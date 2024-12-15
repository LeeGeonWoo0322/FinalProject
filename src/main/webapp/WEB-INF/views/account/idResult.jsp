<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card overflow-hidden z-1">
  <div class="card-body p-0">
    <div class="row g-0 h-100">
      <div class="col-md-5 text-center bg-card-gradient">
        <div class="position-relative p-4 pt-md-5 pb-md-7" data-bs-theme="light">
          <div class="bg-holder bg-auth-card-shape" style="background-image:url(${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/half-circle.png);">
          </div>
          <!--/.bg-holder-->

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
          <div class="text-center text-md-start">
            <h4 class="mb-0"> Forgot your Id?</h4>
            <p class="mb-4">Enter your email and we'll send you a reset link.</p>
          </div>
          <div class="row justify-content-center">
            <div class="col-sm-8 col-md">
              <div class="bg-200 p-2 mb-3 text-center">
              	<c:choose>
              	  <c:when test="${not empty error}">
              	  	<div>일치하는 정보가 없습니다.</div>
              	  </c:when>
              	  <c:otherwise>
	                <div>아이디 : <span class="text-primary">${memId }</span></div>
	                <div>입사일 : ${hireDate }</div>
              	  </c:otherwise>
              	</c:choose>
              </div>
                <button class="btn btn-primary d-block w-100 mt-3" type="button" id="findIdBtn">Send reset link</button>
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
	$("#findIdBtn").on("click", function () {
		location.href = "/account/login.do";
	});
});
</script>