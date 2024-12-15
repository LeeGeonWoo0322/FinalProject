package kr.or.ddit.common.project.vo;

import lombok.Data;

@Data
public class ChartVO {
	
	private String memName;
	private String posName;
	private int projectNo;
	private int memNo;
	private int waitWorkCount;
	private int chartWorkWite;
	private int ingWork;
	private int endWork;
	private int unfinishedWork;
	private int finishedWork;
	private int memPassWork;
	private int memNowWork;
	private int checkCount;
	private int NcheckCount;
	private int nowIngWork;
	private int workCount;
	private int countMem;
}
