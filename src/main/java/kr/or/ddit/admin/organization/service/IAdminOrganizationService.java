package kr.or.ddit.admin.organization.service;

import java.io.ByteArrayInputStream;
import java.util.List;
import java.util.Map;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;

public interface IAdminOrganizationService {

	public int addDept(DepartmentVO deptVO);

	public List<MemberVO> printMember();

	public List<DepartmentVO> printDept();

	public List<PositionVO> printPos();

	public List<MemberVO> allMember(String search) throws Exception;

	public ByteArrayInputStream excelAllMember() throws Exception;

	public void upload(MemberVO member);

	public int memCount();

	public DepartmentVO deptDetail(DepartmentVO dept);

	public int deleteMem(Integer memberNo);

	public int enabledCheck(Integer memberNo);

	public int changePos(Map<String, Object> map);

	public int enabled1Mem();

	public int enabled2Mem();

}
