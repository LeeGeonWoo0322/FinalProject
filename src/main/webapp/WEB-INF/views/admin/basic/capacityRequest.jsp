<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.urv:hover {
	background: #F7F7F7;
}
.form-control:disabled{
	background-color: #F7F7F7;
}
</style>

<div class="d-flex flex-column bg-100 w-100 p-3">
	<div>
		<span>기본 관리</span>
		<h4>용량 요청 관리</h4>
	</div>
	<div class="card w-100 p-3" style="height: 100%">
		<div class="mb-3">
			<table>
				<colgroup>
					<col width="100px">
					<col width="300px">
					<col width="100px">
				</colgroup>
				<tr>
					<th>요청일자</th>
					<td><input type="date" id="capacityReqStart"><span> ~ </span><input type="date" id="capacityReqEnd"></td>
					<td><button id="capacityReqSearchBtn" class="btn btn-info fs-9" type="button" style="padding: 1px 10px">검색</button></td>
				</tr>
			</table>
		</div>
		<div id="tableExample2" data-list='{"valueNames":["requestDate","reqName","type","status","refDate","respName"],"page":10,"pagination":true}'>
			<div class="table-responsive scrollbar" style="min-height: 550px">
				<table class="table table-bordered mb-0" style="font-size: 15px">
					<colgroup>
						<col width="20%">
						<col width="10%">
						<col width="10%">
						<col width="20%">
						<col width="10%">
						<col width="20%">
						<col width="10%">
					</colgroup>
					<thead class="bg-200">
						<tr>
							<th class="text-900 sort text-center" data-sort="requestDate">요청일자</th>
							<th class="text-900 sort text-center" data-sort="reqName">요청자명</th>
							<th class="text-900 sort text-center" data-sort="type">용량타입</th>
							<th class="text-900 text-center">사용량</th>
							<th class="text-900 sort text-center" data-sort="status">반영상태</th>
							<th class="text-900 sort text-center" data-sort="reflectionDate">반영일자</th>
							<th class="text-900 sort text-center" data-sort="respName">처리자</th>
						</tr>
					</thead>
					<tbody class="list" id="capacityReqList">
						<c:choose>
							<c:when test="${empty upgradeReqVOList }">
								<tr>
									<td colspan="7" class="p-4 text-center">용량 추가 요청이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${upgradeReqVOList }" var="urv">
									<tr class="urv" style="cursor: pointer;" data-no="${urv.urNo }">
										<fmt:parseDate value="${urv.reqDate}" var="parseReqDate" pattern="yyyy-MM-dd HH:mm:ss" />
						                <fmt:formatDate value="${parseReqDate}" var="formatReqDate" pattern="yyyy-MM-dd(EE) HH:mm" />
						                <c:if test="${not empty urv.respDate }">
											<fmt:parseDate value="${urv.respDate}" var="parseRespDate" pattern="yyyy-MM-dd HH:mm:ss" />
							                <fmt:formatDate value="${parseRespDate}" var="formatRespDate" pattern="yyyy-MM-dd(EE) HH:mm" />
						                </c:if>
										<td class="requestDate text-center">${formatReqDate }</td>
										<td class="name text-center">${urv.reqMemName }</td>
										<c:if test="${urv.reqGb eq '1' }">
											<td class="type text-center">메일 용량</td>
										</c:if>
										<c:if test="${urv.reqGb eq '2' }">
											<td class="type text-center">드라이브 용량</td>
										</c:if>
										<td class="text-center">
											<c:choose>
											    <c:when test="${urv.mailVolume >= 1024 * 1024 * 1024}">
											        <fmt:formatNumber value="${urv.mailVolume / (1024 * 1024 * 1024)}" var="formatNum" pattern="0.0"/>
											        <span>${formatNum}GB</span>
											    </c:when>
											    <c:when test="${urv.mailVolume >= 1024 * 1024}">
											        <fmt:formatNumber value="${urv.mailVolume / (1024 * 1024)}" var="formatNum" pattern="0.0"/>
											        <span>${formatNum}MB</span>
											    </c:when>
											    <c:when test="${urv.mailVolume >= 1024}">
											        <fmt:formatNumber value="${urv.mailVolume / 1024}" var="formatNum" pattern="0.0"/>
											        <span>${formatNum}KB</span>
											    </c:when>
											    <c:otherwise>
											        <span>${urv.mailVolume}byte</span>
											    </c:otherwise>
											</c:choose>
											<span> 중 </span>
											<c:choose>
											    <c:when test="${urv.totalFileSize >= 1024 * 1024 * 1024}">
											        <fmt:formatNumber value="${urv.totalFileSize / (1024 * 1024 * 1024)}" var="formatNum" pattern="0.0"/>
											        <span>${formatNum}GB</span>
											    </c:when>
											    <c:when test="${urv.totalFileSize >= 1024 * 1024}">
											        <fmt:formatNumber value="${urv.totalFileSize / (1024 * 1024)}" var="formatNum" pattern="0.0"/>
											        <span>${formatNum}MB</span>
											    </c:when>
											    <c:when test="${urv.totalFileSize >= 1024}">
											        <fmt:formatNumber value="${urv.totalFileSize / 1024}" var="formatNum" pattern="0.0"/>
											        <span>${formatNum}KB</span>
											    </c:when>
											    <c:otherwise>
											        <span>${urv.totalFileSize}byte</span>
											    </c:otherwise>
											</c:choose>
											<span> 사용</span>
										</td>
										<c:choose>
											<c:when test="${urv.reqStatus eq '0' }">
												<td class="status text-center p-0 align-middle"><span class="badge badge-subtle-secondary fs-9">대기</span></td>
											</c:when>
											<c:when test="${urv.reqStatus eq '1' }">
												<td class="status text-center p-0 align-middle"><span class="badge badge-subtle-success fs-9">완료</span></td>
											</c:when>
											<c:otherwise>
												<td class="status text-center p-0 align-middle"><span class="badge badge-subtle-danger fs-9">거절</span></td>
											</c:otherwise>
										</c:choose>
										<td class="refDate text-center">
											<c:if test="${not empty urv.respDate}">${formatRespDate }</c:if>
										</td>
										<td class="respName text-center">${urv.respMemName }</td>
										<td class="d-none">${urv.reqComent }</td>
										<td class="d-none">${urv.respReason }</td>
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
<div class="modal fade" id="reqManageModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reqManageModalHead" aria-hidden="true">
  <div class="modal-dialog modal-md mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="reqManageModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="reqManageModalHead">용량 요청 정보</h4>
        </div>
        <div id="urNoDiv" class="d-none"></div>
		<div class="d-flex flex-column p-3">
			<div>
				<table>
					<colgroup>
						<col width="150px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th class="p-2">요청자</th>
							<td id="reqMemName"></td>
						</tr>
						<tr>
							<th class="p-2">요청일자</th>
							<td id="reqDate"></td>
						</tr>
						<tr>
							<th class="p-2">용량</th>
							<td id="capacity"></td>
						</tr>
						<tr>
							<th class="align-top p-2">요청사항</th>
							<td><div id="reqComent" style="white-space: pre-wrap;"></div></td>
						</tr>
					</tbody>
				</table>
			</div>
			<hr>
			<div>
				<table>
					<colgroup>
						<col width="150px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th class="p-2">용량 추가</th>
							<td>100MB</td>
						</tr>
						<tr>
							<th class="align-top p-2">코멘트</th>
							<td>
								<textarea id="respComent" rows="3" cols="50" class="form-control" wrap="hard" spellcheck="false" placeholder="용량 요청 상태가 업데이트되었습니다."></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div id="completeReq" class="d-flex flex-row justify-content-end align-items-center my-2 pe-3 d-none" style="height: 50px;">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-2" id="reqManagAdd"><div style="height: 30px;line-height: 30px">용량추가</div></a></div>
			<div><a class="btn btn-danger d-flex align-items-center px-2 py-0" id="reqManageCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">거절</div></a></div>
		</div>
		<div id="notCompleteReq" class="d-flex flex-row justify-content-center align-items-center my-2 d-none" style="height: 50px;">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0" id="reqManageConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
