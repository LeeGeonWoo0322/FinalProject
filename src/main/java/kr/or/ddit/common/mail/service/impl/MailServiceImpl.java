package kr.or.ddit.common.mail.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PaginationInfoVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;
import kr.or.ddit.common.alarm.service.IAlarmService;
import kr.or.ddit.common.alarm.vo.AlarmBanVO;
import kr.or.ddit.common.alarm.vo.AlarmVO;
import kr.or.ddit.common.approval.vo.ApprovalLineMemberVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import kr.or.ddit.common.mail.mapper.IMailMapper;
import kr.or.ddit.common.mail.service.IMailService;
import kr.or.ddit.common.mail.vo.MailBlockListVO;
import kr.or.ddit.common.mail.vo.MailBlockWordVO;
import kr.or.ddit.common.mail.vo.MailBoxVO;
import kr.or.ddit.common.mail.vo.MailOutOfOfficeVO;
import kr.or.ddit.common.mail.vo.MailRecipientVO;
import kr.or.ddit.common.mail.vo.MailTagVO;
import kr.or.ddit.common.mail.vo.MailVO;
import kr.or.ddit.common.mail.vo.RecipientTagVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service("iMailService")
public class MailServiceImpl implements IMailService{

	@Resource(name = "localPath")
	private String localPath;
	
	@Inject
	private IMailMapper mailMapper;
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private IAlarmService alarmService;

