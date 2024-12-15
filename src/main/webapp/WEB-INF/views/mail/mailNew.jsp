<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=more_vert" />
<style>
.selectedDept{
	background-color: #D0E3F6;
}

#sidebar-content {
	height: calc(100% - 240px);
}

#tableExample2{
	height: calc(100% - 120px);
}

.table > :not(caption) > * > * {
	padding: 5px;
}
table>th{
	width: 100%-180px;
}

tbody tr td:first-child {
	padding-left: 10px;
}

tbody tr td span:first-child {
	font-size: 15px;
	font-weight: 500;
	color: black;
}

tbody tr td span:first-child.title {
	width: 80px;
}

.emailInput {
	width: calc(100% - 52px);
}

tbody tr td{
	max-height: 25px;
}

.nav-menu{
	display: flex;
	justify-content: space-around;
	align-items: center;
	height: 30px
}

.nav-menu a{
	font-size: 13px;
	text-decoration: none;
	position: relative;
	cursor: pointer;
}

.nav-menu a::after{
	content: "";
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 0;
	height: 1px;
	background: black;
	transition: all .1s ease-out;
}

.nav-menu a:active::after{
	width: 100%
}

#reservationInput{
	position: relative;
}
#reservationInput a{
	position: absolute;
	bottom: 9px;
	left: 5px
}
#autocompleteToList li{
	cursor: pointer;
	padding: 0 0 0 5px;
}
#autocompleteToList li.active{
	background-color: #d8f3ff;
	color: black;
}
#autocompleteCCList li{
	cursor: pointer;
	padding: 0 0 0 5px;
}
#autocompleteCCList li.active{
	background-color: #d8f3ff;
	color: black;
}
#autocompleteBCCList li{
	cursor: pointer;
	padding: 0 0 0 5px;
}
#autocompleteBCCList li.active{
	background-color: #d8f3ff;
	color: black;
}
.emailForm:disabled{
	opacity: 0.5;
	background-color: #FFF;
}
input:disabled{
	opacity: 0.5;
	background-color: #FFF;
}
#ui-datepicker-div {
	z-index: 9999;
}

#datepicker:focus {
	outline: none;
}

.i_datepicker input {
	cursor: pointer;
}

.i_datepicker img {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	width: 16px;
	height: 16px;
	background: url(../img/ico_datepicker.svg) no-repeat center/cover;
}

.ui-widget-header {
	border: 0px solid #dddddd;
	background: #fff;
}

.ui-datepicker-calendar>thead>tr>th {
	font-size: 14px !important;
}

.ui-datepicker .ui-datepicker-header {
	position: relative;
	padding: 10px 0;
}

.ui-state-default, .ui-widget-content .ui-state-default,
	.ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover,
	html .ui-button.ui-state-disabled:active {
	border: 0px solid #c5c5c5;
	background-color: transparent;
	font-weight: normal;
	color: #454545;
	text-align: center;
}

.ui-datepicker .ui-datepicker-title {
	margin: 0 0em;
	line-height: 16px;
	text-align: center;
	font-size: 14px;
	padding: 0px;
	font-weight: bold;
}

.ui-datepicker {
	display: none;
	background-color: #fff;
	border-radius: 4px;
	margin-top: 10px;
	margin-left: 0px;
	margin-right: 0px;
	padding: 20px;
	padding-bottom: 10px;
	width: 300px;
	box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.1);
}

.ui-widget.ui-widget-content {
	border: 1px solid #eee;
}

#datepicker:focus>.ui-datepicker {
	display: block;
}

.ui-datepicker-prev, .ui-datepicker-next {
	cursor: pointer;
}

.ui-datepicker-next {
	float: right;
}

.ui-state-disabled {
	cursor: auto;
	color: hsla(0, 0%, 80%, 1);
}

.ui-datepicker-title {
	text-align: center;
	padding: 10px;
	font-weight: 100;
	font-size: 20px;
}

.ui-datepicker-calendar {
	width: 100%;
}

.ui-datepicker-calendar>thead>tr>th {
	padding: 5px;
	font-size: 20px;
	font-weight: 400;
}

.ui-datepicker-calendar>tbody>tr>td>a {
	color: #000;
	font-size: 12px !important;
	font-weight: bold !important;
	text-decoration: none;
}

.ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover {
	cursor: auto;
	background-color: #fff;
}

.ui-datepicker-calendar>tbody>tr>td {
	border-radius: 100%;
	width: 44px;
	height: 30px;
	cursor: pointer;
	padding: 5px;
	font-weight: 100;
	text-align: center;
	font-size: 12px;
}

.ui-datepicker-calendar>tbody>tr>td:hover {
	background-color: transparent;
	opacity: 0.6;
}

.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover,
	.ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus,
	.ui-button:hover, .ui-button:focus {
	border: 0px solid #cccccc;
	background-color: transparent;
	font-weight: normal;
	color: #2b2b2b;
}

/* .ui-widget-header .ui-icon { background-image: url('./btns.png'); }  */

/* .ui-icon-circle-triangle-e { background-position: -20px 0px; background-size: 36px; }

.ui-icon-circle-triangle-w { background-position: -0px -0px; background-size: 36px; }  */
.ui-datepicker-calendar>tbody>tr>td:first-child a {
	color: red !important;
}

.ui-datepicker-calendar>tbody>tr>td:last-child a {
	color: #0099ff !important;
}

.ui-datepicker-calendar>thead>tr>th:first-child {
	color: red !important;
}

.ui-datepicker-calendar>thead>tr>th:last-child {
	color: #0099ff !important;
}

