package kr.or.ddit.common.mail.service;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.mail.vo.MailBlockListVO;
import kr.or.ddit.common.mail.vo.MailBlockWordVO;
import kr.or.ddit.common.mail.vo.MailBoxVO;
import kr.or.ddit.common.mail.vo.MailOutOfOfficeVO;
import kr.or.ddit.common.mail.vo.MailRecipientVO;
import kr.or.ddit.common.mail.vo.MailTagVO;
import kr.or.ddit.common.mail.vo.MailVO;
import kr.or.ddit.common.mail.vo.RecipientTagVO;

public interface IMailService {

	int sendMail(MailVO mail, List<Map<String, List<String>>> recipientData, Authentication authentication) throws IOException ;

	int getInboxUnreadCnt(MemberVO member);

	int getSentUnreadCnt(MemberVO member);

	int getTempUnreadCnt(MemberVO member);

	int getResUnreadCnt(MemberVO member);

	int getSpamUnreadCnt(MemberVO member);

	int getTrashUnreadCnt(MemberVO member);

	int addTagList(MailTagVO mailTag);

	List<MailTagVO> getTagList(MemberVO member);

	MailTagVO getLastMailTag(MemberVO member);

	int modifyTagList(MailTagVO mailTagList);

	int deleteTagList(MailTagVO mailTagList);

	MailVO getMailByNo(int mailNo);
	
	MailRecipientVO getRecMailInfo(MailRecipientVO mailRecipientInfo);

	MailRecipientVO getSenderMailInfo(MailRecipientVO mailRecipientInfo);

	MailRecipientVO getUnifiedMailInfo(MailRecipientVO mailRecipientInfo);
	
	int checkBlock(MailBlockListVO blockListVO);

	void senderAddTrash(MailRecipientVO recipientVO);
	
	void recAddTrash(MailRecipientVO recipientVO);
	
	void changeSenderFav(MailRecipientVO recipientVO);

	void changeRecipientFav(MailRecipientVO recipientVO);

	List<MailRecipientVO> selectRecMailList(PaginationInfoVO<MailRecipientVO> pagingVO);

	List<MailRecipientVO> selectSenderMailList(PaginationInfoVO<MailRecipientVO> pagingVO);

	List<MailRecipientVO> selectUnifiedMailList(PaginationInfoVO<MailRecipientVO> pagingVO);

	List<MemberVO> searchMembers(String searchWord);

	List<MailRecipientVO> getRecentMailList(int memNo);

	void deleteMemFile(int fileNo);

	void deleteRecipientFile(int fileNo);
	
	void deleteMemFileDetail(int fileNo);
	
	void deleteRecipientFileDetail(int fileNo);

	List<FilesDetailVO> getFileDetailList(int fileNo);

	void senderCompletelyDelete(MailRecipientVO recipientVO);

	void recCompletelyDelete(MailRecipientVO recipientVO);

	void applyTag(RecipientTagVO recipientTagVO);

	List<MailTagVO> getTag(MemberVO member);

	List<Integer> tagCheck(int chechedRecNo);

	void unApplyTag(RecipientTagVO recipientTagVO);

	void readSenderMail(MailRecipientVO mailRecipientInfo);

	void readRecMail(MailRecipientVO mailRecipientInfo);

	void unreadSenderMail(MailRecipientVO recipientVO);

	void unreadRecMail(MailRecipientVO recipientVO);

	void addMailBox(MailBoxVO mailBoxVO);

	MailBoxVO getLastMailBox(MemberVO member);

	List<MailBoxVO> getMailBoxList(MemberVO member);

	void unBlockList(MailBlockListVO blockListVO);

	void senderUnTrash(MailRecipientVO recipientVO);

	void recUnTrash(MailRecipientVO recipientVO);

	List<MailVO> getConfirmationMailList(PaginationInfoVO<MailRecipientVO> pagingVO);

	void deleteConfirmationMail(int deleteConfirmationNo);

	void cancleSend(int mailNo);

	void moveMail(MailBoxVO mailBoxVO);

	MailBoxVO getMailBoxNo(PaginationInfoVO<MailRecipientVO> pagingVO);

	void moveInbox(int recNo);

	void emptyMailBox(int emptyMailBoxNo);

	void modifyMailBox(MailBoxVO mailBoxVO);

	void deleteMailBox(int deleteMailBoxNo);

	public void sendReservationMail() throws ParseException;

	MailBlockWordVO addBlockWord(MailBlockWordVO mailBlockWordVO);

	void deleteAllBlockWord(MemberVO member);

	void deleteBlockWord(int deleteNo);

	List<MailBlockWordVO> getBlockWordList(MemberVO member);

	MailBlockListVO addBlockList(MailBlockListVO mailBlockListVO);

	void deleteBlockList(int deleteNo);

	void deleteAllBlockList(MemberVO member);

	List<MailBlockListVO> getBlockList(MemberVO member);

	MailOutOfOfficeVO checkUsedOutOfOffice(int memNo);

	void insertOutOfOffice(MailOutOfOfficeVO mailOutOfOfficeVO);

	void updateOutOfOffice(MailOutOfOfficeVO mailOutOfOfficeVO);

	int checkPassword(MemberVO member);

	Long getMailCapacity(MemberVO member);

	void reqAddCapacity(UpgradeReqVO upgradeReqVO);

	UpgradeReqVO checkReqAddCapacity(MemberVO member);

	FilesDetailVO getFileDetailListByDetailNo(int fileNo);

	List<DepartmentVO> getDeptList();

	List<MemberVO> getDeptMember(DepartmentVO departmentVO);

	List<MailRecipientVO> getTagMail(RecipientTagVO recipientTagVO);

	MailRecipientVO getMailRecipient(MailRecipientVO mailRecipientVO);

	MailBoxVO getMailBoxNoByRec(MailRecipientVO mailRecipientInfo);

}
