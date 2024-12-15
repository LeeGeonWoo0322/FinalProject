<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <!-- ===============================================-->
  <!--    sidebar 시작    -->
  <!-- ===============================================-->
 
<div class="navbar-vertical-content h-100 scrollbar border-end border-end-1" style="width: 250px; text-align: center;">
	<div class="flex-column mb-2">
		<div class="p-3">
			<h4 id="attendHome">근태관리</h4>
		</div>
		<div>
		<div id="curTime"> </div>
		<input type="hidden" value="${member.memNo}" id="userNo">
		<input type="hidden" value="${member.memName}" id="userName">
		
		<div class="d-flex flex-column">
		<div class="d-flex flex-row justify-content-around">
			<div style="font-size: 18px">출근 시간</div>
			<div style="font-size: 18px" id="gWorkTime">--:--:--</div>
		</div>
		<div class="d-flex flex-row justify-content-around">
			<div style="font-size: 18px">퇴근 시간</div>
			<div style="font-size: 18px" id="lWorkTime">--:--:--</div>
		</div>
		</div>
		   <span class="label-text">
<!-- 			주간 누적 근무시간 : <span class="glSumTime"></span> -->
		   </span><br>
		<button type="button" id="gMWork" class="btn btn-falcon-primary me-1 mb-1" data-bs-toggle="modal" data-bs-target="#QRModal">출근</button>
		<button type="button" id="lMWork" class="btn btn-falcon-primary me-1 mb-1" data-bs-toggle="modal" data-bs-target="#QRModal">퇴근</button><br>
		<br>
		
		<!-- 업무 변경 -->
		  <select name="workState2" id="workSt2" class="form-select" aria-label="Default select example">
		    <option id="0" value="workDefault">근무상태변경</option>
		    <option id="3" value="work">업무</option>
		    <option id="4" value="workComp">업무종료</option>
		    <option id="5" value="workOut">외근</option>
		    <option id="6" value="busiTrip">출장</option>
		    <option id="7" value="away">자리비움</option>
		  </select>
		</div>
<!-- 		<div style="text-align: center;"> -->
<!-- 			<button class="btn btn-outline-dark me-1 mb-1 px-6 py-2" type="button">메일 쓰기</button> -->
<!-- 		</div> -->
	</div>
	<div class="p-3" id="sidebar-content" style='cursor:pointer;'>
		<ul class="mb-0 treeview" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">근태관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="myAttendList"> <span style="height: 20px">내 근태현황</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="myVactionList"> <span style="height: 20px">내 연차 내역</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="myInfo"> <span style="height: 20px">내 인사정보</span>
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	
	<div class="p-3" id="sidebar-content" style='cursor:pointer;'>
		<ul class="mb-1 treeview" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-2-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">부서 근태관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-2-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="deptAttendList"> <span style="height: 20px">부서 근태현황</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="deptAttendTotal"> <span style="height: 20px">부서 근태통계</span>
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	
	<div class="p-3" id="sidebar-content" style='cursor:pointer;'>
		<ul class="mb-1 treeview" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-3-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">전사 근태관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-3-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="AllAttendList"> <span style="height: 20px">전사 근태현황</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" id="AllAttendTotal"> <span style="height: 20px">전사 근태통계</span>
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	
	<!-- 모달창 시작 -->
	<div class="modal fade" id="QRModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" id="QrCancel"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<div id="reader" style="width:500px; display:none;"></div>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	
