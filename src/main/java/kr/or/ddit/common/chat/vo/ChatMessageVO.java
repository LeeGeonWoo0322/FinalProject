package kr.or.ddit.common.chat.vo;

import lombok.Data;

@Data
public class ChatMessageVO {
	private int msgNo;
	private int rmNo;
	private String msgContent;
	private String regDate;
	private int fileNo;
	private int memNo;
	
	private String memId;
	private String memName;
	private String senderPosName;
	
	private String senderImg;
	private int unreadCount;
}
