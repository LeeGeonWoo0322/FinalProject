package kr.or.ddit.common.account.vo;

import lombok.Data;

@Data
public class LogVO {
	private int logNo;
	private String ip;
	private int memNo;
	private String memName;
	private String memEmail;
	private String deptName;
	private String createDate;
	private String logStatus;
	private String logType;
	private String logBrowser;
	private String logOs;
	
	private String startDate;
	private String endDate;
	
	public LogVO() {
		
	}
	
	public LogVO(String ip, int memNo, String logStatus, String logType, String logBrowser, String logOs) {
		this.ip = ip;
		this.memNo = memNo;
		this.logStatus = logStatus;
		this.logType = logType;
		this.logBrowser = logBrowser;
		this.logOs = logOs;
	}
}