	@Override
	public int sendMail(MailVO mail, List<Map<String, List<String>>> recipientData, Authentication authentication) throws IOException {

		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		
		FilesVO files = new FilesVO("메일", member.getMemNo());
		FilesVO lastFile = null;
		FilesDetailVO filesDetailVO = new FilesDetailVO();
		MailVO lastMail = null;
		MailRecipientVO mailRecipient = new MailRecipientVO();
		boolean errorExist = false;
		int insertFileStatus = 0;
		List<MemberVO> unBlockRecipientList = new ArrayList<MemberVO>();
		
		File fileRoot = new File(localPath+"/mail");
		if (!fileRoot.exists()) {
			fileRoot.mkdirs();
		}
		
		// 파일 등록
		if(mail.getFile() != null || mail.getDbFile() != null) {
			insertFileStatus = mailMapper.insertFile(files);
			lastFile = mailMapper.getLastFile();
			
			filesDetailVO.setMemNo(member.getMemNo());
			filesDetailVO.setFileNo(lastFile.getFileNo());
			if (mail.getFile() != null) {
				// 상세파일 등록
				if (insertFileStatus > 0) {
					for(MultipartFile file : mail.getFile()) {
						String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
						filesDetailVO.setFilePath("/mail"+File.separator + fileName);
						filesDetailVO.setFileSize(file.getSize());
						filesDetailVO.setFileMime(file.getContentType());
						filesDetailVO.setFileOriginalname(file.getOriginalFilename());
						filesDetailVO.setFileUploadname(fileName);
						File targat = new File(fileRoot, fileName);
						FileCopyUtils.copy(file.getBytes(), targat);
						int insertFileDetailStatus = mailMapper.insertFileDetail(filesDetailVO);
						if (insertFileDetailStatus < 1) {
							errorExist = true;
						}
					}
				}else {
					errorExist = true;
				}
			}else if(mail.getDbFile().size() > 0) {
				mail.setFileNo(lastFile.getFileNo());
				for (int detailFileNo : mail.getDbFile()) {
					filesDetailVO = mailMapper.getFileDetailListByDetailNo(detailFileNo);
					filesDetailVO.setFileNo(lastFile.getFileNo());
					int insertFileDetailStatus = mailMapper.insertFileDetail(filesDetailVO);
					if (insertFileDetailStatus < 1) {
						errorExist = true;
					}
				}
			}
		}
		
		// 메일 등록
		if (!errorExist) {
			if (mail.getMailStatus().equals("전송")) {
				mail.setMailReadYn("Y");
			}
			if (mail.getMailRes().equals("Y")) {
				mail.setMailReadYn("N");
				mail.setMailStatus("예약");
			}
			if (mail.getFile() != null) {
				mail.setFileNo(lastFile.getFileNo());
			}
			int insertMailStatus = mailMapper.insertMail(mail);
			if (insertMailStatus < 1) {
				errorExist = true;
			}
		}
		
		lastMail = mailMapper.getLastMail();
		
		// 수신자 등록
		if (!errorExist) {
			mailRecipient.setMailNo(lastMail.getMailNo());
			mailRecipient.setRecStatus("수신됨");
			if (mail.getMailStatus().equals("예약")) {
				mailRecipient.setRecStatus("예약");
			}
			for (int i = 0; i < recipientData .size(); i++) {
				List<String> recipientType = recipientData.get(i).get("recipient");
				if (i == 0) {
					mailRecipient.setRecType("받는사람");
				}
				if (i == 1) { 
					mailRecipient.setRecType("CC");
				}
				if (i == 2) {
					mailRecipient.setRecType("BCC");
				}
				if (recipientType.size()>0) {
					for(String recipient : recipientType) {
						MemberVO recipientInfo = mailMapper.getRecipient(recipient);
						MailOutOfOfficeVO mailOutOfOfficeVO = mailMapper.checkUsedOutOfOffice(recipientInfo.getMemNo());
						if (mailOutOfOfficeVO != null && mailOutOfOfficeVO.getAutoUseYn().equals("Y")) {
							MailVO outOfOfficeMail = new MailVO(mailOutOfOfficeVO.getMemNo(), mailOutOfOfficeVO.getAutoTitle(), mailOutOfOfficeVO.getAutoContent());
							mailRecipient.setRecipientNo(member.getMemNo());
							mailRecipient.setRecipientName(member.getMemName());
							mailRecipient.setRecipientEmail(member.getMemEmail());
							mailRecipient.setRecipientDeptName(member.getDeptName());
							mailRecipient.setRecipientPosName(member.getPosName());
							mailMapper.insertMail(outOfOfficeMail);
							outOfOfficeMail = mailMapper.getLastMail();
							mailMapper.changeStatusByOutOfOffice(lastMail);
							mailRecipient.setMailNo(outOfOfficeMail.getMailNo());
							mailMapper.insertRecipient(mailRecipient);
						}else {
							MailBlockListVO blockListVO = new MailBlockListVO(recipientInfo.getMemNo(), member.getMemNo());
							boolean blockExist = false;
							List<MailBlockWordVO> blockWordList = mailMapper.getBlockWordList(recipientInfo);
							mailRecipient.setRecipientNo(recipientInfo.getMemNo());
							mailRecipient.setRecipientName(recipientInfo.getMemName());
							mailRecipient.setRecipientEmail(recipientInfo.getMemEmail());
							mailRecipient.setRecipientDeptName(recipientInfo.getDeptName());
							mailRecipient.setRecipientPosName(recipientInfo.getPosName());
							mailMapper.insertRecipient(mailRecipient);
							for (MailBlockWordVO blockWordVO : blockWordList) {
								if (mail.getMailContent().contains(blockWordVO.getBlockWord())) {
									blockExist = true;
								}else if (mail.getMailTitle().contains(blockWordVO.getBlockWord())) {
									blockExist = true;
								}
							}
							int status = mailMapper.checkBlock(blockListVO);
							if (status > 0) {
								blockExist = true;
							}
							if (blockExist) {
								MailRecipientVO lastRecipientVO = mailMapper.getLastRecMail();
								mailMapper.blockMail(lastRecipientVO);
							}else {
								unBlockRecipientList.add(recipientInfo);
							}
						}
					}
				}
			}
			
		}
		
		// 알람 등록
		AlarmVO alarm = new AlarmVO();
		AlarmBanVO alarmBanVO = new AlarmBanVO();
		List<AlarmVO> alarmList =new ArrayList<>();
		for (MemberVO unBlockREcipient : unBlockRecipientList) {
			MailRecipientVO getLastRowNo = mailMapper.getLastMailByNo(unBlockREcipient);
			alarmBanVO.setMemNo(member.getMemNo());
			alarmBanVO.setTechCategory("메일");
			int cnt=alarmService.chkBanAlarm(alarmBanVO);
			if(cnt>0) {
				continue;
			}
			alarm.setAlarmCategory("메일");
			alarm.setReceiverNo(unBlockREcipient.getMemNo());
			alarm.setAlarmContent(member.getMemName()+" "+member.getPosName()+"님이 "+mail.getMailTitle()+"을 발신함.");
			alarm.setAlarmUrl("/mail/read/1/"+getLastRowNo.getMailRowNo());
			AlarmVO insertedAlarm = alarmService.insertAlarm(alarm);
			alarmList.add(insertedAlarm);
		}
		if (alarmList.size()>0) {
			alarmService.sendNotificationToUsers(alarmList);
		}
		return 1;
	}


