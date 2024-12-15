package kr.or.ddit.common.home.service;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;

public interface IHomeService {

	List<ScheduleVO> getMyScheduleList(MemberVO member);

	List<ScheduleVO> getScheduleList(ScheduleVO scheduleVO);

}
