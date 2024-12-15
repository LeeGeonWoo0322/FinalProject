package kr.or.ddit.common.project.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.approval.vo.FavoriteFormVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import kr.or.ddit.common.project.vo.ChartVO;
import kr.or.ddit.common.project.vo.CheckListVO;
import kr.or.ddit.common.project.vo.PicNMVO;
import kr.or.ddit.common.project.vo.ProjectAttendeeVO;
import kr.or.ddit.common.project.vo.ProjectVO;
import kr.or.ddit.common.project.vo.WorkComentVO;
import kr.or.ddit.common.project.vo.WorkFavoriteVO;
import kr.or.ddit.common.project.vo.WorkVO;

public interface IProjectMapper {

	public int insertProject(ProjectVO proVO);

	public int addMem(ProjectAttendeeVO proMem);

	public int favorite(WorkFavoriteVO workFavorite);

	public List<ProjectAttendeeVO> detailMem(int projectNo);

	public int insertWorkFile(FilesVO filesVO);

	public int insertWortk(WorkVO workVO);

	public void insertWorkDetailFile(FilesDetailVO filesDetailVO);

	public int addWorkMem(PicNMVO picVO);

	public int insertCheck(CheckListVO chekVO);

	public List<WorkVO> workList(int projectNo);

	public ProjectVO proWorkList(int workNo);

	public List<CheckListVO> checkList(int workNo);

	public List<PicNMVO> picList(int workNo);

	public FilesVO getfile(int workNo);

	public List<FilesDetailVO> getfileDetail(int fileNo);


	public List<WorkVO> workDetailList(int projectNo);

	public List<ProjectVO> listHome(int memNo);

	public Integer countWorkMem(int projectNo);

	public Integer countWork(int projectNo);

	public int newComent(WorkComentVO wcVO);

	public int delComnet(WorkComentVO wcVO);

	public int delFilesDetail(int fileNo);

	public int delFile(int fileNo);

	public int delPicMem(int workNo);

	public int delWork(WorkVO workVO);

	public int delAllComnet(int fileNo);

	public int delAllCheck(int writerNo);

	public int delAllFile(int fileNo);

	public int delAllPicMem(int workNo);

	public int delAllFilesDetail(int fileNo);

	public int delProject(ProjectVO proVO);

	public void delAttendee(int projectNo);

	public void delFavorite(int projectNo);

	public int deleteWork(int workNo, int fileNo);


	public void addProjectMem(ProjectAttendeeVO paVO);

	public List<ProjectAttendeeVO> projectAttendeeList(int projectNo);

	public int deleteWork(WorkVO workVO);

	public int deleteNoFileWork(WorkVO workVO);

	public int checkListYn(CheckListVO checkVO);

	public int delCheck(int workNo);

	public int modCheckList(CheckListVO checkVO);

	public int modifyWork(WorkVO workVO);

	public List<FilesDetailVO> selectFiles(int fileNo);

	public void insertWorkFileDetail(FilesDetailVO filesDetailVO);

	public int modifyWorkplus(WorkVO workVO);

	public List<WorkFavoriteVO> favorList(int memNo);

	public WorkVO modalOpen(WorkVO workVO);

	public ProjectVO mngPicChek(int projectNo);

	public List<WorkComentVO> cmtList(int workNo);

	public int countCheck(int workNo);

	public int countCheckY(int workNo);


	public int updateField(WorkVO workVO);

	public int workStatus(WorkVO workVO);


	public ProjectVO detailProject(Map<String, Object> param);

	public List<PicNMVO> picList(WorkVO workVO);

	public List<WorkVO> ListWork(int projectNo);

	public List<MemberVO> loginMem(int memNo);

	public int delFavor(WorkFavoriteVO favorVO);

	public List<ChartVO> siderList(int memNo);


	public ChartVO picChart(ChartVO chartVO);

	public WorkVO countStatus(int projectNo);

	public WorkVO workDetail(int workNo);

	public int updatePrograss(WorkVO workVO);

	public ChartVO countVal1(int projectNo);
	public ChartVO countVal2(int projectNo);
	public ChartVO countVal3(int projectNo);
	public ChartVO countVal4(int projectNo);

	public List<ChartVO> paChart(ChartVO chartVO);

	public int dueEnd(WorkVO workVO);

	public List<ProjectVO> listHome1(int memNo);

	public List<WorkVO> projectField(int projectNo);





}
