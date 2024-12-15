package kr.or.ddit.common.board.vo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import lombok.Data;

@Data
public class BoardVO {
	private int boardNo;            // 게시판 번호
	private int memNo;			    // 게시판 작성자	 - 사원번호
	private String boardTitle;      // 제목
	private String boardContent;    // 내용
	private String boardCreate;     // 작성일
	private String boardUpdate;     // 수정일
	private String boardType;       // 게시판 타입
	private String postType;        // 게시물 타입
	private String boardNotice;     // 공지여부 default 'N'
	private String boardAlarm;      // 알림여부 default 'N'
	private int boardHit;           // 조회수
	private int fileNo;             // 게시판 첨부파일 번호
	private Integer thumbnailFileNo;	// 게시판 섬네일 첨부파일 번호
	private int postNo;				// 게시글 번호
	private String postImg;         // 게시글 이미지
	
	private String delYn;          // 파일 삭제여부 - 파일 있고 없고 판단을 위해
	
	private String memName;			// 게시글 작성자명
	private List<BoardCommentVO> comments;
	
	private MultipartFile thumbnailImgFile;
	private MultipartFile[] attachedFiles;
	private List<FilesVO> fileList;
	private List<FilesDetailVO> fileDetailList = new ArrayList<FilesDetailVO>();
	private FilesVO thumbnailFiles;
	private FilesDetailVO thumbnailFileDetail;
	
	public void setAttachedFiles(MultipartFile[] attachedFiles) {
	    // null 체크 및 빈 배열 처리
	    if (attachedFiles == null || attachedFiles.length == 0) {
	        this.attachedFiles = new MultipartFile[0]; // 빈 배열로 초기화
	        fileDetailList.clear(); // 파일 세부 리스트 초기화
	        return;
	    }

	    // null이 아닌 파일과 이름이 비어있지 않은 파일 필터링
	    this.attachedFiles = Arrays.stream(attachedFiles)
	            .filter(file -> file != null && !StringUtils.isBlank(file.getOriginalFilename()))
	            .toArray(MultipartFile[]::new);

	    // fileDetailList 초기화
	    fileDetailList.clear(); // 이전 파일 세부 정보 초기화

	    // 유효한 파일이 있는 경우에만 세부 정보 추가
	    if (this.attachedFiles.length > 0) {
	        for (MultipartFile file : this.attachedFiles) {
	            if (!file.isEmpty()) {
	                fileDetailList.add(new FilesDetailVO(file));
	            }
	        }
	    }
	}
}