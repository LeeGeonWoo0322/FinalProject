package kr.or.ddit.admin.approval.service.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.approval.mapper.IAdminApprovalMapper;
import kr.or.ddit.admin.approval.service.IAdminApprovalService;
import kr.or.ddit.common.approval.vo.ApprovalFormVO;

@Service
public class AdminApprovalServiceImpl implements IAdminApprovalService {
	
	@Inject
	private IAdminApprovalMapper adminApprovalMapper;

	@Override
	public List<ApprovalFormVO> getApprFormList() {
		return adminApprovalMapper.getApprFormList();
	}

	@Override
	public void registerApprForm(ApprovalFormVO approvalFormVO) {
		adminApprovalMapper.registerApprForm(approvalFormVO);
	}

	@Override
	public void deleteForm(int formNo) {
		adminApprovalMapper.deleteForm(formNo);
	}

	@Override
	public void updateForm(ApprovalFormVO approvalFormVO) {
		adminApprovalMapper.updateForm(approvalFormVO);
	}

	@Override
	public List<ApprovalFormVO> getApprovalStatistics(Map<String, String> map) {
		return adminApprovalMapper.getApprovalStatistics(map);
	}

	@Override
	public List<Map<String, Object>> getApprovalStatusCounts(Map<String, String> map) {
		return adminApprovalMapper.getApprovalStatusCounts(map);
	}

	@Override
	public List<Map<String, Object>> getEmployeeSubmissions(Map<String, String> map) {
		return adminApprovalMapper.getEmployeeSubmissions(map);
	}

	@Override
	public ByteArrayInputStream generateApprovalStatusExcel(Map<String, String> params) throws IOException {
	    XSSFWorkbook workbook = new XSSFWorkbook();
	    XSSFSheet sheet = workbook.createSheet("Approval Status");

	    // 헤더 작성
	    Row header = sheet.createRow(0);
	    header.createCell(0).setCellValue("날짜");
	    header.createCell(1).setCellValue("진행중");
	    header.createCell(2).setCellValue("반려");
	    header.createCell(3).setCellValue("완료");
	    header.createCell(4).setCellValue("합계");

	    // 데이터 조회
	    List<Map<String, Object>> approvalStatusCounts = adminApprovalMapper.getApprovalStatusCounts(params);

	    // 데이터를 Excel 행으로 작성
	    int rowIdx = 1;
	    for (Map<String, Object> status : approvalStatusCounts) {
	        Row row = sheet.createRow(rowIdx++);
	        
	        // 날짜 셀 작성
	        row.createCell(0).setCellValue(status.get("REG_DATE").toString());

	        // 진행중, 반려, 완료 셀 값 작성
	        int progress = ((BigDecimal) status.get("PROGRESS")).intValue();
	        int rejected = ((BigDecimal) status.get("REJECTED")).intValue();
	        int completed = ((BigDecimal) status.get("COMPLETED")).intValue();

	        row.createCell(1).setCellValue(progress);
	        row.createCell(2).setCellValue(rejected);
	        row.createCell(3).setCellValue(completed);

	        // 합계 셀 작성
	        int total = progress + rejected + completed;
	        row.createCell(4).setCellValue(total);
	    }

	    ByteArrayOutputStream out = new ByteArrayOutputStream();
	    workbook.write(out);
	    workbook.close();

	    return new ByteArrayInputStream(out.toByteArray());
	}

}
