package kr.or.ddit.common.project.service.impl;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.ServiceResult;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.approval.vo.FavoriteFormVO;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import kr.or.ddit.common.project.mapper.IProjectMapper;
import kr.or.ddit.common.project.service.IProjectService;
import kr.or.ddit.common.project.vo.ChartVO;
import kr.or.ddit.common.project.vo.CheckListVO;
import kr.or.ddit.common.project.vo.PicNMVO;
import kr.or.ddit.common.project.vo.ProjectAttendeeVO;
import kr.or.ddit.common.project.vo.ProjectVO;
import kr.or.ddit.common.project.vo.WorkComentVO;
import kr.or.ddit.common.project.vo.WorkFavoriteVO;
import kr.or.ddit.common.project.vo.WorkVO;
import kr.or.ddit.common.security.vo.CustomUser;

@Service
public class ProjectServiceImpl implements IProjectService {
	
	@Inject
	private IProjectMapper proMap;

	@Resource(name = "localPath")
	private String localPath;
	
	@Transactional  
	@Override
	// 프로젝트 인서트
	public ServiceResult insertProject(ProjectVO proVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		proVO.setMngPicNo(memberVO.getMemNo());
		int status = 0;
		int stat = 0;
		ProjectAttendeeVO paVO = new ProjectAttendeeVO();
		ServiceResult res = null;
		System.out.println("proVO=============="+proVO);
		status = proMap.insertProject(proVO);
		if(status > 0) {
			
			for(int i=0;  i < proVO.getProAList().size(); i++ ) {
				paVO.setMemNo(proVO.getProAList().get(i));
				paVO.setProjectNo(proVO.getProjectNo());
				proMap.addProjectMem(paVO); 
				stat++;
				System.out.println(stat);
			} 
			if(stat == proVO.getProAList().size()) {
				res = ServiceResult.OK;
			}
		} else {
			res = ServiceResult.FAILED;
		}
		System.out.println("결과는 : "+res);
		return res;
	}

	
	@Transactional
	@Override
	// 프로젝트 디테일
	public Map<String, Object> detailProject(int projectNo, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		int memNo = memberVO.getMemNo();
		
		Map<String,Object> result = new HashMap<String, Object>(); ; 
		Map<String, Object> param = new HashMap<String, Object>();
		List<PicNMVO> picList = new ArrayList<PicNMVO>();
		
//		List<WorkFavoriteVO> favorWork = proMap.favorList(memberVO.getMemNo());
		List<ProjectAttendeeVO> attendeeList = proMap.projectAttendeeList(projectNo);
		
		param.put("projectNo", projectNo);
		param.put("memNo", memNo);
		
		ProjectVO proVO = proMap.detailProject(param);
		if(attendeeList != null && attendeeList.size()>0) {
			proVO.setPaList(attendeeList);
		}
		
		WorkVO countWork = new WorkVO();
		List<WorkVO> workVO = proMap.workList(projectNo);
		if(workVO.size() > 0 && workVO != null) {
			countWork = proMap.countStatus(workVO.get(0).getProjectNo());
		} else {
			countWork = null;
		}
		
		WorkVO work = new WorkVO();
		
		// 프로젝트 내부 work찾기
		List<WorkVO> selectWork = proMap.ListWork(projectNo);
		if(selectWork != null && selectWork.size() > 0) {
			for (int i = 0; i <selectWork.size(); i++) {
				picList = proMap.picList(selectWork.get(i).getWorkNo());
				workVO.get(i).setPicList(picList);
			}
		}
		if(workVO != null && workVO.size()>0) {
			for (int i = 0; i < workVO.size(); i++) {
				int workNo = workVO.get(i).getWorkNo();
				int total = proMap.countCheck(workNo); 
				int chekY = proMap.countCheckY(workNo);
				workVO.get(i).setTotalcheck(total);
				int field = (int)((double) chekY / total *100);
				if(field != work.getField()) {
					work.setField(field);
					work.setWorkNo(workVO.get(i).getWorkNo());
					proMap.updateField(work); 
				}
				
			}
		}
		List<MemberVO> loginMem = proMap.loginMem(memberVO.getMemNo());
		result.put("loginMem",loginMem);
		result.put("workVO",workVO);
		result.put("proVO", proVO);
		if(countWork != null) {
			result.put("countWork", countWork);
		}
		return result;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	// work 생성
	public ServiceResult insertWork(WorkVO workVO, CheckListVO chekVO, PicNMVO picVO, Authentication auth) {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		workVO.setWriterNo(memberVO.getMemNo());
		
		ServiceResult res = null;
		int workStatus = 0;
		int checkStatus = 0;
		int picStatus = 0;
		int fileStatus = 0;
		int fileDetailStatus = 0;
		List<FilesDetailVO> workFileList = workVO.getFileDetailList();
		String locate =  "/project";
		FilesVO filesVO = new FilesVO();

		if(workFileList != null && workFileList.size() > 0) {

			filesVO.setMemNo(memberVO.getMemNo());	
			filesVO.setFileCategory("프로젝트");
			fileStatus = proMap.insertWorkFile(filesVO);	
			
			if(fileStatus > 0) {
				String saveLocate ;
				File file = new File(locate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				for(FilesDetailVO filesDetailVO : workFileList) {
					String saveName = UUID.randomUUID().toString();		// UUID의 랜덤 파일명 생성
					saveName += "_" + filesDetailVO.getFileOriginalname();
					saveLocate = locate + "/" + saveName;	// 파일 복사를 위한 경로 설정
					
					// 파일 데이터를 추가 하기 위한 준비
					filesDetailVO.setMemNo(memberVO.getMemNo());
					filesDetailVO.setFileNo(filesVO.getFileNo());
					filesDetailVO.setFilePath(saveLocate);
					filesDetailVO.setFileUploadname(saveName);
					
					proMap.insertWorkDetailFile(filesDetailVO);
					fileDetailStatus++;
					
					File saveFile = new File(saveLocate);
					try {
						filesDetailVO.getItem().transferTo(saveFile);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}	// 파일 복사
				}
				
			}
		
		}	
		
		if(fileDetailStatus == workFileList.size()) {
			workVO.setFileNo(filesVO.getFileNo());
			workStatus = proMap.insertWortk(workVO);
			if(workStatus > 0) {
				for(int i=0; i<picVO.getMemNoList().size(); i++) {
					picVO.setMemNo(picVO.getMemNoList().get(i));
					picVO.setWorkNo(workVO.getWorkNo());
					proMap.addWorkMem(picVO);
					picStatus++;
					System.out.println(picStatus);
				}
			}
		}
		if(picStatus == picVO.getMemNoList().size()) {
			for(int i=0; i<chekVO.getClNameLsit().size();i++ ) {
				if(chekVO.getClNameLsit().get(i) != null && chekVO.getClNameLsit().size() >0) {
					String clName = chekVO.getClNameLsit().get(i);
					chekVO.setClName(clName);
					chekVO.setWorkNo(workVO.getWorkNo());
					proMap.insertCheck(chekVO);
					checkStatus++;
				}
				
			}
			if(checkStatus == chekVO.getClNameLsit().size()) {
				res = ServiceResult.OK;
			} else {
				res = ServiceResult.FAILED;
			}
		}
		
		return res;
	}
	
	

	@Transactional
	@Override
	// work 별 디테일
	public Map<String, Object> detailWork(WorkVO workVO) {
		Map<String, Object> detailVal = new HashMap<>();	
		ServiceResult res = null;
		List<WorkVO> work = new ArrayList<WorkVO>();
		work = proMap.workDetailList(workVO.getProjectNo());
		
		if(work !=null) {
			detailVal.put("workVO", work);
			res = ServiceResult.OK;
		}
		
		if(res == ServiceResult.OK) {
			detailVal.put("res", ServiceResult.OK);
		}

		return detailVal;
	}
	
	
	

	@Override
	// 프로젝트 홈 리스트
	public Map<String, Object> listHome(ProjectVO proVO, Authentication auth) {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		Map<String,Object> pro = new HashMap<String, Object>(); 
		List<ProjectVO> project = proMap.listHome(memberVO.getMemNo());
		
		List<WorkFavoriteVO> favorWork = proMap.favorList(memberVO.getMemNo());
		List<MemberVO> loginMem = proMap.loginMem(memberVO.getMemNo());
		pro.put("loginMem",loginMem);
		
		
		List<PicNMVO> faPicList = new ArrayList<PicNMVO>();
		if(favorWork != null && favorWork.size() > 0) {
			for (int i = 0; i < favorWork.size(); i++) {
				int faWorkNo = favorWork.get(i).getWorkNo();
				faPicList = proMap.picList(faWorkNo);
				favorWork.get(i).setFaPicList(faPicList);
			
			}
		}
		List<ProjectAttendeeVO> attendeeList = new ArrayList<ProjectAttendeeVO>();
		if(project != null && project.size() > 0) {
			for (int i = 0; i < project.size(); i++) {
				attendeeList = proMap.projectAttendeeList(project.get(i).getProjectNo());
				project.get(i).setPaList(attendeeList);
			}
		}
		pro.put("project", project);
		pro.put("favorWork", favorWork);
		System.out.println("1111111111111111111 : "+attendeeList);
		System.out.println("1111111111111111111 : "+project);
		System.out.println("1111111111111111111 : "+favorWork);
		return pro;
	}

	@Override
	public Map<String, Object> newComent(WorkComentVO wcVO, Authentication auth) {
		ServiceResult sr = null;
		Map<String,Object> res = new HashMap<String, Object>();
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		wcVO.setWriterNo(memberVO.getMemNo());
		String memName = memberVO.getMemName();
		int wc = 0;
		wc = proMap.newComent(wcVO);
		if(wc > 0) {
			res.put("wc", wc);
			res.put("sr",ServiceResult.OK);
			res.put("memName", memName);
			res.put("loginMem",memberVO.getMemNo());
		}
		
		
		return res;
	}

	@Override
	public Map<String, Object> delComent(WorkComentVO wcVO, Authentication auth) {
		Map<String,Object> res = new HashMap<String, Object>();
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		WorkComentVO wcVO1;
		int writer = wcVO.getWriterNo();
		int wcMemNO = memberVO.getMemNo();
		int del = 0;
		ServiceResult re = null;
			
		if(writer == wcMemNO) {
			del = proMap.delComnet(wcVO);
			if(del > 0) {
				re = ServiceResult.OK;
				res.put("re", ServiceResult.OK);
			} else {
				re = ServiceResult.FAILED;
				res.put("re", ServiceResult.FAILED);
			}
		}
		
		
		return res;
	}
	
	@Transactional
	@Override
	public Map<String, Object> delWork(WorkVO workVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		Map<String,Object> res = new HashMap<String, Object>();
		ServiceResult re = null;
		int del = 0;
			int workNo = workVO.getWorkNo();
			int fileNo = workVO.getFileNo();
			
			proMap.delAllComnet(workVO.getWorkNo());
			proMap.delAllCheck(workVO.getWorkNo());
			proMap.delAllFilesDetail(workVO.getFileNo());
			proMap.delAllFile(workVO.getFileNo());
			proMap.delAllPicMem(workVO.getWorkNo());
			del = proMap.delWork(workVO);
			if(del > 0) {
				re = ServiceResult.OK;
			} else {
					re = ServiceResult.FAILED;
			}
			
		return res;
	}

	@Transactional
	@Override
	public Map<String, Object> delProject(ProjectVO proVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		WorkVO workVO = new WorkVO();
		Map<String,Object> res = new HashMap<String, Object>();
		ServiceResult re = null;
		int count = 0;
		System.out.println("proVO ==========="+proVO);
		if(proVO.getFileNoList() != null && proVO.getFileNoList().size() > 0) {
			for (int i = 0; i < proVO.getFileNoList().size(); i++) {
				proMap.delAllFilesDetail(proVO.getFileNoList().get(i));
				proMap.delAllFile(proVO.getFileNoList().get(i));
			}
		} else {
			System.out.println("2");
		}
		
		if(proVO.getWorkNoList() != null && proVO.getWorkNoList().size() > 0 ) {
			for (int i = 0; i < proVO.getWorkList().size(); i++) {
				proMap.delAllComnet(proVO.getWorkList().get(i));
				workVO.setWorkNo(proVO.getWorkList().get(i)); 
				
				proMap.delAllPicMem(proVO.getWorkList().get(i));
				proMap.delWork(workVO);
			}
		} else {
			System.out.println("3");
		}
	
		proMap.delAttendee(proVO.getProjectNo());
		proMap.delFavorite(proVO.getProjectNo());
		
		int delPro = proMap.delProject(proVO);
		
		if(delPro > 0) {
			res.put("re", ServiceResult.OK);
		} else {
			res.put("re", ServiceResult.FAILED);
		}
	System.out.println("123123123123123" + res.get(re));
		return res;
	}

	@Override
	public List<ProjectAttendeeVO> projectAttendeeList(int projectNo) {
		// TODO Auto-generated method stub
		return proMap.projectAttendeeList(projectNo);
	}

	@Override
	public Map<String, Object> checkListYn(CheckListVO checkVO, Authentication auth) {
		ServiceResult result = null;
		Map<String,Object> re = new HashMap<String, Object>();
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		checkVO.setMemNo(memberVO.getMemNo());

		System.out.println("123123123 : "+re);
		int chek = proMap.checkListYn(checkVO);
		if(chek > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		re.put("result", result);
		
		return re;
	}
	
	@Transactional
	@Override
	public Map<String, Object> modwork(WorkVO workVO, CheckListVO checkVO, PicNMVO picVO, ProjectVO proVO, Authentication auth, MultipartFile[] files) {
		ServiceResult sr = null;
		Map<String,Object> res = new HashMap<String, Object>();
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		int pass = 0;
		for(int i = 0; i < picVO.getMemNoList().size(); i++) {
			int memNum = picVO.getMemNoList().get(i);
			if(proVO.getMngPicNo() == memberVO.getMemNo() || memberVO.getMemNo() == memNum) {
				pass = 1;
			} else {
				res.put("msg", "권한이 없습니다.");
				sr = ServiceResult.FAILED;
				return res;
			}
		}
		
		int chek = 0;
		int del = 0;
		int newCheck = 0;
		int delpc = 0;
		int pc = 0;
		int checkSize = checkVO.getModClNameList().size();
		int newChekSize = checkVO.getModNewList().size();
		int pcSize = picVO.getMemNoList().size();
		int workUp = 0;
		int delDetailFile = 0;
		int insertDetailFile = 0;
		int fileStatus = 0;
		FilesVO filesVO = null;
		if(pass == 1) {
			
			List<FilesDetailVO> selectFiles = proMap.getfileDetail(workVO.getFileNo());
			List<FilesDetailVO> fileDetailList = new ArrayList<FilesDetailVO>();
			if(selectFiles != null && selectFiles.size() > 0) {
				delDetailFile = proMap.delAllFilesDetail(workVO.getFileNo());
				if(delDetailFile > 0) {
					for (int i = 0; i < selectFiles.size(); i++) {
					selectFiles.get(i).setFileNo(workVO.getWorkNo());
					proMap.insertWorkFileDetail(selectFiles.get(i));
					insertDetailFile ++;
					}
					
					if(insertDetailFile < selectFiles.size()) {
						res.put("msg", "파일 등록 실패.");
					}
				}
			} else {
				workVO.setAttachedFiles(files);
				List<FilesDetailVO> workFileList = workVO.getFileDetailList();
				String locate = localPath + "/project";
				filesVO = new FilesVO();

				if(workFileList != null && workFileList.size() > 0) {

					filesVO.setMemNo(memberVO.getMemNo());	
					filesVO.setFileCategory("프로젝트");
					fileStatus = proMap.insertWorkFile(filesVO);	
					
					if(fileStatus > 0) {
						String saveLocate ;
						File file = new File(locate);
						if(!file.exists()) {
							file.mkdirs();
						}
						
						for(FilesDetailVO filesDetailVO : workFileList) {
							String saveName = UUID.randomUUID().toString();		// UUID의 랜덤 파일명 생성
							saveName += "_" + filesDetailVO.getFileOriginalname();
							saveLocate = locate + "/" + saveName;	// 파일 복사를 위한 경로 설정
							
							// 파일 데이터를 추가 하기 위한 준비
							filesDetailVO.setMemNo(memberVO.getMemNo());
							filesDetailVO.setFileNo(filesVO.getFileNo());
							filesDetailVO.setFilePath(saveLocate);
							filesDetailVO.setFileUploadname(saveName);
							
							proMap.insertWorkDetailFile(filesDetailVO);
							
							File saveFile = new File(saveLocate);
							try {
								filesDetailVO.getItem().transferTo(saveFile);
							} catch (IllegalStateException e) {
								e.printStackTrace();
							} catch (IOException e) {
								e.printStackTrace();
							}	// 파일 복사
						}
						
					}
				
				}	

			}
			del = proMap.delCheck(workVO.getWorkNo());
			
			if(del >= 0) {
				for(int c=0; c<checkSize; c++) {
					checkVO.setClName(checkVO.getModClNameList().get(c));
					checkVO.setClNo(checkVO.getModCheckNoList().get(c));
					checkVO.setCheckDate(checkVO.getModCheckDateList().get(c));
					checkVO.setMemNo(checkVO.getModCheckMemList().get(c));
					checkVO.setCheckYn(checkVO.getModCheckYnList().get(c));
					checkVO.setWorkNo(workVO.getWorkNo());
					chek = proMap.modCheckList(checkVO);
					
				}
				
				for(int a=0; a < newChekSize;  a++) {
					checkVO.setClName(checkVO.getModNewList().get(a));
					checkVO.setWorkNo(workVO.getWorkNo());
					newCheck = proMap.insertCheck(checkVO);
				}
			}
			
			int total = proMap.countCheck(workVO.getWorkNo()); 
			int chekY = proMap.countCheckY(workVO.getWorkNo());
			int field = (int)((double) chekY / total *100);
			if(field != workVO.getField()) {
				workVO.setField(field);
				workVO.setWorkNo(workVO.getWorkNo());
				proMap.updateField(workVO);
			}
			
			
			delpc = proMap.delAllPicMem(workVO.getWorkNo());
			if(delpc > 0) {
				for (int i = 0; i < pcSize; i++) {
					picVO.setWorkNo(workVO.getWorkNo());
					picVO.setMemNo(picVO.getMemNoList().get(i));
					pc = proMap.addWorkMem(picVO);
				}
			}
			
			if(selectFiles != null && selectFiles.size() > 0) {
				workUp = proMap.modifyWork(workVO);
				if(workUp > 0) {
					sr = ServiceResult.OK;
					res.put("sr", "OK");
					
				} else {
					sr = ServiceResult.FAILED;
					res.put("msg", "에러발생.");
				
				}
			} else {
				workVO.setFileNo(filesVO.getFileNo());
				workUp = proMap.modifyWorkplus(workVO);
				if(workUp > 0) {
					sr = ServiceResult.OK;
					res.put("sr", "OK");
					
				} else {
					sr = ServiceResult.FAILED;
					res.put("msg", "에러발생.");
				
				}
				
			}
			

			
			
			
		}
		
		
		
		
		
		return res;
	}

	
	// 모달 디테일
	@Override
	public Map<String, Object> modalOpen(WorkVO workVO, Authentication auth) {
		Map<String, Object> res = new HashMap<>();
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		List<PicNMVO> memList = proMap.picList(workVO.getWorkNo());
		List<ProjectAttendeeVO> paMemList = proMap.projectAttendeeList(workVO.getProjectNo());
		int pass = 0;
		ProjectVO proVO = proMap.mngPicChek(workVO.getProjectNo());
		if(proVO.getMngPicNo() == memberVO.getMemNo()) {
			pass++;
		}
		for (int i = 0; i < paMemList.size(); i++) {
			if(memberVO.getMemNo() == paMemList.get(i).getMemNo()) {
				pass ++;
			}
		}
		if(memberVO.getMemNo() == workVO.getWriterNo()) {
			pass ++;
		}
		if(pass > 0) {
			WorkVO work = proMap.modalOpen(workVO);
			List<WorkFavoriteVO> favoritesList = proMap.favorList(memberVO.getMemNo());
			List<CheckListVO> checkList = proMap.checkList(workVO.getWorkNo());
			List<WorkComentVO> cmtList = proMap.cmtList(workVO.getWorkNo());
			
			List<MemberVO> loginMem = proMap.loginMem(memberVO.getMemNo());
			res.put("loginMem", loginMem);
			res.put("work", work);
			res.put("cmtList", cmtList);
			res.put("favoritesList", favoritesList);
			res.put("checkList", checkList);
			res.put("member", memberVO.getMemNo());
			res.put("memList", memList);
			res.put("paMemList", paMemList);
		} else {
			res.put("status", "FAILED");
			res.put("msg", "권한이 없습니다.");
		}
		System.out.println("res"+ res);
		res.put("status", "OK");
	
		
		return res;
	}


	@Override
	public Map<String, Object> workStatus(WorkVO workVO) {
		Map<String, Object> re = new HashMap<>();
		int updateStatus = proMap.workStatus(workVO);
		if(updateStatus > 0) {
			re.put("update", "OK");
			
		} else {
			re.put("update", "FAILED");
		}
		WorkVO countWork = proMap.countStatus(workVO.getProjectNo());
		re.put("countWork", countWork);
		return re;
	}


	@Override
	public Map<String, Object> modField(WorkVO workVO) {
		Map<String,Object> res = new HashMap<String, Object>();
		int workNo = workVO.getWorkNo();
		int total = proMap.countCheck(workNo); 
		int chekY = proMap.countCheckY(workNo);
		int field = (int)((double) chekY / total *100);
		if(field >= 0) {
			workVO.setField(field);
			workVO.setWorkNo(workNo);
			proMap.updateField(workVO);
		}

//		List<PicNMVO> picList = proMap.picList(workVO.getWorkNo());
//		List<CheckListVO> checkList = proMap.checkList(workVO.getWorkNo());
//		workInfo.setPicList(picList);
//		workInfo.setCheckList(checkList);
//		res.put("work", workInfo);
		res.put("field", field);
		res.put("status", "OK");
		System.out.println("123123123 : "+field);
		
		return res;
	}

	// 즐겨찾기 등록
	@Override
	public Map<String, Object> favorInsert(WorkFavoriteVO favorVO) {
		Map<String,Object> re = new HashMap<String, Object>();
		favorVO.setFavoriteY("Y");
		int favor = proMap.favorite(favorVO);
		
		if(favor > 0 ) {
			re.put("status", "OK");
		}else {
			re.put("status", "FAILED");
		}
		
		return re;
	}


	@Override
	public Map<String, Object> delFavor(WorkFavoriteVO favorVO) {
		Map<String,Object> re = new HashMap<String, Object>();
		int favor = proMap.delFavor(favorVO);
		
		if(favor > 0 ) {
			re.put("status", "OK");
		}else {
			re.put("status", "FAILED");
		}
		
		return re;
	}


	@Override
	public Map<String, Object> proChart(ChartVO chartVO) {
		Map<String,Object> re = new HashMap<String, Object>();
		ChartVO chart1 = proMap.countVal1(chartVO.getProjectNo());
		ChartVO chart2 = proMap.countVal2(chartVO.getProjectNo());
		ChartVO chart3 = proMap.countVal3(chartVO.getProjectNo());
		ChartVO chart4 = proMap.countVal4(chartVO.getProjectNo());
		re.put("chart1", chart1);
		re.put("chart2", chart2);
		re.put("chart3", chart3);
		re.put("chart4", chart4);
		return re;
	}
	@Override
	public Map<String, Object> picChart(ChartVO chartVO) {
		Map<String,Object> re = new HashMap<String, Object>();
		List<ProjectAttendeeVO> attendeeList = new ArrayList<ProjectAttendeeVO>();
		List<ChartVO> paChartList = new ArrayList<ChartVO>();
		ChartVO chart = new ChartVO();
		int memNo = 0;
		if(chartVO.getMemNo() == 0) {
			attendeeList = proMap.projectAttendeeList(chartVO.getProjectNo());
			if(attendeeList != null && attendeeList.size() > 0) {
				for (int j = 0; j < attendeeList.size(); j++) {
					memNo = attendeeList.get(j).getMemNo();
					chartVO.setMemNo(memNo);
					paChartList.add(proMap.picChart(chartVO));
				}
				if(paChartList != null) {
					re.put("val", "all");
					re.put("status", "OK");
					re.put("chart", paChartList);
				}
			} else {
				chart = proMap.picChart(chartVO);
				if(chart != null) {
					re.put("status", "OK");
					re.put("val", "one");
					re.put("chart", chart);
				} else {
					re.put("status", "FAILED");
				}
			}
		} else {
			chart = proMap.picChart(chartVO);
			if(chart != null) {
				re.put("status", "OK");
				re.put("val", "one");
				re.put("chart", chart);
			} else {
				re.put("status", "FAILED");
			}
		}
		System.out.println("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee : "+re);
		return re;
	}


	@Override
	public Map<String, Object> sider(MemberVO memberVO, Authentication auth) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO1 = customUser.getMember();
		int memNo = memberVO.getMemNo();
		Map<String,Object> re = new HashMap<String, Object>();
		List<ChartVO> sider = proMap.siderList(memNo);
		re.put("sider", sider);
		re.put("loginMemNo", memberVO1.getMemNo());
		return re;
	}


	@Override
	public Map<String, Object> updatePrograss(WorkVO workVO) {
		Map<String,Object> re = new HashMap<String, Object>();
		int work = proMap.updatePrograss(workVO);
		WorkVO countWork = new WorkVO(); 
		if(work > 0) {
			re.put("status", "OK");
			
		}else {
			re.put("status", "FAILED");
		}
		countWork = proMap.countStatus(workVO.getProjectNo());
		re.put("countWork", countWork);
		return re;
	}


	@Override
	public Map<String, Object> dueEnd(WorkVO workVO) {
		Map<String,Object> re = new HashMap<String, Object>();
		if(workVO.getWorkList() != null && workVO.getWorkList().size() > 0) {
			int workNo = 0;
			int upWork = 0;
			String workPrograss;
			WorkVO countWork = new WorkVO(); 
			for (int i = 0; i < workVO.getWorkList().size(); i++) {
				workNo = workVO.getWorkList().get(i);
				workPrograss = workVO.getPrograssList().get(i);
				workVO.setWorkNo(workNo);
				workVO.setWorkPrograss(workPrograss);
				upWork = proMap.dueEnd(workVO);
			}
			if(upWork == workVO.getWorkList().size()) {
				re.put("status", "OK");
			} else {
				re.put("status", "FAILED");
			}
			countWork = proMap.countStatus(workVO.getProjectNo());
			re.put("countWork", countWork);
		}
		return re;
	}
 

	@Override
	public Map<String, Object> homeProjectList(int memNo) {
		Map<String,Object> re = new HashMap<String, Object>();
		List<ProjectVO> proVO = proMap.listHome(memNo);
		int totalField = 0;
		int projectNo = 0;
		int workField = 0;
		List<WorkVO> workVO = new ArrayList<WorkVO>();
		if(proVO != null) {
			for (int i = 0; i < proVO.size(); i++) {
				projectNo = proVO.get(i).getProjectNo();
				workVO = proMap.projectField(projectNo);
				workField = 0;
				for (int j = 0; j < workVO.size(); j++) {
					workField += workVO.get(j).getField();
				}
				totalField = (int)((double) workField / workVO.size());
				proVO.get(i).setTotalField(totalField);
			}
		}
		re.put("proVO", proVO);
		
		return re;
	}



	
	
}
