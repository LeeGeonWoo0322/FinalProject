package kr.or.ddit.admin.reservation.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.admin.reservation.mapper.IAdminReservationMapper;
import kr.or.ddit.admin.reservation.service.IAdminReservationService;
import kr.or.ddit.common.account.vo.PositionVO;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;

@Service
public class AdminReservationServiceImpl implements IAdminReservationService{

	@Inject
	private IAdminReservationMapper adminReservationMapper;
	
	@Override
	public List<PositionVO> getPositionList() {
		return adminReservationMapper.getPositionList();
	}

	@Override
	public int insertAssetCategory(AssetCategoryVO assetCategoryVO) {
		return adminReservationMapper.insertAssetCategory(assetCategoryVO);
	}

	@Override
	public List<AssetCategoryVO> getAssetCategory() {
		return adminReservationMapper.getAssetCategory();
	}

	@Override
	public AssetCategoryVO getAssetCategoryDetail(AssetCategoryVO assetCategoryVO) {
		return adminReservationMapper.getAssetCategoryDetail(assetCategoryVO);
	}

	@Override
	public AssetCategoryVO getLastAssetCategoryDetail() {
		return adminReservationMapper.getLastAssetCategoryDetail();
	}

	@Override
	public int updateAssetCategory(AssetCategoryVO assetCategoryVO) {
		return adminReservationMapper.updateAssetCategory(assetCategoryVO);
	}

	@Override
	public int updateUseInfo(AssetCategoryVO assetCategoryVO) {
		return adminReservationMapper.updateUseInfo(assetCategoryVO);
	}

	@Override
	public List<AssetVO> getAssetByAcNo(AssetCategoryVO assetCategoryVO) {
		return adminReservationMapper.getAssetByAcNo(assetCategoryVO);
	}

	@Override
	public int addAsset(AssetVO assetVO) {
		return adminReservationMapper.addAsset(assetVO);
	}

	@Override
	public AssetVO getLastAssetDetail() {
		return adminReservationMapper.getLastAssetDetail();
	}

	@Override
	public int updateAssetCategoryByAsset(AssetVO assetVO) {
		return adminReservationMapper.updateAssetCategoryByAsset(assetVO);
	}

	@Override
	public List<AssetVO> getAsset(AssetVO assetVO) {
		return adminReservationMapper.getAsset(assetVO);
	}

}
