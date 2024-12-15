package kr.or.ddit.common.attend.service;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.attend.vo.WorkAtstateVO;

public interface IAttendanceService {
	
	public int gWork(AttendanceVO attendance);
	
	public int lWork(AttendanceVO attendance);

	public AttendanceVO glWorkTime(AttendanceVO attendance);

	public AttendanceVO overTimeUpd(AttendanceVO attendance);

	public AttendanceVO otPrint(AttendanceVO attendance);

	public int updOverTime(AttendanceVO attendance);

	public List<WorkAtstateVO> curMonth(AttendanceVO attendance);

	public List<AttendanceVO> totalDeptList(AttendanceVO attendance);

	public int updAttend(AttendanceVO attendance);

	public List<MemberVO> deptWeekAttend(AttendanceVO attendance);
	
}
