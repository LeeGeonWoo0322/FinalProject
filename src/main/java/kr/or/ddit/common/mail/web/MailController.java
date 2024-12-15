package kr.or.ddit.common.mail.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;
import kr.or.ddit.common.drive.vo.DriveFileVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.mail.service.IMailService;
import kr.or.ddit.common.mail.vo.MailBlockListVO;
import kr.or.ddit.common.mail.vo.MailBlockWordVO;
import kr.or.ddit.common.mail.vo.MailBoxVO;
import kr.or.ddit.common.mail.vo.MailOutOfOfficeVO;
import kr.or.ddit.common.mail.vo.MailRecipientVO;
import kr.or.ddit.common.mail.vo.MailTagVO;
import kr.or.ddit.common.mail.vo.MailVO;
import kr.or.ddit.common.mail.vo.RecipientTagVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mail")
public class MailController {

	@Inject
	private IAccountService accountService;
	
	@Inject
	private PasswordEncoder pe;
	
	@Resource(name="localPath")
	private String localPath;
	
	@Inject
	private IMailService mailService;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping("/mailbox/{mailboxId}")
	public String getMailFolder(@PathVariable("mailboxId") int mailboxId, 
	                            @RequestParam(name = "page", defaultValue = "1") int currentPage, 
	                            @RequestParam(name = "searchWord", required = false) String searchWord, 
	                            Authentication authentication,
	                            Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<MailRecipientVO> dataList = null;
		List<MailVO> confirmationMailList = null;
		MailBoxVO mailBoxVO = null;
		boolean errorExist = false;
		
		PaginationInfoVO<MailRecipientVO> pagingVO = new PaginationInfoVO<MailRecipientVO>(10,5);
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setMemNo(member.getMemNo());
		if (mailboxId > 100) {
			pagingVO.setKeyword(mailboxId-100);
			mailBoxVO = mailService.getMailBoxNo(pagingVO);
			if (mailBoxVO == null) {
				errorExist = true;
			}else {
				pagingVO.setMailboxNo(mailBoxVO.getMailboxNo());
				model.addAttribute("mailBoxVO", mailBoxVO);
			}
		}
		pagingVO.setKeyword(mailboxId);
		
		if (!errorExist) {
			if (mailboxId == 1 || mailboxId == 6 || mailboxId == 12 || mailboxId > 100) {
				dataList = mailService.selectRecMailList(pagingVO);
			}else if (mailboxId == 2 || mailboxId == 4 || mailboxId == 5) {
				dataList = mailService.selectSenderMailList(pagingVO);
			}else if (mailboxId == 3) {
				confirmationMailList = mailService.getConfirmationMailList(pagingVO);
			}else if (mailboxId == 7 || mailboxId == 8 || mailboxId == 9 || mailboxId == 10 || mailboxId == 11) {
				dataList = mailService.selectUnifiedMailList(pagingVO);
			}else {
				dataList = null;
			}
			
			if (mailboxId == 3) {
				pagingVO.setConfirmationMailList(confirmationMailList);
			}else {
				pagingVO.setDataList(dataList);
			}
		}
		
		int inboxUnreadCnt = mailService.getInboxUnreadCnt(member);
		int sentUnreadCnt = mailService.getSentUnreadCnt(member);
		int tempUnreadCnt = mailService.getTempUnreadCnt(member);
		int resUnreadCnt = mailService.getResUnreadCnt(member);
		int spamUnreadCnt = mailService.getSpamUnreadCnt(member);
		int trashUnreadCnt = mailService.getTrashUnreadCnt(member);
		
		model.addAttribute("member", member);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("inboxUnreadCnt", inboxUnreadCnt);
		model.addAttribute("sentUnreadCnt", sentUnreadCnt);
		model.addAttribute("tempUnreadCnt", tempUnreadCnt);
		model.addAttribute("resUnreadCnt", resUnreadCnt);
		model.addAttribute("spamUnreadCnt", spamUnreadCnt);
		model.addAttribute("trashUnreadCnt", trashUnreadCnt);
		
	    return "mail/mailbox";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/new")
	public String writeForm(
			@RequestParam(name = "type", required = false) String type,
			@RequestParam(name = "mailboxId", required = false) String mailboxId,
			@RequestParam(name = "mailNo", required = false) String mailRowNo,
			Authentication authentication,
			Model model) {
		
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		MailVO mail = null;
		String mailTitle = "";
		if (StringUtils.isNotBlank(type)) {
			MailRecipientVO mailRecipientInfo = new MailRecipientVO(member.getMemNo(), Integer.parseInt(mailRowNo), Integer.parseInt(mailboxId));
			if (mailboxId.equals("1") || mailboxId.equals("6") || mailboxId.equals("12")) {
				mailRecipientInfo = mailService.getRecMailInfo(mailRecipientInfo);
			}else if (mailboxId.equals("2") || mailboxId.equals("3") || mailboxId.equals("4") || mailboxId.equals("5")) {
				mailRecipientInfo = mailService.getSenderMailInfo(mailRecipientInfo);
			}else {
				mailRecipientInfo = mailService.getUnifiedMailInfo(mailRecipientInfo);
			}
			mail = mailService.getMailByNo(mailRecipientInfo.getMailNo());
			if (type.equals("reply")||type.equals("allReply")) {
				mailTitle = "RE: " + mail.getMailTitle();
			}
			else if (type.equals("forward")) {
				mailTitle = "FW: " + mail.getMailTitle();
			}
			else if (type.equals("again")) {
				mailTitle = mail.getMailTitle();
			}
		}else {
			type = "basic";
		}
		List<MailRecipientVO> recentMailList = mailService.getRecentMailList(member.getMemNo());
		
		DepartmentVO departmentVO = new DepartmentVO();
		departmentVO.setDeptNo(1);
		List<MemberVO> deptMemberList = mailService.getDeptMember(departmentVO);
		
		int inboxUnreadCnt = mailService.getInboxUnreadCnt(member);
		int sentUnreadCnt = mailService.getSentUnreadCnt(member);
		int tempUnreadCnt = mailService.getTempUnreadCnt(member);
		int resUnreadCnt = mailService.getResUnreadCnt(member);
		int spamUnreadCnt = mailService.getSpamUnreadCnt(member);
		int trashUnreadCnt = mailService.getTrashUnreadCnt(member);
		
		model.addAttribute("inboxUnreadCnt", inboxUnreadCnt);
		model.addAttribute("sentUnreadCnt", sentUnreadCnt);
		model.addAttribute("tempUnreadCnt", tempUnreadCnt);
		model.addAttribute("resUnreadCnt", resUnreadCnt);
		model.addAttribute("spamUnreadCnt", spamUnreadCnt);
		model.addAttribute("trashUnreadCnt", trashUnreadCnt);
		model.addAttribute("deptMemberList", deptMemberList);
		model.addAttribute("recentMailList", recentMailList);
		model.addAttribute("mailTitle", mailTitle);
		model.addAttribute("member", member);
		model.addAttribute("mail", mail);
		model.addAttribute("type", type);
//		model.addAttribute("files", files);
		
		return "mail/mailNew";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/read/{mailboxId}/{mailRowNo}")
	public String readMail(@PathVariable("mailboxId") int mailboxId, 
			@PathVariable("mailRowNo") int mailRowNo, 
			Authentication authentication,
			RedirectAttributes redirectAttributes,
			Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		MailRecipientVO mailRecipientInfo = new MailRecipientVO(member.getMemNo(), mailRowNo, mailboxId);
		boolean errorExist = false;
		if (mailboxId > 100) {
			mailRecipientInfo.setKeyword(mailboxId-100);
			MailBoxVO mailBoxVO = mailService.getMailBoxNoByRec(mailRecipientInfo);
			if (mailBoxVO == null) {
				errorExist = true;
			}else {
				mailRecipientInfo.setMailboxNo(mailBoxVO.getMailboxNo());
				model.addAttribute("mailBoxVO", mailBoxVO);
			}
			mailRecipientInfo.setKeyword(mailboxId+100);
		}
		if (mailboxId == 1 || mailboxId == 6 || mailboxId == 12 || mailboxId > 100) {
			mailRecipientInfo = mailService.getRecMailInfo(mailRecipientInfo);
		}else if (mailboxId == 2 || mailboxId == 3 || mailboxId == 4 || mailboxId == 5) {
			mailRecipientInfo = mailService.getSenderMailInfo(mailRecipientInfo);
		}else {
			mailRecipientInfo = mailService.getUnifiedMailInfo(mailRecipientInfo);
		}
		List<FilesDetailVO> fileList = null;
		if (mailRecipientInfo == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "메일이 존재하지 않습니다");
			return "redirect:/mail/mailbox/1";
		}
		MailVO mail = mailService.getMailByNo(mailRecipientInfo.getMailNo());
		if (mail.getFileNo() != 0) {
			fileList = mailService.getFileDetailList(mail.getFileNo());
		}
		mailRecipientInfo.setRecipientNo(member.getMemNo());
		if (mailRecipientInfo.getMailGb().equals("S")) {
			mailService.readSenderMail(mailRecipientInfo);
		}else {
			mailService.readRecMail(mailRecipientInfo);
		}
		
		int inboxUnreadCnt = mailService.getInboxUnreadCnt(member);
		int sentUnreadCnt = mailService.getSentUnreadCnt(member);
		int tempUnreadCnt = mailService.getTempUnreadCnt(member);
		int resUnreadCnt = mailService.getResUnreadCnt(member);
		int spamUnreadCnt = mailService.getSpamUnreadCnt(member);
		int trashUnreadCnt = mailService.getTrashUnreadCnt(member);
		
		model.addAttribute("inboxUnreadCnt", inboxUnreadCnt);
		model.addAttribute("sentUnreadCnt", sentUnreadCnt);
		model.addAttribute("tempUnreadCnt", tempUnreadCnt);
		model.addAttribute("resUnreadCnt", resUnreadCnt);
		model.addAttribute("spamUnreadCnt", spamUnreadCnt);
		model.addAttribute("trashUnreadCnt", trashUnreadCnt);
		model.addAttribute("member", member);
		model.addAttribute("fileList", fileList);
		model.addAttribute("mail", mail);
		model.addAttribute("mailRecipientInfo", mailRecipientInfo);
		model.addAttribute("mailboxId", mailboxId);
		return "mail/mailRead";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/option")
	public String option(Authentication authentication, Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		MailOutOfOfficeVO outOfOfficeVO = mailService.checkUsedOutOfOffice(member.getMemNo());
		boolean outOfOfficeExist = false;
		if (outOfOfficeVO != null) {
			outOfOfficeExist = true;
		}
		model.addAttribute("outOfOfficeExist", outOfOfficeExist);
		model.addAttribute("outOfOffice", outOfOfficeVO);
		model.addAttribute("member", member);
		return "mail/option";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/send.do")
	public ResponseEntity<String> sendMail(MailVO mail, @RequestPart("recipientData")List<Map<String, List<String>>> recipientData, Authentication authentication) throws IOException {
		
		int status = mailService.sendMail(mail, recipientData, authentication);
		if (status>0) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		
		return new ResponseEntity<String>("FAIL", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getTagList.do")
	public ResponseEntity<List<MailTagVO>> getTagList(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<MailTagVO> tagList = mailService.getTagList(member);
		return new ResponseEntity<List<MailTagVO>>(tagList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/tagCheck.do")
	public ResponseEntity<Integer[]> tagCheck(@RequestBody List<Integer> checkedRecNoList, Authentication authentication){

		List<Integer> tagList = new ArrayList<>();
		for (int checkedRecNo : checkedRecNoList) {
		    List<Integer> applyTagList = mailService.tagCheck(checkedRecNo);
		    tagList.addAll(applyTagList);
		}
		Set<Integer> tagNoSet = new HashSet<>(tagList);
		Integer[] tagNoArray = tagNoSet.toArray(new Integer[0]);
		
		return new ResponseEntity<Integer[]>(tagNoArray, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addTagList.do")
	public ResponseEntity<MailTagVO> addTagList(@RequestBody Map<String, String> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		String tagListName = map.get("mailTagName");
		String tagListColor = map.get("mailTagColor");
		MailTagVO mailTagList = new MailTagVO(tagListName, tagListColor, member.getMemNo());
		int status = mailService.addTagList(mailTagList);
		MailTagVO lastMailTag = null;
		if (status > 0) {
			lastMailTag = mailService.getLastMailTag(member);
		}
		return new ResponseEntity<MailTagVO>(lastMailTag, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/modifyTagList.do")
	public ResponseEntity<String> modifyTagList(@RequestBody Map<String, String> map){
		int tagListNo = Integer.parseInt(map.get("mailTagNo"));
		String tagListName = map.get("mailTagName");
		String tagListColor = map.get("mailTagColor");
		MailTagVO mailTagList = new MailTagVO(tagListNo, tagListName, tagListColor);
		int status = mailService.modifyTagList(mailTagList);
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteTagList.do")
	public ResponseEntity<String> deleteTagList(@RequestBody Map<String, Integer> map){
		int tagListNo = (int)map.get("mailTagNo");
		MailTagVO mailTagList = new MailTagVO(tagListNo);
		int status = mailService.deleteTagList(mailTagList);
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/applyTag.do")
	public ResponseEntity<String> applyTag(@RequestBody Map<String, Object> map){
		List<Integer> recList = (List<Integer>) map.get("recList");
		RecipientTagVO recipientTagVO = null;
		int tagNo = (int)map.get("tagNo");
		boolean applyOk = true;
		for (int recNo : recList) {
			List<Integer> applyedTagList = mailService.tagCheck(recNo);
			for (int applyedTag : applyedTagList) {
				if (applyedTag == tagNo) {
					applyOk = false;
				}
			}
			if (applyOk) {
				recipientTagVO = new RecipientTagVO(recNo, tagNo);
				mailService.applyTag(recipientTagVO);
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/unApplyTag.do")
	public ResponseEntity<String> unApplyTag(@RequestBody Map<String, Object> map){
		List<Integer> recList = (List<Integer>) map.get("recList");
		RecipientTagVO recipientTagVO = null;
		int tagNo = (int)map.get("tagNo");
		for (int recNo : recList) {
			List<Integer> applyedTagList = mailService.tagCheck(recNo);
			for (int applyedTag : applyedTagList) {
				if (applyedTag == tagNo) {
					recipientTagVO = new RecipientTagVO(recNo, tagNo);
					mailService.unApplyTag(recipientTagVO);
				}
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getTag.do")
	public ResponseEntity<List<MailTagVO>> getTag(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<MailTagVO> tagList = mailService.getTag(member);
		return new ResponseEntity<List<MailTagVO>>(tagList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addSpam.do")
	public ResponseEntity<String> addSpam(@RequestBody List<Integer> blockList, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		for(int blockedMember : blockList) {
			MailBlockListVO blockListVO = new MailBlockListVO(member.getMemNo(), blockedMember);
			int blockListExist = mailService.checkBlock(blockListVO);
			if (blockListExist < 1) {
				mailService.addBlockList(blockListVO);
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addTrash.do")
	public ResponseEntity<String> addTrash(@RequestBody Map<String, Object> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> trashList = (List<Integer>) map.get("trashList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		for(int i = 0; i < trashList.size(); i++) {
			MailRecipientVO recipientVO = new MailRecipientVO(trashList.get(i), member.getMemNo());
			if (mailGbList.get(i).equals("S")) {
				mailService.senderAddTrash(recipientVO);
			}else {
				mailService.recAddTrash(recipientVO);
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addSpamAndTrash.do")
	public ResponseEntity<String> addSpamAndTrash(@RequestBody Map<String, Object> spamAndTrashList, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> blockList = (List<Integer>) spamAndTrashList.get("blockList");
		List<Integer> trashList = (List<Integer>) spamAndTrashList.get("trashList");
		List<String> mailGbList = (List<String>) spamAndTrashList.get("mailGbList");
		for (int i = 0; i < blockList.size(); i++) {
			MailBlockListVO blockListVO = new MailBlockListVO(member.getMemNo(), blockList.get(i));
			MailRecipientVO recipientVO = new MailRecipientVO(trashList.get(i), member.getMemNo());
			int blockListExist = mailService.checkBlock(blockListVO);
			if (blockListExist < 1) {
				mailService.addBlockList(blockListVO);
			}
			if (mailGbList.get(i).equals("S")) {
				mailService.senderAddTrash(recipientVO);
			}else {
				mailService.recAddTrash(recipientVO);
			}
		}
			
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/unSpam.do")
	public ResponseEntity<String> unSpam(@RequestBody List<Integer> unblockList, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		for(int unblockedMember : unblockList) {
			MailBlockListVO unblockListVO = new MailBlockListVO(member.getMemNo(), unblockedMember);
				mailService.unBlockList(unblockListVO);
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/unTrash.do")
	public ResponseEntity<String> unTrash(@RequestBody Map<String, Object> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> untrashList = (List<Integer>) map.get("untrashList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		for(int i = 0; i < untrashList.size(); i++) {
			MailRecipientVO recipientVO = new MailRecipientVO(untrashList.get(i), member.getMemNo());
			if (mailGbList.get(i).equals("S")) {
				mailService.senderUnTrash(recipientVO);
			}else {
				mailService.recUnTrash(recipientVO);
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/unSpamAndTrash.do")
	public ResponseEntity<String> unSpamAndTrash(@RequestBody Map<String, Object> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> unblockList = (List<Integer>) map.get("unblockList");
		List<Integer> untrashList = (List<Integer>) map.get("untrashList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		for (int i = 0; i < unblockList.size(); i++) {
			MailBlockListVO unblockListVO = new MailBlockListVO(member.getMemNo(), unblockList.get(i));
			MailRecipientVO recipientVO = new MailRecipientVO(untrashList.get(i), member.getMemNo());
			mailService.unBlockList(unblockListVO);
			if (mailGbList.get(i).equals("S")) {
				mailService.senderUnTrash(recipientVO);
			}else {
				mailService.recUnTrash(recipientVO);
			}
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/changeFav.do")
	public ResponseEntity<String> changeFav(@RequestBody MailRecipientVO recipientVO, Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		recipientVO.setRecipientNo(member.getMemNo());
		if (recipientVO.getKeyword() == 2 || recipientVO.getKeyword() == 3 ||recipientVO.getKeyword() == 4 ||recipientVO.getKeyword() == 5) {
			mailService.changeSenderFav(recipientVO);
		}else {
			mailService.changeRecipientFav(recipientVO);
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/searchMember.do")
    public ResponseEntity<List<MemberVO>> searchMember(@RequestBody Map<String, String> map) {
		List<MemberVO> memberList = null;
		String searchWord = map.get("searchWord");
		if (!StringUtils.isBlank(searchWord)) {
			memberList = mailService.searchMembers(searchWord);
		}
        return new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
    }
	
	// CKEDITOR를 이용하여 본문 내용에 선택 이미지 업로드하기
	@RequestMapping(value="/imageUpload.do")
	public String imageUpload(
			HttpServletRequest req, HttpServletResponse resp,
			MultipartHttpServletRequest multiFile
			) throws Exception {
		// CKEDITOR4 특정 버전 이후부터 html 형식의 데이터를 리턴하는 방법에서 JSON 데이터를 구성해서 리턴하는 방식으로 변경됨
		JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
		PrintWriter printWriter = null;			// 외부 응답으로 내보낼 때 사용할 객체
		OutputStream out = null;				// 본문내용에 추가한 이미지를 파일로 생성할 객체
		long limitSize = 1024 * 1024 * 2;		// 업로드 파일 최대 크기 (2MB)
		
		MultipartFile file = multiFile.getFile("upload");	// upload라는 키로 MultipartFile 타입의 파일 데이터를 꺼낸다.
		
		// 파일 객체가 null이 아니고 파일 사이즈가 0보다 크고 파일명이 공백이 아닌경우는 무조건 파일 데이터가 존재하는 경우
		if(file != null && file.getSize() > 0 && StringUtils.isNotBlank(file.getOriginalFilename())) {
			// 데이터 Mime 타입이 'image/'를 포함한 이미지 파일안지 체크
			if(file.getContentType().toLowerCase().startsWith("image/")) {
				// 업로드 한 파일 사이즈가 최대 크기(2MB) 보다 클 때
				if(file.getSize() > limitSize) {	// 크기 초과 에러
					/*
					 * {
					 * 		"uploaded" : 0,
					 * 		"error" : [
					 * 			{
					 * 				"message" : "2MB미만의 이미지만 업로드 가능합니다."
					 *			} 		
					 * 		]
					 * }
					 * 에러가 발생했을 때 출력 형태를 위와 같은 형식으로 만든다.
					 */
					JsonObject jsonMsg = new JsonObject();
					JsonArray jsonArr = new JsonArray();
					jsonMsg.addProperty("message", "2MB미만의 이미지만 업로드 가능합니다.");
					jsonArr.add(jsonMsg);
					json.addProperty("uploaded", 0);
					json.add("error", jsonArr.get(0));
					
					resp.setCharacterEncoding("UTF-8");
					printWriter = resp.getWriter();
					printWriter.println(json);
				}else {								// 정상 범위 안에있는 파일
					/*
					 * {
					 * 		"uploaded" : 1,
					 * 		"fileName" : "xxxxxxxxxxx-xxxxxxxxxx.jpg",
					 * 		"url" : "/resources/img/xxxxxxxx-xxxxxxxxxx.jpg"
					 * }
					 */
					try {
						String fileName = file.getOriginalFilename();	// 파일명 얻어오기
						byte[] bytes = file.getBytes();		// 파일 데이터 얻어오기
						// 업로드 경로 설정(배포 서버 안에 들어 있는)
						String locate = localPath + "/mail";
						
						File uploadFile = new File(locate);
						// 업로드 경로로 설정된 폴더구조가 존재하지 않는 경우, 파일을 복사할 수 없으므로 폴더 구조가 존재하지 않는 경우
						// 해당 위치에 폴더를 생성하고 존재하는 경우 건너뛰도록 한다.
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						
						// UUID_원본파일명
						fileName = UUID.randomUUID().toString() + "_" + fileName;
						String uploadPath = locate + "/" + fileName;	// 업로드 경로 + 파일명
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);	// 파일 복사
						
						printWriter = resp.getWriter();
						String fileUrl = req.getContextPath() + "/upload/mail/" + fileName; 
						
						System.out.println("fileUrl::"+ fileUrl);
						
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						
						printWriter.println(json);
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(out != null) {
							out.close();
						}
						if(printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/fileListPreview.do")
	public ResponseEntity<List<FilesDetailVO>> fileListPreview(@RequestBody Map<String, Integer> map){
		List<FilesDetailVO> fileList = mailService.getFileDetailList(map.get("fileNo"));
		return new ResponseEntity<List<FilesDetailVO>>(fileList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteFileDetail.do")
	public ResponseEntity<String> deleteFileDetail(@RequestBody Map<String, Integer> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		int fileNo = map.get("fileNo");
		int memNo = map.get("writer");
		if (member.getMemNo() == memNo) {
			mailService.deleteMemFileDetail(fileNo);
		}else {
			mailService.deleteRecipientFileDetail(fileNo);
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteFile.do")
	public ResponseEntity<String> deleteFile(@RequestBody Map<String, Object> map, Authentication authentication){
		List<Integer> fileDeleteList = (List<Integer>) map.get("fileDeleteList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		for (int i = 0; i < fileDeleteList.size(); i++) {
			if (mailGbList.get(i).equals("S")) {
				mailService.deleteMemFile(fileDeleteList.get(i));
			}else {
				mailService.deleteRecipientFile(fileDeleteList.get(i));
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/fillInput.do")
	public ResponseEntity<MailVO> fillInput(@RequestBody Map<String, Integer> map){
		int mailNo = map.get("mailNo");
		MailVO mail = mailService.getMailByNo(mailNo);
		List<FilesDetailVO> fileList = mailService.getFileDetailList(mail.getFileNo());
		mail.setFileList(fileList);
		return new ResponseEntity<MailVO>(mail, HttpStatus.OK);
	}	
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/completelyDelete.do")
	public ResponseEntity<String> completelyDelete(@RequestBody Map<String, Object> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> completelyDeleteList = (List<Integer>) map.get("completelyDeleteList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		for (int i = 0; i < completelyDeleteList.size(); i++) {
			MailRecipientVO recipientVO = new MailRecipientVO(completelyDeleteList.get(i), member.getMemNo());
			if (mailGbList.get(i).equals("S")) {
				mailService.senderCompletelyDelete(recipientVO);
			}else {
				mailService.recCompletelyDelete(recipientVO);
			}
			
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/readMail.do")
	public ResponseEntity<String> readMail(@RequestBody Map<String, Object> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> mailNoList = (List<Integer>) map.get("mailNoList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		MailRecipientVO recipientVO = null;
		for (int i = 0; i < mailNoList.size(); i++) {
			recipientVO = new MailRecipientVO(mailNoList.get(i), member.getMemNo());
			if (mailGbList.get(i).equals("S")) {
				mailService.readSenderMail(recipientVO);
			}else {
				mailService.readRecMail(recipientVO);
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/unreadMail.do")
	public ResponseEntity<String> unreadMail(@RequestBody Map<String, Object> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<Integer> mailNoList = (List<Integer>) map.get("mailNoList");
		List<String> mailGbList = (List<String>) map.get("mailGbList");
		MailRecipientVO recipientVO = null;
		for (int i = 0; i < mailNoList.size(); i++) {
			recipientVO = new MailRecipientVO(mailNoList.get(i), member.getMemNo());
			if (mailGbList.get(i).equals("S")) {
				mailService.unreadSenderMail(recipientVO);
			}else {
				mailService.unreadRecMail(recipientVO);
			}
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addMailBox.do")
	public ResponseEntity<MailBoxVO> addMailBox(@RequestBody Map<String, String> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		MailBoxVO mailBoxVO = new MailBoxVO(member.getMemNo(), map.get("mailboxName"));
		mailService.addMailBox(mailBoxVO);
		mailBoxVO = mailService.getLastMailBox(member);
		return new ResponseEntity<MailBoxVO>(mailBoxVO, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getMailBoxList.do")
	public ResponseEntity<List<MailBoxVO>> getMailBoxList(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<MailBoxVO> mailboxList = mailService.getMailBoxList(member);
		return new ResponseEntity<List<MailBoxVO>>(mailboxList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteConfirmationMail.do")
	public ResponseEntity<String> deleteConfirmationMail(@RequestBody Map<String, List<Integer>> map){
		List<Integer> deleteConfirmationNoList = map.get("deleteConfirmationNo");
		for (int deleteConfirmationNo : deleteConfirmationNoList) {
			mailService.deleteConfirmationMail(deleteConfirmationNo);
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/cancleSend.do")
	public ResponseEntity<String> cancleSend(@RequestBody Map<String, List<Integer>> map){
		List<Integer> cancleSendNoList = map.get("cancleSendNo");
		for (int mailNo : cancleSendNoList) {
			mailService.cancleSend(mailNo);
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/moveMail.do")
	public ResponseEntity<String> moveMail(@RequestBody Map<String, Object> map){
		List<Integer> moveNoList = (List<Integer>) map.get("moveNoList");
		int mailboxNo = (int) map.get("mailboxNo");
		for (int recNo : moveNoList) {
			MailBoxVO mailBoxVO = new MailBoxVO(recNo, mailboxNo);
			mailService.moveMail(mailBoxVO);
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/moveInbox.do")
	public ResponseEntity<String> moveInbox(@RequestBody Map<String, List<Integer>> map){
		List<Integer> moveInboxList =  map.get("moveInboxList");
		for (int recNo : moveInboxList) {
			mailService.moveInbox(recNo);
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/emptyMailBox.do")
	public ResponseEntity<String> emptyMailBox(@RequestBody Map<String, Integer> map){
		int emptyMailBoxNo =  map.get("emptyMailBoxNo");
		mailService.emptyMailBox(emptyMailBoxNo);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/modifyMailBox.do")
	public ResponseEntity<String> modifyMailBox(@RequestBody Map<String, String> map){
		int modifyMailBoxNo =  Integer.parseInt(map.get("modifyMailBoxNo"));
		String modifyMailboxNameVal =  map.get("modifyMailboxNameVal");
		MailBoxVO mailBoxVO = new MailBoxVO();
		mailBoxVO.setMailboxNo(modifyMailBoxNo);
		mailBoxVO.setMailboxName(modifyMailboxNameVal);
		mailService.modifyMailBox(mailBoxVO);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteMailBox.do")
	public ResponseEntity<String> deleteMailBox(@RequestBody Map<String, Integer> map){
		int deleteMailBoxNo =  map.get("deleteMailBoxNo");
		mailService.deleteMailBox(deleteMailBoxNo);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addBlockWord.do")
	public ResponseEntity<MailBlockWordVO> addBlockWord(@RequestBody Map<String, String> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		String blockWord =  map.get("blockWord");
		MailBlockWordVO mailBlockWordVO = new MailBlockWordVO(member.getMemNo(), blockWord);
		mailBlockWordVO = mailService.addBlockWord(mailBlockWordVO);
		
		return new ResponseEntity<MailBlockWordVO>(mailBlockWordVO, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteBlockWord.do")
	public ResponseEntity<String> deleteBlockWord(@RequestBody Map<String, Integer> map){
		int deleteNo =  map.get("deleteNo");
		mailService.deleteBlockWord(deleteNo);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/deleteAllBlockWord.do")
	public ResponseEntity<String> deleteAllBlockWord(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		mailService.deleteAllBlockWord(member);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getBlockWordList.do")
	public ResponseEntity<List<MailBlockWordVO>> getBlockWordList(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<MailBlockWordVO> blockWordList = mailService.getBlockWordList(member);
		
		return new ResponseEntity<List<MailBlockWordVO>>(blockWordList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addBlockList.do")
	public ResponseEntity<MailBlockListVO> addBlockList(@RequestBody Map<String, String> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		MailBlockListVO mailBlockListVO = null;
		String blockListEmail =  map.get("blockList");
		MemberVO blockMember = new MemberVO();
		blockMember.setMemEmail(blockListEmail);
		blockMember = accountService.findId(blockMember);
		if (blockMember == null) {
			mailBlockListVO = null;
		}else {
			mailBlockListVO = new MailBlockListVO(member.getMemNo(), blockMember.getMemNo());
			mailBlockListVO = mailService.addBlockList(mailBlockListVO);
		}
		
		return new ResponseEntity<MailBlockListVO>(mailBlockListVO, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteBlockList.do")
	public ResponseEntity<String> deleteBlockList(@RequestBody Map<String, Integer> map){
		int deleteNo =  map.get("deleteNo");
		mailService.deleteBlockList(deleteNo);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/deleteAllBlockList.do")
	public ResponseEntity<String> deleteAllBlockList(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		mailService.deleteAllBlockList(member);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getBlockList.do")
	public ResponseEntity<List<MailBlockListVO>> getBlockList(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		List<MailBlockListVO> blockList = mailService.getBlockList(member);
		
		return new ResponseEntity<List<MailBlockListVO>>(blockList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/outOfOfficeSave.do")
	public ResponseEntity<String> outOfOfficeSave(@RequestBody Map<String, String>map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		String title = map.get("title");
		String content = map.get("content");
		String useYn = map.get("outOfOfficeSave");
		String outOfOfficeIsExist = map.get("outOfOfficeIsExist");
		MailOutOfOfficeVO mailOutOfOfficeVO = new MailOutOfOfficeVO(member.getMemNo(), title, content, useYn);
		if (outOfOfficeIsExist.equals("false")) {
			mailService.insertOutOfOffice(mailOutOfOfficeVO);
		}else {
			mailService.updateOutOfOffice(mailOutOfOfficeVO);
		}
		return new ResponseEntity<String>("저장했습니다.", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/securityMail.do")
	public ResponseEntity<Boolean> securityMail(@RequestBody Map<String, String> map, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		String password = map.get("inputval");
		boolean correct = pe.matches(password, member.getMemPw());
		
		return new ResponseEntity<Boolean>(correct, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/fileAllDelete.do")
	public ResponseEntity<String> fileAllDelete(@RequestBody Map<String, Object> map, Authentication authentication){
		int fileNo = (int) map.get("deleteFileNo");
		String mailGb = (String) map.get("mailGb");
		if (mailGb.equals("S")) {
			mailService.deleteMemFile(fileNo);
		}else {
			mailService.deleteRecipientFile(fileNo);
		}
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getMailCapacity.do")
	public ResponseEntity<Long> getMailCapacity(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		Long myMailCapacity = mailService.getMailCapacity(member);
		
		return new ResponseEntity<Long>(myMailCapacity, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/checkReqAddCapacity.do")
	public ResponseEntity<UpgradeReqVO> checkReqAddCapacity(Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		UpgradeReqVO checkReqAddCapacity = mailService.checkReqAddCapacity(member);
		
		return new ResponseEntity<UpgradeReqVO>(checkReqAddCapacity, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/reqAddCapacity.do")
	public ResponseEntity<String> reqAddCapacity(@RequestBody UpgradeReqVO upgradeReqVO, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		upgradeReqVO.setReqMemNo(member.getMemNo());
		
		mailService.reqAddCapacity(upgradeReqVO);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/downloadZipFile.do")
	public void downloadZipFile(@RequestBody Map<String, Object> map, HttpServletResponse response) {
	    String fileName = (String) map.get("mailTitle");
	    List<Integer> fileNoList = (List<Integer>) map.get("fileDetailNoList");
	    List<File> fileList = new ArrayList<>();
	    
	    response.setStatus(HttpServletResponse.SC_OK);
	    response.setContentType("application/zip");

	    try {
	        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
	        response.addHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName + ".zip");

	        ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream());

	        for (int fileNo : fileNoList) {
	            File file = new File(localPath + mailService.getFileDetailListByDetailNo(fileNo).getFilePath());
	            if (file.exists()) {
	                fileList.add(file);
	            }
	        }

	        for (File file : fileList) {
	            zipOut.putNextEntry(new ZipEntry(file.getName().substring(37)));
	            try (FileInputStream fis = new FileInputStream(file)) {
	                StreamUtils.copy(fis, zipOut);
	            }
	            zipOut.closeEntry();
	        }

	        zipOut.finish();
	        zipOut.flush(); 
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getDepartmentTree.do")
	public ResponseEntity<List<DepartmentVO>> getDepartmentTree() {
		
		List<DepartmentVO> departmentList = mailService.getDeptList();
		
		return new ResponseEntity<List<DepartmentVO>>(departmentList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/getDeptMember.do")
	public ResponseEntity<List<MemberVO>> getDeptMember(@RequestBody DepartmentVO departmentVO) {
		
		List<MemberVO> memberList = mailService.getDeptMember(departmentVO);
		
		return new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/getTagMail.do")
	public ResponseEntity<List<MailRecipientVO>> getTagMail(@RequestBody RecipientTagVO recipientTagVO) {
		
		List<MailRecipientVO> mailRecipientNoList = mailService.getTagMail(recipientTagVO);
		List<MailRecipientVO> mailRecipientList = new ArrayList<MailRecipientVO>();
		for (MailRecipientVO mailRecipientVO : mailRecipientNoList) {
			mailRecipientList.add(mailService.getMailRecipient(mailRecipientVO));
		}
		
		return new ResponseEntity<List<MailRecipientVO>>(mailRecipientList, HttpStatus.OK);
	}
	
	

}
