package kr.or.ddit.common.chat.vo;

import lombok.Data;

@Data
public class ChatRoomVO {
	private int rmNo;
	private int memNo;
	private String rmName;
	private String rmImg;
	private String regDate;
	private String rmType;
	
	private String chatDate;	// 가장 마지막 채팅 날짜
	private String chatMsg;		// 가장 마지막 채팅 메시지
	private int roomPeople;		// 채팅방 참여인원
	private int unreadCount; 	// 안 읽은 메시지 개수
}