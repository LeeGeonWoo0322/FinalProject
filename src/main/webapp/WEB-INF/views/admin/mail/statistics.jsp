<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="d-flex flex-column bg-100 w-100 p-3" style="height: 100%">
	<div>
		<span>메뉴 관리 / 메일</span>
		<h4>메일 통계</h4>
	</div>
	<div class="card w-100 p-3" style="flex: 1 0 auto;">
		<div class="d-flex flex-column">
			<div class="d-flex flex-row justify-content-between">
				<h5>전체 메일</h5>
			</div>
			<div>
				<table>
					<colgroup>
						<col style="width: 100px">
						<col style="width: 250px">
					</colgroup>
					<tbody>
						<tr>
							<th>메뉴 선택</th>
							<td>
								<select id="dataType" style="width: 110px"> 
									<optgroup label="전체">
										<option value="total">전체</option>
									</optgroup>
									<optgroup label="전체 & 부서 비교">
										<c:forEach items="${deptList }" var="department">
											<option value="${department.deptNo }">${department.deptName }</option>
										</c:forEach>
									</optgroup>
								</select>
							</td>
						</tr>
						<tr>
							<th>기간</th>
							<td class="d-flex flex-row">
								<select id="dataPeriod" style="width: 110px">
									<option value="lastDayIso">최근 24시간</option>
									<option value="lastWeekIso">최근 일주일</option>
									<option value="lastMonthIso">최근 한달</option>
									<option value="lastYearIso">최근 1년</option>
								</select>
								<button class="btn btn-info ms-1 px-3 py-0" id="searchBtn">검색</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="d-flex flex-row w-100 pt-4" style="height: 325px">
				<div>
					<div class="echart-line-chart-example" style="height: 100%;width: 1000px" data-echart-responsive="true"></div>
				</div>
				<div class="d-flex justify-content-center">
					<div class="echart-nested-pies-chart" style="height: 100%;width: 500px" data-echart-responsive="true"></div>
				</div>
			</div>
		</div>
		<div class="d-flex flex-row mb-2 mt-4">
			<div>
				<select id="dataDownloadType">
					<option value="CSV">CSV</option>
					<option value="EXCEL">EXCEL</option>
				</select>
			</div>
			<button class="btn btn-info py-0 px-2 ms-1" id="dataDownloadBtn">저장</button>
		</div>
		<div id="tableExample2" data-list='{"page":5,"pagination":true}'>
			<div class="table-responsive scrollbar" style="height: 200px">
				<table class="table table-bordered border-500 fs-9 mb-0">
					<colgroup>
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
					</colgroup>
					<thead class="bg-200" id="dataTableThead">
						<tr>
							<th colspan="2" class="py-1 text-center">날짜</th>
							<th colspan="4" class="text-center py-1">정상메일</th>
							<th colspan="4" class="text-center py-1">스팸메일</th>
							<th colspan="2" class="py-1 text-center">합계</th>
						</tr>
					</thead>
					<tbody class="list" id="dataTableTbody">
						<tr>
							<td colspan="2"></td>
							<td colspan="4"></td>
							<td colspan="4"></td>
							<td colspan="2"></td>
						</tr>
					</tbody>	
				</table>
			</div>
		    <div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
		    	<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
		    </div>
		</div>
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<script type="text/javascript">
const recentTimeFrames = getRecentTimeFrames();

