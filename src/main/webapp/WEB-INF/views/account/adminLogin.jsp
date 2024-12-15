<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
.img-responsive {
    width: 200px; /* 원하는 크기로 조정 */
    height: auto;
    display: block; /* 블록 요소로 설정하여 아래 텍스트와 분리 */
    margin: 0 auto; /* 가운데 정렬 */

}
</style>    
    
<div class="card overflow-hidden z-1">
  <div class="card-body p-0">
    <div class="row g-0 h-100">
      <div class="col-md-5 text-center bg-card-gradient">
        <div class="position-relative p-4 pt-md-5 pb-md-7" data-bs-theme="light">
          <div class="bg-holder bg-auth-card-shape" style="background-image:url(${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/half-circle.png);">
          </div>
          <!--/.bg-holder-->

          <div class="z-1 position-relative"><p class="link-light mb-4 font-sans-serif fs-5 d-inline-block fw-bolder">IRIS</p>
          <img class="img-responsive" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/IRIS3.png" alt="logo" />
            <p class="opacity-75 text-white">Intelligent Realtime Interactive System</p>
          </div>
        </div>
        <div class="mt-6 mb-6 mt-md-4 mb-md-5" data-bs-theme="light">
        </div>
      </div>
      <div class="col-md-7 d-flex flex-center">
        <div class="p-4 flex-grow-1">
          <div class="row flex-between-center">
            <div class="d-flex flex-row mb-4">
              <h4>관리자 로그인</h4>
              <div class="vr text-900 mx-3"></div>
              <h4>Admin</h4>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label" for="otpCode" style="font-size: 16px;font-weight: bold;">OTP 인증</label>
            <input class="form-control" id="otpCode" type="password" placeholder="OTP 인증코드를 입력해주세요." name="otpCode"/>
          </div>
          <div id="error-text" style="color: red;font-size: 13px;"></div>
          <div class="mb-2">
            <button class="btn btn-primary d-block w-100 mt-2" type="button" id="otpCheckBtn">확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.7.7/axios.min.js" integrity="sha512-DdX/YwF5e41Ok+AI81HI8f5/5UsoxCVT9GKYZRIzpLxb8Twz4ZwPPX+jQMwMhNQ9b5+zDEefc+dcvQoPWGNZ3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
$(function () {
	$("#otpCode").on("keydown", function (event) {
		if (event.keyCode == 13) {
			otpCheck();
		}
	});
	
	$("#otpCheckBtn").on("click", function () {
		otpCheck();
	});
});
function otpCheck() {
	let otpCode = $("#otpCode").val();
	axios({
		url : "/account/checkOTP.do",
		method : "post",
		data : {
			otpCode : otpCode
		},
		headers : {
			"Content-Type" : "application/json; charset=utf-8"
		}
	}).then(function (response) {
		if (response.data == 'SUCCESS') {
			location.href = "/admin/basic/capacityRequest.do";
		}else {
			$("#error-text").text('인증번호가 올바르지 않습니다.');
		}
	});
}
</script>