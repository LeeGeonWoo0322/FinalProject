<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	input[type="month"] {position : relative};
 	input[type="month"]::-webkit=clear-button,
 	input[type="month"]::-webkit-inner-spin-button {display:none;}
	input[type="month"]::-webkit-calendar-picker-indicator {
			position : absolute;
			left : 0;
			top : 0;
			width : 100%;
			height : 100%;
			background : transparent;
			color : transparent;
			cursor : pointer;
	}
	#choiceMon {
		border-width : 0;
		width : 130px;
		font-size: 20px;
		text-align: center;
	}
	.table caption{
		caption-side : top;
	}
</style>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<input type="hidden" value="${member.deptNo}" id="userDept">
	<div class="d-flex flex-column w-100 p-3 m-3 scrollbar" style="text-align: center;">
		<h1 style="text-align: center;">부서 근태 통계</h1>
		<div class="d-flex flex-row justify-content-center" id="cur_date">
			<span id="prevMonth"><i class="bi bi-caret-left-fill fs-6"></i></span>
			<input type="month" id="choiceMon" name="choiceMon" class="form-control search-input fuzzy-search w-25">
			<span id="nextMonth"><i class="bi bi-caret-right-fill fs-6"></i></span>
		</div>
		<table class="table table-bordered border-500 fs-10 mb-0">
			<thead>
				<tr>
					<th>지각</th>
					<th>결근</th>
					<th>휴가</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="tardy">0</td>
					<td id="mooM">0</td>
					<td id="vacaM">0</td>
				</tr>
			</tbody>
		</table>
		<hr>
		<div id="deptMemberList" data-list='{"valueNames":["name","deptName","date","intime","outtime","moo","vaca"], "page":5,"pagination":true}'>
			  <div class="table-responsive scrollbar">
			    <table class="table table-bordered border-500 fs-10 mb-0">
			      <thead class="bg-200">
			        <tr>
			          <th class="text-900" data-sort="name">이름</th>
			          <th class="text-900" data-sort="deptName">부서명</th>
			          <th class="text-900" data-sort="date">날짜</th>
			          <th class="text-900" data-sort="intime">출근</th>
			          <th class="text-900" data-sort="outtime">퇴근</th>
			          <th class="text-900" data-sort="moo">결근</th>
			          <th class="text-900" data-sort="vaca">휴가</th>
			        </tr>
			      </thead>
			      <tbody class="list" id="deptMemList">
			      	<tr>
			      		<td>no-data</td>
			      		<td></td>
			      		<td></td>
			      		<td></td>
			      		<td></td>
			      		<td></td>
			      		<td></td>
			      	</tr>
			      </tbody>
			    </table>
			  </div>
			  
			  <!-- 페이징 -->
			  <div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			    <ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"> </span></button>
			  </div>
		</div>
	</div>
	
	<!-- 모달창 시작 -->
	<div class="modal fade" id="deptModify" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<table class="table table-bordered fs-10 mb-0">
	      		<caption><h3>출근 시간 수정</h3></caption>
	      		<tbody>
	      			<tr>
	      				<td>기존 시간 </td>
	      				<td><input type="time" id="modalCurTime" readonly>
		      				<input type="hidden" id="modalAttdNo">
		      				<input type="hidden" id="modalCurDate">
		      				<input type="hidden" id="modalMemNo">
	      			</tr>
	      			<tr>
	      				<td>변경 시간</td>
	      				<td><input type="time" id="modalUpdateTime"></td>
	      			</tr>
	      			<tr>
	      				<td>사유</td>
	      				<td><input type="text" id="modalCont"></td>
	      			</tr>
	      		</tbody>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-info" type="button" data-bs-dismiss="modal">취소</button>
	        <button class="btn btn-info" type="button" id="workUpdate" data-bs-dismiss="modal"> 수정 </button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	
	<!-- 모달창 시작 -->
	<div class="modal fade" id="deptModify2" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<table class="table table-bordered fs-10 mb-0">
	      		<caption><h3>퇴근 시간 수정</h3></caption>
	      		<tbody>
	      			<tr>
	      				<td>기존 시간</td>
	      				<td><input type="time" id="modalCurTime2" readonly> 
		      				<input type="hidden" id="modalAttdNo2">
		      				<input type="hidden" id="modalCurDate2">
		      				<input type="hidden" id="modalMemNo2">
	      			</tr>
	      			<tr>
	      				<td>변경 시간</td>
	      				<td><input type="time" id="modalUpdateTime2"></td>
	      			</tr>
	      			<tr>
	      				<td>사유</td>
	      				<td><input type="text" id="modalCont2"></td>
	      			</tr>
	      		</tbody>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-info" type="button" data-bs-dismiss="modal">취소</button>
	        <button class="btn btn-info" type="button" id="lWorkUpdate" data-bs-dismiss="modal"> 수정 </button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
