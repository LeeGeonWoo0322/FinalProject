package kr.or.ddit.common.ffChat.service;

import java.util.List;

import kr.or.ddit.common.ffChat.vo.VideoChatVO;
import kr.or.ddit.common.ffChat.vo.VideochatRoomMemberVO;

public interface IFFChatMainService {

	public List<VideoChatVO> videoChatList(String memNo);

	public void create(VideoChatVO videoChatVO);

	public void closeRoom(String id);

	public int isTitleExist(String title);

	public void invite(VideochatRoomMemberVO videochatRoomMemberVO);

	public List<VideoChatVO> videoChatListByName(VideoChatVO listVO);

}
