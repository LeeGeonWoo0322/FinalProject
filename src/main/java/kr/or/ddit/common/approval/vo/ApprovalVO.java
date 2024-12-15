package kr.or.ddit.common.approval.vo;

import lombok.Data;

@Data
public class ApprovalVO {
	private String apprId;
	private int formNo;
	private String apprTitle;
	private String apprContent;
	private String regDate;
	private String apprImport;
	private String apprStatus;
	private String apprTmprDy;
	private String completeDate;
	private int memNo;	// 기안자
	private int fileNo;
	private int secNo;	// posNo 겸 secNo
	
	private String senderName;// 기안자이름
	private int myOrder;	// 내 결재순서
	private int apprOrder;	// 가장 최근 결재를한 결재순서
	private String apprRsn;	// 반려사유
	
	

}
