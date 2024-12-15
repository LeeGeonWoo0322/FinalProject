<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
input[type="date"] {position : relative};
input[type="date"]::-webkit=clear-button,
input[type="date"]::-webkit-inner-spin-button {display:none;}
input[type="date"]::-webkit-calendar-picker-indicator {
      position : absolute;
      left : 0;
      top : 0;
      width : 100%;
      height : 100%;
      background : transparent;
      color : transparent;
      cursor : pointer;
}
#calMonth {
   border-width : 0;
   width : 130px;
   font-size: 20px;
   text-align: center;
}
.form-control:disabled {
	background-color: #FFF;
}
#ui-datepicker-div {
	z-index: 9999;
}

#datepicker:focus {
	outline: none;
}

.i_datepicker input {
	cursor: pointer;
}

.i_datepicker img {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	width: 16px;
	height: 16px;
	background: url(../img/ico_datepicker.svg) no-repeat center/cover;
}

.ui-widget-header {
	border: 0px solid #dddddd;
	background: #fff;
}

.ui-datepicker-calendar>thead>tr>th {
	font-size: 14px !important;
}

.ui-datepicker .ui-datepicker-header {
	position: relative;
	padding: 10px 0;
}

.ui-state-default, .ui-widget-content .ui-state-default,
	.ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover,
	html .ui-button.ui-state-disabled:active {
	border: 0px solid #c5c5c5;
	background-color: transparent;
	font-weight: normal;
	color: #454545;
	text-align: center;
}

.ui-datepicker .ui-datepicker-title {
	margin: 0 0em;
	line-height: 16px;
	text-align: center;
	font-size: 14px;
	padding: 0px;
	font-weight: bold;
}

.ui-datepicker {
	display: none;
	background-color: #fff;
	border-radius: 4px;
	margin-top: 10px;
	margin-left: 0px;
	margin-right: 0px;
	padding: 20px;
	padding-bottom: 10px;
	width: 300px;
	box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.1);
}

.ui-widget.ui-widget-content {
	border: 1px solid #eee;
}

#datepicker:focus>.ui-datepicker {
	display: block;
}

.ui-datepicker-prev, .ui-datepicker-next {
	cursor: pointer;
}

.ui-datepicker-next {
	float: right;
}

.ui-state-disabled {
	cursor: auto;
	color: hsla(0, 0%, 80%, 1);
}

.ui-datepicker-title {
	text-align: center;
	padding: 10px;
	font-weight: 100;
	font-size: 20px;
}

.ui-datepicker-calendar {
	width: 100%;
}

.ui-datepicker-calendar>thead>tr>th {
	padding: 5px;
	font-size: 20px;
	font-weight: 400;
}

.ui-datepicker-calendar>tbody>tr>td>a {
	color: #000;
	font-size: 12px !important;
	font-weight: bold !important;
	text-decoration: none;
}

.ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover {
	cursor: auto;
	background-color: #fff;
}

.ui-datepicker-calendar>tbody>tr>td {
	border-radius: 100%;
	width: 44px;
	height: 30px;
	cursor: pointer;
	padding: 5px;
	font-weight: 100;
	text-align: center;
	font-size: 12px;
}

.ui-datepicker-calendar>tbody>tr>td:hover {
	background-color: transparent;
	opacity: 0.6;
}

.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover,
	.ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus,
	.ui-button:hover, .ui-button:focus {
	border: 0px solid #cccccc;
	background-color: transparent;
	font-weight: normal;
	color: #2b2b2b;
}

/* .ui-widget-header .ui-icon { background-image: url('./btns.png'); }  */

/* .ui-icon-circle-triangle-e { background-position: -20px 0px; background-size: 36px; }

.ui-icon-circle-triangle-w { background-position: -0px -0px; background-size: 36px; }  */
.ui-datepicker-calendar>tbody>tr>td:first-child a {
	color: red !important;
}

.ui-datepicker-calendar>tbody>tr>td:last-child a {
	color: #0099ff !important;
}

.ui-datepicker-calendar>thead>tr>th:first-child {
	color: red !important;
}

.ui-datepicker-calendar>thead>tr>th:last-child {
	color: #0099ff !important;
}

