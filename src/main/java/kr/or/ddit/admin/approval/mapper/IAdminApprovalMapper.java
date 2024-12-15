package kr.or.ddit.admin.approval.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.approval.vo.ApprovalFormVO;
import kr.or.ddit.common.approval.vo.ApprovalVO;

public interface IAdminApprovalMapper {

	public List<ApprovalFormVO> getApprFormList();

	public void registerApprForm(ApprovalFormVO approvalFormVO);

	public void deleteForm(int formNo);

	public void updateForm(ApprovalFormVO approvalFormVO);

	public List<ApprovalFormVO> getApprovalStatistics(Map<String, String> map);

	public List<Map<String, Object>> getApprovalStatusCounts(Map<String, String> map);

	public List<Map<String, Object>> getEmployeeSubmissions(Map<String, String> map);

}
