<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.folderClick {
	width: 100%;
	text-align: left;
	border: none;
}

.firstView {
	text-align: left;
}

input[type="checkbox"] {
	margin-right: 10px;
}

table {
	border-collapse: collapse;
}

.table-bordered > :not(caption) > * > * {
	padding: 5px;
}
</style>
<!-- sidebar 있던자리 --> 

<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->
<div id="tableExample2" style="flex: 1 0 auto" class="p-3" data-list='{"valueNames":["name","size","mime","regDate"],"page":10,"pagination":true}'>
	<br />
	<span style="margin-center: 10px; font-size: 25px" id="subTitleOfSection">개인 드라이브</span><span id="subTitleOfFolder" style="margin-left: 10px"></span>
	<div class="table-responsive scrollbar">
		<form action="/drive/filesDownload" id="filesDownload" method="post">
		</form>
		<table class="table-table-bordered w-100" id="topMenuBar">
			<colgroup>
				<col width="5%">
				<col width="6%">
				<col width="5%">
				<col width="5%">
				<col width="5%">
				<col width="8%">
				<col width="66%">
			</colgroup>
			<tr>
				<td style="cursor: pointer;" id="createFolderBtn">
					새폴더<span id="newFolderLocation" style="display: none;">9292</span>
				</td>
				<td style='cursor:pointer;' id="downloadBtn">다운로드</td>
				<td style='cursor:pointer;' id="deleteBtn">삭제</td>
				<td style='cursor:pointer;' id="copyBtn">복사</td>
				<td style='cursor:pointer;' id="moveBtn">이동</td>
				<td style='cursor:pointer;' id="sendMail">메일보내기</td>  
				<td class="mr-3 d-flex justify-content-end">       
					<div class="p-3 search-box align-middle">
						<div class="position-relative">
							<input class="form-control search-input" type="text" placeholder="Search..." id="searchWord" name="searchWord" spellcheck="false" autocomplete="off" onkeydown="if(event.key === 'Enter') document.getElementById('searchBtn').click();"/>
						    <span class="fas fa-search search-box-icon"></span>
							<button type="button" id="searchBtn" style="display: none;"></button>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<div style="min-height: 374px;">
			<table class="table table-bordered fs-9 mb-0">
				<colgroup>
					<col width="5%">    
					<col width="45%">
					<col width="12%">
					<col width="12%">
					<col width="20%">
				</colgroup>
				<thead class="bg-200">
					<tr style="text-align: center;">
						<th class="text-900 sort"></th>
						<th class="text-900 sort" data-sort="name">이름</th>
						<th class="text-900 sort" data-sort="size">크기</th>
						<th class="text-900 sort" data-sort="mime">확장자</th>
						<th class="text-900 sort" data-sort="regDate">등록날짜</th>
					</tr>
				</thead>
				<tbody class="ViewTTable list" id="ViewTableOfMy">
					<c:set value="${ fileList}" var="fileList"></c:set> 
					<c:choose>
						<c:when test="${empty fileList && empty folderList}">
							<td colspan="5" style="text-align: center;"><p class="mt-3 mb-3">조회하신 데이터가 없습니다.</p></td>
						</c:when>
						<c:otherwise>
							<c:forEach items="${folderList }" var="DriveFolderVO">
								<c:if test="${DriveFolderVO.folderType eq 1}">
									<tr class="folderClick_P">
										<td style="text-align: center;">
											<input type="checkbox" class="checkboxes" data-folder-no="${DriveFolderVO.folderNo }">
										</td>
										<td class="folderClick name" type="button">
											<span class="far fa-folder"></span>&nbsp;&nbsp;${DriveFolderVO.folderName }
											<p style="display: none;">${DriveFolderVO.folderNo }</p>
										</td>
										<td></td>
										<td></td>
										<td style="text-align: center;">${fn:substring(DriveFolderVO.folderCreate,0,10) }</td>
									</tr>
								</c:if>
							</c:forEach>
							<c:forEach items="${fileList }" var="DriveFileVO">
								<c:if test="${DriveFileVO.dfType eq 1 }">
									<tr style="text-align: center;">
										<td>
											<input type="checkbox" class="checkboxes align-middle" data-file-no="${DriveFileVO.dfNo }">
										</td>
										<td class="align-middle name" style="text-align: left;" onclick="downloadFile('${DriveFileVO.dfNo}')" role="button">${DriveFileVO.dfName }</td>
										<td class="size">
											<c:choose>
										        <c:when test="${DriveFileVO.dfSize > 1024*1024*1024 }">
										            <fmt:formatNumber value="${DriveFileVO.dfSize / 1024 / 1024 / 1024 }" maxFractionDigits="2" /> GB
										        </c:when>
										        <c:when test="${DriveFileVO.dfSize <= 1024*1024*1024 && DriveFileVO.dfSize > 1024*1024 }">
										            <fmt:formatNumber value="${DriveFileVO.dfSize / 1024 / 1024 }" maxFractionDigits="2" /> MB
										        </c:when>
										        <c:when test="${DriveFileVO.dfSize <= 1024*1024 && DriveFileVO.dfSize > 1024 }">
										            <fmt:formatNumber value="${DriveFileVO.dfSize / 1024 }" maxFractionDigits="2" /> KB
										        </c:when>
										        <c:otherwise>
										            <fmt:formatNumber value="${DriveFileVO.dfSize }" maxFractionDigits="2" /> Byte
										        </c:otherwise>
										    </c:choose>
										</td> 
										<td class="align-middle mime">${DriveFileVO.dfMime }</td>
										<td class="align-middle regDate">${fn:substring(DriveFileVO.dfCreate,0,10) }</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tbody class="ViewTTable list" id="ViewTableOfCompany">
					<c:set value="${ fileList}" var="fileList"></c:set>
					<c:choose>
						<c:when test="${empty fileList && empty folderList}">
							<tr>
								<td colspan="5" style="text-align: center;"><p class="mt-3 mb-3">조회하신 데이터가 없습니다.</p></td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${folderList }" var="DriveFolderVO">
								<c:if test="${DriveFolderVO.folderType eq 2}">
									<tr class="folderClick_P">
										<td style="text-align: center;">
											<input type="checkbox" class="checkboxes" data-folder-no='${DriveFolderVO.folderNo }'>
										</td>
										<td class="folderClick" type="button">
											<span class="far fa-folder"></span>&nbsp;&nbsp;${DriveFolderVO.folderName }
											<p style="display: none;">${DriveFolderVO.folderNo }</p>
										</td>
										<td></td>
										<td></td>
										<td style="text-align: center;">${fn:substring(DriveFolderVO.folderCreate,0,10) }</td>
									</tr>
								</c:if>
							</c:forEach>
							<c:forEach items="${fileList }" var="DriveFileVO">
								<c:if test="${DriveFileVO.dfType eq 2 }">
									<tr style="text-align: center;">
										<td>
											<input type="checkbox" class="checkboxes" data-file-no="${DriveFileVO.dfNo }">
										</td>
										<td style="text-align: left;" onclick="downloadFile('${DriveFileVO.dfNo}')" role="button">${DriveFileVO.dfName }</td>
										<td class="size">
											<c:choose>
												<c:when test="${DriveFileVO.dfSize > 1024*1024 }">
													<fmt:formatNumber value="${DriveFileVO.dfSize / 1024 / 1024 }" maxFractionDigits="2" /> MB
												</c:when>
												<c:otherwise>
													<fmt:formatNumber value="${DriveFileVO.dfSize / 1024}" maxFractionDigits="2" /> KB
												</c:otherwise>
											</c:choose>
										</td>
										<td class="mime">${DriveFileVO.dfMime }</td>
										<td class="regDate">${fn:substring(DriveFileVO.dfCreate,0,10) }</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
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
<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    modal 시작    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    업로드 modal 시작    -->
<!-- ===============================================-->

