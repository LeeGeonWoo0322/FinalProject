package kr.or.ddit.common.reservation.vo;

import lombok.Data;

@Data
public class ReservationAttendeeVO {
	private int raNo;
	private int resvNo;
	private int memNo;
	private String memName;
	private String posName;
	private String deptName;
}
