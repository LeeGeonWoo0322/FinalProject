package kr.or.ddit.admin.attend.web;

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
@RequestMapping("/admin/attend")
public class AdminAttendController {
	
	@Inject
	private IAccountService accountService;
	
	@RequestMapping("/attendSetTime")
	public String attendSetTime(Authentication authen, Model model) {
		log.info("admin attendSetTime 진입");
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		
		return "admin/attend/attendSetTime";
	}
	
	@RequestMapping("/attendSetState")
	public String attendSetState(Authentication authen, Model model) {
		log.info("admin attendSetState 진입");
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		
		return "admin/attend/attendSetState";
	}
	
	@RequestMapping("/attendDelVaca")
	public String attendDelVaca(Authentication authen, Model model) {
		log.info("admin attendDelVaca 진입");
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		
		return "admin/attend/attendDelVaca";
	}
	
	@RequestMapping("/attendSetVaca")
	public String attendSetVaca(Authentication authen, Model model) {
		log.info("admin attendSetVaca 진입");
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		
		return "admin/attend/attendSetVaca";
	}
}
