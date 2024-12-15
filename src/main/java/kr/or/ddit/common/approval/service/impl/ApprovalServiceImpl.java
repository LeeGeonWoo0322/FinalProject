package kr.or.ddit.common.approval.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.approval.mapper.IApprovalMapper;
import kr.or.ddit.common.approval.service.IApprovalService;
import kr.or.ddit.common.approval.vo.AgencyVO;
import kr.or.ddit.common.approval.vo.ApprovalFormVO;
import kr.or.ddit.common.approval.vo.ApprovalLineMemberVO;
import kr.or.ddit.common.approval.vo.ApprovalVO;
import kr.or.ddit.common.approval.vo.FavoriteFormVO;
import kr.or.ddit.common.approval.vo.ReadingVO;
import kr.or.ddit.common.approval.vo.ReferenceVO;
import kr.or.ddit.common.approval.vo.SealVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;

@Service
public class ApprovalServiceImpl implements IApprovalService {
	@Inject
	private IApprovalMapper approvalMapper;

	@Override
	public List<ApprovalVO> getApprovalList(int memNo) {
		return approvalMapper.getApprovalList(memNo);
	}

	@Override
	public ApprovalVO getApproval(ApprovalVO approvalVO) {
		return approvalMapper.getApproval(approvalVO);
	}

	@Override
	public void registerSeal(SealVO sealVO) {
		approvalMapper.registerSeal(sealVO);
	}

	@Override
	public List<SealVO> getSealList(int memNo) {
		return approvalMapper.getSealList(memNo);
	}

	@Override
	public void selSealUpdate(SealVO sealVO) {
		approvalMapper.selSealUpdate(sealVO);
	}

	@Override
	public List<ApprovalFormVO> approvalFormList() {
		return approvalMapper.approvalFormList();
	}

	@Override
	public ApprovalFormVO getApprovalForm(int formNo) {
		return approvalMapper.getApprovalForm(formNo);
	}

	@Override
	public List<DepartmentVO> approvalDeptList() {
		return approvalMapper.approvalDeptList();
	}

	@Override
	public List<MemberVO> approvalMemList() {
		return approvalMapper.approvalMemList();
	}

	@Override
	public void registerApproval(ApprovalVO approvalVO) {
		approvalMapper.registerApproval(approvalVO);
	}

	@Override
	public void registerLine(ApprovalLineMemberVO approvalLineMemberVO) {
		approvalMapper.registerLine(approvalLineMemberVO);
	}

	@Override
	public void registerRef(ReferenceVO referenceVO) {
		approvalMapper.registerRef(referenceVO);
	}

	@Override
	public void registerRead(ReadingVO readingVO) {
		approvalMapper.registerRead(readingVO);
	}

	@Override
	public int updateAppr(ApprovalVO approvalVO) {
		return approvalMapper.updateAppr(approvalVO);
	}

	@Override
	public List<ApprovalLineMemberVO> getApprovalLine(String apprId) {
		return approvalMapper.getApprovalLine(apprId);
	}

	@Override
	public List<ReferenceVO> getReferenceMemberList(String apprId) {
		return approvalMapper.getReferenceMemberList(apprId);
	}

	@Override
	public List<ReadingVO> getReadMemberList(String apprId) {
		return approvalMapper.getReadMemberList(apprId);
	}

	@Override
	public SealVO getSeal(int memNo) {
		return approvalMapper.getSeal(memNo);
	}

	@Override
	public void doApproval(ApprovalLineMemberVO approvalLineMemberVO) {
		approvalMapper.doApproval(approvalLineMemberVO);
	}

	@Override
	public int approvalSeal(ApprovalVO approvalVO) {
		int cnt = checkApprovalStatus(approvalVO);
		System.out.println("결재할사람:"+cnt);
		if(approvalVO.getApprStatus().equals("반려")) {
			approvalVO.setApprStatus("반려");
		}else if(approvalVO.getApprStatus().equals("임시")) {
			approvalVO.setApprStatus("임시");
		}else if(approvalVO.getApprStatus().equals("완료")||cnt<=0) {
			approvalVO.setApprStatus("완료");
		}else {
			approvalVO.setApprStatus("진행중");
		}
		
		
		return approvalMapper.approvalSeal(approvalVO);
	}

	@Override
	public int checkApprovalStatus(ApprovalVO approvalVO) {
		return approvalMapper.checkApprovalStatus(approvalVO);
	}

	@Override
	public MemberVO getMember(int memNo) {
		return approvalMapper.getMember(memNo);
	}

	@Override
	public List<AgencyVO> getAgencyList(int granterNo) {
		return approvalMapper.getAgencyList(granterNo);
	}

	@Override
	public List<MemberVO> getDeptMemList(MemberVO memberVO) {
		return approvalMapper.getDeptMemList(memberVO);
	}

	@Override
	public void saveAbsence(AgencyVO agencyVO) {
		approvalMapper.saveAbsence(agencyVO);
	}

	@Override
	public void deleteApprLineByApprId(String apprId) {
		approvalMapper.deleteApprLineByApprId(apprId);
	}

	@Override
	public void deleteRefByApprId(String apprId) {
		approvalMapper.deleteRefByApprId(apprId);
	}

	@Override
	public void deleteReadApprId(String apprId) {
		approvalMapper.deleteReadApprId(apprId);
	}

	@Override
	public List<ApprovalVO> refApprList(int memNo) {
		return approvalMapper.refApprList(memNo);
	}

	@Override
	public List<ApprovalVO> readApprList(int memNo) {
		return approvalMapper.readApprList(memNo);
	}

	@Override
	public int registerFavoriteForm(FavoriteFormVO favoriteFormVO) {
		return approvalMapper.registerFavoriteForm(favoriteFormVO);
	}

	@Override
	public List<ApprovalFormVO> getFavoriteFormList(int memNo) {
		return approvalMapper.getFavoriteFormList(memNo);
	}

	@Override
	public void updateRsn(ApprovalLineMemberVO approvalLineMemberVO) {
		approvalMapper.updateRsn(approvalLineMemberVO);
	}

	@Override
	public ApprovalLineMemberVO getApprRsnWithMemberInfo(String apprId) {
		return approvalMapper.getApprRsnWithMemberInfo(apprId);
	}

	@Override
	public void cancelAppr(String apprId) {
		approvalMapper.cancelAppr(apprId);
	}

	@Override
	public void updateApprLine(ApprovalLineMemberVO approvalLineMemberVO) {
		approvalMapper.updateApprLine(approvalLineMemberVO);
	}

	@Override
	public int registerVct(UseVacationVO useVacationVO) {
		return approvalMapper.registerVct(useVacationVO);
	}

	@Override
	public int chkVaction(UseVacationVO useVacationVO) {
		return approvalMapper.chkVaction(useVacationVO);
	}

	@Override
	public String getVacationDec(int vctTypeNo) {
		return approvalMapper.getVacationDec(vctTypeNo);
	}

	@Override
	public void deductVacation(UseVacationVO useVacationVO) {
		approvalMapper.deductVacation(useVacationVO);
	}

	@Override
	public ApprovalLineMemberVO getNextMember(ApprovalLineMemberVO approvalLineMemberVO) {
		return approvalMapper.getNextMember(approvalLineMemberVO);
	}

	@Override
	public List<ApprovalVO> getWaitingApprovalList(int memNo) {
		return approvalMapper.getWaitingApprovalList(memNo);
	}

	@Override
	public ApprovalLineMemberVO getApprovalLineMember(ApprovalLineMemberVO approvalLineMemberVO) {
		return approvalMapper.getApprovalLineMember(approvalLineMemberVO);
	}
}
