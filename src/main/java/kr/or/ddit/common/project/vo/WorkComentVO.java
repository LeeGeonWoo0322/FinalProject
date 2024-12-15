package kr.or.ddit.common.project.vo;

import lombok.Data;

@Data
public class WorkComentVO {
	private int cmntNo;
	private int workNo;
	private String cmntContent;
	private String regDate;
	private int writerNo;
	
	private String memName;
	private String posName;
}
  