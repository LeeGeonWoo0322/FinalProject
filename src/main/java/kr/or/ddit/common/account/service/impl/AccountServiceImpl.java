package kr.or.ddit.common.account.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.mapper.IAccountMapper;
import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.LogVO;
import kr.or.ddit.common.account.vo.MemberAuthVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.UpgradeReqVO;

@Service
public class AccountServiceImpl implements IAccountService{

	@Inject
	private IAccountMapper accountMapper;
	
	@Override
	public MemberVO loginCheck(MemberVO member) {
		return accountMapper.loginCheck(member);
	}

	@Override
	public MemberVO findId(MemberVO member) {
		MemberVO memberVO = accountMapper.findId(member);
		return memberVO == null ? null : memberVO;
	}

	@Override
	public MemberVO readByUserId(String username) {
		return accountMapper.readByUserId(username);
	}

	@Override
	public int tempPass(MemberVO member) {
		return accountMapper.tempPass(member);
	}

	@Override
	public MemberVO tempPassCheck(String username) {
		return accountMapper.tempPassCheck(username);
	}

	@Override
	public MemberVO getMember(String memId) {
		return accountMapper.getMember(memId);
	}
	
	@Override
	public MemberVO getMemberByNo(int memNo) {
		return accountMapper.getMemberByNo(memNo);
	}

	@Override
	public void changePw(MemberVO memberVO) {
		accountMapper.changePw(memberVO);
	}

	@Override
	public MemberVO getMemberAll(String username) {
		return accountMapper.getMemberAll(username);
	}

	@Override
	public List<MemberAuthVO> checkMemberAuth(MemberVO member) {
		return accountMapper.checkMemberAuth(member);
	}

	@Override
	public MemberAuthVO getSecretKey(MemberVO member) {
		return accountMapper.getSecretKey(member);
	}

	@Override
	public void insertUserLoginLog(LogVO logVO) {
		accountMapper.insertUserLoginLog(logVO);
	}

	@Override
	public void updateMailVolume(UpgradeReqVO upgradeReqVO) {
		accountMapper.updateMailVolume(upgradeReqVO);
	}

	@Override
	public void updateDriveVolume(UpgradeReqVO upgradeReqVO) {
		accountMapper.updateDriveVolume(upgradeReqVO);
	}

}
