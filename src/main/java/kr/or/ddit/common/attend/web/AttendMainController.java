package kr.or.ddit.common.attend.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.service.IAttendanceService;
import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.attend.vo.WorkAtstateVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/attend")
public class AttendMainController {
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IAttendanceService attendService;
	
	@RequestMapping("/main")
	public String main(Authentication authen, Model model) {
		log.info("attend main 진입");
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		
		return "attend/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/gWork", method = RequestMethod.POST)
	public int gWork(@RequestBody AttendanceVO attendance){
		int res = attendService.gWork(attendance);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/lWork", method = RequestMethod.POST)
	public int lWork(@RequestBody AttendanceVO attendance){
		int res = attendService.lWork(attendance);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updOverTime", method = RequestMethod.POST)
	public int updOverTime(@RequestBody AttendanceVO attendance){
		int res = attendService.updOverTime(attendance);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updAttend", method = RequestMethod.POST)
	public int updAttend(@RequestBody AttendanceVO attendance){
		int res = attendService.updAttend(attendance);
		
		return res;
	}
	
	@RequestMapping(value = "/glWorkTime", method = RequestMethod.POST)
	public ResponseEntity<AttendanceVO>  glWorkTime(@RequestBody AttendanceVO attendance){
		AttendanceVO res = attendService.glWorkTime(attendance);
		return new ResponseEntity<AttendanceVO>(res,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/otPrint", method = RequestMethod.POST)
	public ResponseEntity<AttendanceVO>  otPrint(@RequestBody AttendanceVO attendance){
		log.info("otPrint 진입");
		AttendanceVO res = attendService.otPrint(attendance);
		System.out.println("####################"+res);
		
		return new ResponseEntity<AttendanceVO>(res,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/overTimeUpd", method = RequestMethod.POST)
	public ResponseEntity<AttendanceVO>  overTimeUpd(@RequestBody AttendanceVO attendance){
		AttendanceVO res = attendService.overTimeUpd(attendance);
		
		return new ResponseEntity<AttendanceVO>(res,HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/renderCurMonth", method = RequestMethod.POST)
	public List<WorkAtstateVO> renderCurMonth(@RequestBody AttendanceVO attendance){
		List<WorkAtstateVO> res = attendService.curMonth(attendance);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/totalDeptList", method = RequestMethod.POST)
	public List<AttendanceVO> totalDeptList(@RequestBody AttendanceVO attendance){
		List<AttendanceVO> res = attendService.totalDeptList(attendance);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/deptWeekAttend", method =RequestMethod.POST)
	public List<MemberVO> deptWeekAttend (@RequestBody AttendanceVO attendance){
		List<MemberVO> res = attendService.deptWeekAttend(attendance);
		
		return res;
	}
	
	@PostMapping("/vacaData")
	public ResponseEntity<Map<String,Object>>vacaChartData(@RequestBody String choiceMon){
		System.out.println(choiceMon);
//		Map<String, Object> res = attendService.vacaChartData(choiceMon);
		
		return null;
	}
}