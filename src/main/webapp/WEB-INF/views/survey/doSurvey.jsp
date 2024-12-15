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
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>작성자 &nbsp; : &nbsp; ${thisSurvey.deptName} ${thisSurvey.memName } ${thisSurvey.posName }</span>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>설문기간 &nbsp; : &nbsp; ${fn:substring(thisSurvey.startDate,0,10) } ~ ${fn:substring(thisSurvey.endDate,0,10) }</span>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>결과 공개 여부 &nbsp; : &nbsp; 
			<c:choose>
           		<c:when test="${thisSurvey.publicYn == 'Y'}">
           			공개
           		</c:when>
           		<c:otherwise>
           			비공개
           		</c:otherwise>
           	</c:choose>
		</span>
		<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>개요&nbsp; : &nbsp; ${thisSurvey.survIntro }</span>
	</div>
	
	<c:forEach var="question" items="${thisSurvey.surveyQuestion }" varStatus="vs">
		<c:if test="${question.getQType() == '1'}">
			<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'> 
				<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>${question.QContent }</span>
				<div style='margin-bottom: 8px;'>
					<c:forEach items="${question.surveyChoice }" var="Choice">
						<c:if test="${question.singleOrMulti == 1}">
							<input type='radio' class="selectTypeResponse" name='${question.QNo }' value="${Choice.choiceNo }" style='margin-right: 10px;'><span class="me-3" style='font-size: 16px;'>${Choice.choiceContent }</span>
						</c:if>
						<c:if test="${question.singleOrMulti == 2}">
							<input type='checkbox' class="selectTypeResponse" name='${question.QNo }' value="${Choice.choiceNo }" style='margin-right: 10px;'><span class="me-3" style='font-size: 16px;'>${Choice.choiceContent }</span>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<c:if test="${question.getQType() == '2'}">
			<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'>   
				<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>${question.QContent }</span>
				<input type='text' name='${question.QNo }' class='textTypeResponse form-control form-control-sm w-50'>
			</div>
		</c:if>
	</c:forEach>
	<div class="d-flex flex-row justify-content-center align-items-left my-2" style="height: 50px; margin-right: 40px;">
        <div>
	        <a id="submitSurvey" class="btn btn-info d-flex align-items-left px-2 py-0 me-3">
	        	<div style="height: 30px; line-height: 30px">제출</div>
	        </a>
        </div>
        <div>
        	<a id="cancelSuevey" class="btn btn-falcon-default d-flex align-items-left px-2 py-0">
	        	<div style="height: 30px; line-height: 30px">취소</div>
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


<script>
$("#tableExample2").parent().attr("style", "height: 100%;");


$(function(){
	// 제출 버튼 클릭
	var surveyNo = ${thisSurvey.survNo };
	console.log(surveyNo);
	
	$("#submitSurvey").on("click",function(){
		var stop = 0;
		
		$(".selectTypeResponse").each(function() {
            var questionNo = $(this).attr("name");  // 질문 번호
		
            var questionInputs = $("input[name='" + questionNo + "']:checked");  // 해당 질문의 체크된 항목

            if (questionInputs.length === 0) {
                // 체크된 항목이 없으면 경고 표시하고 제출 막기
                requiredAlert("모든 질문에 대해 응답해주십시오", isAlertVisible);
                $(this).focus();
                stop = 1;
                return false;  
            }
        });
		
		if(stop == 1){
			return false;
		}
		
		var questionResponse = [];
		
		// 다수의 텍스트형 질문 답변을 배열로 받음
		$(".textTypeResponse").each(function() {
		var value = $(this).val(); // 각 질문의 답변
		if (value === "" || value === null) {
		    allFilled = false; // 비어있는 문항이 있으면 false로 설정
		    requiredAlert("모든 질문에 대해 응답해주십시오", isAlertVisible);
		    $(this).focus();
		    stop = 1;
		    return false; // each 루프를 종료
		}
			var name = $(this).attr("name");	// 각 질문의 질문번호
		    questionResponse.push({ qNo: name, respContent: value, survNo : surveyNo }); // 객체 형태로 추가
		});
		
		if(stop == 1){
			return false;
		}
		
		// 다수의 선택형 질문 답변을 배열로 받음
		$(".selectTypeResponse:checked").each(function() {
		    var value = $(this).val(); 
		    var name = $(this).attr("name");
		    questionResponse.push({ qNo: name, respContent: value, survNo : surveyNo });
		});
		
		console.log(questionResponse);
		console.log(questionResponse);
		
		$.ajax({
			url : "/survey/submitResponse",
			type : "POST",
			data : JSON.stringify(questionResponse),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log("잘 다녀왔지 그래그래");
				location.href="/survey/main";
			},error: function(xhr){
				console.error("잘 좀 해봐 뽕@알아");
			}
		});

	});
	
	// 취소 버튼 클릭
	$("#cancelSuevey").on("click",function(){
		console.log("호출됨");
		if(confirm("작성을 취소하시겠습니까?")){
			location.href="/survey/main";
		}
	});
	
	
	let isAlertVisible = false; // 알러트 창 변경!
	
	function requiredAlert(comment, isAlertVisible) {
	    let alertBox = $('#alertBox');
	    $("#alertDiv").html(comment);
	    if (!isAlertVisible) { // 알림이 보이지 않을 때만 실행
	        isAlertVisible = true; // 알림을 표시 중임을 설정
	        alertBox.css('display', "block");
	        setTimeout(function() {
	            alertBox.css('display', "none");
	            isAlertVisible = false; // 알림이 사라진 후 플래그를 초기화
	        }, 2000);
	    }
	    return false;
	}
	
	
	
	
	
	
	
	
});
</script>