.ui-state-highlight, .ui-widget-content .ui-state-highlight,
	.ui-widget-header .ui-state-highlight {
	border: 0px;
	background: #f1f1f1;
	border-radius: 50%;
	padding-top: 7px;
	padding-bottom: 8px;
}
</style>
<div class="d-flex flex-column w-100">
    <div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
	<div class="d-flex flex-column justify-content-between" style="height: 120px">
		<div class="d-flex flex-row align-items-center p-3">
			<h4 class="m-0">메일 쓰기</h4>	
		</div>
		<div class="d-flex flex-row justify-content-between align-items-center p-2">
			<div class="d-flex d-gid gap-2 flex-row align-items-center">
				<div class="d-flex d-gid gap-2 flex-row align-items-center">
					<a class="btn p-1" id="addBtn"> 
						<span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
							  <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
							</svg>
						</span> <span>보내기</span>
					</a>
					<a class="btn p-1" id="tempBtn"> 
						<span>
							<i class="bi bi-download"></i>
							<input type="checkbox" id="mailTemp" class="d-none">
						</span> <span>임시저장</span>
					</a>
					<a class="btn p-1" id="resetBtn"> 
						<span>
							<i class="bi bi-arrow-repeat"></i>
						</span> <span>다시쓰기</span>
					</a>
					<span class="btn-group">
						<a class="btn dropdown-toggle p-1" id="reservationBtn" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
							<span>
								<span class="far fa-clock" style="height: 16px;width: 16px"></span>
								<input type="checkbox" id="mailRes" class="d-none">
							</span> <span>예약메일</span>
						</a>
					    <div class="dropdown-menu" style="width: 221px">
					  		<div class="d-flex flex-row align-items-center" style="padding: 4px 16px;color: #344050;">
					  			<div class="me-2" style="width: 50px">발송날짜</div>
					  			<div class="position-relative w-75" id="reservationInput">
					  				<input type="text" id="datePicker" class="form-control ps-4" readonly style="outline: none;box-shadow: none;font-size: 15px">
					  				<div id="datePickerIcon" style="position:absolute ;top: 7px;left: 5px"><img alt="" src="${pageContext.request.contextPath }/resources/icon/calendarIcon.png" style="width: 20px;height: 20px;"></div>
					  			</div>
					  		</div>
						    <div class="d-flex flex-row align-items-center mt-2" style="padding: 4px 16px;color: #344050;">
						    	<div class="me-2" style="width: 50px">발송시간</div>
						    	<div>
								    <select name="hourSelect" id="hourSelect">
									    <c:forEach var="i" begin="0" end="23">
									    	<fmt:formatNumber var="valueStr" value="${i }" pattern="00"/>
									    	<option value="${valueStr }">${valueStr }</option>
									    </c:forEach>
								    </select>시
								    <select name="timeSelect" id="timeSelect">
								    	<c:forEach var="i" begin="0" end="5">
								    		<fmt:formatNumber var="valueStr" value="${i*10 }" pattern="00"/>
								    		<option value="${valueStr }">${valueStr }</option>
								    	</c:forEach>
								    </select>분
								</div>
						    </div>
					    	<div class="float-end mt-2 pe-3">
					    		<button class="btn btn-info px-1 py-0" id="addReservationBtn" type="button">확인</button>
					    		<button class="btn btn-light border px-1 py-0" type="button">취소</button>
					    	</div>
					    </div>
					</span>
					<a class="btn p-1" id="securityBtn"> 
						<span>
							<span data-feather="lock" style="height: 16px; width: 16px;"></span>
							<input type="checkbox" id=mailSecurity class="d-none">
						</span> <span>보안메일</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="scrollbar px-3 mt-1">
		<form action="" id="mailForm">
			<table class="w-100" style="table-layout: fixed;">
				<thead class="w-100">
			        <tr>
			          <th style="width: 180px"></th>
			          <th></th>
			        </tr>
		    	</thead>
		    	<tbody class="w-100">
					<tr>
					    <td>
					        <div class="d-flex flex-row align-items-center">
					            <span class="d-inline-block title">받는사람</span>
					            <span><input type="checkbox" id="writeMyself"></span>
					            <span class="ms-1">나에게</span>
					        </div>
					    </td>
					    <td>
					        <div class="emailForm d-flex flex-row align-items-center">
					            <div class="emailInput d-flex flex-row align-items-start border rounded-1">
					                <div class="d-flex flex-row flex-wrap w-100 position-relative" id="emailInputDiv" style="display: grid">
									    <input class="lastInput form-control-sm border border-0" id="lastToInput" type="text" data-to="recipient" spellcheck="false" autocomplete="off"/>
									    <ul class="list-group scrollbar" id="autocompleteToList" style="display: none; position: absolute; z-index: 2000; top: 100%; left: 0; height: 100px; width: 100%"></ul>
					                </div>
					                <div>
					                    <select class="recentList border border-0" style="outline: none;">
					                        <option value="최근주소">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근주소</option>
					                        <c:if test="${not empty recentMailList }">
					                        	<c:forEach items="${recentMailList }" var="recentMailList">
					                        		<option value="${recentMailList.memName }, ${recentMailList.posName }, ${recentMailList.deptName }, ${recentMailList.memEmail }">${recentMailList.memEmail }</option>
					                        	</c:forEach>
					                        </c:if>
					                    </select>
					                </div>
					            </div>
					            <div class="btn border border-black float-end ms-2 p-0" data-bs-toggle="modal" data-bs-target="#addressbookModal" style="width: 52px;height: 30px;line-height: 30px">주소록</div>
					        </div>
					    </td>
					</tr>
		      		<tr>
			      		<td>
			      			<div class="d-flex flex-row align-items-center">
			      				<span class="d-flex flex-row align-items-center title">참조<span class="d-inline-block align-center ps-1" style="cursor: pointer;"><i class="bi bi-plus-square" id="CCIcon"></i></span></span>
			      			</div>
			      		</td>
			      		<td>
			      			<div class="emailForm d-flex flex-row align-items-center">
					      		<div class="emailInput d-flex flex-row align-items-center border rounded-1">
					      			<div class="d-flex flex-row flex-wrap w-100 position-relative">
					      				<input class="lastInput form-control-sm border border-0" id="lastCCInput" type="text" data-to="CC" spellcheck="false" autocomplete="off"/>
									    <ul class="list-group scrollbar" id="autocompleteCCList" style="display: none; position: absolute; z-index: 2000; top: 100%; left: 0; height: 100px; width: 100%"></ul>
					      			</div>
					      			<div>
					                    <select class="recentList border border-0" style="outline: none;">
					                        <option value="최근주소">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근주소</option>
					                        <c:if test="${not empty recentMailList }">
					                        	<c:forEach items="${recentMailList }" var="recentMailList">
					                        		<option value="${recentMailList.memName }, ${recentMailList.posName }, ${recentMailList.deptName }, ${recentMailList.memEmail }">${recentMailList.memEmail }</option>
					                        	</c:forEach>
					                        </c:if>
					                    </select>
					      			</div>
					      			</div>
				      			<div class="btn border border-black float-end ms-2 p-0" data-bs-toggle="modal" data-bs-target="#addressbookModal" style="width: 52px;height: 30px;line-height: 30px">주소록</div>
				      		</div>
			      		</td>
		      		</tr>
		      		<tr id="BCC" class="d-none">
			      		<td>
			      			<div class="d-flex flex-row align-items-center">
			      				<span class="d-flex flex-row align-items-center title">숨은참조</span>
			      			</div>
			      		</td>
			      		<td>
			      			<div class="emailForm d-flex flex-row align-items-center">
					      		<div class="emailInput d-flex flex-row align-items-center border rounded-1">
					      			<div class="d-flex flex-row flex-wrap w-100 position-relative">
					      				<input class="lastInput form-control-sm border border-0" id="lastBCCInput" type="text" data-to="BCC" spellcheck="false" autocomplete="off"/>
									    <ul class="list-group scrollbar" id="autocompleteBCCList" style="display: none; position: absolute; z-index: 2000; top: 100%; left: 0; height: 100px; width: 100%"></ul>
					      			</div>
					      			<div>
					                    <select class="recentList border border-0" style="outline: none;">
					                        <option value="최근주소">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근주소</option>
					                        <c:if test="${not empty recentMailList }">
					                        	<c:forEach items="${recentMailList }" var="recentMailList">
					                        		<option value="${recentMailList.memName }, ${recentMailList.posName }, ${recentMailList.deptName }, ${recentMailList.memEmail }">${recentMailList.memEmail }</option>
					                        	</c:forEach>
					                        </c:if>
					                    </select>
					      			</div>
					      			</div>
				      			<div class="btn border border-black float-end ms-2 p-0" data-bs-toggle="modal" data-bs-target="#addressbookModal" style="width: 52px;height: 30px;line-height: 30px">주소록</div>
				      		</div>
			      		</td>
		      		</tr>
		      		<tr>
		      			<td>
		      				<div class="d-flex flex-row align-items-center">
			      				<span class="d-inline-block title">제목</span>
			      				<span><input type="checkbox" id="mailImp" id="mailImp"></span>
			      				<span class="ms-1">중요!</span>
			      			</div>
		      			</td>
		      			<td>
		      				<div class="d-flex flex-row align-items-center border rounded-1 w-100">
				      			<input class="form-control-sm w-100 border border-0" id="mailTitle" type="text" value="${mailTitle }" spellcheck="false">
			      			</div>
		      			</td>
		      		</tr>
		      		<tr class="align-top">
		      			<td class="h-100 pt-3">
		      				<div class="d-flex flex-row align-items-center">
			      				<span class="d-flex flex-row align-items-center title">파일첨부<span class="d-inline-block align-center ps-1" style="cursor: pointer;"><i class="bi bi-dash-square" id="BCCIcon"></i></span></span>
						    </div>
		      			</td>
		      			<td class="pt-3">
		      				<div class="d-flex flex-column">
			      				<div class="d-flex felx-row justify-content-between" id="fileBtnDiv">
			      					<div>
			      						<div class="btn border border-black me-1 px-1 py-0" id="selectFile" style="height: 30px;line-height: 30px">파일선택</div>
			      						<div class="btn border border-black me-1 px-1 py-0" id="resetFile" style="height: 30px;line-height: 30px">모두삭제</div>
			      					</div>
			      					<div><span class="fs-10">일반 <span class="fs-10" id="fileTotalSize">0Byte</span>/20MB</span></div>
			      				</div>
								<div class="d-flex justify-content-center border border-dashed my-2 d-flex p-2 scrollbar-overlay" id="fileForm" style="min-height: 50px;max-height: 200px;border-color: #999">
								    <div class="d-flex justify-content-center align-items-center">
								        <i class="bi bi-paperclip"></i>
								        <div class="d-flex align-items-center p-1">
								            여기에 첨부 파일을 끌어 오세요. 또는 
								            <label style="cursor: pointer; font-weight: bold; text-decoration: underline; font-size: inherit; margin-bottom: 0;padding-left: 5px">
								                <input type="file" style="display: none;" multiple id="fileInput" />
								                파일 선택
								            </label>
								        </div>
								    </div>
								    <div id="fileList">
								    </div>
								</div>
							</div>
		      			</td>
		      		</tr>
		    	</tbody>
			</table>
			<div class="mb-3">
				<textarea name="mailContent" id="mailContent" cols="50" rows="5" class="form-control"></textarea>
			</div>
		</form>
	</div>
