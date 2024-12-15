<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- ===============================================-->
<!--    sidebar 시작    -->
<!-- ===============================================-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=more_vert" />
<style>
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
	height: 2px;
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

</style>
<div class="navbar-vertical-content h-100 scrollbar border-end border-end-1" style="min-width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">메일</h4>
			<a href=""><i class="bi bi-gear text-dark-emphasis fs-7 me-3"></i></a>
		</div>
		<div style="text-align: center;">
			<a class="btn border-dark me-1 mb-1 px-6 py-2" href="/mail/register.do" id="registerBtn">메일 쓰기</a>
		</div>
	</div>
	<div class="p-3" id="sidebar-content"">
		<ul class="mb-0 treeview" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">메일함</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span style="height: 20px">받은메일함</span> <span class="badge rounded-pill badge-subtle-secondary ms-1" style="height: 20px; padding-top: 5px">3</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text d-flex flex-row justify-content-between w-100">
								<a class="flex-1 d-inline-block" href="#!"> <span style="height: 20px">보낸메일함</span> <span class="badge rounded-pill badge-subtle-secondary ms-1" style="height: 20px; padding-top: 5px">3</span></a>
								<a class="d-inline-block" style="cursor: pointer;"><span class="d-inline-block border py-0 fs-11" style="padding: 0 2px">수신확인</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span style="height: 20px">임시메일함</span> <span class="badge rounded-pill badge-subtle-secondary ms-1" style="height: 20px; padding-top: 5px">3</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span style="height: 20px">예약메일함</span> <span class="badge rounded-pill badge-subtle-secondary ms-1" style="height: 20px; padding-top: 5px">3</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text d-flex flex-row justify-content-between w-100">
								<a class="flex-1" href="#!"> <span style="height: 20px">스팸메일함</span> <span class="badge rounded-pill badge-subtle-secondary ms-1" style="height: 20px; padding-top: 5px">3</span></a>
								<a class="d-inline-block" style="cursor: pointer;"><span class="d-inline-block border py-0 fs-11" style="padding: 0 2px">비우기</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text d-flex flex-row justify-content-between w-100">
								<a class="flex-1" href="#!"> 휴지통 </a>
								<a class="d-inline-block" style="cursor: pointer;"><span class="d-inline-block border py-0 fs-11" style="padding: 0 2px">비우기</span></a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			<div>
				<p class="treeview-text mb-2">
					<a class="flex-1" href="#!"> <span class="me-1" data-feather="plus" style="width: 15px; height: 15px"></span>메일함 추가
					</a>
				</p>
			</div>
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-2-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">빠른검색</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-2-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span class="me-2 text-warning"></span> 중요메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span class="me-2 text-warning"></span> 안읽은메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span class="me-2 text-primary"></span> 읽은메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span class="me-2 text-primary"></span> 첨부메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span class="me-2 text-danger"></span> 답장한메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <span class="me-2 text-info"></span> 내가쓴메일함
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-3-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">태그</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-3-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item d-flex flex-row align-items-center justify-content-between">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <i class="bi bi-tag-fill" style="color: blue;"></i> 중요자료
								</a>
							</p>
							<p class="d-flex align-items-center m-0" style="height: 26.38px;line-height: 26.38px">
								<a class="d-inline-block" style="cursor: pointer;height: 26.38px;line-height: 26.38px"><span class="material-symbols-outlined" style="color: #AAA;padding-top: 2px">more_vert</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item d-flex flex-row align-items-center justify-content-between">
							<p class="treeview-text">
								<a class="flex-1" href="#!"> <i class="bi bi-tag-fill" style="color: #FBE983"></i> 참고자료
								</a>
							</p>
							<p class="d-flex align-items-center m-0" style="height: 26.38px;line-height: 26.38px">
								<a class="d-inline-block" style="cursor: pointer;height: 26.38px;line-height: 26.38px"><span class="material-symbols-outlined" style="color: #AAA;padding-top: 2px">more_vert</span></a>
							</p>
						</div>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="border-top border-300 d-flex flex-column align-items-center justify-content-center" style="height: 120px">
		<div class="d-flex flex-column justify-content-center w-75">
			<div class="progress" style="height: 10px" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
				<div class="progress-bar bg-info" style="width: 40%"></div>
			</div>
			<div>
				<span style="font-size: 12px">2.0GB중 3.3MB 사용</span>
			</div>
			<button class="btn border border-1 border-dark" type="button">용량 추가 요청</button>
		</div>
	</div>
