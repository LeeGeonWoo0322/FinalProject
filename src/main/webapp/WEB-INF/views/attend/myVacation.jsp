<%@page import="java.text.SimpleDateFormat"%>
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
</style>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<hr/>
	<div class="d-flex flex-column w-100 p-2 m-2" style="text-align: center;">
		<h1 style="text-align: center;">내 연차 내역</h1>
		<div class="d-flex flex-column p-2">
		<!-- 연차신청 -->
		<form id="approvalForm" action="/approval/register.do" method="POST" class="d-flex justify-content-end">
				<input type="hidden" name="formNo" id="formNo" value="22">
				<input type="hidden" name="approvalLine" id="approvalLineInput">
				<input type="hidden" name="referenceList" id="referenceListInput">
				<input type="hidden" name="readList" id="readListInput">
				<button type="button" class="btn" id="registerApprBtn"><span class="bi-calendar-minus fs-8"></span> 연차 신청</button>
		</form>
		
			<table class="table table-bordered border-500 fs-10 mb-0 w-100 p-2" align="center">
<!-- 					<tr> -->
<%-- 						<th class="text-900 bg-200" colspan="4">${member.memName }</th> --%>
<!-- 					</tr> -->
					<tr>
						<th class="text-900 bg-200"">발생 연차</th>
						<th class="text-900 bg-200">발생 월차</th>
						<th class="text-900 bg-200">사용 연차</th>
						<th class="text-900 bg-200">잔여 연차</th>
					</tr>
					<tr>
						<td id="yearOff">0</td>
						<td id="monthOff">0</td>
						<td id="useOff">0</td>
						<td id="leftOff">0</td>
					</tr>
			</table>
		</div>
		<hr/>
		<div class="d-flex flex-row justify-content-center" id="cur_date">
			<span id="prevMonth"><i class="bi bi-caret-left-fill fs-6"></i></span>
			<input type="month" id="choiceMon" name="choiceMon">
			<span id="nextMonth"><i class="bi bi-caret-right-fill fs-6"></i></span>
		</div>
		
		<h3 align="center">사용내역</h3>
		<div id="useVacation" data-list='{"valueNames":["type","startDt","useDt", "cont"], "pagination":true}' class="d-flex flex-column p-2" style="text-align: center;">
			  <div class="table-responsive scrollbar" style="min-height: 200px">
			    <table class="table table-bordered border-500 fs-9 mb-0 w-100" align="center">
			      <thead class="bg-200">
			        <tr>
			          <th class="text-900 sort">휴가 종류</th>
			          <th class="text-900 sort">사용기간</th>
			          <th class="text-900 sort">사용 연차</th>
			          <th class="text-900 sort">내용</th>
			        </tr>
			      </thead>
			      <tbody class="list" id="useVacaList">
			        <tr>
			         	<td>사용한 휴가 내역이 없습니다.</td>
			        </tr>
			      </tbody>
			    </table>
			  </div>
			 <!-- 페이징 -->
			  <div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			    <ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"> </span></button>
			  </div>
		</div>
		
	<h3 align="center">생성내역</h3>
		<div id="createVaca" data-list='{"valueNames":["date","createDt","cont"], "pagination":true}' 
			class="d-flex flex-column p-2 h-50" style="text-align: center;">
		  <div class="table-responsive scrollbar" style="min-height: 100px">
		    <table class="table table-bordered border-500 fs-9 mb-0 w-100" align="center">
		      <thead class="bg-200">
		        <tr>
		          <th class="text-900" data-sort="date">등록일</th>
		          <th class="text-900" data-sort="createDt">발생일수</th>
		          
