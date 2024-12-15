package kr.or.ddit.common.survey.service;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.survey.vo.SurveyAttendeeVO;
import kr.or.ddit.common.survey.vo.SurveyResponseVO;
import kr.or.ddit.common.survey.vo.SurveyVO;

public interface ISurveyService {

	public List<DepartmentVO> getDepartmentList();						// 부서 정보 가져오기
	public List<MemberVO> getMemberList();								// 모든 멤버 리스트
	public List<SurveyVO> getMySurveyList(int memNo);					// 내가 포함된 설문들
	public List<SurveyAttendeeVO> getMyAttendanceList(int memNo);		// 내 참여여부 가져오기
	public SurveyVO getThisSurvey(int survNo);							// 클릭한 설문의 세부정보 - board detail 같은 것
	public SurveyVO getWriterInfo(int writerMemberNo);					// 작성자 정보
	public int submitResponse(SurveyResponseVO surveyResponseVO);		// 응답 제출(등록)하기
	public void participatedSuevey(SurveyAttendeeVO surveyAttendeeVO);	// 설문 참여여부 Y로 바꾸기
	public List<SurveyAttendeeVO> getSurveyAttendee(int mySurveyNo);	// 특정 설문의 모든 Attendee 가져오기

}