<div class="modal fade" id="uploadModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" data-modal-name = "upload">  
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content border-0" style="width: 980px;">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button class="btn-close btn btn-sm d-flex flex-left transition-base" id="addressBookCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
					<h4 class="mb-1" style="height: 40px; line-height: 40px" id="staticBackdropLabel">업로드</h4>
				</div>
				<div class="d-flex flex-row">
					<div class="w-50 p-3" id="sidebar-content" style="height: 300px; overflow-y: auto;">   
						<ul class="mb-0 treeview" id="treeviewExample">
							<li class="treeview-list-item">
								<!-- 개인 드라이브 태그 -->
								<p class="treeview-text" style="margin-left: 10px">
								업로드할 폴더를 선택하세요
								</p>
								<p class="treeview-text">
									<a data-bs-toggle="collapse" href="#modalOfMyDrive" role="button" aria-expanded="false">
									</a>
									<span onclick="selectedFolderUpper(9292)" style="color: black; cursor:pointer; font-weight: 500; font-size: 15px">개인 드라이브</span>
								</p>
								<ul class="collapse treeview-list ps-1" id="modalOfMyDrive" data-show="false">
								</ul> <!-- 개인 드라이브 안쪽 태그 -->
							</li>

							<li class="treeview-list-item mb-2">
								<p class="treeview-text">
									<a data-bs-toggle="collapse" href="#ModalOfCompanyDrive" role="button" aria-expanded="false" > 
									</a>
									<span onclick="selectedFolderUpper(9494)" style="color: black; cursor:pointer; font-weight: 500; font-size: 15px">전사 드라이브</span>
								</p>
								<ul class="collapse treeview-list ps-1" id="ModalOfCompanyDrive" data-show="false">

								</ul>
							</li>
						</ul>
					</div>  
					<div class="w-50 p-3 border-start">
						<form>
							<label for="dfType">대상 폴더</label><br/>
							<select name="dfType" id="dfType" style="pointer-events: none;">
								<option value="1">개인 드라이브</option>
								<option value="2">전사 드라이브</option>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="uploadModalFolderName">상세 폴더 : </label> <br /> <br /> <input type="hidden" id="uploadFolderNo" name="folderNo" value="" /> 
							<div style="display: flex; align-items: center;">
							    <label for="inputFile" class="btn border border-black me-1 px-1 py-0 mt-2" style="height: 30px; line-height: 30px; cursor: pointer;">파일 선택</label>
							    <input type="file" id="inputFile" name="files" multiple="multiple" style="display: none;" />
							    <div class="btn border border-black me-1 px-1 py-0" id="delAll" style="height: 30px; line-height: 30px; cursor: pointer;">전체 삭제</div>
							</div>
							<div id="uploadFileList" style="height: 150px; overflow-y: auto;" class="d-block border scrollbar mt-2"></div>  
						</form>
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

