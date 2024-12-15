package kr.or.ddit.common.attend.web;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("info")
public class InfoMainController {
	
	@Inject
	private IAccountService accountService;
	
	@RequestMapping("/myInfo")
	public String printMyVacation(Authentication authen, Model model){
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member",member);
		
		return "attend/myInfo";
	}
	
	@RequestMapping("/deptAttendList")
	public String deptAttendList(Authentication authen, Model model){
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member",member);
		
		return "attend/deptAttendList";
	}
	
	@RequestMapping("/deptAttendTotal")
	public String deptAttendTotal(Authentication authen, Model model){
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member",member);
		
		return "attend/deptAttendTotal";
	}
	
	@RequestMapping("/allAttendList")
	public String allAttendList(Authentication authen, Model model){
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member",member);
		
		return "attend/allAttendList";
	}
	
	@RequestMapping("/allAttendTotal")
	public String allAttendTotal(Authentication authen, Model model){
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member",member);
		
		return "attend/allAttendTotal";
	}
}
