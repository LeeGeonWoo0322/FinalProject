<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="card overflow-hidden z-1">
  <div class="card-body p-0">
    <div class="row g-0 h-100">
      <div class="col-md-5 text-center bg-card-gradient">
        <div class="position-relative p-4 pt-md-5 pb-md-7" data-bs-theme="light">
          <div class="bg-holder bg-auth-card-shape" style="background-image:url(${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/half-circle.png);"></div><!--/.bg-holder-->
          <div class="z-1 position-relative"><p class="link-light mb-4 font-sans-serif fs-5 d-inline-block fw-bolder">falcon</p>
            <p class="opacity-75 text-white">With the power of Falcon, you can now focus only on functionaries for your digital products, while leaving the UI design on us!</p>
          </div>
        </div>
        <div class="mt-3 mb-4 mt-md-4 mb-md-5" data-bs-theme="light">
          <p class="mb-0 mt-4 mt-md-5 fs-10 fw-semi-bold text-white opacity-75">Read our <a class="text-decoration-underline text-white" href="#!">terms</a> and <a class="text-decoration-underline text-white" href="#!">conditions </a></p>
        </div>
      </div>
      <div class="col-md-7 d-flex flex-center">
        <div class="p-4 p-md-5 flex-grow-1">
          <h3>Reset password</h3>
          <form class="mt-3" id="changePwForm" action="/account/changePw.do" method="post">
            <div class="mb-3"><label class="form-label" for="card-reset-password">New Password</label><input class="form-control" type="password" id="card-reset-password" name="memPw"></div>
            <div class="mb-3"><label class="form-label" for="card-reset-confirm-password">Confirm Password</label><input class="form-control" type="password" id="card-reset-confirm-password"></div>
            <button class="btn btn-primary d-block w-100 mt-3" type="button" id="changePwBtn">Set password</button>
          </form>
          <div class="text-center text-danger fs-8" id="notMatch"></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function () {
	var changePwForm = $("#changePwForm");
	var changePwBtn = $("#changePwBtn");
	var input = $(".input");
	
	changePwBtn.on("click", function () {
		var password1 = $("#card-reset-password").val();
		var password2 = $("#card-reset-confirm-password").val();
		
		if (password1 === password2) {
			changePwForm.submit();
		}else{
			$("#notMatch").text("비밀번호가 일치하지 않습니다.");
		}
	});
	
	input.on("keydown", function (event) {
		if (event.keyCode==13) {
			changePwForm.submit();
		}
	});
});
</script>