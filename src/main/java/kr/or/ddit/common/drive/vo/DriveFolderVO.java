package kr.or.ddit.common.drive.vo;

import lombok.Data;

@Data
public class DriveFolderVO {
	
	private int folderNo;			// 폴더 번호
	private int memNo;				// 사원번호
	private String folderName;		// 폴더 이름
	private int folderParentNo;	// 상위폴더 이름 		-> 없으면 최상위 폴더임
	private String folderCreate;	// 폴더 생성날짜		(시간 포함됨 알아서 잘 잘라야 함)
	private int folderType;		// 폴더 타입 		- 1: 개인 / 2: 전사

}
