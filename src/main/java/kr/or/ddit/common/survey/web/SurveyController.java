package kr.or.ddit.common.survey.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.security.vo.CustomUser;
import kr.or.ddit.common.survey.service.ISurveyService;
import kr.or.ddit.common.survey.vo.SurveyAttendeeVO;
import kr.or.ddit.common.survey.vo.SurveyResponseVO;
import kr.or.ddit.common.survey.vo.SurveyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/survey")
public class SurveyController {
	
	@Inject
	ISurveyService surveyService;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String survey(Model model) {
		
		// 로그인한 회원정보 가져오기
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		// 로그인한 계정의 회원번호
		int memNo = memberVO.getMemNo(); 
		
		List<SurveyVO> mySurveyList = surveyService.getMySurveyList(memNo);						// 설문 대상에 내가 포함된 설문 리스트
		List<SurveyAttendeeVO> myAttendanceList = surveyService.getMyAttendanceList(memNo);		// 내가 참여하고 있는 설문 번호들과 참여여부
//		List<MemberVO> memberList = surveyService.getMemberList();								// 회원 리스트
		
		// SurveyVO에 있는 List<surveyAttendeeVO> 를 채워넣어준다.
		for(SurveyVO mySurvey : mySurveyList) {
			int mySurveyNo = mySurvey.getSurvNo();
			List<SurveyAttendeeVO>surveyAttendee = surveyService.getSurveyAttendee(mySurveyNo);
			mySurvey.setSurveyAttendee(surveyAttendee);
		}
		
		model.addAttribute("mySurveyList",mySurveyList);
		model.addAttribute("myAttendanceList",myAttendanceList);
		
		return "survey/main";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/registerForm1")
	public String surveyRegisterForm1(Model model) {
		
		List<DepartmentVO> departmentList = surveyService.getDepartmentList();
		List<MemberVO> memberList = surveyService.getMemberList();
		
		model.addAttribute("departmentList",departmentList);
		model.addAttribute("memberList",memberList);
		
		return "survey/registerForm1";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/registerForm2", method = RequestMethod.POST)
	public String surveyRegisterForm2(SurveyVO surveyVO, Model model) {
		SurveyVO test1 = surveyVO;
		String test2 = "test";
		
		model.addAttribute(model);
		return "survey/registerForm2";
	}
	
	// 설문하러 가기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/doSurvey", method = RequestMethod.GET)
	public String doSurvey(int survNo, Model model) {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		int memNo = memberVO.getMemNo();
		
		SurveyVO thisSurvey = surveyService.getThisSurvey(survNo);
		int writerMemberNo = thisSurvey.getMemNo();
		
		SurveyVO writerInfo = surveyService.getWriterInfo(writerMemberNo);
		thisSurvey.setMemName(writerInfo.getMemName());
		thisSurvey.setPosName(writerInfo.getPosName());
		thisSurvey.setDeptName(writerInfo.getDeptName());
		
		model.addAttribute("thisSurvey",thisSurvey);
		
		String test = "test";
		
		String test1 = test;
		
		return "survey/doSurvey";
	}
	
	// 설문 확인하러 가기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/goResult", method = RequestMethod.GET)
	public String goResult(int survNo, Model model) {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		int memNo = memberVO.getMemNo();
		
		SurveyVO thisSurvey = surveyService.getThisSurvey(survNo);
		int writerMemberNo = thisSurvey.getMemNo();
		
		SurveyVO writerInfo = surveyService.getWriterInfo(writerMemberNo);
		thisSurvey.setMemName(writerInfo.getMemName()); 
		thisSurvey.setPosName(writerInfo.getPosName()); 
		thisSurvey.setDeptName(writerInfo.getDeptName());
		
		model.addAttribute("thisSurvey",thisSurvey);
		
		String test = "test";
		
		String test1 = test;
		
		return "survey/goResult";
	}
	// 답안 받아서 등록하기
	@RequestMapping(value = "/submitResponse", method = RequestMethod.POST)
	public ResponseEntity<String> submitResponse(@RequestBody List<Map<String, Object>>data){
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		// 답안 VO
		SurveyResponseVO surveyResponseVO = new SurveyResponseVO();
		
		int cnt = 0;
		
		for(int i=0; i<data.size(); i++) {
			Map<String, Object> responseOfQ = data.get(i);
			int qNo = Integer.parseInt((String) responseOfQ.get("qNo")); 
			String respContent = (String) responseOfQ.get("respContent");
			
			surveyResponseVO.setQNo(qNo);
			surveyResponseVO.setRespContent(respContent);
			surveyResponseVO.setMemNo(memberVO.getMemNo());
			
			// 답변 등록
			int count = surveyService.submitResponse(surveyResponseVO);
			cnt += count;
		}
		int survNo = (int) data.get(0).get("survNo"); 
		
		// Survey Attendee VO 에 survNo와 memNo 조건을 걸어 참여 여부 Y로 변경
		SurveyAttendeeVO surveyAttendeeVO = new SurveyAttendeeVO();
		surveyAttendeeVO.setMemNo(memberVO.getMemNo());
		surveyAttendeeVO.setSurvNo(survNo);
		surveyService.participatedSuevey(surveyAttendeeVO);
		
		String resp = "";
		if(cnt == data.size()) {
			resp = "good";
		}else {
			resp = "뭔가 잘못됨";
		}
		
		return new ResponseEntity<String>(resp,HttpStatus.OK);
	}
	
	@RequestMapping(value = "ongoingSurvey", method = RequestMethod.GET)
	public String ongoingSurvey(Model model) {
		log.info("abc"+model);
		return "survey/ongoingSurvey";
	}
	
	@RequestMapping(value = "completedSurvey", method = RequestMethod.GET)
	public String completedSurvey(Model model) {
		log.info("abcd"+model);
		return "survey/completedSurvey";
	}
	
	
	
	
	
	
	
	
	
	

}
