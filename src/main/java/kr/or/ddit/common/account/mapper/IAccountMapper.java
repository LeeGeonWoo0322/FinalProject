package kr.or.ddit.common.account.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.LogVO;
import kr.or.ddit.common.account.vo.MemberAuthVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;

public interface IAccountMapper {

	public MemberVO loginCheck(MemberVO member);

	public MemberVO findId(MemberVO member);

	public MemberVO readByUserId(String username);

	public int tempPass(MemberVO member);

	public MemberVO tempPassCheck(String username);

	public MemberVO getMember(String memId);
	
	public MemberVO getMemberByNo(int memNo);

	public void changePw(MemberVO memberVO);

	public MemberVO getMemberAll(String username);

	public List<MemberAuthVO> checkMemberAuth(MemberVO member);

	public MemberAuthVO getSecretKey(MemberVO member);

	public void insertUserLoginLog(LogVO logVO);

	public void updateMailVolume(UpgradeReqVO upgradeReqVO);

	public void updateDriveVolume(UpgradeReqVO upgradeReqVO);

}
