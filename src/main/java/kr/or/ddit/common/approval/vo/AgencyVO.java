package kr.or.ddit.common.approval.vo;

import lombok.Data;

@Data
public class AgencyVO {
	private int agencyNo;
	private int granterNo;
	private String startDate;
	private String endDate;
	private String agencyContent;
	
	private String agencyName;
	
}
