package kr.or.ddit.admin.organization.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;

public interface IAdminOrganizationMapper {

	public int addDept(DepartmentVO deptVO);

	public List<MemberVO> printMember();

	public List<DepartmentVO> printDept();

	public List<PositionVO> printPos();

	public List<MemberVO> allMember(String search)throws Exception;

	public void upload(MemberVO member);

	public List<MemberVO> allMember1();

	public int memCount();

	public DepartmentVO deptDetail(DepartmentVO dept);

	public int deleteMem(Integer memberNo);

	public int enabledCheck(Integer memberNo);

	public int changePos(@Param("memberNo") Integer memberNo,@Param("posNo") int posNo);

	public int enabled1Mem();

	public int enabled2Mem();

}