<!-- ===============================================-->
<!--    업로드 modal 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    복사 modal 시작    -->
<!-- ===============================================-->
<div class="modal fade" id="copyModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg mt-6" role="document" style="width: 650px;">
    	<div class="modal-content border-0" style="width: 100%; height: 370px; overflow-y: auto;">	
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button class="btn-close btn btn-sm d-flex flex-left transition-base" id="addressBookCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
					<h4 class="mb-1" style="height: 40px; line-height: 40px" id="staticBackdropLabel">복사</h4>
				</div>
				<div class="d-flex flex-row">
					<div class="w-50 p-3" id="sidebar-content">
						<ul class="mb-0 treeview" id="treeviewExample" style="width: 100%; height: 190px; overflow-y: auto; border-right: 1px solid #ccc;">
							<li class="treeview-list-item">
								<!-- 개인 드라이브 태그 -->
								<p class="treeview-text">
									<a data-bs-toggle="collapse" href="#myDriveInCopy" role="button" aria-expanded="false" onclick="selectedFolderUpper(9292)">
									</a>
									<span style="color: black; cursor:pointer; font-weight: 500; font-size: 15px">개인 드라이브</span>
								</p>
								<ul class="collapse treeview-list ps-1" id="myDriveInCopy" data-show="false">
								</ul> <!-- 개인 드라이브 안쪽 태그 -->
							</li>

							<li class="treeview-list-item mb-2">
								<p class="treeview-text">
									<a data-bs-toggle="collapse" href="#companyDriveInCopy" role="button" aria-expanded="false" onclick="selectedFolderUpper(9494)">
									</a>
									<span style="color: black; cursor:pointer; font-weight: 500; font-size: 15px">전사 드라이브</span>
								</p>
								<ul class="collapse treeview-list ps-1" id="companyDriveInCopy" data-show="false">

								</ul>
							</li>
						</ul>
					</div>
					<div class="w-50 p-3">
						<form action="/drive/copy" method="post" id="copyForm">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="copyModalFolderName">상세 폴더 : </label> <br /> <br /> <input type="hidden" id="copyFolderNo" name="folderNo" value="" />
						</form>
					</div>
				</div>
				<div class="d-flex flex-row justify-content-end align-items-left my-2" style="height: 50px; margin-right: 40px">
					<div>
						<a class="btn btn-info d-flex align-items-left px-2 py-0 me-3" id="copyOk"><div style="height: 30px; line-height: 30px">확인</div></a>
					</div>
					<div>
						<a class="btn btn-falcon-default d-flex align-items-left px-2 py-0" id="copyCancel" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px; line-height: 30px">취소</div></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ===============================================-->
<!--    복사 modal 끝    -->
<!-- ===============================================-->
<!-- ===============================================-->
<!--    이동 modal 시작    -->
<!-- ===============================================-->

<div class="modal fade" id="moveModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg mt-6" role="document" style="width: 650px;">
		<div class="modal-content border-0" style="width: 100%; height: 370px; overflow-y: auto;">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button class="btn-close btn btn-sm d-flex flex-left transition-base" id="addressBookCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-0">
				<div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
					<h4 class="mb-1" style="height: 40px; line-height: 40px" id="staticBackdropLabel">이동</h4>
				</div>
				<div class="d-flex flex-row">
					<div class="w-50 p-3" id="sidebar-content">
						<ul class="mb-0 treeview" id="treeviewExample" style="width: 100%; height: 190px; overflow-y: auto; border-right: 1px solid #ccc;">
							<li class="treeview-list-item">
								<!-- 개인 드라이브 태그 -->
								<p class="treeview-text">
									<a data-bs-toggle="collapse" href="#myDriveInMove" role="button" aria-expanded="false">
									</a>
									<span style="color: black; cursor:pointer; font-weight: 500; font-size: 15px" onclick="moveModalSelectedFolderUpper(9292)">개인 드라이브</span>
								</p>
								<ul class="collapse treeview-list ps-1" id="myDriveInMove" data-show="false">
								</ul> <!-- 개인 드라이브 안쪽 태그 -->
							</li>

							<li class="treeview-list-item mb-2">
								<p class="treeview-text">
									<a data-bs-toggle="collapse" href="#companyDriveInMove" role="button" aria-expanded="false">
									</a>
									<span style="color: black; cursor:pointer; font-weight: 500; font-size: 15px" onclick="moveModalSelectedFolderUpper(9494)">전사 드라이브</span>
								</p>
								<ul class="collapse treeview-list ps-1" id="companyDriveInMove" data-show="false">

								</ul>
							</li>
						</ul>
					</div>
					<div class="w-50 p-3">
						<form action="/drive/move" method="post" id="moveForm">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="moveModalFolderName">상세 폴더 : </label> <br /> <br /> 
							<input type="hidden" id="moveFolderNo" name="folderNo" value="" />
							<input type="hidden" id="moveFolderType" name="folderType" value="" />
						</form>
					</div>
				</div>
				<div class="d-flex flex-row justify-content-end align-items-left my-2" style="height: 50px; margin-right: 40px">
					<div>
						<a class="btn btn-info d-flex align-items-left px-2 py-0 me-3" id="moveOk"><div style="height: 30px; line-height: 30px">확인</div></a>
					</div>
					<div>
						<a class="btn btn-falcon-default d-flex align-items-left px-2 py-0" id="moveCancel" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px; line-height: 30px">취소</div></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ===============================================-->
<!--    이동 modal 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    modal 끝    -->
<!-- ===============================================-->

<!-- ===============================================-->
<!--    설정 시작    -->
<!-- ===============================================-->

<div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1" aria-labelledby="settings-offcanvas">
	<div class="offcanvas-header settings-panel-header justify-content-between bg-shape">
		<div class="z-1 py-1">
			<div class="d-flex justify-content-between align-items-left mb-1">
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
				<h5 class="fs-9 d-flex align-items-left">Navigation Position</h5>
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
		<h5 class="fs-9 d-flex align-items-left">Vertical Navbar Style</h5>
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
<script type="text/javascript">

// 업로드 모달
var uploadModal = $("#uploadModal");
//폴더 클릭되면 업로드 폴더번호 지정하기

function uploadModalselectedFolder(val1, val2){
	console.log("호출됨1");
	$("#uploadModalFolderName").text("상세 폴더: "+val2+"");
	$("input[id=uploadFolderNo]").val(val1);
	console.log($("input[id=uploadFolderNo]").val());
};
function moveModalselectedFolder(val1, val2){
	console.log("호출됨2");
	$("#moveModalFolderName").text("상세 폴더: "+val2+"");
	$("input[id=moveFolderNo]").val(val1);
	$("input[id=moveFolderType]").val(0);
};
function moveModalSelectedFolderUpper(val){
	console.log("그 긴거 호출됨");
	if(val==9292){
		$("#moveModalFolderName").text("상세 폴더 : 개인 드라이브");
		$("input[id=moveFolderNo]").val(0);
		$("input[id=moveFolderType]").val(1);
	}else if(val==9494){
		$("#moveModalFolderName").text("상세 폴더 : 전사 드라이브");
		$("input[id=moveFolderNo]").val(0);
		$("input[id=moveFolderType]").val(2);
	}
};
function copyModalselectedFolder(val1, val2){
	console.log("호출됨3");
	$("#copyModalFolderName").text("상세 폴더: "+val2+"");
	$("input[id=copyFolderNo]").val(val1);
};
function copyModalSelectedFolderUpper(val){
	$("#copyModalFolderName").text("상세 폴더: "+val2+"");
	$("input[id=copyFolderNo]").val(val1);
};

