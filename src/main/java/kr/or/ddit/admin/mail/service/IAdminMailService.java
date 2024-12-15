package kr.or.ddit.admin.mail.service;

import java.util.List;

import kr.or.ddit.admin.mail.vo.DataListVO;
import kr.or.ddit.common.account.vo.DepartmentVO;

public interface IAdminMailService {

	List<DepartmentVO> getDeptList();

	Integer getTotalMailUsageCnt(DataListVO dataListVO);
	
	Integer getTotalSpamMailCnt(DataListVO dataListVO);
	
	Integer getDeptMailUsageCnt(DataListVO dataListVO);

	Integer getDeptSpamMailCnt(DataListVO dataListVO);

	Integer getLastTotalMailUsageCnt(DataListVO dataListVO);
	
	Integer getLastTotalSpamMailCnt(DataListVO dataListVO);
	
	Integer getLastDeptMailUsageCnt(DataListVO dataListVO);

	Integer getLastDeptSpamMailCnt(DataListVO dataListVO);

}
