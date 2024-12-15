package kr.or.ddit.common.account.vo;

import lombok.Data;

@Data
public class UpgradeReqVO {
	private int urNo;
	private int reqMemNo;
	private int respMemNo;
	private String reqMemName;
	private String respMemName;
	private Long mailVolume;
	private String reqComent;
	private String reqDate;
	private String respDate;
	private int reqGb;
	private int reqStatus;
	private String respReason;
	private Long totalFileSize;
	
	private String capacityReqStart;
	private String capacityReqEnd;
}
