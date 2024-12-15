package kr.or.ddit.admin.organization.service.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.organization.mapper.IAdminOrganizationMapper;
import kr.or.ddit.admin.organization.service.IAdminOrganizationService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;

@Service
public class AdminOrganizationServiceImpl implements IAdminOrganizationService {
	
	@Inject
	private IAdminOrganizationMapper adOrganizationMapper;
	
	@Override
	public int addDept(DepartmentVO deptVO) {
		int res = adOrganizationMapper.addDept(deptVO);
		
		return res;
	}

	@Override
	public List<MemberVO> printMember() {
		List<MemberVO> memberList = adOrganizationMapper.printMember();
		
		return memberList;
	}

	@Override
	public List<DepartmentVO> printDept() {
		List<DepartmentVO> deptList = adOrganizationMapper.printDept();
		
		return deptList;
	}

	@Override
	public List<PositionVO> printPos() {
		List<PositionVO> posList = adOrganizationMapper.printPos();
		
		return posList;
	}

	@Override
	public List<MemberVO> allMember(String search) throws Exception {
		List<MemberVO> memberList = adOrganizationMapper.allMember(search);
		
		return memberList;
	}

	@Override
	public ByteArrayInputStream excelAllMember() throws Exception{
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet();
		
		Row header = sheet.createRow(0);
		
		header.createCell(0).setCellValue("memNo");
		header.createCell(1).setCellValue("posName");
		header.createCell(2).setCellValue("deptName");
		header.createCell(3).setCellValue("memId");
		header.createCell(4).setCellValue("memName");
		header.createCell(5).setCellValue("memEmail");
		header.createCell(6).setCellValue("memAddr1");
		header.createCell(7).setCellValue("memAddr2");
		header.createCell(8).setCellValue("memPost");
		header.createCell(9).setCellValue("hireDate");
		header.createCell(10).setCellValue("enabled");

		List<MemberVO> allMember = adOrganizationMapper.allMember1();
		
		int rowIdx = 1;
		for(MemberVO vo : allMember) {
			Row row = sheet.createRow(rowIdx++);
			row.createCell(0).setCellValue(vo.getMemNo());
			row.createCell(1).setCellValue(vo.getPosName());
			row.createCell(2).setCellValue(vo.getDeptName());
			row.createCell(3).setCellValue(vo.getMemId());
			row.createCell(4).setCellValue(vo.getMemName());
			row.createCell(5).setCellValue(vo.getMemEmail());
			row.createCell(6).setCellValue(vo.getMemAddr1());
			row.createCell(7).setCellValue(vo.getMemAddr2());
			row.createCell(8).setCellValue(vo.getMemPost());
			row.createCell(9).setCellValue(vo.getHireDate());
			row.createCell(10).setCellValue(vo.getEnabled());
		}
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		workbook.write(out);
		workbook.close();
		
		return new ByteArrayInputStream(out.toByteArray());
	}

	@Override
	public void upload(MemberVO member) {
		adOrganizationMapper.upload(member);
	}

	@Override
	public int memCount() {
		int res = adOrganizationMapper.memCount();
		return res;
	}

	@Override
	public DepartmentVO deptDetail(DepartmentVO dept) {
		DepartmentVO res = adOrganizationMapper.deptDetail(dept);
		
		return res;
	}

	@Override
	public int deleteMem(Integer memberNo) {
		int res = adOrganizationMapper.deleteMem(memberNo);
		
		return res;
	}

	@Override
	public int enabledCheck(Integer memberNo) {
		int res = adOrganizationMapper.enabledCheck(memberNo);
		
		return res;
	}

	@Override
	public int changePos(Map<String, Object> map) {
		List<Integer> memList = (List<Integer>)map.get("checkedMemNoList");
		 int posNo = (int) map.get("posNo");
		 int res = 0;
		 for (Integer memberNo : memList) {
			 res = adOrganizationMapper.changePos(memberNo, posNo);
		}
		return res;
	}

	@Override
	public int enabled1Mem() {
		int res = adOrganizationMapper.enabled1Mem();
		return res;
	}

	@Override
	public int enabled2Mem() {
		int res = adOrganizationMapper.enabled2Mem();
		return res;
	}
}
