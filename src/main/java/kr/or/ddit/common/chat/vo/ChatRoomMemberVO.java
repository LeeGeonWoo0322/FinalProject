package kr.or.ddit.common.chat.vo;

import lombok.Data;

@Data
public class ChatRoomMemberVO {
	private int rmNo;
	private int memNo;
	private String alarmYn;
	private int lastRead;
}
