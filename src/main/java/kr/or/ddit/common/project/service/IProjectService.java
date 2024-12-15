package kr.or.ddit.common.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.project.vo.ChartVO;
import kr.or.ddit.common.project.vo.CheckListVO;
import kr.or.ddit.common.project.vo.PicNMVO;
import kr.or.ddit.common.project.vo.ProjectAttendeeVO;
import kr.or.ddit.common.project.vo.ProjectVO;
import kr.or.ddit.common.project.vo.WorkComentVO;
import kr.or.ddit.common.project.vo.WorkFavoriteVO;
import kr.or.ddit.common.project.vo.WorkVO;

public interface IProjectService {


	Map<String, Object> detailProject(int projectNo, Authentication auth);

	ServiceResult insertProject(ProjectVO proVO, Authentication auth);

	Map<String, Object> detailWork(WorkVO workVO);

	Map<String, Object> listHome(ProjectVO proVO, Authentication auth);

	Map<String, Object> newComent(WorkComentVO wcVO, Authentication auth);

	Map<String, Object> delComent(WorkComentVO wcVO, Authentication auth);

	Map<String, Object> delWork(WorkVO workVO, Authentication auth);

	Map<String, Object> delProject(ProjectVO proVO, Authentication auth);

	ServiceResult insertWork(WorkVO workVO, CheckListVO chekVO, PicNMVO picVO,
			Authentication auth) throws Exception;

	List<ProjectAttendeeVO> projectAttendeeList(int projectNo);

	Map<String, Object> checkListYn(CheckListVO checkVO, Authentication auth);

	Map<String, Object> modwork(WorkVO workVO, CheckListVO checkVO, PicNMVO picVO, ProjectVO proVO, Authentication auth, MultipartFile[] files);

	Map<String, Object> modalOpen(WorkVO workVO, Authentication auth);

	Map<String, Object> workStatus(WorkVO workVO);

	Map<String, Object> modField(WorkVO workVO);

	Map<String, Object> favorInsert(WorkFavoriteVO favorVO);

	Map<String, Object> delFavor(WorkFavoriteVO favorVO);

	Map<String, Object> proChart(ChartVO chartVO);

	Map<String, Object> sider(MemberVO memberVO, Authentication auth);

	Map<String, Object> picChart(ChartVO chartVO);

	Map<String, Object> updatePrograss(WorkVO workVO);

	Map<String, Object> dueEnd(WorkVO workVO);

	Map<String, Object> homeProjectList(int memNo);




  
	
	
}
