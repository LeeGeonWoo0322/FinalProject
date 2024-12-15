package kr.or.ddit.common.survey.vo;

import java.util.List;

import lombok.Data;

@Data
public class SurveyQuestionVO {
	
	private int qNo;				// 질문 번호
	private int survNo;				// 설문 번호
	private String qContent;		// 질문
	private String qType;			// 질문 유형 - 선택형, 단문응답형 등등
	private String singleOrMulti;	// 단일 / 복수 여부 - 단일선택인지 복수선택인지	null
	
	private List<SurveyResponseVO> surveyResponse; 
	private List<QuestionChoiceVO> surveyChoice;
}
