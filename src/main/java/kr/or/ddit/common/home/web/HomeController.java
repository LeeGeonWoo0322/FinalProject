package kr.or.ddit.common.home.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.approval.service.IApprovalService;
import kr.or.ddit.common.approval.vo.ApprovalVO;
import kr.or.ddit.common.attend.service.IAttendanceService;
import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.board.service.BoardService;
import kr.or.ddit.common.board.vo.BoardVO;
import kr.or.ddit.common.calendar.vo.ScheduleVO;
import kr.or.ddit.common.home.service.IHomeService;
import kr.or.ddit.common.mail.service.IMailService;
import kr.or.ddit.common.mail.vo.MailBoxVO;
import kr.or.ddit.common.mail.vo.MailRecipientVO;
import kr.or.ddit.common.project.service.IProjectService;
import kr.or.ddit.common.todoList.service.IToDoListService;
import kr.or.ddit.common.todoList.vo.ToDoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	@Inject
	private IToDoListService todoService;
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IHomeService homeService;
	
	@Inject
	private IAttendanceService attendService;
	
	@Inject
	private IMailService mailService;
	
	@Inject
	private IApprovalService approvalService;
	@Inject
	private BoardService boardService;
	
	@Inject
	private IProjectService proService;
	
	@RequestMapping("/")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String main(Authentication authentication, Model model) {

		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		// 오늘 일정 데이터 가져오기
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setDeptNo(member.getDeptNo());
		scheduleVO.setStartDate(today.format(formatter));
		
		List<ScheduleVO> scheduleList = homeService.getScheduleList(scheduleVO);
		
		// 받은메일함 정보 가져오기
		PaginationInfoVO<MailRecipientVO> pagingVO = new PaginationInfoVO<MailRecipientVO>(10,5);
		pagingVO.setMemNo(member.getMemNo());
		pagingVO.setKeyword(1);
		List<MailRecipientVO> dataList = mailService.selectRecMailList(pagingVO);
		pagingVO.setDataList(dataList);
		
		// 커스텀 메일함 가져오기
		List<MailBoxVO> mailBoxList = mailService.getMailBoxList(member);
		
		// 결재 대기 문서 5개만 가져오기
		List<ApprovalVO> apprList = approvalService.getWaitingApprovalList(member.getMemNo());
		
		// board에 공지만 가져오기
		List<BoardVO> result = boardService.homeNoticeList();
		log.info("homeboardlist::" + result);
		
		
		List<ToDoVO> todoVO = todoService.homeTodo(member.getMemNo());
		Map<String,Object> pro = proService.homeProjectList(member.getMemNo());
		model.addAttribute("pro",pro);
		System.out.println("pro              :"+pro);
		model.addAttribute("todoVO",todoVO);
		
		model.addAttribute("boardList", result);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("mailBoxList", mailBoxList);
		model.addAttribute("scheduleList", scheduleList);
		model.addAttribute("member", member);
		model.addAttribute("apprList", apprList);
		
		return "home/main";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getMyScheduleList.do")
	public ResponseEntity<List<Map<String, Object>>> getMyScheduleList(Authentication authentication){

		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Map<String, Object>> events = new ArrayList<Map<String,Object>>();

		List<ScheduleVO> myScheduleList = homeService.getMyScheduleList(member);
		
		for (ScheduleVO scheduleVO : myScheduleList) {
			Map<String, Object> event = new HashMap<String, Object>();
			event.put("id", scheduleVO.getSchdlNo());
			event.put("title", scheduleVO.getSchdlName());
			event.put("description", scheduleVO.getSchdlContent());
			event.put("start", scheduleVO.getStartDate() + "T" + scheduleVO.getStartTime());
			event.put("end", scheduleVO.getEndDate() + "T" + scheduleVO.getEndTime());
			events.add(event);
		}
		
		return new ResponseEntity<List<Map<String, Object>>>(events, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/getScheduleList.do")
	public ResponseEntity<List<ScheduleVO>> getScheduleList(@RequestBody ScheduleVO scheduleVO, Authentication authentication){
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		scheduleVO.setDeptNo(member.getDeptNo());
		
		List<ScheduleVO> scheduleList = homeService.getScheduleList(scheduleVO);
		
		return new ResponseEntity<List<ScheduleVO>>(scheduleList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/getMailboxList.do")
	public ResponseEntity<List<MailRecipientVO>> getMailboxList(@RequestBody MailBoxVO mailBoxVO, Authentication authentication){
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		boolean errorExist = false;
		
		PaginationInfoVO<MailRecipientVO> pagingVO = new PaginationInfoVO<MailRecipientVO>(10,5);
		pagingVO.setMemNo(member.getMemNo());
		pagingVO.setKeyword(mailBoxVO.getMailboxRowNo());
		mailBoxVO = mailService.getMailBoxNo(pagingVO);
		if (mailBoxVO == null) {
			errorExist = true;
		}else {
			pagingVO.setMailboxNo(mailBoxVO.getMailboxNo());
		}
		pagingVO.setKeyword(mailBoxVO.getMailboxRowNo()+100);
		
		List<MailRecipientVO> dataList = mailService.selectRecMailList(pagingVO);
		
		return new ResponseEntity<List<MailRecipientVO>>(dataList, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/glWorkTime", method = RequestMethod.POST)
	public ResponseEntity<AttendanceVO>  glWorkTime(@RequestBody AttendanceVO attendance){
		AttendanceVO res = attendService.glWorkTime(attendance);
		return new ResponseEntity<AttendanceVO>(res,HttpStatus.OK);
	}
	
	@PostMapping("/createUrlQRCode")
	 public String createQrCode(@RequestParam String url, HttpServletRequest req) throws WriterException, IOException {

    String uploadDir = req.getServletContext().getRealPath("") + File.separator + "qrCode";
    String filePath = uploadDir + File.separator + "qrCode.png";
 
        File directory = new File(uploadDir);
	 	if (!directory.exists()) {
	 		directory.mkdirs();
	 	}

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(url, BarcodeFormat.QR_CODE, 350, 350);
        // Path 
	    Path path = FileSystems.getDefault().getPath(filePath);
	    MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

	    return "urlQRCode";
	 }
}
