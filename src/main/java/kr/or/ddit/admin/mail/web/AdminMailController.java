package kr.or.ddit.admin.mail.web;

import java.io.ByteArrayInputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.mail.service.IAdminMailService;
import kr.or.ddit.admin.mail.vo.DataListVO;
import kr.or.ddit.common.account.vo.DepartmentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/mail")
public class AdminMailController {

	@Inject
	private IAdminMailService adminMailService;
	
	@GetMapping("/statistics")
	public String mailStatistics(Model model) {
		
		Map<String, Object> dataList = new HashMap<String, Object>();
		List<Integer> totalMailUsageList = new ArrayList<Integer>();
		List<String> dataPeriod = new ArrayList<>();
		DataListVO dataListVO = new DataListVO("lastDayIso", "total");
		int totalMailUsageCnt = 0;
		int totalSpamMailCnt = 0;
		
		Calendar cal = Calendar.getInstance();
		String currentTime = String.format("%04d-%02d-%02dT%02d:%02d:%02d", 
				cal.get(Calendar.YEAR), 
				cal.get(Calendar.MONTH) + 1, 
				cal.get(Calendar.DAY_OF_MONTH), 
				cal.get(Calendar.HOUR_OF_DAY), 
				cal.get(Calendar.MINUTE), 
				cal.get(Calendar.SECOND));
		
		cal.add(Calendar.DAY_OF_MONTH, -1);
		cal.add(Calendar.HOUR_OF_DAY, +1);
        
        // 현재 시간을 기준으로 최근 24시간의 시간을 추가
        for (int i = 0; i < 24; i++) {
            String time = String.format("%04d-%02d-%02dT%02d:00:00", 
	            cal.get(Calendar.YEAR), 
	            cal.get(Calendar.MONTH) + 1, 
	            cal.get(Calendar.DAY_OF_MONTH), 
	            cal.get(Calendar.HOUR_OF_DAY));
        	dataPeriod.add(time);
        	cal.add(Calendar.HOUR_OF_DAY, 1);
        }
        
        dataPeriod.add(currentTime);
        
		for (int i = 0; i < dataPeriod.size()-1; i++) {
			dataListVO.setPeriodData1(dataPeriod.get(i).replace("T", " ").substring(0, 19));
			dataListVO.setPeriodData2(dataPeriod.get(i + 1).replace("T", " ").substring(0, 19));
			totalMailUsageList.add(adminMailService.getTotalMailUsageCnt(dataListVO));
			totalMailUsageCnt += adminMailService.getTotalMailUsageCnt(dataListVO);
			totalSpamMailCnt += adminMailService.getTotalSpamMailCnt(dataListVO);
		}
		
		List<DepartmentVO> deptList = adminMailService.getDeptList();
		
		
		dataList.put("totalMailUsageList", totalMailUsageList);
		dataList.put("totalMailUsageCnt", totalMailUsageCnt);
		dataList.put("totalSpamMailCnt", totalSpamMailCnt);
		dataList.put("period", dataListVO.getPeriod());
		dataList.put("dataType", dataListVO.getDataType());
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("dataList", dataList);
		
		return "admin/mail/statistics";
	}
	
	@PostMapping("/getData.do")
	public ResponseEntity<Map<String, Object>> getData(@RequestBody DataListVO dataListVO){
		
		String dataType = dataListVO.getDataType();
		List<String> dataPeriod = dataListVO.getPeriodData();
		
		Map<String, Object> dataList = new HashMap<String, Object>();
		List<Integer> totalMailUsageList = new ArrayList<Integer>();
		List<Integer> deptMailUsageList = new ArrayList<Integer>();
		List<Integer> totalSpamMailList = new ArrayList<Integer>();
		List<Integer> deptSpamMailList = new ArrayList<Integer>();
		int totalMailUsageCnt = 0;
		int deptMailUsageCnt = 0;
		int totalSpamMailCnt = 0;
		int deptSpamMailCnt = 0;
		
		if (!dataType.equals("total")) {
			for (int i = 0; i < dataPeriod.size(); i++) {
				if (i<dataPeriod.size()-1) {
					dataListVO.setPeriodData1(dataPeriod.get(i).replace("T", " ").substring(0, 19));
					dataListVO.setPeriodData2(dataPeriod.get(i + 1).replace("T", " ").substring(0, 19));
					deptMailUsageList.add(adminMailService.getDeptMailUsageCnt(dataListVO));
					deptSpamMailList.add(adminMailService.getDeptSpamMailCnt(dataListVO));
					deptMailUsageCnt += adminMailService.getDeptMailUsageCnt(dataListVO);
					deptSpamMailCnt += adminMailService.getDeptSpamMailCnt(dataListVO);
				}
			}
			
			dataList.put("deptMailUsageList", deptMailUsageList);
			dataList.put("deptSpamMailList", deptSpamMailList);
			dataList.put("deptMailUsageCnt", deptMailUsageCnt);
			dataList.put("deptSpamMailCnt", deptSpamMailCnt);
		}
		
		for (int i = 0; i < dataPeriod.size(); i++) {
			if (i < dataPeriod.size()-1) {
				dataListVO.setPeriodData1(dataPeriod.get(i).replace("T", " ").substring(0, 19));
				dataListVO.setPeriodData2(dataPeriod.get(i + 1).replace("T", " ").substring(0, 19));
				totalMailUsageList.add(adminMailService.getTotalMailUsageCnt(dataListVO));
				totalSpamMailList.add(adminMailService.getTotalSpamMailCnt(dataListVO));
				totalMailUsageCnt += adminMailService.getTotalMailUsageCnt(dataListVO);
				totalSpamMailCnt += adminMailService.getTotalSpamMailCnt(dataListVO);
			}
		}
		
		dataList.put("totalMailUsageList", totalMailUsageList);
		dataList.put("totalSpamMailList", totalSpamMailList);
		dataList.put("totalMailUsageCnt", totalMailUsageCnt);
		dataList.put("totalSpamMailCnt", totalSpamMailCnt);
		dataList.put("period", dataListVO.getPeriod());
		
		return new ResponseEntity<Map<String,Object>>(dataList,HttpStatus.OK);
	}
	
	
}
