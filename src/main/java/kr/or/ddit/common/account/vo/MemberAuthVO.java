package kr.or.ddit.common.account.vo;

import lombok.Data;


@Data
public class MemberAuthVO {
	
	private int maNo;
	private int memNo;
	private String memAuth;
	private String secretkey;
}