	@Override
	public int getInboxUnreadCnt(MemberVO member) {
		return mailMapper.getInboxUnreadCnt(member);
	}

	@Override
	public int getSentUnreadCnt(MemberVO member) {
		return mailMapper.getSentUnreadCnt(member);
	}

	@Override
	public int getTempUnreadCnt(MemberVO member) {
		return mailMapper.getTempUnreadCnt(member);
	}

	@Override
	public int getResUnreadCnt(MemberVO member) {
		return mailMapper.getResUnreadCnt(member);
	}

	@Override
	public int getSpamUnreadCnt(MemberVO member) {
		return mailMapper.getSpamUnreadCnt(member);
	}

	@Override
	public int getTrashUnreadCnt(MemberVO member) {
		return mailMapper.getTrashUnreadCnt(member);
	}

	@Override
	public int addTagList(MailTagVO mailTag) {
		return mailMapper.addTagList(mailTag);
	}

	@Override
	public List<MailTagVO> getTagList(MemberVO member) {
		return mailMapper.getTagList(member);
	}

	@Override
	public MailTagVO getLastMailTag(MemberVO member) {
		return mailMapper.getLastMailTag(member);
	}

	@Override
	public int modifyTagList(MailTagVO mailTagList) {
		return mailMapper.modifyTagList(mailTagList);
	}

	@Override
	public int deleteTagList(MailTagVO mailTagList) {
		return mailMapper.deleteTagList(mailTagList);
	}

	// 발신자, 수신자 정보를 포함한 메일 정보 가져오기
	// 수산자 정보를 리스트로 가져와서 메일 정보에 세팅
	@Override
	public MailVO getMailByNo(int mailNo) {
		MailVO mail = mailMapper.getMailByNo(mailNo);
		List<MailRecipientVO> recipientList = mailMapper.getMailRecipientInfoByMailNo(mailNo);
		mail.setRecipientList(recipientList);
		List<FilesDetailVO> fileList = mailMapper.getFileDetailList(mail.getFileNo());
		mail.setFileList(fileList);
		return mail;
	}
	
	@Override
	public int checkBlock(MailBlockListVO blockListVO) {
		return mailMapper.checkBlock(blockListVO);
	}

	@Override
	public void senderAddTrash(MailRecipientVO recipientVO) {
		mailMapper.senderAddTrash(recipientVO);
	}
	
	@Override
	public void recAddTrash(MailRecipientVO recipientVO) {
		mailMapper.recAddTrash(recipientVO);
	}

	@Override
	public void changeSenderFav(MailRecipientVO recipientVO) {
		mailMapper.changeSenderFav(recipientVO);
		
	}
	
	@Override
	public void changeRecipientFav(MailRecipientVO recipientVO) {
		mailMapper.changeRecipientFav(recipientVO);
		
	}

