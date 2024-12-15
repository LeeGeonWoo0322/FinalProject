package kr.or.ddit.common.reservation.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.reservation.service.IReservationService;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;
import kr.or.ddit.common.reservation.vo.ReservationAttendeeVO;
import kr.or.ddit.common.reservation.vo.ReservationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	@Inject
	IReservationService reservationService;
	
	@Inject
	IAccountService accountService;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/main")
	public String main(Authentication authentication, Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername()); 
		
		List<AssetCategoryVO> assetCategoryList = reservationService.getAssetCategoryList();
		List<List<AssetVO>> assetListArray = new ArrayList<List<AssetVO>>();
		for (AssetCategoryVO assetCategoryVO : assetCategoryList) {
			List<AssetVO> assetList = reservationService.getAssetList(assetCategoryVO);
			assetListArray.add(assetList);
		}
		List<ReservationVO> myReservationList = reservationService.getMyReservation(member);
		
		model.addAttribute("myReservationList", myReservationList);
		model.addAttribute("assetCategoryList", assetCategoryList);
		model.addAttribute("assetListArray", assetListArray);
		model.addAttribute("member", member);
		
		return "reservation/main";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/gridWeek")
	public String detail(Authentication authentication, int astNo, Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername()); 
		
		List<AssetCategoryVO> assetCategoryList = reservationService.getAssetCategoryList();
		List<List<AssetVO>> assetListArray = new ArrayList<List<AssetVO>>();
		for (AssetCategoryVO assetCategoryVO : assetCategoryList) {
			List<AssetVO> assetList = reservationService.getAssetList(assetCategoryVO);
			assetListArray.add(assetList);
		}
		List<ReservationVO> myReservationList = reservationService.getMyReservation(member);
		
		AssetVO assetVO = reservationService.getAssetByAstNo(astNo);
		AssetCategoryVO assetCategoryVO = reservationService.getAssetCategoryByAsset(assetVO);
		
		model.addAttribute("myReservationList", myReservationList);
		model.addAttribute("assetCategoryList", assetCategoryList);
		model.addAttribute("assetListArray", assetListArray);
		model.addAttribute("member", member);
		model.addAttribute("assetCategoryVO", assetCategoryVO);
		model.addAttribute("assetVO", assetVO);
		
		return "reservation/gridWeek";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/getAssetTimeLine.do")
	public ResponseEntity<List<Object>> getAssetTimeLine(@RequestBody AssetCategoryVO assetCategoryVO){
		
		List<Object> assetInfo = new ArrayList<Object>();
		
		assetInfo.add(reservationService.getAssetCategory(assetCategoryVO));
		List<AssetVO> assetList = reservationService.getAssetList(assetCategoryVO);
		assetInfo.add(assetList);
		return new ResponseEntity<List<Object>>(assetInfo, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/insertReservation.do")
	public ResponseEntity<String> insertReservation(@RequestBody ReservationVO reservationVO){
		
		int status = reservationService.insertReservation(reservationVO);
		if (status > 0) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/updateReservation.do")
	public ResponseEntity<String> updateReservation(@RequestBody ReservationVO reservationVO){
		
		int status = reservationService.updateReservation(reservationVO);
		if (status > 0) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/updateReservationByDrop.do")
	public ResponseEntity<String> updateReservationByDrop(@RequestBody ReservationVO reservationVO){
		
		int status = reservationService.updateReservationByDrop(reservationVO);
		if (status > 0) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/cancleReservation.do")
	public ResponseEntity<String> cancleReservation(@RequestBody ReservationVO reservationVO){
		
		int status = reservationService.cancleReservation(reservationVO);
		if (status > 0) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getReservationList.do")
	public ResponseEntity<List<Map<String, Object>>> getReservationList(){
		
		List<Map<String, Object>> events = new ArrayList<Map<String,Object>>();

		List<ReservationVO> reservationList = reservationService.getReservationList();
		
		for (ReservationVO reservationVO : reservationList) {
			Map<String, Object> event = new HashMap<String, Object>();
			event.put("id", reservationVO.getResvNo());
			event.put("resourceId", reservationVO.getAstNo());
			event.put("astNo", reservationVO.getAstNo());
			event.put("resvMember", reservationVO.getResvMember());
			event.put("title", reservationVO.getMemName() + " " + reservationVO.getStartDate().substring(11, 16) + " ~ " + reservationVO.getEndDate().substring(11, 16));
			event.put("description", reservationVO.getResvPrps());
			event.put("start", reservationVO.getStartDate().replace(" ", "T"));
			event.put("end", reservationVO.getEndDate().replace(" ", "T"));
			events.add(event);
		}
		
		return new ResponseEntity<List<Map<String, Object>>>(events, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getAssetReservationList.do")
	public ResponseEntity<List<Map<String, Object>>> getAssetReservationList(AssetVO assetVO){
		
		List<Map<String, Object>> events = new ArrayList<Map<String,Object>>();

		List<ReservationVO> reservationList = reservationService.getAssetReservationList(assetVO.getAstNo());
		
		for (ReservationVO reservationVO : reservationList) {
			Map<String, Object> event = new HashMap<String, Object>();
			event.put("id", reservationVO.getResvNo());
			event.put("resourceId", reservationVO.getAstNo());
			event.put("astNo", reservationVO.getAstNo());
			event.put("resvMember", reservationVO.getResvMember());
			event.put("title", reservationVO.getMemName() + " " + reservationVO.getStartDate().substring(11, 16) + " ~ " + reservationVO.getEndDate().substring(11, 16));
			event.put("description", reservationVO.getResvPrps());
			event.put("start", reservationVO.getStartDate().replace(" ", "T"));
			event.put("end", reservationVO.getEndDate().replace(" ", "T"));
			event.put("allDay", "Y".equals(reservationVO.getAlldayYn()));
			events.add(event);
		}
		
		return new ResponseEntity<List<Map<String, Object>>>(events, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/detail.do")
	public String detail(int resvNo, Authentication authentication, Model model){
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		ReservationVO reservationVO = reservationService.getReservation(resvNo);
		AssetVO assetVO = reservationService.getAssetByReservation(reservationVO);
		AssetCategoryVO assetCategoryVO = reservationService.getAssetCategoryByAsset(assetVO);
		List<ReservationAttendeeVO> attendeeList = reservationService.getAttendeeList(reservationVO);
		
		List<AssetCategoryVO> assetCategoryList = reservationService.getAssetCategoryList();
		List<List<AssetVO>> assetListArray = new ArrayList<List<AssetVO>>();
		for (AssetCategoryVO acVO : assetCategoryList) {
			List<AssetVO> assetList = reservationService.getAssetList(acVO);
			assetListArray.add(assetList);
		}
		
		model.addAttribute("member", member);
		model.addAttribute("reservationVO", reservationVO);
		model.addAttribute("assetVO", assetVO);
		model.addAttribute("assetCategoryVO", assetCategoryVO);
		model.addAttribute("attendeeList", attendeeList);
		model.addAttribute("assetCategoryList", assetCategoryList);
		model.addAttribute("assetListArray", assetListArray);
		
		return "reservation/detail";
	}
	
}
