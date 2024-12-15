package kr.or.ddit.common.attend.vo;

import lombok.Data;

@Data
public class WorkTypeVO {
	private int wtNo;
	private String wtName;
	private String inDate;
	private String outDate;
	private String lunchStartTime;
	private String launchEndTime;
	private int maxWorkTime;
	private int minWorkTime;
}
