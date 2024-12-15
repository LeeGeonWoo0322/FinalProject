package kr.or.ddit.common.survey.vo;

import lombok.Data;

@Data
public class SurveyAttendeeVO {
	
	// 설문 대상자들
	private int survNo;		// 설문 번호
	private int memNo;		// 사원 번호
	private String survYn;	// 참여 여부	null

}
