package kr.or.ddit.common.mail.vo;

import lombok.Data;

@Data
public class MailTagVO {
	private int mailTagNo;
	private int memNo;
	private int recNo;
	private String mailTagName;
	private String mailTagColor;
	
	public MailTagVO(){
		
	}
	
	// addTagList
	public MailTagVO(String tagName, String tagColor, int memNo) {
		this.mailTagName = tagName;
		this.mailTagColor = tagColor;
		this.memNo = memNo;
	}
	
	// deleteTagList
	public MailTagVO(int mailTagNo, String tagName, String tagColor) {
		this.mailTagNo = mailTagNo;
		this.mailTagName = tagName;
		this.mailTagColor = tagColor;
	}
	
	// deleteTagList
	public MailTagVO(int mailTagNo) {
		this.mailTagNo = mailTagNo;
	}
	
}
