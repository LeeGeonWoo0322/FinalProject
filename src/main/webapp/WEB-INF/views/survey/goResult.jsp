<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->

<div id="tableExample2" style="flex: 1 0 auto" class="p-3 border-start boarder-start-1">
	<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'>
		<div id="alertBox" style="position: fixed; top: 300px; left: 63%; transform: translateX(-50%); z-index: 1000; display: none;">
		   <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
		</div>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px; font-size: x-large; text-align: center;'>${thisSurvey.survTitle }</span>
<!-- 		<span style='font-weight: bold; color: #333; display: inline;'>작성자 : </span> -->
<!-- 		<span style='font-weight: normal; font-size: smaller; color: #333; display: inline;'>${thisSurvey.deptName} ${thisSurvey.memName} ${thisSurvey.posName}</span> -->
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>작성자 &nbsp; : &nbsp; 인사부 조돌복 부장</span>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>설문기간 &nbsp; : &nbsp; 2024-11-19 ~ 2024-12-09</span>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>결과 공개 여부 &nbsp; : &nbsp; 공개</span>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>개요&nbsp; : &nbsp; 회사의 가치와 문화가 실제 업무에 반영되는지에 대한 만족도 조사</span>
	</div>
	
	<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'> 
		<p style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>1. 조직의 가치관(예: 팀워크, 책임감, 혁신 등)이 일상 업무에 잘 반영되어 있다고 생각하십니까?</p>
		<div style="margin-bottom: 8px; display: flex;">
			<div style="flex: 0 0 20%;">
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">매우 그렇다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">그렇다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">보통이다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">그렇지 않다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">매우 그렇지 않다</p>
			</div>
			<div style="flex: 0 0 20%;">  
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">28%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">25%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">19%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">16%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">13%</p>
			</div>
			<div style="display: flex; flex: 0 0 60%;">
				<div class="d-flex" style="max-height: 300px; max-width: 400px;">
					<canvas class="myDoughnutChart" width="400" height="300" style="display: block;" data-chart="[10,7,6,6,3]" data-labels='["매우 그렇다","그렇다","보통이다","그렇지 않다","매우 그렇지 않다"]'></canvas>
				</div>
			</div>
		</div>
	</div>
	<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'> 
		<p style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>2. 조직의 가치관과 나의 개인 가치관이 잘 맞는다고 느끼십니까?</p>
		<div style="margin-bottom: 8px; display: flex;">
			<div style="flex: 0 0 20%;">
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">매우 그렇다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">그렇다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">보통이다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">그렇지 않다</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">매우 그렇지 않다</p>
			</div>
			<div style="flex: 0 0 20%;">
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">31%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">22%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">19%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">18%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">10%</p>
			</div>
			<div style="display: flex; flex: 0 0 60%;">
				<div class="d-flex" style="max-height: 300px; max-width: 400px;">
					<canvas class="myDoughnutChart" width="400" height="300" style="display: block;" data-chart="[9,8,6,5,4]" data-labels='["매우 그렇다","그렇다","보통이다","그렇지 않다","매우 그렇지 않다"]'></canvas>
				</div>
			</div>
		</div>
	</div>
	<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'> 
		<p style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>3. 회사의 가치관 중에서 본인이 중요하다고 생각하는 것을 모두 선택해 주세요.</p>
		<div style="margin-bottom: 8px; display: flex;">
			<div style="flex: 0 0 20%;">
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">팀워크</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">책임감</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">존중과 배려</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">고객 중심</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">지속 가능한 성장</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">투명성과 신뢰</p>
			</div>
			<div style="flex: 0 0 20%;">
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">18%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">22%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">15%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">10%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">25%</p><br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">10%</p>
			</div>
			<div style="display: flex; flex: 0 0 60%;">
				<div class="d-flex" style="max-height: 300px; max-width: 400px;">
					<canvas class="myDoughnutChart" width="400" height="300" style="display: block;" data-chart="[18,22,15,10,25,10]" data-labels='["팀워크","책임감","존중과 배려","고객 중심","지속 가능한 성장","투명성과 신뢰"]'></canvas>  
				</div>
			</div>
		</div>
	</div>
	<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'>   
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>4. 사내 문화 또는 가치관에 대해 개선이 필요하다고 생각되는 부분이 있다면 자유롭게 작성해 주세요.</span>
		<div style="margin-bottom: 8px; display: flex;">
			<div style="flex: 0 0 20%;">
				<br/>
				<br/>
				<br/>
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">응답함</p><br/>
				<br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">응답하지 않음</p><br/>
				<br/>
			</div>
			<div style="flex: 0 0 20%;">
				<br/>
				<br/>
				<br/>
				<br/><p class="me-3 ms-3" style="font-size: 16px; margin: 0;">69%</p><br/>
				<br/>
				<p class="me-3 ms-3" style="font-size: 16px; margin: 0;">31%</p><br/>
				<br/>
			</div>
			<div style="display: flex; flex: 0 0 60%;">
				<div class="d-flex" style="max-height: 300px; max-width: 400px;">
					<canvas class="myDoughnutChart" width="400" height="300" style="display: block;" data-chart="[22,10]" data-labels='["응답함","응답하지 않음"]'></canvas>  
				</div>
			</div>
		</div>
	</div>
	<div class="d-flex flex-row justify-content-center align-items-left my-2" style="height: 50px; margin-right: 40px;">
		<div>
			<a id="cancelSuevey" class="btn btn-falcon-default d-flex align-items-left px-2 py-0">
				<div style="height: 30px; line-height: 30px">돌아가기</div>
			</a>
	    </div>
    </div>
