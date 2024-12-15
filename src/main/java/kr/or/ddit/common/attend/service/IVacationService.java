package kr.or.ddit.common.attend.service;

import java.util.List;

import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import kr.or.ddit.common.attend.vo.VacCreateVO;

public interface IVacationService {

	public List<UseVacationVO> vacaAllList(UseVacationVO useVaca);
	public List<VacCreateVO> createVacaList(VacCreateVO useVaca);
	public List<UseVacationVO> myVacaTotal(UseVacationVO useVaca);
	public List<VacCreateVO> myCreateVacaTotal(VacCreateVO createVaca);
	public int deptVaca(AttendanceVO attendance);
	
}
