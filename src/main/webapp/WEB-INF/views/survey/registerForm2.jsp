<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- sidebar 있던자리 -->
<style>
#questionModal {
	display: none;
	position: fixed; /* 스크롤해도 고정되도록 설정 */
	z-index: 999; /* 다른 요소 위에 나타나도록 설정 */
	left: 0;
	top: 0;
	width: 100%; /* 화면 전체를 덮도록 설정 */
	height: 100%;
}

/* 모달창 콘텐츠 박스 */
.modal-content {
	position: absolute;
	top: 30%; /* 화면 가운데 배치 */
	left: 50%;
	transform: translate(-50%, -50%); /* 화면 가운데로 이동 */
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
	width: 50%; /* 너비 설정 */
	max-width: 600px; /* 최대 너비 제한 */
}

.makeQuestion {
	max-width: 1200px;
	max-height: 500px; /* 원하는 높이로 설정 */
	overflow-y: auto; /* 세로 스크롤 추가 */
	overflow-x: hidden; /* 가로 스크롤은 필요 없으므로 숨김 */
	border: 1px solid #ccc; /* 가시적인 테두리 */
}
</style>

<!-- ===============================================-->
<!--    modal 시작    -->
<!-- ===============================================-->
<div id="questionModal" style="display: none;">
	<div class="modal-content">
		<span class="close">&times;</span>
		<h2>문항 추가</h2>
		<form id="questionForm">
			<label for="qContent">질문:</label> <input type="text" id="qContent" name="qContent" style="width: 90%;"><br>
			<br> <label for="qType">설문 문항 타입:</label>
			<select id="qType" name="qType">
				<option disabled selected>선택해주세요</option>
				<option value="textType">텍스트형</option>
				<option value="selectType">선택형</option>
			</select>

			<!-- 문항 타입에 따라 동적으로 추가될 영역 -->
			<div id="dynamicFields"></div>

			<button type="button" id="addQuestionBtn">추가</button>
		</form>
	</div>
</div>
<!-- ===============================================-->
<!--    modal 끝    -->
<!-- ===============================================-->


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->
<div style="margin: 20px; font-family: Arial, sans-serif;">
    <h3 style="color: #444; font-weight: bold;">설문 문항 작성</h3>
    <div style="background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); width: 1050px">  
        <form action="" style="display: flex; flex-direction: column;">
            <label for="survIntro" style="margin-top: 10px; font-weight: bold;">시작 안내 문구</label>
            <div style="display: flex; align-items: center; margin-bottom: 20px;">
                <input type="text" id="survIntro" name="survIntro" style="padding: 10px; border: 1px solid #ccc; border-radius: 4px; flex: 1; margin-right: 10px;" placeholder="설문 시작 안내를 입력하세요" />
                <button type="button" style="background-color: #f0f0f0; color: #333; border: 1px solid #ccc; padding: 10px 15px; border-radius: 4px; cursor: pointer;">
                    파일 첨부
                </button>
            </div>

            <div class="makedQuestion"></div>
            <button type="button" id="addQBtn" style="background-color: #f0f0f0; color: #333; border: 1px solid #ccc; padding: 10px 15px; border-radius: 4px; cursor: pointer;">
                문항 추가
            </button>
        </form>
    </div>
    <div style="margin-top: 20px;">
        <button style="background-color: black; color: white; border: none; padding: 10px 15px; border-radius: 4px; cursor: pointer; margin-right: 10px;">
            등록
        </button>
        <button style="background-color: white; color: black; border: 1px solid #ccc; padding: 10px 15px; border-radius: 4px; cursor: pointer;">
            취소
        </button>
    </div>
</div>



