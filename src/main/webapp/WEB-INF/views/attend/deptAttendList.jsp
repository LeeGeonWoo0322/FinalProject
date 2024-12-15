<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<input type="hidden" value="${member.deptNo}" id="userDept">
	<div class="d-flex flex-column w-75 scrollbar" >
	<h2>부서 근태 현황</h2>
	<div class="d-flex flex-row justify-content-center" id="cur_date">
		<span id="prevMonth"><i class="bi bi-caret-left-fill fs-6"></i></span>
		<input type="month" id="choiceMon" name="choiceMon">
		<span id="nextMonth"><i class="bi bi-caret-right-fill fs-6"></i></span>
	</div>
		<div id="useVacation" data-list='{"page":5,"pagination":true}' class="d-flex flex-column p-2">
			  <div class="table-responsive scrollbar">
			    <table class="table table-bordered border-500 fs-10 mb-0">
			      <thead class="bg-200">
			        <tr>
			          <th class="text-900 sort">이름</th>
			          <th class="text-900 sort">누적 근무시간</th>
			          <th class="text-900 sort">1주</th>
			          <th class="text-900 sort">2주</th>
			          <th class="text-900 sort">3주</th>
			          <th class="text-900 sort">4주</th>
			          <th class="text-900 sort">5주</th>
			        </tr>
			      </thead>
			      <tbody class="list">
			        <tr>
			          <td class="name">
			          	Anna<br>
						부장<br>
						A근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">
			          	Homer<br>
						차장<br>
						A근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">
			          	Oscar<br>
						사원<br>
						A근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">E
			          	mily<br>
						대리<br>
						A근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">
			          	Jara<br>
						부장<br>
						A근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">
			          	Clark<br>
						부장<br>
						A근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">
			          	Jennifer<br>
						대리<br>
						B근무
			          </td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">Tony</td>
			         <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">Tom</td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">Michael</td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">Antony</td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">Raymond</td>
			          <td class="monthAttend">13h27m27s</td>
			          <td class="1Date">4h10m20s</td>
			          <td class="2Date">5h20m30s</td>
			          <td class="3Date">2h15m45s</td>
			          <td class="4Date">3h13m17s</td>
			          <td class="5Date">0h0m0s</td>
			        </tr>
			        <tr>
			          <td class="name">Marie</td>
			          <td class="email">경영</td>
			          <td class="age">연차</td>
			          <td class="useDate">2024-10-19 ~ 2024-10-21</td>
			          <td class="useVaca">3</td>
			          <td class="cont">그냥</td>
			        </tr>
			        <tr>
			          <td class="name">Cohen</td>
			          <td class="email">경영</td>
			          <td class="age">연차</td>
			          <td class="useDate">2024-10-19 ~ 2024-10-21</td>
			          <td class="useVaca">3</td>
			          <td class="cont">그냥</td>
			        </tr>
			        <tr>
			          <td class="name">Rowen</td>
			          <td class="email">경영</td>
			          <td class="age">연차</td>
			          <td class="useDate">2024-10-19 ~ 2024-10-21</td>
			          <td class="useVaca">3</td>
			          <td class="cont">그냥</td>
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
	var choiceMon = $("#choiceMon");
	const userName = $("#userName").val();
	const userNo = $("#userNo").val();
	const userDept = $("#userDept").val();
	
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
	})
	
	printDeptList()
	
	function printDeptList() {
		var curDate = $("#choiceMon").val()
		
		console.log(curDate)
		$.ajax({
			url : "/attend/deptWeekAttend", 
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				deptNo : userDept,
				attendanceDate : curDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res)
				$.each(res, function(index, value){
					if(value.memNo == value.memAttendance[0].memNo){
						console.log("같다")
					}
				})
			}
		})
	}
})
</script>