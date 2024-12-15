package kr.or.ddit.common.approval.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SealVO {
	private int memNo;
	private String sealImg;
	private String sealName;
	private String selImg;
	
	private MultipartFile sealImgFile;
}
