package kr.or.ddit.common.file.mapper;

import java.util.List;

import kr.or.ddit.common.file.vo.FilesDetailVO;
import kr.or.ddit.common.file.vo.FilesVO;

public interface IFileMapper {

	public int saveAttachFile(FilesVO fileVO);

	public void saveFileDetail(FilesDetailVO fileDetail);

	public List<FilesDetailVO> getFileDetailList(int fileNo);

	public FilesDetailVO getFileDetail(int fileDetailNo);

}
