package kr.or.ddit.common.calendar.vo;

import lombok.Data;

@Data
public class SchdlAttendeeVO {
	private int attendNo;
	private int schdlNo;
	private int memNo;
	
	private String memName;
	private String deptName;
}
