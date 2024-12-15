package kr.or.ddit.admin.board.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.mail.web.AdminMailController;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.access.prepost.PreAuthorize;

@Slf4j
@Controller
@RequestMapping("/admin/board")
public class AdminBoardController {
	
	
	@GetMapping("/main")
	public String boardMain() {
		return "admin/board/main";
	}
	
	@GetMapping("/statistics")
	public String boardStatistics() {
		return "admin/board/statistics";
	}
	
	@GetMapping("/create")
	public String boardCreate() {
		return "admin/board/create";
	}
	
	@GetMapping("/modify")
	public String boardModify() {
		return "admin/board/modify";
	}


}
