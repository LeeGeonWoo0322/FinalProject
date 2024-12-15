package kr.or.ddit.common.reservation.vo;

import lombok.Data;

@Data
public class ReservationVO {
	
	private int resvNo;
	private int astNo;
	private int resvMember;
	private String memName;
	private String posName;
	private String deptName;
	private String startDate;
	private String endDate;
	private String alldayYn;
	private String repeatYn;
	private String resvPrps;
	private String acName;
	private String astName;
}
