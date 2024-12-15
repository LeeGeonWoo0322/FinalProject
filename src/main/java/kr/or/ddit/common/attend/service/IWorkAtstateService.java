package kr.or.ddit.common.attend.service;

import java.util.List;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.attend.vo.WorkAtstateVO;

public interface IWorkAtstateService {

	public WorkAtstateVO printAtstate(WorkAtstateVO workAtstate);
	
	public int changeWork(WorkAtstateVO atstate);
	
	public List<WorkAtstateVO> curMonth(WorkAtstateVO atstate);

	public List<WorkAtstateVO> atList(WorkAtstateVO atstate);

	public WorkAtstateVO curModal(WorkAtstateVO atstate);

	public int updAtstate(WorkAtstateVO atstate);

	public int delAtstate(WorkAtstateVO atstate);

	public int updWork(WorkAtstateVO atstate);

	public WorkAtstateVO printWorking(WorkAtstateVO atstate);

	public MemberVO printLWork(MemberVO member);

}
