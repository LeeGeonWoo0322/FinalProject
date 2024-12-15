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
        <div class="p-4 p-md-5 flex-grow-1">
          <div class="row flex-between-center">
            <div class="col-auto">
              <h3>로그인</h3>
            </div>
          </div>
          <form action="/login" method="post" id="loginForm">
            <div class="mb-3">
              <label class="form-label" for="card-email">Id</label>
              <input class="form-control" id="card-email" type="text" placeholder="Id" name="username" value="${member.memId }"/>
            </div>
            
            <div class="mb-1">
              <div class="d-flex justify-content-between">
                <label class="form-label" for="card-password">Password</label>
              </div>
              <input class="form-control" id="card-password" type="password" placeholder="Password" name="password"/>
            </div>
             
            <div class="row flex-between-center">
              <div class="col-auto">
                <div class="form-check mb-1">
                  <input class="form-check-input" type="checkbox" id="card-checkbox" name="remember-me"/>
                  <label class="form-check-label mb-0" for="card-checkbox">로그인 저장</label>
                </div>
              </div>
            </div>
            <div class="d-none" id="captchaImg">
	           	<div class="w-100">
	           		<img alt="" src="" class="w-100 img-thumbnail">
	           	</div>
	            <div class="d-flex flex-row mt-1" id="captchaForm">
					<div class="w-75" id="cap_line">
						<input type="text" id="captchaInput" name="captcha" placeholder="정답을 입력해주세요." title="정답을 입력해주세요." class="w-100 form-control" data-detect="code">
					</div>
					<div class="w-25 ps-2">
					    <button class="btn border border-1 rounded-3" type="button" id="reloadBtn">
					        <i class="bi bi-arrow-repeat"></i>
					    </button>
					</div>
				</div>
			</div>
            <div id="error-text" style="color: red;font-size: 15px;fon"></div>
            <div class="mb-2">
              <button class="btn btn-primary d-block w-100 mt-2" type="button" id="loginBtn">Log in</button>
            </div>
			<div class="d-flex flex-row justify-content-between">
			  <div class="w-50 text-center">
			    <a class="fs-10" href="/account/findId.do">ID 찾기</a>
			  </div>
			  <div class="w-50 text-center">
			    <a class="fs-10" href="/account/findPw.do">비밀번호 찾기</a>
			  </div>
			</div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function () {
	var cnt = 0;
	var loginBtn = $("#loginBtn");
	var loginForm = $("#loginForm");
	var login = $(".form-control");
	var idInput = $("#card-email");
	var pwInput = $("#card-password");
	var reloadBtn = $("#reloadBtn");
	var captchaKey = "";
	var captchaInput = $("#captchaInput");
	
	getCaptchaImage();

	login.on("keydown", function (event) {
		if(event.keyCode == 13){			// Enter 키를 눌렀을 때
			let idText = idInput.val();
			let pwText = pwInput.val();
			
			validation(idText,pwText);
		}
	});
	
	loginBtn.on("click", function () {
		let idText = idInput.val();
		let pwText = pwInput.val();
		
		validation(idText,pwText);
	});
	
	reloadBtn.on("click", function () {
		console.log("reload");
		getCaptchaImage();
	})
	
	function validation(id,pw){
		let memId = id;	// 아이디 값
		let memPw = pw;	// 비밀번호 값
		
		if (!memId.trim()) {
			$("#error-text").text("아이디를 입력해주세요.");
			idInput.focus();
			 return false;
		}
		
		if (!memPw.trim()) {
			$("#error-text").text("비밀번호를 입력해주세요.");
			pwInput.focus();
			 return false;
		}
		loginCheck(memId, memPw);
	}
	
	function loginCheck(id, pw) {
		$.ajax({
			url : "/account/loginCheck.do",
			method : "post",
			data : JSON.stringify({
				memId : id,
				memPw : pw
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				if (res) {
					if (cnt >= 5) {
						getCaptchaAnswer();
					} else {
						loginForm.submit();
					}
				} else {
					cnt++;
					if (cnt >= 5) {
						$("#captchaImg").attr("class", "d-block");
					}
					$("#error-text").text("아이디 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요.");
					return false;
				}
			}
		});
	}
	
	function getCaptchaImage(){
		$.ajax({
			url : "/account/createCaptcha.do",
			method : "get",
			success : function (res) {
				console.log(res);
				captchaKey = res.key;
				$("#captchaImg img").attr("src", "data:image/png;base64,"+res.Base64Image)
			}
		});
	}
	
	function getCaptchaAnswer() {
		let value = captchaInput.val();
		$.ajax({
			url : "/account/checkAnswer.do",
			method : "post",
			data : JSON.stringify({
				captchaKey : captchaKey,
				value : value
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				console.log(res);
				if (res) {
					loginForm.submit(); // 캡차가 맞으면 로그인 제출
				} else {
					getCaptchaImage();
					$("#error-text").text("캡차가 올바르지 않습니다. 다시 시도해주세요.");
				}
			}
		});
	}
	
});
</script>