package kr.or.ddit.admin.reservation.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.PositionVO;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;

public interface IAdminReservationMapper {

	List<PositionVO> getPositionList();

	int insertAssetCategory(AssetCategoryVO assetCategoryVO);

	List<AssetCategoryVO> getAssetCategory();

	AssetCategoryVO getAssetCategoryDetail(AssetCategoryVO assetCategoryVO);

	AssetCategoryVO getLastAssetCategoryDetail();

	int updateAssetCategory(AssetCategoryVO assetCategoryVO);

	int updateUseInfo(AssetCategoryVO assetCategoryVO);

	List<AssetVO> getAssetByAcNo(AssetCategoryVO assetCategoryVO);

	int addAsset(AssetVO assetVO);

	AssetVO getLastAssetDetail();

	int updateAssetCategoryByAsset(AssetVO assetVO);

	List<AssetVO> getAsset(AssetVO assetVO);

}
