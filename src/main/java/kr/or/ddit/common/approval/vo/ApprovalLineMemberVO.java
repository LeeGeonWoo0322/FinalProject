package kr.or.ddit.common.approval.vo;

import lombok.Data;

@Data
public class ApprovalLineMemberVO {
	private String apprId;
	private int apprOrder;
	private String apprRole;
	private int memNo;
	private String apprYn;
	private String apprTime;
	private String apprRsn;
	
	private String memName;
	private String posName;
	private String deptName;
	
	private int agencyNo;
	private String agencyName;
}
