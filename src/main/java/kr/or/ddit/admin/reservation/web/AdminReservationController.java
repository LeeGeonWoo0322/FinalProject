package kr.or.ddit.admin.reservation.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.admin.reservation.service.IAdminReservationService;
import kr.or.ddit.common.account.service.IAccountService;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;
import kr.or.ddit.common.reservation.vo.AssetCategoryVO;
import kr.or.ddit.common.reservation.vo.AssetVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin/reservation")
public class AdminReservationController {
	
	@Resource(name="localPath")
	private String localPath;
	
	@Inject
	private IAdminReservationService adminReservationService;
	
	@Inject
	private IAccountService accountService;
	
	@GetMapping("/assetManage")
	public String reservationList(Model model) {
		
		List<PositionVO> positionList = adminReservationService.getPositionList();
		List<AssetCategoryVO> assetCategoryList = adminReservationService.getAssetCategory();
		List<AssetVO> assetList = null;
		if (assetCategoryList.size() > 0) {
			assetList = adminReservationService.getAssetByAcNo(assetCategoryList.get(0));
			model.addAttribute("assetList", assetList);
		}
		
		model.addAttribute("assetCategoryList", assetCategoryList);
		model.addAttribute("assetCategoryListSize", assetCategoryList.size());
		model.addAttribute("positionList", positionList);
		
		return "admin/reservation/assetManage";
	}
	
	@PostMapping("/addAssetCategory.do")
	public ResponseEntity<AssetCategoryVO> addAssetCategory(@RequestBody AssetCategoryVO assetCategoryVO, Authentication authentication){
		User user = (User) authentication.getPrincipal();
		MemberVO member = accountService.getMember(user.getUsername());
		assetCategoryVO.setMemNo(member.getMemNo());
		
		int status = adminReservationService.insertAssetCategory(assetCategoryVO);
		AssetCategoryVO assetCategoryDetail = adminReservationService.getLastAssetCategoryDetail();
		
		return new ResponseEntity<AssetCategoryVO>(assetCategoryDetail, HttpStatus.OK);
	}
	
	@PostMapping("/addAsset.do")
	public ResponseEntity<AssetVO> addAsset(@RequestBody AssetVO assetVO){
		
		int status = adminReservationService.addAsset(assetVO);
		AssetVO assetDetail = adminReservationService.getLastAssetDetail();
		int status2 = adminReservationService.updateAssetCategoryByAsset(assetVO);
		
		return new ResponseEntity<AssetVO>(assetDetail, HttpStatus.OK);
	}
	
	@PostMapping("/getAssetCategoryDetail.do")
	public ResponseEntity<AssetCategoryVO> getAssetCategoryDetail(@RequestBody AssetCategoryVO assetCategoryVO){
		
		AssetCategoryVO assetCategoryDetail = adminReservationService.getAssetCategoryDetail(assetCategoryVO);
		
		return new ResponseEntity<AssetCategoryVO>(assetCategoryDetail, HttpStatus.OK);
	}
	
	@PostMapping("/updateAssetCategory.do")
	public ResponseEntity<String> updateAssetCategory(@RequestBody AssetCategoryVO assetCategoryVO){
		
		int status = adminReservationService.updateAssetCategory(assetCategoryVO);
		
		if (status > 0) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
	}
	