.ui-state-highlight, .ui-widget-content .ui-state-highlight,
	.ui-widget-header .ui-state-highlight {
	border: 0px;
	background: #f1f1f1;
	border-radius: 50%;
	padding-top: 7px;
	padding-bottom: 8px;
}
ul{
	list-style: none;	
}
.fc .fc-scrollgrid{
	border-color: var(--falcon-gray-300);
}
.fc.fc-theme-standard td{
	border-color: var(--falcon-gray-300);
}
.fc.fc-theme-standard th{
	border-color: var(--falcon-gray-300);
}
.fc-event-title{
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
</style>
    
<div class="d-flex flex-column p-3" style="flex: 1 0 auto;">
    <div id="alertBox" style="position: fixed; top: 100px; left: 60%; transform: translateX(-50%); display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
    </div>
	<div class="mb-2">
		<h4>자산 예약 현황</h4>
		<select class="form-select form-select-sm" id="selectAssetCategory" style="width: 300px">
			<c:choose>
				<c:when test="${empty assetCategoryList }">
					<option>자산 카테고리가 없습니다.</option>
				</c:when>
				<c:otherwise>
					<c:forEach items="${assetCategoryList }" var="assetCategory">
						<option value="${assetCategory.acNo }">${assetCategory.acName }</option>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</select>
	</div>
	
	<div class="w-100" id="calendar"></div>
	
	<div>
		<h5 class="mb-3 mt-4">내 예약/대여 현황</h5>
		<div id="tableExample2" data-list='{"page":5,"pagination":true}'>
			<div class="table-responsive scrollbar" style="min-height: 375px">
				<table class="table table-bordered fs-9 mb-0">
		    		<colgroup>
		    			<col width="25%">
		    			<col width="25%">
		    			<col width="10%">
		    			<col width="25%">
		    			<col width="15%">
		    		</colgroup>
					<thead class="bg-200">
						<tr>
							<th class="text-center text-900">자산 카테고리</th>
							<th class="text-center text-900">자산명</th>
							<th class="text-center text-900">예약 종류</th>
							<th class="text-center text-900">예약 시간</th>
							<th class="text-center text-900">수정/취소</th>
						</tr>
					</thead>
					<tbody class="list">
						<c:choose>
							<c:when test="${empty myReservationList }">
								<tr>
									<td colspan="5" class="align-middle text-center p-5">예약목록이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${myReservationList }" var="reservation">
									<tr>
										<td class="align-middle py-1">${reservation.acName }</td>
										<td class="align-middle py-1">${reservation.astName }</td>
										<td class="align-middle text-center py-1">
											<c:if test="${reservation.alldayYn eq 'Y' }">종일예약</c:if>
											<c:if test="${reservation.alldayYn eq 'N' }">일반예약</c:if>
										</td>
										<td class="align-middle text-center py-1">${fn:substring(reservation.startDate,0,16) } ~ ${fn:substring(reservation.endDate,0,16) }</td>
										<td class="d-flex flex-row justify-content-center align-items-center align-middle py-1" style="border-left: none">
											<a href="/reservation/detailReservation.do?resvNo=${reservation.resvNo }" class="updateReservationBtn btn border d-flex align-items-center py-1 px-3 me-2">수정</a>
											<a class="cancleReservationBtn btn border d-flex align-items-center py-1 px-3" data-no="${reservation.resvNo }">취소</a>
										</td>
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
<!-- 예약 모달 -->
<div class="modal fade" id="reservationModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reservationModalHead" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0" style="width: 700px">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="reservationModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="reservationModalHead"></h4>
          <div id="astNoDiv" class="d-none"></div>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3 p-3">
			<table>
				<colgroup>
					<col width="100px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th class="py-2">예약일</th>
						<td class="d-flex flex-row align-items-center d-gap gap-1 position-relative">
			  				<input type="text" id="datePicker1" class="form-control form-control-sm ps-4" readonly style="outline: none;box-shadow: none;font-size: 15px;width: 130px;cursor: default;">
		  					<div id="datePickerIcon1" style="position:absolute ;top: 2px;left: 5px"><img alt="" src="${pageContext.request.contextPath }/resources/icon/calendarIcon.png" style="width: 20px;height: 20px;"></div>
							<div class="position-relative">
								<input id="selectTime1" type="text" class="form-control form-control-sm align-middle" readonly="readonly" style="outline: none;box-shadow: none;font-size: 15px;width: 100px;" value="00:00">
								<ul id="selectTime1-ul" class="position-absolute border rounded-2 w-100 scrollbar p-0 d-none" style="height: 125px;z-index: 2000;background-color: #FFF;cursor: default;">
								    <c:forEach var="i" begin="0" end="47"> 
								        <fmt:formatNumber var="hour" value="${i div 2}" pattern="00"/> <!-- 시간 계산 -->
								        <fmt:formatNumber var="minute" value="${(i mod 2) * 30}" pattern="00"/> <!-- 분 계산 -->
								        <li class="${i == 47 ? '' : 'border-bottom'} border-end px-2" data-value="${hour}:${minute}" style="cursor: pointer;">${hour}:${minute}</li> <!-- 마지막 항목에서 border-bottom 제거 -->
								    </c:forEach>
								</ul>
							</div>
							<span class="pt-1"> ~ </span>
							<input type="text" id="datePicker2" class="form-control form-control-sm ps-4" readonly style="outline: none;box-shadow: none;font-size: 15px;width: 130px;cursor: default;">
		  					<div id="datePickerIcon2" style="position:absolute ;top: 2px;left: 257px"><img alt="" src="${pageContext.request.contextPath }/resources/icon/calendarIcon.png" style="width: 20px;height: 20px;"></div>
							<div class="position-relative">
								<input id="selectTime2" type="text" class="form-control form-control-sm align-middle" readonly="readonly" style="outline: none;box-shadow: none;font-size: 15px;width: 100px;" value="00:00">
								<ul id="selectTime2-ul" class="position-absolute border rounded-2 w-100 scrollbar p-0 d-none" style="height: 125px;z-index: 2000;background-color: #FFF;cursor: default;">
								    <c:forEach var="i" begin="0" end="47"> 
								        <fmt:formatNumber var="hour" value="${i div 2}" pattern="00"/> <!-- 시간 계산 -->
								        <fmt:formatNumber var="minute" value="${(i mod 2) * 30}" pattern="00"/> <!-- 분 계산 -->
								        <li class="${i == 47 ? '' : 'border-bottom'} border-end px-2" data-value="${hour}:${minute}" style="cursor: pointer;">${hour}:${minute}</li> <!-- 마지막 항목에서 border-bottom 제거 -->
								    </c:forEach>
								</ul>
							</div>
							<input type="checkbox" class="form-check-input ms-2" id="checkAllDay">종일
						</td>
					</tr>
					<tr>
						<th class="py-2">예약자</th>
						<td>
					        <div class="d-flex flex-row flex-wrap d-gap gap-1 align-items-center">
					            <div class="border rounded-5 bg-info-subtle px-2">
					                <span class="text-900" style="font-size: 14px;">${member.memName } ${member.posName }</span>
					            </div>
				        	</div>	
						</td>
					</tr>
					<tr>
						<th class="py-2">목적</th>
						<td><input type="text" class="form-control form-control-sm" id="reservationPerpose"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2 pe-3" style="height: 50px;">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-2" id="reservationConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-secondary d-flex align-items-center px-2 py-0" id="reservationCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css" />
<script src="https://unpkg.com/@popperjs/core@2"></script>
<script src="https://unpkg.com/tippy.js@6"></script>
<script src='${pageContext.request.contextPath }/resources/dist/index.global.js'></script>
<script type="text/javascript">

let minStartTime = "";
let maxEndTime = "";
let recentDate = "";

if (sessionStorage.getItem('message')) {
	let message = sessionStorage.getItem('message');
	requiredAlert(message, isAlertVisible);
	sessionStorage.removeItem('message');
}

if (sessionStorage.getItem('acNo')) {
	let acNo = sessionStorage.getItem('acNo');
	$("#selectAssetCategory").val(acNo);
	sessionStorage.removeItem('acNo');
}

if (sessionStorage.getItem('reservationDate')) {
	let reservationDate = sessionStorage.getItem('reservationDate');
	
	getAssetTimeLine(new Date(reservationDate));
	sessionStorage.removeItem('reservationDate');
}else {
	getAssetTimeLine(new Date());
}

$(function () {
	
	let datePicker1 = $("#datePicker1");
	let datePicker2 = $("#datePicker2");

	datePicker1
    .datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
            ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });
    datePicker1.datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
    
    datePicker2
    .datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
            ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });
    datePicker2.datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
    
    // 첫 번째 날짜 선택기 아이콘 클릭 시 날짜 선택기 표시
    $("#datePickerIcon1").on("click", function (event) {
        event.stopPropagation(); // 이벤트 전파 방지
        datePicker1.datepicker("show");
    });

    // 두 번째 날짜 선택기 아이콘 클릭 시 날짜 선택기 표시
    $("#datePickerIcon2").on("click", function (event) {
        event.stopPropagation(); // 이벤트 전파 방지
        datePicker2.datepicker("show");
    });

    // 날짜 선택기 클릭 시 이벤트 전파 방지
    datePicker1.on("click", function (event) {
        event.stopPropagation();
        datePicker1.datepicker("show");
    });

    datePicker2.on("click", function (event) {
        event.stopPropagation();
        datePicker2.datepicker("show");
    });
    
    // selectTime1 클릭 시 ul 토글
    $("#selectTime1").on("click", function () {
        $("#selectTime1-ul").removeClass("d-none");
        $("#selectTime2-ul").removeClass("d-none");
        $("#selectTime2-ul").addClass("d-none"); // 다른 ul을 닫기
    });

    // selectTime2 클릭 시 ul 토글
    $("#selectTime2").on("click", function () {
        $("#selectTime1-ul").removeClass("d-none");
        $("#selectTime2-ul").removeClass("d-none");
        $("#selectTime1-ul").addClass("d-none"); // 다른 ul을 닫기
    });

    // selectTime1-ul 항목 클릭 시 값 설정
    $("#selectTime1-ul li").on("click", function () {
        var selectedValue = $(this).data("value");
        $("#selectTime1").val(selectedValue);
        $("#selectTime1-ul").addClass("d-none"); // ul 닫기
    });

    // selectTime2-ul 항목 클릭 시 값 설정
    $("#selectTime2-ul li").on("click", function () {
        var selectedValue = $(this).data("value");
        $("#selectTime2").val(selectedValue);
        $("#selectTime2-ul").addClass("d-none"); // ul 닫기
    });

    // ul 외부 클릭 시 ul 닫기
    $(document).on("click", function (event) {
        if (!$(event.target).closest('#selectTime1').length) {
            $("#selectTime1-ul").addClass("d-none");
        }
        if (!$(event.target).closest('#selectTime2').length) {
            $("#selectTime2-ul").addClass("d-none");
        }
    });
    
    $(".cancleReservationBtn").on("click", function () {
    	let resvNo = $(this).data("no");
    	axios({
    		url : "/reservation/cancleReservation.do",
    		method : "post",
    		data : {
    			resvNo : resvNo,
    		},
    		headers : {
    			"Content-Type" : "application/json; charset=utf-8"
    		}
    	}).then(function (response) {
    		sessionStorage.setItem('message', '예약이 취소되었습니다.');
    		location.href = "/reservation/main";
		});
	});
    
    $("#checkAllDay").on("click", function () {
    	console.log("AA");
		if ($(this).is(":checked")) {
			$("#selectTime1").addClass("d-none");
			$("#selectTime2").addClass("d-none");
			$("#datePickerIcon2").css("left", "157px");
		}else {
			$("#selectTime1").removeClass("d-none");
			$("#selectTime2").removeClass("d-none");
			$("#datePickerIcon2").css("left", "257px");
		}
	});
    
    $("#selectAssetCategory").on("change", function () {
    	getAssetTimeLine();
	});
    
    $("#reservationCancle"), $("#reservationModalCloseBtn").on("click", function () {
    	initReservationModal();
	});
    
    $("#reservationConfirm").on("click", function () {
    	let astNo = $("#astNoDiv").text();
    	let acNo = $("#selectAssetCategory").val();
    	let alldayYn = $("#checkAllDay").is(":checked") ? "Y" : "N";
    	let resvPrps = $("#reservationPerpose").val();
    	
    	let startDate = $("#datePicker1").datepicker('getDate');
    	let year1 = startDate.getFullYear();
    	let month1 = String(startDate.getMonth() + 1).padStart(2, '0');
    	let day1 = String(startDate.getDate()).padStart(2, '0');
    	let startTime = $("#selectTime1").val() + ":00";
    	if (alldayYn == "Y") {
			startTime = minStartTime;			
		}
    	let startDateStr = year1 + "-" + month1 + "-" + day1 + " " + startTime;

    	let endDate = $("#datePicker2").datepicker('getDate');
    	let year2 = endDate.getFullYear();
    	let month2 = String(endDate.getMonth() + 1).padStart(2, '0');
    	let day2 = String(endDate.getDate()).padStart(2, '0');
    	let endTime = $("#selectTime2").val() + ":00";
    	if (alldayYn == "Y") {
			endTime = maxEndTime;
		}
    	let endDateStr = year2 + "-" + month2 + "-" + day2 + " " + endTime;
    	
    	axios({
    		url : "/reservation/insertReservation.do",
    		method : "post",
    		data : {
    			astNo : astNo,
    			resvMember : ${member.memNo},
    			startDate : startDateStr,
    			endDate : endDateStr,
    			alldayYn : alldayYn,
    			resvPrps : resvPrps
    		},
    		headers : {
    			"Content-Type" : "application/json; charset=utf-8"
    		}
    	}).then(function (response) {
    		$("#reservationModal").modal("hide");
    		initReservationModal();
    		sessionStorage.setItem('message', '예약이 완료되었습니다.');
    		sessionStorage.setItem('reservationDate', startDate);
    		sessionStorage.setItem('acNo', acNo);
    		location.reload();
		});
	});
	
});

