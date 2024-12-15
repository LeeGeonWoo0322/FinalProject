package kr.or.ddit.common.mail.vo;

import lombok.Data;

@Data
public class RecipientTagVO {
	private int recNo;
	private int mailTagNo;
	
	public RecipientTagVO() {
		
	}
	
	public RecipientTagVO(int recNo, int mailTagNo) {
		this.recNo = recNo;
		this.mailTagNo = mailTagNo;
	}
	
}