<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    설정 시작    -->
<!-- ===============================================-->
<div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1" aria-labelledby="settings-offcanvas">
	<div class="offcanvas-header settings-panel-header justify-content-between bg-shape">
		<div class="z-1 py-1">
			<div class="d-flex justify-content-between align-items-center mb-1">
				<h5 class="text-white mb-0 me-2">
					<span class="fas fa-palette me-2 fs-9"></span>Settings
				</h5>
				<button class="btn btn-primary btn-sm rounded-pill mt-0 mb-0" data-theme-control="reset" style="font-size: 12px">
					<span class="fas fa-redo-alt me-1" data-fa-transform="shrink-3"></span>Reset
				</button>
			</div>
			<p class="mb-0 fs-10 text-white opacity-75">Set your own customized style</p>
		</div>
		<div class="z-1" data-bs-theme="dark">
			<button class="btn-close z-1 mt-0" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
	</div>
	<div class="offcanvas-body scrollbar-overlay px-x1 h-100" id="themeController">
		<h5 class="fs-9">Color Scheme</h5>
		<p class="fs-10">Choose the perfect color mode for your app.</p>
		<div class="btn-group d-block w-100 btn-group-navbar-style">
			<div class="row gx-2">
				<div class="col-4">
					<input class="btn-check" id="themeSwitcherLight" name="theme-color" type="radio" value="light" data-theme-control="theme" /> <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherLight"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-default.jpg" alt="" /></span><span class="label-text">Light</span></label>
				</div>
				<div class="col-4">
					<input class="btn-check" id="themeSwitcherDark" name="theme-color" type="radio" value="dark" data-theme-control="theme" /> <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherDark"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-dark.jpg" alt="" /></span><span class="label-text"> Dark</span></label>
				</div>
				<div class="col-4">
					<input class="btn-check" id="themeSwitcherAuto" name="theme-color" type="radio" value="auto" data-theme-control="theme" /> <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherAuto"> <span class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-auto.jpg" alt="" /></span><span class="label-text"> Auto</span></label>
				</div>
			</div>
		</div>
		<hr />
		<div class="d-flex justify-content-between">
			<div class="d-flex align-items-start">
				<img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/left-arrow-from-left.svg" width="20" alt="" />
				<div class="flex-1">
					<h5 class="fs-9">RTL Mode</h5>
					<p class="fs-10 mb-0">Switch your language direction</p>
					<a class="fs-10" href="documentation/customization/configuration.html">RTL Documentation</a>
				</div>
			</div>
			<div class="form-check form-switch">
				<input class="form-check-input ms-0" id="mode-rtl" type="checkbox" data-theme-control="isRTL" />
			</div>
		</div>
		<hr />
		<div class="d-flex justify-content-between">
			<div class="d-flex align-items-start">
				<img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/arrows-h.svg" width="20" alt="" />
				<div class="flex-1">
					<h5 class="fs-9">Fluid Layout</h5>
					<p class="fs-10 mb-0">Toggle container layout system</p>
					<a class="fs-10" href="documentation/customization/configuration.html">Fluid Documentation</a>
				</div>
			</div>
			<div class="form-check form-switch">
				<input class="form-check-input ms-0" id="mode-fluid" type="checkbox" data-theme-control="isFluid" />
			</div>
		</div>
		<hr />
		<div class="d-flex align-items-start">
			<img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/paragraph.svg" width="20" alt="" />
			<div class="flex-1">
				<h5 class="fs-9 d-flex align-items-center">Navigation Position</h5>
				<p class="fs-10 mb-2">Select a suitable navigation system for your web application</p>
				<div>
					<select class="form-select form-select-sm" aria-label="Navbar position" data-theme-control="navbarPosition">
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
		<p class="fs-10 mb-0">Switch between styles for your vertical navbar</p>
		<p>
			<a class="fs-10" href="modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See Documentation</a>
		</p>
		<div class="btn-group d-block w-100 btn-group-navbar-style">
			<div class="row gx-2">
				<div class="col-6">
					<input class="btn-check" id="navbar-style-transparent" type="radio" name="navbarStyle" value="transparent" data-theme-control="navbarStyle" /> <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-transparent"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/default.png" alt="" /><span class="label-text"> Transparent</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-inverted" type="radio" name="navbarStyle" value="inverted" data-theme-control="navbarStyle" /> <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-inverted"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/inverted.png" alt="" /><span class="label-text"> Inverted</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-card" type="radio" name="navbarStyle" value="card" data-theme-control="navbarStyle" /> <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-card"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/card.png" alt="" /><span class="label-text"> Card</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-vibrant" type="radio" name="navbarStyle" value="vibrant" data-theme-control="navbarStyle" /> <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-vibrant"> <img class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/vibrant.png" alt="" /><span class="label-text"> Vibrant</span></label>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ===============================================-->
<!--    설정 끝    -->
<!-- ===============================================-->
<script>