function openReservationBtn() {
	$("#reservationModal").modal("show");
}

function getAssetTimeLine(reservationDate) {
    let assetCategoryNo = $("#selectAssetCategory").val();
    axios({
        url: "/reservation/getAssetTimeLine.do",
        method: "post",
        data: {
            acNo: assetCategoryNo
        },
        headers: {
            "Content-Type": "application/json; charset=utf-8"
        }
    }).then(function (response) {
    	let category = response.data[0];
        let assetList = response.data[1]; // 서버로부터의 응답
        minStartTime = category.acUseStart;
        maxEndTime = category.acUseEnd;
        let calendarHeight = 0;
        if (assetList.length > 1) {
	        calendarHeight = 120 + assetList.length * 40;
		}else {
			calendarHeight = 120;
		}
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'resourceTimeline',
            themeSystem: 'bootstrap5',
            locale: 'ko',
            timeZone: 'local',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: ''
            },
            titleFormat: function (date) {
                // date.date를 Date 객체로 변환
                var currentDate = new Date(date.date.year, date.date.month, date.date.day);

                // 연도, 월, 일 추출
                var year = currentDate.getFullYear();
                var month = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 +1
                var day = currentDate.getDate();

                // 요일 추출
                var options = { weekday: 'long', year: 'numeric', month: 'numeric', day: 'numeric', locale: 'ko-KR' };
                var weekday = new Intl.DateTimeFormat('ko-KR', { weekday: 'short' }).format(currentDate);

                // "2024년 11월 8일 (금)" 형태로 포맷
                return `\${year}년 \${month}월 \${day}일 (\${weekday})`;
            },
            height: calendarHeight,
            nowIndicator : true,
            now : reservationDate,
            weekends: false,
            slotMinTime : category.acUseStart,
            slotMaxTime : category.acUseEnd,
            slotLabelFormat : {
	           	hour: '2-digit',
	           	minute: '2-digit',
            },
            eventMaxStack : 1,
            resourceAreaColumns: [
                {
                    field: 'fname',
                    headerContent: '자산명',
                    width: '50px'
                }
            ],
            resources: assetList.map(asset => ({
                id: asset.astNo,    // 자산 ID
                fname: asset.astName // 자산 이름
            })),
            resourceAreaWidth: '150px',
            eventMaxStack: 1,
            editable : true,
            selectable : true,
            
            events: "/reservation/getReservationList.do",
            
            select: function(info) {
                var calendar = info.view.calendar;
                var currentEvents = calendar.getEvents(); // 현재 이벤트 목록 가져오기

                // 선택한 시간
                var selectedStart = info.start;
                var selectedEnd = info.end;
                var selectedResourceId = info.resource.id;

                // 선택한 자산의 겹치는 이벤트 체크
				var hasConflict = currentEvents.some(event => {
				    return (
				        event.extendedProps.astNo == selectedResourceId && (selectedStart < event.end && selectedEnd > event.start) // 겹치는 조건
				    );
				});

                if (hasConflict) {
                    requiredAlert("선택한 시간에 이미 예약된 이벤트가 있습니다.", isAlertVisible);
                    return; // 예약을 진행하지 않음
                } else {
                    let now = new Date();
                    let date1 = new Date(info.startStr);
                    var hours1 = String(date1.getHours()).padStart(2, '0');
                    var minutes1 = String(date1.getMinutes()).padStart(2, '0');
                    let date2 = new Date(info.endStr);
                    var hours2 = String(date2.getHours()).padStart(2, '0');
                    var minutes2 = String(date2.getMinutes()).padStart(2, '0');

                    if (now > date2) {
                        requiredAlert("지난 시간에는 예약이 불가능합니다.", isAlertVisible);
                        return false;
                    } else {
                        $("#datePicker1").datepicker('setDate', info.start);
                        $("#datePicker2").datepicker('setDate', info.end);
                        $("#selectTime1").val(hours1 + ":" + minutes1);
                        $("#selectTime2").val(hours2 + ":" + minutes2);
                        $("#astNoDiv").text(info.resource.id);
                        $("#reservationModalHead").text("예약 - " + info.resource.extendedProps.fname);
                        $("#reservationModal").modal("show");
                    }
                }
            },
            
            // 이벤트 클릭 시 정보 얻기
            eventClick: function(info) {
                // 클릭한 이벤트의 정보
                var eventId = info.event.id; // 이벤트 ID
                location.href="/reservation/detail.do?resvNo=" + eventId;
            },

            eventDrop: function(info) {
            	let resvNo = info.event.id;
                // 현재 사용자의 ID (예시로 'currentUserId'로 지정)
                let currentUserId = ${member.memNo};

                // 이벤트의 예약자 ID를 가져옵니다.
                let eventOwnerId = info.event.extendedProps.resvMember; // 예약자 ID가 저장된 위치

                // 예약자가 나인지 확인
                if (eventOwnerId !== currentUserId) {
                    alert("이 예약을 변경할 권한이 없습니다."); // 권한이 없을 경우 경고
                    info.revert(); // 변경 이전 상태로 되돌리기
                    return; // 함수 종료
                }
                
                let newAstNo = info.newResource ? info.newResource.id : info.event.extendedProps.astNo;
                let startDateStr = info.event.startStr.substring(0,19).replace("T", " ");
                let endDateStr = info.event.endStr.substring(0,19).replace("T", " ");

            	axios({
            		url : "/reservation/updateReservationByDrop.do",
            		method : "post",
            		data : {
            			resvNo : resvNo,
            			astNo : newAstNo,
            			startDate : startDateStr,
            			endDate : endDateStr,
            		},
            		headers : {
            			"Content-Type" : "application/json; charset=utf-8"
            		}
            	}).then(function (response) {
            		requiredAlert("예약이 수정되었습니다.", isAlertVisible);
        		});
            },
            eventDidMount: function(info) {
                // Tippy.js로 툴팁 설정
                tippy(info.el, {
                    content: info.event.extendedProps.description,
                    placement: 'top', // 툴팁 위치
                    theme: 'light', // 툴팁 테마
                });
            }
        });
        calendar.render();
        $(".fc-license-message").addClass("d-none");
    }).catch(function (error) {
        console.error('Error fetching asset timeline:', error);
    });
}

function initReservationModal() {
	$("#datePicker1").datepicker('setDate', 'today');
	$("#datePicker2").datepicker('setDate', 'today');
	$("#selectTime1").val("00:00");
	$("#selectTime2").val("00:00");
	$("#checkAllDay").prop("checked", false);
	$("#reservationPerpose").val("");
}

</script>