</div>
  <!-- ===============================================-->
  <!--    sidebar 끝    -->
  <!-- ===============================================-->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/2.3.8/html5-qrcode.min.js"></script>
 <script>
 
 function printWorkSt2(){
	 console.log(attendanceDate)
		$.ajax({
			url : "/workState/printWorking",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				stateDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				
				$.ajax({
					url : "/workState/printLWork",
					method : "post",
					data : JSON.stringify({
						memNo : userNo
					}),
					contentType : "application/json; charset=utf-8",
					success : function(mem) {
						
						console.log("으아아아")
				
				console.log(res)
				
					if(res.atstateType != null){
						if(res.atstateType == "업무"){
							$("select[name=workState2]").val("work").prop("selected",true);
						}
						if(res.atstateType == "업무종료"){
							$("select[name=workState2]").val("workComp").prop("selected",true);
						}
						if(res.atstateType == "외근"){
							$("select[name=workState2]").val("workOut").prop("selected",true);
						}
						if(res.atstateType == "출장"){
							$("select[name=workState2]").val("busiTrip").prop("selected",true);
						}
						if(res.atstateType == "자리비움"){
							$("select[name=workState2]").val("away").prop("selected",true);
						}
					} else {
						if(res.stateType == "업무"){
							$("select[name=workState2]").val("work").prop("selected",true);
						}
						if(res.stateType == "업무종료"){
							$("select[name=workState2]").val("workComp").prop("selected",true);
						}
						if(res.stateType == "외근"){
							$("select[name=workState2]").val("workOut").prop("selected",true);
						}
						if(res.stateType == "출장"){
							$("select[name=workState2]").val("busiTrip").prop("selected",true);
						}
						if(res.stateType == "자리비움"){
							$("select[name=workState2]").val("away").prop("selected",true);
						}
					}
						
				if(mem.memStatus == "출근"){
					$("select[name=workState2]").val("workDefault").prop("selected",true);
				}
				
				if(mem.memStatus == "퇴근"){
					$("select[name=workState2]").val("workDefault").prop("selected",true);
				}
				}
			})
		}
	})
}
 
// function printLWork(){
	
