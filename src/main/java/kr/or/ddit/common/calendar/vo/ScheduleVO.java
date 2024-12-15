package kr.or.ddit.common.calendar.vo;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import lombok.Data;

@Data
public class ScheduleVO {
	private int schdlNo;
	private int calNo;
	private int memNo;
	private int deptNo;
	private String schdlName;
	private String schdlGroup;
	private String schdlPlace;
	private String startDate;
	private String endDate;
	private String startTime;
	private String endTime;
	private String alldayYn;
	private String schdlColor;
	private String reptYn;
	private String schdlContent;
	private String schdlOpen;
	
	private String[] memNosArray;
	
	//SCHDL : MEMBER = 1 : N
	//FROM SCHEDULE S, MEMBER M
	//WHERE S.MEM_NO = M.MEM_NO
	// <select ... resultMap="schduleMap"
	// join문을 쓰면 resultMap도 사용
	private List<MemberVO> memNos;
	
	private String[] memNames;
    private String[] deptNames;
	//SCHDL : SCHDL_ATTENDEE = 1 : N
	private List<SchdlAttendeeVO> schdlAttendeeVO;
	private List<ScheduleVO> vacationSchedules;

	
}