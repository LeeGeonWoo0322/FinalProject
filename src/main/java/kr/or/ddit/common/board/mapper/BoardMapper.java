package kr.or.ddit.common.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.board.vo.BoardCommentVO;
import kr.or.ddit.common.board.vo.BoardVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;

public interface BoardMapper {

	public void insertBoard(BoardVO boardVO);

	public int insertBoardFile(FilesVO filesVO);
	
	public void insertBoardDetailFile(FilesDetailVO filesDetailVO);

	FilesDetailVO boardDownload(FilesDetailVO filesDetailVO);

	public void fileNoNextval(BoardVO boardVO);

	public FilesVO selectBoardFile();

	public MemberVO getId(String username);
	
	public List<BoardVO> selectBoardList();
	public List<BoardVO> selectBoardListNew(PaginationInfoVO<BoardVO> pagingVO);
	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);
	
	public void incrementHit(int boardNo);
	
	public BoardVO selectBoardDetail(int boardNo);
	public List<BoardCommentVO> selectBoardComments(int boardNo);
	public int insertComment(BoardCommentVO commentVO);
	public int updateComment(BoardCommentVO commentVO);
	public int deleteComment(int cmntNo);
	public int deleteCommentsByBoardNo(int boardNo);
	public List<FilesDetailVO> selectAttachedFilesByFileNo(int fileNo);
	public FilesDetailVO selectFileDetail(int fileDetailNo);
	public void markFileDetailAsDeletedByFileDetailNo(int fileDetailNo);
	public void updateBoardFileNo(BoardVO boardVO);
	public void updateBoard(BoardVO boardVO);
	public void deleteBoard(int boardNo);
	public void markFileDetailAsDeletedByFileNo(int fileNo);
	public void markFileAsDeletedByFileNo(int fileNo);
	public int getFileNoByBoardNo(int boardNo);
	public List<BoardVO> selectBoardNoticeList(String postType);
	public List<BoardVO> selectAlbumBoardList(PaginationInfoVO<BoardVO> pagingVO);
	public List<BoardVO> selectPostsByPage(@Param("startRow") int startRow, @Param("endRow") int endRow, @Param("postType")String postType);
	public FilesDetailVO selectThumbnailFileDetail(int fileNo);
	public void updateBoardThumbnailFileNo(BoardVO boardVO);

	public List<MemberVO> memberAalarmList();

	public List<BoardVO> previousList(BoardVO board);
	
	// HomeController
	public List<BoardVO> homeNoticeList();
	



	


}
