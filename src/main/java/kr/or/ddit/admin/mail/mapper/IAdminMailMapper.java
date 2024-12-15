package kr.or.ddit.admin.mail.mapper;

import java.util.List;

import kr.or.ddit.admin.mail.vo.DataListVO;
import kr.or.ddit.common.account.vo.DepartmentVO;

public interface IAdminMailMapper {

	public List<DepartmentVO> getDeptList();

	public int getDataCnt(DataListVO dataListVO);

	public Integer getTotalMailUsageCnt(DataListVO dataListVO);

	public Integer getTotalSpamMailCnt(DataListVO dataListVO);

	public Integer getDeptMailUsageCnt(DataListVO dataListVO);

	public Integer getDeptSpamMailCnt(DataListVO dataListVO);

	public Integer getLastTotalMailUsageCnt(DataListVO dataListVO);

	public Integer getLastTotalSpamMailCnt(DataListVO dataListVO);

	public Integer getLastDeptMailUsageCnt(DataListVO dataListVO);

	public Integer getLastDeptSpamMailCnt(DataListVO dataListVO);

}