</div>
<!-- ===============================================-->
<!--    주소록 모달 시작    -->
<!-- ===============================================-->
<div class="modal fade" id="addressbookModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0" style="width:980px">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base" id="addressBookCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="staticBackdropLabel">주소록</h4>
        </div>
		<div class="d-flex flex-column p-3" style="height: 500px;">
			<div class="d-flex flex-row" style="height: 450px">
				<div class="border border-end-0 p-2" style="width: 150px" id="addressBookDeptList">

				</div>
				<div class="d-flex flex-column border" style="width: 350px;flex: 1 0 auto;">
				    <div class="overflow-x-auto w-100" style="height: 450px">
				        <table class="table" id="addressTable" style="min-width: 525px;">
				        	<colgroup>
				        		<col width="65px">
				        		<col width="85px">
				        		<col width="85px">
				        		<col width="85px">
				        		<col>
				        	</colgroup>
				            <thead class="bg-200">
				                <tr>
				                    <th class="align-middle white-space-nowrap" style="width: 65px">
				                        <div class="form-check mb-0" style="width: 30px">
				                            <input class="form-check-input" type="checkbox" data-bulk-select='{"body":"bulk-select-body","actions":"bulk-select-actions","replacedElement":"bulk-select-replace-element"}' />
				                        </div>
				                    </th>
				                    <th class="text-black dark__text-white align-middle" style="width: 85px">이름</th>
				                    <th class="text-black dark__text-white align-middle" style="width: 85px">직위</th>
				                    <th class="text-black dark__text-white align-middle" style="width: 85px">부서</th>
				                    <th class="text-black dark__text-white align-middle">이메일</th>
				                </tr>
				            </thead>
				            <tbody id="bulk-select-body">
				            	<c:forEach items="${deptMemberList }" var="deptMember">
				            		<tr>
					                    <td class="align-middle white-space-nowrap">
					                        <div class="form-check mb-0">
					                            <input class="selectToCheck form-check-input" type="checkbox" data-bulk-select-row="data-bulk-select-row" />
					                        </div>
					                    </td>
					                    <td class="align-middle name">${deptMember.memName }</td>
					                    <td class="align-middle position">${deptMember.posName }</td>
					                    <td class="align-middle dept">${deptMember.deptName }</td>
					                    <td class="align-middle email">${deptMember.memEmail }</td>
					                </tr>
				            	</c:forEach>
				            </tbody>
				        </table>
				    </div>
				</div>
				<div class="d-flex flex-column justify-content-between align-items-center" id="selectTo" style="width: 70px">
					<div class="d-flex flex-column justify-content-center align-items-center" style="height: 150px">
						<a class="btn border p-0" style="margin: 0 0 5px 0" data-to="recipient">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px" class="selectToSpan">그룹</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
						<a class="btn border p-0" data-to="recipient">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px" class="selectToSpan">개인</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
					</div>
					<div class="d-flex flex-column justify-content-center align-items-center" style="height: 150px">
						<a class="btn border p-0" style="margin: 0 0 5px 0" data-to="CC">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px" class="selectToSpan">그룹</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
						<a class="btn border p-0" data-to="CC">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px" class="selectToSpan">개인</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
					</div>
					<div class="d-flex flex-column justify-content-center align-items-center" style="height: 150px">
						<a class="btn border p-0" style="margin: 0 0 5px 0" data-to="BCC">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px" class="selectToSpan">그룹</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
						<a class="btn border p-0" data-to="BCC">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px" class="selectToSpan">개인</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
					</div>
				</div>
				<div style="width: 300px">
					<div style="height: 150px" class="w-100">
						<div style="height: 25px;">받는사람</div>
						<div class="overflow-x-auto border bg-200 w-100 p-1" id="recipients" style="width: 300px;height: 120px;">
						
						</div>
					</div>
					<div style="height: 150px">
						<div style="height: 25px;margin-top: 3px">참조</div>
						<div class="overflow-x-auto border bg-200 p-1" id="CCs"  style="width: 300px;height: 120px;">
						
						</div>
					</div>
					<div style="height: 150px;">
						<div style="height: 25px;margin-top: 2px">숨은참조</div>
						<div class="overflow-x-auto border bg-200 p-1" id="BCCs" style="width: 300px;height: 120px;">
						
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="toListContirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="toListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 태그 추가 모달 -->
<div class="modal fade" id="addTagListModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addTagListModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addTagListCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addTagListModalHead">태그 추가</h4>
        </div>
		<div class="d-flex flex-column justify-content-center align-items-center align-middle p-3">
			<span class="p-0 my-1" id="addTagListModalMent">새 태그 이름을 입력하세요.</span>
			<input class="form-control-sm border-1" type="text" id="tagListNameInput">
			<span class="p-0 my-1">태그 색상을 선택하세요</span>
			<div class="d-flex flex-row flex-wrap d-gap gap-1" style="width: 170px">
				<div class="tag-color" data-color="#905341" style="background: #905341;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#D06B64" style="background: #D06B64;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#D75269" style="background: #D75269;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FA573C" style="background: #FA573C;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FF7537" style="background: #FF7537;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FFAD46" style="background: #FFAD46;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#42D692" style="background: #42D692;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#16A765" style="background: #16A765;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#7BD148" style="background: #7BD148;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#B3DC6C" style="background: #B3DC6C;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FBE983" style="background: #FBE983;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FAD165" style="background: #FAD165;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#F691B2" style="background: #F691B2;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#CD74E6" style="background: #CD74E6;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#9A9CFF" style="background: #9A9CFF;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#B99AFF" style="background: #B99AFF;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#6691E5" style="background: #6691E5;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#9FC6E7" style="background: #9FC6E7;width: 15px;height: 15px;border: 1px solid #FFF"></div>
			</div>
			<div id="addTagListModaltagNoData" class="d-none"></div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addTagListConfirm"><div id="contirmText" style="height: 30px;line-height: 30px"></div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addTagListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 태그 리스트 삭제 모달 -->
