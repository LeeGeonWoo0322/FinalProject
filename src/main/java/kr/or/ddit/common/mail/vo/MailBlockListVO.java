package kr.or.ddit.common.mail.vo;

import lombok.Data;

@Data
public class MailBlockListVO {
	private int blNo;
	private int memNo;
	private int blockedMemNo;
	private String blockedMemEmail;
	
	public MailBlockListVO() {
		
	}
	
	public MailBlockListVO(int memNo, int blockedMemNo) {
		this.memNo = memNo;
		this.blockedMemNo = blockedMemNo;
	}
}
