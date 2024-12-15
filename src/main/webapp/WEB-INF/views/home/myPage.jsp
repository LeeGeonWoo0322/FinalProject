<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card p-3" style="height: 100%">

	<h2>마이페이지</h2>
	<div class="d-flex flex-row">
		<div>
			<div style="width: 500px">
				<table>
					<colgroup>
						<col width="150px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th class="p-2">사진</th>
							<td class="p-2">
			        			<div class="d-flex flex-row align-items-end">
			        				<div style="width: 100px;height: 100px" class="me-2">
			        					<c:if test="${empty member.memProfileimg }">
				        					<img style="width: 100%;height: 100%" src="${pageContext.request.contextPath }/resources/icon/default_profile.png">
			        					</c:if>
			        					<c:if test="${not empty member.memProfileimg }">
				        					<img style="width: 100%;height: 100%" src="${member.memProfileimg }">
			        					</c:if>
			        				</div>
			       					<input type="file" id="file" name="" class="d-none">
			       					<label for="file" class="m-0">
			       						<div class="btn border px-1 py-0">사진 등록</div>
			       					</label>
			        			</div>
			        			<div>
			        				❋사진은 자동으로 150x150 사이즈로 적용 됩니다.
			        			</div>
							</td>
						</tr>
						<tr>
							<th class="p-2">이름</th>
							<td class="p-2">${member.memName }</td>
						</tr>
						<tr>
							<th class="p-2">부서</th>
							<td class="p-2">${member.deptName }</td>
						</tr>
						<tr>
							<th class="p-2">직위</th>
							<td class="p-2">${member.posName }</td>
						</tr>
						<tr>
							<th class="p-2">이메일</th>
							<td class="p-2">${member.memEmail }</td>
						</tr>
						<tr>
							<th class="p-2">연락처</th>
							<td class="p-2">${member.memTel }</td>
						</tr>
						<tr>
							<th class="p-2">입사일</th>
							<td class="p-2">${fn:substring(member.hireDate,0,10) }</td>
						</tr>
					</tbody>
				</table>
				<form>
					<input type="hidden" id="memNo" value="${member.memNo }"/>
					<input type="hidden" id="memId" value="${member.memId }"/>
					<input type="hidden" id="hireDate" value="${member.hireDate }"/>
					<input type="hidden" id="memEmail" value="${member.memEmail }"/>
				</form>
			</div>
			<div class="d-flex flex-row justify-content-center mt-3" style="width: 500px">
				<div><a class="btn btn-info d-flex align-items-center me-2">저장</a></div>
				<div><a class="btn btn-secondary d-flex align-items-center">취소</a></div>
			</div>
		</div>
		<div>
		 	<h3>출/퇴근 인증 QR 코드</h3>
		    <img id="qrImg" alt="" src="">
		    <input type="hidden" id="btn1"><br>
		    <div id="result1"></div>
		    <input type="hidden" id="btn2"><br>
		    <div id="reader" style="width:500px; display:none;"></div>
		    <div id="result2"></div>
		    <div id="result3"></div>
		</div>
	</div>
	
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/2.3.8/html5-qrcode.min.js"></script>
<script type="text/javascript">
createQR();
$(function(){
	
	$("#qrImg").attr("src", "/account/memberQrCodeImage");

	
	var btn1 = $("#btn1");
	var btn2 = $("#btn2");
	
	btn1.on("click", function() {
		$.ajax({
			url : "/account/memberQrCodeValue",
			method : "get",
			contentType : "application/json; charset=UTF-8",
			success : function (result) {
				var html = "";
				html = "<h3>값 : " + result + "</h3>";
				$("#result1").html(html);
			}
		});
	});
	
	btn2.on("click", function() {
		startQrScanner();
	});
	

	function startQrScanner() {
	    $('#reader').show(); // 스캐너 영역을 표시
	
	    // Html5QrCode 객체를 생성하여 QR 코드 스캔 기능을 활성화
	    // "reader"는 QR 코드를 스캔할 영역의 ID로, 이 영역애서 실시간으로 QR 코드를 스캔
	    let html5QrCode = new Html5Qrcode("reader");
	
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
	        function (qrCodeMessage) {
	        	
	        	
				var html = "";
				html = "<h3>값 : " + qrCodeMessage + "</h3>";
				$("#result2").html(html);
	
	            // QR 코드 데이터에서 JSON을 추출
	            $.ajax({
	                url: '/account/memberQrCodeValue',
	                type: 'GET',
	                success: function(result) {
	                	
	                    // JSON 데이터를 처리
						html = "<h3>값 : " + result + "</h3>";
						$("#result3").html(html);
						
						// QR 코드 스캔을 중지하고 카메라를 끕니다.
						// 중지 성공 시 then() 실행, 실패 시 catch() 실행
	                    html5QrCode.stop().then(() => {
	                        console.log('QR code scanning stopped.');
	                        $('#reader').hide();
	                    }).catch((err) => {
	                        console.error('Failed to stop QR code scanning:', err);
	                    });
	                },
	                error: function(xhr, status, error) {
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
	}
});
function createQR() {
	data = {
		memNo : $("#memNo").val(),
		memId : $("#memId").val(),
		hireDate : $("#hireDate").val(),
		memEmail : $("#memEmail").val()
	}
	$.ajax({
		 url : "/account/createMemberQRCode",
		 method : "post",
		 data : JSON.stringify(data),
		 contentType : "application/json; charset=UTF-8",
		 success : function(result) {
			 
		 }
	})
}
</script>