$(function() {
    // 모달창 열기 및 닫기
    var modal = $("#questionModal");
    var addQBtn = $("#addQBtn");
    var closeModal = $(".close");

    // 문항 추가 버튼 클릭 시 모달창 열기
    addQBtn.on("click", function() {
        modal.show();
    });

    // 모달 닫기 버튼 클릭 시 모달창 닫기
    closeModal.on("click", function() {
        modal.hide();
        $("#dynamicFields").empty();
    	$('#qType').val('');
    	$('#qContent').val('');
    });

    // 설문 문항 타입에 따라 동적으로 필드 추가
   $("#qType").on("change", function() {
	    var selectedValue = $(this).val();
	    var dynamicFields = $("#dynamicFields");
	    dynamicFields.empty(); // 기존 필드 초기화
	
	    if (selectedValue === "textType") {
	        // 텍스트형 입력 칸 추가
	        dynamicFields.append();
	    } else if (selectedValue === "selectType") {
	        // 선택형 입력 칸 추가
	        dynamicFields.append(`
	            <div id="optionFields">
	                <input type="text" name="option[]" class="optionInput" style="width: 90%;"><br>
	                <input type="button" id="addOptionBtn" value="여기를 누르면 선택지가 추가됩니다." style="width: 90%; text-align: center;">
	            </div>
	        `);  
	    }
	});

	// 선택지 추가 버튼 클릭 시 선택지 입력 칸 추가
	$(document).on("click", "#addOptionBtn", function() {
    var optionCount = $("#optionFields .optionInput").length + 1;

    // 새로 추가할 input 요소를 문자열로 정의
    var newInput = $(`
        <label for="option${optionCount}"></label>    
        <input type="text" name="option[${optionCount}]" class="optionInput" style="width: 90%;"><br>
    `);

    // 버튼 앞에 새 input 요소 삽입
    $(this).before(newInput);
  
    // 새로 추가된 input 요소에 포커스
    newInput.filter('input').focus();
});


    // 문항 추가 버튼 클릭 시 폼 데이터 처리
    $("#addQuestionBtn").on("click", function() {
    	if(!contentCheck()){
    		return;
    	}
    	
    	if ($("#qType").val() == "selectType"){
	    	if (!validateOptions()) {
	    		return; // 값이 없는 경우 이후 작업을 중단
	    	}
    	}
    	
//========================================================================================================================================================================================================================================================================================================
// 작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄 작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄   작업 표시줄
//========================================================================================================================================================================================================================================================================================================
        
		var formData = $("#questionForm").serializeArray();
        var qNo = $("div .makedQuestion > div").length+1;
        console.log(formData); // 데이터 확인
        
		var str = "";
		if ($("#qType").val() == "selectType") {  
		    str += "<div style='border: 1px solid #ccc; width: 1000px; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9;'>"; 
		    str += "<span style='font-size: 18px; font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>" + qNo + ". " + formData[0].value + "</span>"; 
		    for (let i = 2; i < formData.length; i++) {
		        str += "<div style='margin-bottom: 8px;'><input type='checkbox' style='margin-right: 10px;'><span style='font-size: 16px;'>" + formData[i].value + "</span></div>";
		    }
		    str += "</div>";	   
		} else {
		    str += "<div style='border: 1px solid #ccc; width: 1000px; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9;'>";   
		    str += "<span style='font-size: 18px; font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>" + qNo + ". " + formData[0].value + "</span>"; 
		    str += "<input type='text' style='width: calc(100% - 30px); padding: 10px; border: 1px solid #ccc; border-radius: 4px;'>";    
		    str += "</div>";
		}

		$("div.makedQuestion").append(str);
        
        
        // 모달창 닫기
        modal.hide();
        // 모달 초기화
        $("#dynamicFields").empty();
	   	$('#qType').val('');
	   	$('#qContent').val('');

        // 이후 추가적으로 서버로 데이터를 전송하거나 UI 업데이트를 할 수 있습니다.
    });

    // 모달창 외부 클릭 시 닫기
    $(window).on("click", function(event) {
        if ($(event.target).is(modal)) {
            modal.hide();
	        // 모달 초기화
	        $("#dynamicFields").empty();
	    	$('#qType').val('');
	    	$('#qContent').val('');
        }
    });
    
    
    function validateOptions() {
        // 모든 optionInput 요소를 가져옵니다.
        const options = $(".optionInput");
        let hasValue = false;
		const qContent = $("#qContent");
        // 각 입력 필드를 순회하여 비어있는 요소를 제거하고 값이 있는 요소가 있는지 확인합니다.
        options.each(function() {
            if ($(this).val().trim() === "") {
                // 비어있는 요소는 제거합니다.
                $(this).parent().remove(); // 부모 div를 제거합니다.
            } else {
                hasValue = true; // 값이 있는 요소가 발견됨
            }
        });

        // 값이 있는 요소가 하나도 없다면 경고를 띄우고 false를 반환합니다.
        if (!hasValue) {
            alert("값이 있는 선택지가 없습니다. 값을 입력해주세요.");
            return false; // 유효하지 않음을 나타냄
        }

        return true;
    }

    // qContent입력했는지 확인
    function contentCheck() {
		const qContent = $("#qContent");
        if (qContent.val().trim() === "") {
        	alert("질문을 입력해주세요");
        	return false;
        }
        return true;
    }
    
});
</script>


