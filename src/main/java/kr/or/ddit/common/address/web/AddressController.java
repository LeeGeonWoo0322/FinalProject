package kr.or.ddit.common.address.web;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.address.service.IAddressService;
import kr.or.ddit.common.address.vo.AddressDTO;
import kr.or.ddit.common.address.vo.AddressVO;
import kr.or.ddit.common.address.vo.ContactVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/address")
public class AddressController {

	@Inject
	private IAccountService accountService;

	@Inject
	private IAddressService addressService;

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping("/main")
	public String mainForm(Authentication authentication, Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		log.info("## 로그인한 유저 정보 : " + member);
		List<AddressVO> address = addressService.getAddress(member.getMemNo());
		log.info("## 초기 주소록 address 값 : " + address);
		model.addAttribute("member", member);
		model.addAttribute("address", address);
		log.info("## 최종적으로 들고가는 로그인정보 : " + member);
		return "address/main";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/detail")
	public String detail(ContactVO contactVO, Authentication authentication, Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		contactVO = addressService.getContactByAbNo(contactVO);
		List<AddressVO> address = addressService.addContact(String.valueOf(member.getMemNo()));
		model.addAttribute("address", address);
		model.addAttribute("contactVO", contactVO);
		return "address/detail";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/allAddress", method = RequestMethod.POST)
	public List<MemberVO> allAddressList(@RequestBody MemberVO member) {
		log.info("## memNo" + member);
		List<MemberVO> memList = addressService.allAddressList(member);
		return memList;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/myGroupAddress", method = RequestMethod.POST)
	public List<MemberVO> myGroupAddressList(@RequestBody MemberVO member) {
		List<MemberVO> memList = addressService.myGroupAddressList(member);
		return memList;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/deptList", method = RequestMethod.GET)
	public Map<String, Object> deptList(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		log.info("## 로그인한 memNo값 : " + member.getMemNo());
		List<DepartmentVO> deptList = addressService.deptList();
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("memNo", member.getMemNo());
	    response.put("deptList", deptList);
		
		return response;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/groupAddress", method = RequestMethod.POST)
	public List<MemberVO> groupAddress(@RequestBody MemberVO member) {

		log.info("memNo 넘어오나요?: {}", member.getMemNo());

		List<MemberVO> memList = addressService.myGroupAddressList(member);
		log.info("## memList : {}", memList);
		for (MemberVO memberVO : memList) {
			log.info("## memberVO : " + memberVO);
		}
		return memList;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/addModalAddress", method = RequestMethod.POST)
	public String addModalAddress(@RequestBody AddressVO address) {
		log.info("## addressVO 값 : " + address);
		String result = addressService.addModalAddress(address);
		return result;

	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/delModalAddress", method = RequestMethod.POST)
	public String delModalAddress(@RequestBody AddressVO address) {
		log.info("## addressVO 값  del : " + address);
		addressService.delContact(address);
		String result = addressService.delModalAddress(address);
		return result;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/modifyModalAddress", method = RequestMethod.POST)
	public String modifyModalAddress(@RequestBody AddressVO address) {
		log.info("## addressVO 값 mod : " + address);
		String result = addressService.modifyModalAddress(address);
		return result;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/moveAddress", method = RequestMethod.POST)
	public ResponseEntity<String> moveAddress(@RequestBody AddressDTO addressDTO) {
		List<MemberVO> checkedData = addressDTO.getCheckedData();
		int abNo = addressDTO.getAbNo();
		log.info("## checkedData: " + checkedData);
		addressService.moveAddress(checkedData, abNo);
		return ResponseEntity.ok("주소록 등록 성공");
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/exAddress", method = RequestMethod.POST)
	public List<ContactVO> exAddress(@RequestBody ContactVO contact) {
		log.info("ajax로 넘어온 데이터 : " + contact);
		List<ContactVO> impList = addressService.importAddress(contact);
		log.info("## ContactVO : " + impList);
		return impList;
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/addContact", method = RequestMethod.GET)
	public String addContact(Authentication authentication, Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		model.addAttribute("member", member);
		model.addAttribute("memNo", member.getMemNo());
		List<AddressVO> address = addressService.addContact(String.valueOf(member.getMemNo()));
		log.info("## 주소록 address 값 : " + address);
		model.addAttribute("address", address);
		return "address/addContact";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/addExContact", method = RequestMethod.POST)
	public String addExContact(ContactVO contact, RedirectAttributes redirectAttributes) {
	    log.info("## 외부 연락처 등록 : " + contact);
	    addressService.addExContact(contact);
	    redirectAttributes.addFlashAttribute("message", "연락처가 성공적으로 등록되었습니다.");
	    return "redirect:/address/main"; // 리다이렉트
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/deleteChecked", method = RequestMethod.POST)
	public String deleteChecked(@RequestBody List<ContactVO> contact) {
		log.info("## contact : " + contact);
		addressService.deleteChecked(contact);
		return "address/main";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/favorites", method = RequestMethod.POST)
	public ResponseEntity<AddressDTO> favorites(@RequestBody AddressDTO addressDTO, Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		log.info("## 로그인한 유저 정보 : " + member);
		List<AddressDTO> importAddress = addressService.getAbNo(member.getMemNo());

		/* 중요주소록이 없었을 때 insert시키는 쿼리 만들어 놓기 */

		log.info("## 중요 주소록 abNo 값 : " + importAddress);
		log.info("## importAddress 크기 : " + importAddress.size());

		int abNo = 0;

		if (!importAddress.isEmpty()) {
			abNo = importAddress.get(0).getAbNo(); // 첫 번째 객체에서 abNo 값 추출
			log.info("## 추출한 abNo 값 : " + abNo);
		} else {
			log.info("## 주소록이 비어 있습니다.");
		}

		List<MemberVO> favorites = addressDTO.getFavorites();
		log.info("## favorites : " + favorites);
		addressService.moveAddress(favorites, abNo);

		addressDTO.setFavorites(favorites);
		addressDTO.setAbNo(abNo);
		return ResponseEntity.ok(addressDTO);

	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/delFavorites", method = RequestMethod.POST)
	public String delFavorites(@RequestBody List<ContactVO> contact) {
		log.info("## contact : " + contact);
		addressService.delFavorit(contact);
		return "address/main";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/importAbNo", method = RequestMethod.GET)
	public ResponseEntity<Integer> importAbNo(Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		log.info("## 로그인한 유저 정보 : " + member);
		List<AddressDTO> importAddress = addressService.getAbNo(member.getMemNo());
		int abNo = 0;
		if (!importAddress.isEmpty()) {
			abNo = importAddress.get(0).getAbNo(); // 첫 번째 객체에서 abNo 값 추출
			log.info("## 추출한 abNo 값 11 : " + abNo);
			return ResponseEntity.ok(abNo); // 정상적으로 값을 반환
		} else {
			log.info("## 주소록이 비어 있습니다.");
			return ResponseEntity.noContent().build(); // 204 No Content 반환
		}
	}
}