$(function () {
	
	let dataList = {
		dataType : '${dataList.dataType}',
		period : '${dataList.period}',
		totalMailUsageList : ${dataList.totalMailUsageList},
		totalMailUsageCnt : ${dataList.totalMailUsageCnt},
		totalSpamMailCnt : ${dataList.totalSpamMailCnt},
	}
	let initNormalMailCnt = dataList.totalMailUsageCnt - dataList.totalSpamMailCnt;
	let initNormalMailPersent = dataList.totalMailUsageCnt == 0 ? 0 : Math.round((initNormalMailCnt/dataList.totalMailUsageCnt)*100);
	let initSpamMailPersent = dataList.totalMailUsageCnt == 0 ? 0 : Math.round((dataList.totalSpamMailCnt/dataList.totalMailUsageCnt)*100);
	
	let initTableHTML = `
							<tr>
								<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastDayIso[0].substring(0,10)} ~ \${recentTimeFrames.lastDayIso[23].substring(0,10)}</td>
								<td colspan="2" class="totalNormalMailCnt py-1 text-center">\${initNormalMailCnt}</td>
								<td colspan="2" class="py-1 text-center">\${initNormalMailPersent}%</td>
								<td colspan="2" class="totalSpamMailCnt py-1 text-center">\${dataList.totalSpamMailCnt}</td>
								<td colspan="2" class="py-1 text-center">\${initSpamMailPersent}%</td>
								<td colspan="2" class="totalMailUsageCnt py-1 text-center">\${dataList.totalMailUsageCnt}</td>
							</tr>			
						`;
	$("#dataTableTbody").html(initTableHTML);
	
	docReady(echartsBasicBarChartInit('total', dataList));
	docReady(echartsNestedPiesChartInit('total', dataList));
	
	let globalTotalMailUsageList = [];
	let globalTotalSpamMailList = [];
	let globalDeptMailUsageList = [];
	let globalDeptSpamMailList = [];
	
	$("#dataDownloadBtn").on("click", function () {
		let dataType = $("#dataType").val();
		let dataPeriod = $("#dataPeriod").val();
		let dataDownloadType = $("#dataDownloadType").val();
		if (dataDownloadType == 'CSV') {
			downloadCSV(dataType, dataPeriod);
		}else if (dataDownloadType == 'EXCEL') {
			downloadExcel(dataType, dataPeriod);
		}
	});
	
	$("#searchBtn").on("click", function () {
		let dataType = $("#dataType").val();
		let dataTypeKo = "";
		if (dataType == 1) {
			dataTypeKo = '재무부';	
		}else if (dataType == 2) {
			dataTypeKo = '인사부';
		}else if (dataType == 3) {
			dataTypeKo = '마케팅부';
		}else if (dataType == 4) {
			dataTypeKo = '영업부';
		}else if (dataType == 5) {
			dataTypeKo = 'IT부';
		}else if (dataType == 6) {
			dataTypeKo = '법무부';
		}else if (dataType == 7) {
			dataTypeKo = '운영부';
		}else if (dataType == 8) {
			dataTypeKo = '서비스부';
		}else if (dataType == 9) {
			dataTypeKo = 'R&D부';
		}
		let period = $("#dataPeriod").val();
		let periodData = recentTimeFrames[period];
		axios({
			url : "/admin/mail/getData.do",
			method : "post",
			data : JSON.stringify({
				dataType : dataType,
				period : period,
				periodData : periodData
			}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			let dataTableHTML = "";
			if (dataType == 'total') {
				$("#dataTableThead").html(`
											<tr>
												<th colspan="2" class="py-1 text-center">날짜</th>
												<th colspan="4" class="text-center py-1">정상메일</th>
												<th colspan="4" class="text-center py-1">스팸메일</th>
												<th colspan="2" class="py-1 text-center">합계</th>
											</tr>
										  `)
				
				if (period == 'lastDayIso') {
					let totalMailUsageCnt = res.totalMailUsageCnt;
					let totalSpamMailCnt = res.totalSpamMailCnt;
					let totalNormalMailCnt = totalMailUsageCnt - totalSpamMailCnt;
					let totalNormalMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalNormalMailCnt/totalMailUsageCnt)*100);
					let totalSpamMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalSpamMailCnt/totalMailUsageCnt)*100);
					dataTableHTML += `
									<tr>
										<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastDayIso[0].substring(0,10)} ~ \${recentTimeFrames.lastDayIso[23].substring(0,10)}</td>
										<td colspan="2" class="totalNormalMailCnt py-1 text-center">\${totalNormalMailCnt}</td>
										<td colspan="2" class="py-1 text-center">\${totalNormalMailPersent}%</td>
										<td colspan="2" class="totalSpamMailCnt py-1 text-center">\${totalSpamMailCnt}</td>
										<td colspan="2" class="py-1 text-center">\${totalSpamMailPersent}%</td>
										<td colspan="2" class="totalMailUsageCnt py-1 text-center">\${totalMailUsageCnt}</td>
									</tr>			
									`;
				}else if (period == 'lastWeekIso' || period == 'lastMonthIso') {
					globalTotalMailUsageList = res.totalMailUsageList;
					globalTotalSpamMailList = res.totalSpamMailList;
					for (var i = 0; i < res.totalMailUsageList.length; i++) {
						let totalMailUsageCnt = res.totalMailUsageList[i];
						let totalSpamMailCnt = res.totalSpamMailList[i];
						let totalNormalMailCnt = totalMailUsageCnt - totalSpamMailCnt;
						let totalNormalMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalNormalMailCnt/totalMailUsageCnt)*100);
						let totalSpamMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalSpamMailCnt/totalMailUsageCnt)*100);
						if (period == 'lastWeekIso') {
							dataTableHTML += `
											<tr>
											<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastWeekIso[i].substring(0,10)} ~ \${recentTimeFrames.lastWeekIso[i+1].substring(0,10)}</td>
											`;
						}else {
							dataTableHTML += `
								<tr>
								<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastMonthIso[i].substring(0,10)} ~ \${recentTimeFrames.lastMonthIso[i+1].substring(0,10)}</td>
								`;						
						}
						dataTableHTML += `
												<td colspan="2" class="totalNormalMailCnt py-1 text-center">\${totalNormalMailCnt}</td>
												<td colspan="2" class="py-1 text-center">\${totalNormalMailPersent}%</td>
												<td colspan="2" class="totalSpamMailCnt py-1 text-center">\${totalSpamMailCnt}</td>
												<td colspan="2" class="py-1 text-center">\${totalSpamMailPersent}%</td>
												<td colspan="2" class="totalMailUsageCnt py-1 text-center">\${totalMailUsageCnt}</td>
											</tr>						
										`;
					}
				}else {
					globalTotalMailUsageList = res.totalMailUsageList;
					globalTotalSpamMailList = res.totalSpamMailList;
					for (var i = 0; i < res.totalMailUsageList.length; i++) {
						let totalMailUsageCnt = res.totalMailUsageList[i];
						let totalSpamMailCnt = res.totalSpamMailList[i];
						let totalNormalMailCnt = totalMailUsageCnt - totalSpamMailCnt;
						let totalNormalMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalNormalMailCnt/totalMailUsageCnt)*100);
						let totalSpamMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalSpamMailCnt/totalMailUsageCnt)*100);
							dataTableHTML += `
											<tr>
												<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastYearIso[i].substring(0,7)}</td>
												<td colspan="2" class="totalNormalMailCnt py-1 text-center">\${totalNormalMailCnt}</td>
												<td colspan="2" class="py-1 text-center">\${totalNormalMailPersent}%</td>
												<td colspan="2" class="totalSpamMailCnt py-1 text-center">\${totalSpamMailCnt}</td>
												<td colspan="2" class="py-1 text-center">\${totalSpamMailPersent}%</td>
												<td colspan="2" class="totalMailUsageCnt py-1 text-center">\${totalMailUsageCnt}</td>
											</tr>						
										`;
					}
				}
			}else {
				$("#dataTableThead").html(`
											<tr>
												<th colspan="2" class="py-1 text-center">날짜</th>
												<th colspan="2" class="text-center py-1">정상메일(\${dataTypeKo})</th>
												<th colspan="2" class="text-center py-1">스팸메일(\${dataTypeKo})</th>
												<th colspan="1" class="py-1 text-center">합계(\${dataTypeKo})</th>
												<th colspan="2" class="text-center py-1">정상메일(전체)</th>
												<th colspan="2" class="text-center py-1">스팸메일(전체)</th>
												<th colspan="1" class="py-1 text-center">합계(전체)</th>
											</tr>
										  `)
				if (period == 'lastDayIso') {
					let totalMailUsageCnt = res.totalMailUsageCnt;
					let totalSpamMailCnt = res.totalSpamMailCnt;
					let deptMailUsageCnt = res.deptMailUsageCnt;
					let deptSpamMailCnt = res.deptSpamMailCnt;
					let totalNormalMailCnt = totalMailUsageCnt - totalSpamMailCnt;
					let deptNormalMailCnt = deptMailUsageCnt - deptSpamMailCnt;
					let totalNormalMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalNormalMailCnt/totalMailUsageCnt)*100);
					let totalSpamMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalSpamMailCnt/totalMailUsageCnt)*100);
					let deptNormalMailPersent = deptMailUsageCnt == 0 ? 0 : Math.round((deptNormalMailCnt/deptMailUsageCnt)*100);
					let deptSpamMailPersent = deptMailUsageCnt == 0 ? 0 : Math.round((deptSpamMailCnt/deptMailUsageCnt)*100);
					dataTableHTML += `
									<tr>
										<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastDayIso[0].substring(0,10)} ~ \${recentTimeFrames.lastDayIso[23].substring(0,10)}</td>
										<td class="totalNormalMailCnt py-1 text-center">\${deptNormalMailCnt}</td>
										<td class="py-1 text-center">\${deptNormalMailPersent}%</td>
										<td class="totalSpamMailCnt py-1 text-center">\${deptSpamMailCnt}</td>
										<td class="py-1 text-center">\${deptSpamMailPersent}%</td>
										<td class="totalMailUsageCnt py-1 text-center">\${deptMailUsageCnt}</td>
										<td class="totalNormalMailCnt py-1 text-center">\${totalNormalMailCnt}</td>
										<td class="py-1 text-center">\${totalNormalMailPersent}%</td>
										<td class="totalSpamMailCnt py-1 text-center">\${totalSpamMailCnt}</td>
										<td class="py-1 text-center">\${totalSpamMailPersent}%</td>
										<td class="totalMailUsageCnt py-1 text-center">\${totalMailUsageCnt}</td>
									</tr>			
									`;
				}else if (period == 'lastWeekIso' || period == 'lastMonthIso') {
					globalTotalMailUsageList = res.totalMailUsageList;
					globalTotalSpamMailList = res.totalSpamMailList;
					globalDeptMailUsageList = res.deptMailUsageList;
					globalDeptSpamMailList = res.deptSpamMailList;
					for (var i = 0; i < res.totalMailUsageList.length; i++) {
						let totalMailUsageCnt = res.totalMailUsageList[i];
						let totalSpamMailCnt = res.totalSpamMailList[i];
						let deptMailUsageCnt = res.deptMailUsageList[i];
						let deptSpamMailCnt = res.deptSpamMailList[i];
						let totalNormalMailCnt = totalMailUsageCnt - totalSpamMailCnt;
						let deptNormalMailCnt = deptMailUsageCnt - deptSpamMailCnt;
						let totalNormalMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalNormalMailCnt/totalMailUsageCnt)*100);
						let totalSpamMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalSpamMailCnt/totalMailUsageCnt)*100);
						let deptNormalMailPersent = deptMailUsageCnt == 0 ? 0 : Math.round((deptNormalMailCnt/deptMailUsageCnt)*100);
						let deptSpamMailPersent = deptMailUsageCnt == 0 ? 0 : Math.round((deptSpamMailCnt/deptMailUsageCnt)*100);
						if (period == 'lastWeekIso') {
							dataTableHTML += `
											<tr>
											<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastWeekIso[i].substring(0,10)} ~ \${recentTimeFrames.lastWeekIso[i+1].substring(0,10)}</td>
											`;
						}else {
							dataTableHTML += `
								<tr>
								<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastMonthIso[i].substring(0,10)} ~ \${recentTimeFrames.lastMonthIso[i+1].substring(0,10)}</td>
								`;						
						}
						dataTableHTML += `
												<td class="totalNormalMailCnt py-1 text-center">\${deptNormalMailCnt}</td>
												<td class="py-1 text-center">\${deptNormalMailPersent}%</td>
												<td class="totalSpamMailCnt py-1 text-center">\${deptSpamMailCnt}</td>
												<td class="py-1 text-center">\${deptSpamMailPersent}%</td>
												<td class="totalMailUsageCnt py-1 text-center">\${deptMailUsageCnt}</td>
												<td class="totalNormalMailCnt py-1 text-center">\${totalNormalMailCnt}</td>
												<td class="py-1 text-center">\${totalNormalMailPersent}%</td>
												<td class="totalSpamMailCnt py-1 text-center">\${totalSpamMailCnt}</td>
												<td class="py-1 text-center">\${totalSpamMailPersent}%</td>
												<td class="totalMailUsageCnt py-1 text-center">\${totalMailUsageCnt}</td>
											</tr>						
										`;
					}
				}else {
					globalTotalMailUsageList = res.totalMailUsageList;
					globalTotalSpamMailList = res.totalSpamMailList;
					globalDeptMailUsageList = res.deptMailUsageList;
					globalDeptSpamMailList = res.deptSpamMailList;
					for (var i = 0; i < res.totalMailUsageList.length; i++) {
						let totalMailUsageCnt = res.totalMailUsageList[i];
						let totalSpamMailCnt = res.totalSpamMailList[i];
						let deptMailUsageCnt = res.deptMailUsageList[i];
						let deptSpamMailCnt = res.deptSpamMailList[i];
						let totalNormalMailCnt = totalMailUsageCnt - totalSpamMailCnt;
						let deptNormalMailCnt = deptMailUsageCnt - deptSpamMailCnt;
						let totalNormalMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalNormalMailCnt/totalMailUsageCnt)*100);
						let totalSpamMailPersent = totalMailUsageCnt == 0 ? 0 : Math.round((totalSpamMailCnt/totalMailUsageCnt)*100);
						let deptNormalMailPersent = deptMailUsageCnt == 0 ? 0 : Math.round((deptNormalMailCnt/deptMailUsageCnt)*100);
						let deptSpamMailPersent = deptMailUsageCnt == 0 ? 0 : Math.round((deptSpamMailCnt/deptMailUsageCnt)*100);
							dataTableHTML += `
											<tr>
												<td colspan="2" class="period py-1 text-center">\${recentTimeFrames.lastYearIso[i].substring(0,7)}</td>
												<td class="totalNormalMailCnt py-1 text-center">\${deptNormalMailCnt}</td>
												<td class="py-1 text-center">\${deptNormalMailPersent}%</td>
												<td class="totalSpamMailCnt py-1 text-center">\${deptSpamMailCnt}</td>
												<td class="py-1 text-center">\${deptSpamMailPersent}%</td>
												<td class="totalMailUsageCnt py-1 text-center">\${deptMailUsageCnt}</td>
												<td class="totalNormalMailCnt py-1 text-center">\${totalNormalMailCnt}</td>
												<td class="py-1 text-center">\${totalNormalMailPersent}%</td>
												<td class="totalSpamMailCnt py-1 text-center">\${totalSpamMailCnt}</td>
												<td class="py-1 text-center">\${totalSpamMailPersent}%</td>
												<td class="totalMailUsageCnt py-1 text-center">\${totalMailUsageCnt}</td>
											</tr>						
										`;
					}
				}
			}
			$("#dataTableTbody").html(dataTableHTML);
			var tableExample2 = new List('tableExample2', {
				  page: 5,
				  pagination: true
				});
			
			docReady(echartsBasicBarChartInit(dataType, res));
			docReady(echartsNestedPiesChartInit(dataType, res));
			
		});
	});
	
	// CSV 다운로드
	function downloadCSV(dataType,dataPeriod) {
		let now = new Date();
		let month = now.getMonth() + 1;
		let dataPeriodKo = "";
		let dataTypeKo = "";
		if (dataPeriod == 'lastDayIso') {
			dataPeriodKo = "최근 24시간";
		}else if (dataPeriod == 'lastWeekIso') {
			dataPeriodKo = "최근 일주일";
		}else if (dataPeriod == 'lastMonthIso') {
			dataPeriodKo = "최근 한달";
		}else {
			dataPeriodKo = "최근 1년";
		}
		
		if (dataType == 'total') {
			dataTypeKo = "전체";
		}else if (dataType == 1) {
			dataTypeKo = "재무부";
		}else if (dataType == 2) {
			dataTypeKo = "인사부";
		}else if (dataType == 3) {
			dataTypeKo = "마케팅부";
		}else if (dataType == 4) {
			dataTypeKo = "영업부";
		}else if (dataType == 5) {
			dataTypeKo = "IT부";
		}else if (dataType == 6) {
			dataTypeKo = "법무부";
		}else if (dataType == 7) {
			dataTypeKo = "운영부";
		}else if (dataType == 8) {
			dataTypeKo = "서비스부";
		}else if (dataType == 9) {
			dataTypeKo = "R&D부";
		}
		
	    const fileName = "메일 통계_" + dataTypeKo + "_" + dataPeriodKo + "_" + now.getFullYear() + month + now.getDate() + now.getHours() + now.getMinutes() + now.getSeconds() + ".csv";
	    const csv = convertNodeToCsvString(dataPeriod, dataTypeKo, dataPeriodKo);

	    var link = document.createElement("a");
	    var blob = new Blob(["\uFEFF"+csv], {type: 'text/csv; charset=utf-8'});
	    var url = URL.createObjectURL(blob);
	    $(link).attr({"download" : fileName , "href" : url});
	    link.click();
	}

	function convertNodeToCsvString(period, dataTypeKo, dataPeriodKo) {
	    var result = "";
	    let dataPeriod = recentTimeFrames[period];
	    result += "기간," + dataPeriodKo + "\n";
	    result += "시간 범위," + dataPeriod[0].substring(0, 10) + "~" + dataPeriod[dataPeriod.length - 1].substring(0, 10) + "\n";
	    
	    var node = $("#dataTableThead").find("th");

	    $(node).each(function (index, value) {
	        result += $(value).text() + ",";
	    });
	    result = result.slice(0, -1);
	    result += "\n";

		if (period == 'lastDayIso') {
	        result += recentTimeFrames.lastDayIso[0].substring(0,10) + " ~ " + recentTimeFrames.lastDayIso[23].substring(0,10) + ",";
	        if (dataTypeKo != '전체') {
		        result += (dataList.deptMailUsageCnt - deptSpamMailCnt) + ",";
		        result += dataList.deptSpamMailCnt + ",";
		        result += dataList.deptMailUsageCnt + ",";
			}
	        result += initNormalMailCnt + ",";
	        result += dataList.totalSpamMailCnt + ",";
	        result += dataList.totalMailUsageCnt + "\n";
		}else if (period == 'lastWeekIso') {
			for (var i = 0; i < globalTotalMailUsageList.length; i++) {
				if (i < globalTotalMailUsageList.length - 1) {
			        result += recentTimeFrames.lastWeekIso[i].substring(0,10) + " ~ " + recentTimeFrames.lastWeekIso[i+1].substring(0,10) + ",";

				}else {
			        result += recentTimeFrames.lastWeekIso[i].substring(0,10) + " ~ " + recentTimeFrames.lastWeekIso[i].substring(0,10) + ",";
				}
		        if (dataTypeKo != '전체') {
			        result += (globalDeptMailUsageList[i] - globalDeptSpamMailList[i]) + ",";
			        result += globalDeptSpamMailList[i] + ",";
			        result += globalDeptMailUsageList[i] + ",";
				}
		        result += (globalTotalMailUsageList[i] - globalTotalSpamMailList[i]) + ",";
		        result += globalTotalSpamMailList[i] + ",";
		        result += globalTotalMailUsageList[i] + "\n";
			}
		}else if (period == 'lastMonthIso') {
			for (var i = 0; i < globalTotalMailUsageList.length; i++) {
				if (i < globalTotalMailUsageList.length - 1) {
			        result += recentTimeFrames.lastMonthIso[i].substring(0,10) + " ~ " + recentTimeFrames.lastMonthIso[i+1].substring(0,10) + ",";

				}else {
			        result += recentTimeFrames.lastMonthIso[i].substring(0,10) + " ~ " + recentTimeFrames.lastMonthIso[i].substring(0,10) + ",";
				}
		        if (dataTypeKo != '전체') {
			        result += (globalDeptMailUsageList[i] - globalDeptSpamMailList[i]) + ",";
			        result += globalDeptSpamMailList[i] + ",";
			        result += globalDeptMailUsageList[i] + ",";
				}
		        result += (globalTotalMailUsageList[i] - globalTotalSpamMailList[i]) + ",";
		        result += globalTotalSpamMailList[i] + ",";
		        result += globalTotalMailUsageList[i] + "\n";
			}
		}else {
			for (var i = 0; i < globalTotalMailUsageList.length; i++) {
		        result += recentTimeFrames.lastYearIso[i].substring(0,7) + ",";
		        if (dataTypeKo != '전체') {
			        result += (globalDeptMailUsageList[i] - globalDeptSpamMailList[i]) + ",";
			        result += globalDeptSpamMailList[i] + ",";
			        result += globalDeptMailUsageList[i] + ",";
				}
		        result += (globalTotalMailUsageList[i] - globalTotalSpamMailList[i]) + ",";
		        result += globalTotalSpamMailList[i] + ",";
		        result += globalTotalMailUsageList[i] + "\n";
			}	
		}
	    return result;
	}
	
	// 엑셀 다운로드
	function downloadExcel(dataType, dataPeriod) {
	    let now = new Date();
	    let month = now.getMonth() + 1;
	    let dataPeriodKo = "";
	    let dataTypeKo = "";
	    if (dataPeriod == 'lastDayIso') {
	        dataPeriodKo = "최근 24시간";
	    } else if (dataPeriod == 'lastWeekIso') {
	        dataPeriodKo = "최근 일주일";
	    } else if (dataPeriod == 'lastMonthIso') {
	        dataPeriodKo = "최근 한달";
	    } else {
	        dataPeriodKo = "최근 1년";
	    }
	
	    if (dataType == 'total') {
	        dataTypeKo = "전체";
	    } else if (dataType == 1) {
	        dataTypeKo = "재무부";
	    } else if (dataType == 2) {
	        dataTypeKo = "인사부";
	    } else if (dataType == 3) {
	        dataTypeKo = "마케팅부";
	    } else if (dataType == 4) {
	        dataTypeKo = "영업부";
	    } else if (dataType == 5) {
	        dataTypeKo = "IT부";
	    } else if (dataType == 6) {
	        dataTypeKo = "법무부";
	    } else if (dataType == 7) {
	        dataTypeKo = "운영부";
	    } else if (dataType == 8) {
	        dataTypeKo = "서비스부";
	    } else if (dataType == 9) {
	        dataTypeKo = "R&D부";
	    }
	
	    const fileName = "메일 통계_" + dataTypeKo + "_" + dataPeriodKo + "_" + now.getFullYear() + month + now.getDate() + now.getHours() + now.getMinutes() + now.getSeconds() + ".xlsx";
	    const data = convertNodeToExcelData(dataPeriod, dataTypeKo, dataPeriodKo);
	
	    const ws = XLSX.utils.aoa_to_sheet(data);
	    const wb = XLSX.utils.book_new();
	    XLSX.utils.book_append_sheet(wb, ws, "Mail Statistics");
	
	    XLSX.writeFile(wb, fileName);
	}
	
	function convertNodeToExcelData(period, dataTypeKo, dataPeriodKo) {
	    let data = [];
	    let dataPeriod = recentTimeFrames[period];
	    data.push(["기간", dataPeriodKo]);
	    data.push(["시간 범위", dataPeriod[0].substring(0, 10) + " ~ " + dataPeriod[dataPeriod.length - 1].substring(0, 10)]);
	
	    var node = $("#dataTableThead").find("th");
	    let headers = [];
	
	    $(node).each(function (index, value) {
	        headers.push($(value).text());
	    });
	    data.push(headers);
	
	    if (period == 'lastDayIso') {
	        let row = [
	            recentTimeFrames.lastDayIso[0].substring(0, 10) + " ~ " + recentTimeFrames.lastDayIso[23].substring(0, 10)
	        ];
	        if (dataTypeKo != '전체') {
	            row.push(dataList.deptMailUsageCnt - dataList.deptSpamMailCnt);
	            row.push(dataList.deptSpamMailCnt);
	            row.push(dataList.deptMailUsageCnt);
	        }
	        row.push(initNormalMailCnt);
	        row.push(dataList.totalSpamMailCnt);
	        row.push(dataList.totalMailUsageCnt);
	        data.push(row);
	    } else if (period == 'lastWeekIso') {
	        for (let i = 0; i < globalTotalMailUsageList.length; i++) {
	            let row = [
	                recentTimeFrames.lastWeekIso[i].substring(0, 10) + " ~ " + recentTimeFrames.lastWeekIso[i + 1]?.substring(0, 10)
	            ];
	            if (dataTypeKo != '전체') {
	                row.push(globalDeptMailUsageList[i] - globalDeptSpamMailList[i]);
	                row.push(globalDeptSpamMailList[i]);
	                row.push(globalDeptMailUsageList[i]);
	            }
	            row.push(globalTotalMailUsageList[i] - globalTotalSpamMailList[i]);
	            row.push(globalTotalSpamMailList[i]);
	            row.push(globalTotalMailUsageList[i]);
	            data.push(row);
	        }
	    } else if (period == 'lastMonthIso') {
	        for (let i = 0; i < globalTotalMailUsageList.length; i++) {
	            let row = [
	                recentTimeFrames.lastMonthIso[i].substring(0, 10) + " ~ " + recentTimeFrames.lastMonthIso[i + 1]?.substring(0, 10)
	            ];
	            if (dataTypeKo != '전체') {
	                row.push(globalDeptMailUsageList[i] - globalDeptSpamMailList[i]);
	                row.push(globalDeptSpamMailList[i]);
	                row.push(globalDeptMailUsageList[i]);
	            }
	            row.push(globalTotalMailUsageList[i] - globalTotalSpamMailList[i]);
	            row.push(globalTotalSpamMailList[i]);
	            row.push(globalTotalMailUsageList[i]);
	            data.push(row);
	        }
	    } else {
	        for (let i = 0; i < globalTotalMailUsageList.length; i++) {
	            let row = [recentTimeFrames.lastYearIso[i].substring(0, 7)];
	            if (dataTypeKo != '전체') {
	                row.push(globalDeptMailUsageList[i] - globalDeptSpamMailList[i]);
	                row.push(globalDeptSpamMailList[i]);
	                row.push(globalDeptMailUsageList[i]);
	            }
	            row.push(globalTotalMailUsageList[i] - globalTotalSpamMailList[i]);
	            row.push(globalTotalSpamMailList[i]);
	            row.push(globalTotalMailUsageList[i]);
	            data.push(row);
	        }
	    }
	
	    return data;
	}
	
});