let recentTd = null;

$(".urv").on("click", function () {
	recentTd = $(this).find("td");
	$("#urNoDiv").text($(this).data('no'));
	$("#reqMemName").text(recentTd.eq(1).text());
	$("#reqDate").text(recentTd.eq(0).text());
	$("#capacity").text(recentTd.eq(3).text());
	$("#reqComent").html(recentTd.eq(7).html());
	$("#respComent").val(recentTd.eq(8).html())
	
	toggleReadonly("#reqComent");
	
	$("#completeReq").addClass("d-none");
	$("#notCompleteReq").addClass("d-none");
	if (recentTd.eq(4).find("span").text() == '대기') {
		$("#completeReq").removeClass("d-none");
	}else {
		$("#notCompleteReq").removeClass("d-none");
	}
	if (recentTd.eq(4).find("span").text() == '완료') {
	    $("#respComent").prop("disabled", true); 
	} else {
	    $("#respComent").prop("disabled", false); 
	}
	
	$("#reqManageModal").modal("show");
});

//읽기 전용 상태를 설정하는 함수
function toggleReadonly(selector) {
    $(selector).prop("readonly", $(selector).val() ? true : false);
}

$("#reqManagAdd, #reqManageCancle").on("click", function () {
	reqManage($(this));
	$("#reqManageModal").modal("hide");
});

