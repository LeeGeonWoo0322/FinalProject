package kr.or.ddit.common.board.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.core.io.UrlResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.board.mapper.BoardMapper;
import kr.or.ddit.common.board.service.BoardService;
import kr.or.ddit.common.board.vo.BoardCommentVO;
import kr.or.ddit.common.board.vo.BoardVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Resource(name="localPath")
	private String localPath;
	
	@Inject
	private BoardMapper boardMapper;
	
	// 게시글 조회
	@Override
	public List<BoardVO> selectBoardList(Authentication authentication){
		log.debug("selectBoardList 호출됨");
		List<BoardVO> result = null;
		
		result = boardMapper.selectBoardList();
		
		return result;
	}
	
	// 등록
	@Override
	@Transactional
	public ServiceResult insertForm(BoardVO boardVO
			,Authentication authentication
			) {
		ServiceResult result = ServiceResult.OK;
		
		// security 적용된 memNo 값 가져오기
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = boardMapper.getId(user.getUsername());
		log.info("memberVO :: " + memberVO);
		
		//boardVO.setMemNo(1);
		boardVO.setMemNo(memberVO.getMemNo());
		//boardVO.setBoardType("전사게시판");
		//boardVO.setPostType("사내공지");
		
		List<FilesDetailVO> noticeFileList = boardVO.getFileDetailList();
		String locate = localPath + "/board/board";
		
		if(noticeFileList != null && noticeFileList.size() > 0) {
			
			FilesVO filesVO = new FilesVO();
			
			filesVO.setMemNo(memberVO.getMemNo());
			//filesVO.setMemNo(1);
			filesVO.setFileCategory(boardVO.getPostType());
			
			int status = boardMapper.insertBoardFile(filesVO);
			
			if(status > 0) {	// 등록 성공
				
				String saveLocate ;
				File file = new File(locate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				boardVO.setFileNo(filesVO.getFileNo());
				
				for(FilesDetailVO filesDetailVO : noticeFileList) {
					String saveName = UUID.randomUUID().toString();		// UUID의 랜덤 파일명 생성
					saveName += "_" + filesDetailVO.getFileOriginalname();
					saveLocate = locate + "/" + saveName;	// 파일 복사를 위한 경로 설정
					
					// 파일 데이터를 추가 하기 위한 준비
					filesDetailVO.setMemNo(memberVO.getMemNo());
					filesDetailVO.setFileNo(filesVO.getFileNo());
					filesDetailVO.setFilePath("/board/board/" + saveName);
					filesDetailVO.setFileUploadname(saveName);
					boardMapper.insertBoardDetailFile(filesDetailVO);
					
					File saveFile = new File(saveLocate);
					try {
						filesDetailVO.getItem().transferTo(saveFile);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}	// 파일 복사
				}
				
			}else {				// 등록 실패
				result = ServiceResult.FAILED;
			}
			
		}
		
		boardMapper.insertBoard(boardVO);
		
		return result;
	}
	
	

	
	// 파일 다운로드
	@Override
	public FilesDetailVO boardDownload(FilesDetailVO filesDetailVO) {
		
		return boardMapper.boardDownload(filesDetailVO);
	}
	
	
	
	// submit으로 했을경우
	@Override
	public ServiceResult insertBoard(BoardVO boardVO, Authentication authentication) {
		// TODO Auto-generated method stub
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = boardMapper.getId(user.getUsername());
		boardVO.setMemNo(memberVO.getMemNo());
		
		//파일 처리
		MultipartFile[] files = boardVO.getAttachedFiles();
		if(files != null && files.length > 0) {
			FilesVO filesVO = saveFiles(memberVO.getMemNo(), files, boardVO.getPostType());
			if(filesVO.getFileNo()==0) {
				log.error("저장한 File 번호가 정상적이지 않음: {} ",filesVO);
			}
			boardVO.setFileNo(filesVO.getFileNo());
		}
		
		boardMapper.insertBoard(boardVO);
		return ServiceResult.OK;
	}
	
	
	//앨범 파일 DB등록
	private FilesVO saveFiles(int memNo, MultipartFile[] files, String fileCategory) {
		FilesVO filesVO = new FilesVO();
		filesVO.setMemNo(memNo);
		filesVO.setFileCategory(fileCategory);
		
		boardMapper.insertBoardFile(filesVO);
		
//		String savePath = localPath + "/" + fileCategory;
		String savePath = "/board" + "/" + fileCategory;
		
		File directory = new File(localPath + savePath);
		if(!directory.exists()) {
			directory.mkdirs();
		}
		List<FilesDetailVO> fileDetailList = new ArrayList();
		for(MultipartFile file : files) {
			fileDetailList.add(saveFileDetail(filesVO.getFileNo(), memNo, savePath, file));
		}
		filesVO.setFilesDetailList(fileDetailList);
		
		return filesVO;

	}
	
		
	//조회수 
	@Override
	public void incrementHit(int boardNo) {
		// TODO Auto-generated method stub
		boardMapper.incrementHit(boardNo);
		
	}
	
	
	private FilesDetailVO saveFileDetail(int fileNo, int memNo, String savePath, MultipartFile file) {
		
		String saveName = UUID.randomUUID().toString()+"_"+file.getOriginalFilename();
		String fullPath = savePath+"/"+saveName;
		FilesDetailVO fileDetail = new FilesDetailVO(file);
		fileDetail.setMemNo(memNo);
		fileDetail.setFileNo(fileNo);
		fileDetail.setFilePath(fullPath);
		fileDetail.setFileUploadname(saveName);
		boardMapper.insertBoardDetailFile(fileDetail);
		try {
			file.transferTo(new File(localPath + fullPath));
		}catch(IOException e) {
			log.error("파일 저장 중 오류 발생. 파일정보 : {}",file);
		}
		return fileDetail;
	}



	@Override
	public BoardVO getBoardDetail(int boardNo) {

		return boardMapper.selectBoardDetail(boardNo);
	}

	@Override
	public List<BoardCommentVO> selectBoardCommentList(int boardNo) {
	
		return boardMapper.selectBoardComments(boardNo);
	}

	@Override
	public void addComment(BoardCommentVO commentVO, Authentication authentication) {
		User user = (User) authentication.getPrincipal();
		MemberVO memberVO = boardMapper.getId(user.getUsername());
		commentVO.setMemNo(memberVO.getMemNo());
		boardMapper.insertComment(commentVO);
		
	}

	@Override
	public void updateComment(BoardCommentVO commentVO, Authentication authentication) {
		boardMapper.updateComment(commentVO);
	}
	

	@Override
	public void deleteComment(int cmntNo, Authentication authentication) {
		boardMapper.deleteComment(cmntNo);
	}
	

	@Override
	public MemberVO getMemberByUserName(String userName) {

		MemberVO memberVO = boardMapper.getId(userName);
		return memberVO;
	}
	

	@Override
	public List<FilesDetailVO> getAttachedFilesByFileNo(int fileNo){
		return boardMapper.selectAttachedFilesByFileNo(fileNo);
	}
	
	@Override
	public FilesDetailVO getFileDetail(int fileDetailNo) {
		return boardMapper.selectFileDetail(fileDetailNo);
	}
	

	public void updateBoardWithFiles(BoardVO boardVO, Integer[] deleteFileNos) {
		//게시글 수정 
		boardMapper.updateBoard(boardVO);
		
		//첨부파일 삭제
		if(deleteFileNos != null) {
			log.info("deleteFileNos : {}",deleteFileNos);
			for(Integer fileDetailNo : deleteFileNos) {
				boardMapper.markFileDetailAsDeletedByFileDetailNo(fileDetailNo);
			}
		}else {
			log.error("deleteFileNos is Empty.");
		}
		
		//새파일 추가 처리
		if(boardVO.getAttachedFiles()!=null && boardVO.getAttachedFiles().length>0) {
			log.debug("attached File Length: {}", boardVO.getAttachedFiles().length);
			//기존 게시글이 FILE_NO가 없었던 경우라면 새로운 FILE_NO생성해줘야함
			if(boardVO.getFileNo() == 0) {
				FilesVO filesVO = new FilesVO();
				filesVO.setFileCategory(boardVO.getPostType());
				filesVO.setMemNo(boardVO.getMemNo());
				
				//FILES 테이블에 파일 그룹 레코드 추가
				boardMapper.insertBoardFile(filesVO);
				
				// 새로 생성된 file_no 설정 및 DB 저장 
				boardVO.setFileNo(filesVO.getFileNo());
				boardMapper.updateBoardFileNo(boardVO);
			}
//			String savePath = localPath + "/" + boardVO.getPostType();
			String savePath = "/board/modify"; 
			
			File directory = new File(localPath + savePath);
			if(!directory.exists()) {
				directory.mkdirs();
			}
			
			for(MultipartFile file : boardVO.getAttachedFiles()) {
				saveFileDetail(boardVO.getFileNo(), boardVO.getMemNo(), savePath, file);
			}
			
		}
	}
	
	@Transactional
	@Override
	public void deleteBoardWithFilesAndComments(int boardNo) {
		//댓글 삭제
		boardMapper.deleteCommentsByBoardNo(boardNo);
		
		//파일 및 파일 디테일 삭제
		Integer fileNo = boardMapper.getFileNoByBoardNo(boardNo);
		if(fileNo != null) {
			//삭제 대상 게시글 첨부파일 테이블 데이터 논리적 삭제 처리
			boardMapper.markFileDetailAsDeletedByFileNo(fileNo);
			//삭제 대상 게시글 파일 테이블 데이터 삭제 처리
			boardMapper.markFileAsDeletedByFileNo(fileNo);
		}
		
		//게시글 삭제
		boardMapper.deleteBoard(boardNo);
	}
	
	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.selectBoardCount(pagingVO);
	}
	public List<BoardVO> selectBoardListNew(PaginationInfoVO<BoardVO> pagingVO){
		return boardMapper.selectBoardListNew(pagingVO);
	}
	public List<BoardVO> selectBoardNoticeList(String postType){
		return boardMapper.selectBoardNoticeList(postType);
	}
	public List<BoardVO> selectPostsByPage(int startRow, int endRow, String postType){
		return boardMapper.selectPostsByPage(startRow, endRow, postType);
	}
	
	
	//앨범형 등록
	public ServiceResult saveAlbumBoard(BoardVO boardVO, Authentication auth) {
		ServiceResult result = ServiceResult.OK;
		User user = (User) auth.getPrincipal();
		MemberVO memberVO = boardMapper.getId(user.getUsername());
		boardVO.setMemNo(memberVO.getMemNo());
		
		MultipartFile[] files = boardVO.getAttachedFiles();
		if(files != null && files.length > 0) {
			FilesVO filesVO = saveFiles(memberVO.getMemNo(), files, boardVO.getPostType());
			if(filesVO.getFileNo()==0) {
				log.error("저장한 File 번호가 정상적이지 않음: {}",filesVO);
			}
			boardVO.setFileNo(filesVO.getFileNo());
		}
		MultipartFile thumbnailFile = boardVO.getThumbnailImgFile();
		if(thumbnailFile!=null && !thumbnailFile.isEmpty()) {
			FilesVO fileVO = saveFiles(memberVO.getMemNo(), new MultipartFile[] {thumbnailFile}, boardVO.getPostType());
			if(fileVO.getFileNo()==0) {
				log.error("저장한 thumbnail File 번호가 정상적이지 않음: {}",fileVO);
			}
			boardVO.setThumbnailFileNo(fileVO.getFileNo());
		}
		log.info("boardAlbumData: {}", boardVO);
		boardMapper.insertBoard(boardVO);
		return result;
	}
	
	
	
	@Override
	public PaginationInfoVO<BoardVO> getAlbumPosts(PaginationInfoVO<BoardVO> pagingVO){
		log.info("getAlbUmPosts: {}",pagingVO);
		int totalRecord = boardMapper.selectBoardCount(pagingVO);
		log.info("totalRecord: {}",totalRecord);
		pagingVO.setTotalRecord(totalRecord);
		List<BoardVO> dataList = boardMapper.selectAlbumBoardList(pagingVO);
		log.info("dataList: {}",dataList);
		pagingVO.setDataList(dataList);
		return pagingVO;
		
	}
	
	@Override
	public String getThumbnailImage(int fileNo){
		FilesDetailVO fileDetail = boardMapper.selectThumbnailFileDetail(fileNo);
		Path filePath  = null;
		if(fileDetail == null || fileDetail.getFilePath() == null) {
			//Path filePath = Paths.get(fileDetail.getFilePath()).normalize();
		}
		String filePaths = "/resources/images/image_icon.jpg";
		
//		filePath = Paths.get(fileDetail.getFilePath()).normalize();
//		org.springframework.core.io.Resource resource;
//		try {
//			resource = new UrlResource(filePath.toUri());
		filePaths = fileDetail.getFilePath();
//		String[] divTexts = filePaths.split("/");
//		String resURL = "";
//		for(int i = 0; i < divTexts.length; i++) {
//			String encodingText = divTexts[i];
//			if(i > 2) {
//				 try {
//					encodingText = URLEncoder.encode(divTexts[i], "UTF-8");
//				} catch (UnsupportedEncodingException e) {
//					e.printStackTrace();
//				}
//			}
//			resURL += encodingText;
//			if(i < divTexts.length - 1) {
//				resURL += "/";
//			}
//		}
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		return filePaths;
	}
	
	@Transactional
	@Override
	public void deleteThumbnail(BoardVO board) {
		//썸네일 detail논리적 삭제처리
		boardMapper.markFileDetailAsDeletedByFileNo(board.getThumbnailFileNo());
		//썸네일 file 논리적 삭제처리
		boardMapper.markFileAsDeletedByFileNo(board.getThumbnailFileNo());
		board.setThumbnailFileNo(null);
		boardMapper.updateBoardThumbnailFileNo(board);
	}
	
	@Override
	@Transactional
	public void updateThumbnail(BoardVO board) {	
		log.info("updateThumbnail with : {}",board);
		MultipartFile thumbnailFile = board.getThumbnailImgFile();
		if(thumbnailFile != null && !thumbnailFile.isEmpty()) {
			
			FilesVO fileVO = saveFiles(board.getMemNo(), new MultipartFile[] {thumbnailFile}, board.getPostType());
			if(fileVO.getFileNo()==0) {
				log.error("저장한 썸네일 파일번호가 정상적이지 않음");
			}
			board.setThumbnailFileNo(fileVO.getFileNo());
			boardMapper.updateBoardThumbnailFileNo(board);
		}
	
	}
	
	//전체 알림
	@Override
	public List<MemberVO> memberAalarmList() {
		return boardMapper.memberAalarmList();
	}

	@Override
	public List<BoardVO> previousList(BoardVO board) {
		// TODO Auto-generated method stub
		return boardMapper.previousList(board);
	}

	// HomeController
	@Override
	public List<BoardVO> homeNoticeList() {
		// TODO Auto-generated method stub
		return boardMapper.homeNoticeList();
	}




}
