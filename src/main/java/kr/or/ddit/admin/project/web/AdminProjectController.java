package kr.or.ddit.admin.project.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.mail.web.AdminMailController;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminProjectController {

	@GetMapping("/project")
	public String mailStatistics() {
		return "admin/project/projectAdmin";
	}
}
