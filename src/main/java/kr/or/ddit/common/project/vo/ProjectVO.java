package kr.or.ddit.common.project.vo;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;
import lombok.Data;

@Data
public class ProjectVO {
	private int projectNo;
	private int mngPicNo;
	private String projectTitle;
	private String regDate;
	private String endDate;
	
	private String mngMemName;
	private String mngPosName;
	
	private int totalField;
	
	private List<WorkVO> workNoList;
	private List<ProjectAttendeeVO> paList;
	
	private List<Integer> fileNoList;
	private List<Integer> workList;
	private List<Integer> memNoList;
	private List<Integer> proAList;
	private List<Integer> picMemList;
}
  