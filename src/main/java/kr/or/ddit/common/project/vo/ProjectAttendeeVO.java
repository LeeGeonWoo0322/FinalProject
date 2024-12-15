package kr.or.ddit.common.project.vo;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;
import lombok.Data;

@Data
public class ProjectAttendeeVO {
	private int memNo;
	private int projectNo;
	private String memName;
	private String posName;
	List<MemberVO> memNameList;
	List<PositionVO> posNameList;
}
  