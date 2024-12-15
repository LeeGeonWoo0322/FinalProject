package kr.or.ddit.common.board.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;
import kr.or.ddit.common.approval.service.IApprovalService;
import kr.or.ddit.common.approval.vo.ApprovalLineMemberVO;
import kr.or.ddit.common.approval.vo.ApprovalVO;
import kr.or.ddit.common.board.service.BoardService;
import kr.or.ddit.common.board.vo.BoardCommentVO;
import kr.or.ddit.common.board.vo.BoardVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final BoardVO BoardVO = null;

	@Inject
	private BoardService boardService;
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IAlarmService alarmService;
	
	@Inject
	private IApprovalService approvalService;
	
	@javax.annotation.Resource(name = "localPath")
	private String localPath;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/boardList")
	public String boardList(Authentication authentication, Model model, BoardVO boardVO) {
		log.info("boardList 실행");
		
		List<BoardVO> result = boardService.selectBoardList(authentication);
		log.info("result : {}",result);
		
		model.addAttribute("boardList", result);
		model.addAttribute("boardType", boardVO.getBoardType());
		model.addAttribute("postType", boardVO.getPostType());
		log.info("boardType: {}",boardVO.getBoardType());
		log.info("postType: {}",boardVO.getPostType());
		return "board/list";
	}
	
	//등록 폼
	@GetMapping("/registerForm")
	public String registerForm(Authentication auth, Model model,
			@RequestParam("boardType")String boardType, @RequestParam("postType")String postType) {
		log.info("registerForm()실행....!");
		
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = boardService.getMemberByUserName(user.getUsername());
		int currentMemNo = memberVO.getMemNo();
		log.info("CurrentMemNo: {}",currentMemNo);
		model.addAttribute("currentMemNo", currentMemNo);
		model.addAttribute("boardType", boardType);
		model.addAttribute("postType", postType);
		return "board/register";
	}
	
	 //등록
	@RequestMapping("/registerForm")
	public ResponseEntity<Map<String, String>> register(@RequestPart("boardVO") BoardVO boardVO, ApprovalVO approvalVO, 
			@RequestPart(value = "file", required = false) MultipartFile[] file, Authentication authentication,
			Model model) {
		log.info("register()실행....!");
		
		boardVO.setAttachedFiles(file);
		System.out.println("boardVO :: ");
		System.out.println(boardVO);
		
		// ajax릁 통해 파일 받아오기
		ServiceResult sr = boardService.insertForm(boardVO, authentication);
		
		log.info("boaraVO 이후 값 확인 ::" + boardVO);
		
		// 알림 기능
		if("Y".equals(boardVO.getBoardAlarm())) {
			log.info("여기로 들어 왔니?!?!?" + boardVO.getBoardAlarm());
			List<MemberVO> memList = boardService.memberAalarmList();
			
			MemberVO memberVO = getAuthenticatedMember();
			AlarmVO alarm = new AlarmVO();
			AlarmBanVO alarmBanVO = new AlarmBanVO();
			List<AlarmVO> alarmList =new ArrayList<>();
			
//			for (MemberVO member : memList) {
//				alarmBanVO.setMemNo(member.getMemNo());
//				alarmBanVO.setTechCategory("공지사항");
//				approvalVO.setApprTitle("<span style='color:red;'>공지사항</span>");
//				int cnt=alarmService.chkBanAlarm(alarmBanVO);
//				if(cnt>0) {
//					continue;
//				}		
//				
//				alarm.setAlarmCategory("공지사항");
//				alarm.setReceiverNo(member.getMemNo());
//				alarm.setAlarmContent(memberVO.getMemName()+"님이 "+approvalVO.getApprTitle()+"을 등록했습니다.");
//				alarm.setAlarmUrl("/board/detail/"+boardVO.getBoardNo());
//				AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
//				alarmList.add(insertedAlarm);
//			}
			
			
				// 시연 테스트 4번만 알림!
				alarmBanVO.setMemNo(4);
				alarmBanVO.setTechCategory("공지사항");
				approvalVO.setApprTitle("<span style='color:red;'>공지사항</span>");
				int cnt=alarmService.chkBanAlarm(alarmBanVO);
				
				alarm.setAlarmCategory("공지사항");
				alarm.setReceiverNo(4);
				alarm.setAlarmContent(memberVO.getMemName()+"님이 "+approvalVO.getApprTitle()+"을 등록했습니다.");
				alarm.setAlarmUrl("/board/detail/"+boardVO.getBoardNo());
				AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
				alarmList.add(insertedAlarm);
			
			
			
			
			if (alarmList.size()>0) {
				alarmService.sendNotificationToUsers(alarmList);
			}
		}
				
		// 그냥 파일 받아오기
		//ServiceResult sr = boardService.insertBoard(boardVO, authentication);
		Map<String, String> response = new HashMap<>();
		response.put("postType", boardVO.getPostType());
		response.put("boardType", boardVO.getBoardType());
		//return new ResponseEntity<String>("success", HttpStatus.OK);
		return ResponseEntity.ok(response);
	}
	
	private MemberVO getAuthenticatedMember() {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return customUser.getMember();
	}
	
	
	
	
	
	//상세보기
	@GetMapping("/detail/{boardNo}")
	public String getBoardDetail(@PathVariable int boardNo, BoardVO boardVO, Model model, Authentication auth) {
		boardService.incrementHit(boardNo);
		BoardVO board = boardService.getBoardDetail(boardNo);
		List<BoardCommentVO> comments = boardService.selectBoardCommentList(boardNo);
		List<FilesDetailVO> attachedFiles = boardService.getAttachedFilesByFileNo(board.getFileNo());
		
		//현재 로그인된 사용자 정보
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = boardService.getMemberByUserName(user.getUsername());
		int currentMemNo = memberVO.getMemNo();
		
		// 게시판 이전글 다음글 
		List<BoardVO> boardList = boardService.previousList(board);
		
		log.info("뭐가 들어있니?!?: {}",boardList);
		
		log.info("getBoardDetail. boardInfo: {}",board);
		
		model.addAttribute("boardList", boardList);
		
		model.addAttribute("board", board);
		model.addAttribute("comments", comments);
		model.addAttribute("currentMemNo", currentMemNo);
		model.addAttribute("attachedFiles", attachedFiles);
		model.addAttribute("boardType", board.getBoardType());
		model.addAttribute("postType", board.getPostType());
		
		
		return "board/detail";
	}
	
	//댓글등록
	@PostMapping("/comment")
	public String addComment(BoardCommentVO commentVO,BoardVO boardVO, RedirectAttributes redirectAttributes, Authentication authentication) {
		boardService.addComment(commentVO, authentication);
		redirectAttributes.addAttribute("boardNo", commentVO.getBoardNo());
		if(boardVO.getBoardType().equals("앨범게시판")) {
			return "redirect:/board/albumDetail/{boardNo}"; 
		}
		return "redirect:/board/detail/{boardNo}";
	}

	//댓글수정	
	@PostMapping("/comment/update")
	public String updateComment(BoardCommentVO commentVO, BoardVO boardVO, RedirectAttributes redirectAttributes, Authentication authentication) {
		boardService.updateComment(commentVO, authentication);
		redirectAttributes.addAttribute("boardNo", commentVO.getBoardNo());
		if(boardVO.getBoardType().equals("앨범게시판")) {
			return "redirect:/board/albumDetail/{boardNo}"; 
		}
		return "redirect:/board/detail/{boardNo}";
	}

	//댓글삭제
	@PostMapping("/comment/delete")
	public String deleteComment(@RequestParam("cmntNo")int cmntNo, BoardVO boardVO,
			RedirectAttributes redirectAttributes, Authentication authentication) {
		log.info("comment Delete From : {}", boardVO);
		boardService.deleteComment(cmntNo, authentication);
		redirectAttributes.addAttribute("boardNo", boardVO.getBoardNo());
		if(boardVO.getBoardType().equals("앨범게시판")) {
			return "redirect:/board/albumDetail/{boardNo}"; 
		}
		return "redirect:/board/detail/{boardNo}";
	}
	
	
	//파일 다운로드
	@GetMapping("/download/{fileDetailNo}")
	public ResponseEntity<byte[]> downloadFile(@PathVariable int fileDetailNo, HttpServletRequest request) throws IOException{
		FilesDetailVO fileDetailVO = boardService.getFileDetail(fileDetailNo);
		Path file = Paths.get(fileDetailVO.getFilePath());
		Resource resource = null;
//		try {
//			resource = new UrlResource(file.toUri());
//		}catch(MalformedURLException e) {
//			log.error("파일을 UrlResource로 변환에 실패");
			//안정화 전까지 에러 발생에 대한 stack 정보 출력 코드.
//			e.printStackTrace();
//		}
		
		String filename = fileDetailVO.getFileOriginalname().replaceAll(" ", "_"); 
		InputStream in = null;
		try {
			in = new FileInputStream(new File(localPath + fileDetailVO.getFilePath()));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		String agent = request.getHeader("User-Agent");
		if (StringUtils.containsIgnoreCase(agent, "msie") || StringUtils.containsIgnoreCase(agent, "trident")) {
		} else {
//			filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		}
		filename = URLEncoder.encode(filename, "UTF-8");
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION,  "attachment; filename=\""+filename+"\"")
				.body(IOUtils.toByteArray(in));
	}
	
	
	// 게시판 수정 (모달)
	@PostMapping("/update")
	public String updateBoard(BoardVO boardVO,
			@RequestParam(value="deleteThumbnailFlag", required = false)String deleteThumbnailFlag,
			@RequestParam(value = "attachedFiles", required = false) MultipartFile[] attachedFiles,
			@RequestParam(value = "deleteFileNos", required = false) Integer[] deleteFileNos) {
		log.info("update Board Info: {}",boardVO);
		log.info("attachedFiles: {}", attachedFiles);
		log.info("deleteThumbnailFlag: {}",deleteThumbnailFlag);
		if("true".equals(deleteThumbnailFlag)) {
			boardService.deleteThumbnail(boardVO);
		}else if(boardVO.getThumbnailImgFile() != null && !boardVO.getThumbnailImgFile().isEmpty()) {
			boardService.deleteThumbnail(boardVO);
			boardService.updateThumbnail(boardVO);
		}
		boardService.updateBoardWithFiles(boardVO, deleteFileNos);
		if(boardVO.getBoardType().equals("앨범게시판")) {
			return "redirect:/board/albumDetail/"+boardVO.getBoardNo();
		}
		return "redirect:/board/detail/"+boardVO.getBoardNo();
		
	}
	
	
	// 페이징 처리
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/paging.do")
	public ResponseEntity<PaginationInfoVO<BoardVO>> pagings(@RequestBody Map<String, Object> map, Authentication authentication, Model model) {
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		String searchWord = (String) map.get("searchWord");
		int currentPage = (int) map.get("currentPage");
		String postType= (String)map.get("postType");
		
		log.info("pagings postType: {}",postType);
		
		List<BoardVO> noticeList = boardService.selectBoardNoticeList(postType);
		
		int pageSize = 10 - noticeList.size();
		
		// 페이징, 검색기능
		PaginationInfoVO<BoardVO> pagingVO = new PaginationInfoVO<BoardVO>(pageSize,5);
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		pagingVO.setMemNo(member.getMemNo());
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setPostType(postType);
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = boardService.selectBoardCount(pagingVO);
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord);
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의
		// 리스트 데이터를 전달한다.
		List<BoardVO> dataList = new ArrayList();
		dataList.addAll(noticeList);
		log.info("noticeList : " + noticeList);
		List<BoardVO> boardListNew = boardService.selectBoardListNew(pagingVO);
		dataList.addAll(boardListNew);
		log.info("boardListNew : " + boardListNew);
		
		pagingVO.setDataList(dataList);
		log.info("dataList : " + dataList);
				
		
		return new ResponseEntity<PaginationInfoVO<BoardVO>>(pagingVO, HttpStatus.OK);
	}
	
	// 게시판 삭제
	@PostMapping("/delete/{boardNo}")
	public String deleteBoard(@PathVariable("boardNo") int boardNo,
			@RequestParam("boardType")String boardType, @RequestParam("postType") String postType,
			 RedirectAttributes redirectAttributes) {
		boardService.deleteBoardWithFilesAndComments(boardNo);
		log.info("boardType: {}",boardType);
		log.info("postType: {}",postType);
		redirectAttributes.addAttribute("boardType", boardType);
		redirectAttributes.addAttribute("postType", postType);
		
		if(boardType.equals("전사게시판") || boardType.equals("일반게시판")) {
			
			return "redirect:/board/boardList";
		}
		
		return "redirect:/board/albumList";
	}
	
	
	
	
	@GetMapping("/loadMore")
	@ResponseBody
	public List<BoardVO> loadMorePosts(@RequestParam int page, @RequestParam int pageSize, String postType){
		int startRow = (page -1) * pageSize + 1;
		int endRow = page * pageSize;
		return boardService.selectPostsByPage(startRow, endRow, postType);
	}
	
	//앨범형 등록 폼
	@GetMapping("/albumRegisterForm")
	public String albumRegisterForm(Authentication auth, Model model,
			@RequestParam("boardType")String boardType, @RequestParam("postType")String postType) {
		log.info("albumRegisterForm()실행....!");
		
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = boardService.getMemberByUserName(user.getUsername());
		int currentMemNo = memberVO.getMemNo();
		log.info("CurrentMemNo: {}",currentMemNo);
		model.addAttribute("currentMemNo", currentMemNo);
		model.addAttribute("boardType", boardType);
		model.addAttribute("postType", postType);
		return "board/albumRegister";
	}
		
	//앨범형 등록
	@RequestMapping("/albumRegisterForm")
	public ResponseEntity<Map<String, String>> albumRegister(@RequestPart("boardVO") BoardVO boardVO,
			@RequestPart(value = "file", required = false) MultipartFile[] file,
			@RequestPart(value = "thumbnailImg", required = false) MultipartFile thumbnailImg,
			Authentication authentication, Model model) {
		log.info("album register()실행....!");
		
		boardVO.setAttachedFiles(file);
		boardVO.setThumbnailImgFile(thumbnailImg);
		System.out.println("boardVO :: ");
		System.out.println(boardVO);
		
		// ajax릁 통해 파일 받아오기
		ServiceResult sr = boardService.saveAlbumBoard(boardVO, authentication);
				
		// 그냥 파일 받아오기
		//ServiceResult sr = boardService.insertBoard(boardVO, authentication);
		Map<String, String> response = new HashMap<>();
		response.put("postType", boardVO.getPostType());
		response.put("boardType", boardVO.getBoardType());
		//return new ResponseEntity<String>("success", HttpStatus.OK);
		return ResponseEntity.ok(response);
	}
	
	/*
	@PostMapping("/albumPaging.do")
	public ResponseEntity<PaginationInfoVO<BoardVO>> getAlbumPosts(@RequestBody PaginationInfoVO<BoardVO> pagingVO){
		log.info("pagingVO: {}",pagingVO);
		PaginationInfoVO<BoardVO> albumPosts = boardService.getAlbumPosts(pagingVO);
		return ResponseEntity.ok(albumPosts);
	}*/
	
	@PostMapping("/albumPaging.do")
	public ResponseEntity<PaginationInfoVO<BoardVO>> getAlbumPosts(@RequestBody Map<String, Object> paramMap){
		log.info("paramMap: {}",paramMap);
		paramMap.forEach((key, value) -> {
			log.info("Key: {}, Value: {}",key, value);
		});
		PaginationInfoVO<BoardVO> paging = new PaginationInfoVO<BoardVO>((int)paramMap.get("screenSize"), 1);
		paging.setCurrentPage((int)paramMap.get("currentPage"));
		paging.setPostType((String)paramMap.get("postType"));
		String searchWord = (String)paramMap.get("searchWord");
		if(StringUtils.isNotBlank(searchWord)) {
			paging.setSearchWord(searchWord);
		}
		log.info("paging Info: {}",paging);
		PaginationInfoVO<BoardVO> albumPosts = boardService.getAlbumPosts(paging);
		return ResponseEntity.ok(albumPosts);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/albumList")
	public String albumList(Authentication authentication, Model model, BoardVO boardVO) {
		log.info("albumList 실행");
		
		//List<BoardVO> result = boardService.selectBoardList(authentication);
		//model.addAttribute("boardList", result);
		model.addAttribute("boardType", boardVO.getBoardType());
		model.addAttribute("postType", boardVO.getPostType());
		log.info("boardType: {}",boardVO.getBoardType());
		log.info("postType: {}",boardVO.getPostType());
		return "board/albumList";
	}
	
	//앨범형 리스트
	@GetMapping("/thumbnail/{fileNo}")
	public ResponseEntity<byte[]> getThumbnailImage(@PathVariable int fileNo){
		String resultPath = boardService.getThumbnailImage(fileNo);
		log.info("goHome1101() 실행...!");
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		try {
			in = new FileInputStream(localPath + resultPath);
			headers.setContentType(MediaType.IMAGE_PNG);
			// IOUtils.toByteArray(in) : InputStream의 내용을 byte[]로 가져옵니다.
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			try {
				in.close();
			}
			catch (IOException e) {
				e.printStackTrace();
			}
		} 
		return entity;
	}
	
	
	@GetMapping("/albumDetail/{boardNo}")
	public String getAlbumDetail(@PathVariable int boardNo, Model model, Authentication auth) {
		boardService.incrementHit(boardNo);
		BoardVO board = boardService.getBoardDetail(boardNo);
		List<BoardCommentVO> comments = boardService.selectBoardCommentList(boardNo);
		List<FilesDetailVO> attachedFiles = boardService.getAttachedFilesByFileNo(board.getFileNo());
		//Resource thumbnailImage = boardService.getThumbnailImage(board.getThumbnailFileNo()).getBody();
		//현재 로그인된 사용자 정보
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = boardService.getMemberByUserName(user.getUsername());
		int currentMemNo = memberVO.getMemNo();
		
		log.info("getBoardDetail. boardInfo: {}",board);
		model.addAttribute("board", board);
		model.addAttribute("comments", comments);
		model.addAttribute("currentMemNo", currentMemNo);
		model.addAttribute("attachedFiles", attachedFiles);
		model.addAttribute("postType", board.getPostType());
		/*
		if(thumbnailImage != null) {
			model.addAttribute("thumbnailImage", thumbnailImage);
		}
		*/
		
		return "board/albumDetail";
	}
}
