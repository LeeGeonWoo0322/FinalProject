package kr.or.ddit.admin.reservation.service;

import java.util.List;

import kr.or.ddit.common.account.vo.PositionVO;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;

public interface IAdminReservationService {

	public List<PositionVO> getPositionList();

	public int insertAssetCategory(AssetCategoryVO assetCategoryVO);

	public List<AssetCategoryVO> getAssetCategory();

	public AssetCategoryVO getAssetCategoryDetail(AssetCategoryVO assetCategoryVO);

	public AssetCategoryVO getLastAssetCategoryDetail();

	public int updateAssetCategory(AssetCategoryVO assetCategoryVO);

	public int updateUseInfo(AssetCategoryVO assetCategoryVO);

	public List<AssetVO> getAssetByAcNo(AssetCategoryVO assetCategoryVO);

	public int addAsset(AssetVO assetVO);

	public AssetVO getLastAssetDetail();

	public int updateAssetCategoryByAsset(AssetVO assetVO);

	public List<AssetVO> getAsset(AssetVO assetVO);

}
