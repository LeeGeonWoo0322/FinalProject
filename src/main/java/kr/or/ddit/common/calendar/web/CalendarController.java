package kr.or.ddit.common.calendar.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.calendar.service.IScheduleService;
import kr.or.ddit.common.calendar.vo.ResponseDateVO;
import kr.or.ddit.common.calendar.vo.SchdlAttendeeVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendar")
public class CalendarController {

	@Inject
	private IAccountService accountService;
	
	@Inject
	private IScheduleService service;
	
	
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping("/main")
	public String mainForm(Authentication authentication, Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		log.info("## 초기 user 정보값 : " + member);
		return "calendar/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/getMain" , method = RequestMethod.GET)
	public Map<String, List<ScheduleVO>> getMain(int memNo) {
		List<ScheduleVO> scheduleList = service.myList(memNo);
		log.info("## scheduleList !! " + scheduleList);
		
		// schdlGroup이 'my'인 이벤트를 비공개와 공개로 나누기
	    List<ScheduleVO> myEventsY = scheduleList.stream()
	            .filter(event -> "my".equals(event.getSchdlGroup()) && "Y".equals(event.getSchdlOpen())) // 공개 이벤트
	            .collect(Collectors.toList());
	    
	    List<ScheduleVO> myEventsN = scheduleList.stream()
	            .filter(event -> "my".equals(event.getSchdlGroup()) && "N".equals(event.getSchdlOpen())) // 비공개 이벤트
	            .collect(Collectors.toList());
	    
	    // schdlGroup이 'my'가 아닌 이벤트 중 schdlOpen이 'Y'인 이벤트
	    List<ScheduleVO> groupEventsY = scheduleList.stream()
	            .filter(event -> !"my".equals(event.getSchdlGroup()) && "Y".equals(event.getSchdlOpen())) // 공개 이벤트
	            .collect(Collectors.toList());

	    // 결과를 Map에 추가
	    Map<String, List<ScheduleVO>> result = new HashMap<String, List<ScheduleVO>>();
	    result.put("myEventsY", myEventsY); // 공개 이벤트
	    result.put("myEventsN", myEventsN); // 비공개 이벤트
	    result.put("groupEventsY", groupEventsY); // 공개 그룹 이벤트
	    log.info("## groupEventsY !! " + groupEventsY);
	    return result;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/register" , method = RequestMethod.GET)
	public String calendarRegisterForm(Authentication authentication, Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		log.info("## member 값 : " + member);
		log.info("posNo : " + member.getPosNo());
		return "calendar/register";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value="/register" , method = RequestMethod.POST)
	public String calendarRegister(@RequestBody ScheduleVO schedule , Model model , Authentication authentication) {
		
		log.info("## memlist in schedule" + schedule.getMemNos().toString());
		/*
		ScheduleVO(schdlNo=0, calNo=0, memNo=0, deptNo=0, schdlName=super민수, schdlGroup=my, schdlPlace=, startDate=2024-11-01, 
		endDate=2024-11-01, startTime=00:00:00, endTime=00:00:00, alldayYn=null, schdlColor=null, reptYn=null, schdlContent=, 
		schdlOpen=Y, memNosArr=['83', '41'], memNos=null)
		 */
		List<MemberVO> memNos = schedule.getMemNos();
		
		//memNosArr=[83, 41]
		
//		String[] memNosArr = schedule.getMemNosArr();
//		for(String memNoStr : memNosArr) {
//			MemberVO memberVO = new MemberVO();
//			memberVO.setMemNo(Integer.parseInt(memNoStr));
//			memNos.add(memberVO); //***
//		}
//		schedule.setMemNos(memNos);
		
		// memNosArr=['83', '41'], memNos=완성)
		/*
		memNosArr=[83, 41], 
		memNos=[
			MemberVO(memNo=83, posNo=0, deptNo=0, wtNo=0, memId=null, memPw=null, memName=null, memTel=null, memEmail=null, memAddr1=null, memAddr2=null, memPost=null, hireDate=null, memStatus=null, driverLicense=null, memProfileimg=null, tempPwYn=null, enabled=null, workVaca=0, driveVolume=null, memCardImage=null, memCardMemo=null, secNo=0, memAuth=null, posName=null, deptName=null, abNo=null, abName=null, memImgFile=null, cardImgFile=null, memNames=null), 
			MemberVO(memNo=41, posNo=0, deptNo=0, wtNo=0, memId=null, memPw=null, memName=null, memTel=null, memEmail=null, memAddr1=null, memAddr2=null, memPost=null, hireDate=null, memStatus=null, driverLicense=null, memProfileimg=null, tempPwYn=null, enabled=null, workVaca=0, driveVolume=null, memCardImage=null, memCardMemo=null, secNo=0, memAuth=null, posName=null, deptName=null, abNo=null, abName=null, memImgFile=null, cardImgFile=null, memNames=null)
		]
		 */
		log.info("calendarRegister->schedule : " + memNos);
		
		String memId = authentication.getName();
		MemberVO memberDetails = service.getMemberDetail(memId);
		log.info("## memberDetails : " + memberDetails);
		schedule.setMemNo(memberDetails.getMemNo());
	    schedule.setDeptNo(memberDetails.getDeptNo());
	    log.info("## schedule : " + schedule);
	    
		service.register(schedule);
		return "SUCCESS";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value="/modal" , method = RequestMethod.POST)
	public String modalRegister(@RequestBody ScheduleVO schedule , Model model) {
		log.info("#$#$ schedule : " + schedule);
		service.modalRegister(schedule);
		return "SUCCESS";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/events" , method = RequestMethod.GET)
	public ResponseEntity<List<ScheduleVO>> getEvents() {
		List<ScheduleVO> scheduleList = service.list();		// 전체 스케줄 가져옴
		return new ResponseEntity<List<ScheduleVO>>(scheduleList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value="/saveEvent" , method = RequestMethod.POST)
	 public String saveEvent(@RequestBody ScheduleVO schedule) {
		service.eventUpdate(schedule);
		return "SUCCESS"; 
	 }
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/detail" , method = RequestMethod.POST)
	public String calendarDetail(ScheduleVO schedule, Model model , Authentication authentication) {
		User user = (User)authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		log.info("## schedual : " + schedule);
		ScheduleVO attendMember = service.calendarDetail(schedule);
		schedule = service.calendarDetail(schedule);
		model.addAttribute("member" , member);
		model.addAttribute("schedule", schedule);
		model.addAttribute("attendMember", attendMember);
		log.info("## attendMember : " + attendMember);
		return "calendar/detail";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/update" , method = RequestMethod.GET)
	public String calendarUpdateForm(@RequestParam("schdlNo") int schdlNo, Model model, Authentication authentication) {
		User user = (User)authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		ScheduleVO schedule = service.selectOne(schdlNo);
		log.info("## schedule : " + schedule);
		ScheduleVO attendMember = service.calendarDetail(schedule);
		log.info("## attendMember : " + attendMember);
		model.addAttribute("member" , member);
		model.addAttribute("schedule" , schedule);
		model.addAttribute("attendMember" , attendMember);
		
		return "calendar/update";
		
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value="/update" , method = RequestMethod.POST)
	public String calendarUpdate(@RequestBody ScheduleVO schedule , Model model) {
		log.info("## update schedule : " + schedule);
		service.update(schedule);
		return "SUCCESS"; 
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/delete" , method = RequestMethod.POST)
	public String calendarDelete(int schdlNo, Model model) {
		service.delete(schdlNo);
		model.addAttribute(schdlNo);
		return "redirect:/calendar/main";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value="/individualSched" , method = RequestMethod.POST )
	public List<MemberVO> individualSched(@RequestBody ScheduleVO schedule) {
		List<MemberVO> memberList = service.getMemberList(schedule);
		return memberList;
	}
	
	@ResponseBody
	@RequestMapping(value="/modelContent" , method=RequestMethod.POST)
	public String modelContent(@RequestParam("id") String menuId) {
		String modalContent;
        switch (menuId) {
            case "evryDay":
                modalContent = "<select>";
        		for (int i = 1; i <= 30; i++) {
                    modalContent += "<option value='" + i + "'>" + i + "</option>";
                }
                modalContent += "</select> 일 마다";
                break;
            case "evryWek":
                modalContent = ""
            +"<p>매주 반복 일정을 설정하세요.</p>";
                break;
            case "evryMon":
            	modalContent = "<p>매주 반복 일정을 설정하세요.</p>";
            	break;
            default:
                modalContent = "<p>잘못된 선택입니다.</p>";
                break;
        }
        // HTML 콘텐츠를 직접 반환
        return modalContent;
    }

	@ResponseBody
	@RequestMapping(value ="/eventsForMembers" , method = RequestMethod.POST)
	public ResponseDateVO getMembers(@RequestBody MemberVO member) {		
		log.info("## 빨리 찾는 방법 member : " + member.getMemNames());
		List<Integer> memNos = service.getMemNos(member.getMemNames());
		
	    List<ScheduleVO> events = service.getMemberNames(member);	/* 개인스캐줄(memNo별) 중 공개 설정한 데이터  */
	    log.info("## 빨리 찾는 방법 2 : " + events);
	    
	    /* 이벤트를 가져와야함 */
	    
//	    List<Integer> memNos = new ArrayList<Integer>();
	    
//	    Set<Integer> memNos = new HashSet<Integer>();	// Set을 사용하여 중복 제거
//	    for (ScheduleVO event : events) {
//	    	memNos.add(event.getMemNo());
//	    }
	    
	    // vacationSchdl 메서드 호출 시 memNo 리스트 전달
//	    List<ScheduleVO> vacationSchedules = service.vacationSchdl(memNos);
	    List<ScheduleVO> vacationSchedules = service.vacationSchdl(new ArrayList<Integer>(memNos));	// Set을 List로 변환
	    
	    ResponseDateVO responseDate = new ResponseDateVO();
        responseDate.setEvents(events);
        responseDate.setVacationSchedules(vacationSchedules);
        
	    return responseDate;
	}
	
	@ResponseBody
	@RequestMapping(value ="/eventsForMe" , method = RequestMethod.POST)
	public Map<String, List<ScheduleVO>> getMySchedule(@RequestBody MemberVO member) {
		
		List<ScheduleVO> events = service.getMySchedule(member.getMemNo());
		log.info("## events : " + events);
		
		List<ScheduleVO> myEvents = events.stream()
				.filter(event -> "my".equals(event.getSchdlGroup())) // schdlGroup이 'my'인 이벤트 필터링
		        .collect(Collectors.toList());
		
		List<ScheduleVO> groupEvents = events.stream()
		        .filter(event -> !"my".equals(event.getSchdlGroup())) // schdlGroup이 'my'가 아닌 이벤트 필터링
		        .collect(Collectors.toList());
		
		Map<String, List<ScheduleVO>> result = new HashedMap();
		result.put("myEvents", myEvents);
	    result.put("groupEvents", groupEvents);
		
//	    return events; // List<ScheduleVO> 로 받음
	    return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deptList" , method = RequestMethod.GET)
	public List<DepartmentVO> deptList() {
		List<DepartmentVO> deptList = service.deptList();
		return deptList;
	}
	
	@ResponseBody
	@RequestMapping(value ="/groupAddress" , method = RequestMethod.POST)
	public List<ScheduleVO> groupAddress(@RequestBody MemberVO member) {
		log.info("## 빨리 찾는 방법 depNo : " + member.getDeptNo());
	    List<ScheduleVO> events = service.groupAddress(member.getDeptNo());
	    log.info("## 빨리 찾는 방법 2 : " + events);
	    return events;
	}
	
	@ResponseBody
	@RequestMapping(value="/detailRegister" , method = RequestMethod.POST)
	public String detailRegister(@RequestBody ScheduleVO schedule , Model model) {
		log.info("#$#$ schedule : " + schedule);
		
		return "SUCCESS";
	}
	
	@ResponseBody
	@RequestMapping(value = "/attendMember" , method=RequestMethod.POST)
	public List<MemberVO> attendMember(@RequestBody Map<String, List<Integer>>map , Model model) {
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		List<Integer> memList = map.get("memList");
		for (int memNo : memList) {
			MemberVO member = accountService.getMemberByNo(memNo);
			memberList.add(member);
		}
		return memberList;
	}
 
}
