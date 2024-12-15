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
          <div class="text-center"><img class="d-block mx-auto mb-4" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/16.png" alt="Email" width="100">
            <h3 class="mb-2">Please check your email!</h3>
            <p>An email has been sent to <strong>${email }</strong>. Please click on the <br class="d-none d-sm-block d-md-none">included link to reset <span class="white-space-nowrap">your password.</span></p><a class="btn btn-primary btn-sm mt-3" href="/account/login.do"><svg class="svg-inline--fa fa-chevron-left fa-w-10 me-1" data-fa-transform="shrink-4 down-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg="" style="transform-origin: 0.3125em 0.5625em;"><g transform="translate(160 256)"><g transform="translate(0, 32)  scale(0.75, 0.75)  rotate(0 0 0)"><path fill="currentColor" d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z" transform="translate(-160 -256)"></path></g></g></svg><!-- <span class="fas fa-chevron-left me-1" data-fa-transform="shrink-4 down-1"></span> Font Awesome fontawesome.com -->Return to login</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>