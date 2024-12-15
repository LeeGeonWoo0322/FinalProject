package kr.or.ddit.common.attend.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.mapper.IWorkAtstateMapper;
import kr.or.ddit.common.attend.service.IWorkAtstateService;
import kr.or.ddit.common.attend.vo.WorkAtstateVO;

@Service
public class WorkAtstateServiceImpl implements IWorkAtstateService {
	
	@Inject
	private IWorkAtstateMapper workAtstateMapper;
	
	@Override
	public WorkAtstateVO printAtstate(WorkAtstateVO workAtstate) {
		
		WorkAtstateVO res = workAtstateMapper.printAtstate(workAtstate);
		
		return res;
	}
	
	@Override
	public int changeWork(WorkAtstateVO atstate) {
		int res = workAtstateMapper.changeWork(atstate);
		workAtstateMapper.changeMemStatus(atstate);
		
		return res;
	}

	@Override
	public List<WorkAtstateVO> curMonth(WorkAtstateVO atstate) {
		List<WorkAtstateVO> res = workAtstateMapper.curMonth(atstate);
		
		return res;
	}

	@Override
	public List<WorkAtstateVO> atList(WorkAtstateVO atstate) {
		List<WorkAtstateVO> res = workAtstateMapper.atList(atstate);
		
		
		return res;
	}

	@Override
	public WorkAtstateVO curModal(WorkAtstateVO atstate) {
		WorkAtstateVO res = workAtstateMapper.curModal(atstate);
		
		return res;
	}

	@Override
	public int updAtstate(WorkAtstateVO atstate) {
		int res = workAtstateMapper.updAtstate(atstate);
		
		return res;
	}

	@Override
	public int delAtstate(WorkAtstateVO atstate) {
		int res = workAtstateMapper.delAtstate(atstate);
		
		return res;
	}

	@Override
	public int updWork(WorkAtstateVO atstate) {
		int res = workAtstateMapper.updWork(atstate);
		
		return res;
	}

	@Override
	public WorkAtstateVO printWorking(WorkAtstateVO atstate) {
		WorkAtstateVO res = workAtstateMapper.printWorking(atstate);
		
		return res;
	}

	@Override
	public MemberVO printLWork(MemberVO member) {
		MemberVO res = workAtstateMapper.printLWork(member);
		
		return res;
	}
}
