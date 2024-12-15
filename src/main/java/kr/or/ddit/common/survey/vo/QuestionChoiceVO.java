package kr.or.ddit.common.survey.vo;

import lombok.Data;

@Data
public class QuestionChoiceVO {
	private int choiceNo;
	private int qNo;
	private String choiceContent;
}
