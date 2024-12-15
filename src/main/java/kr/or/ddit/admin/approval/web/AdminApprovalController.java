package kr.or.ddit.admin.approval.web;

import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.admin.approval.service.IAdminApprovalService;
import kr.or.ddit.common.approval.service.IApprovalService;
import kr.or.ddit.common.approval.vo.ApprovalFormVO;
import kr.or.ddit.common.approval.vo.ApprovalVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/approval")
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class AdminApprovalController {
	
	@Inject
	private IAdminApprovalService adminApprovalService;
	
	@Inject
	private IApprovalService approvalService;
	
	
	
	@GetMapping("/approvalFormList")
	public String approvalHome(Model model) {
		
		List<ApprovalFormVO> approvalFormList = adminApprovalService.getApprFormList();
		System.out.println("전자결재 양식리스트:"+approvalFormList);
		model.addAttribute("approvalFormList", approvalFormList);
		return "admin/approval/approvalFormList";
	}
	
	@GetMapping("/chart")
	public String dateByChart() {
		return "admin/approval/chart";
	}
	
	@GetMapping("/createForm")
	public String createForm() {
		return "admin/approval/createForm";
	}
	
	@PostMapping("/createForm")
	public String registerForm(ApprovalFormVO approvalFormVO) {
		
		System.out.println("양식이름:"+approvalFormVO.getFormTitle());
		adminApprovalService.registerApprForm(approvalFormVO);
		return "redirect:/admin/approval/approvalFormList";
	}
	
	@GetMapping("/formDetail.do")
	public String formDetail(int formNo, Model model) {
		
		ApprovalFormVO approvalFormVO = approvalService.getApprovalForm(formNo);
		model.addAttribute("approvalFormVO", approvalFormVO);
		System.out.println(approvalFormVO);
		return "admin/approval/detail";
	}
	
	@GetMapping("/update.do")
	public String updateForm(int formNo, Model model) {
		
		ApprovalFormVO approvalFormVO = approvalService.getApprovalForm(formNo);
		model.addAttribute("approvalFormVO", approvalFormVO);
		model.addAttribute("status", "u");
		return "admin/approval/createForm";
	}
	
	@PostMapping("/update.do")
	public String update(ApprovalFormVO approvalFormVO) {
		adminApprovalService.updateForm(approvalFormVO);
		System.out.println("제목:"+approvalFormVO.getFormTitle());
		System.out.println("번호:"+approvalFormVO.getFormNo());
		System.out.println("카테고리:"+approvalFormVO.getFormCategory());
		System.out.println("내용:"+approvalFormVO.getFormContent());
		return "redirect:/admin/approval/approvalFormList";
	}
	
	@GetMapping("/delete.do")
	public String delete(int formNo, Model model) {
		
		adminApprovalService.deleteForm(formNo);
		return "redirect:/admin/approval/approvalFormList";
	}
	
	@PostMapping("/fetchApprovalStatistics")
    public ResponseEntity<Map<String, Object>> fetchApprovalStatistics(
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam String deptNo) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("deptNo", deptNo);
		
		System.out.println("시작기간:"+startDate);
		System.out.println("종료기간:"+endDate);
		System.out.println("부서번호:"+deptNo);
		// 양식 사용 통계 조회
		List<ApprovalFormVO> formUsage = adminApprovalService.getApprovalStatistics(map);
		// 결재 상태 통계 조회
        List<Map<String, Object>> statusCounts = adminApprovalService.getApprovalStatusCounts(map);
        
        
        System.out.println("양식 사용 통계:"+formUsage);
        System.out.println("결재 상태 통계:"+statusCounts);
        Map<String, Object> response = new HashMap<>();
        response.put("formUsage", formUsage);
        response.put("statusCounts", statusCounts);
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
	
	@PostMapping("/excelDown")
	public ResponseEntity<InputStreamResource> excelDown(@RequestParam Map<String, String> params) throws Exception {
	    ByteArrayInputStream excelFile = adminApprovalService.generateApprovalStatusExcel(params);

	    String fileName = "승인_통계목록";
	    String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");

	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Disposition", "attachment;filename=" + outputFileName + ".xlsx");

	    return ResponseEntity.ok()
	            .headers(headers)
	            .contentType(MediaType.APPLICATION_OCTET_STREAM)
	            .body(new InputStreamResource(excelFile));
	}
	
}
