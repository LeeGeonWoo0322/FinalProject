package kr.or.ddit.admin.organization.web;

import java.io.ByteArrayInputStream;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.admin.organization.service.IAdminOrganizationService;
import kr.or.ddit.common.account.vo.DepartmentVO;
import kr.or.ddit.common.account.vo.MemberVO;
import kr.or.ddit.common.account.vo.PositionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/organization")
public class AdminOrganizationController {
	
	@Inject
	private IAdminOrganizationService adOrganizationService;
	
	@GetMapping("/design")
	public String design() {
		return "admin/organization/design";
	}
	
	@GetMapping("/memberManage")
	public String memberManage(Model model, @RequestParam(required = false, name = "searchWord") String search) throws Exception {
		System.out.println(search);
		List<MemberVO> memberList = adOrganizationService.allMember(search);
		model.addAttribute("memberList", memberList);
		
		return "admin/organization/memberManage";
	}
	
	@GetMapping("/register")
	public String register() {
		return "admin/organization/register";
	}
	
	@ResponseBody
	@PostMapping("/addDept")
	public int addDept(@RequestBody DepartmentVO deptVO) {
		int res =  adOrganizationService.addDept(deptVO);
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/printDept")
	public List<DepartmentVO> printDept() {
		List<DepartmentVO> deptList = adOrganizationService.printDept();
		
		return deptList;
	}
	
	@ResponseBody
	@PostMapping("/printPos")
	public List<PositionVO> printPos() {
		List<PositionVO> posList = adOrganizationService.printPos();
		
		return posList;
	}
	
	@ResponseBody
	@PostMapping("/memCount")
	public int memCount() {
		int res = adOrganizationService.memCount();
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/enabled1Mem")
	public int enabled1Mem() {
		int res = adOrganizationService.enabled1Mem();
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/enabled2Mem")
	public int enabled2Mem() {
		int res = adOrganizationService.enabled2Mem();
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public int deleteMember(@RequestBody Map<String, Object> map, Authentication authentication){
		List<Integer> memList = (List<Integer>) map.get("checkedMemNoList");
		for (Integer memberNo : memList) {
			int res = adOrganizationService.enabledCheck(memberNo);
			if(res < 1) {
				return 0;
			}
		}
			
		for (Integer memberNo1 : memList) {
			adOrganizationService.deleteMem(memberNo1);
		}
		
		return 1;
	}
	
	@ResponseBody
	@PostMapping("changePos")
	public int changePos(@RequestBody Map<String,Object> map) {
		 int res = adOrganizationService.changePos(map);
		return res;
	}
	
	@PostMapping("/excelDown")
	public ResponseEntity<InputStreamResource> excelDown() throws Exception{
		ByteArrayInputStream excelFile = adOrganizationService.excelAllMember();
		
		String fileName = "직원_전체목록";
		String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment;filename=" + outputFileName + ".xlsx");
		
		return ResponseEntity.ok()
				.headers(headers)
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.body(new InputStreamResource(excelFile));
	}
	
	@ResponseBody
	@PostMapping("/deptDetail")
	public DepartmentVO deptDetail(@RequestBody DepartmentVO dept) {
		DepartmentVO res = adOrganizationService.deptDetail(dept);
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/insert")
	public ResponseEntity<String> uploadExcel(@RequestParam(value="file", required = false) MultipartFile file,
			HttpServletRequest req,
			final MultipartHttpServletRequest objMulti){
		
//	Map<String, Object> data = new HashMap<String,Object>();
		
	try {
		// 업로드할 파일 객체를 불러온다.
		HashMap<String, MultipartFile> objFiles = (HashMap<String, MultipartFile>) objMulti.getFileMap();
		
		for (MultipartFile objFile : objFiles.values()) {
			XSSFWorkbook objWorkBook = new XSSFWorkbook(objFile.getInputStream());
			
			XSSFSheet objSheet = objWorkBook.getSheetAt(0);
			
			int intRowCount = objSheet.getPhysicalNumberOfRows();
			
			String[] strHeader = new String[14];
			
			strHeader[0] = "posNo";
			strHeader[1] = "deptNo";
			strHeader[2] = "memId";
			strHeader[3] = "memPw";
			strHeader[4] = "memName";
			strHeader[5] = "memTel";
			strHeader[6] = "memEmail";
			strHeader[7] = "memAddr1";
			strHeader[8] = "hireDate";
			strHeader[9] = "driverLicense";
			strHeader[10] = "memProfileimg";
			strHeader[11] = "tempPwYn";
			strHeader[12] = "mailVolume";
			strHeader[13] = "memNo";
			
			// 엑셀의 행 개수만큼 for문 처리
			for (int i = 1; i < intRowCount; i++) {
				XSSFRow objRow = objSheet.getRow(i);
				
				if(objRow != null) {
					MemberVO member = new MemberVO();
					
					for (int j = 0; j < objRow.getPhysicalNumberOfCells(); j++) {
						XSSFCell objCell = objRow.getCell(j);
						
						// 각 셀에서 읽어들인 값으로 파라미터 지정
						String strValue = "";
						
						switch(objCell.getCellType()) {
						
							case NUMERIC:
								DecimalFormat df = new DecimalFormat("#");
								strValue = df.format(objCell.getNumericCellValue());
								break;
							default:
								strValue = objCell.getStringCellValue();
						}
						
						if (j == 0 ) {
							member.setPosNo(Integer.parseInt(strValue));
						} else if (j == 1) {
							member.setDeptNo(Integer.parseInt(strValue));
						} else if (j == 2) {
							member.setMemId(strValue);
						} else if (j == 3) {
							member.setMemPw(strValue);
						} else if (j == 4) {
							member.setMemName(strValue);
						} else if (j == 5) {
							member.setMemTel(strValue);
						} else if (j == 6) {
							member.setMemEmail(strValue);
						} else if (j == 7) {
							member.setMemAddr1(strValue);
						} else if (j == 8) {
							member.setHireDate(strValue);
						} else if (j == 9) {
							member.setDriverLicense(strValue);
						} else if (j == 10) {
							member.setMemProfileimg(strValue);
						} else if (j == 11) {
							member.setTempPwYn(strValue);
						} else if (j == 12) {
							member.setMailVolume(Long.parseLong(strValue));
						} else if (j == 13) {
							member.setMemNo(Integer.parseInt(strValue));
						}
					}
					adOrganizationService.upload(member);
				}
			}
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
			
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
}
