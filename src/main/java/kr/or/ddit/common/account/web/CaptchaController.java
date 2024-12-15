package kr.or.ddit.common.account.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/account")
public class CaptchaController {
	
	@GetMapping("/createCaptcha.do")
	public ResponseEntity<Map<String, Object>> createCaptcha() throws IOException{
		
		String captchaKey = getKey();
		byte[] captchaImage = getImage(captchaKey);
		String captcahBase64Image = new String(Base64.getEncoder().encode(captchaImage));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("key", captchaKey);
		map.put("Base64Image", captcahBase64Image);
		
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	@PostMapping("/checkAnswer.do")
	public ResponseEntity<Boolean> captchaAnswer(@RequestBody CaptchaAnswer captchaAnswer){
		log.info("여기 옴");
		boolean result = getAnswer(captchaAnswer.getCaptchaKey(), captchaAnswer.getValue());
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	public String getKey() {
	    String clientId = "4HKDTsvJINH2Ti09oz4H"; // 애플리케이션 클라이언트 아이디값";
	    String clientSecret = "RqQfUq5DkN"; // 애플리케이션 클라이언트 시크릿값";
	    String captchaKey = "";
	    try {
	        String code = "0"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
	        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { // 정상 호출
	            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else {  // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	            response.append(inputLine);
	        }
	        br.close();
	        ObjectMapper objectMapper = new ObjectMapper();
	        CaptchaKey captchaKeyInfo = objectMapper.readValue(response.toString(), CaptchaKey.class);
	        captchaKey = captchaKeyInfo.getKey();
	        log.info("captchaKey : " + captchaKey);
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return captchaKey;
	}
	
	public byte[] getImage(String captchaKey) throws IOException {
	    String clientId = "4HKDTsvJINH2Ti09oz4H";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "RqQfUq5DkN";//애플리케이션 클라이언트 시크릿값";
	    byte[] entity = null;
	    InputStream is = null;
	    try {
	        String key = captchaKey; // https://openapi.naver.com/v1/captcha/nkey 호출로 받은 키값
	        String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key;
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { // 정상 호출
	            is = con.getInputStream();
	        } else {  // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            String inputLine;
	            StringBuffer response = new StringBuffer();
	            while ((inputLine = br.readLine()) != null) {
	                response.append(inputLine);
	            }
	            br.close();
	        }
	        entity = IOUtils.toByteArray(is);
	    } catch (Exception e) {
	        log.debug("error : " + e);
	    }
	    finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	    return entity;
	}
	
	public boolean getAnswer(String captchaKey, String value) {
	    String clientId = "4HKDTsvJINH2Ti09oz4H";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "RqQfUq5DkN";//애플리케이션 클라이언트 시크릿값";
	    boolean answer = false;
	    try {
	        String code = "1"; // 키 발급시 0,  캡차 이미지 비교시 1로 세팅
	        String key = captchaKey; // 캡차 키 발급시 받은 키값
	        // value : 사용자가 입력한 캡차 이미지 글자값
	        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code +"&key="+ key + "&value="+ value;

	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("X-Naver-Client-Id", clientId);
	        con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { // 정상 호출
	            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else {  // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	            response.append(inputLine);
	        }
	        br.close();
	        if (response.toString().contains("true")) {
				answer = true;
			}
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return answer;
	}
}

@Data
class CaptchaKey{
	private String key;
}

@Data
class CaptchaAnswer{
	private String captchaKey;
	private String value;
}

@Data
class CaptchaResult{
	private String result;
}
