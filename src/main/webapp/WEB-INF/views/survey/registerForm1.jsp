<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--  style 시작 -->

<style>
#questionModal {
	display: none;
	position: fixed; /* 스크롤해도 고정되도록 설정 */
	z-index: 999; /* 다른 요소 위에 나타나도록 설정 */
	left: 0;
	top: 20%;
	width: 100%; /* 화면 전체를 덮도록 설정 */
	height: 100%;
}

/* 모달창 콘텐츠 박스 */
.modal-contentA {
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
  

<!--  style 끝 -->

  
<div id="tableExample2" style="flex: 1 0 auto" class="p-3">
	<div>
	    <form action="registerForm2" method="post"> 
		
		    
			<!-- 아래의 나눠진 영역 -->
		    <div style="display: flex; justify-content: space-between; margin-top: 15px; height: 600px; border: 1px solid #ced4da" class="mb-3">
		        <div style="flex: 1; padding: 10px;">
		        
		        	<!-- 설문 제목  -->
				    <div style="margin-bottom: 15px;">
				        <label for="survTitle" style="font-weight: bold; display: block; margin-bottom: 5px;">설문 제목</label>
				        <input type="text" class="form-control form-control-sm" id="survTitle" name="survTitle" style="width: 100%;">
				        <span id="titleError" style="color: red; font-size: 12px;"></span>
				    </div>
				    
				    <!-- 시작안내 문구 -->
				    <label for="survIntro" style="margin-top: 10px; font-weight: bold;">시작 안내 문구</label>
		            <div style="display: flex; align-items: center;">
		                <input type="text" class="form-control form-control-sm" id="survIntro" name="survIntro" style="width: 100%" placeholder="설문 시작 안내를 입력하세요" />
		            </div>
		                <div class="btn border border-black me-1 px-1 py-0 mb-3" style="height: 30px; line-height: 30px;" onclick="$('#attachment').click()"> 
		                	파일첨부
		                </div>
		                <input type="file" id="attachment" style="display: none;">
		            
		            <!-- 설문기간 선택 -->
					<div style="margin-bottom: 15px;">
				        <label style="font-weight: bold; display: block; margin-bottom: 5px;">설문 기간</label>
				        <div style="display: flex; align-items: center;">
				            <input type="date" id="startDate" name="startDate" style="flex: 1; padding: 2px; border-radius: 5px; border: 1px solid #ccc; margin-right: 5px;">
				            ~
				            <input type="date" id="endDate" name="endDate" style="flex: 1; padding: 2px; border-radius: 5px; border: 1px solid #ccc; margin-left: 5px;">
				        </div>
			            <span id="setTimeError" style="color: red; font-size: 12px;"></span>
				    </div>
				    <div style="margin-bottom: 15px;">
				        <label style="font-weight: bold; display: block; margin-bottom: 5px;">설문 대상</label>
				        <div style="margin-bottom: 5px;">
				            <div class="form-group d-flex align-items-center mt-3 mb-3">
					            <input type="radio" name="surveyAttendee" checked="checked" value="AllDepart"/>
					            <span id="attendeeDepart"></span>
							    <select id="selectDepart" name="depart" class="form-control form-control-sm ms-2" style="width: 20%; text-align: center;">
							        <option value="default" disabled selected>부서 선택</option>
							        <option value="100">부서 전체</option> 
							        <c:forEach var="department" items="${departmentList }">
							        	<option value="${department.deptNo }">${department.deptName }</option>   
							        </c:forEach>
							        
							    </select>
							</div>
				        </div>
				        <div>
				            <input type="radio" name="surveyAttendee"/>
				            직접선택 
				            <div class="btn border border-black px-1 py-0" style="height: 30px; line-height: 30px;" id="organModalOpenBtn">  
		                		조직도
		                	</div>
				        </div>
				        <div id="SurveyTargetList">
				        	
				        </div>
				    </div>
				
				    <div style="margin-bottom: 15px;">
				        <label style="font-weight: bold; display: block; margin-bottom: 5px;">결과 공개</label>
				        <input type="radio" id="publicYn" name="publicYn" value="Y"> 공개
				        <input type="radio" id="publicYn" name="publicYn" value="N" checked="checked"> 비공개
				    </div>
				
				    <div style="margin-bottom: 15px;">
				        <label style="font-weight: bold; display: block; margin-bottom: 5px;">수정 허용</label>
				        <input type="radio" id="updateYn" name="updateYn" value="Y"> 허용
				        <input type="radio" id="updateYn" name="updateYn" value="N" checked="checked"> 허용 안함
				    </div>
				</div>
		        
		        
		        <!-- 영역 2번 질문 문항 만드는 곳 -->
		        <div style="flex: 2; text-align: center;">
		        
					<div style="font-family: Arial, sans-serif;">
					   <div class="btn border border-black px-1 py-0 mb-2 mt-2" onclick="$('#addQBtn').click()">
		                		설문 문항 작성
		                </div>
					    <div style="background-color: #fff; padding: 20px; border-radius: 5px;">
							<div class="makedQuestionField" style="overflow: auto; min-height: 496px; max-height: 496px"></div>
				             
							<button type="button" id="addQBtn" style="display: none;"></button>
						</div>
					</div>
					<!-- 질문 생성 끝 -->
				</div>
		    </div>
		</form>

	</div> 
    <div style="text-align: center;">
        <button onclick="cancel()" style="padding: 10px 20px; border-radius: 5px; background-color: #f44336; color: white; border: none;">취소</button>
        <button type="button" id="nextBtn" style="padding: 10px 20px; border-radius: 5px; background-color: #4CAF50; color: white; border: none; margin-right: 10px;">다음</button>
    </div>
</div>
  
<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    modal1 질문 문항 제작 모달 시작    -->
<!-- ===============================================-->
<div id="questionModal" style="display: none;">
	<div class="modal-contentA">
		<span class="close">&times;</span>
		<h2>문항 추가</h2>
		<form id="questionForm">
			<div class="form-group d-flex align-items-center">
			    <label for="qContent" class="mb-0 mr-2">질문:</label>
			    <input type="text" class="ms-2 form-control form-control-sm" placeholder="질문 내용을 입력해주세요" id="qContent" name="qContent" style="width: 75%;">
			</div>
			<div class="form-group d-flex align-items-center mt-3 mb-3">
			    <label for="qType" class="mb-0 mr-2">설문 문항 타입:</label>
			    <select id="qType" name="qType" class="form-control form-control-sm ms-2" style="width: 20%;">
			        <option value="default" disabled selected>선택해주세요</option>
			        <option value="textType">텍스트형</option>
			        <option value="selectType">선택형</option> 
			    </select>
			</div>

			<!-- 문항 타입에 따라 동적으로 추가될 영역 -->
			<div id="dynamicFields" style="min-height: 400px; max-height: 400px; overflow: auto;"></div>

			<button type="button" id="addQuestionBtn">추가</button>
		</form>
	</div>
</div>
<!-- ===============================================-->
<!--    modal 질문제작 모달 끝    -->
<!-- ===============================================-->

<!-- =============================================== -->
<!-- 	modal 조직도 추가 모달 시작 -->
<!-- =============================================== -->
<div class="modal fade" id="organChartModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" data-modal-name = "organChart">  
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content border-0" style="width: 980px;">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button class="btn-close btn btn-sm d-flex flex-left transition-base" id="addressBookCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
					<h4 class="mb-1" style="height: 40px; line-height: 40px" id="staticBackdropLabel">조직도</h4>
				</div>
				<div class="d-flex flex-row">
					<div class="w-50 p-3" id="sidebar-content" style="height: 600px; overflow-y: auto;">   
						<ul class="mb-0 treeview" id="treeviewExample">
							<li class="treeview-list-item">
								<!-- 개인 드라이브 태그 -->
								<p class="treeview-text" style="margin-left: 10px">
								설문 대상을 지정해 주세요
								</p>
								<c:forEach var="departmentInModal" items="${departmentList }">
									<p class="treeview-text">
										<a data-bs-toggle="collapse" href="#departmentInModal${departmentInModal.deptNo }members" role="button" aria-expanded="false">
										</a>
										 <input type="checkbox" data-depart-no="${departmentInModal.deptNo }"><span class="ms-1" style="color: black; cursor:pointer; font-weight: 500; font-size: 15px">${departmentInModal.deptName }</span>
									</p>
									<ul class="collapse treeview-list ps-1" id="departmentInModal${departmentInModal.deptNo }members" data-show="false">
										<c:forEach var="memberInModal" items="${memberList }">
											<c:if test="${memberInModal.deptNo == departmentInModal.deptNo}">
												<li class="treeview-list-item">
													<div class="treeview-item ms-2">
														<p class="treeview-text">
															<input type="checkbox" class="ms-3" data-member-departname="${departmentInModal.deptName }" data-member-departno="${memberInModal.deptNo }"  data-member-name="${memberInModal.memName }" data-member-no="${memberInModal.memNo }">
															<span class="ms-1" style="cursor: pointer;">${memberInModal.memName }</span>  
														</p>
													</div>   
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:forEach>
							</li>
						</ul>
					</div>
					<div class="w-50 p-3 border-start">
						<div id="selectedTargetInModal" style="width: 100%; height: 502px; overflow: auto;">
						<!-- 여기에 이름들 추가되면 됨 -->
							<div>
							    <span class="ms-2 mb-1">oo부</span>
							</div>
							<div class="targetDepart3 border-top border-secondary mb-2">
							    <span class="ms-1">사람이름</span>
							    <span class="ms-1">사람이름</span>
							    <span class="ms-1">사람이름</span>
							    <span class="ms-1">사람이름</span>
							</div>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
							<span class="ms-1">사람이름</span>
						</div>
						<div class="d-flex flex-row justify-content-end align-items-left my-2" style="height: 50px; margin-right: 40px">
							<div>
								<a class="btn btn-info d-flex align-items-left px-2 py-0 me-3" id="toListContirm"><div style="height: 30px; line-height: 30px">확인</div></a>
							</div>
							<div>
								<a class="btn btn-falcon-default d-flex align-items-left px-2 py-0" id="toListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px; line-height: 30px">취소</div></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- =============================================== -->
<!-- 	modal 조직도 추가 모달 끝 -->
<!-- =============================================== -->


<!-- ===============================================-->
<!--    설정 시작    -->
<!-- ===============================================-->
<div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1"
    aria-labelledby="settings-offcanvas">
    <div class="offcanvas-header settings-panel-header justify-content-between bg-shape">
      <div class="z-1 py-1">
        <div class="d-flex justify-content-between align-items-center mb-1">
          <h5 class="text-white mb-0 me-2"><span class="fas fa-palette me-2 fs-9"></span>Settings</h5>
          <button class="btn btn-primary btn-sm rounded-pill mt-0 mb-0" data-theme-control="reset"
            style="font-size:12px"> <span class="fas fa-redo-alt me-1"
              data-fa-transform="shrink-3"></span>Reset</button>
        </div>
        <p class="mb-0 fs-10 text-white opacity-75"> Set your own customized style</p>
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
            <input class="btn-check" id="themeSwitcherLight" name="theme-color" type="radio" value="light"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherLight"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-default.jpg" alt="" /></span><span
                class="label-text">Light</span></label>
          </div>
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherDark" name="theme-color" type="radio" value="dark"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherDark"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-dark.jpg" alt="" /></span><span class="label-text">
                Dark</span></label>
          </div>
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherAuto" name="theme-color" type="radio" value="auto"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherAuto"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-auto.jpg" alt="" /></span><span class="label-text">
                Auto</span></label>
          </div>
        </div>
      </div>
      <hr />
      <div class="d-flex justify-content-between">
        <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/left-arrow-from-left.svg"
            width="20" alt="" />
          <div class="flex-1">
            <h5 class="fs-9">RTL Mode</h5>
            <p class="fs-10 mb-0">Switch your language direction </p><a class="fs-10"
              href="documentation/customization/configuration.html">RTL Documentation</a>
          </div>
        </div>
        <div class="form-check form-switch">
          <input class="form-check-input ms-0" id="mode-rtl" type="checkbox" data-theme-control="isRTL" />
        </div>
      </div>
      <hr />
      <div class="d-flex justify-content-between">
        <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/arrows-h.svg" width="20" alt="" />
          <div class="flex-1">
            <h5 class="fs-9">Fluid Layout</h5>
            <p class="fs-10 mb-0">Toggle container layout system </p><a class="fs-10"
              href="documentation/customization/configuration.html">Fluid Documentation</a>
          </div>
        </div>
        <div class="form-check form-switch">
          <input class="form-check-input ms-0" id="mode-fluid" type="checkbox" data-theme-control="isFluid" />
        </div>
      </div>
      <hr />
      <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/paragraph.svg" width="20" alt="" />
        <div class="flex-1">
          <h5 class="fs-9 d-flex align-items-center">Navigation Position</h5>
          <p class="fs-10 mb-2">Select a suitable navigation system for your web application </p>
          <div>
            <select class="form-select form-select-sm" aria-label="Navbar position" data-theme-control="navbarPosition">
              <option value="vertical">Vertical
              </option>
              <option value="top">Top</option>
              <option value="combo">Combo</option>
              <option value="double-top">Double
                Top</option>
            </select>
          </div>
        </div>
      </div>
      <hr />
      <h5 class="fs-9 d-flex align-items-center">Vertical Navbar Style</h5>
      <p class="fs-10 mb-0">Switch between styles for your vertical navbar </p>
      <p> <a class="fs-10" href="modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See
          Documentation</a></p>
      <div class="btn-group d-block w-100 btn-group-navbar-style">
        <div class="row gx-2">
          <div class="col-6">
            <input class="btn-check" id="navbar-style-transparent" type="radio" name="navbarStyle" value="transparent"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-transparent"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/default.png" alt="" /><span class="label-text">
                Transparent</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-inverted" type="radio" name="navbarStyle" value="inverted"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-inverted"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/inverted.png" alt="" /><span class="label-text">
                Inverted</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-card" type="radio" name="navbarStyle" value="card"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-card"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/card.png" alt="" /><span class="label-text">
                Card</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-vibrant" type="radio" name="navbarStyle" value="vibrant"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-vibrant"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/vibrant.png" alt="" /><span class="label-text">
                Vibrant</span></label>
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- ===============================================-->
<!--    설정 끝    -->
<!-- ===============================================-->
<script>

// 등록 안하고 취소버튼 눌렀을 때
function cancel(){
	if(confirm("작업하신 모든 정보를 잃을 수 있습니다.\n취소하시겠습니까?")){
		location.href="main";
	}
};

// ==================================================== 페이지 왼쪽 정보들 입력되었는지 확인하는 부분(날짜 제목 등등)
$(function(){
	var formData = new FormData();
	var nextBtn = $("#nextBtn")

	nextBtn.on("click",function(){
		// 날짜들
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var today = new Date();

		var cnt = 0;
		
		// 날짜 입력 안하면 안되게 막음
		if(startDate == "" || endDate == ""){
			$("#setTimeError").text("날짜를 다시 확인해주세요");
			cnt += 1;
		}else{
			$("#setTimeError").text();
		}
		
		// 제목 입력 안하면 안되게 막음
		if ($("#survTitle").length === 0 || $("#survTitle").val() === "") {
			$("#titleError").text("제목을 입력해주세요");
			cnt += 1;
		}else{
			$("#titleError").text(""); 
		}
		
		if(cnt == 0){
			$("form").submit();
		}

		
		
		const dataObject = {};
		formData.forEach((value, key) => {
		    dataObject[key] = value;
		});

		// 콘솔에 출력
		console.log(dataObject);
		
	});
	
	// 폐급처럼 날짜 설정 못하게 막기
	(function() {
		var startDate = document.getElementById('startDate');
        var endDate = document.getElementById('endDate');
        var setTimeError = document.getElementById('setTimeError');

        // 오늘 날짜 가져오기
        var today = new Date().toISOString().split('T')[0];
        
        // startDate는 오늘 이후의 날짜만 선택 가능
        startDate.setAttribute('min', today);

        // startDate 변경 시, endDate의 최소값도 변경
        startDate.addEventListener('change', function() {
            endDate.value = ''; // startDate 변경 시 endDate 초기화
            endDate.setAttribute('min', startDate.value);
        });

        // endDate는 startDate 이후의 날짜만 선택 가능
        endDate.addEventListener('change', function() {
            if (endDate.value < startDate.value) {
                setTimeError.textContent = '종료 날짜는 시작 날짜 이후여야 합니다.';
                endDate.value = ''; // 잘못된 값 초기화
            } else {
                setTimeError.textContent = '';
            }
        });
    })();
// ==================================================== 페이지 왼쪽 정보들 입력되었는지 확인하는 부분 끝
	
	
// ==================================================== 질문 추가 모달	
	
	// 모달창 열기 및 닫기
    var modal = $("#questionModal");	// 질문 생성 모달
    var addQBtn = $("#addQBtn");		// 설문 문항 작성 버튼
    var closeModal = $(".close");		// 모달에 있는 x 버튼

    // 문항 추가 버튼 클릭 시 모달창 열기
    addQBtn.on("click", function() {
        modal.show();
    });

    // 모달 닫기 버튼 클릭 시 모달창 닫기
    closeModal.on("click", function() {
        modal.hide();
        $("#dynamicFields").empty();
    	$('#qType').val('default');
    	$('#qContent').val('');
    });

	// 설문 문항 타입에 따라 동적으로 필드 추가
   $("#qType").on("change", function() {
	   console.log("change function 호출됨...!");
	    var selectedValue = $(this).val();
	    var dynamicFields = $("#dynamicFields");
	    dynamicFields.empty(); // 기존 필드 초기화
	
    	// 텍스트형 질문 입력 칸 생성
	    if (selectedValue === "textType") {
	        dynamicFields.append();

		// 선택형 질문 입력 칸 생성
	    } else if (selectedValue === "selectType") {
	        dynamicFields.append(`
	            <div id="optionFields">
	        		<input type="text" name="option" class="optionInput mb-1 form-control formcontrol-sm" style="width:95%">
	                <input type="text" id="addOptionBtn" placeholder="여기를 누르면 선택지가 추가됩니다." class="mb-1 form-control formcontrol-sm" style="width:95%" readonly>
	            </div>
	        `);
	        
		// 질문 유형을 선택하지 않았을 때
	    }else if(selectedValue == "default"){
	    	alert("질문 유형을 선택해주세요");
	    	return
	    }
	    
	});

	// ========================== 선택지 추가 버튼 클릭 시 선택지 입력 칸 추가 과정
	
	// 식별자로 쓸 optionCount 숫자 증가시키기
	$(document).on("click", "#addOptionBtn", function() {
    var optionCount = $("#optionFields .optionInput").length + 1;

    // 선택형 질문지에 삽입할 input 요소 생성
    var newInput = $(`
        <input type="text" name="option" class="optionInput mb-1 form-control formcontrol-sm" style="width: 95%;">
    `);

    // 버튼 앞에 새 input 요소 삽입
    $(this).before(newInput);
  
    // 새로 추가된 input 요소에 포커스
    newInput.filter('input').focus();
});


    // 문항 추가 버튼 클릭 시 폼 데이터 처리 - 모달에서 추가 버튼 눌렀을 때
    $("#addQuestionBtn").on("click", function() {
    	if(!contentCheck()){
    		return;
    	}
    	
    	// 선택형 질문이었을 때 값 검사
    	if ($("#qType").val() == "selectType"){
	    	if (!validateOptions()) {
	    		return; // 값이 없는 경우 이후 작업을 중단
	    	}
    	}

    	
    	// 새로 만든 질문 삽입하기
    	var QuestionFormData = $("#questionForm").serializeArray();
        var qNo = $("div .makedQuestionField > div").length+1;
        console.log(QuestionFormData); // 데이터 확인
        
		var str = "";
		if ($("#qType").val() == "selectType") {  
			// 질문 넣기
		    str += "<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'>"; 
		    str += "<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>" + qNo + ". " + QuestionFormData[0].value + "</span>";
		    // 선택지 넣기
		    for (let i = 2; i < QuestionFormData.length; i++) {
		        str += "<div style='margin-bottom: 8px;'><input type='checkbox' style='margin-right: 10px;'><span style='font-size: 16px;'>" + QuestionFormData[i].value + "</span></div>";
		    }
		    str += "</div>";
		} else {
			// 질문만 넣고 끝
		    str += "<div style='border: 1px solid #ccc; width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 8px; background-color: #f9f9f9; text-align: left;'>";   
		    str += "<span style='font-weight: bold; color: #333; display: block; margin-bottom: 10px;'>" + qNo + ". " + QuestionFormData[0].value + "</span>"; 
		    str += "<input type='text' class='form-control form-control-sm w-100' readonly>";
		    str += "</div>";
		}

		$("div.makedQuestionField").append(str);
        
        
        // 모달창 닫기
        modal.hide();
        // 모달 초기화
        $("#dynamicFields").empty();
	   	$('#qType').val('default');
	   	$('#qContent').val('');

        // 이후 추가적으로 서버로 데이터를 전송하거나 UI 업데이트를 할 수 있습니다.
    });

    // 모달창 외부 클릭 시 닫기
    $(window).on("click", function(event) {
        if ($(event.target).is(modal)) {
            modal.hide();
	        // 모달 초기화
	        $("#dynamicFields").empty();
	    	$('#qType').val('default');       
	    	$('#qContent').val('');
        }
    });
    
    
    
    // 모달에서 호출하는 function 들
    
    // 선택형 질문 검사기
    function validateOptions() {
        // 모든 optionInput 요소를 가져옵니다.
        console.log("선택형 질문 검사기 호출됨");
        const options = $(".optionInput");
        let hasValue = false;
		const qContent = $("#qContent");
        // 각 입력 필드를 순회하여 비어있는 요소를 제거하고 값이 있는 요소가 있는지 확인합니다.
        options.each(function() {
            if ($(this).val().trim() === "") {
                // 비어있는 요소 제거
                $(this).remove();
            } else {
                hasValue = true; // 값이 있는 요소가 발견됨
            }
        });

        // 값이 있는 요소가 하나도 없다면 경고를 띄우고 false 반환
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
// ==================================================== 질문 추가 모달 끝
	
    
    
// ==================================================== 조직도 모달 시작
	// 모달창 열기 및 초기화
	$("#organModalOpenBtn").on("click",function(){
		$('input[type="checkbox"]').prop("checked",false);
// 		$('#selectedTargetInModal').empty();
		$("#organChartModal").modal('show');
	});
	
	// 모달창 닫기 - 완료버튼 클릭
	$("#toListContirm").on("click",function(){
		$("#organChartModal").modal('hide');
	});
	
	$('span.ms-1').on("click",function(){
		$(this).prev("input[type='checkbox']").click();
	});
	
	
	// 조직도 모달에서 부서 체크시 부서 전인원 체크 기능
	var departCheckbox = $('input[type="checkbox"][data-depart-no]');
	departCheckbox.on('change', function() {
    		const departNo = $(this).data('depart-no');
        if ($(this).is(':checked')) {
        		$('input[type="checkbox"][data-member-departno]').each(function(){
		            if($(this).data('member-departno')==departNo){
		            		$(this).prop('checked',true);
		            }
        		});
        } else {
        		$('input[type="checkbox"][data-member-departno]').each(function(){
		            if($(this).data('member-departno')==departNo){
		            		$(this).prop('checked',false);
		            }
        		});
        }
    });

// 	조직도 모달에서 각 인원 체크될 경우 selectedTargetInModal에 표시하기
	$("#organChartModal input[type='checkbox'][data-member-no]").on("click",function(){
		console.log("개별 체크박스 클릭 이벤트 잘 작동함");
		makeNames();
	});    
	
	function makeNames(){
		console.log("호출은 잘 됨");  
		$("#selectedTargetInModal").empty();
		$("#organChartModal input[type='checkbox'][data-member-no]:checked").each(function(){
				console.log("여기까진 됨");
		});
	};
	
	
// ==================================================== 조직도 모달 끝
	
	
	
	
});
</script>