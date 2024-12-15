package kr.or.ddit.common.mail.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import lombok.Data;

@Data
public class MailVO {
	private int mailNo;
	private int memNo;
	private int mailRowNo;
	private String memName;
	private String memEmail;
	private String PosName;
	private String DeptName;
	private String mailTitle;
	private String mailContent;
	private String mailDate;
	private int fileNo;
	private String mailStatus;
	private String mailRes;
	private String mailFavYn;
	private String mailImp;
	private String mailResDate;
	private String mailResTime;
	private String mailReadYn;
	private String mailDelYn;
	private String mailGb;
	private String conDelYn;
	private String mailSecurityYn;
	
	private List<MailRecipientVO> recipientList;
	private List<FilesDetailVO> fileList;
	private List<MultipartFile> file;
	private List<Integer> dbFile;
	
	public MailVO() {
		
	}
	
	public MailVO(int memNo, String mailTitle, String mailContent) {
		this.memNo = memNo;
		this.mailTitle = mailTitle;
		this.mailContent = mailContent;
		this.fileNo = 0;
		this.mailStatus = "전송";
		this.mailRes = "N";
		this.mailImp = "N";
		this.mailReadYn = "N";
		this.mailSecurityYn = "N";
	}
}
