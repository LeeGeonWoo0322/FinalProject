package kr.or.ddit.common.chat.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.chat.service.IChatService;
import kr.or.ddit.common.chat.vo.ChatMessageVO;
import kr.or.ddit.common.chat.vo.ChatRoomMemberVO;
import kr.or.ddit.common.chat.vo.ChatRoomVO;
import kr.or.ddit.common.file.service.IFileService;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import kr.or.ddit.common.file.web.FileDownloadView;
import kr.or.ddit.common.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class ChatController {

	@Inject
	private IChatService chatService;
	
	@Inject
	private IFileService fileService;
	
	@Resource(name = "localPath")
	private String localPath;
	
	@GetMapping("/chatHome.do")
	public String chatHome(Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		System.out.println("멤버:"+memberVO);
		model.addAttribute("memberVO", memberVO);
		
		return "chat/chatHome";
	}
	
	// 채팅방 리스트 가져오기 ajax
		@ResponseBody
		@PostMapping("/chatRoomList.do")
		public ResponseEntity<List<ChatRoomVO>> getChatList() {
			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			MemberVO memberVO = customUser.getMember();
			System.out.println("멤버:"+memberVO);
			// 해당 유저가 속해있는 채팅방 가져오기
			List<ChatRoomVO> roomList = chatService.getRoomList(memberVO.getMemNo());
			System.out.println("방 리스트:"+roomList);
			
			return new ResponseEntity<List<ChatRoomVO>>(roomList, HttpStatus.OK);
		}
		
		@ResponseBody
		@PostMapping("/createSingleChatRoom.do")
		public ResponseEntity<String> createSingleChatRoom(@RequestParam("memNo") String memNo) {
		    CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		    MemberVO memberVO = customUser.getMember();
		    int userMemNo = memberVO.getMemNo();
		    int targetMemNo = Integer.parseInt(memNo);
		    Map<String, Integer> paramMap = new HashMap<>();
		    paramMap.put("userMemNo", userMemNo);
		    paramMap.put("targetMemNo", targetMemNo);
		    // 기존 1대1 채팅방이 존재하는지 확인
		    Integer existingRoomNo = chatService.findSingleChatRoom(paramMap);
		    if (existingRoomNo != null) {
		        return new ResponseEntity<>(String.valueOf(existingRoomNo), HttpStatus.OK);
		    }

		    // 채팅방이 존재하지 않으면 새 채팅방 생성
		    ChatRoomVO chatRoomVO = new ChatRoomVO();
		    chatRoomVO.setRmType("일반");
		    chatRoomVO.setMemNo(userMemNo);
		    chatRoomVO.setRmName("채팅");
		    int rmNo = chatService.createSingleChatRoom(chatRoomVO);
		    System.out.println("채팅방번호:"+rmNo);
		    // 채팅방 멤버 등록
		    ChatRoomMemberVO chatRoomMemberVO = new ChatRoomMemberVO();
		    chatRoomMemberVO.setRmNo(rmNo);
		    chatRoomMemberVO.setMemNo(userMemNo);
		    chatService.registerChatMember(chatRoomMemberVO);

		    chatRoomMemberVO.setMemNo(targetMemNo);
		    chatService.registerChatMember(chatRoomMemberVO);

		    return new ResponseEntity<>(rmNo + "", HttpStatus.OK);
		}
		
		@PostMapping("/createGroupChat")
		public ResponseEntity<String> createGroupChat(@RequestBody Map<String, Object> map) {
				CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			    MemberVO memberVO = customUser.getMember();
			    int userMemNo = memberVO.getMemNo();
			    
				String chatRoomName = (String) map.get("chatRoomName");
				String selectedMembersString = (String) map.get("members");
	            System.out.println("채팅방이름:"+chatRoomName);
	            ChatRoomVO chatRoomVO = new ChatRoomVO();
	            chatRoomVO.setRmName(chatRoomName);
	            chatRoomVO.setRmType("그룹");
	            chatRoomVO.setMemNo(userMemNo);
	            int rmNo = chatService.createSingleChatRoom(chatRoomVO);
			    System.out.println("채팅방번호:"+rmNo);
			    // 채팅방 멤버 등록
			    ChatRoomMemberVO chatRoomMemberVO = new ChatRoomMemberVO();
			    chatRoomMemberVO.setRmNo(rmNo);
			    chatRoomMemberVO.setMemNo(userMemNo);
			    chatService.registerChatMember(chatRoomMemberVO);
			    String[] selectedMembersArray = selectedMembersString.split(",");

			    // 채팅방 멤버 등록
			    for (String memberNoStr : selectedMembersArray) {
			        int memNo = Integer.parseInt(memberNoStr.trim());
			        chatRoomMemberVO.setMemNo(memNo);
			        // 채팅방 멤버 등록 메서드 호출
			        chatService.registerChatMember(chatRoomMemberVO);
			    }
			    return new ResponseEntity<>(rmNo + "", HttpStatus.OK);
	    }
		
		// 채팅방 포함 직원 가져오기
		@ResponseBody
		@GetMapping("/chatRoomMemberList/{rmNo}")
		public ResponseEntity<List<MemberVO>> getChatRoomMemberList(@PathVariable("rmNo") int rmNo) {
			List<MemberVO> memberList = chatService.getChatRoomMemberList(rmNo);
			System.out.println("채팅방 직원 리스트:"+memberList);
			
			return new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
		}
		
		// 채팅 메시지 가져오기 및 LAST_READ 업데이트
	    @ResponseBody
	    @GetMapping("/chatList/{rmNo}")
	    public ResponseEntity<List<ChatMessageVO>> getChatList(@PathVariable("rmNo") int rmNo) {
	        CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	        MemberVO memberVO = customUser.getMember();
	        int memNo = memberVO.getMemNo();
	        
	        ChatRoomMemberVO chatRoomMemberVO = new ChatRoomMemberVO();
	        chatRoomMemberVO.setRmNo(rmNo);
	        chatRoomMemberVO.setMemNo(memNo);
	        // LAST_READ 업데이트
	        chatService.updateLastRead(chatRoomMemberVO);

	        // 채팅 메시지 가져오기
	        List<ChatMessageVO> chatList = chatService.getChatList(rmNo);
	        System.out.println("채팅:" + chatList);
	        log.info("채팅"+chatList);

	        return new ResponseEntity<>(chatList, HttpStatus.OK);
	    }
		
		@PostMapping(value = "/uploadAjax", produces = "text/plain; charset=utf-8")
		public ResponseEntity<String> uploadAjax(@ModelAttribute FilesVO filesVO) throws Exception {
		    String fileCategory = filesVO.getFileCategory();
		    int memNo = filesVO.getMemNo();
		    System.out.println("카테고리: " + fileCategory + ", 회원번호: " + memNo);

		    int fileNo = fileService.saveAttachFile(filesVO);

		    return ResponseEntity.ok(String.valueOf(fileNo));
		}
		
		// 파일 다운로드 요청 처리
		@GetMapping("/downloadFile.do")
		public View fileDownload(int fileDetailNo, ModelMap model) {
		    FilesDetailVO fileDetailVO = fileService.getFileDetail(fileDetailNo); // FileDetailVO를 가져오는 메소드

		    Map<String, Object> fileDetailMap = new HashMap<>();
		    fileDetailMap.put("fileName", fileDetailVO.getFileOriginalname());
		    fileDetailMap.put("fileSize", fileDetailVO.getFileSize());
		    fileDetailMap.put("fileSavePath", localPath+fileDetailVO.getFilePath()); // 파일 경로
		    model.addAttribute("fileDetailMap", fileDetailMap);
		    
		    return new FileDownloadView(); // 수정된 View 클래스 사용
		}
		
		// 파일 세부정보를 가져오는 메소드
	    @PostMapping("/getFileDetails/{fileNo}")
	    @ResponseBody
	    public ResponseEntity<List<FilesDetailVO>> getFileDetails(@PathVariable("fileNo") int fileNo) {
	        List<FilesDetailVO> fileDetailList = fileService.getFileDetailList(fileNo); // 서비스 메소드 호출

	        if (fileDetailList != null) {
	        	System.out.println("파일리스트:"+fileDetailList);
	            return ResponseEntity.ok(fileDetailList); // 파일 세부정보 반환
	        } else {
	            return ResponseEntity.notFound().build(); // 파일 세부정보가 없을 경우 404 반환
	        }
	    }


		
		@GetMapping("/displayFile")
		public ResponseEntity<byte[]> displayFile(int fileDetailNo){
			InputStream in = null;
			ResponseEntity<byte[]> entity = null;
			
			FilesDetailVO filesDetailVO = fileService.getFileDetail(fileDetailNo);
			String fileName= filesDetailVO.getFilePath();
			log.info("# fileName : "+fileName);
			
			try {
				String formatName=fileName.substring(fileName.lastIndexOf(".")+1);		// 확장자 추출
				// 파일 확장자에 알맞는 MediaType 가져오기
				MediaType mType = getMediaType(formatName);
				System.out.println("mType: "+mType);
				HttpHeaders headers = new HttpHeaders();
				
				in = new FileInputStream(localPath+File.separator+fileName);
				if(mType!= null) {
					headers.setContentType(mType);
				}
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}finally {
				if(in!=null) {
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			return entity;
		}
		
		private MediaType getMediaType(String formatName) {
			if(formatName!=null) {
				if(formatName.toUpperCase().equals("JPG")) {
					return MediaType.IMAGE_JPEG;
				}
				if(formatName.toUpperCase().equals("GIF")) {
					return MediaType.IMAGE_GIF;
				}
				if(formatName.toUpperCase().equals("PNG")) {
					return MediaType.IMAGE_PNG;
				}
			}
			return null;
		}
}
