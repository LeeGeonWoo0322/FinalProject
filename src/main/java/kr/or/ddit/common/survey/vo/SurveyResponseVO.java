package kr.or.ddit.common.survey.vo;

import lombok.Data;

@Data
public class SurveyResponseVO {
	private int respNo;			// 응답번호
	private int qNo;			// 질문번호	
	private int memNo;			// 사원번호(응답인원)		null
	private String respContent;	// 응답내용 
}