</div>
<!-- ===============================================-->
<!--    sidebar 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->
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
					<a class="btn p-1" id="previewBtn"> 
						<span>
							<i class="bi bi-eye"></i>
						</span> <span>미리보기</span>
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
					  			<div class="w-75" id="reservationInput">
					  				<input type="text" id="datePicker" class="form-control ps-4" readonly style="outline: none;box-shadow: none;font-size: 15px">
					  				<a id="datePickerIcon"><img alt="" src="${pageContext.request.contextPath }/resources/icon/calendarIcon.png" style="width: 20px;height: 20px"></a>
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
					        <div class="d-flex flex-row align-items-center">
					            <div class="emailInput d-flex flex-row align-items-start border rounded-1">
					                <div class="d-flex flex-row flex-wrap w-100" id="emailInputDiv" style="display: grid">
					                    <input class="form-control-sm border border-0" type="text" id="lastToInput" data-to="받는사람"/>
					                </div>
					                <div>
					                    <select class="border border-0">
					                        <option>최근주소</option>
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
			      			<div class="d-flex flex-row align-items-center">
					      		<div class="emailInput d-flex flex-row align-items-center border rounded-1">
					      			<div class="d-flex flex-row w-100">
					      				<input class="form-control-sm border border-0" type="text" id="lastCCInput" data-to="참조"/>
					      			</div>
					      			<div>
					      				<select class="border border-0">
					      					<option>최근주소</option>
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
			      			<div class="d-flex flex-row align-items-center">
					      		<div class="emailInput d-flex flex-row align-items-center border rounded-1">
					      			<div class="d-flex flex-row w-100">
					      				<input class="form-control-sm border border-0" type="text" id="lastBCCInput" data-to="숨은참조"/>
					      			</div>
					      			<div>
					      				<select class="border border-0">
					      					<option>최근주소</option>
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
				      			<input class="form-control-sm w-100 border border-0" id="mailTitle" type="text">
			      			</div>
		      			</td>
		      		</tr>
		      		<tr class="align-top">
		      			<td class="h-100 pt-3">
		      				<div class="d-flex flex-row align-items-center">
			      				<span class="d-flex flex-row align-items-center title">파일첨부<span class="d-inline-block align-center ps-1" style="cursor: pointer;"><i class="bi bi-dash-square" id="BCCIcon"></i></span></span>
			      				<span><input type="checkbox" id="largeCapacity"></span>
						        <span class="ms-1">대용량</span>
						    </div>
		      			</td>
		      			<td class="pt-3">
		      				<div class="d-flex flex-column">
			      				<div class="d-flex felx-row justify-content-between" id="fileBtnDiv">
			      					<div>
			      						<div class="btn border border-black me-1 px-1 py-0" id="selectFile" style="height: 30px;line-height: 30px">파일선택</div>
			      						<div class="btn border border-black me-1 px-1 py-0" id="selectDrive" style="height: 30px;line-height: 30px">드라이브</div>
			      						<div class="btn border border-black me-1 px-1 py-0" id="resetFile" style="height: 30px;line-height: 30px">모두삭제</div>
			      					</div>
			      					<div><span class="fs-10">일반 0Byte/20MB, 대용량 0Byte/5.0GB</span></div>
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
		<div class="d-flex flex-column" style="height: 500px;">
			<div id="tagArea" class="scrollbar mt-3 ms-2" style="width: 35%; position:relative; bottom: -5px">
				<nav class="nav-menu">
					<a>개인 주소록</a>
					<a>부서 주소록</a>
					<a>공용 주소록</a>
					<a>조직도</a>
				</nav>
			</div>
			<div class="d-flex flex-row" style="padding: 0 24px;height: 450px">
				<div class="border border-end-0" style="width: 200px">주소록</div>
				<div class="d-flex flex-column border" style="width: 350px;">
				    <div class="border-bottom">
				        <input type="text" id="memberSearch" class="border border-0 align-center w-75" placeholder="이름, 이메일, 회사">
				        <span style="cursor: pointer; float: right;"><i class="bi bi-search me-1"></i></span>
				    </div>
				    <div class="overflow-x-auto w-100">
				        <table class="table" style="min-width: 525px;">
				            <thead class="bg-200">
				                <tr>
				                    <th class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0" style="width: 30px">
				                            <input class="form-check-input" type="checkbox" data-bulk-select='{"body":"bulk-select-body","actions":"bulk-select-actions","replacedElement":"bulk-select-replace-element"}' />
				                        </div>
				                    </th>
				                    <th class="text-black dark__text-white align-middle" style="width: 75px">이름</th>
				                    <th class="text-black dark__text-white align-middle" style="width: 75px">직위</th>
				                    <th class="text-black dark__text-white align-middle" style="width: 75px">부서</th>
				                    <th class="text-black dark__text-white align-middle" style="width: 150px">이메일</th>
				                </tr>
				            </thead>
				            <tbody id="bulk-select-body">
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-1" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">김민강</td>
				                    <td class="align-middle position">PL</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">matt513@naver.com</td>
				                </tr>
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-2" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">이건우</td>
				                    <td class="align-middle position">AA</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">dlrjsdn@iris.com</td>
				                </tr>
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-2" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">김필거</td>
				                    <td class="align-middle position">DA</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">rlavlfrj@iris.com</td>
				                </tr>
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-2" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">박민수</td>
				                    <td class="align-middle position">TA</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">qkralstn@iris.com</td>
				                </tr>
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-2" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">이영준</td>
				                    <td class="align-middle position">UA</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">dldudwns@iris.com</td>
				                </tr>
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-2" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">정현영</td>
				                    <td class="align-middle position">BA</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">wjdgusdud@iris.com</td>
				                </tr>
				                <tr>
				                    <td class="align-middle white-space-nowrap">
				                        <div class="form-check mb-0">
				                            <input class="selectToCheck form-check-input" type="checkbox" id="checkbox-2" data-bulk-select-row="data-bulk-select-row" />
				                        </div>
				                    </td>
				                    <td class="align-middle name">김용주</td>
				                    <td class="align-middle position">QA</td>
				                    <td class="align-middle dept">3팀</td>
				                    <td class="align-middle email">rladydwn@iris.com</td>
				                </tr>
				            </tbody>
				        </table>
				    </div>
				</div>
				<div class="d-flex flex-column justify-content-between align-items-center" id="selectTo" style="width: 70px">
					<div class="d-flex flex-column justify-content-center align-items-center" style="height: 150px">
						<a class="btn border p-0" style="margin: 0 0 5px 0" data-to="받는사람">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px">그룹</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
						<a class="btn border p-0" data-to="받는사람">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px">개인</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
					</div>
					<div class="d-flex flex-column justify-content-center align-items-center" style="height: 150px">
						<a class="btn border p-0" style="margin: 0 0 5px 0" data-to="참조">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px">그룹</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
						<a class="btn border p-0" data-to="참조">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px">개인</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
					</div>
					<div class="d-flex flex-column justify-content-center align-items-center" style="height: 150px">
						<a class="btn border p-0" style="margin: 0 0 5px 0" data-to="숨은참조">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px">그룹</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
						<a class="btn border p-0" data-to="숨은참조">
							<span class="d-flex flex-row align-items-center" style="padding: 2px 4px"><span style="font-size: 13px">개인</span> <span><i class="bi bi-chevron-right ms-1 fs-9"></i></span></span>
						</a>
					</div>
				</div>
				<div style="width: 300px">
					<div style="height: 150px" class="w-100">
						<div style="height: 25px;">받는사람</div>
						<div class="overflow-x-auto border bg-200 w-100" id="recipients" style="width: 300px;height: 120px;">
						
						</div>
					</div>
					<div style="height: 150px">
						<div style="height: 25px;margin-top: 3px">참조</div>
						<div class="overflow-x-auto border bg-200" id="CCs"  style="width: 300px;height: 120px;">
						
						</div>
					</div>
					<div style="height: 150px;">
						<div style="height: 25px;margin-top: 2px">숨은참조</div>
						<div class="overflow-x-auto border bg-200" id="BCCs" style="width: 300px;height: 120px;">
						
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
<!-- ===============================================-->
<!--    주소록 모달 끝    -->
<!-- ===============================================-->
<script type="text/javascript">
var fileList = [];
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
	let mailResDate = null;
	let mailResTime = null;
	let addReservationBtn = $("#addReservationBtn");
	let datePicker = $("#datePicker");
	let hourSelect = $("#hourSelect");
	let timeSelect = $("#timeSelect");
	let isAlertVisible = false;
	
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
			fileList.splice(index,1);
			$(this).closest(".fileList").remove();
		}
	    if ($(this).closest(writeMyself).length) {
		    writeMyself.prop("checked", false);
		    $("#myselfInfo").remove();
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
			let myselfHTML = `
            <div class="mailInfo d-flex flex-row align-items-center" id="myselfInfo" data-to="recipient">
				<div class="border rounded-3 bg-info-subtle ms-1 px-1">
					<span style="font-size: 13px">${member.memName}/${member.posName}/${member.deptName}&lt;${member.memEmail}&gt;</span>
					<span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
					<span style="cursor: pointer;"><i class="bi bi-x"></i></span>
				</div>
        	</div>`;
        	$("#lastToInput").before(myselfHTML);
		}else{
			$("#myselfInfo").remove();
		}
	});
	
	addBtn.on("click", function () {
		let toExist = false;
		$(".mailInfo").each(function () {
		    if ($(this).data("to") === "recipient") {
		        toExist = true;
		        return false;
		    }
		});
		if (!toExist) {
			requiredAlert("받는사람이 지정되지 않았습니다.", isAlertVisible);
			return false;
		}
		
		if (!$("#mailTitle").val()) {
			requiredAlert("제목이 입력되지 않았습니다.", isAlertVisible);
			return false;
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
		
		if (mailTemp == "Y") {
			mailStatus = "임시";
		}
		
		$(".mailInfo").each(function() {
		    let dataTo = $(this).data("to"); // 현재 요소의 data-to 값 가져오기
		    let infoText = $(this).find("span").first().text(); // 첫 번째 span의 텍스트 가져오기
		    let emailStr = getEmail(infoText);

		    if (dataTo === "recipient") {
		        recipient.push(emailStr);
		    } else if (dataTo === "CC") {
		        CC.push(emailStr);
		    } else if (dataTo === "BCC") {
		        BCC.push(emailStr);
		    }
		});
		
		let recipientData = [{"recipient" : recipient},{"recipient" : CC},{"recipient" : BCC}];
		let formData = new FormData();
		
		if (fileList.length > 0) {
			for (let i = 0; i < fileList.length; i++) {
				formData.append("file", fileList[i]);
			}		
		}
		formData.append("memNo",memNo);
		formData.append("mailTitle",mailTitle);
		formData.append("mailContent",mailContent);
		formData.append("mailStatus",mailStatus);
		formData.append("mailResDate",mailResDate);
		formData.append("mailResTime",mailResTime);
		formData.append("mailToMe",mailToMe);
		formData.append("mailImp",mailImp);
		formData.append("mailRes",mailRes);
		formData.append("recipientData", new Blob([JSON.stringify(recipientData)], {type:"application/json; charset=utf-8"}));
		
		$.ajax({
			url : "/mail/send.do",
			method : "post",
			data : formData,
			processData : false,
			contentType : false,
			success : function (res) {
				if (res == "SUCCESS") {
					location.href = "/mail/main.do";
				}
			}
			
		});
	});
	
	tempBtn.on("click", function () {
		console.log(this);
		$("#mailTemp").prop("checked", true);
		addBtn.click();
	});
	
	previewBtn.on("click", function () {
		console.log(this);
	});
	
	resetBtn.on("click", function () {
		location.reload(true);
	});
	
	addReservationBtn.on("click", function () {
		if(!validateDateTime()) {
			requiredAlert("예약 시간은 현재 시간 이후 10분후 부터 가능합니다.", isAlertVisible);
			return false;
        }
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
	
	selectDrive.on("click", function () {
		console.log(this);
	});
	
	resetFile.on("click", function () {
		fileList.length = 0;
		$(".fileList").remove();
	});
	
	selectToBtn.on("click", function name() {
		console.log(this);
		let checkList = $(".selectToCheck:checked");
		let selectTo = (this).dataset.to;
		let rowInfo = "";
		for (let i = 0; i < checkList.length; i++) {
		    let row = checkList.eq(i).closest("tr");
		    let name = row.find('.name').text();
		    let position = row.find('.position').text();
		    let dept = row.find('.dept').text();
		    let email = row.find('.email').text();

		    rowInfo += `<div class='text-truncate' style="font-size:13px;white-space:nowrap">\"\${name}/\${position}/\${dept}&lt\${email}&gt\"</div> `;
		}
		if (selectTo == "받는사람") {
			recipients.html(rowInfo);
		}else if (selectTo == "참조") {
			CCs.html(rowInfo);
		}else {
			BCCs.html(rowInfo);
		}

	});
	
	toListContirm.on("click", function () {
	    let recipientsDiv = cleanAndSplit(recipients.text());
	    let CCsDiv = cleanAndSplit(CCs.text());
	    let BCCsDiv = cleanAndSplit(BCCs.text());
		$(".mailInfo").remove();
		let recipientInput = "";
	    
	    function generateInputHTML(list, type) {
	    	
	        let inputHTML = "";
	    	if (list[0]) {
		        for (let i = 0; i < list.length; i++) {
		            inputHTML += `
		                <div class="mailInfo d-flex flex-row align-items-center" data-to="\${type}">
		                    <div class="border rounded-3 bg-info-subtle ms-1 px-1">
		                        <span style="font-size: 13px">\${list[i]}</span>
		                        <span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
		                        <span style="cursor: pointer;"><i class="bi bi-x"></i></span>
		                    </div>
		                </div>`;
		        }
			}
	        return inputHTML;
	    }
		if (writeMyself.is(":checked")) {
		    recipientInput += `
	            <div class="mailInfo d-flex flex-row align-items-center" id="myselfInfo" data-to="recipient">
					<div class="border rounded-3 bg-info-subtle ms-1 px-1">
						<span style="font-size: 13px">${member.memName}/${member.posNo}/${member.deptNo}&lt;${member.memEmail}&gt;</span>
						<span style="cursor: pointer;"><i class="bi bi-pencil"></i></span>
						<span style="cursor: pointer;"><i class="bi bi-x"></i></span>
					</div>
				</div>`;
		}
	    recipientInput += recipientsDiv.length > 0 ? generateInputHTML(recipientsDiv, "recipient") : "";
	    let CCInput = CCsDiv.length > 0 ? generateInputHTML(CCsDiv, "CC") : "";
	    let BCCInput = BCCsDiv.length > 0 ? generateInputHTML(BCCsDiv, "BCC") : "";

	    $("#lastToInput").before(recipientInput);
	    $("#lastCCInput").before(CCInput);
	    $("#lastBCCInput").before(BCCInput);

	    $("#addressbookModal").modal('hide');
	});
	
	$("#addressbookModal").on("keydown", function (event) {
		if(event.keyCode == 27){
			$("#addressBookCloseBtn").click();
		}
	})

	CKEDITOR.replace("mailContent",{
		height:500,
// 		filebrowserUploadUrl: "/imageUpload.do"
	});
	
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
        console.log(this);
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
            let fileSize = null;
            if (f.size / 1024 / 1024 / 1024 > 1) {
				fileSize = (f.size / 1024 / 1024 / 1024).toFixed(2) + " GB";
			}else if (f.size / 1024 / 1024 > 1) {
				fileSize = (f.size / 1024 / 1024).toFixed(2) + " MB";
			}else if (f.size / 1024 > 1) {
				fileSize = (f.size / 1024).toFixed(2) + " KB";
			}
            
            tag += 
                "<div class='fileList d-flex flex-row justify-content-between w-100'>" +
                    "<div class='d-flex flex-row'>" +
                        "<span class='icon-container' style='display:flex;align-items:center;margin-right:8px;'>" +
                            "<i class='bi bi-x' style='cursor: pointer;'></i>" +
                            "<img src='" + fileIcon + "' alt='icon' style='width:20px;height:20px;' />" +
                        "</span>" +
                        "<span class='fileName' style='margin-right:8px;'>" + fileName + "</span>" +
                        "<span><a class='btn py-0 px-1' style='margin-right:8px;border:1px solid #999'>미리보기</a></span>" +
                        "<span><a class='btn py-0 px-1' style='margin-right:8px;border:1px solid #999'>다운로드</a></span>" +	
                    "</div>" +
                    "<div>" +
                        "<span style='margin-right:8px'>일반첨부</span>" +
                        "<span class='fileSize'>" + fileSize + "</span>" +
                    "</div>" +
                "</div>";

        }
        $("#fileList").append(tag);
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
		return true;
    } else {
		return false;
    }
}

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

</script>
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
