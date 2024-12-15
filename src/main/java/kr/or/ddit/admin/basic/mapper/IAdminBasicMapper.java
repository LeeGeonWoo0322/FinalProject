package kr.or.ddit.admin.basic.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.UpgradeReqVO;

public interface IAdminBasicMapper {

	List<UpgradeReqVO> getUpgradeReqList();

	void updateUpgradeReq(UpgradeReqVO upgradeReqVO);

	UpgradeReqVO getUpgradeReqByUrNo(UpgradeReqVO upgradeReqVO);

	List<UpgradeReqVO> searchReq(UpgradeReqVO upgradeReqVO);

}