function selectedFolderUpper(val){
	console.log("호출됨");
	if(val==9292){
		$("select[name=dfType]").val("1");
		$("#uploadModalFolderName").text("상세 폴더: 없음");
		$("#ModalOfCompanyDrive").collapse('hide');
		$("input[id=uploadFolderNo]").val(0);
	}else if(val==9494){
		$("select[name=dfType]").val("2");  
		$("#uploadModalFolderName").text("상세 폴더: 없음");
		$('#modalOfMyDrive').collapse('hide');
		$("input[id=uploadFolderNo]").val(0);
	}
};

var firstView1 = $("#ViewTableOfMy").html();
var firstView2 = $("#ViewTableOfCompany").html();

function firstFolderView(val){
	if(val == 1){ 
		$(".ViewTTable").empty();
		$(".ViewTTable").append(firstView1);
		$("#newFolderLocation").text(9292);
		$("#subTitleOfSection").text("개인 드라이브");
		$("#subTitleOfFolder").text("");
		console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
	}else{ 
		$(".ViewTTable").empty();
		$(".ViewTTable").append(firstView2);
		$("#newFolderLocation").text(9494);
		$("#subTitleOfSection").text("전사 드라이브");
		$("#subTitleOfFolder").text("");
		console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
	}
}

// 사이드바에서 클릭 시 content화면 바꿔주는애 - 수정할 부분은 최상위폴더 이동하는 그거
function view(value){
	console.log("View...!");
	
	var folderNo = value;
	var ViewTable = $(".ViewTTable");
	$("#newFolderLocation").text(folderNo);
	console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());

	var data = {
			folderNo : folderNo
		}

	$.ajax({
		url : "/drive/folderView",
		type : 'POST',
		data : JSON.stringify(data),
		contentType : 'application/json; charset=utf-8',
		success : function(res){
			console.log('success'+res);
			var folders = res['folders'];
			var files = res['files'];
			var upperFolderNo = res['upperFolderNo'];
			var folderName = res['folderName'];
			var folderType = res['folderType'];
			console.log(folders);
			console.log(files);
			console.log(folderType)
			console.log(folderName)
			
			$("#subTitleOfFolder").text(folderName);
			
			if(folderType ==1){
				$("#subTitleOfSection").text("개인 드라이브");
			}else if(folderType ==2){
				$("#subTitleOfSection").text("전사 드라이브");
			}

			var str = "";

			if(upperFolderNo != 0){ 
				str += "";
				str += "<tr class='folderClick_P'>";
				str += "<td></td>";
				str += "<td colspan='5' class='folderClick' style='cursor:pointer'><span class='far fa-folder'></span>&nbsp;&nbsp;상위폴더<p style='display:none;'>"+upperFolderNo+"</p></td>";
				str += "</tr>";
				str += "";
			}else{
				str += "";
				str += "<tr class='folderClick_P'>";
				str += "<td></td>";
				str += "<td colspan='5' class='firstView' style='cursor:pointer'><span class='far fa-folder'></span>&nbsp;&nbsp;상위폴더<p style='display:none;'>"+folderType+"</p></td>";
				str += "</tr>";
				str += "";
			}

			folders.forEach(function(folder){
				var folderNo = folder.folderNo;
				str += "";
				str += "<tr class='folderClick_P' style='text-align: center;'>";
				str += "<td><input type='checkbox' class='checkboxes' data-folder-no='"+folder.folderNo+"'></td>";
				str += "<td style='text-align: left;' class='folderClick' type='button' data-folder-name='"+folder.folderName+"'><span class='far fa-folder'></span>&nbsp;&nbsp;"+folder.folderName+"<p style='display:none;'>"+folder.folderNo+"</p></td>";
				str += "<td ></td>";
				str += "<td ></td>";
				str += "<td style='text-align: center;'>" + folder.folderCreate.substring(0, 10) + "</td>";
				str += "</tr>";
				str += "";
			});
			files.forEach(function(files){
				str += "";
				str += "<tr style='text-align: center;'>";
				str += "<td><input type='checkbox' class='checkboxes' data-file-no='"+files.dfNo+"'></td>";
				str += "<td style='text-align: left;' onclick='downloadFile(\"" + files.dfNo + "\")' role='button'>" + files.dfName + "</td>";
				if(files.dfSize > 1024*1024){
					str += "<td>" + (files.dfSize / 1024 / 1024).toFixed(2) + " MB</td>";
				}else if(files.dfSize > 1024){
					str += "<td>" + (files.dfSize / 1024).toFixed(2) + " KB</td>";
				}else{
					str += "<td>" + files.dfSize + " Byte</td>";
				}
				str += "<td >"+files.dfMime+"</td>";
				str += "<td >"+files.dfCreate.substring(0, 10)+"</td>";
				str += "</tr>";
				str += "";
			});
			$(".ViewTTable").empty();
			ViewTable.append(str);

			ViewTable.on("click",".folderClick_P .firstView",function(){
				var folderType = $(this).children('p:eq(0)').text();
				if(folderType == 1){
					$(".ViewTTable").empty();
					ViewTable.append(firstView1);
					$("#newFolderLocation").text(9292);
					$("#subTitleOfFolder").text("");
					console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
				}else{
					$(".ViewTTable").empty();
					ViewTable.append(firstView2);
					$("#newFolderLocation").text(9494);
					$("#subTitleOfFolder").text("");
					console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
				}
			});

		}, error : function(xhr){
			console.error(xhr);
		}
	});
}

