package kr.or.ddit.common.reservation.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.reservation.mapper.IReservationMapper;
import kr.or.ddit.common.reservation.service.IReservationService;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;
import kr.or.ddit.common.reservation.vo.ReservationAttendeeVO;
import kr.or.ddit.common.reservation.vo.ReservationVO;

@Service
public class ReservationServiceImpl implements IReservationService{

	@Inject
	IReservationMapper reservationMapper;

	@Override
	public List<AssetCategoryVO> getAssetCategoryList() {
		return reservationMapper.getAssetCategoryList();
	}

	@Override
	public List<AssetVO> getAssetList(AssetCategoryVO assetCategoryVO) {
		return reservationMapper.getAssetList(assetCategoryVO);
	}

	@Override
	public AssetCategoryVO getAssetCategory(AssetCategoryVO assetCategoryVO) {
		return reservationMapper.getAssetCategory(assetCategoryVO);
	}

	@Override
	public int insertReservation(ReservationVO reservationVO) {
		return reservationMapper.insertReservation(reservationVO);
	}

	@Override
	public List<ReservationVO> getReservationList() {
		return reservationMapper.getReservationList();
	}

	@Override
	public ReservationVO getReservation(int resvNo) {
		return reservationMapper.getReservation(resvNo);
	}

	@Override
	public AssetVO getAssetByReservation(ReservationVO reservationVO) {
		return reservationMapper.getAssetByReservation(reservationVO);
	}

	@Override
	public List<ReservationAttendeeVO> getAttendeeList(ReservationVO reservationVO) {
		return reservationMapper.getAttendeeList(reservationVO);
	}

	@Override
	public int updateReservation(ReservationVO reservationVO) {
		return reservationMapper.updateReservation(reservationVO);
	}

	@Override
	public int cancleReservation(ReservationVO reservationVO) {
		return reservationMapper.cancleReservation(reservationVO);
	}

	@Override
	public AssetCategoryVO getAssetCategoryByAsset(AssetVO assetVO) {
		return reservationMapper.getAssetCategoryByAsset(assetVO);
	}

	@Override
	public int updateReservationByDrop(ReservationVO reservationVO) {
		return reservationMapper.updateReservationByDrop(reservationVO);
	}

	@Override
	public List<ReservationVO> getMyReservation(MemberVO member) {
		return reservationMapper.getMyReservation(member);
	}

	@Override
	public List<ReservationVO> getAssetReservationList(int astNo) {
		return reservationMapper.getAssetReservationList(astNo);
	}

	@Override
	public AssetVO getAssetByAstNo(int astNo) {
		return reservationMapper.getAssetByAstNo(astNo);
	}

}
