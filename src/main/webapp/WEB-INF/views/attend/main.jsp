<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<style>
	.table caption{
		caption-side : top;
	}
	
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
</style>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<div class="d-flex flex-column w-100 scrollbar">
		<h1 style="text-align: center;">내 근태 현황</h1>
		
		<div class="d-flex flex-row justify-content-center" id="cur_date">
			<span id="prevMonth"><i class="bi bi-caret-left-fill fs-6"></i></span>
			<input type="month" id="choiceMon" name="choiceMon">
			<span id="nextMonth"><i class="bi bi-caret-right-fill fs-6"></i></span>
		</div>
		<!-- 근태 테이블 -->
		<div>
			<div id="tableExample1" class="d-flex flex-column p-3 m-2" style="text-align: center;">
				  <div class="table-responsive scrollbar" style="flex: 1;">
				    <table class="table table-bordered border-500 fs-10 mb-0 p-2" style="border-collapse: collapse;">
				      <thead class="bg-200">
				        <tr>
				          <th class="text-900" style="width: 120px">이번주 누적</th>
				          <th class="text-900" style="width: 120px">이번주 초과</th>
				          <th class="text-900" style="width: 120px">이번주 잔여</th>
<!-- 				          <th class="text-900" style="width: 300px">이번달 누적</th> -->
				          <th class="text-900" style="width: 120px">이번달 연장</th>
				        </tr>
				      </thead>
				      <tbody class="list">
				        <tr>
				          <td class="glSumTime"></td>
				          <td id="over">00:00:00</td>
				          <td id="left">00:00:00</td>
<!-- 				          <td class="monSumTime"></td> -->
				          <td>00:00:00</td>
				        </tr>
				      </tbody>
				    </table>
				  </div>
			</div>
		</div>
		<!-- 주차별 리스트 -->
		<div id="weekAttend" class="row g-3 mb-2 p-2" style="text-align: center;">
		주차별 근무 현황
		</div>
		<!-- 근무이력 상세보기 -->
		<div id="selectAtList" class="d-flex flex-column p-3 m-2" style="display:none;">
			<table class="table table-bordered border-500 fs-10">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead class="bg-200">
					<tr>
						<th class="text-800" colspan="6" style="text-align: center;">근무 기록</th>
					</tr>
				</thead>
				<tbody id="selAtBody" style='cursor:pointer; text-align:center;'>
				
				</tbody>
			</table>
		</div>
		<!-- 변경이력 -->
		<div>
			<div id="tableExample3" class="d-flex flex-column p-2 m-3">
				  <div class="table-responsive scrollbar" style="flex: 1;">
				    <table class="table table-bordered border-500 fs-10 mb-0 p-2">
				      <thead class="bg-200">
				        <tr>
				          <th class="text-900=" style="width: 100%">변경이력</th>
				        </tr>
				      </thead>
				      <tbody id="atList">
				        <tr>
				          <td>
				          	<span id="updName"></span><span id="updPos"></span><br>
				          	<span id="updDate">변경이력이 존재하지 않습니다.</span> <span id="updType"></span> <span id="updAtdate"></span> <span id="updAttype"></span><br>
				          	<span id="updCont"></span>
				          	<span id="changeMem"></span>
				          </td>
				        </tr>
				      </tbody>
				    </table>
				  </div>
			</div>
	
	<!-- 모달창 시작 -->
	<div class="modal fade" id="error-modal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<table class="table table-bordered fs-10 mb-0">
	      		<caption><h3>상태 상세</h3></caption>
	      		<tbody>
	      			<tr>
	      				<td>일시</td>
	      				<td colspan="3"> <input type="date" id="modalDate" readonly> <input type="time" id="modalTime">
	      				<input type="hidden" id="atstateNo"> </td>
	      			</tr>
	      			<tr>
	      				<td>상태</td>
	      				<td> 
	      					<select id="updWorkState">
		      					<option id="3" value="work">업무</option>
							    <option id="4" value="workComp">업무종료</option>
							    <option id="5" value="workOut">외근</option>
							    <option id="6" value="busiTrip">출장</option>
							    <option id="7" value="busiTrip">자리비움</option>
	      					</select>
	      				</td>
	      				<td>사유</td>
	      				<td> <input type="text" id="modalCont"> </td>
	      			</tr>
	      		</tbody>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-primary" type="button" data-bs-dismiss="modal">취소</button>
	        <button class="btn btn-primary" type="button" id="atstateUpdate" data-bs-dismiss="modal"> 수정 </button>
	        <button class="btn btn-danger" type="button" id="atstateDelete" data-bs-dismiss="modal"> 삭제 </button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	
	<!-- alertBox -->
    <div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
		</div>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