function downloadFile(val){
	location.href="/drive/download?dfNo="+val;
}


let $selectedItem = null;

		$('.modal').on('click', 'span', function(event) {
	        event.stopPropagation(); // 이벤트 전파 방지
			console.log("호출됨123123");
	        // 이전 선택된 항목이 있으면 원래 스타일로 되돌리기
	        if ($selectedItem) {
	            $selectedItem.removeClass('selected');
	        }
	        // 현재 클릭한 항목을 선택 상태로 변경
	        $selectedItem = $(this).parent();
	        $selectedItem.addClass('selected');
	    });



$(function(){
	var ViewTable = $(".ViewTTable");
	var firstView1 = $("#ViewTableOfMy").html();
	var firstView2 = $("#ViewTableOfCompany").html();
	$("#ViewTableOfCompany").remove(); 
	ViewTable.empty();
	ViewTable.append(firstView1);
	
	// 다운로드 버튼 눌리면 다운로드 시키기
	ViewTable.on("click","i.bi",function(){
		console.log("호출됨...!");
		location.href="/drive/download?dfNo="+$(this).data('df-no');
	});
	
	//================================================================================
	//목록 버튼 클릭 이벤트 시작
	//================================================================================
	ViewTable.on("click",".folderClick_P .folderClick",function (){
		console.log("폴더이름 : ",$(this).text());
		var folderNo = $(this).children('p:eq(0)').text();
		
		// 폴더 생성위치
		$("#newFolderLocation").text(folderNo);
		console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
		
		var data = {
				folderNo : folderNo
			}
	
		$.ajax({
			url : "/drive/folderView",
			type : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json; charset=utf-8',
			success : function(res){
				console.log('success'+res);
				var folders = res['folders'];
				var files = res['files'];
				var folderName = res['folderName'];
				var upperFolderNo = res['upperFolderNo'];
				var folderType = res['folderType'];
				var folderPath = res['folderPath'];
				
				$("#subTitleOfFolder").text(folderPath);
// 				$("#subTitleOfFolder").text(folderName);
				
				if(folderType ==1){
					$("#subTitleOfSection").text("개인 드라이브");
				}else if(folderType ==2){
					$("#subTitleOfSection").text("전사 드라이브");
				}
				
				var str = "";
	
				if(upperFolderNo != 0){
					str += "";
					str += "<tr class='folderClick_P'>";
					str += "<td></td>";
					str += "<td colspan='5' class='folderClick' style='cursor:pointer'><span class='far fa-folder'></span>&nbsp;&nbsp;상위폴더<p style='display:none;'>"+upperFolderNo+"</p></td>";
					str += "</tr>";
					str += "";
				}else{
					str += "";
					str += "<tr class='folderClick_P'>";
					str += "<td></td>";
					str += "<td colspan='5' class='firstView' style='cursor:pointer'><span class='far fa-folder'></span>&nbsp;&nbsp;상위폴더<p style='display:none;'>"+folderType+"</p></td>";
					str += "</tr>";
					str += "";
				}
	
				folders.forEach(function(folder){
					var folderNo = folder.folderNo;
					str += "";
					str += "<tr class='folderClick_P' style='text-align: center;'>";
					str += "<td><input type='checkbox' class='checkboxes' data-folder-no='"+folder.folderNo+"'></td>";
					str += "<td style='text-align: left;' class='folderClick' type='button' data-folder-name='"+folder.folderName+"'><span class='far fa-folder'></span>&nbsp;&nbsp;"+folder.folderName+"<p style='display:none;'>"+folder.folderNo+"</p></td>";
					str += "<td></td >";
					str += "<td></td >";
					str += "<td style='width: 100px;'>" + folder.folderCreate.substring(0, 10) + "</td>";
					str += "</tr>";
					str += "";
				});
	
				files.forEach(function(files){
					str += "";
					str += "<tr style='text-align: center;'>";
					str += "<td><input type='checkbox' class='checkboxes' data-file-no='"+files.dfNo+"'></td>"
					str += "<td style='text-align: left;' onclick='downloadFile(\"" + files.dfNo + "\")' role='button'>" + files.dfName + "</td>";
					if(files.dfSize > 1024*1024){
						str += "<td>" + (files.dfSize / 1024 / 1024).toFixed(2) + " MB</td>";
					}else if(files.dfSize > 1024){
						str += "<td>" + (files.dfSize / 1024).toFixed(2) + " KB</td>";
					}else{
						str += "<td>" + files.dfSize + " Byte</td>";
					}
					str += "<td >"+files.dfMime+"</td>";
					str += "<td >"+files.dfCreate.substring(0, 10)+"</td>";  
					str += "</tr>";
					str += "";
				});
				$(".ViewTTable").empty();
				ViewTable.append(str);
	
				ViewTable.on("click",".folderClick_P .firstView",function(){
					var folderType = $(this).children('p:eq(0)').text();
					if(folderType == 1){
						$(".ViewTTable").empty();  
						ViewTable.append(firstView1);
						$("#newFolderLocation").text(9292);
						$("#subTitleOfFolder").text("");
						console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
					}else{
						$(".ViewTTable").empty();
						ViewTable.append(firstView2);
						$("#newFolderLocation").text(9494);
						$("#subTitleOfFolder").text("");
						console.log("새로생길 폴더 위치 ->",$("#newFolderLocation").text());
					}
				});
	
			}, error : function(xhr){
				console.error(xhr);
			}
		});
	});
//================================================================================
//목록 버튼 클릭 이벤트 끝
//================================================================================
	var dfType = $("#dfType");
	var inputFile = $("#inputFile");
	var uploadFileList = $("#uploadFileList");
	var delAll = $("#delAll");
	var file = [];
	
	
	// X버튼
	uploadFileList.on("click", ".bi", function() {
	    var delIndex = $(this).parent().parent().index(); // 부모 div의 인덱스를 가져오기
	    console.log("splice이전 : ", file);
	    $(this).parent().parent().remove(); // 부모 div 삭제
	    file.splice(delIndex, 1);
	    console.log("splice이후 : ", file);
	});
	
	// 전체삭제 버튼
	delAll.on("click",function(){
		 uploadFileList.children('div').remove();
		 file.length = 0;
	});
	
	// 대상폴더 선택
	dfType.on("change",function(){
		  var dfTypeValue = $("#dfType option:selected").val();
		  console.log(dfTypeValue);
	});
	
	// 파일 선택
	inputFile.on("change",function(){
		 console.log("파일 변경 감지됨");
		 files = event.target.files
		 console.log("files",files);
		 for(let i=0; i<files.length; i++){
			 let fileIcon = getFileIcon(files[i].name);
			 file.push(files[i]);	// 잘 되는거 확인됨
			 var str = "";
			 str += "<div style='margin: 5px 0; border-radius: 20px; display: flex; align-items: center; width: 98%;'>";
			 str += "<span class='icon-container' style='display: flex; align-items: center; margin-right: 8px;'>";
			 str += "<i class='bi bi-x' style='cursor: pointer;'></i>";
			 str += "<img src='" + fileIcon + "' alt='icon' style='width: 20px; height: 20px; margin-left: 4px;' />";
			 str += "</span>";
			 str += "<a style='text-decoration: none; color: black; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;' title='" + files[i].name + "'>" + files[i].name + "</a>";
			 str += "</div>";
	
			 uploadFileList.append(str);
		 }
		 console.log(file);
	});
	
	function getFileIcon(fileName) {
	    const extension = fileName.split('.').pop().toLowerCase();
	    return fileIcons[extension] || '${pageContext.request.contextPath}/resources/icon/icon-default.png'; // 기본 아이콘 경로
	}
	
	var regBtn = $("#toListContirm");
	// 업로드
	regBtn.on("click",function(){
		  var dfTypeValue = $("#dfType option:selected").val();
		console.log("input[id=uploadFolderNo]")
		  var folderNo = $("input[id=uploadFolderNo]").val();
		console.log(folderNo);
		  var folderNo = Number(folderNo);
		  var formData = new FormData();
		  console.log(folderNo);
		  formData.append("dfType",dfTypeValue);
		  formData.append("folderNo",folderNo);
		  for(let i=0; i<file.length; i++){
			  formData.append("files",file[i]);
		  }
		  if(file.length == 0){
			  alert("파일을 선택해주세요");
			  return;
		  }

		  $.ajax({
			  url : "/drive/register",
			  type : "post",
			  data : formData,
			  dataType : "text",
			  processData : false,
			  contentType : false,
			  success : function(data){
				  console.log(data);
				  location.href = "/drive/list";
			  }
		  });
	
	});
	
	//===================================================================
	// 모달창 조작
	//===================================================================
	
	var uploadBtn = $("#uploadBtn");
	uploadBtn.on("click",function(){
		makeModal("uploadModal");
	});
	
	function makeModal(modalType){
		console.log(modalType);
		var myDrive = '';
		var companyDrive = ''; 
		 
		// 모달의 각 영역들 불러옴
		if(modalType == "uploadModal"){
			myDrive = $("#modalOfMyDrive");
// 			myDrive = "업로드모달";
			companyDrive = $("#ModalOfCompanyDrive");
		}else if (modalType == "moveModal"){
			myDrive = $("#myDriveInMove");
// 			myDrive = "무브모달";
			companyDrive = $("#companyDriveInMove");
		}else if(modalType == "copyModal"){
			myDrive = $("#myDriveInCopy");
// 			myDrive = "카피모달";
			companyDrive = $("#companyDriveInCopy");
		}
		
		console.log(myDrive);
		console.log(companyDrive);
		
		// 모달에 넣어줄 폴더 & 파일들 
		var upperFileList = JSON.parse($("#fileListFromController").val());
		var upperFolderList = JSON.parse($("#folderListFromController").val());
		var underFolderList = JSON.parse($("#underFolderListFromController").val());
		// html넣어줄 녀석
		var upper1 = ""; 
		var upperNo = 0;
		// 1. 최상위 폴더를 집어넣어준다. 개인/전사를 구분한다.
		for(let i=0; i<upperFolderList.length; i++){
			upperNo = 0;
			upper1 += "";
			upper1 += "<li class='treeview-list-item'>";
			upper1 += "		<p class='treeview-text ms-3'>";
			for(let j=0; j<underFolderList.length; j++){
				if(upperFolderList[i].folderNo == underFolderList[j].folderParentNo){
					upperNo += 1
				} 
			}
			if(upperNo == 0){
				upper1 += "			<span role='button' style='color: black; font-weight: 500; font-size: 15px' onclick='"+modalType+"selectedFolder("+upperFolderList[i].folderNo+",\""+upperFolderList[i].folderName+"\")'>"+upperFolderList[i].folderName+"</span>";
			}else{
				upper1 += "			<a data-bs-toggle='collapse' role='button' aria-expanded='false' href='#createdModalFolderNo"+modalType+upperFolderList[i].folderNo+"'>"; 
				upper1 += "			</a>";
				upper1 += "			<span role='button' style='color: black; font-weight: 500; font-size: 15px' onclick='"+modalType+"selectedFolder("+upperFolderList[i].folderNo+",\""+upperFolderList[i].folderName+"\")'>"+upperFolderList[i].folderName+"</span>";
			}
			upper1 += "		</p>";
			upper1 += "		<ul class='collapse treeview-list ps-1' id='createdModalFolderNo"+modalType+upperFolderList[i].folderNo+"' data-show='false'>"; 
			upper1 += "		</ul>";
			upper1 += "</li>";
			upper1 += "";
			if($("#createdModalFolderNo"+modalType+upperFolderList[i].folderNo).length == 0){   
				if(upperFolderList[i].folderType == 1){
					myDrive.append(upper1);
				}else{
					console.log('upper1 호출:', upper1);
					companyDrive.append(upper1);
				}
			}
			upper1 = ""; 
		} 
		 
		var under1 = "";
		var underNo = 0;
		// 하위폴더는 최상위폴더의 구분을 따라가기 때문에 개인/전사를 구분하지 않는다.
		for(let k=0; k<6; k++){ 
			for(let i=0; i<underFolderList.length; i++){
				underNo = 0;
				under1 += "<li class='treeview-list-item ms-3'>";
				under1 += "<p class='treeview-text ms-3'>";
				for(let j=0; j<underFolderList.length; j++){
					if(underFolderList[i].folderNo == underFolderList[j].folderParentNo){
						underNo += 1;
					}
				}
				if(underNo == 0){
					under1 += "<span role='button' style='color: black; font-weight: 500; font-size: 15px' onclick='"+modalType+"selectedFolder("+underFolderList[i].folderNo+",\""+underFolderList[i].folderName+"\")'>"+underFolderList[i].folderName+"</span>";
				}else{
					under1 += "<a data-bs-toggle='collapse' role='button' aria-expanded='false' href='#createdModalFolderNo"+modalType+underFolderList[i].folderNo+"'>"; 
					under1 += "</a>";
					under1 += "<span role='button' style='color: black; font-weight: 500; font-size: 15px' onclick='"+modalType+"selectedFolder("+underFolderList[i].folderNo+",\""+underFolderList[i].folderName+"\")'>"+underFolderList[i].folderName+"</span>";
				}
				under1 += "</p>";
				under1 += "<ul class='collapse treeview-list' id='createdModalFolderNo"+modalType+underFolderList[i].folderNo+"' data-show='true'>";
				under1 += "</ul>"; 
				under1 += "</li>";
				if($("#createdModalFolderNo"+modalType+underFolderList[i].folderParentNo).length != 0 && $("#createdModalFolderNo"+modalType+underFolderList[i].folderNo).length == 0){
					var upperFolder = $("#createdModalFolderNo"+modalType+underFolderList[i].folderParentNo);
					upperFolder.append(under1);
				}
				under1 = "";
			}
		}
	};
	//===================================================================
	// 모달창 조작 끝
	//===================================================================

		
	// 새폴더 만들기	
	var createFolderBtn = $("#createFolderBtn");
	createFolderBtn.on("click",function(){
		console.log("폴더 생성하기");
		
		var newFolderLocation = $("#newFolderLocation").text();
		
		var str = "";
		str +="<span id='createFolderArea'>";
		str +="	<hr/>";
		str +="		<form action='/drive/createFolder' id='createFolderForm' method='post'>";
		str +="			<input type='hidden' value="+newFolderLocation+" name='folderParentNo'/>";
		str +="			새폴더명<input type='text' class='newFolderName' name='folderName'/>";
		str +="			<button type = 'button' id='addFolderBtn'>확인</button>";
		str +="			<button type = 'button' id='cancelFolderAdd'>취소</button>"; 
		str +="		</form>";
		str +="	<hr/>";
		str +="</span>";
		
		if($('#topMenuBar').nextAll("span:has(.newFolderName)").length ==0){   
			$('#topMenuBar').after(str);
		}
		
		$("#addFolderBtn").on("click",function(){
			if($("input.newFolderName").val() == ""||$("input.newFolderName").val() == null){
				alert("폴더명을 입력해주세요");
				return   
			}
			$("#createFolderForm").submit();
		});
		$("#cancelFolderAdd").on("click",function(){
			$("#createFolderArea").remove();
		});
		
		str = "";
	});
	
	
	$(".checkboxes").on("click",function(){
		console.log($(this).data('folderNo'));
		console.log($(this).data('fileNo'));
	});
	
	
	// 체크박스 선택 다운로드 - 체크된 체크박스를 불러오고, 체크박스에 담겨진 folderNo와 fileNo를 이용해 다운로드를 진행 - 다수의 파일 혹은 폴더는 zip 파일로 
	$("#downloadBtn").on("click",function(){
		var selectedFile = [];
		var selectedFolder = [];
		var zipOk = false;
		$(".checkboxes:checked").each(function(){
			// 선택된 데이터들은 이렇게 가져오면 됨
			if ($(this).data('folderNo')) {
		        console.log("Folder No:", $(this).data('folderNo'));
		        selectedFolder.push($(this).data('folderNo'));
		    }
			if ($(this).data('fileNo')) {
		        console.log("File No:", $(this).data('fileNo'));
		        selectedFile.push($(this).data('fileNo'));
		    }
		});
        if (selectedFolder.length == 0 && selectedFile.length == 1) { // 파일 1개 선택
			location.href="/drive/download?dfNo="+selectedFile[0];
        }else if (selectedFolder.length == 0 && selectedFile.length == 0) { // 다시 선택
        	alert("파일을 선택해주세요");
        	$(".checkboxes:checked").prop("checked", false);
        	return;
		}else if (selectedFolder.length == 0 && selectedFile.length > 1) { // 파일 여러개 -> 집파일
			zipOk = true;
		}else { // 폴더 + 파일 -> 집파일
			zipOk = true;
		}
        for(let i=0; i<selectedFile.length; i++){
        	console.log(selectedFile[i]);
        	}
		if(zipOk){
			var form = $('#filesDownload');
				form.append('<input type="hidden" name="selectedFile" value="' + selectedFile + '">');
				form.append('<input type="hidden" name="selectedFolder" value="' + selectedFolder + '">');
			// form 제출
			form.submit();
			form.empty(); 
		}
	});
	
	
	// 삭제버튼 클릭시 삭제
	$("#deleteBtn").on("click",function(){
		if(!confirm("정말 삭제하시겠습니까?")){
			$(".checkboxes:checked").prop("checked", false);
			return
		}
		var selectedFile = [];
		var selectedFolder = [];
		$(".checkboxes:checked").each(function(){
			// 선택된 데이터들은 이렇게 가져오면 됨
			if($(this).data('folderNo')) {
		        selectedFolder.push($(this).data('folderNo'));
		    }
			if($(this).data('fileNo')) {
		        selectedFile.push($(this).data('fileNo'));
		    }
		});
		if(selectedFile.length == 0 && selectedFolder.length == 0){
			alert("삭제할 대상을 선택해주세요");
			return
		}
		var selected = [selectedFolder, selectedFile];
		console.log(selected);
		$.ajax({
			url : '/drive/delete',
			type : 'POST', 
			data : JSON.stringify(selected),
			contentType : 'application/json; charset=utf-8', 
			success : function(res){
				alert("삭제되었습니다.");
				location.reload();
			},error : function(xhr){
				console.error(xhr);
			}
		});
	});
	
	
	// 복사버튼 클릭 시 작동함
	$("#copyBtn").on("click",function(){
		console.log("cpBtn 잘눌림");
		var selectedFile = [];
		$(".checkboxes:checked").each(function(){
			if($(this).data('fileNo')){
				selectedFile.push($(this).data('fileNo'));
			}else{
				$(this).prop("checked", false);  
			}
		});
		if(selectedFile.length == 0){
			$(".checkboxes:checked").prop("checked", false);
			alert("파일을 선택해주세요");
			return;
		}
		var form = $('#copyForm');
		form.append('<input type="hidden" name="selectedFile" value="' + selectedFile + '">');
		
		$("#copyModal").modal("show");
		makeModal("copyModal");
	});
	
	// 복사 모달 확인버튼 클릭 시
	$("#copyOk").on("click",function(){
		$('#copyForm').submit();
	});

	// 복사 모달 취소버튼 클릭 시
	$("#copyCancel").on("click",function(){
		var form = $('#copyForm');
		form.find('input[name="selectedFile"]').remove();
	    form.find('input[name="selectedFolder"]').remove();
	    $("#copyFolderNo").val('');
	});
	
	
	
	// 이동버튼 클릭 시 작동함
	$("#moveBtn").on("click",function(){
		console.log("mvBtn 잘눌림");
		var selectedFile = [];
		var selectedFolder = [];
		$(".checkboxes:checked").each(function(){
			if($(this).data('fileNo')){
				selectedFile.push($(this).data('fileNo'));
			}
			if($(this).data('folderNo')){
				selectedFolder.push($(this).data('folderNo')); 
			}
		});
		if(selectedFile.length == 0 && selectedFolder.length == 0){
			alert("대상을 선택해주세요");
			return;
		}
		var form = $('#moveForm');
		form.append('<input type="hidden" name="selectedFile" value="' + selectedFile + '">');
		form.append('<input type="hidden" name="selectedFolder" value="' + selectedFolder + '">');
		$("#moveModal").modal("show");
		makeModal("moveModal");
	});
	
	// 이동 모달 확인버튼 클릭 시
	$("#moveOk").on("click",function(){
		$('#moveForm').submit();
	});

	// 이동 모달 취소버튼 클릭 시
	$("#moveCancel").on("click",function(){
		var form = $('#moveForm');
		form.find('input[name="selectedFile"]').remove();
	    form.find('input[name="selectedFolder"]').remove();
	    $("#moveFolderNo").val('');
	});
	
	
	
	// 검색버튼 클릭시 작동함
	$("#searchBtn").on("click",function(){
		var searchWord = $("#searchWord").val();
		if(searchWord.length == 0 || searchWord == ""){
			alert("검색어를 입력해주세요");
			return;
		}
		
		$.ajax({
			url : '/drive/search',
			type : 'POST',
			data : JSON.stringify({searchWord : searchWord}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				var searchedFiles = res['searchedFile'];
				var searchedFolders = res['searchedFolder'];
				var str = "";
				
				searchedFolders.forEach(function(folder){
					var folderNo = folder.folderNo;
					str += "";
					str += "<tr class='folderClick_P' style='text-align: center;'>";
					str += "<td><input type='checkbox' class='checkboxes' data-folder-no='"+folder.folderNo+"'></td>";
					str += "<td class='folderClick' type='button' data-folder-name='"+folder.folderName+"' style='text-align: left;'><span class='far fa-folder'></span>&nbsp;&nbsp;"+folder.folderName+"<p style='display:none;'>"+folder.folderNo+"</p></td>";
					str += "<td></td >";
					str += "<td></td >";
					str += "<td style='width: 100px; text-align: center;'>" + folder.folderCreate.substring(0, 10) + "</td>";
					str += "</tr>";
					str += "";
				});
	
				searchedFiles.forEach(function(files){
					str += "";
					str += "<tr style='text-align: center;'>";
					str += "<td><input type='checkbox' class='checkboxes' data-file-no='"+files.dfNo+"'></td>"
					str += "<td style='text-align: left;' onclick='downloadFile(\"" + files.dfNo + "\")' role='button'>" + files.dfName + "</td>";
					if(files.dfSize > 1024*1024){
						str += "<td>" + (files.dfSize / 1024 / 1024).toFixed(2) + " MB</td>";
					}else if(files.dfSize > 1024){
						str += "<td>" + (files.dfSize / 1024).toFixed(2) + " KB</td>";
					}else{
						str += "<td>" + files.dfSize + " Byte</td>";
					}
					str += "<td >"+files.dfMime+"</td>";
					str += "<td >"+files.dfCreate.substring(0, 10)+"</td>";  
					str += "</tr>";
					str += "";
				});
				$(".ViewTTable").empty();
				ViewTable.append(str);
				str = "";
			},error : function(xhr){
				console.error(xhr);
			}
		});
		
	});
	
	
	
});
</script>