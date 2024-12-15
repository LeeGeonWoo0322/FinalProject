package kr.or.ddit.common.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardCommentVO {
	private int cmntNo;			    // 댓글번호
	private int boardNo;			// 게시판 번호
	private String cmntContent;     // 댓글 내용
	private Date regDate;         // 등록일시
	private int memNo;	            // 댓글 작성자 - 사원번호
	private String commentWriter;	// 댓글 작성자명

}

