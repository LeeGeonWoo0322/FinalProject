package kr.or.ddit.common.drive.vo;

import lombok.Data;

@Data
public class DriveFileVO {
	private int dfNo;			// 파일 번호
	private int folderNo;		// 폴더 번호
	private int memNo;			// 사원번호
	private String dfName;		// 파일이름
	private String dfPath;		// 파일 경로
	private int dfSize;			// 파일 크기
	private String dfMime;		// 파일 타입
	private String dfCreate;	// 생성일	- sysdate
	private String dfUpdate;	// 수정일	- 기본값 null - 수정 쿼리에 sysdate로 넣으면 됨
	private int dfType;			// 타입	- 1: 개인 / 2: 전사
	private String dfDelYn;		// 삭제

}
