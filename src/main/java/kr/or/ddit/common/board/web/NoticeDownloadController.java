package kr.or.ddit.common.board.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.ddit.common.board.service.BoardService;
import kr.or.ddit.common.file.vo.FilesDetailVO;

@Controller
@RequestMapping("/notice")
public class NoticeDownloadController {

	@Inject
	private BoardService boardService;
	
	// 파일 다운로드 요청
	@GetMapping("/download.do")
	public View noticeDownload(FilesDetailVO filesDetailVO, ModelMap model) {
		FilesDetailVO resultFilesDetailVO = boardService.boardDownload(filesDetailVO);
		
		Map<String, Object> noticeFileMap = new HashMap<String, Object>();
		noticeFileMap.put("fileName", resultFilesDetailVO.getFileOriginalname());
		noticeFileMap.put("fileSize", resultFilesDetailVO.getFileSize());
		noticeFileMap.put("fileSavepath", resultFilesDetailVO.getFilePath());
		model.addAttribute("noticeFileMap", noticeFileMap);
		
		// 리턴되는 noticeDownloadView는 jsp 페이지로 존재하는 페이지 name을 요청하는게 아니라,
		// 클래스를 요청하는것인데 해당 클래스가 스프링에서 제공하는 AbstractView 클래스를 상속받은 클래스입니다.
		// 해당 클래스는 AbstractView를 상속받아 재정의 메소드를 통해서 함수를 재정의할 때 View로 취급될 수 있게 합니다.
		return new NoticeDownloadView();
	}
	
}













