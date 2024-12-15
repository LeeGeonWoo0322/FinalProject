package kr.or.ddit.common.ffChat.vo;

import lombok.Data;

@Data
public class VidRoom {
	private String roomTitle;
	private String passwd;
	private int maxJoinCount;
	private String endDate;
	private String roomId;
}
