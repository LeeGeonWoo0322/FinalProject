package kr.or.ddit.common.attend.vo;

import lombok.Data;

@Data
public class VacCreateVO {
	private int vacCreateNo;
	private String vacCreateDate;
	private int vacCreateCount;
	private int vctTypeNo;
	private int memNo;
	
	private String vctName;
}
