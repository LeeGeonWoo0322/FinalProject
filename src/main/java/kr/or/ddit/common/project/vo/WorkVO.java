package kr.or.ddit.common.project.vo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import lombok.Data;

@Data
public class WorkVO {
	
	private int workNo;
	private int projectNo;   
	private int writerNo;
	private int memNo;
	private String regDate;
	private String endDate;
	private int fileNo;
	private String workPrograss;
	private int field;
	private int waitWork;
	private String workIntro;
	private String workTitle;
	private int totalcheck;
	private String favorY;
	private String favorMem;
	private List<Integer> workList;
	private List<Integer> fileNoList;
	
	private List<String> prograssList;
	
	private int workWite;
	private int workIng;
	private int workEnd;
	
	private List<CheckListVO> checkList;
	private List<PicNMVO> picList;
	private List<WorkComentVO> cmtList;
	private List<WorkFavoriteVO> favoritesList;
	
	
	@JsonIgnore
	private MultipartFile[] attachedFiles;
	private List<FilesVO> fileList;
	private List<FilesDetailVO> fileDetailList = new ArrayList<FilesDetailVO>();
	
	public void setAttachedFiles(MultipartFile[] attachedFiles) {
	    // null 체크 및 빈 배열 처리
	    if (attachedFiles == null || attachedFiles.length == 0) {
	        this.attachedFiles = new MultipartFile[0]; // 빈 배열로 초기화
  	      fileDetailList.clear(); // 파일 세부 리스트 초기화
	        return;
	    }

	    // null이 아닌 파일과 이름이 비어있지 않은 파일 필터링
	    this.attachedFiles = Arrays.stream(attachedFiles)
	            .filter(file -> file != null && !StringUtils.isBlank(file.getOriginalFilename()))
	            .toArray(MultipartFile[]::new);

	    // fileDetailList 초기화
	    fileDetailList.clear(); // 이전 파일 세부 정보 초기화

	    // 유효한 파일이 있는 경우에만 세부 정보 추가
	    if (this.attachedFiles.length > 0) {
	        for (MultipartFile file : this.attachedFiles) {
	            if (!file.isEmpty()) {
	                fileDetailList.add(new FilesDetailVO(file));
	            }
	        }
	    }
	}
}