var echartsBasicBarChartInit = function echartsBasicBarChartInit(type, dataList) {
    var $barChartEl = document.querySelector('.echart-line-chart-example');
    if ($barChartEl) {
        // Get options from data attribute
        var userOptions = utils.getData($barChartEl, 'options'); // 사용자 옵션 가져오기
        var chart = window.echarts.init($barChartEl);			 // ECharts 라이브러리를 사용하여 선택한 DOM 요소에 차트를 초기화
        
        let period = dataList.period;
        let dataPeriod = recentTimeFrames[period];
        let xAxisData = null;
        if (period == 'lastDayIso') {
            xAxisData = dataPeriod.map(date => date.substring(date.indexOf('T') + 1, date.indexOf('T') + 3) + "시");
            xAxisData.pop();
        } else if (period == 'lastWeekIso') {
            xAxisData = dataPeriod.map(date => date.substring(5, 10));
            xAxisData.pop();
        } else if (period == 'lastMonthIso') {
            xAxisData = dataPeriod.map(date => date.substring(5, 10));
            xAxisData.pop();
        } else {
            xAxisData = dataPeriod.map(date => date.substring(5, 7) + "월");
            // 모든 요소에서 '0' 제거
            xAxisData = xAxisData.map(month => month.charAt(0) == '0' ? month.substr(1) : month);
            xAxisData.pop();
        }

        
        // 데이터 배열: 전체 메일과 부서 메일
        var totalEmails = dataList.totalMailUsageList;
        var totalInterval = Math.ceil((Math.max(...totalEmails)/6));
        var totalMax = totalInterval * 6;
        if (type != 'total') {
	        var departmentEmails = dataList.deptMailUsageList;
		}
        
        // 차트 초기화
        chart.clear();

        if (type != 'total') {
	        var getDefaultOptions = function getDefaultOptions() {	// 기본 옵션 함수 정의
	            return {
	                title: {
	                    text: '전체 메일과 부서 메일의 사용량', // 차트 제목
	                    left: 'center' // 제목 위치를 중앙으로 설정
	                },
	                tooltip: {
	                    trigger: 'axis', 							// 'axis'로 설정하여 축에 대한 툴팁을 표시
	                    padding: [7, 10], 							// 툴팁의 내부 여백을 설정
	                    backgroundColor: utils.getGrays()['100'], 	// 툴팁의 배경색을 설정
	                    borderColor: utils.getGrays()['300'], 		// 툴팁의 테두리 색상
	                    textStyle: { 								// 툴팁 텍스트의 색상과 스타일을 정의
	                        color: utils.getGrays()['1100']
	                    },
	                    borderWidth: 1,								// 테두리의 두께를 설정
	                    formatter: tooltipFormatter,				// 툴팁의 내용을 설정
	                    transitionDuration: 0,						// 툴팁의 전환 지속 시간을 설정
	                    axisPointer: {								// 축 포인터의 설정
	                        type: 'none'
	                    }
	                },
	                legend: {
	                    data: ['전체 메일', '부서 메일'],				// 범례에 표시할 데이터 시리즈의 이름을 배열로 정의
	                    top: 23										// 범례의 위치를 설정합니다 (차트의 상단에서 20px 떨어진 위치)
	                },
	                xAxis: {
	                    type: 'category',							// 'category'로 설정하여 카테고리형 데이터 (월)를 사용
	                    data: xAxisData,							// X축에 표시할 데이터를 months 배열로 설정
	                    boundaryGap: true,                          // 막대가 끝에 밀리지 않도록 설정 (추가된 주석)
	                    axisLine: {									// 축선의 스타일을 설정 (색상 및 유형)
	                        lineStyle: {
	                            color: utils.getGrays()['1000'],
	                            type: 'solid'
	                        }
	                    },
	                    axisTick: {									// 축 눈금의 표시 여부를 설정
	                        show: false	
	                    },
	                    axisLabel: {								// 축 레이블의 스타일을 설정하며, 레이블의 첫 세 글자만 표시하도록 포맷팅
	                        color: utils.getGrays()['1000'],
	                        formatter: function formatter(value) {
	                            return value;
	                        },
	                        margin: 15								// 글자 간 간격
	                    },
	                    splitLine: {								// 축의 분할선 표시 여부를 설정
	                        show: false
	                    }
	                },
	                yAxis: {
	                    type: 'value',								// 'value'로 설정하여 값형 데이터를 사용
	                    boundaryGap: true,							// Y축의 경계 설정
	                    axisLabel: {								// Y축 레이블의 스타일 및 표시 여부
	                        show: true,
	                        color: utils.getGrays()['1000'],
	                        margin: 15
	                    },
	                    splitLine: {								// 분할선의 표시 여부 및 스타일을 설정
	                        show: true,
	                        lineStyle: {
	                            color: utils.getGrays()['1000']
	                        }
	                    },
	                    axisTick: {									// Y축 눈금의 표시 여부를 설정
	                        show: false
	                    },
	                    axisLine: {									// Y축의 축선을 표시할지 여부를 설정
	                        show: false				
	                    },
	                    min: 0,										// Y축의 최소값을 0으로 설정
	                    max: totalMax,								// Y축의 최대값을 totalMax으로 설정
	                    splitNumber: 6,								// Y축 눈금의 수
	                    interval: totalInterval
	                },
	                series: [
	                    {
	                        type: 'bar', // 전체 메일					// 각 시리즈의 유형을 'bar'로 설정하여 막대 그래프를 생성
	                        name: '전체 메일',							// 각 시리즈의 이름을 설정
	                        data: totalEmails,						// 각 시리즈에 표시할 데이터를 지정
	                        itemStyle: {							// 각 막대의 스타일을 설정
	                            color: utils.getColor('primary'),
	                            barBorderRadius: [3, 3, 0, 0]
	                        },
	                        barWidth: '30%',						// 막대 그래프 두께 설정 (퍼센트 또는 픽셀로 설정 가능)
	                        barCategoryGap: '50%', 					// 막대 간격 설정
	                        showSymbol: false,						// 데이터 포인트의 기호 표시 여부를 설정
	                        hoverAnimation: true					// 마우스 오버 시 애니메이션 표시 여부를 설정
	                    },
	                    {
	                        type: 'bar', // 부서 메일
	                        name: '부서 메일',
	                        data: departmentEmails,
	                        itemStyle: {
	                            color: utils.getColor('secondary'), // 다른 색상으로 설정
	                            barBorderRadius: [3, 3, 0, 0]
	                        },
	                        barWidth: '30%',
	                        barCategoryGap: '50%',
	                        showSymbol: false,
	                        hoverAnimation: true
	                    }
	                ],
	                grid: {
	                	top: '15%'
	                },
	                animation: false
	            };
	        };
		}else { // total일 경우
	        var getDefaultOptions = function getDefaultOptions() {	// 기본 옵션 함수 정의
	            return {
	                title: {
	                    text: '전체 메일의 사용량', // 차트 제목
	                    left: 'center' // 제목 위치를 중앙으로 설정
	                },
	                tooltip: {
	                    trigger: 'axis', 							// 'axis'로 설정하여 축에 대한 툴팁을 표시
	                    padding: [7, 10], 							// 툴팁의 내부 여백을 설정
	                    backgroundColor: utils.getGrays()['100'], 	// 툴팁의 배경색을 설정
	                    borderColor: utils.getGrays()['300'], 		// 툴팁의 테두리 색상
	                    textStyle: { 								// 툴팁 텍스트의 색상과 스타일을 정의
	                        color: utils.getGrays()['1100']
	                    },
	                    borderWidth: 1,								// 테두리의 두께를 설정
	                    formatter: tooltipFormatter,				// 툴팁의 내용을 설정
	                    transitionDuration: 0,						// 툴팁의 전환 지속 시간을 설정
	                    axisPointer: {								// 축 포인터의 설정
	                        type: 'none'
	                    }
	                },
	                legend: {
	                    data: ['전체 메일'],				// 범례에 표시할 데이터 시리즈의 이름을 배열로 정의
	                    top: 23										// 범례의 위치를 설정합니다 (차트의 상단에서 20px 떨어진 위치)
	                },
	                xAxis: {
	                    type: 'category',							// 'category'로 설정하여 카테고리형 데이터 (월)를 사용
	                    data: xAxisData,								// X축에 표시할 데이터를 months 배열로 설정
	                    boundaryGap: true,                          // 막대가 끝에 밀리지 않도록 설정 (추가된 주석)
	                    axisLine: {									// 축선의 스타일을 설정 (색상 및 유형)
	                        lineStyle: {
	                            color: utils.getGrays()['1000'],
	                            type: 'solid'
	                        }
	                    },
	                    axisTick: {									// 축 눈금의 표시 여부를 설정
	                        show: false	
	                    },
	                    axisLabel: {								// 축 레이블의 스타일을 설정하며, 레이블의 첫 세 글자만 표시하도록 포맷팅
	                        color: utils.getGrays()['1000'],
	                        formatter: function formatter(value) {
	                            return value;
	                        },
	                        margin: 15								// 글자 간 간격
	                    },
	                    splitLine: {								// 축의 분할선 표시 여부를 설정
	                        show: false
	                    }
	                },
	                yAxis: {
	                    type: 'value',								// 'value'로 설정하여 값형 데이터를 사용
	                    boundaryGap: true,							// Y축의 경계 설정
	                    axisLabel: {								// Y축 레이블의 스타일 및 표시 여부
	                        show: true,
	                        color: utils.getGrays()['1000'],
	                        margin: 15
	                    },
	                    splitLine: {								// 분할선의 표시 여부 및 스타일을 설정
	                        show: true,
	                        lineStyle: {
	                            color: utils.getGrays()['1000']
	                        }
	                    },
	                    axisTick: {									// Y축 눈금의 표시 여부를 설정
	                        show: false
	                    },
	                    axisLine: {									// Y축의 축선을 표시할지 여부를 설정
	                        show: false				
	                    },
	                    min: 0,										// Y축의 최소값을 600으로 설정
	                    max: totalMax,
	                    splitNumber: 6,
	                    interval: totalInterval
	                },
	                series: [
	                    {
	                        type: 'bar', // 전체 메일					// 각 시리즈의 유형을 'bar'로 설정하여 막대 그래프를 생성
	                        name: '전체 메일',							// 각 시리즈의 이름을 설정
	                        data: totalEmails,						// 각 시리즈에 표시할 데이터를 지정
	                        itemStyle: {							// 각 막대의 스타일을 설정
	                            color: utils.getColor('primary'),
	                            barBorderRadius: [3, 3, 0, 0]
	                        },
	                        barWidth: '30%',						// 막대 그래프 두께 설정 (퍼센트 또는 픽셀로 설정 가능)
	                        barCategoryGap: '50%', 					// 막대 간격 설정
	                        showSymbol: false,						// 데이터 포인트의 기호 표시 여부를 설정
	                        hoverAnimation: true					// 마우스 오버 시 애니메이션 표시 여부를 설정
	                    }
	                ],
	                grid: {
	                	top: '15%'
	                },
	                animation: false
	            };
	        };			
		}
        echartSetOption(chart, userOptions, getDefaultOptions);	// 옵션 설정 및 차트 렌더링
    }
};

