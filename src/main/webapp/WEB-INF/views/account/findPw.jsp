<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="card overflow-hidden z-1">
  <div class="card-body p-0">
    <div class="row g-0 h-100">
      <div class="col-md-5 text-center bg-card-gradient">
        <div class="position-relative p-4 pt-md-5 pb-md-7" data-bs-theme="light">
          <div class="bg-holder bg-auth-card-shape" style="background-image:url(${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/half-circle.png);">
          </div>
          <!--/.bg-holder-->

          <div class="z-1 position-relative"><p class="link-light mb-4 font-sans-serif fs-5 d-inline-block fw-bolder">IRIS</p>
            <p class="opacity-75 text-white"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/find.png" alt="" width="200" /></p>
          </div>
        </div>
<!--         <div class="mt-3 mb-4 mt-md-4 mb-md-5" data-bs-theme="light"> -->
<!--           <p class="mb-0 mt-4 mt-md-5 fs-10 fw-semi-bold text-white opacity-75">Read our <a class="text-decoration-underline text-white" href="#!">terms</a> and <a class="text-decoration-underline text-white" href="#!">conditions </a></p> -->
<!--         </div> -->
      </div>
      <div class="col-md-7 d-flex flex-center">
        <div class="p-4 p-md-5 flex-grow-1">
          <div class="text-center text-md-start">
            <h4 class="mb-0"> 비밀번호를<br> 잊어버리셨나요?</h4> <br> 
            <p class="mb-4">이메일을 입력하면 재설정 링크를 보내드립니다.</p>
          </div>
          <div class="row justify-content-center">
            <div class="col-sm-8 col-md">
              <form class="mb-3" id="findPwForm" action="/account/findPw.do" method="post">
                <input class="form-control" type="email" name="memEmail" placeholder="Email address" />
                <div class="mb-3"></div>
                <button class="btn btn-primary d-block w-100 mt-3" type="button" id="findPwBtn">Send reset link</button>
              </form>
              <div class="text-center text-danger fs-6" id="result"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function () {
	var findPwForm = $("#findPwForm");
	var findPwBtn = $("#findPwBtn");
	var input = $("input"); 

	input.on("keydown", function (event) {
		if (event.keyCode == 13) { 
			event.preventDefault(); 
			findPwForm.submit();
		}
	});

	findPwBtn.on("click", function () {
		findPwForm.submit(); 
	});
});
</script>
