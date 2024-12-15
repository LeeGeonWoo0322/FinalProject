package kr.or.ddit.common.calendar.service;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.calendar.vo.SchdlAttendeeVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;

public interface IScheduleService {
	
	public MemberVO getMemberDetail(String memId);

	public void register(ScheduleVO schedule);	
	
	public ScheduleVO selectOne(int schdlNo);

	public void update(ScheduleVO schedule);
	
	public void delete(int schdlNo);

	public void eventUpdate(ScheduleVO schedule);

	public void modalRegister(ScheduleVO schedule);

	public List<ScheduleVO> list();

	public List<MemberVO> getMemberList(ScheduleVO schedule);

	public List<ScheduleVO> getMemberNames(MemberVO member);

	public List<ScheduleVO> getMySchedule(int memNo);

	public List<ScheduleVO> myList(int memNo);

	public List<DepartmentVO> deptList();

	public List<ScheduleVO> groupAddress(int deptNo);

	public ScheduleVO calendarDetail(ScheduleVO schedule);

	public void attendInsert();

	public List<ScheduleVO> vacationSchdl(List<Integer> memNos);

	public List<Integer> getMemNos(List<String> memNames);



}
