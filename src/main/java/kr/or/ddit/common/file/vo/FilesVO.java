package kr.or.ddit.common.file.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//board
@Data
public class FilesVO {
	
	private int fileNo;				 // 파일 번호
	private String fileCategory;     // 파일구분명
	private int memNo;	             // 등록자 - 사원번호
	private String delYn; 			 // 삭제여부
	
	private List<MultipartFile> fileList;
	private List<FilesDetailVO> filesDetailList;

	public FilesVO(){
		
	}
	
	public FilesVO(String fileCategory, int memNo){
		this.fileCategory = fileCategory;
		this.memNo = memNo;
	}
	
}