	@Override
	public List<MailRecipientVO> selectRecMailList(PaginationInfoVO<MailRecipientVO> pagingVO) {
		return mailMapper.selectRecMailList(pagingVO);
	}


	public List<MailRecipientVO> selectSenderMailList(PaginationInfoVO<MailRecipientVO> pagingVO) {
		return mailMapper.selectSenderMailList(pagingVO);
	}
	
	
	@Override
	public List<MailRecipientVO> selectUnifiedMailList(PaginationInfoVO<MailRecipientVO> pagingVO) {
		return mailMapper.selectUnifiedMailList(pagingVO);
	}


	@Override
	public List<MemberVO> searchMembers(String searchWord) {
		return mailMapper.searchMembers(searchWord);
	}


	@Override
	public List<MailRecipientVO> getRecentMailList(int memNo) {
		return mailMapper.getRecentMailList(memNo);
	}


	@Override
	public void deleteMemFile(int fileNo) {
		mailMapper.deleteMemFile(fileNo);
	}


	@Override
	public void deleteRecipientFile(int fileNo) {
		mailMapper.deleteRecipientFile(fileNo);
	}


	@Override
	public void deleteMemFileDetail(int fileNo) {
		mailMapper.deleteMemFileDetail(fileNo);
	}


	@Override
	public void deleteRecipientFileDetail(int fileNo) {
		mailMapper.deleteRecipientFileDetail(fileNo);
	}

	@Override
	public List<FilesDetailVO> getFileDetailList(int fileNo) {
		return mailMapper.getFileDetailList(fileNo);
	}


	@Override
	public void senderCompletelyDelete(MailRecipientVO recipientVO) {
		mailMapper.senderCompletelyDelete(recipientVO);
	}


	@Override
	public void recCompletelyDelete(MailRecipientVO recipientVO) {
		mailMapper.recCompletelyDelete(recipientVO);
		
	}


	@Override
	public MailRecipientVO getRecMailInfo(MailRecipientVO mailRecipientInfo) {
		return mailMapper.getRecMailInfo(mailRecipientInfo);
	}


	@Override
	public MailRecipientVO getSenderMailInfo(MailRecipientVO mailRecipientInfo) {
		return mailMapper.getSenderMailInfo(mailRecipientInfo);
	}


	@Override
	public MailRecipientVO getUnifiedMailInfo(MailRecipientVO mailRecipientInfo) {
		return mailMapper.getUnifiedMailInfo(mailRecipientInfo);
	}


	@Override
	public void applyTag(RecipientTagVO recipientTagVO) {
		mailMapper.applyTag(recipientTagVO);
	}


	@Override
	public List<MailTagVO> getTag(MemberVO member) {
		return mailMapper.getTag(member);
	}


	@Override
	public List<Integer> tagCheck(int chechedRecNo) {
		return mailMapper.tagCheck(chechedRecNo);
	}


	@Override
	public void unApplyTag(RecipientTagVO recipientTagVO) {
		mailMapper.unApplyTag(recipientTagVO);
	}


	@Override
	public void readSenderMail(MailRecipientVO recipientVO) {
		mailMapper.readSenderMail(recipientVO);
	}


	@Override
	public void readRecMail(MailRecipientVO recipientVO) {
		mailMapper.readRecMail(recipientVO);
	}


	@Override
	public void unreadSenderMail(MailRecipientVO recipientVO) {
		mailMapper.unreadSenderMail(recipientVO);
	}


	@Override
	public void unreadRecMail(MailRecipientVO recipientVO) {
		mailMapper.unreadRecMail(recipientVO);
	}


	@Override
	public void addMailBox(MailBoxVO mailBoxVO) {
		mailMapper.addMailBox(mailBoxVO);
	}


	@Override
	public MailBoxVO getLastMailBox(MemberVO member) {
		return mailMapper.getLastMailBox(member);
	}


