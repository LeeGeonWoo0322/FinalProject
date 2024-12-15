package kr.or.ddit.common.drive.service.impl;

import java.util.Collection;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.drive.mapper.IDriveMapper;
import kr.or.ddit.common.drive.service.IDriveService;
import kr.or.ddit.common.drive.vo.DriveFileVO;
import kr.or.ddit.common.drive.vo.DriveFolderVO;

@Service
public class DriveServiceImpl implements IDriveService {

	@Inject
	private IDriveMapper driveMapper;
	
	@Override
	public List<DriveFileVO> getDriveFileList() {
		return driveMapper.getDriveFileList();
	}

	@Override
	public List<DriveFolderVO> getDriveFolderList() {
		return driveMapper.getDriveFolderList();
	}

	@Override
	public int registerFile(DriveFileVO driveFileVO) {
		return driveMapper.registerFile(driveFileVO);
	}

	@Override
	public DriveFileVO getDriveFile(int dfNo) {
		return driveMapper.getDriveFile(dfNo);
	}

	@Override
	public List<DriveFolderVO> getFoldersInFolder(int folderNo) {
		return driveMapper.getFoldersInFolder(folderNo);
	}

	@Override
	public List<DriveFileVO> getFilesInFolder(int folderNo) {
		return driveMapper.getFilesInFolder(folderNo);
	}

	@Override
	public DriveFolderVO getUpperFolderNo(int folderNo) {
		return driveMapper.getUpperFolderNo(folderNo);
	}

	@Override
	public List<DriveFolderVO> getUnderFolderList() {
		return driveMapper.getUnderFolderList();
	}

	@Override
	public List<DriveFolderVO> getUnderFileList() {
		return driveMapper.getUnderFileList();
	}

	@Override
	public int getFolderType(int folderNo) {
		return driveMapper.getFolderType(folderNo);
	}

	@Override
	public int registerFolder(DriveFolderVO driveFolderVO) {
		return driveMapper.registerFolder(driveFolderVO);
	}

	@Override
	public int deleteFile(DriveFileVO driveFileVO) {
		return driveMapper.deleteFile(driveFileVO);
	}

	@Override
	public Collection<? extends DriveFileVO> getDfNoInFolder(int folderNo) {
		return driveMapper.getDfNoInFolder(folderNo);
	}

	@Override
	public DriveFileVO getDfNo(int dfNo) {
		return driveMapper.getDfNo(dfNo);
	}

	@Override
	public void deleteFolderInFolder(DriveFolderVO driveFolderVO) {
		driveMapper.deleteFolderInFolder(driveFolderVO);
	}

	@Override
	public void deleteFileInFolder(DriveFolderVO driveFolderVO) {
		driveMapper.deleteFileInFolder(driveFolderVO);
	}

	@Override
	public List<DriveFolderVO> getSelectedFolders(int folderNo) {
		return driveMapper.getSelectedFolders(folderNo);
	}

	@Override
	public DriveFileVO getOriginalDriveFile(int dfNo) {
		return driveMapper.getOriginalDriveFile(dfNo);
	}

	@Override
	public List<DriveFileVO> searchFile(String searchWord) {
		return driveMapper.searchFile(searchWord);
	}

	@Override
	public List<DriveFolderVO> searchFolder(String searchWord) {
		return driveMapper.searchFolder(searchWord);
	}

	@Override
	public void moveFolder(DriveFolderVO driveFolderVO) {
		driveMapper.moveFolder(driveFolderVO);
		
	}

	@Override
	public void moveFile(DriveFileVO driveFileVO) {
		driveMapper.moveFile(driveFileVO);
		
	}

	@Override
	public List<DriveFileVO> gettotalByte() {
		return driveMapper.gettotalByte();
	}

	@Override
	public List<DriveFolderVO> getFolderPaths(int folderNo) {
		return driveMapper.getFolderPaths(folderNo);
	}


}
