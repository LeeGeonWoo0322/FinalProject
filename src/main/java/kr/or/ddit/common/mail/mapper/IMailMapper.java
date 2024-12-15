package kr.or.ddit.common.mail.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import kr.or.ddit.common.mail.vo.MailBlockListVO;
import kr.or.ddit.common.mail.vo.MailBlockWordVO;
import kr.or.ddit.common.mail.vo.MailBoxVO;
import kr.or.ddit.common.mail.vo.MailOutOfOfficeVO;
import kr.or.ddit.common.mail.vo.MailRecipientVO;
import kr.or.ddit.common.mail.vo.MailTagVO;
import kr.or.ddit.common.mail.vo.MailVO;
import kr.or.ddit.common.mail.vo.RecipientTagVO;

public interface IMailMapper {

	public int insertFile(FilesVO files);

	public int insertFileDetail(FilesDetailVO filesDetailVO);

	public int insertMail(MailVO mail);

	public FilesVO getLastFile();

	public MailVO getLastMail();

	public MemberVO getRecipient(String recipient);

	public void insertRecipient(MailRecipientVO mailRecipient);

	public int getInboxUnreadCnt(MemberVO member);

	public int getSentUnreadCnt(MemberVO member);

	public int getTempUnreadCnt(MemberVO member);

	public int getResUnreadCnt(MemberVO member);

	public int getSpamUnreadCnt(MemberVO member);

	public int getTrashUnreadCnt(MemberVO member);

	public int addTagList(MailTagVO mailTag);

	public List<MailTagVO> getTagList(MemberVO member);

	public MailTagVO getLastMailTag(MemberVO member);

	public int modifyTagList(MailTagVO mailTagList);

	public int deleteTagList(MailTagVO mailTagList);

	public int addBlockList(MailBlockListVO blockListVO);

	public MailVO getMailByNo(int mailNo);

	public List<MailRecipientVO> getMailRecipientInfoByMailNo(int mailNo);

	public int checkBlock(MailBlockListVO blockListVO);

	public void senderAddTrash(MailRecipientVO recipientVO);

	public void recAddTrash(MailRecipientVO recipientVO);
	
	public void changeSenderFav(MailRecipientVO recipientVO);
	
	public void changeRecipientFav(MailRecipientVO recipientVO);

	public List<MailRecipientVO> selectRecMailList(PaginationInfoVO<MailRecipientVO> pagingVO);

	public List<MailRecipientVO> selectSenderMailList(PaginationInfoVO<MailRecipientVO> pagingVO);

	public List<MailRecipientVO> selectUnifiedMailList(PaginationInfoVO<MailRecipientVO> pagingVO);
	
	public MailRecipientVO getRecMailInfo(MailRecipientVO mailRecipientInfo);
	
	public MailRecipientVO getSenderMailInfo(MailRecipientVO mailRecipientInfo);
	
	public MailRecipientVO getUnifiedMailInfo(MailRecipientVO mailRecipientInfo);
	
	public List<MemberVO> searchMembers(String searchWord);

	public List<MailRecipientVO> getRecentMailList(int memNo);

	public void deleteMemFile(int fileNo);

	public void deleteRecipientFile(int fileNo);
	
	public void deleteMemFileDetail(int fileNo);
	
	public void deleteRecipientFileDetail(int fileNo);

	public List<FilesDetailVO> getFileDetailList(int fileNo);

	public void senderCompletelyDelete(MailRecipientVO recipientVO);

	public void recCompletelyDelete(MailRecipientVO recipientVO);

	public void applyTag(RecipientTagVO recipientTagVO);

	public List<MailTagVO> getTag(MemberVO member);

	public List<Integer> tagCheck(int chechedRecNo);

	public void unApplyTag(RecipientTagVO recipientTagVO);

	public void readSenderMail(MailRecipientVO recipientVO);

	public void readRecMail(MailRecipientVO recipientVO);

	public void unreadSenderMail(MailRecipientVO recipientVO);

	public void unreadRecMail(MailRecipientVO recipientVO);

	public void addMailBox(MailBoxVO mailBoxVO);

	public MailBoxVO getLastMailBox(MemberVO member);

	public List<MailBoxVO> getMailBoxList(MemberVO member);

	public void unBlockList(MailBlockListVO unblockListVO);

	public void senderUnTrash(MailRecipientVO recipientVO);

	public void recUnTrash(MailRecipientVO recipientVO);

	public List<MailVO> getConfirmationMailList(PaginationInfoVO<MailRecipientVO> pagingVO);
	
	public List<Integer> getSendMailRowNo(PaginationInfoVO<MailRecipientVO> pagingVO);

	public void deleteConfirmationMail(int deleteConfirmationNo);

	public void cancleSend(int recNo);

	public void moveMail(MailBoxVO mailBoxVO);

	public MailBoxVO getMailBoxNo(PaginationInfoVO<MailRecipientVO> pagingVO);

	public void moveInbox(int recNo);

	public FilesDetailVO getFileDetailListByDetailNo(int detailFileNo);

	public void emptyMailBox(int emptyMailBoxNo);

	public void modifyMailBox(MailBoxVO mailBoxVO);

	public void deleteMailBox(int deleteMailBoxNo);

	public void blockMail(MailRecipientVO mailRecipientVO);

	public int addBlockWord(MailBlockWordVO mailBlockWordVO);

	public MailBlockWordVO getLastBlockWord(MailBlockWordVO mailBlockWordVO);

	public void deleteAllBlockWord(MemberVO member);

	public void deleteBlockWord(int deleteNo);

	public List<MailBlockWordVO> getBlockWordList(MemberVO member);

	public MailBlockListVO getLastBlockList(MailBlockListVO mailBlockListVO);

	public void deleteBlockList(int deleteNo);

	public void deleteAllBlockList(MemberVO member);

	public List<MailBlockListVO> getBlockList(MemberVO member);

	public MailOutOfOfficeVO checkUsedOutOfOffice(int memNo);

	public void insertOutOfOffice(MailOutOfOfficeVO mailOutOfOfficeVO);

	public void updateOutOfOffice(MailOutOfOfficeVO mailOutOfOfficeVO);

	public List<MailVO> getReservationMailList(String formatedNow);

	public void updateReservationMail(MailVO mailVO);

	public void updateReservationResMail(MailVO mailVO);

	public MailRecipientVO getLastRecMail();

	public List<MailRecipientVO> getReservationRecMailList(MailVO mailVO);

	public int checkPassword(MemberVO member);

	public Long getMailCapacity(MemberVO member);

	public void reqAddCapacity(UpgradeReqVO upgradeReqVO);

	public UpgradeReqVO checkReqAddCapacity(MemberVO member);

	public MailRecipientVO getLastMailByNo(MemberVO unBlockREcipient);

	public List<DepartmentVO> getDeptList();

	public List<MemberVO> getDeptMember(DepartmentVO departmentVO);

	public void changeStatusByOutOfOffice(MailVO mail);

	public List<MailRecipientVO> getTagMail(RecipientTagVO recipientTagVO);

	public MailRecipientVO getMailRecipient(MailRecipientVO mailRecipientVO);

	public MailBoxVO getMailBoxNoByRec(MailRecipientVO mailRecipientInfo);



}