<div class="modal fade" id="deleteTagListModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="deleteTagListModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="deleteTagListCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="deleteTagListModalHead">태그 삭제</h4>
        </div>
		<div>
			<p>태그를 삭제하시겠습니까?</p>
		</div>
		<div id="deleteTagListModaltagNoData" class="d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="deleteTagListConfirm"><div id="contirmText" style="height: 30px;line-height: 30px"></div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="deleteTagListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
let type = `${type}`;
let fileTotalSize = 0;
let mailResDate = null;
let mailResTime = null;
if (type != 'basic') {
	setTimeout(() => {
		fillInput(${mail.mailNo});
	}, 300);
}
if (type == 'drive'){
	setTimeout(() => {
		filePreview(${file});
	}, 200);
}
getDepartmentTree();
var fileList = [];
var dbFile = []
$(function () {
	let addBtn = $("#addBtn");
	let tempBtn = $("#tempBtn");
	let previewBtn = $("#previewBtn");
	let resetBtn = $("#resetBtn");
	let reservationBtn = $("#reservationBtn");
	let securityBtn = $("#securityBtn");
	let writeMyself = $("#writeMyself");
	let CCIcon = $("#CCIcon");
	let BCCIcon = $("#BCCIcon");
	let selectFile = $("#selectFile");
	let selectDrive = $("#selectDrive");
	let resetFile = $("#resetFile");
	let fileInput = $("#fileInput");
	let selectToBtn = $("#selectTo a");
	let recipients = $("#recipients");
	let CCs = $("#CCs");
	let BCCs = $("#BCCs");
	let toListContirm = $("#toListContirm");
	let addReservationBtn = $("#addReservationBtn");
	let datePicker = $("#datePicker");
	let hourSelect = $("#hourSelect");
	let timeSelect = $("#timeSelect");
	let lastToInput = $("#lastToInput");
	let lastCCInput = $("#lastCCInput");
	let lastBCCInput = $("#lastBCCInput");
	let selectedIndex = 0;
	let autoCreateModifyFlag = false;	
	let ajaxRequest = false;
	
	CKEDITOR.replace("mailContent",{
		height:500,
		filebrowserUploadUrl: "/mail/imageUpload.do"
	});
	
	$("#addressBookDeptList").on("click", "span", function () {
		$("#addressBookDeptList").find("span").removeClass("selectedDept");
		$(this).addClass("selectedDept");
		let deptNo = $(this).data("no");
		axios({
			url : "/mail/getDeptMember.do",
			method : "post",
			data : {
				deptNo : deptNo
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			let deptMemberListHTML = "";
			for (var i = 0; i < res.length; i++) {
				deptMemberListHTML += `
							            <tr>
						                    <td class="align-middle white-space-nowrap">
						                        <div class="form-check mb-0">
						                            <input class="selectToCheck form-check-input" type="checkbox" data-bulk-select-row="data-bulk-select-row" />
						                        </div>
						                    </td>
						                    <td class="align-middle name">\${res[i].memName}</td>
						                    <td class="align-middle position">\${res[i].posName}</td>
						                    <td class="align-middle dept">\${res[i].deptName}</td>
						                    <td class="align-middle email">\${res[i].memEmail}</td>
						                </tr>
									  `;
			}
			$("#bulk-select-body").html(deptMemberListHTML);
		});
	});
	
	$(".recentList").on("change", function () {
		let selectVal = $(this).val();
		let selectValArr = selectVal.split(",");
		if (selectVal != "최근주소") {
			let mailHTML = `
				            <div class="mailInfo d-flex flex-row align-items-center" id="myselfInfo" data-to="recipient">
								<div class="border rounded-3 bg-info-subtle ms-1 px-1">
									<span style="font-size: 13px">\${selectValArr[0]}/\${selectValArr[1]}/\${selectValArr[2]} &lt;\${selectValArr[3]}&gt;</span>
									<span class="edit-icon" style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
									<span style="cursor: pointer;"><i class="bi bi-x"></i></span>
								</div>
				    		</div>
							`;
			$(this).closest(".emailInput").find(".lastInput").before(mailHTML);
			$(this).val("최근주소");
		}
	});
	
	$(document).on('click', function (event) {
	    // lastToInput 또는 autocompleteList를 클릭한 경우 무시
	    if (!$(event.target).closest('#lastToInput').length && 
	        !$(event.target).closest('#autocompleteToList').length) {
	        
	        let lastToInputValue = lastToInput.val();
	        let regexp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

	        if (lastToInputValue) {
	            if (!regexp.test(lastToInputValue)) {
	                let warningText = `
	                    <div class="wrongMailInfo border rounded-3 bg-danger-subtle ms-1 px-1">
	                        <span style="font-size: 13px">\${lastToInputValue}</span>
	                        <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
	                        <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
	                    </div>
	                `;
	                lastToInput.before(warningText);
	                lastToInput.val("");
	                lastToInput.focus();
	            }
	        }
	        $('#autocompleteToList').hide(); // 리스트 숨기기
	        ajaxRequest = false;
	    }
	});
	
	$(document).on('moucedown', function (event) {
	    // 클릭한 요소가 입력 필드나 자동 완성 리스트가 아닌 경우
	    if (!$(event.target).closest('#lastToInput').length &&
	        !$(event.target).closest('#lastCCInput').length &&
	        !$(event.target).closest('#lastBCCInput').length &&
	        !$(event.target).closest('#autocompleteToList').length &&
	        !$(event.target).closest('#autocompleteCCList').length &&
	        !$(event.target).closest('#autocompleteBCCList').length) {
	        
	        // 이메일 검사를 위한 정규 표현식
	        let regexp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	        
	        // lastToInput 검사
	        validateEmailInput('#lastToInput', regexp);
	        
	        // lastCCInput 검사
	        validateEmailInput('#lastCCInput', regexp);
	        
	        // lastBCCInput 검사
	        validateEmailInput('#lastBCCInput', regexp);
	        
	        // 각 자동 완성 리스트 숨기기
	        $('#autocompleteToList').hide();
	        $('#autocompleteCCList').hide();
	        $('#autocompleteBCCList').hide();
	        ajaxRequest = false;
	    }
	});
	


	$(".emailInput").on('keyup', ".lastInput", function (event) {
		console.log(ajaxRequest);
		let lastInput = $(this);
		let type = lastInput.data("to");
		let lastInputValue = $(this).val();
		let list = $(this).closest(".emailInput").find("ul");
	    const allowedKeys = [
	        8,   // Backspace
	        9,   // Tab
	        13,  // Enter
	        46,  // Delete
	        37,  // Left Arrow
	        38,  // Up Arrow
	        39,  // Right Arrow
	        40   // Down Arrow
	    ];
	    
	    const key = event.which || event.keyCode;
	    if (lastInputValue.length == 1) {
	    	ajaxRequest = false;
		}
	    if (ajaxRequest) return; // 이미 요청 중이면 새로운 요청을 차단
	    ajaxRequest = true;
	    
	    if (!list.is(":visible") && key == 13) {
	    	let regexp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	    	if (!regexp.test(lastInputValue)) {
				let warningText = `
									<div class="wrongMailInfo border rounded-3 bg-danger-subtle ms-1 px-1">
										<span style="font-size: 13px">\${lastInputValue}</span>
										<span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
										<span style="cursor: pointer;"><i class="bi bi-x"></i></span>
									</div>
									`;
				lastInput.before(warningText);
				lastInput.val("");
				lastInput.focus();
			}
		}
	    
	    if (
	            (key >= 48 && key <= 57) || // 숫자 0-9
	            (key >= 65 && key <= 90) || // 대문자 A-Z
	            (key >= 97 && key <= 122)|| // 소문자 a-z
	            key == 8  // Backspace
	        ){
			$.ajax({
				url : "/mail/searchMember.do",
				method : "post",
				data : JSON.stringify({searchWord : lastInputValue}),
				contentType : "application/json; charset=utf-8",
				success : function (memberList) {
			            list.empty(); // 이전 결과 초기화

			            if (memberList.length === 0) {
			                list.hide();
			                return;
			            }

			            memberList.forEach(member => {
			                let li = $('<li class="list-group-item"></li>').text(`\${member.memName}/\${member.posName}/\${member.deptName} <\${member.memEmail}>`);
			                li.click(function (event) {
			                    event.preventDefault(); // 기본 동작 방지 (예: 텍스트 선택)
			                    event.stopPropagation(); // 이벤트 전파 중지
								selectedText = $(this).text().replace("<", "&lt;").replace(">", "&gt;");
			                    if (lastInput.hasClass("modifyInput")) {
			                    	lastInput.closest(".mailInfo").find("span:first").html(selectedText);
									lastInput.prevAll().show();
									lastInput.remove();
									list.hide();
									autoCreateModifyFlag = true;
									return;
								}else {
				                    lastInput.before($('<div class="mailInfo d-flex flex-row align-items-center" data-to="'+type+'"></div>').html(`
				                        <div class="border rounded-3 bg-info-subtle ms-1 px-1">
				                            <span style="font-size: 13px">\${selectedText}</span>
				                            <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
				                            <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
				                        </div>
				                    `));
				                    lastInput.val("");
								}
			                    list.hide(); // 자동완성 리스트 숨기기
			                });
			                list.append(li);
			            });
			            selectedIndex = 0;
			            list.find("li").eq(0).addClass("active");
			            if (autoCreateModifyFlag) {
			            	autoCreateModifyFlag = false;
							return;
						}
			            list.show(); // 결과가 있을 때만 보여줌
				},
	            complete: function () {
	                ajaxRequest = false; // AJAX 요청이 완료되면 플래그 해제
	            }
			});
	    }
	    
	    if (key === 38) { // Up Arrow
	        if (selectedIndex > 0) {
	            highlightItem(--selectedIndex, list, list.find("li"));
	        }
	    } else if (key === 40) { // Down Arrow
	        if (selectedIndex < list.find("li").length - 1) {
	            highlightItem(++selectedIndex, list, list.find("li"));
	        }
	    } else if (key === 13) { // Enter
	        if (selectedIndex !== -1) {
	            let selectedLi = list.find("li").eq(selectedIndex);
	            selectedLi.trigger('click'); // 선택된 항목 클릭 이벤트 트리거
	        }
	    }
	    return;
	});


	
	$('main').on('click','.bi-pencil', function() {
		let mailInfo = $(this).closest(".mailInfo");
		let divWidth = mailInfo.width();
		let mailInfoText = mailInfo.text().trim();
		console.log(mailInfoText);
		mailInfo.find("span").hide();
		mailInfo.find("span").eq(2).after($("<input type='text' class='lastInput modifyInput bg-info-subtle border-0' style='font-size:13px;width:"+divWidth+"px;outline:none;'>"));
		mailInfo.find("input").val(mailInfoText);
		mailInfo.find("input").focus();
	});
	
	CCIcon.on("click", function () {
		if (CCIcon.hasClass("bi-plus-square")) {
			$("#BCC").removeClass('d-none');
			CCIcon.attr("class", "bi-dash-square");
		}
		else{
			$("#BCC").addClass('d-none')
			CCIcon.attr("class", "bi-plus-square");
		}
	});
	BCCIcon.on("click", function () {
		if (BCCIcon.hasClass("bi-dash-square")) {
			$("#fileForm").addClass('d-none')
			$("#fileBtnDiv").addClass('mb-2');
			BCCIcon.attr("class", "bi-plus-square");
		}
		else{
			$("#fileForm").removeClass('d-none');
			$("#fileBtnDiv").removeClass('mb-2');
			BCCIcon.attr("class", "bi-dash-square");
		}
	});
	
	$("main").on("click", ".bi-x", function () {
		if ($(this).closest('.mailInfo').length) {
			$(this).closest(".mailInfo").remove();
		}
		if ($(this).closest('.fileList').length) {
			let index = $(".fileList").index($(this).closest('.fileList'));
			let fileSize = $(this).closest('.fileList').data("size");
			let fileDetailNo = $(this).closest('.fileList').data("detail-no");
			for(let i = 0; i < dbFile.length; i++) {
			    if (dbFile[i] === fileDetailNo) {
			    	dbFile.splice(i, 1);
			    }
			}
			fileTotalSize = fileTotalSize - fileSize;
			fileList.splice(index,1);
			$("#fileTotalSize").text(formatFileSize(fileTotalSize));
			$(this).closest(".fileList").remove();
		}
	    if ($(this).closest($("#myselfInfo")).length) {
		    writeMyself.prop("checked", false);
		    $("#myselfInfo").remove();
		}
	    if ($(this).closest(".addressSelect").length) {
	    	$(this).closest(".addressSelect").remove();
		}
	    if ($(this).closest(".wrongMailInfo").length) {
	    	$(this).closest(".wrongMailInfo").remove();
		}
	    if ($(this).closest(".reservationInfo").length) {
	    	$("#mailRes").prop("checked", false);
	    	mailResDate = null;
	    	mailResTime = null;
		    $(this).closest(".reservationInfo").remove();
		}
	    if ($(this).closest(".securityInfo").length) {
	    	$("#mailSecurity").prop("checked", false);
		    $(this).closest(".securityInfo").remove();
		}
	});
	
	writeMyself.on("change", function () {
		if (writeMyself.is(':checked')) {
			$(".mailInfo").remove();
			let myselfHTML = `
            <div class="mailInfo d-flex flex-row align-items-center" id="myselfInfo" data-to="recipient">
				<div class="border rounded-3 bg-info-subtle ms-1 px-1">
					<span style="font-size: 13px">${member.memName}/${member.posName}/${member.deptName} &lt;${member.memEmail}&gt;</span>
				</div>
        	</div>`;
        	$("#lastToInput").before(myselfHTML);
        	$(".emailForm").find("input, select, button").prop("disabled", true);
        	$(".emailForm").find(".btn").css("pointerEvents", "none");
        	$(".emailForm").find(".btn").css("opacity", "0.5");
		}else{
			$("#myselfInfo").remove();
			$(".emailForm").find("input, select, button").prop("disabled", false);
        	$(".emailForm").find(".btn").css("pointerEvents", "auto");
        	$(".emailForm").find(".btn").css("opacity", "1");
		}
	});
	
	addBtn.on("click", function () {
		let toExist = false;
		let overlap = false;
		$(".mailInfo").each(function () {
		    if ($(this).data("to") === "recipient") {
		        toExist = true;
		        return false;
		    }
		});
		
		if ($(".emailInput .wrongMailInfo").length) {
			requiredAlert("잘못된 메일 주소입니다.", isAlertVisible);
			return false;
		}
		
		if (!toExist) {
			requiredAlert("받는사람이 지정되지 않았습니다.", isAlertVisible);
			return false;
		}
		
		if (!$("#mailTitle").val()) {
			requiredAlert("제목이 입력되지 않았습니다.", isAlertVisible);
			return false;
		}
		if ($("#mailRes").prop("checked")) {
			if(!validateDateTime()) {
				requiredAlert("예약 시간은 현재 시간 이후 10분후 부터 가능합니다.", isAlertVisible);
				return false;
	        }
			mailResDate = formatDateString(mailResDate.toISOString());
		}
		
		let memNo = ${member.memNo};
		let mailTitle = $("#mailTitle").val();
		let mailContent = CKEDITOR.instances.mailContent.getData();
		let mailStatus = "전송";
		let file = fileList;
		let mailTemp = $("#mailTemp").prop("checked") ? "Y" : "N";
		let mailToMe = $("#writeMyself").prop("checked") ? "Y" : "N";
		let mailImp = $("#mailImp").prop("checked") ? "Y" : "N";
		let mailRes = $("#mailRes").prop("checked") ? "Y" : "N";
		let mailSecurity = $("#mailSecurity").prop("checked") ? "Y" : "N";
		let recipient = [];
		let CC = [];
		let BCC = [];
		let emailSet = new Set();
		
		if (mailTemp == "Y") {
			mailStatus = "임시";
		}
		
		$(".mailInfo").each(function() {
		    let dataTo = $(this).data("to"); // 현재 요소의 data-to 값 가져오기
		    let infoText = $(this).find("span").first().text(); // 첫 번째 span의 텍스트 가져오기
		    let emailStr = getEmail(infoText);
		    
		    // 중복 확인
		    if (emailSet.has(emailStr)) {
				requiredAlert(`중복된 이메일: \${emailStr}`, isAlertVisible);
		    	overlap = true;
		    } else {
		        emailSet.add(emailStr); // Set에 이메일 추가
		    }
		        
		    if (dataTo === "recipient") {
		        recipient.push(emailStr);
		    } else if (dataTo === "CC") {
		        CC.push(emailStr);
		    } else if (dataTo === "BCC") {
		        BCC.push(emailStr);
		    }
		});
		
		if (overlap) {
			return false;
		}	
		
		let recipientData = [{"recipient" : recipient},{"recipient" : CC},{"recipient" : BCC}];
		let formData = new FormData();
		
		if (type == 'basic') {
			if (fileList.length > 0) {
				for (let i = 0; i < fileList.length; i++) {
					formData.append("file", fileList[i]);
				}		
			}
		}else {
			formData.append("dbFile", dbFile);
		}
		
		formData.append("memNo",memNo);
		formData.append("mailTitle",mailTitle);
		formData.append("mailContent",mailContent);
		formData.append("mailStatus",mailStatus);
		formData.append("mailResDate",mailResDate);
		formData.append("mailToMe",mailToMe);
		formData.append("mailImp",mailImp);
		formData.append("mailRes",mailRes);
		formData.append("mailSecurityYn",mailSecurity);
		formData.append("recipientData", new Blob([JSON.stringify(recipientData)], {type:"application/json; charset=utf-8"}));
		
		$.ajax({
			url : "/mail/send.do",
			method : "post",
			data : formData,
			processData : false,
			contentType : false,
			success : function (res) {
				if (res == "SUCCESS") {
					location.href = "/mail/mailbox/1";
				}
			}
			
		});
	});
	
	tempBtn.on("click", function () {
		$("#mailTemp").prop("checked", true);
		addBtn.click();
	});
	
	previewBtn.on("click", function () {
	});
	
	resetBtn.on("click", function () {
		location.reload(true);
	});
	
	addReservationBtn.on("click", function () {
		let reservationHTML = "";
		mailResDate = datePicker.val();
		mailResTime = hourSelect.val() + ":" + timeSelect.val() + ":00";
		mailResTimeStr = hourSelect.val() + "시 " + timeSelect.val() + "분";
		$("#mailRes").prop("checked", true);
		reservationHTML = `
							<div class="reservationInfo d-flex flex-row align-items-center border rounded-3 ms-1 px-1">
								<span style="font-size: 13px">\${mailResDate} \${mailResTimeStr}</span>
								<span style="cursor: pointer;"><i class="bi bi-x"></i></span>
							</div>
						  `;
		if(!validateDateTime()) {
			requiredAlert("예약 시간은 현재 시간 이후 10분후 부터 가능합니다.", isAlertVisible);
			return false;
        }
		reservationBtn.after(reservationHTML)
		$("#mailRes").prop("checked", true);
	});
	securityBtn.on("click", function () {
		let securityHTML = "";
		if (!$("#mailSecurity").prop("checked")) {
			$("#mailSecurity").prop("checked", true);
			securityHTML = `
				<div class="securityInfo d-flex flex-row align-items-center border rounded-3 ms-1 px-1">
					<span style="font-size: 13px">사용중</span>
					<span style="cursor: pointer;"><i class="bi bi-x"></i></span>
				</div>
			  `;
			securityBtn.after(securityHTML);
		}
		
	});
	
	selectFile.on("click", function () {
		fileInput.click();
	});
	
	resetFile.on("click", function () {
		fileList.length = 0;
		$(".fileList").remove();
	});
	
	selectToBtn.on("click", function name() {
		let checkList = $(".selectToCheck:checked");
		let selectTo = (this).dataset.to;
		let selectToSpanText = $(this).find(".selectToSpan").text();
		let groupListTr = $("#bulk-select-body").find("tr");
		let rowInfo = "";
		if (selectToSpanText == '개인') {
			for (let i = 0; i < checkList.length; i++) {
			    let row = checkList.eq(i).closest("tr");
			    let name = row.find('.name').text();
			    let position = row.find('.position').text();
			    let dept = row.find('.dept').text();
			    let email = row.find('.email').text();
	
			    rowInfo += `<div class='addressSelect d-flex flex-row justify-content-between'>
			    				<div class='text-truncate' style="font-size:13px;white-space:nowrap">\"\${name}/\${position}/\${dept}&lt\${email}&gt\" </div>
			    				<span style="cursor: pointer;margin-left: 5px;width:15px;height:15px"><i class="bi bi-x"></i></span>
			    			</div> `;
			}
			if (selectTo == "recipient") {
				recipients.html(rowInfo);
			}else if (selectTo == "CC") {
				CCs.html(rowInfo);
			}else {
				BCCs.html(rowInfo);
			}
		}else {
			for (var i = 0; i < groupListTr.length; i++) {
				let name = groupListTr.eq(i).find('td').eq(1).text();
				let position = groupListTr.eq(i).find('td').eq(2).text();
				let dept = groupListTr.eq(i).find('td').eq(3).text();
				let email = groupListTr.eq(i).find('td').eq(4).text();
				rowInfo += `<div class='addressSelect d-flex flex-row justify-content-between'>
								<div class='text-truncate' style="font-size:13px;white-space:nowrap">\"\${name}/\${position}/\${dept}&lt\${email}&gt\" </div>
								<span style="cursor: pointer;margin-left: 5px;width:15px;height:15px"><i class="bi bi-x"></i></span>
							</div> `;
			}
			if (selectTo == "recipient") {
				recipients.html(rowInfo);
			}else if (selectTo == "CC") {
				CCs.html(rowInfo);
			}else {
				BCCs.html(rowInfo);
			}
		}
	});
	
	toListContirm.on("click", function () {
	    let recipientsDiv = cleanAndSplit(recipients.find(".text-truncate").text());
	    let CCsDiv = cleanAndSplit(CCs.text());
	    let BCCsDiv = cleanAndSplit(BCCs.text());
		$(".addressList").remove();
		let recipientInput = "";
	    
	    function generateInputHTML(list, type) {
	    	
	        let inputHTML = "";
	        for (let i = 0; i < list.length; i++) {
	        	if (list[i]) {
		            inputHTML += `
					               <div class="mailInfo addressList d-flex flex-row align-items-center" data-to="\${type}">
					                   <div class="border rounded-3 bg-info-subtle ms-1 px-1">
					                       <span style="font-size: 13px">\${list[i]}</span>
					                       <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
					                       <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
					                   </div>
					               </div>
		                		`;
				}
	        }
	        return inputHTML;
	    }

	    recipientInput += recipientsDiv.length > 0 ? generateInputHTML(recipientsDiv, "recipient") : "";
	    let CCInput = CCsDiv.length > 0 ? generateInputHTML(CCsDiv, "CC") : "";
	    let BCCInput = BCCsDiv.length > 0 ? generateInputHTML(BCCsDiv, "BCC") : "";

	    $("#lastToInput").before(recipientInput);
	    $("#lastCCInput").before(CCInput);
	    $("#lastBCCInput").before(BCCInput);
	    $("#addressTable").find(".selectToCheck").prop("checked", false);

	    $("#addressbookModal").modal('hide');
	});
	
	$("#addressbookModal").on("keydown", function (event) {
		if(event.keyCode == 27){
			$("#addressBookCloseBtn").click();
		}
	})

	fileInput.on("change", function (event) {
		let files = event.target.files;
		fileListPreview(files);
	});
	
    $("#fileForm").on("dragenter", function(e){
        e.preventDefault();
        e.stopPropagation();
    }).on("dragover", function(e){
        e.preventDefault();
        e.stopPropagation();
        $(this).css("border-color", "#25BCFD");
    }).on("dragleave", function(e){
        e.preventDefault();
        e.stopPropagation();
        $(this).css("border-color", "#999");
    }).on("drop", function(e){
        e.preventDefault();

        let files = e.originalEvent.dataTransfer.files;
        fileListPreview(files);
    });
	
    datePicker
    .datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
            ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
            ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });
    datePicker.datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
    
    $("#reservationInput").on("click", function (event) {
    	event.stopPropagation();
		datePicker.datepicker("show");
	});
    
    function validateEmailInput(inputSelector, regexp) {
    	 let inputValue = $(inputSelector).val();
    	
        if (inputValue) {
            if (!regexp.test(inputValue)) {
                let warningText = `
                    <div class="wrongMailInfo border rounded-3 bg-danger-subtle ms-1 px-1">
                        <span style="font-size: 13px">\${inputValue}</span>
                        <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
                        <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
                    </div>
                `;
                $(inputSelector).before(warningText);
                $(inputSelector).val("");
                $(inputSelector).focus();
            }
        }
    }
    
});

