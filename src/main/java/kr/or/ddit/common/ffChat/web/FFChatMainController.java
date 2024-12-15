package kr.or.ddit.common.ffChat.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.velocity.runtime.directive.Parse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kong.unirest.HttpResponse;
import kong.unirest.Unirest;
import kong.unirest.json.JSONArray;
import kong.unirest.json.JSONObject;
import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.ffChat.service.IFFChatMainService;
import kr.or.ddit.common.ffChat.vo.VideoChatVO;
import kr.or.ddit.common.ffChat.vo.VideochatRoomMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ffChat")
public class FFChatMainController {
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IFFChatMainService ffchatService;

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping("/main")
	public String main(Authentication authen, Model model) {
		log.info("ffChat main 진입");
		
		User user = (User) authen.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		
		return "ffChat/ffChatHome";
	}
	
	// 방 만들기
	// 클라이언트에서 받은 정보를 쿼리스트링으로 변환하여 API주소로 정보를 보낸다.
	// 응답으로 받은 내용(room url id)을 DB에 저장한다.
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/room")
	public ResponseEntity<String> grmRoomOpen(@RequestBody Map<String, String> queryMap){
		
		String query = "";
		Iterator<String> it = queryMap.keySet().iterator();
		// 쿼리스트링 변환기
		while(it.hasNext()) {
			String key = it.next();
			System.out.println(key);
			if(key.equals("maxJoinCount")) {
				continue;
			}
			if(queryMap.get(key).contains(" ")) {
				queryMap.put(key, queryMap.get(key).replaceAll(" ", "%20"));
				queryMap.put(key, queryMap.get(key).replaceAll(":", "%3A"));
				queryMap.put(key, queryMap.get(key).replace("+", "%2B"));
			}
			query += "&" + key + "=" + queryMap.get(key);
		}
		
		HttpResponse<String> response = Unirest.post("https://openapi.gooroomee.com/api/v1/room")
				  .header("accept", "application/json")
				  .header("content-type", "application/x-www-form-urlencoded")
				  .header("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				  .body("callType=P2P&liveMode=true&maxJoinCount="+ queryMap.get("maxJoinCount") +"&liveMaxJoinCount=100&layoutType=4&sfuIncludeAll=true" + query)
				  .asString();
		// UniRest의 JSON관련 클래스 활용
		// 응답으로 받은 urlid를 db에 저장
		JSONObject jsonObject = new JSONObject(response.getBody());
		String roomId = jsonObject.getJSONObject("data").getJSONObject("room").getString("roomId");
		ffchatService.create(new VideoChatVO(queryMap.get("roomTitle"), queryMap.get("passwd"), roomId));
		
		it = queryMap.keySet().iterator();
		while(it.hasNext()) {
			String key = it.next();
			if(key.equals("selectedMem")) {
				System.out.println(queryMap.get(key));
				String[] mems = queryMap.get(key).split(",");
				for(int i = 0; i < mems.length; i++) {
					ffchatService.invite(new VideochatRoomMemberVO(roomId,Integer.parseInt(mems[i])));
				}
			}
		}
		return new ResponseEntity<String>(response.getBody(), HttpStatus.OK);
		
	}
		
	// 방 리스트 가져오기
	// 리스트를 DB에서 가져와 JSON스트링의 형태로 응답해준다.
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/list/{id}")
	public ResponseEntity<String> grmRoomList(@PathVariable String id) {
		
		List<VideoChatVO> list = ffchatService.videoChatList(id);
		List<List<VideoChatVO>> chatList = new ArrayList<List<VideoChatVO>>();
		for (VideoChatVO listVO : list) {
			chatList.add(ffchatService.videoChatListByName(listVO));
		}
		// UniRest의 JSON관련 클래스 활용
		JSONArray jsonArray = new JSONArray(chatList);
				
		return new ResponseEntity<String>(jsonArray.toString(), HttpStatus.OK);
	}
	
	// 방 종료
	@GetMapping("/close/{id}")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public ResponseEntity<String> grmRoomClose(@PathVariable String id) {
		
		System.out.println(id);
		
		HttpResponse<String> response = Unirest.delete("https://openapi.gooroomee.com/api/v1/room/" + id )
				  .header("accept", "application/json")
				  .header("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				  .asString();
		
		ffchatService.closeRoom(id);
		
		return new ResponseEntity<String>(response.getBody(), HttpStatus.OK);
	}
	
	// 방 이름 중복체크
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/check/{title}")
	public int isTitleExist(@PathVariable String title) {
		
		int cnt = ffchatService.isTitleExist(title);
		
		return cnt;
	}
}
