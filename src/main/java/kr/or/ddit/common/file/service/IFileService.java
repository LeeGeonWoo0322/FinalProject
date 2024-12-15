package kr.or.ddit.common.file.service;

import java.util.List;

import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;

public interface IFileService {

	public int saveAttachFile(FilesVO fileVO) throws Exception;

	public List<FilesDetailVO> getFileDetailList(int fileNo);

	public FilesDetailVO getFileDetail(int fileDetailNo);

}
