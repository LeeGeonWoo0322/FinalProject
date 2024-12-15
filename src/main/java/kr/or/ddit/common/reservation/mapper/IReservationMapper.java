package kr.or.ddit.common.reservation.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;
import kr.or.ddit.common.reservation.vo.ReservationAttendeeVO;
import kr.or.ddit.common.reservation.vo.ReservationVO;

public interface IReservationMapper {

	List<AssetCategoryVO> getAssetCategoryList();

	List<AssetVO> getAssetList(AssetCategoryVO assetCategoryVO);

	AssetCategoryVO getAssetCategory(AssetCategoryVO assetCategoryVO);

	int insertReservation(ReservationVO reservationVO);

	List<ReservationVO> getReservationList();

	ReservationVO getReservation(int resvNo);

	AssetVO getAssetByReservation(ReservationVO reservationVO);

	List<ReservationAttendeeVO> getAttendeeList(ReservationVO reservationVO);

	int updateReservation(ReservationVO reservationVO);

	int cancleReservation(ReservationVO reservationVO);

	AssetCategoryVO getAssetCategoryByAsset(AssetVO assetVO);

	int updateReservationByDrop(ReservationVO reservationVO);

	List<ReservationVO> getMyReservation(MemberVO member);

	List<ReservationVO> getAssetReservationList(int astNo);

	AssetVO getAssetByAstNo(int astNo);

}
