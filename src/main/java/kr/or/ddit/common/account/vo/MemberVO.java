package kr.or.ddit.common.account.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.attend.vo.AttendanceVO;
import lombok.Data;


@Data
public class MemberVO {
	
	private int memNo;
	private int posNo;
	private int deptNo;
	private int wtNo;
	private String memId;
	private String memPw;
	private String memName;
	private String memTel;
	private String memEmail;
	private String memAddr1;
	private String memAddr2;
	private String memPost;
	private String hireDate;
	private String memStatus;
	private String driverLicense;
	private String memProfileimg;
	private String tempPwYn;
	private String enabled;
	private int workVaca;
	private String driveVolume;
	private String memCardImage;
	private String memCardMemo;
	private long mailVolume;
	private int secNo;
	private List<MemberAuthVO> memAuth;
	private List<PositionVO> posList;
	
	private String posName;
	private String deptName;
	
	private String abNo;
	private String abName;
	
	private MultipartFile memImgFile;
	private MultipartFile cardImgFile;
	
	private List<String> memNames;
	private List<AttendanceVO> memAttendance;
	
	private String importYn;
	
	
}
