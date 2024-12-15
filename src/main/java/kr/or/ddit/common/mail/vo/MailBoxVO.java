package kr.or.ddit.common.mail.vo;

import lombok.Data;

@Data
public class MailBoxVO {
	private int mailboxNo;
	private int mailboxRowNo; 
	private int memNo;
	private String mailboxName;
	
	public MailBoxVO() {
		
	}
	
	public MailBoxVO(int memNo, String mailboxName) {
		this.memNo = memNo;
		this.mailboxName = mailboxName;
	}
	
	public MailBoxVO(int memNo, int mailboxNo) {
		this.memNo = memNo;
		this.mailboxNo = mailboxNo;
	}
}
