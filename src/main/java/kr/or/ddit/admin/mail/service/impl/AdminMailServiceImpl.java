package kr.or.ddit.admin.mail.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.mail.mapper.IAdminMailMapper;
import kr.or.ddit.admin.mail.service.IAdminMailService;
import kr.or.ddit.admin.mail.vo.DataListVO;
import kr.or.ddit.common.account.vo.DepartmentVO;

@Service
public class AdminMailServiceImpl implements IAdminMailService{

	@Inject
	private IAdminMailMapper adminMailMapper;
	
	@Override
	public List<DepartmentVO> getDeptList() {
		return adminMailMapper.getDeptList();
	}

	@Override
	public Integer getTotalMailUsageCnt(DataListVO dataListVO) {
		return adminMailMapper.getTotalMailUsageCnt(dataListVO);
	}

	@Override
	public Integer getTotalSpamMailCnt(DataListVO dataListVO) {
		return adminMailMapper.getTotalSpamMailCnt(dataListVO);
	}

	@Override
	public Integer getDeptMailUsageCnt(DataListVO dataListVO) {
		return adminMailMapper.getDeptMailUsageCnt(dataListVO);
	}

	@Override
	public Integer getDeptSpamMailCnt(DataListVO dataListVO) {
		return adminMailMapper.getDeptSpamMailCnt(dataListVO);
	}

	@Override
	public Integer getLastTotalMailUsageCnt(DataListVO dataListVO) {
		return adminMailMapper.getLastTotalMailUsageCnt(dataListVO);
	}

	@Override
	public Integer getLastTotalSpamMailCnt(DataListVO dataListVO) {
		return adminMailMapper.getLastTotalSpamMailCnt(dataListVO);
	}

	@Override
	public Integer getLastDeptMailUsageCnt(DataListVO dataListVO) {
		return adminMailMapper.getLastDeptMailUsageCnt(dataListVO);
	}

	@Override
	public Integer getLastDeptSpamMailCnt(DataListVO dataListVO) {
		return adminMailMapper.getLastDeptSpamMailCnt(dataListVO);
	}


}
