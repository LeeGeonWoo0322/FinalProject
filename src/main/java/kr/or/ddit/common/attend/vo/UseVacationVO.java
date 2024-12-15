package kr.or.ddit.common.attend.vo;

import lombok.Data;

@Data
public class UseVacationVO {
	private int useVctNo;
	private int vctTypeNo;
	private int memNo;
	private int useDt;
	private String vctCont;
	private String vctStart;
	private String vctEnd;
	
	private String vctName;
}
