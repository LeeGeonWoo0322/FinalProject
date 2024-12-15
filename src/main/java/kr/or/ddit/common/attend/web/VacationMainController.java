package kr.or.ddit.common.attend.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.service.IVacationService;
import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import kr.or.ddit.common.attend.vo.VacCreateVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("vacation")
public class VacationMainController {
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IVacationService vacationService;
	
	@RequestMapping("/printMyVacation")
	public String printMyVacation(Authentication authen, Model model){
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member",member);
		
		return "attend/myVacation";
	}
	
	@ResponseBody
	@RequestMapping(value="/myUseVacaList", method = RequestMethod.POST)
	public List<UseVacationVO> myUseVacaList(@RequestBody UseVacationVO useVaca){
		List<UseVacationVO> res = vacationService.vacaAllList(useVaca);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/myCreateVacaList", method = RequestMethod.POST)
	public List<VacCreateVO> myCreateVacaList(@RequestBody VacCreateVO createVaca){
		List<VacCreateVO> res = vacationService.createVacaList(createVaca);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/myUseVacaTotal", method = RequestMethod.POST)
	public List<UseVacationVO> myVacaTotal(@RequestBody UseVacationVO useVaca){
		List<UseVacationVO> res = vacationService.myVacaTotal(useVaca);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/myCreateVacaTotal", method = RequestMethod.POST)
	public List<VacCreateVO> myCreateVacaTotal(@RequestBody VacCreateVO createVaca){
		List<VacCreateVO> res = vacationService.myCreateVacaTotal(createVaca);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/deptVaca", method = RequestMethod.POST)
	public int deptVaca(@RequestBody AttendanceVO attendance){
		int res = vacationService.deptVaca(attendance);
		
		return res;
	}
	
	
}
