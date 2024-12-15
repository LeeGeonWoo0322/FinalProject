package kr.or.ddit.common.security.web;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.LogVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.web.LogUtil;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	private static final Logger log = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Inject
	private IAccountService accountService;
	
	// 로그인 성공 후 처리할 처리자
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("CustomLoginSuccessHandler:onAuthenticationSuccess() 실행...!");
		
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.tempPassCheck(user.getUsername());
		LogUtil logUtil = new LogUtil();
		
		// 인증 시 발생하는 에러 정보들이 session에 저장되어 있는데 해당 에러들을 지운다. (Optional)
		clearAuthenticationAttribute(request);
		
        // 클라이언트 IP 주소, User-Agent 정보 얻기
        String ipAddress = logUtil.getClientIpAddr(request);
        log.info("ip:"+ipAddress);
        String userAgent = request.getHeader("User-Agent");
        String operatingSystem = logUtil.getOperatingSystem(userAgent);
        String browser = logUtil.getBrowser(userAgent);
        
        LogVO logVO = new LogVO(ipAddress, memberVO.getMemNo(), "로그인", "USER", browser, operatingSystem);
        
        accountService.insertUserLoginLog(logVO);
		
		// 타겟정보가 존재한다면 타겟으로 이동하고
		// 타겟정보가 존재하지 않을때에는 '/'로 이동
		// 타겟이 없을 때 : 보호할 자원으로의 요청을 하지 않았을 때, 즉 단순히 로그인 페이지에서 접속 정보 입력 후 로그인 요청했을 때
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		String targetUrl = "/";
		if (savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl();	// 보호할 자원으로 이동할 타겟정보
		}
		if (memberVO.getTempPwYn().equals("Y")) {
			targetUrl = "/account/changePw.do";
		}
		log.info("targetUrl : " + targetUrl);
		response.sendRedirect(targetUrl);
	}

	private void clearAuthenticationAttribute(HttpServletRequest request) {
		// session 정보가 존재한다면 현재 session을 반환하고 존재하지 않으면 null을 반환합니다.
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		
		// SPRING_SECURITY_LAST_EXCEPTION 
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
	

}
