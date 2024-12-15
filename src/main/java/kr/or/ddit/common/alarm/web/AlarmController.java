package kr.or.ddit.common.alarm.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmVO;
import kr.or.ddit.common.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notification")
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class AlarmController {
    @Inject
    private IAlarmService alarmService;
    
    @Inject
	private IAccountService accountService;

    @GetMapping("/alarm")
    public SseEmitter streamNotifications(HttpSession session, HttpServletResponse response, Authentication authentication) {
    	
        // 응답 헤더 설정
        response.setContentType("text/event-stream; charset=UTF-8"); // UTF-8 인코딩 설정
        response.setCharacterEncoding("UTF-8"); // UTF-8 인코딩 설정

        User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
        SseEmitter emitter = new SseEmitter(60 *60* 1000L);	// 유지시간 설정

        // 사용자별 emitter 등록
        alarmService.registerEmitter(memberVO.getMemNo(), emitter);

        return emitter;
    }
    
    
    
    @GetMapping("/alarmList")
    public String alarmAllList() {
        log.info("alarmAllList 실행");
        return "home/notification";
    }
    
    @GetMapping("/unreadCount")
	public ResponseEntity<Integer> unreadCount(Authentication authentication) {
    	User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());

        int unreadCnt= alarmService.getUnreadAlarmCount(memberVO.getMemNo());
		return new ResponseEntity<>(unreadCnt, HttpStatus.OK);
	}
    
    @GetMapping("/readNotification")
    public ResponseEntity<String> readNotification(@RequestParam("alarmNo") int alarmNo) {
    	AlarmVO alarmVO = alarmService.getAlarm(alarmNo);
    	int cnt= alarmService.readNotification(alarmVO);
    	String result="";
    	if(cnt>0) {
    		result="성공";
    	}else {
    		result="실패";
    	}
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @GetMapping("/markAllAsRead")
    public ResponseEntity<String> markAllAsRead(Authentication authentication) {
    	User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
    	int cnt= alarmService.markAllAsRead(memberVO.getMemNo());
    	String result="";
    	if(cnt>0) {
    		result="성공";
    	}else {
    		result="실패";
    	}
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @PostMapping("/deleteNotification")
    public ResponseEntity<String> deleteNotification(@RequestParam("alarmNo") int alarmNo) {
        int cnt = alarmService.deleteNotification(alarmNo);
        
        String result;
        if (cnt > 0) {
            result = "삭제 성공";
        } else {
            result = "삭제 실패";
        }
        
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @GetMapping("/alarmOption")
    public String alarmOption(Model model, Authentication authentication) {
    	User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
        model.addAttribute("memberVO", memberVO);
    	return "home/alarmOption";
    }
    
    @PostMapping("/alarmOption/save")
    public String alarmOptionRegister(Model model, Authentication authentication) {
    	User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
        model.addAttribute("memberVO", memberVO);
    	return "home/alarmOption";
    }
    
    @GetMapping("/notificationList")
	public ResponseEntity<List<AlarmVO>> notificationList(Authentication authentication) {
    	User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
        
        List<AlarmVO> notificationList = alarmService.notificationList(memberVO.getMemNo());
        
		return new ResponseEntity<>(notificationList, HttpStatus.OK);
	}
    
}
