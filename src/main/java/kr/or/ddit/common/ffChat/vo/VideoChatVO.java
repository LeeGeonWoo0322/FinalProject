package kr.or.ddit.common.ffChat.vo;

import java.util.List;

import lombok.Data;

@Data
public class VideoChatVO {
	private String roomTitle;
	private String roomPasswd;
	private String roomUrlId;
	private String roomOpen;
	private String memName;
	private String posName;
	private String deptName;
	
	private List<VideochatRoomMemberVO> memList;
	
	
	public VideoChatVO() {
		
	}

	/**
	 * 방을 만들 때 사용한다.
	 * @param roomTitle		방 생성시 입력 받음
	 * @param passwd		방 생성시 입력 받음
	 * @param roomUrlId		방 생성 후 응답으로 받음
	 */
	public VideoChatVO(String roomTitle, String passwd, String roomUrlId) {
		this.roomTitle = roomTitle;
		this.roomPasswd = passwd;
		this.roomUrlId = roomUrlId;
		this.roomOpen = "Y";
	}

}
