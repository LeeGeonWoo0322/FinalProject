package kr.or.ddit.common.project.vo;

import java.util.List;

import lombok.Data;

@Data
public class WorkFavoriteVO {
	private int workNo;  
	private int memNo;
	private String favoriteY;
	private int projectNo;
	
	private String workTitle;
	private String regDate;
	private String endDate;
	private String workPrograss;
	private List<PicNMVO> faPicList;
}
