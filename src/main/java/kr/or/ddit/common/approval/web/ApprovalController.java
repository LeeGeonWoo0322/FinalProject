package kr.or.ddit.common.approval.web;

import java.io.File;
import java.io.IOException;
import java.text.MessageFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;
import kr.or.ddit.common.approval.service.IApprovalService;
import kr.or.ddit.common.approval.vo.AgencyVO;
import kr.or.ddit.common.approval.vo.ApprovalFormVO;
import kr.or.ddit.common.approval.vo.ApprovalLineMemberVO;
import kr.or.ddit.common.approval.vo.ApprovalVO;
import kr.or.ddit.common.approval.vo.FavoriteFormVO;
import kr.or.ddit.common.approval.vo.ReadingVO;
import kr.or.ddit.common.approval.vo.ReferenceVO;
import kr.or.ddit.common.approval.vo.SealVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class ApprovalController {

	@Resource(name = "localPath")
	private String localPath;

	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Inject
	private IAccountService accountService;

	@Inject
	private IApprovalService approvalService;
	
	@Inject
	private IAlarmService alarmService;

	@GetMapping("/approvalHome.do")
	public String approvalHome(Model model, Authentication authentication) {
		log.info("approvalHome 실행");
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		return "approval/approvalHome";
	}

	@GetMapping("/approvalList.do")
	public ResponseEntity<List<ApprovalVO>> getApprovalList(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);

		List<ApprovalVO> approvalList = approvalService.getApprovalList(memberVO.getMemNo());

		return new ResponseEntity<List<ApprovalVO>>(approvalList, HttpStatus.OK);
	}

	@GetMapping("/setApproval")
	public String setApproval(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		model.addAttribute("memberVO", memberVO);

		List<SealVO> sealList = approvalService.getSealList(memberVO.getMemNo());
		model.addAttribute("sealList", sealList);

		List<AgencyVO> agencyList = approvalService.getAgencyList(memberVO.getMemNo());
		model.addAttribute("agencyList", agencyList);

		List<MemberVO> deptMemList = approvalService.getDeptMemList(memberVO);
		model.addAttribute("deptMemList", deptMemList);
		System.out.println(deptMemList);
		return "approval/setting";
	}

	@PostMapping("/saveAbsence")
	public String saveAbsence(AgencyVO agencyVO) {
		approvalService.saveAbsence(agencyVO);
		return "redirect:/approval/setApproval";
	}

	@PostMapping("/register.do")
	public String register(@RequestParam("formNo") int formNo, @RequestParam("approvalLine") String approvalLineStr,
	        @RequestParam("referenceList") String referenceListStr, @RequestParam("readList") String readListStr,
	        Model model,Authentication authentication) {

		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
	    ApprovalFormVO approvalFormVO = approvalService.getApprovalForm(formNo);
	    ApprovalVO approvalVO = new ApprovalVO();
	    approvalVO.setFormNo(formNo);
	    approvalVO.setMemNo(memberVO.getMemNo());
	    approvalVO.setApprContent(approvalFormVO.getFormContent());
	    if(memberVO.getPosNo()>3&&memberVO.getPosNo()<=8) {
	    	approvalVO.setSecNo(memberVO.getPosNo()+2);
	    }else if(memberVO.getPosNo()<4){
	    	approvalVO.setSecNo(6);
	    }else {
	    	approvalVO.setSecNo(10);
	    }

	    approvalService.registerApproval(approvalVO);

	    String apprId = approvalVO.getApprId();

	    int i = 0;
	    // 결재라인이 비어 있지 않을 때만 처리
	    if (!approvalLineStr.isEmpty()) {
	        ApprovalLineMemberVO approvalLineMemberVO = new ApprovalLineMemberVO();
	        approvalLineMemberVO.setApprId(apprId);
	        for (String id : approvalLineStr.split(",")) {
	            i++;
	            approvalLineMemberVO.setMemNo(Integer.valueOf(id.trim()));
	            approvalLineMemberVO.setApprOrder(i);
	            approvalService.registerLine(approvalLineMemberVO);
	        }
	    }

	    // 참조 리스트가 비어 있지 않을 때만 처리
	    if (!referenceListStr.isEmpty()) {
	        ReferenceVO referenceVO = new ReferenceVO();
	        referenceVO.setApprId(apprId);
	        for (String id : referenceListStr.split(",")) {
	            referenceVO.setMemNo(Integer.valueOf(id.trim()));
	            approvalService.registerRef(referenceVO);
	        }
	    }

	    // 열람 리스트가 비어 있지 않을 때만 처리
	    if (!readListStr.isEmpty()) {
	        ReadingVO readingVO = new ReadingVO();
	        readingVO.setApprId(apprId);
	        for (String id : readListStr.split(",")) {
	            readingVO.setMemNo(Integer.valueOf(id.trim()));
	            approvalService.registerRead(readingVO);
	        }
	    }
	    ApprovalVO appr = approvalService.getApproval(approvalVO);
	    model.addAttribute("approvalVO", appr);
	    model.addAttribute("memberVO", memberVO);
	    return "approval/register";
	}


	@GetMapping("/getApprovalLine")
	public ResponseEntity<List<ApprovalLineMemberVO>> getApprovalLine(@RequestParam("apprId") String apprId) {

		List<ApprovalLineMemberVO> approvalLine = approvalService.getApprovalLine(apprId);
		log.info("결재라인:" + approvalLine);
		return new ResponseEntity<>(approvalLine, HttpStatus.OK);
	}

	@GetMapping("/getReferenceMemberList")
	public ResponseEntity<List<ReferenceVO>> getReferenceMemberList(@RequestParam("apprId") String apprId) {

		List<ReferenceVO> getReferenceMemberList = approvalService.getReferenceMemberList(apprId);
		log.info("결재라인:" + getReferenceMemberList);
		return new ResponseEntity<>(getReferenceMemberList, HttpStatus.OK);
	}

	@GetMapping("/getReadMemberList")
	public ResponseEntity<List<ReadingVO>> getReadMemberList(@RequestParam("apprId") String apprId) {

		List<ReadingVO> getReadMemberList = approvalService.getReadMemberList(apprId);
		log.info("결재라인:" + getReadMemberList);
		return new ResponseEntity<>(getReadMemberList, HttpStatus.OK);
	}
	
	@PostMapping("/cancelAppr")
	public ResponseEntity<String> cancelAppr(@RequestBody ApprovalVO approvalVO) {
		
		System.out.println("결재:"+approvalVO);
		approvalService.cancelAppr(approvalVO.getApprId());
		int res=approvalService.approvalSeal(approvalVO);
		String result="";
		if(res>0) {
			result="등록 성공";
		}else {
			result="등록 실패";
		}
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@PostMapping("/retryRegister")
	public String retryRegister(ApprovalVO approvalVO, Model model) {
		approvalVO = approvalService.getApproval(approvalVO);
		System.out.println("회수 결재:"+approvalVO);
		model.addAttribute("approvalVO", approvalVO);
		return "approval/register";
	}

	@PostMapping("/updateApprovalInfo")
	public ResponseEntity<String> updateApprovalInfo(@RequestParam("apprId") String apprId,
			@RequestParam("approvalLine") String approvalLine, @RequestParam("referenceList") String referenceList,
			@RequestParam("readList") String readList) {

		try {

			approvalService.deleteApprLineByApprId(apprId); // 결재 라인 삭제
			approvalService.deleteRefByApprId(apprId); // 참조자 삭제
			approvalService.deleteReadApprId(apprId); // 열람자 삭제
			// 결재라인 처리
			int order = 0;
			if (!approvalLine.isEmpty()) {
		        ApprovalLineMemberVO approvalLineMemberVO = new ApprovalLineMemberVO();
		        approvalLineMemberVO.setApprId(apprId);
		        for (String id : approvalLine.split(",")) {
		        	order++;
		            approvalLineMemberVO.setMemNo(Integer.valueOf(id.trim()));
		            approvalLineMemberVO.setApprOrder(order);
		            approvalService.registerLine(approvalLineMemberVO);
		        }
		    }

			if (!referenceList.isEmpty()) {
		        ReferenceVO referenceVO = new ReferenceVO();
		        referenceVO.setApprId(apprId);
		        for (String id : referenceList.split(",")) {
		            referenceVO.setMemNo(Integer.valueOf(id.trim()));
		            approvalService.registerRef(referenceVO);
		        }
		    }

		    // 열람 리스트가 비어 있지 않을 때만 처리
		    if (!readList.isEmpty()) {
		        ReadingVO readingVO = new ReadingVO();
		        readingVO.setApprId(apprId);
		        for (String id : readList.split(",")) {
		            readingVO.setMemNo(Integer.valueOf(id.trim()));
		            approvalService.registerRead(readingVO);
		        }
		    }

			return new ResponseEntity<>("성공", HttpStatus.OK);

		} catch (Exception e) {
			// 예외 발생 시 에러 메시지 반환
			return new ResponseEntity<>("오류 발생: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping("/updateAgencyLine")
	public ResponseEntity<String> updateAgencyLine(@RequestParam String apprId, @RequestParam String approvalLine) {
	    String[] approvalLineArray = approvalLine.split(",");

	    for (int i = 0; i < approvalLineArray.length; i++) {
	        ApprovalLineMemberVO approvalLineMemberVO = new ApprovalLineMemberVO(); // 매 반복마다 새 객체 생성
	        approvalLineMemberVO.setApprId(apprId);
	        approvalLineMemberVO.setApprOrder(i+1);
	        System.out.println("직원번호"+Integer.parseInt(approvalLineArray[i]));
	        approvalLineMemberVO.setMemNo(Integer.parseInt(approvalLineArray[i]));
	        
	        approvalService.updateApprLine(approvalLineMemberVO);
	    }

	    return ResponseEntity.ok("결재라인 업데이트 완료");
	}

	@PostMapping("/registerApproval")
	public String registerApproval(ApprovalVO approvalVO, Model model,Authentication authentication) {
		System.out.println("긴급:"+approvalVO.getApprImport());
		System.out.println("파일번호:"+approvalVO.getFileNo());
		if(approvalVO.getApprImport()==null) {
			approvalVO.setApprImport("N");
		}else if(approvalVO.getApprImport().equals("on")) {
			approvalVO.setApprImport("Y");
		}
		
		approvalService.updateAppr(approvalVO);
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		List<ApprovalLineMemberVO> apprLineList = approvalService.getApprovalLine(approvalVO.getApprId());
		AlarmVO alarm = new AlarmVO();
		AlarmBanVO alarmBanVO = new AlarmBanVO();
		List<AlarmVO> alarmList =new ArrayList<>();
		
		
		ApprovalLineMemberVO member = apprLineList.get(0);
			alarmBanVO.setMemNo(member.getMemNo());
			alarmBanVO.setTechCategory("전자결재");
			int cnt=alarmService.chkBanAlarm(alarmBanVO);
			if(cnt<=0) {
				alarm.setAlarmCategory("전자결재");
				alarm.setReceiverNo(member.getMemNo());
				alarm.setAlarmContent(MessageFormat.format("{0} 결재 차례가 되었습니다.", approvalVO.getApprTitle()));
				alarm.setAlarmUrl("/approval/detail.do?apprId="+approvalVO.getApprId());
				AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
				alarmList.add(insertedAlarm);
				if (alarmList.size()>0) {
					alarmService.sendNotificationToUsers(alarmList);
				}
			}
			
		return "redirect:/approval/detail.do?apprId=" + approvalVO.getApprId();
	}

	@GetMapping("/allApprList")
	public String allApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "전체 결재수신함");
		return "approval/approvalList";
	}

	@GetMapping("/waitingApprovalList")
	public String waitingApprovalList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "결재 대기함");
		return "approval/approvalList";
	}

	@GetMapping("/scheduledApprovalList")
	public String scheduledApprovalList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "결재 예정함");
		return "approval/approvalList";
	}

	@GetMapping("/processingApprovalList")
	public String processingApprovalList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "결재 처리함");
		return "approval/approvalList";
	}

	@GetMapping("/completedApprovalList")
	public String completedApprovalList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "결재 수신완료함");
		return "approval/approvalList";
	}

	@GetMapping("/importApprList")
	public String importApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "긴급");
		return "approval/approvalList";
	}

	@GetMapping("/allSendApprList")
	public String allSendApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "전체 결재발신함");
		return "approval/approvalList";
	}
	
	@GetMapping("/sendGoingApprList")
	public String sendGoingApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "결재 진행함");
		return "approval/approvalList";
	}

	@GetMapping("/sendReturnApprList")
	public String sendReturnApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		
		model.addAttribute("listType", "결재 반려함");
		return "approval/approvalList";
	}             

	@GetMapping("/sendCompletedApprList")
	public String sendCompletedApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "결재 발신완료함");
		return "approval/approvalList";
	}
	
	@GetMapping("/tempAppr")
	public String tempAppr(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("listType", "임시 보관함");
		return "approval/approvalList";
	}
	
	@GetMapping("/refApprList")
	public String refApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		model.addAttribute("memberVO", memberVO);
		List<ApprovalVO> refApprList = approvalService.refApprList(memberVO.getMemNo());
		System.out.println("ref:"+refApprList);
		model.addAttribute("refApprList", refApprList);
		return "approval/refApprList";
	}
	
	@GetMapping("/readApprList")
	public String readApprList(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		model.addAttribute("memberVO", memberVO);
		List<ApprovalVO> readApprList = approvalService.readApprList(memberVO.getMemNo());
		model.addAttribute("readApprList", readApprList);
		return "approval/readApprList";
	}
	
	@GetMapping("/favoriteForm.do")
	public String favoriteForm(Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		model.addAttribute("memberVO", memberVO);
		List<ApprovalFormVO> favoriteFormList = approvalService.getFavoriteFormList(memberVO.getMemNo());
		model.addAttribute("favoriteFormList", favoriteFormList);
		return "approval/favoriteFormList";
	}
	
	@GetMapping("/registerFavoriteForm")
	public ResponseEntity<String> registerFavoriteForm(@RequestParam("formNo") int formNo,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);
		FavoriteFormVO favoriteFormVO= new FavoriteFormVO();
		favoriteFormVO.setMemNo(memberVO.getMemNo());
		favoriteFormVO.setFormNo(formNo);
		int res =approvalService.registerFavoriteForm(favoriteFormVO);
		String result="";
		if(res>0) {
			result="등록 성공";
		}else {
			result="등록 실패";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@GetMapping("/formDetail.do")
	public String formDetail(int formNo, Model model) {
		ApprovalFormVO approvalFormVO = approvalService.getApprovalForm(formNo);
		model.addAttribute("approvalFormVO", approvalFormVO);
		return "approval/formDetail";
	}
	// 전자결재 상세
	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public String detail(String apprId, Model model,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		ApprovalVO approvalVO = new ApprovalVO();
		approvalVO.setApprId(apprId);
		approvalVO.setMemNo(memberVO.getMemNo());
		approvalVO = approvalService.getApproval(approvalVO);
		if(approvalVO.getApprStatus().equals("반려")) {
			ApprovalLineMemberVO approvalLineMemberVO= approvalService.getApprRsnWithMemberInfo(approvalVO.getApprId());
			log.info("반려 사유:"+approvalLineMemberVO.getApprRsn());
			approvalVO.setApprRsn(approvalLineMemberVO.getApprRsn());
			model.addAttribute("approvalLineMemberVO", approvalLineMemberVO);
		}
		model.addAttribute("approvalVO", approvalVO);
		model.addAttribute("memberVO", memberVO);
		log.info("전자결재:" + approvalVO);
		return "approval/detail";
	}

	@PostMapping("/registerSeal")
	public String registerSeal(SealVO sealVO, Model model) {
		String path = uploadPath;
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
		String sealImg = "";

		try {
			MultipartFile sealImgFile = sealVO.getSealImgFile();

			if (sealImgFile != null && sealImgFile.getOriginalFilename() != null
					&& !sealImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + sealImgFile.getOriginalFilename();
				path += "/" + fileName;
				log.info("업로드 패스:" + path);
				sealImgFile.transferTo(new File(path));
				sealImg = "/" + fileName;
			}
			sealVO.setSealImg(sealImg);
			log.info("직인:" + sealVO);
			approvalService.registerSeal(sealVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/approval/setApproval";
	}

	@GetMapping("/selSealUpdate")
	public String selSealUpdate(String sealImg,Authentication authentication, RedirectAttributes redirectAttributes) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		log.info("직인경로:" + sealImg);
		redirectAttributes.addFlashAttribute("seal","seal");
		SealVO sealVO = new SealVO();
		sealVO.setMemNo(memberVO.getMemNo());
		sealVO.setSealImg(sealImg);
		approvalService.selSealUpdate(sealVO);

		return "redirect:/approval/setApproval";
	}

	@GetMapping("/getSeal")
	public ResponseEntity<SealVO> getSeal(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);

		SealVO sealVO = approvalService.getSeal(memberVO.getMemNo());
		if (sealVO == null) {
			sealVO = new SealVO();
			sealVO.setSelImg("/resources/design/public/assets/img/seal/default.png");
		}
		return new ResponseEntity<SealVO>(sealVO, HttpStatus.OK);
	}

	@GetMapping("/approvalFormList")
	public ResponseEntity<List<ApprovalFormVO>> approvalFormList(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);

		List<ApprovalFormVO> approvalFormList = approvalService.approvalFormList();

		return new ResponseEntity<List<ApprovalFormVO>>(approvalFormList, HttpStatus.OK);
	}

	// 부서 목록 불러오기
	@GetMapping("/approvalDeptList")
	public ResponseEntity<List<DepartmentVO>> approvalDeptList(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);

		List<DepartmentVO> approvalDeptList = approvalService.approvalDeptList();

		return new ResponseEntity<List<DepartmentVO>>(approvalDeptList, HttpStatus.OK);
	}

	// 직원 목록 불러오기
	@GetMapping("/approvalMemList")
	public ResponseEntity<List<MemberVO>> approvalMemList(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		System.out.println("멤버:" + memberVO);

		List<MemberVO> approvalMemList = approvalService.approvalMemList();

		return new ResponseEntity<List<MemberVO>>(approvalMemList, HttpStatus.OK);
	}

	@PostMapping("/doApproval")
	public String approvalAgree(ApprovalVO approvalVO,Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		ApprovalLineMemberVO approvalLineMemberVO = new ApprovalLineMemberVO();
		approvalLineMemberVO.setApprId(approvalVO.getApprId());
		approvalLineMemberVO.setMemNo(memberVO.getMemNo());
		approvalLineMemberVO=approvalService.getApprovalLineMember(approvalLineMemberVO);
		approvalService.doApproval(approvalLineMemberVO);

		approvalService.approvalSeal(approvalVO);
		
		if(approvalVO.getApprStatus().equals("반려")) {
			approvalLineMemberVO.setApprRsn(approvalVO.getApprRsn());
			approvalService.updateRsn(approvalLineMemberVO);
		}
		
		approvalVO = approvalService.getApproval(approvalVO);
		
		AlarmVO alarm = new AlarmVO();
		AlarmBanVO alarmBanVO = new AlarmBanVO();
		int chk=0;
		List<AlarmVO> alarmList =new ArrayList<>();
		if(approvalVO.getApprStatus().equals("반려")||approvalVO.getApprStatus().equals("완료")) {
				alarmBanVO.setMemNo(approvalVO.getMemNo());
				alarmBanVO.setTechCategory("전자결재");
				chk=alarmService.chkBanAlarm(alarmBanVO);
				if(chk<=0) {
					alarm.setAlarmCategory("전자결재");
					alarm.setReceiverNo(approvalVO.getMemNo());
//					alarm.setAlarmContent(approvalVO.getApprTitle()+" 결재가 "+approvalVO.getApprStatus()+" 처리되었습니다.");
					alarm.setAlarmContent(MessageFormat.format("{0} 결재가 {1} 처리되었습니다.", approvalVO.getApprTitle(), approvalVO.getApprStatus()));
					alarm.setAlarmUrl("/approval/detail.do?apprId="+approvalVO.getApprId());
					AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
					alarmList.add(insertedAlarm);
					alarmService.sendNotificationToUsers(alarmList);
				}
		}else {
			approvalLineMemberVO.setApprOrder(approvalLineMemberVO.getApprOrder() + 1);

			System.out.println("세팅한No:" + approvalLineMemberVO.getApprOrder());
			ApprovalLineMemberVO nextMember = approvalService.getNextMember(approvalLineMemberVO);
			System.out.println("다음사람:" + nextMember);

			alarmBanVO.setMemNo(nextMember.getMemNo());
			alarmBanVO.setTechCategory("전자결재");
			chk = alarmService.chkBanAlarm(alarmBanVO);

			if(chk <= 0) {
			    alarm.setAlarmCategory("전자결재");
			    alarm.setReceiverNo(nextMember.getMemNo());
			    System.out.println("다음결재자No:" + nextMember.getMemNo());
			    alarm.setAlarmContent(MessageFormat.format("{0} 결재 차례가 되었습니다.", approvalVO.getApprTitle()));
			    alarm.setAlarmUrl("/approval/detail.do?apprId=" + approvalVO.getApprId());
			    AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
			    alarmList.add(insertedAlarm);
			    alarmService.sendNotificationToUsers(alarmList);
			}
		}
		return "redirect:/approval/detail.do?apprId="+approvalVO.getApprId();
	}
	
	@PostMapping("/registerVct")
	public ResponseEntity<String> registerVct(@RequestBody UseVacationVO useVacationVO) {
	    System.out.println("휴가 등록:" + useVacationVO);

	    // 1. 휴가 일수 계산 (USE_DT)
	    long useDt = ChronoUnit.DAYS.between(
	        LocalDate.parse(useVacationVO.getVctStart()),
	        LocalDate.parse(useVacationVO.getVctEnd())
	    ) + 1;
	    useVacationVO.setUseDt((int) useDt);

	    int chk = approvalService.chkVaction(useVacationVO);
	    if (chk <= 0) {
	        int res = approvalService.registerVct(useVacationVO);

	        if (res > 0) {
	            String vctDec = approvalService.getVacationDec(useVacationVO.getVctTypeNo());
	            System.out.println("등록 성공");
	            if ("Y".equals(vctDec)) {
	            	System.out.println("연차차감");
	            	approvalService.deductVacation(useVacationVO);
	            }

	            return new ResponseEntity<>("등록 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("등록 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    } else {
	        return new ResponseEntity<>("중복된 휴가가 존재합니다", HttpStatus.BAD_REQUEST);
	    }
	}
	

}