var echartsNestedPiesChartInit = function echartsNestedPiesChartInit(type, dataList) {
    var $nestedPiesChartEl = document.querySelector('.echart-nested-pies-chart');
    if ($nestedPiesChartEl) {
        var chart = window.echarts.init($nestedPiesChartEl);

     	// 데이터 정의
        var totalMailUsageCnt = dataList.totalMailUsageCnt; // 전체 메일 개수
        var totalSpamMailCnt = dataList.totalSpamMailCnt; // 전체 스팸 메일 개수
        if (type != 'total') {
	        var deptMailUsageCnt = dataList.deptMailUsageCnt; // 특정 부서의 전체 메일 개수
	        var deptSpamMailCnt = dataList.deptSpamMailCnt; // 특정 부서의 스팸 메일 개수
		} 
        
        // 차트 초기화
        chart.clear();
        
        if (type != 'total') {
	        var getNestedPiesOptions = function getNestedPiesOptions() {
	            return {
	                title: {
	                    text: '전체 메일과 부서 메일의 스팸 비율', // 차트 제목
	                    left: 'center' // 제목 위치를 중앙으로 설정
	                },
	                tooltip: {
	                    trigger: 'item', // 툴팁을 항목에 대해 표시
	                    formatter: '{a} <br/>{b}: {c} ({d}%)' // 툴팁 포맷
	                },
	                legend: {
	                    data: ['전체 정상 메일', '전체 스팸 메일', '부서 정상 메일', '부서 스팸 메일'], // 범례 항목
	                    bottom: 0 // 범례 위치를 아래쪽으로 설정
	                },
	                series: [
	                    {
	                        name: '전체 메일 비율', // 바깥 원형 차트의 시리즈 이름
	                        type: 'pie', // 차트 유형을 원형으로 설정
	                        radius: ['55%', '75%'], // 바깥 원형 차트의 내부 및 외부 반경 설정 (간격 확대)
	                        label: {
	                            position: 'outer', // 레이블 위치를 바깥쪽으로 설정
	                            formatter: '{b}: {d}%' // 레이블 포맷
	                        },
	                        data: [
	                            { value: totalMailUsageCnt - totalSpamMailCnt, name: '전체 정상 메일' }, // 전체 정상 메일 데이터
	                            { value: totalSpamMailCnt, name: '전체 스팸 메일' } // 전체 스팸 메일 데이터
	                        ],
	                        itemStyle: {
	                            color: function (params) {
	                                // 색상 결정 함수
	                                return params.data.name === '전체 스팸 메일'
	                                    ? utils.getColor('danger') // 스팸 메일 색상
	                                    : utils.getColor('success'); // 정상 메일 색상
	                            }
	                        }
	                    },
	                    {
	                        name: '부서 메일 비율', // 안쪽 원형 차트의 시리즈 이름
	                        type: 'pie', // 차트 유형을 원형으로 설정
	                        radius: ['20%', '40%'], // 안쪽 원형 차트의 내부 및 외부 반경 설정 (간격 확대)
	                        label: {
	                            position: 'inner', // 레이블 위치를 안쪽으로 설정
	                            formatter: '{b}: {d}%' // 레이블 포맷
	                        },
	                        data: [
	                            { value: deptMailUsageCnt - deptSpamMailCnt, name: '부서 정상 메일' }, // 부서 정상 메일 데이터
	                            { value: deptSpamMailCnt, name: '부서 스팸 메일' } // 부서 스팸 메일 데이터
	                        ],
	                        itemStyle: {
	                            color: function (params) {
	                                // 색상 결정 함수
	                                return params.data.name === '부서 스팸 메일'
	                                    ? utils.getColor('primary') // 부서 스팸 메일 색상
	                                    : utils.getColor('secondary'); // 부서 정상 메일 색상
	                            }
	                        }
	                    }
	                ],
	                animation: false
	            };
	        };
		}else {
	        var getNestedPiesOptions = function getNestedPiesOptions() {
	            return {
	                title: {
	                    text: '전체 메일의 스팸 비율', // 차트 제목
	                    left: 'center' // 제목 위치를 중앙으로 설정
	                },
	                tooltip: {
	                    trigger: 'item', // 툴팁을 항목에 대해 표시
	                    formatter: '{a} <br/>{b}: {c} ({d}%)' // 툴팁 포맷
	                },
	                legend: {
	                    data: ['전체 정상 메일', '전체 스팸 메일'], // 범례 항목
	                    bottom: 0 // 범례 위치를 아래쪽으로 설정
	                },
	                series: [
	                    {
	                        name: '전체 메일의 스팸 비율', // 바깥 원형 차트의 시리즈 이름
	                        type: 'pie', // 차트 유형을 원형으로 설정
	                        radius: ['55%', '75%'], // 바깥 원형 차트의 내부 및 외부 반경 설정 (간격 확대)
	                        label: {
	                            position: 'outer', // 레이블 위치를 바깥쪽으로 설정
	                            formatter: '{b}: {d}%' // 레이블 포맷
	                        },
	                        data: [
	                            { value: totalMailUsageCnt - totalSpamMailCnt, name: '전체 정상 메일' }, // 전체 정상 메일 데이터
	                            { value: totalSpamMailCnt, name: '전체 스팸 메일' } // 전체 스팸 메일 데이터
	                        ],
	                        itemStyle: {
	                            color: function (params) {
	                                // 색상 결정 함수
	                                return params.data.name === '전체 스팸 메일'
	                                    ? utils.getColor('danger') // 스팸 메일 색상
	                                    : utils.getColor('success'); // 정상 메일 색상
	                            }
	                        }
	                    }
	                ],
	                animation: false
	            };
	        };			
		}
        

        chart.setOption(getNestedPiesOptions()); // 차트 옵션 설정
    }
};