	@Override
	public List<MailBoxVO> getMailBoxList(MemberVO member) {
		return mailMapper.getMailBoxList(member);
	}


	@Override
	public void unBlockList(MailBlockListVO unblockListVO) {
		mailMapper.unBlockList(unblockListVO);
	}


	@Override
	public void senderUnTrash(MailRecipientVO recipientVO) {
		mailMapper.senderUnTrash(recipientVO);
	}


	@Override
	public void recUnTrash(MailRecipientVO recipientVO) {
		mailMapper.recUnTrash(recipientVO);
	}


	@Override
	public List<MailVO> getConfirmationMailList(PaginationInfoVO<MailRecipientVO> pagingVO) {
		List<MailVO> confirmationMailList = mailMapper.getConfirmationMailList(pagingVO);
		List<Integer> rowNoList = mailMapper.getSendMailRowNo(pagingVO);
		for (int i = 0; i < confirmationMailList.size(); i++) {
			confirmationMailList.get(i).setMailRowNo(rowNoList.get(i));
		}
		return confirmationMailList;
	}


	@Override
	public void deleteConfirmationMail(int deleteConfirmationNo) {
		mailMapper.deleteConfirmationMail(deleteConfirmationNo);
	}


	@Override
	public void cancleSend(int mailNo) {
		List<MailRecipientVO> recipientList = mailMapper.getMailRecipientInfoByMailNo(mailNo);
		for (MailRecipientVO mailRecipientVO : recipientList) {
			if (mailRecipientVO.getReadYn().equals("N")) {
				mailMapper.cancleSend(mailRecipientVO.getRecNo());
			}
		}
	}


	@Override
	public void moveMail(MailBoxVO mailBoxVO) {
		mailMapper.moveMail(mailBoxVO);
	}


	@Override
	public MailBoxVO getMailBoxNo(PaginationInfoVO<MailRecipientVO> pagingVO) {
		return mailMapper.getMailBoxNo(pagingVO);
	}


	@Override
	public void moveInbox(int recNo) {
		mailMapper.moveInbox(recNo);
	}


	@Override
	public void emptyMailBox(int emptyMailBoxNo) {
		mailMapper.emptyMailBox(emptyMailBoxNo);
	}


	@Override
	public void modifyMailBox(MailBoxVO mailBoxVO) {
		mailMapper.modifyMailBox(mailBoxVO);
	}


	@Override
	public void deleteMailBox(int deleteMailBoxNo) {
		mailMapper.deleteMailBox(deleteMailBoxNo);
	}


	@Override
	public void sendReservationMail() throws ParseException {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String formatedNow = sdf.format(now).substring(0,16) + ":00";
		List<MailVO> mailList = mailMapper.getReservationMailList(formatedNow);
		Date nowDate = sdf.parse(formatedNow);
		
		
		for (MailVO mailVO : mailList) {
			Date dbDate = sdf.parse(mailVO.getMailResDate());
			if (nowDate.equals(dbDate)) {
				mailMapper.updateReservationMail(mailVO);
				mailMapper.updateReservationResMail(mailVO);
				List<MailRecipientVO> recMailList = mailMapper.getReservationRecMailList(mailVO);
				for (MailRecipientVO mailRecipientVO : recMailList) {
					MemberVO recipientInfo = accountService.getMemberByNo(mailRecipientVO.getRecipientNo());
					MailBlockListVO blockListVO = new MailBlockListVO(mailRecipientVO.getRecipientNo(), mailVO.getMemNo());
					boolean blockExist = false;
					List<MailBlockWordVO> blockWordList = mailMapper.getBlockWordList(recipientInfo);
					for (MailBlockWordVO blockWordVO : blockWordList) {
						if (mailVO.getMailContent().contains(blockWordVO.getBlockWord())) {
							blockExist = true;
						}else if (mailVO.getMailTitle().contains(blockWordVO.getBlockWord())) {
							blockExist = true;
						}
					}
					int status = mailMapper.checkBlock(blockListVO);
					if (status > 0) {
						blockExist = true;
					}
					if (blockExist) {
						mailMapper.blockMail(mailRecipientVO);
					}
				}
			}
		}
	}


