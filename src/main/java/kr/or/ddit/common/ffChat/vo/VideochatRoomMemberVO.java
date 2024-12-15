package kr.or.ddit.common.ffChat.vo;

import lombok.Data;

@Data
public class VideochatRoomMemberVO {
	private String roomId;
	private int memNo;	
	private String memName;
	private String deptName;
	private String posName;
	
	public VideochatRoomMemberVO() {
		
	}
	
	public VideochatRoomMemberVO(String roomTitle, int memNo) {
		this.roomId = roomTitle;
		this.memNo = memNo;
	}

}
