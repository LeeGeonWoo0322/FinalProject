package kr.or.ddit.common.attend.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.mapper.IAttendanceMapper;
import kr.or.ddit.common.attend.service.IAttendanceService;
import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.attend.vo.WorkAtstateVO;

@Service
public class AttendanceServiceImpl implements IAttendanceService {
	
	@Inject
	private IAttendanceMapper attendanceMapper;
	
	@Override
	public int gWork(AttendanceVO attendance) {
		int res = 0;
		AttendanceVO att = attendanceMapper.getAttNo(attendance);
		
		if(att != null) {
			return res;
		} else {
			res = attendanceMapper.gWork(attendance);
			attendanceMapper.changeMemStatus(attendance);
			return res;
		}
	}

	@Override
	public int lWork(AttendanceVO attendance) {
		int res = attendanceMapper.lWork(attendance);
		attendanceMapper.changeMemStatus(attendance);
		
		return res;
	}

	@Override
	public AttendanceVO glWorkTime(AttendanceVO attendance) {
		AttendanceVO res = attendanceMapper.glWorkTime(attendance);
		
		return res;
	}

	@Override
	public AttendanceVO overTimeUpd(AttendanceVO attendance) {
		AttendanceVO res = attendanceMapper.overTimeUpd(attendance);
		
		return res;
	}

	@Override
	public AttendanceVO otPrint(AttendanceVO attendance) {
		AttendanceVO res = attendanceMapper.otPrint(attendance);
		
		return res;
	}

	@Override
	public int updOverTime(AttendanceVO attendance) {
		int res = attendanceMapper.updOverTime(attendance);
		
		return res;
	}

	@Override
	public List<WorkAtstateVO> curMonth(AttendanceVO attendance) {
		List<WorkAtstateVO> res = attendanceMapper.curMonth(attendance);
		
		return res;
	}

	@Override
	public List<AttendanceVO> totalDeptList(AttendanceVO attendance) {
		List<AttendanceVO> res = attendanceMapper.totalDeptList(attendance);
		
		return res;
	}

	@Override
	public int updAttend(AttendanceVO attendance) {
		int res = attendanceMapper.updAttend(attendance);
		
		return res;
	}

	@Override
	public List<MemberVO> deptWeekAttend(AttendanceVO attendance) {
		List<MemberVO> res = attendanceMapper.deptWeekAttend(attendance);

		return res;
	}
}
