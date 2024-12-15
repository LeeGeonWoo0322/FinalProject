package kr.or.ddit.admin.basic.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.basic.service.IAdminBasicService;
import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/basic")
public class AdminBasicController {

	@Inject
	private IAccountService	accountService;
	
	@Inject
	private IAdminBasicService adminBasicService;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/capacityRequest.do") 
	public String serviceInfo(Model model) {
		
		List<UpgradeReqVO> upgradeReqVOList = adminBasicService.getUpgradeReqList();
		
		model.addAttribute("upgradeReqVOList", upgradeReqVOList);
		
		return "admin/basic/capacityRequest";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/reqManage.do")
	public ResponseEntity<UpgradeReqVO> reqManage(@RequestBody UpgradeReqVO upgradeReqVO, Authentication authentication) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		upgradeReqVO.setRespMemNo(member.getMemNo());
		adminBasicService.updateUpgradeReq(upgradeReqVO);
		upgradeReqVO = adminBasicService.getUpgradeReqByUrNo(upgradeReqVO);
		if (upgradeReqVO.getReqStatus() == 1) {
			if (upgradeReqVO.getReqGb() == 1) {
				accountService.updateMailVolume(upgradeReqVO);
			}else if (upgradeReqVO.getReqGb() == 2) {
				accountService.updateDriveVolume(upgradeReqVO);
			}
		}
		upgradeReqVO = adminBasicService.getUpgradeReqByUrNo(upgradeReqVO);
		
		return new ResponseEntity<UpgradeReqVO>(upgradeReqVO, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/searchReq.do")
	public ResponseEntity<List<UpgradeReqVO>> searchReq(@RequestBody UpgradeReqVO upgradeReqVO) {
		
		List<UpgradeReqVO> upgradeReqVOList = adminBasicService.searchReq(upgradeReqVO);
		
		return new ResponseEntity<List<UpgradeReqVO>>(upgradeReqVOList, HttpStatus.OK);
	}
	
}
