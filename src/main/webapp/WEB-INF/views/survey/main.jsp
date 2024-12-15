<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!-- sidebar 있던자리 -->

<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->
<div style="flex: 1 0 auto; width: 70%" class="p-3 border-start boarder-start-1">
    <h3>최근 생성된 설문</h3>
	    <div style="display: flex; align-items: center;">
		    <div id="left-arrow" style="cursor: pointer; font-size: 2em;">&#9664;</div>
		    <div id="carousel" style="display: flex; overflow: hidden; width: 90%" >
		        <c:forEach items="${mySurveyList }" var="mySurvey" begin="0" end="4">
		            <div style="flex: 0 0 200px; margin: 0 10px; padding: 15px; background-color: white; border: 1px solid #ccc; border-radius: 10px; position: relative; text-align: left;">
		             	<div class="mb-2">
		             	<span style="position: absolute; top: 15px; right: 15px; font-weight: bold; color: gray;">
		             	<c:set var="surveyedAttendee" value="0"/>
	             		<c:forEach items="${mySurvey.surveyAttendee }" var="attendee">
	             			<c:if test="${attendee.survYn == 'Y' }">
	             				<c:set var="surveyedAttendee" value="${surveyedAttendee +1 }"></c:set>
	             			</c:if>
	             		</c:forEach>
		             	${surveyedAttendee } / ${fn:length(mySurvey.surveyAttendee)}
		             	</span>
	                	<c:forEach items="${myAttendanceList }" var="myAttendanceList">
	                		<c:if test="${myAttendanceList.survNo == mySurvey.survNo }">
				                <c:choose>
	                				<c:when test="${myAttendanceList.survYn == 'Y' }">
		                				<span style="padding: 3px 8px; border-radius: 5px; background-color: #6bcf6b; color: white;">참여완료</span>
	                				</c:when>
	                				<c:otherwise>
	                					<span style="padding: 3px 8px; border-radius: 5px; background-color: #ff6b6b; color: white;">미참여</span>
	                				</c:otherwise>
				                </c:choose>
	                		</c:if>
	                	</c:forEach>
		                <h3 style="font-size: 1.2em; margin: 20px 0 10px; min-height: 47px;">${mySurvey.survTitle }</h3>
		                <p style="font-size: 0.8em; color: gray;">${fn:substring(mySurvey.startDate,0,10) } - ${fn:substring(mySurvey.endDate,0,10) }</p>
		                <p style="font-size: 0.9em; margin: 5px 0;">작성자: ${mySurvey.memName }</p>
		                <p style="font-size: 0.9em; margin: 5px 0;">결과 공개 여부: 
		                	<c:choose>
		                		<c:when test="${mySurvey.publicYn == 'Y'}">
		                			공개
		                		</c:when>
		                		<c:otherwise>
		                			비공개
		                		</c:otherwise>
		                	</c:choose>
		                </p>
		                </div>
		                <c:forEach items="${myAttendanceList }" var="myAttendanceList">
	                		<c:if test="${myAttendanceList.survNo == mySurvey.survNo}">
							    <c:choose>
							        <c:when test="${myAttendanceList.survYn == 'Y'}">
							            <c:if test="${mySurvey.publicYn == 'Y' && surveyedAttendee == fn:length(mySurvey.surveyAttendee)}">
							                <button style="width: 30ex; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;" onclick="goResult(${mySurvey.survNo})">결과조회</button>
							            </c:if>
							            <c:if test="${mySurvey.publicYn == 'Y' && surveyedAttendee != fn:length(mySurvey.surveyAttendee)}">
							                <button style="width: 30ex; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;"">참여완료</button>
							            </c:if>
							            <c:if test="${mySurvey.publicYn != 'Y'}">
							                <button style="width: 30ex; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;">참여완료</button>
							            </c:if>
							        </c:when>
							        <c:otherwise>
							            <button style="width: 30ex; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;" onclick="doSurvey(${mySurvey.survNo})">설문참여</button>
							        </c:otherwise>
							    </c:choose>
							</c:if>
	                	</c:forEach>
		            </div>
				</c:forEach>
		    </div>
		    <div id="right-arrow" style="cursor: pointer; font-size: 2em;">&#9654;</div>
		</div>
    <h3 class="mt-3">나의 설문</h3>  
	<div id="fuck" style="min-height: 405px; width: 94%" class="mt-3" data-list='{"valueNames":["surv_YN","title","period","writer","attendance"],"page":8,"pagination":true}'>
		<div class="table-responsive scrollbar" style="min-height: 405px;"> 
			<table class="table table-bordered fs-10 mb-0">
				<colgroup>
					<col width="15%">
					<col width="30%">
					<col width="30%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<thead class="bg-200">
					<tr style="text-align: center;">
						<th class="text-900 sort">참여 여부</th>
						<th class="text-900 sort" data-sort="title" >설문제목</th>
						<th class="text-900 sort" data-sort="period">설문기간</th>
						<th class="text-900 sort" data-sort="writer">작성자</th>
						<th class="text-900 sort" data-sort="attendance">참여도</th>
					</tr>
				</thead>
				<tbody class="ViewTTable list" id="ViewTableOfMy">
					<c:forEach items="${mySurveyList }" var="mySurvey">
						<c:set var="surveyedAttendee" value="0"/>
	             		<c:forEach items="${mySurvey.surveyAttendee }" var="attendee">
	             			<c:if test="${attendee.survYn == 'Y' }">
	             				<c:set var="surveyedAttendee" value="${surveyedAttendee +1 }"></c:set>
	             			</c:if>
	             		</c:forEach>
						<tr style="text-align: center;">
							<td class="surv_YN">
								<c:forEach items="${myAttendanceList }" var="myAttendanceList">
			                		<c:if test="${myAttendanceList.survNo == mySurvey.survNo }">
						                <c:choose>
			                				<c:when test="${myAttendanceList.survYn == 'Y' }">
				                				<span style="padding: 3px 8px; border-radius: 5px; background-color: #6bcf6b; color: white;">참여완료</span>
			                				</c:when>
			                				<c:otherwise>
			                					<span style="padding: 3px 8px; border-radius: 5px; background-color: #ff6b6b; color: white;">미참여</span>
			                				</c:otherwise>
						                </c:choose>
			                		</c:if>
			                	</c:forEach>
							</td>
							<c:forEach items="${myAttendanceList }" var="myAttendanceList">
		                		<c:if test="${myAttendanceList.survNo == mySurvey.survNo}">
								    <c:choose>
								        <c:when test="${myAttendanceList.survYn == 'Y'}">
								            <c:if test="${mySurvey.publicYn == 'Y' && surveyedAttendee == fn:length(mySurvey.surveyAttendee)}">
												<td class="align-middle name title" style="text-align: left; cursor: pointer;" onclick="goResult(${mySurvey.survNo})">${mySurvey.survTitle }</td>
								            </c:if>
								            <c:if test="${mySurvey.publicYn == 'Y' && surveyedAttendee != fn:length(mySurvey.surveyAttendee)}">
												<td class="align-middle name title" style="text-align: left; cursor: pointer;">${mySurvey.survTitle }</td>
								            </c:if>
								            <c:if test="${mySurvey.publicYn != 'Y'}">
												<td class="align-middle name title" style="text-align: left; cursor: pointer;">${mySurvey.survTitle }</td>
								            </c:if>
								        </c:when>
								        <c:otherwise>
											<td class="align-middle name title" style="text-align: left; cursor: pointer;" onclick="doSurvey(${mySurvey.survNo})">${mySurvey.survTitle }</td>
								        </c:otherwise>
								    </c:choose>
								</c:if>
		                	</c:forEach>  
							<td class="period">
								${fn:substring(mySurvey.startDate,0,10) } - ${fn:substring(mySurvey.endDate,0,10) }
							</td> 
							<td class="align-middle writer">${mySurvey.memName }</td>
							<td class="attendance">${surveyedAttendee }/${fn:length(mySurvey.surveyAttendee)}</td>
						</tr>
			        </c:forEach>
				</tbody>
			</table>
		</div>
		<div class="d-flex justify-content-center mt-3">
			<button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev">
				<span class="fas fa-chevron-left"></span>
			</button>
			<ul class="pagination mb-0"></ul>
			<button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next">
				<span class="fas fa-chevron-right"></span>
			</button>
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
const carousel = document.getElementById('carousel');
const leftArrow = document.getElementById('left-arrow');
const rightArrow = document.getElementById('right-arrow');
let scrollAmount = 0;

leftArrow.onclick = () => {
    scrollAmount -= 210; // 200px + 10px margin
    carousel.scrollTo({ left: scrollAmount, behavior: 'smooth' });
};

rightArrow.onclick = () => {
    scrollAmount += 210; // 200px + 10px margin
    carousel.scrollTo({ left: scrollAmount, behavior: 'smooth' });
};

function doSurvey(survNo){
	location.href="/survey/doSurvey?survNo="+survNo;
};
function goResult(survNo){
	location.href="/survey/goResult?survNo="+survNo;
};

// onload
$(function(){
	
	
	
});
</script>