	// CKEDITOR를 이용하여 본문 내용에 선택 이미지 업로드하기
	@RequestMapping(value="/imageUpload.do")
	public String imageUpload(
			HttpServletRequest req, HttpServletResponse resp,
			MultipartHttpServletRequest multiFile
			) throws Exception {
		// CKEDITOR4 특정 버전 이후부터 html 형식의 데이터를 리턴하는 방법에서 JSON 데이터를 구성해서 리턴하는 방식으로 변경됨
		JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
		PrintWriter printWriter = null;			// 외부 응답으로 내보낼 때 사용할 객체
		OutputStream out = null;				// 본문내용에 추가한 이미지를 파일로 생성할 객체
		long limitSize = 1024 * 1024 * 2;		// 업로드 파일 최대 크기 (2MB)
		
		MultipartFile file = multiFile.getFile("upload");	// upload라는 키로 MultipartFile 타입의 파일 데이터를 꺼낸다.
		
		// 파일 객체가 null이 아니고 파일 사이즈가 0보다 크고 파일명이 공백이 아닌경우는 무조건 파일 데이터가 존재하는 경우
		if(file != null && file.getSize() > 0 && StringUtils.isNotBlank(file.getOriginalFilename())) {
			// 데이터 Mime 타입이 'image/'를 포함한 이미지 파일안지 체크
			if(file.getContentType().toLowerCase().startsWith("image/")) {
				// 업로드 한 파일 사이즈가 최대 크기(2MB) 보다 클 때
				if(file.getSize() > limitSize) {	// 크기 초과 에러
					/*
					 * {
					 * 		"uploaded" : 0,
					 * 		"error" : [
					 * 			{
					 * 				"message" : "2MB미만의 이미지만 업로드 가능합니다."
					 *			} 		
					 * 		]
					 * }
					 * 에러가 발생했을 때 출력 형태를 위와 같은 형식으로 만든다.
					 */
					JsonObject jsonMsg = new JsonObject();
					JsonArray jsonArr = new JsonArray();
					jsonMsg.addProperty("message", "2MB미만의 이미지만 업로드 가능합니다.");
					jsonArr.add(jsonMsg);
					json.addProperty("uploaded", 0);
					json.add("error", jsonArr.get(0));
					
					resp.setCharacterEncoding("UTF-8");
					printWriter = resp.getWriter();
					printWriter.println(json);
				}else {								// 정상 범위 안에있는 파일
					/*
					 * {
					 * 		"uploaded" : 1,
					 * 		"fileName" : "xxxxxxxxxxx-xxxxxxxxxx.jpg",
					 * 		"url" : "/resources/img/xxxxxxxx-xxxxxxxxxx.jpg"
					 * }
					 */
					try {
						String fileName = file.getOriginalFilename();	// 파일명 얻어오기
						byte[] bytes = file.getBytes();		// 파일 데이터 얻어오기
						// 업로드 경로 설정(배포 서버 안에 들어 있는)
						String locate = localPath + "/reservation";
						
						File uploadFile = new File(locate);
						// 업로드 경로로 설정된 폴더구조가 존재하지 않는 경우, 파일을 복사할 수 없으므로 폴더 구조가 존재하지 않는 경우
						// 해당 위치에 폴더를 생성하고 존재하는 경우 건너뛰도록 한다.
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						
						// UUID_원본파일명
						fileName = UUID.randomUUID().toString() + "_" + fileName;
						String uploadPath = locate + "/" + fileName;	// 업로드 경로 + 파일명
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);	// 파일 복사
						
						printWriter = resp.getWriter();
						String fileUrl = req.getContextPath() + "/upload/reservation/" + fileName; 
						
						System.out.println("fileUrl::"+ fileUrl);
						
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						
						printWriter.println(json);
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(out != null) {
							out.close();
						}
						if(printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}
	
	@PostMapping("/getAssetByAcNo.do")
	public ResponseEntity<List<AssetVO>> getAssetByAcNo(@RequestBody AssetCategoryVO assetCategoryVO){
		
		List<AssetVO> assetList = adminReservationService.getAssetByAcNo(assetCategoryVO);
		
		return new ResponseEntity<List<AssetVO>>(assetList, HttpStatus.OK);
	}
	
	@PostMapping("/getAsset.do")
	public ResponseEntity<List<AssetVO>> getAsset(@RequestBody AssetVO assetVO){
		
		List<AssetVO> assetList = adminReservationService.getAsset(assetVO);
		
		return new ResponseEntity<List<AssetVO>>(assetList, HttpStatus.OK);
	}
	
}
