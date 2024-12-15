package kr.or.ddit.common.calendar.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import kr.or.ddit.common.calendar.vo.SchdlAttendeeVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;

public interface IScheduleMapper {
	
	public MemberVO getMemberDetail(String memId);

	public void register(ScheduleVO schedule);

	public List<ScheduleVO> list();

	public ScheduleVO selectOne(int schdlNo);

	public void update(ScheduleVO schedule);
	
	public void deleteAttendees(int schdlNo);

	public void insertAttendee(SchdlAttendeeVO attendee);

	public List<SchdlAttendeeVO> selectAttendees(int schdlNo);
	
	public void delete(int schdlNo);

	public void eventUpdate(ScheduleVO schedule);

	public void modalRegister(ScheduleVO schedule);

	public List<MemberVO> getMemberList(int deptNo);

	public List<ScheduleVO> getMemberNames(MemberVO memNo);

	public List<MemberVO> getMemberNumList(MemberVO member);

	public List<ScheduleVO> getMySchedule(int memNo);

	public List<ScheduleVO> myList(int memNo);

	public List<DepartmentVO> deptList();

	public List<ScheduleVO> groupAddress(int deptNo);

	public void insertMembers(SchdlAttendeeVO memSchedule);

	public List<MemberVO> getAttendNo(int schdlNo);

	public ScheduleVO calendarDetail(ScheduleVO schedule);

	public void attendInsert();

	public List<UseVacationVO> approveList(int memNo);

	public List<ScheduleVO> vacationSchdl(List<Integer> memNos);

	public List<Integer> getMemNos(List<String> memNames);


}
