package kr.or.ddit.common.survey.vo;

import java.util.List;

import lombok.Data;

@Data
public class SurveyVO {
	
	private int survNo;			// 설문번호			
	private int memNo;			// 작성자				null
	private String survTitle;	// 설문 제목
	private String survIntro;	// 설문 개요(설명)		null
	private String startDate;	// 설문 시작 날짜(시간)	null
	private String endDate;		// 설문 종료 날짜(시간)	null
	private String publicYn;	// 결과 공개 여부
	private String importYn;	// 중요 여부			
	private String updateYn;	// 수정 여부			null
	
	private String memName;		// 작성자 명
	private String posName;		// 작성자 직급
	private String deptName;	// 작성자 부서명
	
	private List<SurveyAttendeeVO> surveyAttendee;
	private List<SurveyQuestionVO> surveyQuestion;
}
