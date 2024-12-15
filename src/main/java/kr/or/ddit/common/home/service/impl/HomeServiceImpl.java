package kr.or.ddit.common.home.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;
import kr.or.ddit.common.home.mapper.IHomeMapper;
import kr.or.ddit.common.home.service.IHomeService;

@Service
public class HomeServiceImpl implements IHomeService{

	@Inject
	private IHomeMapper homeMapper;

	@Override
	public List<ScheduleVO> getMyScheduleList(MemberVO member) {
		return homeMapper.getMyScheduleList(member);
	}

	@Override
	public List<ScheduleVO> getScheduleList(ScheduleVO scheduleVO) {
		return homeMapper.getScheduleList(scheduleVO);
	}
	
}
