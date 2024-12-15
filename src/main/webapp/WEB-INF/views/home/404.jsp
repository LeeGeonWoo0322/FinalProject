<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

  <head>
    <meta charset="UTF-8">


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>Falcon | Dashboard &amp; Web App Template</title>


    <!-- ===============================================-->
    <!--    Favicons-->
    <!-- ===============================================-->
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/resources/design/public/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/resources/design/public/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/resources/design/public/assets/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/design/public/assets/img/favicons/favicon.ico">
    <link rel="manifest" href="../../assets/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/resources/design/public/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <script src="${pageContext.request.contextPath}/resources/design/public/assets/js/config.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/simplebar/simplebar.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/design/public/vendors/simplebar/simplebar.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/design/public/assets/css/theme-rtl.css" rel="stylesheet" id="style-rtl">
	<link href="${pageContext.request.contextPath}/resources/design/public/assets/css/theme.css" rel="stylesheet" id="style-default">
	<link href="${pageContext.request.contextPath}/resources/design/public/assets/css/user-rtl.css" rel="stylesheet" id="user-style-rtl">
	<link href="${pageContext.request.contextPath}/resources/design/public/assets/css/user.css" rel="stylesheet" id="user-style-default">
    
  </head>


  <body>

    <!-- ===============================================-->
    <!--    Main Content-->
    <!-- ===============================================-->
    <main class="main" id="top">
      <div class="container" data-layout="container">
        <div class="row flex-center min-vh-100 py-6 text-center">
          <div class="col-sm-10 col-md-8 col-lg-6 col-xxl-5"><a class="d-flex flex-center mb-4" href="/"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/falcon.png" alt="" width="58" /><span class="font-sans-serif text-primary fw-bolder fs-4 d-inline-block">IRIS</span></a>
            <div class="card">
              <div class="card-body p-4 p-sm-5">
                <div class="fw-black lh-1 text-300 fs-error">404</div>
                <p class="lead mt-4 text-800 font-sans-serif fw-semi-bold w-md-75 w-xl-100 mx-auto">The page you're looking for is not found.</p>
                <hr />
                <p>Make sure the address is correct and that the page hasn't moved. If you think this is a mistake, <a href="mailto:info@exmaple.com">contact us</a>.</p><a id="backBtn" class="btn btn-primary btn-sm mt-3"><span class="fas fa-home me-2"></span>이전화면으로 가기</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    

    <!-- ===============================================-->
    <!--    JavaScripts-->
    <!-- ===============================================-->
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/popper/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/anchorjs/anchor.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/is/is.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/echarts/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/fontawesome/all.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/lodash/lodash.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/vendors/list.js/list.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/design/public/assets/js/theme.js"></script>

  </body>
  <script type="text/javascript">
  $(document).ready(function() {
      $('#backBtn').on('click', function() {
              history.back();
          } else {
              window.location.href = "/";
          }
      });
  });
  </script>

</html>