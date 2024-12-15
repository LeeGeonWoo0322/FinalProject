package kr.or.ddit.common.attend.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.service.IWorkAtstateService;
import kr.or.ddit.common.attend.vo.WorkAtstateVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/workState")
public class WorkAtstateController {
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IWorkAtstateService workStateService;
	
	@ResponseBody
	@RequestMapping(value = "/changeWork", method = RequestMethod.POST)
	public int changeWork(@RequestBody WorkAtstateVO atstate){
		int res = workStateService.changeWork(atstate);

		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/printWorking", method = RequestMethod.POST)
	public WorkAtstateVO printWorking(@RequestBody WorkAtstateVO atstate){
		WorkAtstateVO res = workStateService.printWorking(atstate);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/printLWork", method = RequestMethod.POST)
	public MemberVO printLWork(@RequestBody MemberVO member){
		MemberVO res = workStateService.printLWork(member);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updAtstate", method = RequestMethod.POST)
	public int updAtstate(@RequestBody WorkAtstateVO atstate){
		int res = workStateService.updAtstate(atstate);

		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updWork", method = RequestMethod.POST)
	public int updWork(@RequestBody WorkAtstateVO atstate){
		int res = workStateService.updWork(atstate);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delAtstate", method = RequestMethod.POST)
	public int delAtstate(@RequestBody WorkAtstateVO atstate){
		int res = workStateService.delAtstate(atstate);

		return res;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/renderCurMonth", method = RequestMethod.POST)
	public List<WorkAtstateVO> renderCurMonth(@RequestBody WorkAtstateVO atstate){
		List<WorkAtstateVO> res = workStateService.curMonth(atstate);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/renderModal", method = RequestMethod.POST)
	public WorkAtstateVO renderModal(@RequestBody WorkAtstateVO atstate) {
		WorkAtstateVO res = workStateService.curModal(atstate);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/atList", method = RequestMethod.POST)
	public List<WorkAtstateVO> atList(@RequestBody WorkAtstateVO atstate){
		List<WorkAtstateVO> atList = workStateService.atList(atstate);
		
		return atList;
	}
}
