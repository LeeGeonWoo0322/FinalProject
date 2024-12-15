package kr.or.ddit.common.mail.vo;

import java.util.List;

import lombok.Data;

@Data
public class MailRecipientVO {
	// 수신자 정보
	private int recNo;
	private int recipientNo;
	private String recipientName;
	private String recipientEmail;
	private String recipientDeptName;
	private String recipientPosName;
	private String recType;
	private String recStatus;
	private String recTime;
	private String readYn;
	private String recFavYn;
	// 메일 정보
	private int mailNo;
	private int keyword;
	private int mailRowNo;
	private int mailboxNo;
	private String mailTitle;
	private String mailContent;
	private String mailDate;
	private String mailStatus;
	private int fileNo;
	private String mailImp;
	private String mailRes;
	private String mailFavYn;
	private String mailReadYn;
	private String mailGb;
	private String mailResDate;
	private String mailResTime;
	private String mailDelYn;
	private String mailSecurityYn;
	// 발신자 정보
	private int memNo;
	private String memName;
	private String memEmail;
	private int posNo;
	private String posName;
	private int secNo;
	private int deptNo;
	private String deptName;
	private String conDelYn;
	
	public MailRecipientVO(){
		
	}
	
	public MailRecipientVO(int mailNo, int recipientNo) {
		this.mailNo = mailNo;
		this.recipientNo = recipientNo;
	}
	
	public MailRecipientVO(int memNo, int mailRowNo, int keyword) {
		this.memNo = memNo;
		this.mailRowNo = mailRowNo;
		this.keyword = keyword;
	}
}
