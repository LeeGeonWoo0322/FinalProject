package kr.or.ddit.common.chat.web;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;
import kr.or.ddit.common.chat.service.IChatService;
import kr.or.ddit.common.chat.vo.ChatMessageVO;
import kr.or.ddit.common.chat.vo.ChatRoomMemberVO;
import kr.or.ddit.common.chat.vo.ChatRoomVO;
import kr.or.ddit.common.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatHandler extends TextWebSocketHandler {
	private static Map<String, List<WebSocketSession>> sessions = new ConcurrentHashMap<>();

	@Inject
	private IChatService chatService;
	
	@Inject
	private IAlarmService alarmService;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) {
	    String rmNo = getRmNoFromSession(session);
	    log.info("누군가 접속: rmNo = " + rmNo);

	    // 세션 추가
	    sessions.computeIfAbsent(rmNo, key -> new ArrayList<>()).add(session);
	    log.info("## 현재 세션 수: " + sessions.get(rmNo).size());

	    // 새로운 연결 알림 JSON 생성
	    ObjectMapper mapper = new ObjectMapper();
	    Map<String, Object> messageData = new HashMap<>();
	    messageData.put("type", "newConnection");
	    messageData.put("rmNo", rmNo);
	    messageData.put("message", "새로운 직원 입장");

	    String messageJson = "";
	    try {
	        messageJson = mapper.writeValueAsString(messageData);
	    } catch (JsonProcessingException e) {
	        log.error("메시지 변환 에러: ", e);
	    }

	    // 방의 모든 세션에 새 연결 메시지 전송
	    List<WebSocketSession> roomSessions = sessions.get(rmNo);
	    if (roomSessions != null) {
	        for (WebSocketSession webSocketSession : roomSessions) {
	            try {
	                webSocketSession.sendMessage(new TextMessage(messageJson));
	            } catch (IOException e) {
	                log.error("메시지 전송 에러: ", e);
	            }
	        }
	    }
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws IOException {
	    String payload = message.getPayload();
	    String rmNo = getRmNoFromSession(session);
	    log.info("## 받은 메시지: " + payload + " (rmNo: " + rmNo + ")");
	    Principal principal = session.getPrincipal();
	    System.out.println("방법1: " + principal.getName());
	    
	    // 현재 유저 정보 가져오기
	    MemberVO memberVO = chatService.getMember(principal.getName());
	    
	    // 메시지를 DB에 저장
	    ChatMessageVO chatMessage = new ChatMessageVO();
	    chatMessage.setMsgContent(payload); // 메시지 내용
	    chatMessage.setRmNo(Integer.parseInt(rmNo)); // 방 번호
	    chatMessage.setMemNo(memberVO.getMemNo()); // 사용자 ID
	    chatMessage.setMemName(memberVO.getMemName()); // 사용자 이름
	    chatMessage.setSenderImg(memberVO.getMemProfileimg()); // 사용자 프로필 이미지
	    chatMessage.setRegDate(LocalDateTime.now().toString()); // 메시지 전송 시간

	    // 파일 번호 추출
	    ObjectMapper mapper = new ObjectMapper();
	    try {
	        // JSON 파싱하여 fileNo 추출
	        Map<String, Object> messageData = mapper.readValue(payload, new TypeReference<Map<String, Object>>() {});
	        if (messageData.containsKey("fileNo")) {
	            Integer fileNo = Integer.parseInt(messageData.get("fileNo").toString());
	            System.out.println("디비에 넣을 fileNo: " + fileNo);
	            chatMessage.setFileNo(fileNo); // fileNo 설정
	        }
	    } catch (JsonProcessingException e) {
	        log.error("메시지 변환 에러: ", e);
	    }

	    // 메시지를 DB에 저장
	    chatService.saveChatMessage(chatMessage); // DB에 메시지 저장
	    
	    // LAST_READ 업데이트
	    ChatRoomMemberVO chatRoomMemberVO = new ChatRoomMemberVO();
	    chatRoomMemberVO.setRmNo(Integer.parseInt(rmNo));
	    chatRoomMemberVO.setMemNo(memberVO.getMemNo());
	    chatService.updateLastRead(chatRoomMemberVO); // LAST_READ 업데이트 호출

	    // JSON 형식으로 변환
	    String chatMessageJson = "";
	    try {
	        chatMessageJson = mapper.writeValueAsString(chatMessage);
	    } catch (JsonProcessingException e) {
	        log.error("메시지 변환 에러: ", e);
	    }
	    
	    System.out.println("json형태: " + chatMessageJson);
	    // rmNo에 해당하는 모든 세션에 메시지 전달
	    List<WebSocketSession> roomSessions = sessions.get(rmNo);
	    if (roomSessions != null) {
	        System.out.println("roomSessions size: " + roomSessions.size());
	        for (WebSocketSession webSocketSession : roomSessions) {
	            System.out.println("세션 ID: " + webSocketSession.getId() + ", isOpen: " + webSocketSession.isOpen());
	            System.out.println("session.getId(): " + session.getId());
	            try {
	                System.out.println("전송할 메시지: " + chatMessageJson);
	                webSocketSession.sendMessage(new TextMessage(chatMessageJson)); // JSON으로 전송
	                System.out.println("메시지 전송 성공: " + chatMessageJson);
	                
	                // 알림 생성
	                List<MemberVO> memList = chatService.getChatRoomMemberList(Integer.parseInt(rmNo));
	                List<AlarmVO> alarmList = new ArrayList<AlarmVO>();
	                AlarmBanVO alarmBanVO = new AlarmBanVO();
	                alarmBanVO.setTechCategory("chatOp");
	                
	                try {
	                    Map<String, Object> chatData = mapper.readValue(chatMessageJson, new TypeReference<Map<String, Object>>() {});
	                    
	                    // 알림에 필요한 정보 추출
	                    String msgContent = (String) chatData.get("msgContent"); // 메시지 내용
	                    String senderName = (String) chatData.get("memName"); // 보낸 사람 이름
	                    System.out.println("추출한 메시지내용: " + msgContent);
	                    ChatRoomVO chatRoomVO = chatService.getRoom(Integer.parseInt(rmNo));
	                    String rmName = chatRoomVO.getRmName();
	                    if (rmName == null) {
	                        rmName = senderName;
	                    }

	                    // 각 멤버마다 새로운 AlarmVO 객체 생성
	                    for (MemberVO member : memList) {
	                        alarmBanVO.setMemNo(member.getMemNo());
	                        
	                        int cnt = alarmService.chkBanAlarm(alarmBanVO);
	                        System.out.println("거부cnt: " + cnt);
	                        
	                        if (cnt > 0 || memberVO.getMemNo() == member.getMemNo()) {
	                            continue;
	                        }

	                        // 각 멤버마다 새로운 AlarmVO 객체 생성
	                        AlarmVO individualAlarmVO = new AlarmVO();
	                        individualAlarmVO.setAlarmNo(Integer.parseInt(rmNo));
	                        individualAlarmVO.setAlarmContent(msgContent);
	                        individualAlarmVO.setAlarmTitle(rmName);
	                        individualAlarmVO.setAlarmUrl(senderName);
	                        individualAlarmVO.setAlarmCategory("chatOp");
	                        individualAlarmVO.setReceiverNo(member.getMemNo());
	                        
	                        alarmList.add(individualAlarmVO);
	                    }
	                    if (alarmList.size() > 0) {
	                        alarmService.sendNotificationToUsers(alarmList);
	                    }
	                    
	                } catch (JsonProcessingException e) {
	                    log.error("알림 정보 추출 에러: ", e);
	                }
	                
	            } catch (Exception e) {
	                log.error("메시지 전송 에러: ", e);
	            }
	        }
	    }
	}



	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
		String rmNo = getRmNoFromSession(session);
		log.info("## 누군가 떠남: rmNo = " + rmNo);

		List<WebSocketSession> roomSessions = sessions.get(rmNo);
		if (roomSessions != null) {
			roomSessions.remove(session);
			if (roomSessions.isEmpty()) {
				sessions.remove(rmNo);
			}
			log.info("## 남은 세션 수: " + (roomSessions.isEmpty() ? "0" : roomSessions.size()));
		}
	}

	private String getRmNoFromSession(WebSocketSession session) {
		String uri = session.getUri().toString();
		String[] uriParts = uri.split("/");
		if (uriParts.length > 4) {
			System.out.println("------방번호 추출=----" + uriParts[4]);
			return uriParts[4];
		}
		return "";
	}
}
