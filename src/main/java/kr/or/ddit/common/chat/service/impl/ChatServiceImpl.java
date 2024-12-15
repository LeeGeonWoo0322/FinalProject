package kr.or.ddit.common.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.chat.mapper.IChatMapper;
import kr.or.ddit.common.chat.service.IChatService;
import kr.or.ddit.common.chat.vo.ChatMessageVO;
import kr.or.ddit.common.chat.vo.ChatRoomMemberVO;
import kr.or.ddit.common.chat.vo.ChatRoomVO;

@Service
public class ChatServiceImpl implements IChatService {
	@Inject
	private IChatMapper chatMapper;

	@Override
	public List<ChatRoomVO> getRoomList(int memNo) {
	    List<ChatRoomVO> roomList = chatMapper.getRoomList(memNo);
	    
	    for (ChatRoomVO room : roomList) {
	        if ("일반".equals(room.getRmType())) {
	            ChatRoomMemberVO chatRoomMemberVO = new ChatRoomMemberVO();
	            chatRoomMemberVO.setMemNo(memNo);
	            chatRoomMemberVO.setRmNo(room.getRmNo());

	            // 상대방의 정보를 ChatRoomMemberVO로 받아오기
	            MemberVO otherMember = chatMapper.getOtherMemberName(chatRoomMemberVO);
	            
	            // 상대방의 이름을 설정
	            room.setRmName(otherMember.getMemName());
	            // 상대방의 프로필 이미지를 설정
	            room.setRmImg(otherMember.getMemProfileimg());
	        }
	    }
	    
	    return roomList;
	}

	@Override
	public List<ChatMessageVO> getChatList(int rmNo) {
		return chatMapper.getChatList(rmNo);
	}

	@Override
	public void saveChatMessage(ChatMessageVO chatMessage) {
		chatMapper.saveChatMessage(chatMessage);
	}

	@Override
	public MemberVO getMember(String memId) {
		return chatMapper.getMember(memId);
	}

	@Override
	public void updateLastRead(ChatRoomMemberVO chatRoomMemberVO) {
		chatMapper.updateLastRead(chatRoomMemberVO);
	}

	@Override
	public List<MemberVO> getChatRoomMemberList(int rmNo) {
		return chatMapper.getChatRoomMemberList(rmNo);
	}

	@Override
	public int createSingleChatRoom(ChatRoomVO chatRoomVO) {
		chatMapper.createSingleChatRoom(chatRoomVO);
		int rmNo=chatRoomVO.getRmNo();
		return rmNo;
	}

	@Override
	public void registerChatMember(ChatRoomMemberVO chatRoomMemberVO) {
		chatMapper.registerChatMember(chatRoomMemberVO);
	}

	@Override
	public Integer findSingleChatRoom(Map<String, Integer> paramMap) {
	    return chatMapper.findSingleChatRoom(paramMap);
	}

	@Override
	public ChatRoomVO getRoom(int rmNo) {
		return chatMapper.getRoom(rmNo);
	}
}
