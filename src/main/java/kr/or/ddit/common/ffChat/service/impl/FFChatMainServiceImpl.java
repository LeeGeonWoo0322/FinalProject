package kr.or.ddit.common.ffChat.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;

import kr.or.ddit.common.ffChat.mapper.IFFChatMainMapper;
import kr.or.ddit.common.ffChat.service.IFFChatMainService;
import kr.or.ddit.common.ffChat.vo.VideoChatVO;
import kr.or.ddit.common.ffChat.vo.VideochatRoomMemberVO;

@Controller
public class FFChatMainServiceImpl implements IFFChatMainService {
	
	@Inject
	private IFFChatMainMapper ffchatMapper;

	@Override
	public List<VideoChatVO> videoChatList(String memNo) {
		return ffchatMapper.videoChatList(memNo);
	}

	@Override
	public void create(VideoChatVO videoChatVO) {
		ffchatMapper.create(videoChatVO);
	}

	@Override
	public void closeRoom(String id) {
		ffchatMapper.closeRoom(id);
	}

	@Override
	public int isTitleExist(String title) {
		return ffchatMapper.isTitleExist(title);
	}

	@Override
	public void invite(VideochatRoomMemberVO videochatRoomMemberVO) {
		ffchatMapper.invite(videochatRoomMemberVO);
	}

	@Override
	public List<VideoChatVO> videoChatListByName(VideoChatVO listVO) {
		return ffchatMapper.videoChatListByName(listVO);
	}
}
