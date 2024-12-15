package kr.or.ddit.admin.basic.service;

import java.util.List;

import kr.or.ddit.common.account.vo.UpgradeReqVO;

public interface IAdminBasicService {

	List<UpgradeReqVO> getUpgradeReqList();

	void updateUpgradeReq(UpgradeReqVO upgradeReqVO);

	UpgradeReqVO getUpgradeReqByUrNo(UpgradeReqVO upgradeReqVO);

	List<UpgradeReqVO> searchReq(UpgradeReqVO upgradeReqVO);

}
