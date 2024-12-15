package kr.or.ddit.common.mail.vo;

import lombok.Data;

@Data
public class MailBlockWordVO {
	private String bwNo;
	private int memNo;
	private String blockWord;
	
	public MailBlockWordVO() {
		
	}
	
	public MailBlockWordVO(int memNo, String blockWord) {
		this.memNo = memNo;
		this.blockWord = blockWord;
	}
	
}
