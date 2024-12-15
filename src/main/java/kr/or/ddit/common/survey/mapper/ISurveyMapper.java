package kr.or.ddit.common.survey.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.survey.vo.SurveyAttendeeVO;
import kr.or.ddit.common.survey.vo.SurveyResponseVO;
import kr.or.ddit.common.survey.vo.SurveyVO;

public interface ISurveyMapper {

	List<DepartmentVO> getDepartmentList();
	List<MemberVO> getMemberList();
	List<SurveyVO> getMySurveyList(int memNo);
	List<SurveyAttendeeVO> getMyAttendanceList(int memNo);
	SurveyVO getThisSurvey(int survNo);
	SurveyVO getWriterInfo(int writerMemberNo);
	int submitResponse(SurveyResponseVO surveyResponseVO);
	void participatedSuevey(SurveyAttendeeVO surveyAttendeeVO);
	List<SurveyAttendeeVO> getSurveyAttendee(int mySurveyNo);

}
