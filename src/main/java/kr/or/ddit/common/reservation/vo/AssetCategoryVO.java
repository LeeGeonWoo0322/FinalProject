package kr.or.ddit.common.reservation.vo;

import lombok.Data;

@Data
public class AssetCategoryVO {
	private int acNo;
	private String acName;
	private String acRepYn;
	private String acUseStart;
	private String acUseEnd;
	private String acUseWeek;
	private int acUseAuth;
	private int memNo;
	private String acUseStop;
	private String acDelYn;
	private String acUseInfo;
	private int acAssetCnt;
}