// }
 
 $(function(){
	var curTime = $("#curTime");
	var gWork = $("#gWork");
	var lWork = $("#lWork");
	const userName = $("#userName").val();
	const userNo = $("#userNo").val();
	var gWorkTime = $("#gWorkTime");
	var glSumTime = $("#glSumTime").val();
	var workSt2 = $("#workSt2");
	var inTime
	var YMD
// 	attendanceDate
	var atState
	TimeUpdate();		// 현재 시간 불러오기 interval
	overTimePrint();	// 주간 누적 근무시간 출력하기
	timeUpdate();		// 출근 시간, 퇴근시간 출력하기
	printWorkSt2()
	console.log(attendanceDate.substring(attendanceDate.length-2))
	
	// 현재 시간 출력
		function PrintTime() {
			let today = new Date();
			
			days = ['일','월','화','수','목','금','토'];
			year = today.getFullYear();
			mon = today.getMonth()+1
			date = today.getDate();
			day = days[today.getDay()];
			hh = today.getHours()
			mm = today.getMinutes();
			ss = today.getSeconds();
			
			inTime = `\${today.toTimeString().split(' ')[0]}`;
			
			YMD = `\${year}-\${mon}-\${date} \${day}요일`;
			if(date < 10){
				attendanceDate = `\${year}\${mon}0\${date}`;
			} else {
				attendanceDate = `\${year}\${mon}\${date}`;
			}
			atState = `\${year}\${mon}\${date}\${hh}\${mm}\${ss}`;
			
			var Time = `\${YMD}`;
			Time += `<h2>\${inTime}<h2>`;

			curTime.html(Time);
		}
		
	// 현재 시간 불러오기 interval
	function TimeUpdate() {
		PrintTime();
		setInterval(PrintTime, 1000);
	}
		
	// 출근 버튼 누를시
	function gWorkBtn() {
		const today = new Date();
		var dateD = today.getDay();

		$.ajax({
			url : "/attend/gWork",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				inTime : inTime,
				dateD : dateD,
				monoverTime : glSumTime,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				console.log(res)
				if (res != 0){
					overTimePrint();
					timeUpdate();
					$("#QRModal").modal('hide')
					requiredAlert("출근했습니다.",isAlertVisible);
				} else {
					$("#QRModal").modal('hide')
					requiredAlert("출근은 한번만 가능합니다.",isAlertVisible);
				}
			}
		})
	}	
		
	// 퇴근버튼 누를시
	function lWorkBtn() {
		$.ajax({
			url : "/attend/lWork",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				outTime : inTime,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				if(res != 0){
					overTimeUpdate();
					timeUpdate();
					$("#QRModal").modal('hide')
					requiredAlert("퇴근했습니다.",isAlertVisible);
				} else {
					$("#QRModal").modal('hide')
					requiredAlert("퇴근이 불가능한 상태입니다!.",isAlertVisible);
				}
			}
		})
	}
		
	// 출근시간, 퇴근시간 출력
	function timeUpdate() {
		console.log(attendanceDate)
		$.ajax({
			url : "/attend/glWorkTime",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance){
				if(attendance.inTime != null) {
					let gTime = attendance.inTime;
					$("#gWorkTime").html(gTime);
				}
				if(attendance.inTime != null) {
					let lTime = attendance.outTime;
					$("#lWorkTime").html(lTime);
				}
			}
		})
	}
		
	//누적근무시간 출력
	function overTimePrint(){
		$.ajax({
			url : "/attend/otPrint",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance) {
				console.log(attendance)
				if(attendance.movertimeTime != null || attendance.movertimeTime == "") {
						let monoverTime = attendance.monoverTime;
						let movertimeTime = attendance.movertimeTime;
						if (movertimeTime != "00:00:00" && day == "월"){
							movertimeTime = "00:00:00";
						}
						$(".glSumTime").html(movertimeTime);
						console.log(movertimeTime)
						glSumTime = movertimeTime;
				} else {
					$(".glSumTime").html("00:00:00");
				}
			}
		})
	}
		
	// 누적근무시간 계산
	function overTimeUpdate() {
		$.ajax({
			url : "/attend/overTimeUpd",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance){
				let gtArr = [];		// 출근시간 배열
				let ltArr = [];		// 퇴근시간 배열
				let overArr = [];	// 기존 주간 누적 근무시간 배열
				let otArr = [];		// 근무시간 계산을 위한 빈 배열
				
				// DB에서 가져오는 값
				let gTime = attendance.inTime;			// 출근시간 
				let lTime = attendance.outTime;			// 퇴근시간
				let oTime = attendance.movertimeTime;	// 누적근무시간
				if (!oTime){
					oTime = "0:0:0";
				}
				
				// 0:0:0 형식으로 된 시간 형식을 split을 통해 나눠 배열형식으로 바꿈
				gtArr = gTime.split(":");
				ltArr = lTime.split(":");
				overArr = oTime.split(":");
				
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
				
				// 기존 주간 누적 근무시간 + 오늘 근무시간 계산
				overArr[0] = parseInt(overArr[0]) + otArr[0]
				overArr[1] = parseInt(overArr[1]) + otArr[1]

				// 초 단위 먼저 계산해야함
				overArr[2] = parseInt(overArr[2]) + otArr[2]
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
				oTime = `\${overArr[0]}:\${overArr[1]}:\${overArr[2]}`
				otArr = `\${otArr[0]}:\${otArr[1]}:\${otArr[2]}`

				updOverTime(oTime, otArr);
			}
		})
	}
		
	// 누적 주간근무시간 업데이트
	function updOverTime(oTime, otArr) {
		$.ajax({
			url : "/attend/updOverTime",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate,
				overtimeTime : oTime,
				monoverTime : otArr
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance){
				console.log(attendance);
				overTimePrint()
			}
		})
	}
 
	workSt2.change(function() {
		var curStateVal = $(this).val();
		var curState = $("select[id=workSt2] option:selected").text();
		if (curStateVal == "work" || curStateVal == "workOut" || curStateVal == "busiTrip" || curStateVal == "workComp" || curStateVal == "away"){
			$.ajax({
				url : "/workState/changeWork",
				method : "post",
				data : JSON.stringify({
					memNo : userNo,
					stateType : curState
				}),
				contentType : "application/json; charset=utf-8",
				success : function (atstate){
					requiredAlert("근무상태 변경완료",isAlertVisible);
					printWorkSt2();
					printWorkSt();
				}
			})
		} else {
			console.log(curStateVal);
		}
	})
	
	
 	var html5QrCode = null
	$("#gMWork").on("click",function(){
	    $('#reader').show(); // 스캐너 영역을 표시
	
	    // Html5QrCode 객체를 생성하여 QR 코드 스캔 기능을 활성화
	    // "reader"는 QR 코드를 스캔할 영역의 ID로, 이 영역애서 실시간으로 QR 코드를 스캔
	    html5QrCode = new Html5Qrcode("reader");
	
	    // html5QrCode.start(...) : QR 코드 스캔을 시작하는 메서드
	    html5QrCode.start(
	    		
	    	// "user" : 전면 카메라 사용
	    	// "environment : 후면 카메라 사용"
	        { facingMode: "environment" },
	        {
	        	// 초당 프레임 수
	            fps: 10,  
	            // QR 코드 인식 영역 크기
	            // qrbox: {width: 250, height: 250} -> 가로, 세로 각각 설정 가능
	            qrbox: 250
	            
	        },
	        
			// QR 코드 스캔을 성공하면 qrCodeMessage에 QR 코드의 데이터가 들어가고 콜백함수 실행
			function () {
				// QR 코드 데이터에서 JSON을 추출
				$.ajax({
				    url: '/account/memberQrCodeValue',
				    type: 'GET',
				    success: function(result) {
				// QR 코드 스캔을 중지하고 카메라를 끕니다.
				// 중지 성공 시 then() 실행, 실패 시 catch() 실행
			            html5QrCode.stop().then(() => {
			            	gWorkBtn();
			                console.log('QR code scanning stopped.');
			                $('#reader').hide();
			            }).catch((err) => {
			                console.error('Failed to stop QR code scanning:', err);
			                $('#reader').hide();
			            });
			        },error: function(xhr, status, error) {
			            console.error('Error fetching member data:', error);
			        }
			    });
				
			},
	       // 스캔 실패 시
	       function (error) {
	           console.warn(`QR 코드 스캔 실패: ${error}`);
	       }
		    // 시작 실패 시
		   ).catch(err => {
		       console.log(`QR 스캐너 시작 중 오류: ${err}`);
		   });
	})
	
	$("#QrCancel").on("click",function(){
		html5QrCode.stop();
	})

 	$("#lMWork").on("click",function(){
	    $('#reader').show(); // 스캐너 영역을 표시
	
	    // Html5QrCode 객체를 생성하여 QR 코드 스캔 기능을 활성화
	    // "reader"는 QR 코드를 스캔할 영역의 ID로, 이 영역애서 실시간으로 QR 코드를 스캔
	    html5QrCode = new Html5Qrcode("reader");
	
	    // html5QrCode.start(...) : QR 코드 스캔을 시작하는 메서드
	    html5QrCode.start(
	    		
	    	// "user" : 전면 카메라 사용
	    	// "environment : 후면 카메라 사용"
	        { facingMode: "environment" },
	        {
	        	// 초당 프레임 수
	            fps: 10,  
	            // QR 코드 인식 영역 크기
	            // qrbox: {width: 250, height: 250} -> 가로, 세로 각각 설정 가능
	            qrbox: 250
	            
	        },
	        
			// QR 코드 스캔을 성공하면 qrCodeMessage에 QR 코드의 데이터가 들어가고 콜백함수 실행
			function () {
				// QR 코드 데이터에서 JSON을 추출
				$.ajax({
				    url: '/account/memberQrCodeValue',
				    type: 'GET',
				    success: function(result) {
				
				// QR 코드 스캔을 중지하고 카메라를 끕니다.
				// 중지 성공 시 then() 실행, 실패 시 catch() 실행
			            html5QrCode.stop().then(() => {
			            	lWorkBtn();
			                console.log('QR code scanning stopped.');
			                $('#reader').hide();
			            }).catch((err) => {
			                console.error('Failed to stop QR code scanning:', err);
			                $('#reader').hide();
			            })
			        },error: function(xhr, status, error) {
			            console.error('Error fetching member data:', error);
			        }
			    });
			},
	       // 스캔 실패 시
	       function (error) {
	           console.warn(`QR 코드 스캔 실패: ${error}`);
	       }
		    // 시작 실패 시
		   ).catch(err => {
		       console.log(`QR 스캐너 시작 중 오류: ${err}`);
		   });
	})
	
	
	
 })
 
 </script>
 
 <!-- 사이드 바 이동 -->
<script type="text/javascript">
$(function() {
	var myAttendList = $("#myAttendList");
	var myVactionList = $("#myVactionList")
	var deptAttendList = $("#deptAttendList")
	var deptAttendTotal = $("#deptAttendTotal")
	var allAttendList = $("#AllAttendList")
	var allAttendTotal = $("#AllAttendTotal")
	var myInfo = $("#myInfo");

	myAttendList.on("click", function() {
		location.href = "/attend/main";
	})
	
	myVactionList.on("click", function(){
		location.href = "/vacation/printMyVacation"
	})
	
	deptAttendList.on("click", function(){
		location.href = "/info/deptAttendList"
	})
	
	deptAttendTotal.on("click", function(){
		location.href = "/info/deptAttendTotal"
	})
	
	allAttendList.on("click", function(){
		location.href = "/info/allAttendList"
	})
	
	allAttendTotal.on("click", function(){
		location.href = "/info/allAttendTotal"
	})
	
	myInfo.on("click",function(){
		location.href = "/info/myInfo"
	})
})
</script>