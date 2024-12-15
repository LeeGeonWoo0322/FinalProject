package kr.or.ddit.common.calendar.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import kr.or.ddit.common.calendar.mapper.IScheduleMapper;
import kr.or.ddit.common.calendar.service.IScheduleService;
import kr.or.ddit.common.calendar.vo.SchdlAttendeeVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScheduleServiceImpl implements IScheduleService{

	@Inject
	private IScheduleMapper mapper;
	

	@Override
	public MemberVO getMemberDetail(String memId) {
		return mapper.getMemberDetail(memId);
	}
	
	@Override
	public void register(ScheduleVO schedule) {
		mapper.register(schedule);
		int schdlNo = schedule.getSchdlNo();
		for (MemberVO member : schedule.getMemNos()) {
			SchdlAttendeeVO memSchedule = new SchdlAttendeeVO();
			memSchedule.setSchdlNo(schdlNo);				// 방금 생성된 schdlNo
            memSchedule.setMemNo(member.getMemNo());        // 리스트에서 가져온 memNo
            mapper.insertMembers(memSchedule);				// 관련 member insert
		}
	}

	@Override
	public List<ScheduleVO> list() {
		return mapper.list();
	}

	@Override
	public ScheduleVO selectOne(int schdlNo) {
		return mapper.selectOne(schdlNo);
	}

	@Override
	public void update(ScheduleVO schedule) {
		mapper.update(schedule);
		
//		mapper.deleteAttendees(schedule.getSchdlNo());  // 기존 참석자 삭제
		
		for (SchdlAttendeeVO attendee : schedule.getSchdlAttendeeVO()) {
	        attendee.setSchdlNo(schedule.getSchdlNo());  // 스케줄 번호 설정
	        mapper.insertAttendee(attendee);  // 참석자 추가
	    }
		
		List<SchdlAttendeeVO> updatedAttendees = mapper.selectAttendees(schedule.getSchdlNo());
	    schedule.setSchdlAttendeeVO(updatedAttendees); // 최신 정보로 갱신
	}

	@Override
	public void delete(int schdlNo) {
		mapper.deleteAttendees(schdlNo);  // 기존 참석자 삭제
		mapper.delete(schdlNo);
	}

	@Override
	public void eventUpdate(ScheduleVO schedule) {
		mapper.eventUpdate(schedule);
	}

	@Override
	public void modalRegister(ScheduleVO schedule) {
		mapper.modalRegister(schedule);
	}

	@Override
	public List<MemberVO> getMemberList(ScheduleVO schedule) {
		int deptNo = schedule.getDeptNo(); // deptNo를 VO에서 가져옴
		return mapper.getMemberList(deptNo);
	}

	@Override
	public List<ScheduleVO> getMemberNames(MemberVO member) {
		log.info("## 전달된 MemberVO: " + member); // 값이 없음
		log.info("## 전달된 memNames: " + member.getMemNames());
		
		// 전달된 MemberVO로 여러 MemberVO의 memNo 값을 가져옴 (리스트로 변경)
	    List<MemberVO> memNoList = mapper.getMemberNumList(member);  // 다수의 멤버 번호를 가져올 메서드
	    log.info("## 조회된 memNo 리스트: " + memNoList);
	    
	    // 최종적으로 반환할 ScheduleVO 리스트를 초기화
	    List<ScheduleVO> schedules = new ArrayList<ScheduleVO>();
	    
	    for (MemberVO memNo : memNoList) {
	    	List<ScheduleVO> memberSchedules = mapper.getMemberNames(memNo);
	    	schedules.addAll(memberSchedules);
		}
	    
	    log.info("## 조회된 ScheduleVO 리스트 :" +schedules);
		return schedules;
	}

	@Override
	public List<ScheduleVO> getMySchedule(int memNo) {
		
		return mapper.getMySchedule(memNo);
	}

	@Override
	public List<ScheduleVO> myList(int memNo) {
		List<ScheduleVO> scheduleList = mapper.myList(memNo); /* 해당하는 user에 스케줄을(List) 가져옴 */
		return scheduleList;
	}

	@Override
	public List<DepartmentVO> deptList() {
		return mapper.deptList();
	}

	@Override
	public List<ScheduleVO> groupAddress(int deptNo) {
		return mapper.groupAddress(deptNo);
	}

	@Override
	public ScheduleVO calendarDetail(ScheduleVO schedule) {
		return mapper.calendarDetail(schedule);
		
	}

	@Override
	public void attendInsert() {
		mapper.attendInsert();
	}

	@Override
	public List<ScheduleVO> vacationSchdl(List<Integer> memNos) {
		return mapper.vacationSchdl(memNos);
	}

	@Override
	public List<Integer> getMemNos(List<String> memNames) {
		return mapper.getMemNos(memNames);
	}

	


}
