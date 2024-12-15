package kr.or.ddit.common.drive.mapper;

import java.util.Collection;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.drive.vo.DriveFileVO;
import kr.or.ddit.common.drive.vo.DriveFolderVO;

public interface IDriveMapper {

	public List<DriveFileVO> getDriveFileList();

	public List<DriveFolderVO> getDriveFolderList();

	public int registerFile(DriveFileVO driveFileVO);

	public DriveFileVO getDriveFile(int dfNo);

	public List<DriveFolderVO> getFoldersInFolder(int folderNo);

	public List<DriveFileVO> getFilesInFolder(int folderNo);

	public DriveFolderVO getUpperFolderNo(int folderNo);

	public List<DriveFolderVO> getUnderFolderList();

	public List<DriveFolderVO> getUnderFileList();

	public int getFolderType(int folderNo);

	public int registerFolder(DriveFolderVO driveFolderVO);

	public int deleteFile(DriveFileVO driveFileVO);

	public Collection<? extends DriveFileVO> getDfNoInFolder(int folderNo);

	public DriveFileVO getDfNo(int dfNo);

	public void deleteFolderInFolder(DriveFolderVO driveFolderVO);

	public void deleteFileInFolder(DriveFolderVO driveFolderVO);

	public List<DriveFolderVO> getSelectedFolders(int folderNo);

	public DriveFileVO getOriginalDriveFile(int dfNo);

	public List<DriveFileVO> searchFile(String searchWord);

	public List<DriveFolderVO> searchFolder(String searchWord);

	public void moveFolder(DriveFolderVO driveFolderVO);

	public void moveFile(DriveFileVO driveFileVO);

	public List<DriveFileVO> gettotalByte();

	public List<DriveFolderVO> getFolderPaths(int folderNo);




}
