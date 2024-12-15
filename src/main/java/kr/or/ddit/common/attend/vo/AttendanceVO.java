package kr.or.ddit.common.attend.vo;

import lombok.Data;

@Data
public class AttendanceVO {
	private int attendanceNo;
	private int memNo;
	private String attendanceDate;
	private String inTime;
	private String outTime;
	private String monoverTime;
	private String overtimeTime;
	private String attendanceReason;
	private String movertimeTime;
	private String dateD;
	
	private String deptNo;
	private String deptName;
	private String memName;
}
