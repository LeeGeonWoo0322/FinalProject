package kr.or.ddit.admin.security.mapper;

import java.util.List;

import kr.or.ddit.common.account.vo.LogVO;

public interface IAdminSecurityMapper {

	List<LogVO> getLogList();

	List<LogVO> logSearchByPeriod(LogVO logVO);

	List<LogVO> logSearchByName(LogVO logVO);

	List<LogVO> logSearchByAll(LogVO logVO);

}
