package kr.or.ddit.admin.security.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.security.mapper.IAdminSecurityMapper;
import kr.or.ddit.admin.security.service.IAdminSecurityService;
import kr.or.ddit.common.account.vo.LogVO;

@Service
public class AdminSecurityImpl implements IAdminSecurityService{

	@Inject
	private IAdminSecurityMapper adminSecurityMapper;

	@Override
	public List<LogVO> getLogList() {
		return adminSecurityMapper.getLogList();
	}

	@Override
	public List<LogVO> logSearchByPeriod(LogVO logVO) {
		return adminSecurityMapper.logSearchByPeriod(logVO);
	}

	@Override
	public List<LogVO> logSearchByName(LogVO logVO) {
		return adminSecurityMapper.logSearchByName(logVO);
	}

	@Override
	public List<LogVO> logSearchByAll(LogVO logVO) {
		return adminSecurityMapper.logSearchByAll(logVO);
	}
	
}
