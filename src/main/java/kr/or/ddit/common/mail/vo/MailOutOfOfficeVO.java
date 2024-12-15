package kr.or.ddit.common.mail.vo;

import lombok.Data;

@Data
public class MailOutOfOfficeVO {
	private int memNo;
	private String autoTitle;
	private String autoContent;
	private String autoUseYn;
	
	public MailOutOfOfficeVO() {
		
	}
	
	public MailOutOfOfficeVO(int memNo, String autoTitle, String autoContent, String autoUseYn) {
		this.memNo = memNo;
		this.autoTitle = autoTitle;
		this.autoContent = autoContent;
		this.autoUseYn = autoUseYn;
	}
}