$(function () {
	var userNo = $("#userNo").val();
	var userName = $("#userName").val();
	var userDept = $("#userDept").val();
	
	serverTime();
	printDeptList();
	deptVacaTotal();
	
	$("#prevMonth").on("click",function(){
		var prevMon = $("#choiceMon").val().split("-",2)
		prevMon[1] = prevMon[1]-1
		
		if (prevMon[1] == "00"){
			prevMon[0] = prevMon[0]-1
			prevMon[1] = 12
		}
		
		if (prevMon[1] < 10){
			prevMon[1] = `0\${prevMon[1]}`
		}
		
		prevMon = `\${prevMon[0]}-\${prevMon[1]}`
		
		$("#choiceMon").val(prevMon)
		printDeptList()
	})
		
	$("#nextMonth").on("click",function(){
		var prevMon = $("#choiceMon").val().split("-",2)
		prevMon[1] = parseInt(prevMon[1])+1
		
		if(prevMon[1] > 12){
			prevMon[0] = parseInt(prevMon[0])+1
			prevMon[1] = 1
		}
		
		if (prevMon[1] < 10){
			prevMon[1] = `0\${prevMon[1]}`
		}
		
		prevMon = `\${prevMon[0]}-\${prevMon[1]}`
		
		$("#choiceMon").val(prevMon)
		printDeptList()
	})
	
	function serverTime(){
		// 서버시간 가져오기
		var xmlHttpRequest;
		if(window.XMLHttpRequest){// code for Firefox, Mozilla, IE7, etc.
		    xmlHttpRequest = new XMLHttpRequest();
		}else if(window.ActiveXObject){// code for IE5, IE6
		    xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}else{
		    return;
		}

		xmlHttpRequest.open('HEAD', window.location.href.toString(), false);
		xmlHttpRequest.setRequestHeader("ContentType", "text/html");
		xmlHttpRequest.send('');

		var serverDate = xmlHttpRequest.getResponseHeader("Date");
		// 서버시간 가져오기 끝
		
		const d = new Date(serverDate);
		const month = String(d.getMonth()+1).padStart(2,"0");
		const year = String(d.getFullYear()).padStart(2,"0");
		
		// 현재 달 입력
		var curDate = `\${year}-\${month}`
		
		$("#choiceMon").val(curDate);
	}
	
	// 출근 시간 클릭시 모달창에 데이터 입력
	$("#deptMemList").on("click",'.inTime',function(){
		console.log()
		var modalCurTime = $(this).text()
		var modalAttdNo = $(this).data("attd-no")
		var modalCurDate = $(this).data("attd-date")
		var modalMemNo = $(this).data("mem-no")
		// 기존 시간 자동 입력
		$("#modalCurTime").val(modalCurTime)
		// input type hidden에 attdno 입력
		$("#modalAttdNo").val(modalAttdNo)
		// attendanceDate 기존 날짜
		$("#modalCurDate").val(modalCurDate)
		// 변경될 멤버의 번호
		$("#modalMemNo").val(modalMemNo)
		
	})
	
	// 퇴근 시간 클릭시 모달창에 데이터 입력
	$("#deptMemList").on("click",'.outTime',function(){
		var modalCurTime2 = $(this).text()
		var modalAttdNo2  = $(this).data("attd-no")
		var modalCurDate2 = $(this).data("attd-date")
		var modalMemNo2 = $(this).data("mem-no")
		// 기존 시간 자동 입력
		$("#modalCurTime2").val(modalCurTime2)
		// input type hidden에 attdno 입력
		$("#modalAttdNo2").val(modalAttdNo2)
		// attendanceDate 기존 날짜
		$("#modalCurDate2").val(modalCurDate2)
		// 변경될 멤버의 번호
		$("#modalMemNo2").val(modalMemNo2)
	})
	
	// 출근 시간 수정버튼
	$("#workUpdate").on("click",function(){
		var memNo = $("#modalMemNo").val()
		var cMemNo = $("#userNo").val()
		var modalCurTime = $("#modalCurTime").val()
		var modalCurDate = $("#modalCurDate").val().split(" ",1)
		var modalAttdNo = $("#modalAttdNo").val()
		var modalUpdateTime = $("#modalUpdateTime").val()+":00"
		var modalCont = $("#modalCont").val()
		var stateType = "출근"
		
		var stateDate = modalCurDate[0] + " " + modalCurTime
		var atstateDate = modalCurDate[0] + " " + modalUpdateTime
		
		$.ajax({
			url : "/workState/updWork",
			method : "post",
			data : JSON.stringify({
				memNo : memNo,
				changeMemno : cMemNo,
				stateDate : stateDate,
				stateType : stateType,
				atstateDate : atstateDate,
				atstateCont : modalCont
			}),
			contentType : "application/json; charset=utf-8",
			success: function(res){
				console.log(res)				
			}
		})	
		
		$.ajax({
			url : "/attend/updAttend",
			method : "post",
			data : JSON.stringify({
				inTime : modalUpdateTime,
				attendanceNo : modalAttdNo,
			}),
			contentType : "application/json; charset=utf-8",
			success: function(res){
				console.log(res);
				console.log(modalCurDate[0]);
				
				overTimeUpdate(memNo, modalCurDate[0]);
				location.reload();
			}
		})
	})
	
	// 퇴근 시간 수정
	$("#lWorkUpdate").on("click",function(){
		var memNo = $("#modalMemNo2").val()
		var cMemNo = $("#userNo").val()
		var modalCurTime = $("#modalCurTime2").val()
		var modalCurDate = $("#modalCurDate2").val().split(" ",1)
		var modalAttdNo = $("#modalAttdNo2").val()
		var modalUpdateTime = $("#modalUpdateTime2").val()+":00"
		var modalCont = $("#modalCont2").val()
		var stateType = "퇴근"
		
		var stateDate = modalCurDate[0] + " " + modalCurTime
		var atstateDate = modalCurDate[0] + " " + modalUpdateTime
		
		$.ajax({
			url : "/workState/updWork",
			method : "post",
			data : JSON.stringify({
				memNo : memNo,
				changeMemno : cMemNo,
				stateDate : stateDate,
				stateType : stateType,
				atstateDate : atstateDate,
				atstateCont : modalCont
			}),
			contentType : "application/json; charset=utf-8",
			success: function(res){
				console.log(res)
				
			}
		})
		
		$.ajax({
			url : "/attend/updAttend",
			method : "post",
			data : JSON.stringify({
				outTime : modalUpdateTime,
				attendanceNo : modalAttdNo,
			}),
			contentType : "application/json; charset=utf-8",
			success: function(res){
				console.log(res)
				
				overTimeUpdate(memNo, modalCurDate[0]);
				location.reload();
			}
		})
	})
	
	// 누적근무시간 계산
		function overTimeUpdate(getMemNo, getAttendDate) {
			$.ajax({
				url : "/attend/overTimeUpd",
				method : "post",
				data : JSON.stringify({
					memNo : getMemNo,
					attendanceDate : getAttendDate
				}),
				contentType : "application/json; charset=utf-8",
				success : function (attendance){
					let gtArr = [];		// 출근시간 배열
					let ltArr = [];		// 퇴근시간 배열
					let overArr = [];	// 기존 주간 누적 근무시간 배열
					let otArr = [];		// 근무시간 계산을 위한 빈 배열
					let moverArr = [];	// 기존 movertimeTime
					
					// DB에서 가져오는 값
					let gTime = attendance.inTime;					// 출근시간 
					let lTime = attendance.outTime;					// 퇴근시간
					let oTime = attendance.movertimeTime;			// 누적근무시간
					let movertimeTime = attendance.movertimeTime;	// 기존 movertimeTime
					
					console.log(gTime)
					console.log(lTime)
					console.log(oTime)
					console.log(movertimeTime)
					
					// 0:0:0 형식으로 된 시간 형식을 split을 통해 나눠 배열형식으로 바꿈
					gtArr = gTime.split(":");
					ltArr = lTime.split(":");
					overArr = oTime.split(":");
					moverArr = movertimeTime.split(":");
					
					// 출근시간과 퇴근시간을 이용해 누적 근무시간 계산을 위한 배열에 값을 넣는다.
					// [0]=h, [1]=m, [2]=s
					otArr[0] = ltArr[0] - gtArr[0] 
					otArr[1] = ltArr[1] - gtArr[1]
					otArr[2] = ltArr[2] - gtArr[2]
					
					// ex) 출근 1:30:0, 퇴근 2:20:0, 누적 근무시간 0:50:0
					// 위와 같은 경우 계산
					if (otArr[2] < 0){
						otArr[1] = otArr[1] - 1
						otArr[2] = (60 - gtArr[2]) + parseInt(ltArr[2])
					}
					
					// ex) 출근 1:0:30, 퇴근 1:1:20, 누적 근무 시간 0:0:50
					// 위와 같은 경우 계산
					if (otArr[1] < 0){
						otArr[0] = otArr[0] - 1
						otArr[1] = (60 - gtArr[1]) + parseInt(ltArr[1])
					}
					
					
					overArr[0] = otArr[0] - parseInt(moverArr[0]) 
					overArr[1] = otArr[1] - parseInt(moverArr[1])
					overArr[2] = otArr[2] - parseInt(moverArr[2]) 

					console.log(overArr[0])
					console.log(overArr[1])
					console.log(overArr[2])
					
					moverArr[0] = parseInt(moverArr[0]) + overArr[0]
					moverArr[1] = parseInt(moverArr[1]) + overArr[1]
					moverArr[2] = parseInt(moverArr[2]) + overArr[1]
					
					console.log(moverArr[0])
					console.log(moverArr[1])
					console.log(moverArr[2])
					
					// 초 단위 먼저 계산해야함
					if (overArr[2] >= 60){
						overArr[1] += 1
						overArr[2] -= 60
					}
					
					if (overArr[1] >= 60){
						overArr[0] += 1
						overArr[1] -= 60
					}
					
					if (otArr[1] < 10) {
						otArr[1] = "0" + otArr[1]
					}
					
					if(otArr[2] < 10) {
						otArr[2] = "0" + otArr[2]
					}
					
					if (overArr[1] < 10) {
						overArr[1] = "0" + overArr[1]
					}
					
					if(overArr[2] < 10) {
						overArr[2] = "0" + overArr[2]
					}
					oTime = `\${moverArr[0]}:\${moverArr[1]}:\${moverArr[2]}`
					otArr = `\${otArr[0]}:\${otArr[1]}:\${otArr[2]}`
					console.log("#################",oTime);
					console.log("#################",otArr);	//movertimeTime
					updOverTime(getMemNo, getAttendDate, oTime, otArr);
				}
			})
		}
	
	// 누적 주간근무시간 업데이트
	function updOverTime(getMemNo, getAttendDate, oTime, otArr) {
		$.ajax({
			url : "/attend/updOverTime",
			method : "post",
			data : JSON.stringify({
				memNo : getMemNo,
				attendanceDate : getAttendDate,
				overtimeTime : oTime,
				monoverTime : otArr
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance){
				console.log(attendance);
			}
		})
	}
	
	
	// 근태통계 리스트 가져오기
	function printDeptList() {
		var curDate = $("#choiceMon").val().replace("-","/")
		
		console.log(curDate)
		$.ajax({
			url : "/attend/totalDeptList", 
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				deptNo : userDept,
				attendanceDate : curDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(attendance){
				var printDeptAttend
				var tardy = 0;			// 지각 수
				var moo = 0;			// 휴가 수
				console.log(attendance)
				console.log(attendance.length)
				if(attendance.length == 0){
					printDeptAttend = 
						`
							<tr>
								<td colspan = "7">내역이 없습니다.</td>
							</tr>
						`
					$("#deptMemList").html(printDeptAttend);
				}
				$.each(attendance, function(index, res){
					console.log(res.memName)
					
					res.attendanceDate = res.attendanceDate.split(" ",1)
					if(res.inTime != null){
					printDeptAttend += 
						`
							<tr>
								<td class="name">\${res.memName}</td>
								<td class="deptName">\${res.deptName}</td>
								<td class="date">\${res.attendanceDate}</td>
								<td style='cursor:pointer;' data-bs-toggle="modal" data-bs-target="#deptModify" class="inTime" data-attd-no="\${res.attendanceNo}" data-attd-date="\${res.attendanceDate}" data-mem-no="\${res.memNo}">\${res.inTime}</td>
								<td style='cursor:pointer;' data-bs-toggle="modal" data-bs-target="#deptModify2" class="outTime" data-attd-no="\${res.attendanceNo}" data-attd-date="\${res.attendanceDate}" data-mem-no="\${res.memNo}">\${res.outTime}</td>
								<td class="moo">x</td>
								<td class="vaca">x</td>
							</tr>
						`
					} else {
						printDeptAttend += 
							`
								<tr>
									<td class="name">\${res.memName}</td>
									<td class="deptName">\${res.deptName}</td>
									<td class="date">\${res.attendanceDate}</td>
									<td data-bs-toggle="modal" data-bs-target="#deptModify" class="inTime" data-attd-no="\${res.attendanceNo}" data-attd-date="\${res.attendanceDate}" data-mem-no="\${res.memNo}"></td>
									<td data-bs-toggle="modal" data-bs-target="#deptModify2" class="outTime" data-attd-no="\${res.attendanceNo}" data-attd-date="\${res.attendanceDate}" data-mem-no="\${res.memNo}"></td>
									<td class="moo">o</td>
									<td class="vaca">x</td>
								</tr>
							`
					}
					if(res.inTime != null){
						var hour = res.inTime.split(":");
						if(parseInt(hour[0]) >= 9){
							tardy = tardy + 1
						}
						$("#tardy").html(tardy);
					} else {
						moo = moo + 1
						$("#mooM").html(moo);
					}
					$("#deptMemList").html(printDeptAttend);
				})
				var deptMemList = new List('deptMemberList', {
					  valueNames: ['name'],
					  page: 10,
					  pagination: true
					});
				}
		})
	}
	
	function deptVacaTotal(){
		var curDate = $("#choiceMon").val().replace("-","/")
		$.ajax({
			url : "/vacation/deptVaca",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				deptNo : userDept,
				attendanceDate : curDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res)
				$("#vacaM").html(res)
			}
		})
	}
	
})
</script>