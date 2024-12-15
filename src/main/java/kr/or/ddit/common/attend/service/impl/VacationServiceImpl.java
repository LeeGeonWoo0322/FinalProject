package kr.or.ddit.common.attend.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.attend.mapper.IVacationMapper;
import kr.or.ddit.common.attend.service.IVacationService;
import kr.or.ddit.common.attend.vo.AttendanceVO;
import kr.or.ddit.common.attend.vo.UseVacationVO;
import kr.or.ddit.common.attend.vo.VacCreateVO;

@Service
public class VacationServiceImpl implements IVacationService{
	
	@Inject
	private IVacationMapper vacationMapper;

	@Override
	public List<UseVacationVO> vacaAllList(UseVacationVO useVaca) {
		List<UseVacationVO> res =vacationMapper.vacaAllList(useVaca); 
		
		return res;
	}

	@Override
	public List<VacCreateVO> createVacaList(VacCreateVO createVaca) {
		List<VacCreateVO> res =vacationMapper.createVacaList(createVaca); 
		
		return res;
	}

	@Override
	public List<UseVacationVO> myVacaTotal(UseVacationVO useVaca) {
		List<UseVacationVO> res =vacationMapper.myVacaTotal(useVaca); 
		
		return res;
	}

	@Override
	public List<VacCreateVO> myCreateVacaTotal(VacCreateVO createVaca) {
		List<VacCreateVO> res =vacationMapper.myCreateVacaTotal(createVaca);
		
		return res;
	}

	@Override
	public int deptVaca(AttendanceVO attendance) {
		int res = vacationMapper.deptVaca(attendance);
		
		return res;
	}
	
}
