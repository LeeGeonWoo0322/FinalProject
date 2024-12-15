package kr.or.ddit.admin.security.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.security.service.IAdminSecurityService;
import kr.or.ddit.common.account.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/security")
public class AdminSecurityController {

	@Inject
	private IAdminSecurityService adminSecurityService;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/loginLog")
	public String serviceInfo(Model model) {
		
		List<LogVO> logList = adminSecurityService.getLogList();
		
		model.addAttribute("logList", logList);
		
		return "admin/security/loginLog";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/logSearch.do")
	public ResponseEntity<List<LogVO>> logSearch(@RequestBody LogVO logVO) {
		
		List<LogVO> logList = new ArrayList<LogVO>();
		
		if (logVO.getMemName() == "" || logVO.getMemName() == null) {
			logList = adminSecurityService.logSearchByPeriod(logVO);
		}else if(logVO.getStartDate() == "" || logVO.getStartDate() == null){
			logList = adminSecurityService.logSearchByName(logVO);
		}else {
			logList = adminSecurityService.logSearchByAll(logVO);
		}
			
		return new ResponseEntity<List<LogVO>>(logList, HttpStatus.OK);
	}
	
}
