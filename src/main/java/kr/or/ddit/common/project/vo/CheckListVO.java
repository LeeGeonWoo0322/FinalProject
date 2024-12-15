package kr.or.ddit.common.project.vo;

import java.util.List;

import lombok.Data;

@Data
public class CheckListVO {
	
	private int clNo;
	private int workNo;
	private String clName;
	private String checkYn;
	private String checkDate;
	private int memNo;
	
	List<String>  checkYnList;
	List<String>  clNameLsit;
	
	
	// 수정에 필요한 리스트
	List<String> modClNameList;
	List<Integer> modCheckNoList;
	List<String> modCheckDateList;
	List<Integer> modCheckMemList;
	List<String> modNewList;
	List<String> modCheckYnList;
}
  