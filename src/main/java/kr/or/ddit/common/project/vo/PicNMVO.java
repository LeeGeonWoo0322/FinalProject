package kr.or.ddit.common.project.vo;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import lombok.Data;

@Data
public class PicNMVO {
	private int workNo;
	private int memNo;
	private String memName;
	private String posName;
	List<Integer> memNoList;
	List<MemberVO> memberList;
}
  