function getFileIcon(fileName) {
    const extension = fileName.split('.').pop().toLowerCase();
    return fileIcons[extension] || '${pageContext.request.contextPath}/resources/icon/icon-default.png'; // 기본 아이콘 경로
}

function cleanAndSplit(text) {
    return text.replace(/"/g, '')
               .replace(/</g, '&lt;')
               .replace(/>/g, '&gt;')
               .trim()
               .split(" ");
}

function fileListPreview(files) {
    if(files != null && files != undefined){
    	let tag = "";
    	
        for(i=0; i<files.length; i++){
            let f = files[i];
            fileList.push(f);
            let fileName = f.name;
            let fileIcon = getFileIcon(fileName);
            let fileSize = formatFileSize(f.size);
            fileTotalSize = fileTotalSize + f.size;
            
            tag += 
                "<div class='fileList d-flex flex-row justify-content-between w-100' data-size="+ f.size +">" +
                    "<div class='d-flex flex-row'>" +
                        "<span class='icon-container' style='display:flex;align-items:center;margin-right:8px;'>" +
                            "<i class='bi bi-x' style='cursor: pointer;'></i>" +
                            "<img src='" + fileIcon + "' alt='icon' style='width:20px;height:20px;' />" +
                        "</span>" +
                        "<span class='fileName' style='margin-right:8px;'>" + fileName + "</span>" +
                    "</div>" +
                    "<div>" +
                        "<span style='margin-right:8px'>일반첨부</span>" +
                        "<span class='fileSize'>" + fileSize + "</span>" +
                    "</div>" +
                "</div>";

        }
        $("#fileList").append(tag);
        $("#fileTotalSize").text(formatFileSize(fileTotalSize));
    }
}

function DBFileListPreview(files) {
    if(files != null && files != undefined){
    	let tag = "";
    	
        for(i=0; i<files.length; i++){
            let f = files[i];
            fileList.push(f);
            let fileName = f.fileOriginalname;
            let fileIcon = getFileIcon(fileName);
            let fileSize = formatFileSize(f.fileSize);
            fileTotalSize = fileTotalSize + f.fileSize;
            
            tag += 
                "<div class='fileList d-flex flex-row justify-content-between w-100' data-size="+ f.fileSize +" data-detail-no="+f.fileDetailNo+">" +
                    "<div class='d-flex flex-row'>" +
                        "<span class='icon-container' style='display:flex;align-items:center;margin-right:8px;'>" +
                            "<i class='bi bi-x' style='cursor: pointer;'></i>" +
                            "<img src='" + fileIcon + "' alt='icon' style='width:20px;height:20px;' />" +
                        "</span>" +
                        "<span class='fileName' style='margin-right:8px;'>" + fileName + "</span>" +
                    "</div>" +
                    "<div>" +
                        "<span style='margin-right:8px'>일반첨부</span>" +
                        "<span class='fileSize'>" + fileSize + "</span>" +
                    "</div>" +
                "</div>";

        }
        $("#fileList").append(tag);
        $("#fileTotalSize").text(formatFileSize(fileTotalSize));
    }
}

function getEmail(userInfo) {
	if (userInfo.length>0) {
		let ltIndex = userInfo.indexOf("<");
		let gtIndex = userInfo.indexOf(">");
		if (ltIndex == -1 || gtIndex == -1) {
			return;
		}
		return userInfo.substring(ltIndex+1,gtIndex);
	}else {
		return;
	}
	
}

function validateDateTime() {
    let selectedDate = new Date(datePicker.value);
    let selectedHour = parseInt(hourSelect.value);
    let selectedMinute = parseInt(timeSelect.value);

    // 선택한 날짜와 시간을 현재 시간으로 설정
    selectedDate.setHours(selectedHour);
    selectedDate.setMinutes(selectedMinute);

    let now = new Date();
    now.setMinutes(now.getMinutes() + 10); // 현재 시간 기준으로 10분 이후

    // 선택한 시간이 현재 시간 기준 10분 이후인지 확인
    if (selectedDate >= now) {
    	mailResDate = selectedDate;
		return true;
    } else {
		return false;
    }
}


function highlightItem(index, listContainer, listItems) {
    listItems.removeClass('active'); // 기존 활성화된 항목 제거
    listItems.eq(index).addClass('active'); // 현재 인덱스의 항목 강조

    // 강조된 항목이 보이도록 스크롤 조정
    const highlightedItem = listItems.eq(index);

    // 강조된 항목이 보이는 영역을 벗어나면 스크롤
    if (highlightedItem.position().top < 0) {
        listContainer.scrollTop(listContainer.scrollTop() + highlightedItem.position().top);
    } else if (highlightedItem.position().top + highlightedItem.outerHeight() > listContainer.height()) {
        listContainer.scrollTop(listContainer.scrollTop() + highlightedItem.position().top - listContainer.height() + highlightedItem.outerHeight());
    }
}

function formatDate(originalDate) {
    const dateParts = originalDate.split(" "); // 날짜와 시간 분리
    const date = dateParts[0]; // '2024년 10월 15일'
    const time = dateParts[1]; // '09:12'
    
    // 날짜에서 년, 월, 일 추출
    const [year, month, day] = date.match(/\d+/g);

    // 시간에서 시, 분 추출
    const [hour, minute, second] = time.split(":").map(Number);
    
    // 오전, 오후 설정
    const amPm = hour < 12 ? '오전' : '오후';
    const formattedHour = hour % 12 || 12; // 12시간제로 변환

    // 요일 계산 (일요일=0, 월요일=1, ..., 토요일=6)
    const weekdayNames = ['일', '월', '화', '수', '목', '금', '토'];
    const dateObj = new Date(year, month - 1, day); // Date 객체 생성
    const weekday = weekdayNames[dateObj.getDay()]; // 요일

    // 최종 형식
    return `\${year}년 \${month}월 \${day}일 (\${weekday}) \${amPm} \${formattedHour}:\${minute < 10 ? '0' + minute : minute}`;
}

function formatDateString(isoString) {
    // ISO 문자열을 Date 객체로 변환
    const date = new Date(isoString);
    
    // 연도, 월, 일, 시, 분, 초 가져오기
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');
    
    // 원하는 형식으로 문자열 생성
    return `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
}

function fillInput(mailNo) {
	axios({
	    method: 'post',
	    url: '/mail/fillInput.do',
	    data: {
	    	mailNo: mailNo,
	    }
	})
	.then(function (response) {
		let res = response.data;
		if (res.mailImp = 'Y') {
			$("#mailImp").prop("checked", true);
		}
		let recipientList = [];
		let CCList = [];
		let BCCList = [];
		let toInputHTML = "";
		let ccInputHTML = "";
		let bccInputHTML = "";
		let contentInputHTML = "";
		let mailDate = formatDate(res.mailDate);
		let detailFileList = res.fileList;
		for (var i = 0; i < detailFileList.length; i++) {
			dbFile.push(detailFileList[i].fileDetailNo);
		}
		DBFileListPreview(detailFileList);
		
		for (var i = 0; i < res.recipientList.length; i++) {
			if (res.recipientList[i].recType == '받는사람') {
				recipientList.push(res.recipientList[i]);
			}else if (res.recipientList[i].recType == 'CC') {
				CCList.push(res.recipientList[i]);
			}else {
				BCCList.push(res.recipientList[i]);
			}
		}
	    if (type == 'reply' || type == 'allReply') {
	    	toInputHTML += `
					        <div class="mailInfo addressList d-flex flex-row align-items-center" data-to="recipient">
					            <div class="border rounded-3 bg-info-subtle ms-1 px-1">
					                <span style="font-size: 13px">\${res.memName}/\${res.posName}/\${res.deptName} &lt;\${res.memEmail}&gt;</span>
					                <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
					                <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
					            </div>
					        </div>
	    					`;
		}
		if (type == 'allReply' || type == 'again') {
			for (var i = 0; i < recipientList.length; i++) {
				if (recipientList[i].recipientName != `${member.memName}`) {
					toInputHTML += `
							        <div class="mailInfo addressList d-flex flex-row align-items-center" data-to="recipient">
							            <div class="border rounded-3 bg-info-subtle ms-1 px-1">
							                <span style="font-size: 13px">\${recipientList[i].recipientName}/\${recipientList[i].recipientPosName}/\${recipientList[i].recipientDeptName} &lt;\${recipientList[i].recipientEmail}&gt;</span>
							                <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
							                <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
							            </div>
						        	</div>										
								  `;
				}
			}
			for (var i = 0; i < CCList.length; i++) {
				if (CCList[i].recipientName != `${member.memName}`) {
					ccInputHTML += `
							        <div class="mailInfo addressList d-flex flex-row align-items-center" data-to="CC">
							            <div class="border rounded-3 bg-info-subtle ms-1 px-1">
							                <span style="font-size: 13px">\${CCList[i].recipientName}/\${CCList[i].recipientPosName}/\${CCList[i].recipientDeptName} &lt;\${CCList[i].recipientEmail}&gt;</span>
							                <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
							                <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
							            </div>
						        	</div>										
								  `;
				}
			}
			for (var i = 0; i < BCCList.length; i++) {
				if (BCCList[i].recipientName != `${member.memName}`) {
					bccInputHTML += `
							        <div class="mailInfo addressList d-flex flex-row align-items-center" data-to="BCC">
							            <div class="border rounded-3 bg-info-subtle ms-1 px-1">
							                <span style="font-size: 13px">\${BCCList[i].recipientName}/\${BCCList[i].recipientPosName}/\${BCCList[i].recipientDeptName} &lt;\${BCCList[i].recipientEmail}&gt;</span>
							                <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
							                <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
							            </div>
						        	</div>										
								  `;
				}
			}
		}
		if (type == 'reply' || type == 'allReply' || type == 'forward') {
	    	contentInputHTML = `
	    						<p></p>
					    		<div><br><br></div>
					    		<p 
						    		style="font-size:10pt;font-family:sans-serif;padding:0 0 0 10pt"><span>-----Original Message-----</span><br>
						    		<b>From:</b> \${res.memName}/\${res.posName}/\${res.deptName} &lt;\${res.memEmail}&gt; <br>
						    		<b>To:</b> `;
			for (var i = 0; i < recipientList.length; i++) {
				contentInputHTML += `
									\${recipientList[i].recipientName}/\${recipientList[i].recipientPosName}/\${recipientList[i].recipientDeptName} &lt;\${recipientList[i].recipientEmail}&gt;; 
									`;
			}
			contentInputHTML += ` <br><b>CC:</b> `;
			for (var i = 0; i < CCList.length; i++) {
				contentInputHTML += `
									\${CCList[i].recipientName}/\${CCList[i].recipientPosName}/\${CCList[i].recipientDeptName} &lt;\${CCList[i].recipientEmail}&gt;; 
									`;
			}						    		
			contentInputHTML += ` <br><b>BCC:</b> `;
			for (var i = 0; i < BCCList.length; i++) {
				contentInputHTML += `
									\${BCCList[i].recipientName}/\${BCCList[i].recipientPosName}/\${BCCList[i].recipientDeptName} &lt;\${BCCList[i].recipientEmail}&gt;; 
									`;
			}					
			contentInputHTML += `
						    		<br><b>Sent:</b> \${mailDate} <br>
						    		<b>Subject:</b> \${res.mailTitle}<br><br>
						    	`;
			if (res.mailContent) {
				contentInputHTML += `
						    		\${res.mailContent}
		    						`;
			}
		}
		if (type == 'again') {
			if (res.mailContent) {
				contentInputHTML = `\${res.mailContent}`;
			}
		}
		$(".lastInput").eq(0).before(toInputHTML);
		$(".lastInput").eq(1).before(ccInputHTML);
		$(".lastInput").eq(2).before(bccInputHTML);
		CKEDITOR.instances.mailContent.setData(contentInputHTML);
	})
	.catch(function (error) {
	    console.log(error);
	});
}

function getDepartmentTree() {
	axios({
		url : "/mail/getDepartmentTree.do",
		method : "get",
	}).then(function (response) {
		let res = response.data;
		console.log(res);
		let departmentTreeHTML = "";
		departmentTreeHTML += `
							<ul class="mb-0 treeview position-relative" id="departmentTreeview">
								<li class="treeview-list-item">
									<p class="treeview-text">
										<a data-bs-toggle="collapse" href="#departmentTreeview-1-1" role="button" aria-expanded="false"> <span style="font-weight: 500; font-size: 18px" class='text-800'>대덕인재개발원</span>
										</a>
									</p>
									<ul class="collapse treeview-list ps-1" id="departmentTreeview-1-1" data-show="true">
									`;
		for (var i = 0; i < res.length; i++) {
			departmentTreeHTML += `
									<li class="treeview-list-item">
										<div class="treeview-item w-100">
											<p class="treeview-text py-2 w-100">
								  `;
			if (i == 0) {
				departmentTreeHTML += `<a class="flex-1 fs-9 w-100" href="#"><span class="selectedDept px-1 align-middle" style="height: 20px;line-height: 20px" data-no="\${res[i].deptNo}">\${res[i].deptName}</span></a>`;
			}else {
				departmentTreeHTML += `<a class="flex-1 fs-9 w-100" href="#"><span class="px-1 align-middle" style="height: 20px;line-height: 20px" data-no="\${res[i].deptNo}">\${res[i].deptName}</span></a>`;
			}
		}
		departmentTreeHTML += `</p></div></li></ul></li></ul>`;
		$("#addressBookDeptList").html(departmentTreeHTML);
	});
}



</script>