<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<input type="hidden" value="${member.deptNo}" id="userDept">
	<div class="d-flex flex-column w-75 scrollbar" >
		<table>
			<thead>
				<tr>
					<th>메뉴 선택</th>
					<td><select id="selectMenu">
						<option value="" selected disabled hidden>메뉴를 선택해주세요</option>
						<option value="0">부서별 연차 사용수</option>
						<option value="1">부서별 결근</option>
						<option value="2">부서별 지각 수</option>
						</select></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>기간</th>
					<td><input type="month" id="choiceMon" name="choiceMon"></td>
				</tr>
				<tr>
					<td> <button class="btn btn-primary mt-2" id="searchButton">검색</button> </td>
				</tr>
			</tbody>
		</table>
		<canvas class="max-w-100" id="barChart" width="1618" height="1000"></canvas>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<script type="text/javascript">
$(function () {
	
	serverTime()
	
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
	
	$("#searchButton").on("click", function(){
		console.log($("#selectMenu option:selected").val())
		if($("#selectMenu option:selected").val() == "" || $("#selectMenu option:selected").val() == null) return;
		var selMenu = $("#selectMenu option:selected").val()
		var choiceMon = $("#choiceMon").val();
		
		if(selMenu == 0){
			$.ajax({
				url : "/attend/vacaData",
				method : "post",
				data : JSON.stringify({
					choiceMon : choiceMon
				}),
				contentType : "application/json; charset=utf-8",
				success : function(res) {
					console.log(res)
				}
			})
		} else {
			alert("잘못 선택")
		}
	})
	
	function updatePieChart() {
        var ctxBarChart = document.getElementById('barChart').getContext('2d');

        // 기존 차트가 있다면 삭제
        if (window.barChart && window.barChart instanceof Chart) {
            window.barChart.destroy();
        }

        // 새로운 차트 생성
        window.barChart = new Chart(ctxBarChart, {
            type: 'bar',
            data: {
                labels: ['운영부','재무부','인사부'],
                datasets: [
                	{
                		label:'부서별 연차 사용 수',
                    	data: [10,20,30]
                	}
                ]
            }
        });
    }
})
</script>