	@Override
	public MailBlockWordVO addBlockWord(MailBlockWordVO mailBlockWordVO) {
		int status = mailMapper.addBlockWord(mailBlockWordVO);
		MailBlockWordVO lastBlockWordVO = null;
		if (status > 0) {
			lastBlockWordVO = mailMapper.getLastBlockWord(mailBlockWordVO);
		}
		return lastBlockWordVO;
	}


	@Override
	public void deleteAllBlockWord(MemberVO member) {
		mailMapper.deleteAllBlockWord(member);
	}


	@Override
	public void deleteBlockWord(int deleteNo) {
		mailMapper.deleteBlockWord(deleteNo);
	}


	@Override
	public List<MailBlockWordVO> getBlockWordList(MemberVO member) {
		return mailMapper.getBlockWordList(member);
	}

 
	@Override
	public MailBlockListVO addBlockList(MailBlockListVO mailBlockListVO) {
		int status = mailMapper.addBlockList(mailBlockListVO);
		MailBlockListVO lastBlockListVO = null;
		if (status > 0) {
			lastBlockListVO = mailMapper.getLastBlockList(mailBlockListVO);
		}
		return lastBlockListVO;
	}


	@Override
	public void deleteBlockList(int deleteNo) {
		mailMapper.deleteBlockList(deleteNo);		
	}


	@Override
	public void deleteAllBlockList(MemberVO member) {
		mailMapper.deleteAllBlockList(member);
	}


	@Override
	public List<MailBlockListVO> getBlockList(MemberVO member) {
		return mailMapper.getBlockList(member);
	}


	@Override
	public MailOutOfOfficeVO checkUsedOutOfOffice(int memNo) {
		return mailMapper.checkUsedOutOfOffice(memNo);
	}


	@Override
	public void insertOutOfOffice(MailOutOfOfficeVO mailOutOfOfficeVO) {
		mailMapper.insertOutOfOffice(mailOutOfOfficeVO);
	}


	@Override
	public void updateOutOfOffice(MailOutOfOfficeVO mailOutOfOfficeVO) {
		mailMapper.updateOutOfOffice(mailOutOfOfficeVO);
	}


	@Override
	public int checkPassword(MemberVO member) {
		return mailMapper.checkPassword(member);
	}


	@Override
	public Long getMailCapacity(MemberVO member) {
		return mailMapper.getMailCapacity(member);
	}


	@Override
	public void reqAddCapacity(UpgradeReqVO upgradeReqVO) {
		mailMapper.reqAddCapacity(upgradeReqVO);
	}


	@Override
	public UpgradeReqVO checkReqAddCapacity(MemberVO member) {
		return mailMapper.checkReqAddCapacity(member);
	}


	@Override
	public FilesDetailVO getFileDetailListByDetailNo(int fileNo) {
		return mailMapper.getFileDetailListByDetailNo(fileNo);
	}


	@Override
	public List<DepartmentVO> getDeptList() {
		return mailMapper.getDeptList();
	}


	@Override
	public List<MemberVO> getDeptMember(DepartmentVO departmentVO) {
		return mailMapper.getDeptMember(departmentVO);
	}


	@Override
	public List<MailRecipientVO> getTagMail(RecipientTagVO recipientTagVO) {
		return mailMapper.getTagMail(recipientTagVO);
	}


	@Override
	public MailRecipientVO getMailRecipient(MailRecipientVO mailRecipientVO) {
		return mailMapper.getMailRecipient(mailRecipientVO);
	}


	@Override
	public MailBoxVO getMailBoxNoByRec(MailRecipientVO mailRecipientInfo) {
		return mailMapper.getMailBoxNoByRec(mailRecipientInfo);
	}

}