$("#reqManageConfirm").on("click", function () {
	$("#reqManageModal").modal("hide");
});

$("#capacityReqSearchBtn").on("click", function () {
	searchReq();
});

async function reqManage(element) {
	let urNo = $("#urNoDiv").text();
	let reqStatus = 0;
	let respReason = "";
	if (element.is("#reqManagAdd")) {
		reqStatus = 1;
	}else if (element.is("#reqManageCancle")) {
		reqStatus = 2;
	}
	if (!$("#respComent").val()) {
		respReason = "용량 요청 상태가 업데이트되었습니다.";
	}
	
	let response = await axios({
		url : "/admin/basic/reqManage.do",
		method : "post",
		data : {
			urNo : urNo
			, reqStatus : reqStatus
			, respReason : respReason
		},
		headers : {
			"Content-Type" : "application/json; charset=utf-8"	
		}
	});
	
	let res = response.data;
	let weekend = getWeekend(res.respDate);
	let formatMailVolume = formatFileSize(res.mailVolume);
	let formatTotal = formatFileSize(res.totalFileSize);
	if (reqStatus == 1) {
		recentTd.eq(4).html(`<span class="badge badge-subtle-success fs-9">완료</span>`);
	}else if (reqStatus == 2) {
		recentTd.eq(4).html(`<span class="badge badge-subtle-danger fs-9">거절</span>`);
	}
	recentTd.eq(3).text(`\${formatMailVolume} 중 \${formatTotal} 사용`);
	recentTd.eq(5).text(`\${res.respDate.substring(0,10)}(\${weekend}) \${res.respDate.substring(11,16)}`);
	recentTd.eq(6).text(res.respMemName);
    $("#reqMemName").text('');
    $("#reqDate").text('');
    $("#capacity").text('');
    $("#reqComent").html('');
    $("#urNoDiv").text('');
}

async function searchReq() {
	let capacityReqStart = $("#capacityReqStart").val();
	let capacityReqEnd = $("#capacityReqEnd").val();
	
	let response = await axios({
		url : "/admin/basic/searchReq.do",
		method : "post",
		data : {
			capacityReqStart : capacityReqStart,
			capacityReqEnd : capacityReqEnd
		},
		headers : {
			"Content-Type" : "application/json; charset=utf-8"
		}
	});
	
	let res = response.data;
	let searchReqHTML = "";
	for (var i = 0; i < res.length; i++) {
		let formatMailVolume = formatFileSize(res[i].mailVolume);
		let formatTotal = formatFileSize(res[i].totalFileSize);
		let weekend1 = getWeekend(res[i].reqDate);
		let weekend2 = "";
		if (res[i].respDate) {
			weekend2 = getWeekend(res[i].respDate);
		}
		searchReqHTML += `
							<tr class="urv" style="cursor: pointer;" data-no="\${res[i].urNo }">
								<td class="requestDate text-center">\${res[i].reqDate.substring(0,10)}(\${weekend1}) \${res[i].reqDate.substring(11,16)}</td>
								<td class="name text-center">\${res[i].reqMemName }</td>
						`;
						
		if (res[i].reqGb == 1) {
			searchReqHTML += `<td class="type text-center">메일 용량</td>`;
		}else if (res[i].reqGb == 2) {
			searchReqHTML += `<td class="type text-center">드라이브 용량</td>`;
		}
		
		searchReqHTML += `<td class="text-center"><span>\${formatMailVolume} 중 \${formatTotal} 사용</span></td>`;
		
		if (res[i].reqStatus == 0) {
			searchReqHTML += `<td class="status text-center p-0 align-middle"><span class="badge badge-subtle-secondary fs-9">대기</span></td>`;
		}else if (res[i].reqStatus == 1) {
			searchReqHTML += `<td class="status text-center p-0 align-middle"><span class="badge badge-subtle-success fs-9">완료</span></td>`;
		}else {
			searchReqHTML += `<td class="status text-center p-0 align-middle"><span class="badge badge-subtle-danger fs-9">거절</span></td>`;
		}
		
		if (res[i].respDate) {
			searchReqHTML += `<td class="refDate text-center">\${res[i].respDate.substring(0,10)}(\${weekend2}) \${res[i].respDate.substring(11,16)}</td>`;
		}else {
			searchReqHTML += `<td class="refDate text-center"></td>`;
		}
		
		searchReqHTML += `
								<td class="respName text-center">\${res[i].respMemName }</td>
								<td class="d-none">\${res[i].reqComent }</td>
								<td class="d-none">\${res[i].respReason }</td>
							</tr>							
						 `;
	}
	$("#capacityReqList").html(searchReqHTML);
	var logList = new List('tableExample2', {
		valueNames: ["requestDate","reqName","type","status","refDate","respName"],
		page: 10,
		pagination: true
	});
}
</script>