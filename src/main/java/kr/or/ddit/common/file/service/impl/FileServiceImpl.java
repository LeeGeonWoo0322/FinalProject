package kr.or.ddit.common.file.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.file.mapper.IFileMapper;
import kr.or.ddit.common.file.service.IFileService;
import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;
import kr.or.ddit.common.file.web.UploadFileUtils;

@Service
public class FileServiceImpl implements IFileService {

	@Resource(name = "localPath")
	private String localPath;
	
	@Inject
	private IFileMapper fileMapper;

	@Override
	public int saveAttachFile(FilesVO fileVO) throws  Exception {
	    // 파일 메타데이터 저장
	    fileMapper.saveAttachFile(fileVO);
	    int fileNo =fileVO.getFileNo();
	    // 각 파일에 대한 세부 정보 저장
	    for (MultipartFile file : fileVO.getFileList()) {
	        if (!file.isEmpty()) {
	            // 파일 저장
	            String uploadedFilePath = UploadFileUtils.uploadFile(localPath, file.getOriginalFilename(), file.getBytes());

	            // 파일 세부 정보 VO 생성
	            FilesDetailVO fileDetail = new FilesDetailVO();
	            fileDetail.setFileNo(fileNo); // 방금 저장한 fileNo 설정
	            fileDetail.setFilePath(uploadedFilePath); // 저장된 파일 경로
	            fileDetail.setFileSize(file.getSize());
	            fileDetail.setFileMime(file.getContentType());
	            fileDetail.setFileOriginalname(file.getOriginalFilename());
	            fileDetail.setFileUploadname(uploadedFilePath.substring(uploadedFilePath.lastIndexOf("/") + 1)); // 업로드 파일명 설정
	            fileDetail.setMemNo(fileVO.getMemNo()); // 회원 번호 설정
	            
	            // 파일 세부 정보 저장
	            fileMapper.saveFileDetail(fileDetail);
	        }
	    }

	    return fileNo;
	}

	@Override
	public List<FilesDetailVO> getFileDetailList(int fileNo) {
		return fileMapper.getFileDetailList(fileNo);
	}

	@Override
	public FilesDetailVO getFileDetail(int fileDetailNo) {
		return fileMapper.getFileDetail(fileDetailNo);
	}
	
	
}
