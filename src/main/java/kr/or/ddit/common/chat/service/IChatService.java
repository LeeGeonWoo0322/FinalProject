package kr.or.ddit.common.chat.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.chat.vo.ChatMessageVO;
import kr.or.ddit.common.chat.vo.ChatRoomMemberVO;
import kr.or.ddit.common.chat.vo.ChatRoomVO;

public interface IChatService {

	public List<ChatRoomVO> getRoomList(int memNo);

	public List<ChatMessageVO> getChatList(int rmNo);

	public void saveChatMessage(ChatMessageVO chatMessage);

	public MemberVO getMember(String memId);

	public void updateLastRead(ChatRoomMemberVO chatRoomMemberVO);

	public List<MemberVO> getChatRoomMemberList(int rmNo);

	public int createSingleChatRoom(ChatRoomVO chatRoomVO);

	public void registerChatMember(ChatRoomMemberVO chatRoomMemberVO);

	public Integer findSingleChatRoom(Map<String, Integer> paramMap);

	public ChatRoomVO getRoom(int rmNo);


}
