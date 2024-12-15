package kr.or.ddit.common.account.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.security.SecureRandom;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeWriter;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.LogVO;
import kr.or.ddit.common.account.vo.MemberAuthVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.OtpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/account")
public class AccountController {
	
	private static final char[] rndAllCharacters = new char[]{
	        //number
	        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	        //uppercase
	        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	        //lowercase
	        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	        //special symbols
	        '@', '$', '!', '%', '*', '?', '&'
	};
	
	@Inject
	private PasswordEncoder pe;
	
	@Inject
	private IAccountService accountService;
	
	@Autowired
	private JavaMailSenderImpl mailSender;

	@GetMapping("/login.do")
	public String login() {
		return "account/login";
	}
	
	@PostMapping("/loginCheck.do")
	public ResponseEntity<MemberVO> loginCheck(@RequestBody MemberVO member){
		MemberVO dbmember = accountService.loginCheck(member);
		if (dbmember != null) {
			boolean result = pe.matches(member.getMemPw(), dbmember.getMemPw());
			if (result) {
				member = dbmember;
			}else {
				member = null;
			}
		}else {
			member = null;
		}
		return new ResponseEntity<MemberVO>(member, HttpStatus.OK);
	}
	
	@GetMapping("/logout.do")
	public String logoutForm() {
		return "account/logout";
	}
	
	@GetMapping("/findId.do")
	public String findIdForm() {
		return "account/findId";
	}
	
	@PostMapping("/findId.do")
	public String findId(MemberVO member, Model model) {
		
		MemberVO result = accountService.findId(member);
		
		if (result != null) {
			String fmtDate = result.getHireDate().substring(0,10);
			model.addAttribute("memId", result.getMemId());
			model.addAttribute("hireDate", fmtDate);
		}else {
			model.addAttribute("error", "일치하는 정보가 없습니다.");
		}
		
		return "account/idResult";
	}
	
	@GetMapping("/findPw.do")
	public String findPwForm() {
		return "account/findPw";
	}
	