<!-- 		          <th class="text-900" data-sort="cont">내용</th> -->
		        </tr>
		      </thead>
		      <tbody class="list" id="createVacaList">
		      	<tr>
		      		<td>생성된 연차 내역이 없습니다.</td>
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
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
$(function () {
	const userName = $("#userName").val();
	const userNo = $("#userNo").val();
	var choiceMon = $("#choiceMon")

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
	
	choiceMon.val(curDate)
	var curMonth = choiceMon.val()

	console.log(choiceMon.val())
	
	myUseVacaList()			// 사용내역 출력
	myCreateVacaList()		// 생성내역 출력
	totalUseVaca()			// 사용연차 출력
	totalCreateVaca()		// 발생연차 출력
	
	
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
		myUseVacaList()			// 사용내역 출력
		myCreateVacaList()		// 생성내역 출력
		totalUseVaca()			// 사용연차 출력
		totalCreateVaca()		// 발생연차 출력
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
		myUseVacaList()			// 사용내역 출력
		myCreateVacaList()		// 생성내역 출력
		totalUseVaca()			// 사용연차 출력
		totalCreateVaca()		// 발생연차 출력
	})
	
	setTimeout(leftVaca, 500)
	
	function leftVaca(){
		var useOff = $("#useOff");
		var yearOff = $("#yearOff");
		var leftOff = $("#leftOff");
		
		leftOff.html(yearOff.html() - useOff.html())
		console.log(useOff.html());
		console.log(yearOff.html());
	}
	
	function totalUseVaca(){
		$.ajax({
			url : "/vacation/myUseVacaTotal",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				vctStart : year
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res)
				if(res.length > 0){
					var totalUseVaca = 0;
					$.each(res, function(index, value){
						totalUseVaca += value.useDt
					})
					$("#useOff").html(totalUseVaca);
				}
			}
		})
	}
	
	function totalCreateVaca(){
		$.ajax({
			url : "/vacation/myCreateVacaTotal",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				vacCreateDate : year
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log("#################",res)
				if(res.length > 0){
					var totalCreateVaca = 0;
					$.each(res, function(index, value){
						totalCreateVaca += value.vacCreateCount
					})
					$("#yearOff").html(totalCreateVaca);
				}
			}
		})
	}
	
	function myCreateVacaList(){
		curMonth = choiceMon.val()
		
		console.log(userNo);
		console.log(curMonth);
		console.log("@@@@@@@@@@@@")
		$.ajax({
			url : "/vacation/myCreateVacaList",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				vacCreateDate : curMonth
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res.length)
				if(res.length > 0){
					var printCreateVacaList
					$.each(res, function(index, value){
						printCreateVacaList +=
							`
								<tr>
									<td class="date px-2 py-1">\${value.vacCreateDate.split(" ",1)}</td>
									<td class="createDt px-2 py-1">\${value.vacCreateCount}</td>
								<tr>
							`
// 									<td class="cont px-2 py-1">\${value.vctTypeNo}</td>
						$("#createVacaList").html(printCreateVacaList);
					})
					var options = {
						valueNames: ['date','createDt','cont'],
						page: 10,
						pagination: true
					}
					var createVaca = new List('createVaca', options);
				} else {
					printCreateVacaList = 
						`
							<tr>
					         	<td colspan="3">생성된 연차 내역이 없습니다.</td>
					        </tr>
						`
					$("#createVacaList").html(printCreateVacaList)
				}
			}
		})
	}
	
	
	function myUseVacaList() {
		curMonth = choiceMon.val()
		$.ajax({
			url : "/vacation/myUseVacaList",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				vctStart : curMonth
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res.length)
				if(res.length > 0){
					var printVacaList
					$.each(res, function(index, value){
						console.log(value.vctCont)
						printVacaList += 
							`
								<tr>
									<td class="type px-2 py-1">\${value.vctName}</td>
									<td class="startDt px-2 py-1">\${value.vctStart.split(" ",1)}~\${value.vctEnd.split(" ",1)}</td>
									<td class="useDt px-2 py-1">\${value.useDt}</td>
									<td class="cont px-2 py-1">\${value.vctCont}</td>
								</tr>
							`
						$("#useVacaList").html(printVacaList)
					})
					var useVacation = new List('useVacation', {
						  valueNames: ['useDt'],
						  page: 10,
						  pagination: true
					});
				} else {
					printVacaList = 
						`
							<tr>
					         	<td colspan="4">사용한 휴가 내역이 없습니다.</td>
					        </tr>
						`
					$("#useVacaList").html(printVacaList)
				}
			}
		})
	}
	
	$("#registerApprBtn").on("click",function(){
		console.log($("#formNo").val())
		
		$('#approvalForm').submit();
	})
})
</script>