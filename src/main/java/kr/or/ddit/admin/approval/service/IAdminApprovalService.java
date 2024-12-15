package kr.or.ddit.admin.approval.service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.common.approval.vo.ApprovalFormVO;

public interface IAdminApprovalService {

	public List<ApprovalFormVO> getApprFormList();

	public void registerApprForm(ApprovalFormVO approvalFormVO);

	public void deleteForm(int formNo);

	public void updateForm(ApprovalFormVO approvalFormVO);

	public List<ApprovalFormVO> getApprovalStatistics(Map<String, String> map);

	public List<Map<String, Object>> getApprovalStatusCounts(Map<String, String> map);

	public List<Map<String, Object>> getEmployeeSubmissions(Map<String, String> map);

	public ByteArrayInputStream generateApprovalStatusExcel(Map<String, String> params) throws IOException;

}
