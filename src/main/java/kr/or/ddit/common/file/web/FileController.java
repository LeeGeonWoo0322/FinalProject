package kr.or.ddit.common.file.web;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import kr.or.ddit.common.file.service.IFileService;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasRole('ROLE_MEMBER')")
public class FileController {

	
	@Inject
	private IFileService fileService;
	
	@Resource(name = "localPath")
	private String localPath;
	
	@PostMapping(value = "/uploadAjax", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> uploadAjax(@ModelAttribute FilesVO fileVO) throws Exception {
	    String fileCategory = fileVO.getFileCategory();
	    int memNo = fileVO.getMemNo();
	    System.out.println("카테고리: " + fileCategory + ", 회원번호: " + memNo);

	    int fileNo = fileService.saveAttachFile(fileVO);
	    System.out.println("파일넘버"+fileNo);

	    return ResponseEntity.ok(String.valueOf(fileNo));
	}
	
	// 파일 다운로드 요청 처리
	@GetMapping("/downloadFile.do")
	public View fileDownload(int fileDetailNo, ModelMap model) {
	    FilesDetailVO fileDetailVO = fileService.getFileDetail(fileDetailNo); // FileDetailVO를 가져오는 메소드

	    Map<String, Object> fileDetailMap = new HashMap<>();
	    fileDetailMap.put("fileName", fileDetailVO.getFileOriginalname());
	    fileDetailMap.put("fileSize", fileDetailVO.getFileSize());
	    fileDetailMap.put("fileSavePath", localPath+fileDetailVO.getFilePath()); // 파일 경로
	    model.addAttribute("fileDetailMap", fileDetailMap);
	    
	    return new FileDownloadView(); // 수정된 View 클래스 사용
	}
	
	// 파일 세부정보를 가져오는 메소드
    @PostMapping("/getFileDetails/{fileNo}")
    @ResponseBody
    public ResponseEntity<List<FilesDetailVO>> getFileDetails(@PathVariable("fileNo") int fileNo) {
        List<FilesDetailVO> fileDetailList = fileService.getFileDetailList(fileNo); // 서비스 메소드 호출

        if (fileDetailList != null) {
        	System.out.println("파일리스트:"+fileDetailList);
            return ResponseEntity.ok(fileDetailList); // 파일 세부정보 반환
        } else {
            return ResponseEntity.notFound().build(); // 파일 세부정보가 없을 경우 404 반환
        }
    }


	
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> display(String fileName){
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		log.info("fileName: "+fileName);
		
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);	// 확장자 추출
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			
			in = new FileInputStream(localPath+fileName);	// 파일을 얻어옴
			if(mType!=null) {
				headers.setContentType(mType);
			}else {
				// 원본파일명 추출
				fileName=fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+
							new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}
			entity=new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return entity;
	}
	
}
