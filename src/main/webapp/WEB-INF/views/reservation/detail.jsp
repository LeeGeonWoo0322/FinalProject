<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<div class="mb-3">
		<h4>상세 예약 - ${assetVO.astName }</h4>
		<div id="resvNoDiv" class="d-none">${reservationVO.resvNo }</div>
	</div>
	<div style="width: 850px">
		<table class="w-100">
			<colgroup>
				<col width="170px">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th class="py-2 align-top">예약일</th>
					<td class="d-flex flex-row align-items-center d-gap gap-1 position-relative">
		  				<input type="text" id="datePicker1" class="form-control form-control-sm ps-4" readonly style="outline: none;box-shadow: none;font-size: 15px;width: 130px;cursor: default;">
	  					<div id="datePickerIcon1" style="position:absolute ;top: 2px;left: 5px"><img alt="" src="${pageContext.request.contextPath }/resources/icon/calendarIcon.png" style="width: 20px;height: 20px;"></div>
						<div class="position-relative">
							<input id="selectTime1" type="text" class="form-control form-control-sm align-middle" readonly="readonly" style="outline: none;box-shadow: none;font-size: 15px;width: 100px;" value="${reservationVO.startDate.substring(11,16) }">
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
							<input id="selectTime2" type="text" class="form-control form-control-sm align-middle" readonly="readonly" style="outline: none;box-shadow: none;font-size: 15px;width: 100px;" value="${reservationVO.endDate.substring(11,16) }">
							<ul id="selectTime2-ul" class="position-absolute border rounded-2 w-100 scrollbar p-0 d-none" style="height: 125px;z-index: 2000;background-color: #FFF;cursor: default;">
							    <c:forEach var="i" begin="0" end="47"> 
							        <fmt:formatNumber var="hour" value="${i div 2}" pattern="00"/> <!-- 시간 계산 -->
							        <fmt:formatNumber var="minute" value="${(i mod 2) * 30}" pattern="00"/> <!-- 분 계산 -->
							        <li class="${i == 47 ? '' : 'border-bottom'} border-end px-2" data-value="${hour}:${minute}" style="cursor: pointer;">${hour}:${minute}</li> <!-- 마지막 항목에서 border-bottom 제거 -->
							    </c:forEach>
							</ul>
						</div>
						<input type="checkbox" class="form-check-input ms-2" id="checkAllDay" <c:if test="${reservationVO.alldayYn eq 'Y' }">checked</c:if>>종일
					</td>
				</tr>
				<tr>
					<th class="py-2">예약자</th>
					<td>
				        <div class="d-flex flex-row flex-wrap d-gap gap-1 align-items-center">
				            <div class="border rounded-5 bg-info-subtle px-2">
				                <span class="text-900" style="font-size: 14px;">${reservationVO.memName } ${reservationVO.posName }</span>
				            </div>
			        	</div>	
					</td>
				</tr>
				<tr>
					<th class="py-2 align-top">
						참석자
						<button id="addAttendeeBtn" class="border-0 bg-200 ms-1 fs-10 text-700">
							<span class="fas fa-plus me-2 text-500 fs-11"></span>참석자 추가
						</button>
					</th>
					<td>
						<div class="d-flex flex-row flex-wrap d-gap gap-1">
							<c:if test="${not empty attendeeList }">
								<c:forEach items="${attendeeList }" var="attendee">
									<div class="border rounded-5 bg-info-subtle px-2">
						                <span class="text-900" style="font-size: 14px;">${attendee.memName } ${attendee.posName }</span>
						            </div>
								</c:forEach>
							</c:if>
						</div>
					</td>
				</tr>
				<tr>
					<th class="py-2 align-top">목적</th>
					<td><textarea rows="2" cols="50" class="form-control" id="reservationPerpose" style="width: 550px">${reservationVO.resvPrps }</textarea></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="d-flex flex-row justify-content-end mt-4 pe-4" style="width: 750px">
		<div><a class="btn btn-primary d-flex align-items-center me-2" id="returnToList">목록</a></div>
		<c:if test="${reservationVO.resvMember eq member.memNo }">
			<div><a class="btn btn-info d-flex align-items-center me-2" id="updateReservation">예약수정</a></div>
			<div><a class="btn btn-secondary d-flex align-items-center" id="cancleReservation">예약취소</a></div>
		</c:if>
	</div>
</div>

<script src='${pageContext.request.contextPath }/resources/dist/index.global.js'></script>
<script type="text/javascript">

let minStartTime = '${assetCategoryVO.acUseStart}';
let maxEndTime = '${assetCategoryVO.acUseEnd}';

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
    datePicker1.datepicker('setDate', new Date('${reservationVO.startDate}')); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
    
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
    datePicker2.datepicker('setDate', new Date('${reservationVO.endDate}')); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
    
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
    
    $("#returnToList").on("click", function () {
		location.href = "/reservation/main";
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
    
    $("#updateReservation").on("click", function () {
		let resvNo = $("#resvNoDiv").text();
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
    		url : "/reservation/updateReservation.do",
    		method : "post",
    		data : {
    			resvNo : resvNo,
    			startDate : startDateStr,
    			endDate : endDateStr,
    			alldayYn : alldayYn,
    			resvPrps : resvPrps
    		},
    		headers : {
    			"Content-Type" : "application/json; charset=utf-8"
    		}
    	}).then(function (response) {
    		sessionStorage.setItem('message', '예약이 수정되었습니다.');
    		location.href = "/reservation/main";
		});
	});
    
    $("#cancleReservation").on("click", function () {
    	let resvNo = $("#resvNoDiv").text();
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
	
});


</script>