package kr.or.ddit.common.approval.vo;

import lombok.Data;

@Data
public class ApprovalFormVO {
	private int formNo;
	private String formTitle;
	private String formContent;
	private String formCategory;
	private String regDate;
	private String delYn;
	
    private int usageCount; // 양식 사용 횟수
    private int ongoingCount; // 진행 중인 결재 수
    private int completedCount; // 완료된 결재 수
    private int rejectedCount; // 반려된 결재 수
}