	@PostMapping("/findPw.do")
	public String findPw(MemberVO member, Model model) {
		
		MemberVO result = accountService.findId(member);
		if (result == null) {
			model.addAttribute("error", "일치하는 정보가 없습니다.");
			return "account/pwResult";
		}else {
			
			log.info("전달 받은 이메일 주소 : " + member.getMemEmail());
			
			String tempPass = getRandomPassword(10);
			result.setTempPwYn("Y");
			result.setMemPw(pe.encode(tempPass));
			accountService.tempPass(result);
			
			//이메일 보낼 양식
			String setFrom = "ha1eyk513@naver.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
			String toMail = result.getMemEmail();
			String title = "회원가입 인증 이메일 입니다.";
			String content = "인증 코드는 " + tempPass + " 입니다." +
							 "<br>" +
							 "해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	            helper.setFrom(setFrom);
	            helper.setTo(toMail);
	            helper.setSubject(title);
	            helper.setText(content, true);
	            mailSender.send(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("email", result.getMemEmail());
			return "account/sendEmail";
		}
	}
	
	@GetMapping("/changePw.do")
	public String changePwForm() {
		return "account/changePw";
	}
	
	@PostMapping("/changePw.do")
	public String changePw(String memPw, Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = accountService.getMember(user.getUsername());
		memberVO.setMemPw(pe.encode(memPw));
		memberVO.setTempPwYn("N");
		accountService.changePw(memberVO);
		return "redirect:/";
	}
	
	public String getRandomPassword(int length) {
        StringBuffer sb = new StringBuffer();
        SecureRandom sr = new SecureRandom();
        sr.setSeed(new Date().getTime());

        int idx = 0;
        int len = rndAllCharacters.length; // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
	    for (int i = 0; i < length; i++) {
	    	idx = sr.nextInt(len);
	    	sb.append(rndAllCharacters[idx]);
	    }

	    String randomPassword = sb.toString();

	    // 최소 8자리에 대문자, 소문자, 숫자, 특수문자 각 1개 이상 포함
	    String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}";
	    if (!Pattern.matches(pattern, randomPassword)) {
	        return getRandomPassword(length);    //비밀번호 조건(패턴)에 맞지 않는 경우 메서드 재실행
	    }
	    return randomPassword;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/myPage.do")
	public String myPage(Authentication authentication, Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		model.addAttribute("member", member);
		
		return "home/myPage";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/checkMemberAuth.do")
	public ResponseEntity<String> checkMemberAuth(Authentication authentication, Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		List<MemberAuthVO> authList = accountService.checkMemberAuth(member);
		for (MemberAuthVO memberAuthVO : authList) {
			if (memberAuthVO.getMemAuth().equals("ROLE_ADMIN")) {
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}
		return new ResponseEntity<String>("FAIL", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/otpLogin.do")
	public String otpLogin() {
		return "account/adminLogin";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/checkOTP.do")
	public ResponseEntity<String> checkOTP(@RequestBody OtpVO otpVO, Authentication authentication, HttpServletRequest request) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		OTPUtil otpUtil = new OTPUtil();
		
		MemberAuthVO memberAuthVO = accountService.getSecretKey(member);
		
		String generatedOTP = otpUtil.getTOTPCode(memberAuthVO.getSecretkey());
		
		if (generatedOTP.equals(otpVO.getOtpCode())) {
			
			LogUtil logUtil = new LogUtil();
	        String ipAddress = logUtil.getClientIpAddr(request);
	        String userAgent = request.getHeader("User-Agent");
	        String operatingSystem = logUtil.getOperatingSystem(userAgent);
	        String browser = logUtil.getBrowser(userAgent);
	        
	        LogVO logVO = new LogVO(ipAddress, member.getMemNo(), "로그인", "ADMIN", browser, operatingSystem);
	        
	        accountService.insertUserLoginLog(logVO);
			
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		return new ResponseEntity<String>("FAIL", HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@GetMapping("/logoutLog.do")
	public String logoutLog(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		LogUtil logUtil = new LogUtil();
		LogVO logVO = null;
		
        String ipAddress = logUtil.getClientIpAddr(request);
        String userAgent = request.getHeader("User-Agent");
        String operatingSystem = logUtil.getOperatingSystem(userAgent);
        String browser = logUtil.getBrowser(userAgent);
        
        String referer = (String)request.getHeader("REFERER");
        
        if (referer.contains("admin")) {
        	logVO = new LogVO(ipAddress, member.getMemNo(), "로그아웃", "USER, ADMIN", browser, operatingSystem);
		}else {
			logVO = new LogVO(ipAddress, member.getMemNo(), "로그아웃", "USER", browser, operatingSystem);
		}
        
        accountService.insertUserLoginLog(logVO);
		
		return "redirect:/account/logout.do";
	}
	
	@PostMapping("/createMemberQRCode")
    public ResponseEntity<MemberVO> createMemberQRCode(@RequestBody MemberVO memberVO, HttpServletRequest req) throws WriterException, IOException {
    	
    	// JSON을 MemberVO 객체로 변환
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(memberVO);

        String uploadDir = req.getServletContext().getRealPath("") + File.separator + "qrCode";
        String filePath = uploadDir + File.separator + "memberQrCode.png";
        
        File directory = new File(uploadDir);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        // UTF-8을 ISO-8859-1로 디코딩
        BitMatrix bitMatrix = qrCodeWriter.encode(new String(json.getBytes("UTF-8"), "ISO-8859-1"), BarcodeFormat.QR_CODE, 350, 350);

        Path path = FileSystems.getDefault().getPath(filePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

        return new ResponseEntity<MemberVO>(memberVO, HttpStatus.OK);  
    }
	
	@ResponseBody
	@GetMapping("/memberQrCodeImage")
	public ResponseEntity<byte[]> qrCodeImage(HttpServletRequest req) throws IOException{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String path = req.getServletContext().getRealPath("/qrCode/memberQrCode.png");
		
		in = new FileInputStream(path);
		entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@GetMapping(value = "/memberQrCodeValue", produces = "text/plain; charset=UTF-8") // ISO-8859-1로 디코딩 된 데이터를 UTF-8로 인코딩
	public ResponseEntity<String> qrCodeValue(HttpServletRequest req){
		ResponseEntity<String> entity = null;
		String path = req.getServletContext().getRealPath("/qrCode/memberQrCode.png");
        try {
        	BufferedImage bufferedImage = ImageIO.read(new File(path));

        	// 이미지를 LuminanceSource로 변환하여 밝기 정보 추출
        	LuminanceSource luminanceSource = new BufferedImageLuminanceSource(bufferedImage);

        	// 밝기 정보를 이진화(Binarization)하여 BinaryBitmap에 저장
        	BinaryBitmap binaryBitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));

        	// BinaryBitmap의 이진 데이터를 분석하여 QR 코드를 디코딩하여 Result 객체에 저장
        	Result result = new MultiFormatReader().decode(binaryBitmap);
        	
        	entity = new ResponseEntity<String>(result.getText(), HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return entity;
	}
}