let isAlertVisible = false;

function requiredAlert(comment, isAlertVisible) {
    let alertBox = $('#alertBox');
    $("#alertDiv").html(comment);
    if (!isAlertVisible) { // 알림이 보이지 않을 때만 실행
        isAlertVisible = true; // 알림을 표시 중임을 설정
        alertBox.css('display', "block");
        setTimeout(function() {
            alertBox.css('display', "none");
            isAlertVisible = false; // 알림이 사라진 후 플래그를 초기화
        }, 2000);
    }
    return false;
}

$(function () {
	const userName = $("#userName").val();
	const userNo = $("#userNo").val();
	
	var today = new Date();
	var fyear = today.getFullYear();
	var mon = today.getMonth()+1;
	var date = today.getDate();
	
	var inTime
	var YMD
	var attendanceDate
	var atState
	var curDay
	var curDate
	
	// 실행
	printInTime()
	updList()
	renderCurMonth()
	showToday()
	
	
	// 달력에서 월 변경시
	$("#choiceMon").on("change",function(e){
		console.log(e.target.value)
		renderCurMonth(e.target.value)
		printInTime(e.target.value)
		updList(e.target.value)
	})
	
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
		
		console.log(prevMon[1])
		prevMon = `\${prevMon[0]}-\${prevMon[1]}`
		$("#choiceMon").val(prevMon)
		renderCurMonth($("#choiceMon").val())
		printInTime($("#choiceMon").val())
		updList($("#choiceMon").val())
		showToday()
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
		renderCurMonth($("#choiceMon").val())
		printInTime($("#choiceMon").val())
		updList($("#choiceMon").val())
		showToday()
	})
	
	// 1주차, 2주차, 3주차 표 생성
	function renderCurMonth(sendDate){
		console.log("renderCurMonth()실행!!!!!")
		var firstDay2 = new Date(fyear, mon-1,1).getDate();	// 이번달 1일
		var lastDay2 = new Date(fyear, mon,0).getDate();	// 이번달의 마지막 날
		var printAttend = "";
		curDate = `\${fyear}/\${mon}`;
		curDate2 = `\${fyear}-\${mon}`;
		console.log(sendDate)
		if(typeof sendDate != "undefined"){
			curDate = sendDate.replace('-','/')
			curDate2 = sendDate
			firstDay2 = new Date(curDate2.split('-',2)[0], curDate2.split('-',2)[1]-1,1).getDate();
			lastDay2 = new Date(curDate2.split('-',2)[0], curDate2.split('-',2)[1],0).getDate();
			fyear = curDate2.split('-',2)[0]
			mon = curDate2.split('-',2)[1]
		}
// 		$("#curMonth").html(curDate2);
		$("#choiceMon").attr("value", curDate2)
		$.ajax({
			url : "/attend/renderCurMonth",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : curDate
			}),
			async:false,
			contentType : "application/json; charset=utf-8",
			success : function(attendance){
// 				attendance == this.attendance
				// <table><th> 생성
				for(var i = 1; i <= 5; i++){
					printAttend += 
						`
							<div class="accordion" id="accordionExample\${i}">
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="heading1"><button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse\${i}" aria-expanded="true" aria-controls="collapse\${i}">
							    	<span style="color: black; font-weight: 500; font-size: 25px">\${i}주차</span></button></h2>
							    <div class="accordion-collapse collapse" id="collapse\${i}" aria-labelledby="heading\${i}" data-bs-parent="#accordionExample">
							      <div class="accordion-body">
									  <div class="table-responsive scrollbar" style="flex: 1;">
									    <table class="table table-bordered border-500 fs-10 mb-0" style="border-collapse: collapse;" id="selDiv" style="text-align: center;">
									      <thead class="bg-200">
									        <tr>
									          <th class="text-900 sort" style="width: 120px">일자</th>
									          <th class="text-900 sort" style="width: 100px">출근</th>
									          <th class="text-900 sort" style="width: 100px">퇴근</th>
									          <th class="text-900 sort" style="width: 300px">총 근무시간</th>
									        </tr>
									      </thead>
									      <tbody class="atList" id="atList\${i}">
									      	
									      </tbody>
									    </table>
									</div>
							      </div>
							    </div>
							  </div>
							</div>
						`
				}
				$("#weekAttend").html(printAttend)
				var printAttendDe
				var i = 1;		// 1주차, 2주차 증가값
				var days = ['일','월','화','수','목','금','토'];
// 				console.log(attendance[0].attendanceDate);
				// <table><td> 생성
				for(firstDay2; firstDay2 <= lastDay2; firstDay2++){
					var AtList = $("#atList"+i);
					var lastDay3 = new Date(fyear, mon-1,firstDay2).getDay();
					if(firstDay2 < 10){
						curDay = `\${curDate2}-0\${firstDay2}`
					} else {
						curDay = `\${curDate2}-\${firstDay2}`
					}
					// getDay() 0=일, 1=월, 2=화, 3=수, 4=목, 5=금, 6=토
					if (lastDay3 != 0){
						printAttendDe += 
							`
							<tr id="\${curDay}-0" style='cursor:pointer;'>
								<td id="\${curDay}-6">\${firstDay2}일 \${days[lastDay3]}요일 </td>
								<td id="\${curDay}-1"></td>
								<td id="\${curDay}-2"></td>
								<td id="\${curDay}-3"> <input type="hidden" id="\${curDay}-7"/> </td>
							</tr>
							`
						AtList.html(printAttendDe);
					} else{
						printAttendDe +=
							`
							<tr id="\${curDay}-0" data-date="0" style='cursor:pointer;'>
								<td id="\${curDay}-6">\${firstDay2}일 \${days[lastDay3]}요일</td>
								<td id="\${curDay}-1"></td>
								<td id="\${curDay}-2"></td>
								<td id="\${curDay}-3"></td>
							</tr>
							`
						AtList.html(printAttendDe);
						if(firstDay2 != 1){
							i = i+1;
							printAttendDe = null;
						}
					}
				}
				
// 				firstDay2 = new Date(fyear, mon-1,1).getDate();	// 이번달 1일
// 				lastDay2 = new Date(fyear, mon,0).getDate();	// 이번달의 마지막 날
			}
		})
	}
	
	<!-- 주차별 시간 출력 -->
	function printInTime(sendDate) {
		var firstDay2 = new Date(fyear, mon-1,1).getDate();	// 이번달 1일
		var lastDay2 = new Date(fyear, mon,0).getDate();	// 이번달의 마지막 날
		console.log("printInTime() 실행!!!!!!!!!!!!!");
		curDate = `\${fyear}/\${mon}`;
		if(typeof sendDate != "undefined"){
			curDate = sendDate.replace('-','/')
		}
		$.ajax({
				url : "/attend/renderCurMonth",
				method : "post",
				data : JSON.stringify({
				memNo : userNo,
				attendanceDate : curDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(attendance){
				console.log("printInTime() ajax실행 성공")
				
				var glArr = [0, 0, 0]
				var thisWeekSum
				for(firstDay2; firstDay2 <= lastDay2; firstDay2++){
					if (firstDay2 < 10){
						curDay = `\${fyear}-\${mon}-0\${firstDay2}`
					}else{
						curDay = `\${fyear}-\${mon}-\${firstDay2}`
					}
// 					console.log(curDay)
					if (new Date(curDay).getDay() == 0){
						glArr = [0,0,0]						
					}
					$(attendance).each(function(){
						var attDate = this.attendanceDate.split(" ",1)
						if(curDay == attDate[0]){
							$("#"+curDay+"-1").html(this.inTime);
							$("#"+curDay+"-2").html(this.outTime);
							$("#"+curDay+"-3").html(this.monoverTime);
							
							glArr[0] = parseInt(glArr[0]) + parseInt(this.monoverTime.split(":")[0]);
							glArr[1] = parseInt(glArr[1]) + parseInt(this.monoverTime.split(":")[1]);
							glArr[2] = parseInt(glArr[2]) + parseInt(this.monoverTime.split(":")[2]);
							
							if(glArr[0] < 10){
								glArr[0] = "0" + glArr[0];						
							}
							
							if(glArr[1] < 10){
								glArr[1] = "0" + glArr[1];					
							}
							
							if(glArr[2] < 10){
								glArr[2] = "0" + glArr[2];
							}
							
							thisWeekSum = `\${glArr[0]}:\${glArr[1]}:\${glArr[2]}`
							$(".glSumTime").html(thisWeekSum)
						}
					})
				}
			}
		})
	}
	
	$(".accordion-button").on('click',function(){
		$("#selectAtList").hide();
	})
	
	// 일자별 상세 근무기록
	$(document).on('click','[id^=2024-]',function(){
// 	$('.atList').on('click','td',function(){
		var printState = "";
		var selectId = $(this).attr("id")
		selectId = selectId.split("-")[0]+"-"+selectId.split("-")[1]+"-"+selectId.split("-")[2];
		$.ajax({
			url : "/workState/renderCurMonth",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				stateDate : curDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(atstate){
				var selStatD = [];
				for(const statD of atstate){
					if(selectId == statD.stateDate.split(" ",1)){
						selStatD.push(statD)
					}
				}
				
				if(selStatD.length == 0){
					$("#selectAtList").hide();
				} else {
					$("#selectAtList").show();
					for(i = 0; i < selStatD.length; i++){
						if(selStatD[i].atstateType != "출근"){						
							if(selStatD[i].atstateType != null){
								printState +=
									`
											<tr data-bs-toggle="modal" data-bs-target="#error-modal">
												<td class="text-900 sort">일자</td>
												<td class="text-900 sort">\${selStatD[i].atstateDate.split(" ",1)}</td>
												<td class="text-900 sort">시간</td>
												<td class="text-900 sort">\${selStatD[i].atstateDate.split(" ")[1]}</td>
												<td class="text-900 sort">근무상태</td>
												<td class="text-900 sort">\${selStatD[i].atstateType}</td>
												<input id="AtstateDetail" type="hidden" value="\${selStatD[i].workAtstate}"/>
											</tr>
									`
									$("#selAtBody").html(printState);
							} else {
							printState +=
								`
										<tr data-bs-toggle="modal" data-bs-target="#error-modal">
											<td class="text-900 sort" style="width: 150px">일자</td>
											<td class="text-900 sort" style="width: 150px">\${selStatD[i].stateDate.split(" ",1)}</td>
											<td class="text-900 sort" style="width: 150px">시간</td>
											<td class="text-900 sort" style="width: 150px">\${selStatD[i].stateDate.split(" ")[1]}</td>
											<td class="text-900 sort" style="width: 150px">근무상태</td>
											<td class="text-900 sort" style="width: 150px">\${selStatD[i].stateType}</td>
											<input id="AtstateDetail" type="hidden" value="\${selStatD[i].workAtstate}"/>
										</tr>
								`
								$("#selAtBody").html(printState);
							}
					}
				}
			}
			}	
		})
	})
	
	// 모달 on 수정버튼
	$("#atstateUpdate").on("click", function(){
		var updState = $("select[id=updWorkState] option:selected").text();	// 선택된 업무
		var updText = $("#modalCont").val();								// 수정사유
		var updDate = $("#modalDate").val();								// 수정될 날짜
		var updTime = $("#modalTime").val();								// 수정될 날짜
		var atstateNo = $("#atstateNo").val();								// hidden처리 되어 있는 상태번호
		var updDate1 = updDate.split("T",2);								// T 제거 날짜와 시간 2개의 배열로나눔
		updDate = `\${updDate} \${updTime}`							// 배열 합치기
		updDate = updDate.replaceAll('-','/');								// '-' 을 '/' 로 수정
		
		$.ajax({
			url : "/workState/updAtstate",
			method : "post",
			data : JSON.stringify({
				workAtstate : atstateNo,
				atstateDate : updDate,
				atstateCont : updText,
				atstateType : updState
			}),
			contentType : "application/json; charset=utf-8",
			success : function(atstate){
				// return int값
				console.log(atstate)
				location.reload();
			}
		})
	})
	
	$("#atstateDelete").on("click", function(){
		var atstateNo = $("#atstateNo").val();
		
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
				url : "/workState/delAtstate",
				method : "post",
				data : JSON.stringify({
					workAtstate : atstateNo
				}),
				contentType : "application/json; charset=utf-8",
				success : function(res){
					if(res > 0){
						
					}else {
						alert("삭제에 실패했습니다.")
					}
				}
			})
			alert("정상적으로 삭제되었습니다.")
		} else {
			alert("삭제를 취소했습니다.")
		}
	})
	
	// 모달에 값 넣기
	$("#selAtBody").on("click","tr",function(e){
		console.log("모달 클릭")
		
		var workAt = $(this).children();
		var workAtstate = workAt.eq(6).val();
		
		$.ajax({
			url : "/workState/renderModal",
			method : "post",
			data : JSON.stringify({
				workAtstate : workAtstate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(atstate){
				console.log(atstate.stateDate.split(" ",2)[0]);
				console.log(atstate.stateDate.split(" ",2)[1]);
				var selDate = atstate.stateDate.split(" ",1)[0];
// 				console.log(selDate)

				$("#modalDate").val(atstate.stateDate.split(" ",2)[0]);
				$("#modalTime").val(atstate.stateDate.split(" ",2)[1]);
				$("#modalCont").val();
				$("#atstateNo").val(atstate.workAtstate);
			}
		})
	})
	
	function printGlsumTime() {
		var curDate3day = today.getDate()	
		curDate3 = curDate2 + "-" + "0" +curDate3day
		console.log("printGlsumTime");
		console.log(curDate3);
		console.log($("#"+curDate3+"-0").children().eq(3).eq(0))
	}
	printGlsumTime();
	// 변경 이력 출력
	function updList(sendDate){
		var printAt
		curDate = `\${fyear}/\${mon}`;
		
		if(typeof sendDate != "undefined"){
			curDate = sendDate.replace('-','/')
		}
		
		console.log("updList 실행!!")		
		$.ajax({
			url : "/workState/atList",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				atstateDate : curDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(atstate){
				$(atstate).each(function(){
					var atstat = this
					if(atstat.atstateCont == null){
						atstat.atstateCont = ""
					}
					printAt +=
						`
						<tr>
				          <td>
				          	<span id="updName">\${userName}</span><br>
				          	<span id="updDate">\${atstat.stateDate}</span> <span id="updType">\${atstat.stateType}</span> -> <span id="updAtdate">\${atstat.atstateDate}</span> <span id="updAttype">\${atstat.atstateType}</span><br>
				          	<span id="updCont">\${atstat.atstateCont}</span>
				          </td>
				        </tr>
				        `
				    $("#atList").html(printAt);
				})
						
			}
		})
	}
	
	function showToday(){
		var fyear = today.getFullYear();
		var mon = today.getMonth()+1;
		var date = today.getDate();
		
		var Today = `\${fyear}-\${mon}-\${date}-0`	
		let tdElement = document.getElementById(Today);
		
		tdElement.style.fontWeight = "900";
		tdElement.style.color = "black";
		tdElement.style.fontSize = "15px";
		
		tdElement.parentNode.parentNode.parentNode.parentNode.parentNode.className = 'accordion-collapse collapse show'
	}
})
</script>
