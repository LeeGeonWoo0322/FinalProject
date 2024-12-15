package kr.or.ddit.common.approval.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.approval.vo.AgencyVO;
import kr.or.ddit.common.approval.vo.ApprovalFormVO;
import kr.or.ddit.common.approval.vo.ApprovalLineMemberVO;
import kr.or.ddit.common.approval.vo.ApprovalVO;
import kr.or.ddit.common.approval.vo.FavoriteFormVO;
import kr.or.ddit.common.approval.vo.ReadingVO;
import kr.or.ddit.common.approval.vo.ReferenceVO;
import kr.or.ddit.common.approval.vo.SealVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;

public interface IApprovalMapper {

	public List<ApprovalVO> getApprovalList(int memNo);

	public ApprovalVO getApproval(ApprovalVO approvalVO);

	public void registerSeal(SealVO sealVO);

	public List<SealVO> getSealList(int memNo);

	public void selSealUpdate(SealVO sealVO);

	public List<ApprovalFormVO> approvalFormList();

	public ApprovalFormVO getApprovalForm(int formNo);

	public List<DepartmentVO> approvalDeptList();

	public List<MemberVO> approvalMemList();

	public void registerApproval(ApprovalVO approvalVO);

	public void registerLine(ApprovalLineMemberVO approvalLineMemberVO);

	public void registerRef(ReferenceVO referenceVO);

	public void registerRead(ReadingVO readingVO);

	public int updateAppr(ApprovalVO approvalVO);

	public List<ApprovalLineMemberVO> getApprovalLine(String apprId);

	public List<ReferenceVO> getReferenceMemberList(String apprId);

	public List<ReadingVO> getReadMemberList(String apprId);

	public SealVO getSeal(int memNo);

	public void doApproval(ApprovalLineMemberVO approvalLineMemberVO);

	public int approvalSeal(ApprovalVO approvalVO);

	public int checkApprovalStatus(ApprovalVO approvalVO);

	public MemberVO getMember(int memNo);

	public List<AgencyVO> getAgencyList(int granterNo);

	public List<MemberVO> getDeptMemList(MemberVO memberVO);

	public void saveAbsence(AgencyVO agencyVO);

	public void deleteApprLineByApprId(String apprId);

	public void deleteRefByApprId(String apprId);

	public void deleteReadApprId(String apprId);

	public List<ApprovalVO> refApprList(int memNo);

	public List<ApprovalVO> readApprList(int memNo);

	public int registerFavoriteForm(FavoriteFormVO favoriteFormVO);

	public List<ApprovalFormVO> getFavoriteFormList(int memNo);

	public void updateRsn(ApprovalLineMemberVO approvalLineMemberVO);

	public ApprovalLineMemberVO getApprRsnWithMemberInfo(String apprId);

	public void cancelAppr(String apprId);

	public void updateApprLine(ApprovalLineMemberVO approvalLineMemberVO);

	public int registerVct(UseVacationVO useVacationVO);

	public int chkVaction(UseVacationVO useVacationVO);

	public String getVacationDec(int vctTypeNo);

	public void deductVacation(UseVacationVO useVacationVO);

	public ApprovalLineMemberVO getNextMember(ApprovalLineMemberVO approvalLineMemberVO);

	public List<ApprovalVO> getWaitingApprovalList(int memNo);

	public ApprovalLineMemberVO getApprovalLineMember(ApprovalLineMemberVO approvalLineMemberVO);

}
