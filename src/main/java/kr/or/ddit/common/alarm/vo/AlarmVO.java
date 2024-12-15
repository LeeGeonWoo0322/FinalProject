package kr.or.ddit.common.alarm.vo;

import java.util.List;

import lombok.Data;

@Data
public class AlarmVO {
	private int alarmNo;
	private String alarmCategory;
	private String alarmTitle;
	private String alarmContent;
	private String regDate;
	private String isRead;
	private String alarmDelYn;
	private int receiverNo;
	private String alarmUrl;
	
	private List<Integer> targetMemNos;
	private String sender;
	
}