</div>

<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->



<!-- ===============================================-->
<!--    설정 시작    -->
<!-- ===============================================-->
<div class="offcanvas offcanvas-end settings-panel border-0"
	id="settings-offcanvas" tabindex="-1"
	aria-labelledby="settings-offcanvas">
	<div
		class="offcanvas-header settings-panel-header justify-content-between bg-shape">
		<div class="z-1 py-1">
			<div class="d-flex justify-content-between align-items-center mb-1">
				<h5 class="text-white mb-0 me-2">
					<span class="fas fa-palette me-2 fs-9"></span>Settings
				</h5>
				<button class="btn btn-primary btn-sm rounded-pill mt-0 mb-0"
					data-theme-control="reset" style="font-size: 12px">
					<span class="fas fa-redo-alt me-1" data-fa-transform="shrink-3"></span>Reset
				</button>
			</div>
			<p class="mb-0 fs-10 text-white opacity-75">Set your own
				customized style</p>
		</div>
		<div class="z-1" data-bs-theme="dark">
			<button class="btn-close z-1 mt-0" type="button"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
	</div>
	<div class="offcanvas-body scrollbar-overlay px-x1 h-100"
		id="themeController">
		<h5 class="fs-9">Color Scheme</h5>
		<p class="fs-10">Choose the perfect color mode for your app.</p>
		<div class="btn-group d-block w-100 btn-group-navbar-style">
			<div class="row gx-2">
				<div class="col-4">
					<input class="btn-check" id="themeSwitcherLight" name="theme-color"
						type="radio" value="light" data-theme-control="theme" /> <label
						class="btn d-inline-block btn-navbar-style fs-10"
						for="themeSwitcherLight"> <span
						class="hover-overlay mb-2 rounded d-block"><img
							class="img-fluid img-prototype mb-0"
							src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-default.jpg"
							alt="" /></span><span class="label-text">Light</span></label>
				</div>
				<div class="col-4">
					<input class="btn-check" id="themeSwitcherDark" name="theme-color"
						type="radio" value="dark" data-theme-control="theme" /> <label
						class="btn d-inline-block btn-navbar-style fs-10"
						for="themeSwitcherDark"> <span
						class="hover-overlay mb-2 rounded d-block"><img
							class="img-fluid img-prototype mb-0"
							src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-dark.jpg"
							alt="" /></span><span class="label-text"> Dark</span></label>
				</div>
				<div class="col-4">
					<input class="btn-check" id="themeSwitcherAuto" name="theme-color"
						type="radio" value="auto" data-theme-control="theme" /> <label
						class="btn d-inline-block btn-navbar-style fs-10"
						for="themeSwitcherAuto"> <span
						class="hover-overlay mb-2 rounded d-block"><img
							class="img-fluid img-prototype mb-0"
							src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-auto.jpg"
							alt="" /></span><span class="label-text"> Auto</span></label>
				</div>
			</div>
		</div>
		<hr />
		<div class="d-flex justify-content-between">
			<div class="d-flex align-items-start">
				<img class="me-2"
					src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/left-arrow-from-left.svg"
					width="20" alt="" />
				<div class="flex-1">
					<h5 class="fs-9">RTL Mode</h5>
					<p class="fs-10 mb-0">Switch your language direction</p>
					<a class="fs-10"
						href="documentation/customization/configuration.html">RTL
						Documentation</a>
				</div>
			</div>
			<div class="form-check form-switch">
				<input class="form-check-input ms-0" id="mode-rtl" type="checkbox"
					data-theme-control="isRTL" />
			</div>
		</div>
		<hr />
		<div class="d-flex justify-content-between">
			<div class="d-flex align-items-start">
				<img class="me-2"
					src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/arrows-h.svg"
					width="20" alt="" />
				<div class="flex-1">
					<h5 class="fs-9">Fluid Layout</h5>
					<p class="fs-10 mb-0">Toggle container layout system</p>
					<a class="fs-10"
						href="documentation/customization/configuration.html">Fluid
						Documentation</a>
				</div>
			</div>
			<div class="form-check form-switch">
				<input class="form-check-input ms-0" id="mode-fluid" type="checkbox"
					data-theme-control="isFluid" />
			</div>
		</div>
		<hr />
		<div class="d-flex align-items-start">
			<img class="me-2"
				src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/paragraph.svg"
				width="20" alt="" />
			<div class="flex-1">
				<h5 class="fs-9 d-flex align-items-center">Navigation Position</h5>
				<p class="fs-10 mb-2">Select a suitable navigation system for
					your web application</p>
				<div>
					<select class="form-select form-select-sm"
						aria-label="Navbar position" data-theme-control="navbarPosition">
						<option value="vertical">Vertical</option>
						<option value="top">Top</option>
						<option value="combo">Combo</option>
						<option value="double-top">Double Top</option>
					</select>
				</div>
			</div>
		</div>
		<hr />
		<h5 class="fs-9 d-flex align-items-center">Vertical Navbar Style</h5>
		<p class="fs-10 mb-0">Switch between styles for your vertical
			navbar</p>
		<p>
			<a class="fs-10"
				href="modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See
				Documentation</a>
		</p>
		<div class="btn-group d-block w-100 btn-group-navbar-style">
			<div class="row gx-2">
				<div class="col-6">
					<input class="btn-check" id="navbar-style-transparent" type="radio"
						name="navbarStyle" value="transparent"
						data-theme-control="navbarStyle" /> <label
						class="btn d-block w-100 btn-navbar-style fs-10"
						for="navbar-style-transparent"> <img
						class="img-fluid img-prototype"
						src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/default.png"
						alt="" /><span class="label-text"> Transparent</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-inverted" type="radio"
						name="navbarStyle" value="inverted"
						data-theme-control="navbarStyle" /> <label
						class="btn d-block w-100 btn-navbar-style fs-10"
						for="navbar-style-inverted"> <img
						class="img-fluid img-prototype"
						src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/inverted.png"
						alt="" /><span class="label-text"> Inverted</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-card" type="radio"
						name="navbarStyle" value="card" data-theme-control="navbarStyle" />
					<label class="btn d-block w-100 btn-navbar-style fs-10"
						for="navbar-style-card"> <img
						class="img-fluid img-prototype"
						src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/card.png"
						alt="" /><span class="label-text"> Card</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-vibrant" type="radio"
						name="navbarStyle" value="vibrant"
						data-theme-control="navbarStyle" /> <label
						class="btn d-block w-100 btn-navbar-style fs-10"
						for="navbar-style-vibrant"> <img
						class="img-fluid img-prototype"
						src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/vibrant.png"
						alt="" /><span class="label-text"> Vibrant</span></label>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ===============================================-->
