package kr.or.ddit.common.file.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FilesDetailVO {
	private MultipartFile item;
	
	private int fileNo;			          	 // 파일 번호
	private int fileDetailNo;			   	 // 첨부파일상세번호
	private String filePath;                 // 파일저장경로
	private long fileSize;					 // 파일사이즈
	private String fileMime;				 // 파일확장자
	private String fileOriginalname;         // 파일원본명
	private String fileUploadname;           // 파일저장명
	private String regDate;                  // 등록일
	private int memNo;	                     // 등록자 - 사원번호
	private String delYn;	                 // 파일삭제여부 default 'N'
	private String recDelYn;
	private int downloadCnt;                 // 다운로드 횟수
	
	public FilesDetailVO() {}
	
	public FilesDetailVO(MultipartFile item) {
		this.item = item;
		this.fileOriginalname = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMime = item.getContentType();
	}
	
}





