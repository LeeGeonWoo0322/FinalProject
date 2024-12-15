<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="d-flex flex-column bg-100 w-100 p-3">
	<div>
		<span>보안 관리</span>
		<h4>멤버 접근 로그</h4>
		<div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
        	<div class="bg-dark text-light border rounded-3 p-2" id="alertDiv">
        </div>
   	</div>
	</div>
	<div class="card w-100 p-3" style="height: 100%">
		<div class="d-flex flex-column mb-2">
			<div>
				<table>
					<colgroup>
						<col width="100px">
						<col width="300px">
						<col width="100px">
					</colgroup>
					<tr>
						<th>이름</th>
						<td colspan="2"><input type="text" id="memName" class="form-control form-control-sm" style="width: 90%"></td>
					</tr>
					<tr>
						<th>기간</th>
						<td><input type="date" id="logStart"> ~ <input type="date" id="logEnd"></td>
						<td><button class="btn btn-info me-2 mb-1 px-3 py-1" type="button" id="logBtn">검색</button></td>
					</tr>
				</table>
			</div>
		</div>
		<div id="tableExample2" data-list='{"valueNames":["time","name","dept","status","type","ip","device","browser","os"],"page":10,"pagination":true}'>
			<div class="table-responsive scrollbar" style="min-height: 550px">
				<table class="table table-bordered mb-0" style="font-size: 15px">
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead class="bg-200">
						<tr>
							<th class="text-900 sort text-center" data-sort="time">시간</th>
							<th class="text-900 sort text-center" data-sort="name">이름(이메일)</th>
							<th class="text-900 sort text-center" data-sort="dept">부서</th>
							<th class="text-900 sort text-center" data-sort="status">상태</th>
							<th class="text-900 sort text-center" data-sort="type">유형</th>
							<th class="text-900 sort text-center" data-sort="ip">IP</th>
							<th class="text-900 sort text-center" data-sort="browser">브라우저</th>
							<th class="text-900 sort text-center" data-sort="os">운영체제</th>
						</tr>
					</thead>
					<tbody class="list" id="logList">
						<c:choose>
							<c:when test="${empty logList }">
								<tr>
									<td colspan="8" class="p-4 text-center">로그인 또는 로그아웃된 기록이 없습니다.</td>
								</tr>
							</c:when>
						    <c:otherwise>
						        <c:forEach items="${logList}" var="log">
						            <tr>
						                <fmt:parseDate value="${log.createDate}" var="parseDate" pattern="yyyy-MM-dd HH:mm:ss" />
						                <fmt:formatDate value="${parseDate}" var="formatDate" pattern="yyyy-MM-dd(EE) HH:mm" />
						                <td class="time text-center">${formatDate}</td>
						                <td class="name">${log.memName}(${log.memEmail})</td>
						                <td class="dept text-center">${log.deptName}</td>
						                <td class="status text-center p-1 align-middle">
						                    <c:if test="${log.logStatus eq '로그인'}">
						                        <span class="badge badge-subtle-success fs-9">로그인</span>
						                    </c:if>
						                    <c:if test="${log.logStatus eq '로그아웃'}">
						                        <span class="badge badge-subtle-danger fs-9">로그아웃</span>
						                    </c:if>
						                </td>
						                <td class="type text-center">${log.logType}</td>
						                <td class="ip text-center">${log.ip}</td>
						                <td class="browser text-center">${log.logBrowser}</td>
						                <td class="os text-center">${log.logOs}</td>
						            </tr>
						        </c:forEach>
						    </c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			 	 <ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
async function logSearchResult(){

	let memName = $("#memName").val();
	let logStart = $("#logStart").val();
	let logEnd = $("#logEnd").val();
	
	if (!memName && !logStart && !logEnd) {
		requiredAlert("이름이나 기간 중 하나 이상 입력해주세요.", isAlertVisible);
		return false;
	} else if ((logStart && !logEnd) || (!logStart && logEnd)) {
		requiredAlert("모든 기간을 입력해주세요.", isAlertVisible);
		return false;
	}
	
	let resp = await axios({
		url : "/admin/security/logSearch.do",
		method : "post",
		data : {
			memName : memName
			, startDate : logStart
			, endDate : logEnd
		},
		headers : {
			"Content-Type" : "application/json; charset=utf-8"
		}
	});
  
  	let res = resp.data;
	let logListHTML = '';
	for (var i = 0; i < res.length; i++) {
		let weekend = getWeekend(res[i].createDate);
		logListHTML += `
				        <tr>
			                <td class="time text-center">\${res[i].createDate.substring(0,10)}(\${weekend}) \${res[i].createDate.substring(11,16)}</td>
			                <td class="name">\${res[i].memName}(\${res[i].memEmail})</td>
			                <td class="dept text-center">\${res[i].deptName}</td>
			                <td class="status text-center p-1 align-middle">
			           `;
		if (res[i].logStatus == '로그인') {
			logListHTML += `<span class="badge badge-subtle-success fs-9">로그인</span>`;
		}else {
			logListHTML += `<span class="badge badge-subtle-danger fs-9">로그아웃</span>`;
		}
		logListHTML += `
			                </td>
			                <td class="type text-center">\${res[i].logType}</td>
			                <td class="ip text-center">\${res[i].ip}</td>
			                <td class="browser text-center">\${res[i].logBrowser}</td>
			                <td class="os text-center">\${res[i].logOs}</td>
			            </tr>
						`;
	}
	$("#logList").html(logListHTML);
	var logList = new List('tableExample2', {
		valueNames: ["time","name","dept","status","type","ip","device","browser","os"],
		page: 10,
		pagination: true
	});
}


$("#logBtn").on("click", function () {
	logSearchResult();  // 요 자체가 비동기로 돌기 때문에 주의 필요
});

</script>
