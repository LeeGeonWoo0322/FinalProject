package kr.or.ddit.admin.basic.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.basic.mapper.IAdminBasicMapper;
import kr.or.ddit.admin.basic.service.IAdminBasicService;
import kr.or.ddit.common.account.vo.UpgradeReqVO;

@Service
public class AdminBasicServiceImpl implements IAdminBasicService{

	@Inject
	private IAdminBasicMapper adminBasicMapper;
	
	@Override
	public List<UpgradeReqVO> getUpgradeReqList() {
		return adminBasicMapper.getUpgradeReqList();
	}

	@Override
	public void updateUpgradeReq(UpgradeReqVO upgradeReqVO) {
		adminBasicMapper.updateUpgradeReq(upgradeReqVO);
	}

	@Override
	public UpgradeReqVO getUpgradeReqByUrNo(UpgradeReqVO upgradeReqVO) {
		return adminBasicMapper.getUpgradeReqByUrNo(upgradeReqVO);
	}

	@Override
	public List<UpgradeReqVO> searchReq(UpgradeReqVO upgradeReqVO) {
		return adminBasicMapper.searchReq(upgradeReqVO);
	}

}