function getRecentTimeFrames() {
    const now = new Date(); // 현재 날짜
    const currentHour = now.getHours(); // 현재 시
    const currentDate = now.getDate(); // 현재 일
    const currentMonth = now.getMonth(); // 현재 월 (0부터 시작, 11은 12월)
    const currentYear = now.getFullYear(); // 현재 년

 	// 최근 1년 데이터
	const lastYearDates = [];
	for (let i = 0; i < 12; i++) {
	    const monthIndex = (currentMonth + 1 + i) % 12; // 23년 12월부터 시작
	    const year = currentYear - 1 + Math.floor((currentMonth + 1 + i) / 12); // 년도 계산
	    lastYearDates.push(new Date(year, monthIndex, 1)); // Date 객체를 배열에 추가
	}
	lastYearDates.push(now);

    // 최근 1개월 데이터
    const lastMonthDates = [];
    const daysInLastMonth = new Date(currentYear, currentMonth, 0).getDate(); // 지난 월의 마지막 일
    for (let i = currentDate + 1; i <= daysInLastMonth; i++) {
        const date = new Date(currentYear, (currentMonth + 11) % 12, i); // 현재 월의 다음 날부터 마지막 날까지
        lastMonthDates.push(date); // ISO 변환 전 추가
    }
    for (let i = 1; i <= currentDate; i++) {
        lastMonthDates.push(new Date(currentYear, currentMonth, i)); // 현재 월의 1일부터 현재 날짜까지
    }
    lastMonthDates.push(now);
    
    // 최근 일주일 데이터
    const lastWeekDates = [];
    for (let i = 0; i < 7; i++) {
		const date = new Date(currentYear, currentMonth, currentDate - 6 + i);
		lastWeekDates.push(date);
	}
	lastWeekDates.push(now);

    // 최근 1일 데이터
    const lastDayDates = [];
    for (let i = currentHour + 1; i <= 23; i++) { // 전날 시각부터 23시까지
        const date = new Date(currentYear, currentMonth, currentDate - 1, i); // 전날 날짜의 i시
        lastDayDates.push(date);
    }
    for (let i = 0; i <= currentHour; i++) { // 0시부터 현재 시각까지
        const date = new Date(currentYear, currentMonth, currentDate, i); // 현재 날짜의 i시
        lastDayDates.push(date);
    }
    lastDayDates.push(now);

    // 모든 날짜를 KST 기준으로 ISO 형식으로 변환
    const convertToKST = (date) => {
        // UTC에서 KST로 변환 (UTC + 9시간)
        const kstDate = new Date(date.getTime() + (9 * 60 * 60 * 1000));
        return kstDate.toISOString();
    };

    const lastYearIso = lastYearDates.map(convertToKST);
    const lastMonthIso = lastMonthDates.map(convertToKST);
    const lastWeekIso = lastWeekDates.map(convertToKST);
    const lastDayIso = lastDayDates.map(convertToKST);
    
    return {
        lastYearIso,
        lastMonthIso,
        lastWeekIso,
        lastDayIso
    };
}


</script>