<!--    설정 끝    -->
<!-- ===============================================-->

 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$("#tableExample2").parent().attr("style", "height: 100%;");

$(".myDoughnutChart").each(function(){
	var ctx = $(this)[0].getContext('2d');
	var data = $(this).data('chart');
	var labels = $(this).data('labels');
	var myDoughnutChart = new Chart(ctx, {
	  type: 'doughnut',
	  data: {
	    labels: labels, // 차트에 표시할 항목들
	    datasets: [{
	      label: 'My Doughnut Chart',
	      data: data, // 각 항목의 값
	      backgroundColor: ['#A8D0E6', '#E1BEE7', '#B9F6CA', '#FFF9C4', '#FAD0C9', "#FFD1B5"], // 항목들의 색상
	      hoverOffset: 4 // 마우스 오버시 이동 효과
	    }]
	  },
	  options: {
	    responsive: true,
	    plugins: {
	      legend: {
	        position: 'right',
	        labels: {
	            usePointStyle: true, // 포인트 스타일 사용 (기본적인 사각형 대신 원으로 표시됨)
	            boxWidth: 10, // 레전드 항목의 크기 조정
	            padding: 20 // 레전드 항목 사이의 간격
	          }
	      },
	      tooltip: {
	        callbacks: {
	          label: function(tooltipItem) {
	            return tooltipItem.label + ': ' + tooltipItem.raw;
	          }
	        }
	      }
	    }
	  }
	});
});


</script>
