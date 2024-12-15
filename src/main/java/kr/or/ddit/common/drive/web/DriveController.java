package kr.or.ddit.common.drive.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.drive.service.IDriveService;
import kr.or.ddit.common.drive.vo.DriveFileVO;
import kr.or.ddit.common.drive.vo.DriveFolderVO;
import kr.or.ddit.common.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/drive")
public class DriveController {
	
	@Resource(name = "localPath")
	private String resourcePath;
	
	@Inject
	private IDriveService driveService;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerDriveForm() {
		log.info("일단 잘 옴");
		return "drive/register";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping(value = "/register", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> registerDrive(Model model, @RequestPart("files") MultipartFile[] files, DriveFileVO driveFileVO) throws Exception {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		// 넣어야 하는 정보
		// 드라이브 파일 - 파일번호, 폴더번호, 파일이름, 파일경로, 파일타입, 생성일, 수정일(X), 타입, 삭제(X)
		// 첨부파일	- 파일번호, 파일카테고리, 최초등록자, 삭제여부
		// 첨부파일상세	- 첨부파일 상세번호, 파일번호, 첨부파일저장경로, 첨부파일사이즈
		//			- 첨부파일 확장자, 첨부파일 원본명, 첨부파일 저장명, 첨부파일 등록일시
		//			- 첨부파일 등록자, 첨부파일 삭제여부, 첨부파일 다운로드 횟수
		
		
		int totalCnt = 0; 

		for(int i=0; i<files.length; i++) {
			MultipartFile file = files[i];
//			log.info("fileName : " + file.getOriginalFilename());
//			log.info("filebyte[] : " + file.getBytes());
			
			String uploadedFileName = UploadFile(file);	// 파일 경로랑 uuid 붙은 녀석
			int fileNameIndex = uploadedFileName.lastIndexOf("/");
			// uuid 붙은 파일이름
			String fileName = file.getOriginalFilename();
			// 경로
			String Path = uploadedFileName;
			int index = uploadedFileName.lastIndexOf(".");
			// 파일 타입
			String extension = uploadedFileName.substring(index + 1);
			//크기
			int fileSize = (int) file.getSize();
			
			int memNo = memberVO.getMemNo();
			
			int test = 123;
			int test2 = 123;
			driveFileVO.setDfName(fileName);
			driveFileVO.setDfPath(Path);
			driveFileVO.setDfSize(fileSize);
			driveFileVO.setDfMime(extension);
			driveFileVO.setMemNo(memNo);
			
			int cnt = driveService.registerFile(driveFileVO);
			
			totalCnt += cnt;
			
		}

		String respo = "controller다녀옴!";
		
		if(totalCnt == files.length) {
			respo = "업로드 성공";
		}else {
			respo = "업로드 실패";
		}
		
		return new ResponseEntity<String>(respo, HttpStatus.OK);
	}
	
	// 파일 업로드 하기
	private String UploadFile(MultipartFile file) throws Exception {
		UUID uuid = UUID.randomUUID();
		String uuidName = uuid.toString() + "_" + file.getOriginalFilename();
		
		// 경로 만들기
		String firstFolder = File.separator+"finalDrive";
		String secondFolder = firstFolder + File.separator + "driveFiles";
		// 경로로 폴더 만들기
		makeDir(resourcePath,firstFolder,secondFolder);
		
		File target = new File(resourcePath + secondFolder, uuidName);
		byte[] fileData = file.getBytes();
		FileCopyUtils.copy(fileData,target);	// 파일복사
		
		String uploadedFileName = secondFolder.replace(File.separatorChar,'/')+"/"+uuidName;
		
		return uploadedFileName;
	}

	private static void makeDir(String uploadPath, String ...Folders) {
		if(new File(Folders[Folders.length -1]).exists()) {
			return;
		}
		
		for (String path : Folders) {
			File dirPath = new File(uploadPath + path);
			
			// 경로에 각 폴더가 없으면 각각 만들어준다.
			if(!dirPath.exists()) {
				dirPath.mkdirs();
			}
		}
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String driveList(Model model) {
		log.info("driveList 실행됨");
		
		List<DriveFileVO> fileList = driveService.getDriveFileList();
		List<DriveFolderVO> folderList = driveService.getDriveFolderList();
		model.addAttribute("fileList",fileList);
		model.addAttribute("folderList",folderList);
		
		// 하위폴더를 모달 창에 띄우기 위한 녀석들
		List<DriveFolderVO> underFolderList = driveService.getUnderFolderList();
		List<DriveFolderVO> underFileList = driveService.getUnderFileList();
		model.addAttribute("underFolderList",underFolderList);
		
		// 용량을 보여주기 위한 녀석들
		List<DriveFileVO> totalByte = driveService.gettotalByte();
		
		int totalSize = 0;
		
		for(int i=0; i<totalByte.size(); i++) {
			int size = totalByte.get(i).getDfSize();
			totalSize += size;
		}

		Gson gson = new Gson();
		
		String jsonUnderFolder = gson.toJson(underFolderList);
		String jsonFileList = gson.toJson(fileList);
		String jsonFolderList = gson.toJson(folderList);
		String jsonUnderFile = gson.toJson(underFileList);
		
		model.addAttribute("jsonUnderFile",jsonUnderFile);
		model.addAttribute("jsonUnderFolder",jsonUnderFolder);
		model.addAttribute("jsonFileList",jsonFileList);
		model.addAttribute("jsonFolderList",jsonFolderList);
		model.addAttribute("totalSize",totalSize);
		
		String test = "test";
		
		return "drive/list";
		
	}
	
	// 파일 다운로드 버튼 눌리면 작동함
	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public ResponseEntity<byte[]> goHome1102(int dfNo){ 

		DriveFileVO driveFile = driveService.getDriveFile(dfNo);
		
		String filePath = resourcePath + driveFile.getDfPath();
		String fileName = driveFile.getDfName();;
		HttpHeaders headers = new HttpHeaders();
//		driveFile.getDfSize();
		
		InputStream in = null;
		ResponseEntity<byte[]>entity = null;
		
		try {
			in = new FileInputStream(filePath);
			// MediaType.APPLICATION_OCTET_STREAM은 이진 파일을 위한 기본값입니다.
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\"" +
					new String(fileName.getBytes("UTF-8"),"ISO-8859-1") + "\"");
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers, HttpStatus.CREATED);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			try {
				in.close();
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
		return entity;
	}
	
	
	@RequestMapping(value = "/folderView", method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> folderView(@RequestBody DriveFolderVO driveFolderVO){
		
		int folderNo = driveFolderVO.getFolderNo();
//		DriveFileVO driveFileVO = new DriveFileVO();

		DriveFolderVO upperFolderNo = driveService.getUpperFolderNo(folderNo);
		String folderName = "";
		int parentFolderNO = 0;
		
		if(upperFolderNo != null) {
			parentFolderNO = upperFolderNo.getFolderParentNo();
			 folderName = upperFolderNo.getFolderName();
		}
		
		List<DriveFolderVO> foldersInFolder = driveService.getFoldersInFolder(folderNo);
		List<DriveFileVO> filesInFolder = driveService.getFilesInFolder(folderNo);
		int folderType = driveService.getFolderType(folderNo);
		List<DriveFolderVO> folderPaths = driveService.getFolderPaths(folderNo);
		
		String folderPath = "";  // 폴더 경로
		
		for(int i = 0; i<folderPaths.size(); i++) {
			if(i == 0) {
				folderPath += folderPaths.get(i).getFolderName();
			}else {
				folderPath += " - "+folderPaths.get(i).getFolderName();
			}
		}
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		if(folderPath != "" && !(folderPath.isEmpty())) {
			resultMap.put("folderPath", folderPath);
		}
		resultMap.put("folders",foldersInFolder);
		resultMap.put("files", filesInFolder);
		resultMap.put("upperFolderNo", parentFolderNO);
		resultMap.put("folderType", folderType);
		resultMap.put("folderName",folderName);
		
		return new ResponseEntity<Map<String,Object>>(resultMap,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/createFolder", method = RequestMethod.POST)
	public String createFolder(DriveFolderVO driveFolderVO) {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();

		driveFolderVO.setMemNo(memberVO.getMemNo());
		
		int folderParentNo = driveFolderVO.getFolderParentNo();
		
		if(folderParentNo == 9292) {
			driveFolderVO.setFolderType(1);
			driveFolderVO.setFolderParentNo(0);
		}else if(folderParentNo == 9494) {
			driveFolderVO.setFolderType(2);
			driveFolderVO.setFolderParentNo(0);
		}else {
			int folderType = driveService.getFolderType(folderParentNo);
			driveFolderVO.setFolderType(folderType);
		}
		int cnt = driveService.registerFolder(driveFolderVO);
		
		return "redirect:/drive/list";
	}
	
	
	@RequestMapping(value = "/filesDownload", method = RequestMethod.POST)
	public void selectDownload(
	        @RequestParam(name = "selectedFolder", required = false) String selectedFolder,
	        @RequestParam(name = "selectedFile", required = false) String selectedFile,
	        HttpServletResponse response) {

	    log.info("asd" + selectedFolder);
	    log.info("asd" + selectedFile);

	    List<DriveFileVO> paths = new ArrayList<>();
	    String zipName = "";
	    
	    if (selectedFile != null && !selectedFile.isEmpty()) {
	        String[] file = selectedFile.split(",");
	        for (String files : file) {
	            log.info(files);
	            int dfNo = Integer.parseInt(files);
	            if(driveService.getDriveFile(dfNo).getFolderNo() != 0) {
	            	int folderNo = driveService.getDriveFile(dfNo).getFolderNo();
	            	zipName = driveService.getUpperFolderNo(folderNo).getFolderName();
	            }else {
	            	if(driveService.getDriveFile(dfNo).getDfType() == 1) {
	            		zipName = "개인 드라이브";
	            	}else {
	            		zipName = "전사 드라이브";
	            	}
	            }
	            paths.add(driveService.getDfNo(dfNo));
	        }
	    }

	    if (selectedFolder != null && !selectedFolder.isEmpty()) {
	        String[] folder = selectedFolder.split(",");
	        
	        if(folder.length == 1 && selectedFile.isEmpty()) {
	        	
		        	int folderNo2 = Integer.parseInt(folder[0]);
	        			zipName = driveService.getUpperFolderNo(folderNo2).getFolderName();
	        			paths.addAll(driveService.getDfNoInFolder(folderNo2));
	        	
	        	
	        }else {
		        	for (String folders : folder) {
		        		log.info(folders);
		        		int folderNo2 = Integer.parseInt(folders);
		        		if(driveService.getUpperFolderNo(folderNo2).getFolderParentNo() != 0) {
		        			int folderNo = driveService.getUpperFolderNo(folderNo2).getFolderParentNo();
		        			zipName = driveService.getUpperFolderNo(folderNo).getFolderName();
		        		}else {
		        			if(driveService.getUpperFolderNo(folderNo2).getFolderType() ==1) {
		        				zipName = "개인 드라이브";
		        			}else {
		        				zipName = "전사 드라이브";
		        			}
		        		}
		        		paths.addAll(driveService.getDfNoInFolder(folderNo2));
		        	}
	        }
	    }
	    // zipName 인코딩 해주기
	    
	    for (DriveFileVO path : paths) {
	        log.info("paths : " + path.getDfPath());
	    }

	    // 폴더, 파일 상관없이 파일 경로를 넘겨주면 된다.
	    response.setStatus(HttpServletResponse.SC_OK);
	    response.setContentType("application/zip");
	    try {
	    	String encodedZipName = URLEncoder.encode(zipName, "UTF-8").replaceAll("\\+", "%20");
	    	response.addHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedZipName + ".zip");
	    } catch (UnsupportedEncodingException e) {
	    	log.error("Encoding error: ", e);
	    	
	    	// 적절한 에러 처리
	    }

	    try (ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream())) {
	        List<File> fileList = new ArrayList<>();

	        for (DriveFileVO path : paths) {
	            fileList.add(new File(resourcePath+path.getDfPath()));
	        }

	        for (File file : fileList) {
	            try (FileInputStream fis = new FileInputStream(file)) {
	                zipOut.putNextEntry(new ZipEntry(file.getName()));
	                StreamUtils.copy(fis, zipOut);
	                zipOut.closeEntry();
	            } catch (IOException e) {
	                log.error("Error processing file: " + file.getName(), e);
	            }
	        }

	    } catch (IOException e) {
	        log.error("Error creating zip file", e);
	    }
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFolder(@RequestBody List<List<Integer>> selected){
		List<Integer>selectedFolder = selected.get(0);
		List<Integer>selectedFile = selected.get(1);
		
		DriveFileVO driveFileVO = new DriveFileVO();
		DriveFolderVO driveFolderVO = new DriveFolderVO();
		
		int cnt = 0;
		
		for(int i=0; i<selectedFile.size(); i++) {
			log.info("file"+selectedFile.get(i));
			int dfNo = selectedFile.get(i);
			driveFileVO.setDfNo(dfNo);
			int success = driveService.deleteFile(driveFileVO);
			cnt += success;
		}
		
		for(int i=0; i<selectedFolder.size(); i++) {
			log.info("folder"+selectedFolder.get(i));
			int folderNo = selectedFolder.get(i);
			driveFolderVO.setFolderNo(folderNo);
			driveService.deleteFileInFolder(driveFolderVO);
			driveService.deleteFolderInFolder(driveFolderVO);
		}
		
		String res = "삭제 성공";
		return new ResponseEntity<String>(res,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/copy", method = RequestMethod.POST)
	public String copy(
	        @RequestParam(name = "selectedFile", required = false) String selectedFile,
	        @RequestParam(name = "folderNo") int folderNo) {
		
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO memberVO = customUser.getMember();
		
		int memNo = memberVO.getMemNo();
		
		int dfType = driveService.getFolderType(folderNo);
		
		String[] sFileNos = selectedFile.split(",");
		List<Integer> fileNos = new ArrayList<Integer>();
		
		for (String sFileNo : sFileNos) {
			fileNos.add(Integer.parseInt(sFileNo.trim()));
		}
		
	    log.info("fileNo들 : " + fileNos);
	    log.info("target Folder : " + folderNo);
	    
	    for(int i=0; i<fileNos.size(); i++) {
	    	DriveFileVO driveFileVO = driveService.getDriveFile(fileNos.get(i));
	    	driveFileVO.setFolderNo(folderNo);
	    	driveFileVO.setDfType(dfType);
	    	driveFileVO.setMemNo(memNo);
	    	
	    	driveService.registerFile(driveFileVO);
	    }
	    
	    
		return "redirect:/drive/list";
	}
	
	@RequestMapping(value = "/move", method = RequestMethod.POST)
	public String move(
			@RequestParam(name = "selectedFolder", required = false) String selectedFolder,		// 출발 폴더들
			@RequestParam(name = "selectedFile", required = false) String selectedFile,			// 출발 파일들
			@RequestParam(name = "folderNo",required = false) int folderNo,
			@RequestParam(name = "folderType",required = false) int folderType ) {				// 도착 폴더
		
		List<Integer>folderNos = new ArrayList<Integer>(); // 출발 폴더들의 폴더번호가 int로 담긴 list 
		List<Integer>fileNos = new ArrayList<Integer>(); // 출발 파일들의 파일번호가 int로 담긴 list
		int Type = 0;
		if(folderNo != 0) {
			Type = driveService.getFolderType(folderNo);
		}else if(folderNo == 0) {
			Type = folderType;
		}
		
		// 정수화 및 배열화 진행
		if(selectedFolder != null && !selectedFolder.isEmpty()) {
			String[] folders = selectedFolder.split(",");
			for(String folder : folders) {
				folderNos.add(Integer.parseInt(folder));
			}
		}
		
		if(selectedFile != null && !selectedFile.isEmpty()) {
			String[] files = selectedFile.split(",");
			for(String file : files) {
				fileNos.add(Integer.parseInt(file));
			}
		}	
		// 정수화 및 배열화 작업 종료
		
		for(int targetfolderNo : folderNos) {
			DriveFolderVO driveFolderVO = new DriveFolderVO();
			driveFolderVO.setFolderNo(targetfolderNo);
			driveFolderVO.setFolderParentNo(folderNo);
			driveFolderVO.setFolderType(Type);
			
			driveService.moveFolder(driveFolderVO);
		}
		
		for(int dfNo : fileNos) {
			DriveFileVO driveFileVO = new DriveFileVO();
			driveFileVO.setDfNo(dfNo);
			driveFileVO.setFolderNo(folderNo);
			driveFileVO.setDfType(Type);
			
			driveService.moveFile(driveFileVO);
		}
		
		return "redirect:/drive/list";
	}
	
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> search(@RequestBody Map<String, String>searchWordFromJSP){
		
		log.info(searchWordFromJSP.get("searchWord"));
		
		String searchWord = searchWordFromJSP.get("searchWord");
		
		List<DriveFileVO> searchedFile = driveService.searchFile(searchWord);
		List<DriveFolderVO> searchedFolder = driveService.searchFolder(searchWord);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("searchedFile", searchedFile);
		resultMap.put("searchedFolder", searchedFolder);
		
		return new ResponseEntity<Map<String,Object>>(resultMap,HttpStatus.OK);
	}
	
	
}
