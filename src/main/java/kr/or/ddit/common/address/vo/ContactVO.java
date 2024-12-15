package kr.or.ddit.common.address.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ContactVO {
	private int conNo;
	private int abNo;
	private String conProfile;
	private String conName;
	private String conCom;
	private String conDept;
	private String conPos;
	private String conEmail;
	private String conTel;
	private String conComTel;
	private String conComAddr;
	private String conComFax;
	private String conMemo;
	private String importYn;
	
	private MultipartFile conProfileImg;
}
