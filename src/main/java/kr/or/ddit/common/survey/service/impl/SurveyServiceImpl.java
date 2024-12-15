package kr.or.ddit.common.survey.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.survey.mapper.ISurveyMapper;
import kr.or.ddit.common.survey.service.ISurveyService;
import kr.or.ddit.common.survey.vo.SurveyAttendeeVO;
import kr.or.ddit.common.survey.vo.SurveyResponseVO;
import kr.or.ddit.common.survey.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements ISurveyService {
	
	@Inject
	private ISurveyMapper surveyMapper;

	@Override
	public List<DepartmentVO> getDepartmentList() {
		return surveyMapper.getDepartmentList();
	}

	@Override
	public List<MemberVO> getMemberList() {
		return surveyMapper.getMemberList();
	}

	@Override
	public List<SurveyVO> getMySurveyList(int memNo) {
		return surveyMapper.getMySurveyList(memNo);
	}

	@Override
	public List<SurveyAttendeeVO> getMyAttendanceList(int memNo) {
		return surveyMapper.getMyAttendanceList(memNo);
	}

	@Override
	public SurveyVO getThisSurvey(int survNo) {
		return surveyMapper.getThisSurvey(survNo);
	}

	@Override
	public SurveyVO getWriterInfo(int writerMemberNo) {
		return surveyMapper.getWriterInfo(writerMemberNo);
	}

	@Override
	public int submitResponse(SurveyResponseVO surveyResponseVO) {
		return surveyMapper.submitResponse(surveyResponseVO);
	}

	@Override
	public void participatedSuevey(SurveyAttendeeVO surveyAttendeeVO) {
		surveyMapper.participatedSuevey(surveyAttendeeVO);
	}

	@Override
	public List<SurveyAttendeeVO> getSurveyAttendee(int mySurveyNo) {
		return surveyMapper.getSurveyAttendee(mySurveyNo);
	}


}
