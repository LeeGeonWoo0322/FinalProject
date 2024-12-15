package kr.or.ddit.common.project.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.sun.mail.iap.Response;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;
import kr.or.ddit.common.approval.vo.ApprovalLineMemberVO;
import kr.or.ddit.common.project.service.IProjectService;
import kr.or.ddit.common.project.vo.ChartVO;
import kr.or.ddit.common.project.vo.CheckListVO;
import kr.or.ddit.common.project.vo.PicNMVO;
import kr.or.ddit.common.project.vo.ProjectAttendeeVO;
import kr.or.ddit.common.project.vo.ProjectVO;
import kr.or.ddit.common.project.vo.WorkComentVO;
import kr.or.ddit.common.project.vo.WorkFavoriteVO;
import kr.or.ddit.common.project.vo.WorkVO;
import kr.or.ddit.common.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/project")
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class ProjectController {

	@Inject
	private IProjectService proService;
	
	@Inject
	private IAlarmService alarmService;
	
	private MemberVO getAuthenticatedMember() {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		return memberVO;
	}  
	
	
	@PostMapping("/updatePrograss")
	public ResponseEntity<Map<String,Object>> updatePrograss(@RequestBody WorkVO workVO) {
		Map<String,Object> res = new HashMap<String, Object>();
		res = proService.updatePrograss(workVO);
		
		System.out.println(res);
		return ResponseEntity.ok(res);
	}
	@PostMapping("/dueEnd")
	public ResponseEntity<Map<String,Object>> dueEnd(@RequestBody WorkVO workVO) {
		Map<String,Object> res = new HashMap<String, Object>();
		res = proService.dueEnd(workVO);
		if(res.get("status").equals("OK")) {
			res.put("result", "OK");
		} else {
			res.put("result", "FAILED");
		}
		System.out.println(res);
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/projectChart")
	public ResponseEntity<Map<String,Object>> projectChart(@RequestBody ChartVO chartVO) {
		Map<String,Object> res = new HashMap<String, Object>();
		res = proService.proChart(chartVO);
		System.out.println(res);
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/picChart")
	public ResponseEntity<Map<String,Object>> picChart(@RequestBody ChartVO chartVO) {
		Map<String,Object> res = new HashMap<String, Object>();
		res = proService.picChart(chartVO);
		if(res.get("status").equals("OK")) {
			res.put("res", "OK");
		} 
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/sider")
	public ResponseEntity<Map<String,Object>> sider(@RequestBody MemberVO memberVO , Authentication auth) {
		Map<String,Object> res = new HashMap<String, Object>();
		res = proService.sider(memberVO, auth);
		System.out.println(res);
		return ResponseEntity.ok(res);
	}
	
	@GetMapping("/projectHome")
	public String projectHome(ProjectVO proVO, Authentication auth, Model model) {
		Map<String,Object> result = new HashMap<String, Object>();
		Map<String,Object> pro = proService.listHome(proVO,auth);
		result.put("pro", pro);
		model.addAllAttributes(result);
		System.out.println("==============="+result);
		
		return "project/home_mk";
	}
	
	@GetMapping("/projectDetail/{projectNo}")
	public String projectDetail(@PathVariable int projectNo, Model model, Authentication auth) {
		
		Map<String,Object> result = proService.detailProject(projectNo, auth);
		model.addAttribute("result", result);
		System.out.println("진짜 결과는 이거야 봐야해 : "+result);
		
		return "project/detail_mk";
	}
	
	
	
	
	
	@PostMapping("/insertProject")
	public ResponseEntity<Map<String,Object>> insertProject(
			@RequestBody ProjectVO proVO, Authentication auth ) {
		System.out.println("proVO============"+proVO);
		Map<String,Object> response = new HashMap<>();
		ServiceResult res = proService.insertProject(proVO, auth);
		if(res == ServiceResult.OK) {
			response.put("status", "success");
			response.put("proVO", proVO);
		} else {
			response.put("status", "fail");
		}
		
		MemberVO memberVO = getAuthenticatedMember();
		List<ProjectAttendeeVO> paList = proService.projectAttendeeList(proVO.getProjectNo());
		AlarmVO alarm = new AlarmVO();
		AlarmBanVO alarmBanVO = new AlarmBanVO();
		List<AlarmVO> alarmList =new ArrayList<>();
		System.out.println("11111000000000");
		for (ProjectAttendeeVO member : paList ) {
			alarmBanVO.setMemNo(member.getMemNo());
			alarmBanVO.setTechCategory("프로젝트");
			int cnt=alarmService.chkBanAlarm(alarmBanVO);
			if(cnt>0) {
				continue;
			}
			alarm.setAlarmCategory("프로잭트");
			alarm.setReceiverNo(member.getMemNo());
			alarm.setAlarmContent(memberVO.getMemName()+" "+memberVO.getPosName()+"님이 "+proVO.getProjectTitle()+"을 발신함.");
			alarm.setAlarmUrl("/project/projectDetail/"+proVO.getProjectNo());
			AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
			alarmList.add(insertedAlarm);
		}
		if (alarmList.size()>0) { 
			alarmService.sendNotificationToUsers(alarmList);
		}

		
		return ResponseEntity.ok(response);
	}
	
	
	@PostMapping("/insertWork")
	public ResponseEntity<String> insertWork(
			@RequestPart("workVO") WorkVO workVO
			, @RequestPart(value = "files", required = false) MultipartFile[] files
			, @RequestPart("chekVO") CheckListVO chekVO
			, @RequestPart("picVO") PicNMVO picVO
			, Authentication auth
			) throws Exception{
		
		
		workVO.setAttachedFiles(files);
		String result = "";
		
		Map<String, Object> res = new HashMap<>();
		ServiceResult re = proService.insertWork(workVO, chekVO, picVO, auth);
		if (re == ServiceResult.OK) {
			result = "SUCCESS";
		}else {
			result = "FAIL";
		}
		System.out.println("컨트롤러 :"+res );
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	
	
	// 지울까
	@PostMapping("/workDetail")
	public ResponseEntity<Map<String, Object>> workDetail(@RequestBody WorkVO workVO ){
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> detailVal = proService.detailWork(workVO);
		
		
		if(detailVal.get("res") == ServiceResult.OK) {
			
			result.put("detailVal",detailVal);
		} else {
			result.put("err", "err!");
		}
		System.out.println("1=============="+result.get("detailVal").toString());
		return ResponseEntity.ok(result);
		
	}

	@PostMapping("/modalOpen")
	public ResponseEntity<Map<String,Object>> modalOpen(@RequestBody WorkVO workVO, Authentication auth){
		Map<String, Object> res = new HashMap<>();
		res = proService.modalOpen(workVO , auth); 
		
		
		
		return ResponseEntity.ok(res);
	}
	
	
	
	@PostMapping("/newComent")
	public ResponseEntity<Map<String, Object>> newComent(@RequestBody WorkComentVO wcVO, Authentication auth) {
		Map<String,Object> res = new HashMap<String, Object>();
		System.out.println(wcVO);
		res = proService.newComent(wcVO,auth);
		res.put("wcVO", wcVO);
		System.out.println(res);
		
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/delComent")
	public ResponseEntity<Map<String, Object>> delComent(@RequestBody WorkComentVO wcVO, Authentication auth) {
		Map<String,Object> res = new HashMap<String, Object>();
		System.out.println(wcVO);
		res = proService.delComent(wcVO,auth);
		res.put("wcVO", wcVO);
		
		System.out.println(res);
		
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/delWork")
	public ResponseEntity<Map<String, Object>> delWork(@RequestBody WorkVO workVO, Authentication auth) {
		Map<String,Object> res = new HashMap<String, Object>();
		System.out.println(workVO);
		res = proService.delWork(workVO,auth);
		if(res.get("re") == ServiceResult.OK) {
			System.out.println("성공?");
			res.put("res","OK");
		}
		
		System.out.println(workVO);
		
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/delProject")
	public ResponseEntity<Map<String, Object>> delProject(@RequestBody ProjectVO proVO, Authentication auth) {
		System.out.println("33333333333333333333333333333 = "+proVO);
		Map<String,Object> res = new HashMap<String, Object>();
		res = proService.delProject(proVO, auth);
		if(res.get("re") == ServiceResult.OK) {
			res.put("res", "OK");
		} else {
			res.put("res", "FAILED");
		}
		System.out.println("dd?"+res);
		
		return ResponseEntity.ok(res);
	}
	
	@PostMapping("/checkListYN")
	public ResponseEntity<Map<String, Object>> checkListYn(@RequestBody CheckListVO checkVO, Authentication auth) {
		Map<String,Object> re = new HashMap<String, Object>();
		String status;
		re = proService.checkListYn(checkVO,auth);
		if(re.get("result") == ServiceResult.OK) {
			re.put("status", "OK");
		} else {
			re.put("status", "Fail");
			
		}
		
		return ResponseEntity.ok(re);
	}
	
	
	@PostMapping("/modifyWork")
	public ResponseEntity<Map<String, Object>> modifyWork(
			@RequestPart("workVO") WorkVO workVO
			,@RequestPart("checkVO") CheckListVO checkVO
			,@RequestPart("picVO") PicNMVO picVO
			,@RequestPart("proVO") ProjectVO proVO
			,@RequestPart(value = "files", required = false) MultipartFile[] files
			, Authentication auth){
		Map<String,Object> re = new HashMap<String, Object>();
		re = proService.modwork(workVO, checkVO, picVO, proVO, auth, files);
		
			
			if(re.get("sr").equals("OK"))  {
				re.put("res", "SUCCESS");
				
			} else {
				re.put("res", "FAILED");
				
			}
			
		
		return ResponseEntity.ok(re);
	}
	
	@PostMapping("/workPrograss")
	public ResponseEntity<Map<String,Object>> workPrograss (@RequestBody WorkVO workVO){
		Map<String,Object> re = new HashMap<String, Object>();
		
			re = proService.workStatus(workVO);
					
		
		return ResponseEntity.ok(re);
	}
	@PostMapping("/modField")
	public ResponseEntity<Map<String,Object>> modField (@RequestBody WorkVO workVO){
		Map<String,Object> res = new HashMap<String, Object>();
		
		res = proService.modField(workVO);
		if(res.get("status") == "OK") {
			res.put("result", "SUCCESS");
		} else {
			res.put("result", "FAILED");
		}
		
		return ResponseEntity.ok(res);
	}
	
	
	@PostMapping("/favorInsert")
	public ResponseEntity<Map<String,Object>> favorInsert (@RequestBody WorkFavoriteVO favorVO){
		Map<String,Object> re = new HashMap<String, Object>();
		
		re = proService.favorInsert(favorVO);
		if(re.get("status").equals("OK")) {
			re.put("result","SUCCESS");
		}else {
			re.put("result","FAILED");
		}
		
		return ResponseEntity.ok(re);
	}
	@PostMapping("/delFavor")
	public ResponseEntity<Map<String,Object>> delFavor (@RequestBody WorkFavoriteVO favorVO){
		Map<String,Object> re = new HashMap<String, Object>();
		
		re = proService.delFavor(favorVO);
		if(re.get("status").equals("OK")) {
			re.put("result","SUCCESS");
		}else {
			re.put("result","FAILED");
		}
		
		return ResponseEntity.ok(re);
	}
	
	
}
