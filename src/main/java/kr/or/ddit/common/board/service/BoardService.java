package kr.or.ddit.common.board.service;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.board.vo.BoardCommentVO;
import kr.or.ddit.common.board.vo.BoardVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;

public interface BoardService {


	public FilesDetailVO boardDownload(FilesDetailVO filesDetailVO);

	public ServiceResult insertForm(BoardVO boardVO, Authentication authentication);
	
	public ServiceResult insertBoard(BoardVO boardVO, Authentication authentication);
	
	public List<BoardVO> selectBoardList(Authentication authentication);
	public List<BoardVO> selectBoardListNew(PaginationInfoVO<BoardVO> pagingVO);
	public List<BoardVO> selectBoardNoticeList(String postType);
	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);
	public void incrementHit(int boardNo);
	
	public BoardVO getBoardDetail(int boardNo);
	
	public List<BoardCommentVO> selectBoardCommentList(int boardNo);
	public void addComment(BoardCommentVO commentVO, Authentication authentication);
	public void updateComment(BoardCommentVO commentVO, Authentication authentication);
	public void deleteComment(int cmntNo, Authentication authentication);
	
	public MemberVO getMemberByUserName(String userName);
	
	public List<FilesDetailVO> getAttachedFilesByFileNo(int fileNo);
	public FilesDetailVO getFileDetail(int fileDetailNo);
	
	public void updateBoardWithFiles(BoardVO boardVO, Integer[] deleteFileNos);

	public void deleteBoardWithFilesAndComments(int boardNo);
	public List<BoardVO> selectPostsByPage(int startRow, int endRow, String postType);
	public ServiceResult saveAlbumBoard(BoardVO boardVO, Authentication auth);
	public PaginationInfoVO<BoardVO> getAlbumPosts(PaginationInfoVO<BoardVO> pagingVO);
	public String getThumbnailImage(int fileNo);
	public void deleteThumbnail(BoardVO board);
	public void updateThumbnail(BoardVO board);

	public List<MemberVO> memberAalarmList();

	public List<BoardVO> previousList(BoardVO board);
	
	// HomeController
	public List<BoardVO> homeNoticeList();



	

	
}
