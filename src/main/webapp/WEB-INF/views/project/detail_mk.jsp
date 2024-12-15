<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertAttribute name="siderbar">
</tiles:insertAttribute>
<style>
.sortable-ghost {
	opacity: 0.4;
	border: 2px dashed #007bff; /* 드래그 중일 때의 스타일 */
}

.kanban-header {
	height: calc(100% - 70px);
}

#dateInput {
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
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

.inp {
	padding: 10px 10px;
	background-color: #f1f1f1;
	border-radius: 4px;
	border: 0px;
}
</style>
<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->


<!-- ================================메인 화면 ============================================================================================-->
<div class="d-flex flex-column w-100">
	<div class="d-flex align-items-center p-3" style="background-color: #f9fafd; height: 70px; line-height: 70px">
		<h4>프로젝트명  : ${result.proVO.projectTitle}</h4>
		<input type="hidden" id="proj" value="${result.proVO.projectTitle}">
		<input type="hidden" id="loginMem" value="${result.loginMem[0].memNo }">
		<input type="hidden" id="nowLogin" value="${result.loginMem[0].memNo }">
		<input type="hidden" id="projectNo" name="projectNo" value="${result.proVO.projectNo }"> 
		<input type="hidden" id="mngPicNo" name="mngPicNo" value="${result.proVO.mngPicNo }">
			<p class="mb-0 fw-medium font-sans-serif" style="cursor:pointer;margin-left:auto;" onclick=openChart()>
				<span class="fas fa-chart-bar"  >
				</span>
			</p>
	</div>

	<div class="kanban-header rounded-2">
		<!-- 3분할로 나눔 -->
		<div
			class="kanban-container me-n3 w-100 d-flex flex-row justify-content-around">
			<!-- 분류함 -->
			<div class="kanban-column">
				<div class="d-block scrollbar" id="waitWork"
					style="max-height: 580px">
					<div class="kanban-column-header">
						<input type="hidden" id="workPrograss" value="wait"> 대기함 <span
							class="text-500" id="countwait"> 
							<c:choose>
								<c:when test="${empty result.workVO}">
							        ( 0 )
							    </c:when>
								<c:otherwise>
									<div id="waitDiv">
								        ( ${result.countWork.workWite } )
									</div>
							    </c:otherwise>
							</c:choose>
						</span>
					</div>
					<div class="kanban-items-container" data-sortable="data-sortable"
						id="waitDiv">
						<!-- 한칸 -->
						<c:choose>
							<c:when test="${empty result.workVO }">
								<div id="nullWork">
									업무가 없습니다.<br /> 생성해 주세요.
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${result.workVO }" var="work">
									<c:if test="${work.workPrograss eq 'wait' }">
										<div class="kanban-item sortable-item-wrapper"
											draggable="true" id="workItem${work.workNo }">
											<div
												class="card sortable-item kanban-item-card hover-actions-trigger">
												<div class="card-body">
													<!-- 숨긴버튼 -->
													<div class="position-relative">
														<div class="dropdown font-sans-serif">
															<button
																class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions"
																type="button" data-boundary="viewport"
																data-bs-toggle="dropdown" aria-haspopup="true"
																aria-expanded="false">
																<svg class="svg-inline--fa fa-ellipsis-h fa-w-16"
																	data-fa-transform="shrink-2" aria-hidden="true"
																	focusable="false" data-prefix="fas"
																	data-icon="ellipsis-h" role="img"
																	xmlns="http://www.w3.org/2000/svg"
																	viewBox="0 0 512 512" data-fa-i2svg=""
																	style="transform-origin: 0.5em 0.5em;">
															<g transform="translate(256 256)">
																<g transform="translate(0, 0)  scale(0.875, 0.875)  rotate(0 0 0)">
																	<path fill="currentColor" d="M328 256c0 39.8-32.2 72-72 72s-72-32.2-72-72 32.2-72 72-72 72 32.2 72 72zm104-72c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72zm-352 0c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72z" transform="translate(-256 -256)">
																	</path>
																</g>
															</g>
														</svg>
															</button>
															<div class="dropdown-menu dropdown-menu-end py-0" style="">
																<a class="dropdown-item text-danger" id="workDel" draggable="false" onclick=workdel(${work.workNo })>Remove</a>
															</div>
														</div>
													</div>
													<!-- 숨긴버튼 끝-->
													<div id="favorStatus${work.workNo}"  class="d-flex align-items-center">
														<c:choose> 
															<c:when test="${work.favorY eq 'Y' and work.favorMem == result.loginMem[0].memNo}"> 
																<span id="spanFavor${work.workNo }"><i class="bi bi-star-fill" style="color:orange;cursor:pointer" onclick=delFavorites(${work.workNo})></i></span>
															</c:when>
															<c:otherwise>
																<span class="favIcon me-1 text-center"  id="spanFavor${work.workNo }" style="cursor: pointer;"> <i class="bi bi-star" onclick=favorCheck(${work.workNo})></i> </span>					
															</c:otherwise>
														</c:choose>
														<p class="mb-0 fw-medium font-sans-serif" onclick=openModal(${work.workNo})>
															<input type="hidden" id="thisWorkNo${work.workNo}" name="workNo" value="${work.workNo}"> 
															<input type="hidden" id="WorkProjectNo${work.workNo}" name="projectNo" value="${work.projectNo}"> 
															<input type="hidden" id="workPrograss${work.workNo}" name="workPrograss" value="${work.workPrograss}">
															<input type="hidden" id="workFile${work.workNo}" name="workFile${work.workNo}" value="${work.fileNo}">
															<input type="hidden" id="workTi${work.workNo}"  value="${work.workTitle}">
															<input type="hidden" id="endDate${work.workNo }" value="${work.endDate }">
															<input type="hidden" id="field${work.workNo }" value="${work.field }">
															${work.workTitle}
														</p>
													</div>
													<div class="kanban-item-footer cursor-default">
														<span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="files"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-paperclip text-900 fs-6">
																<path
																	d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"></path></svg>
															<span> <c:choose>
																	<c:when
																		test="${work.fileNo != 0 and not empty work.fileDetailList}">
																        ${fn:length(work.fileDetailList)}
																    </c:when>
																	<c:otherwise>
																        0
																    </c:otherwise>
																</c:choose>
														</span>
														</span> <span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="Attachments"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-user text-900 fs-6">
																<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2">
		                                                    </path>
		                                                    <circle cx="12"
																	cy="7" r="4">
		                                                    </circle>
	                                                    </svg> <span>
																${fn:length(work.picList)} </span>
														</span> <span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="Checklist"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-file-text text-900 fs-6">
															<path
																	d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
															<polyline points="14 2 14 8 20 8"></polyline>
																<line x1="16" y1="13" x2="8" y2="13">
															 </line>
																<line x1="16" y1="17" x2="8" y2="17"></line>
																<polyline points="10 9 9 9 8 9"></polyline></svg> <span>
																${work.totalcheck } </span>
																
														</span>
													</div>
													<div class="me-2">
														<div class="echart-pie-chart-example"
															style="min-height: 5px;" data-echart-responsive="true"></div>
														<div class="progress mb-3" style="height: 15px"
															role="progressbar" aria-valuenow="50" aria-valuemin="0"
															aria-valuemax="100">
															<div class="progress-bar" id="workField${work.workNo }" style="width: ${work.field}%">
																${work.field}%
																
																<input type="hidden" id="field${work.workNo }" value="${work.field}">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- 분류함 대기함은 plus포함 -->
				<div class="kanban-column-footer">
					<div class="fs-9 mb-0">
						<div class="kanban-item sortable-item-wrapper" draggable="false">
							<div
								class="card sortable-item kanban-item-card hover-actions-trigger">
								<div class="card-body">
									<p class="mb-0 fw-medium font-sans-serif stretched-link"
										data-bs-toggle="modal" data-bs-target="#asdf">
										<button
											class="btn btn-link btn-sm d-block w-100 btn-add-card text-decoration-none text-600"
											type="button">
											<svg style="width: 15px; height: 15px"
												class="svg-inline--fa fa-plus fa-w-14 me-2"
												aria-hidden="true" focusable="false" data-prefix="fas"
												data-icon="plus" role="img"
												xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
												data-fa-i2svg="">
                                                <path
													fill="currentColor"
													d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
                                            </svg>
										</button>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 분류함 대기함은 plus포함 영역 끝-->
			</div>
			<!-- 분류함 끝 -->

			<!-- 진행함 -->
			<div class="kanban-column" id="ingWork">
				<div class="kanban-column-header">
					<input type="hidden" id="workPrograss" value="ing"> 진행함 <span
						class="text-500" id="counting"> 
						<c:choose>
							<c:when test="${empty result.workVO}">
					      	  ( 0 )
					    	</c:when>
							<c:otherwise>
							<div id="ingDiv">
						        ( ${result.countWork.workIng} )
							</div>
					   		</c:otherwise>
						</c:choose>
					</span>
				</div>
				<div class="kanban-items-container scrollbar"
					data-sortable="data-sortable" id="ingWorkDiv" style="height: 650px">
					<!-- 한칸 -->
					<c:choose>
						<c:when test="${empty result.workVO }">
							<div id="nullWorkIng">
								진행중인 업무가 없습니다.<br />
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${result.workVO }" var="work">
								<c:if test="${work.workPrograss eq 'ing' }">
										<div class="kanban-item sortable-item-wrapper"
											draggable="true" id="workItem${work.workNo }">
											<div
												class="card sortable-item kanban-item-card hover-actions-trigger">
												<div class="card-body">
													<!-- 숨긴버튼 -->
													<div class="position-relative">
														<div class="dropdown font-sans-serif">
															<button
																class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions"
																type="button" data-boundary="viewport"
																data-bs-toggle="dropdown" aria-haspopup="true"
																aria-expanded="false">
																<svg class="svg-inline--fa fa-ellipsis-h fa-w-16"
																	data-fa-transform="shrink-2" aria-hidden="true"
																	focusable="false" data-prefix="fas"
																	data-icon="ellipsis-h" role="img"
																	xmlns="http://www.w3.org/2000/svg"
																	viewBox="0 0 512 512" data-fa-i2svg=""
																	style="transform-origin: 0.5em 0.5em;">
															<g transform="translate(256 256)">
																<g transform="translate(0, 0)  scale(0.875, 0.875)  rotate(0 0 0)">
																	<path fill="currentColor" d="M328 256c0 39.8-32.2 72-72 72s-72-32.2-72-72 32.2-72 72-72 72 32.2 72 72zm104-72c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72zm-352 0c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72z" transform="translate(-256 -256)">
																	</path>
																</g>
															</g>
														</svg>
															</button>
															<div class="dropdown-menu dropdown-menu-end py-0" style="">
																<a class="dropdown-item text-danger" id="workDel" draggable="false" onclick=workdel(${work.workNo })>Remove</a>
															</div>
														</div>
													</div>
													<!-- 숨긴버튼 끝-->
													<div id="favorStatus${work.workNo}"  class="d-flex align-items-center">
														<c:choose>
															<c:when test="${work.favorY eq 'Y' and work.favorMem == result.loginMem[0].memNo}"> 
																	<span id="spanFavor${work.workNo }"><i class="bi bi-star-fill" style="color:orange;cursor:pointer" onclick=delFavorites(${work.workNo})></i></span>
															</c:when>
															<c:otherwise>
																<span class="favIcon me-1 text-center"  id="spanFavor${work.workNo }" style="cursor: pointer;"> <i class="bi bi-star" onclick=favorCheck(${work.workNo})></i> </span>					
															</c:otherwise>
														</c:choose>
													<p class="mb-0 fw-medium font-sans-serif"
														onclick=openModal(${work.workNo})>
														<input type="hidden" id="thisWorkNo${work.workNo}" name="workNo" value="${work.workNo}"> 
														<input type="hidden" id="WorkProjectNo${work.workNo}" name="projectNo" value="${work.projectNo}"> 
														<input type="hidden" id="workPrograss${work.workNo}" name="workPrograss" value="${work.workPrograss}">
														<input type="hidden" id="workFile${work.workNo}" name="workFile${work.workNo}" value="${work.fileNo}">
														<input type="hidden" id="workTi${work.workNo}"  value="${work.workTitle}">
														<input type="hidden" id="endDate${work.workNo }" value="${work.endDate }">
														<input type="hidden" id="field${work.workNo }" value="${work.field }">
														${work.workTitle}
													</p>
													</div>
													<div class="kanban-item-footer cursor-default">
														<span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="files"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-paperclip text-900 fs-6">
																<path
																	d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"></path></svg>
															<span> <c:choose>
																	<c:when
																		test="${work.fileNo != 0 and not empty work.fileDetailList}">
																        ${fn:length(work.fileDetailList)}
																    </c:when>
																	<c:otherwise>
																        0
																    </c:otherwise>
																</c:choose>
														</span>
														</span> <span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="Attachments"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-user text-900 fs-6">
																<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2">
		                                                    </path>
		                                                    <circle cx="12"
																	cy="7" r="4">
		                                                    </circle>
	                                                    </svg> <span>
																${fn:length(work.picList)} </span>
														</span> <span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="Checklist"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-file-text text-900 fs-6">
															<path
																	d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
															<polyline points="14 2 14 8 20 8"></polyline>
																<line x1="16" y1="13" x2="8" y2="13">
															 </line>
																<line x1="16" y1="17" x2="8" y2="17"></line>
																<polyline points="10 9 9 9 8 9"></polyline></svg> <span>
																${work.totalcheck } </span>
														</span>
													</div>
													<div class="me-2">
														<div class="echart-pie-chart-example"
															style="min-height: 5px;" data-echart-responsive="true"></div>
														<div class="progress mb-3" style="height: 15px"
															role="progressbar" aria-valuenow="50" aria-valuemin="0"
															aria-valuemax="100">
															<div class="progress-bar" id="workField${work.workNo }" style="width: ${work.field}%">
																${work.field}%
																<input type="hidden" id="field${work.workNo }" value="${work.field}">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			<!-- 진행함 끝 -->

			<!-- 완료함 -->
			<div class="kanban-column" id="endWork">
				<div class="kanban-column-header">
					<input type="hidden" id="workPrograss" value="end"> 완료함 <span
						class="text-500" id="countend"> <c:choose>
							<c:when test="${empty result.workVO}">
						        ( 0 )
						    </c:when>
							<c:otherwise>
								<div id="endDiv">
						       	 ( ${result.countWork.workEnd} )
								</div>
						    </c:otherwise>
						</c:choose>
					</span>
				</div>
				<div class="kanban-items-container scrollbar"
					data-sortable="data-sortable" id="endWorkDiv" style="">
					<!-- 한칸 -->
					<c:choose>
						<c:when test="${empty result.workVO  }">
							<div id="nullWorkEnd">
								완료된 업무가 없습니다.<br />
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${result.workVO  }" var="work">
								<c:if test="${work.workPrograss eq 'end' }">
										<div class="kanban-item sortable-item-wrapper"
											draggable="true" id="workItem${work.workNo }">
											<div
												class="card sortable-item kanban-item-card hover-actions-trigger">
												<div class="card-body">
													<!-- 숨긴버튼 -->
													<div class="position-relative">
														<div class="dropdown font-sans-serif">
															<button
																class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions"
																type="button" data-boundary="viewport"
																data-bs-toggle="dropdown" aria-haspopup="true"
																aria-expanded="false">
																<svg class="svg-inline--fa fa-ellipsis-h fa-w-16"
																	data-fa-transform="shrink-2" aria-hidden="true"
																	focusable="false" data-prefix="fas"
																	data-icon="ellipsis-h" role="img"
																	xmlns="http://www.w3.org/2000/svg"
																	viewBox="0 0 512 512" data-fa-i2svg=""
																	style="transform-origin: 0.5em 0.5em;">
															<g transform="translate(256 256)">
																<g transform="translate(0, 0)  scale(0.875, 0.875)  rotate(0 0 0)">
																	<path fill="currentColor" d="M328 256c0 39.8-32.2 72-72 72s-72-32.2-72-72 32.2-72 72-72 72 32.2 72 72zm104-72c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72zm-352 0c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72z" transform="translate(-256 -256)">
																	</path>
																</g>
															</g>
														</svg>
															</button>
															<div class="dropdown-menu dropdown-menu-end py-0" style="">
																<a class="dropdown-item text-danger" id="workDel" draggable="false" onclick=workdel(${work.workNo })>Remove</a>
															</div>
														</div>
													</div>
													<!-- 숨긴버튼 끝-->
													<div id="favorStatus${work.workNo}"  class="d-flex align-items-center">
													<c:choose>
														<c:when test="${work.favorY eq 'Y' and work.favorMem == result.loginMem[0].memNo}"> 
															<span id="spanFavor${work.workNo }"><i class="bi bi-star-fill" style="color:orange;cursor:pointer" onclick=delFavorites(${work.workNo})></i></span>
														</c:when>
														<c:otherwise>
															<span class="favIcon me-1 text-center"  id="spanFavor${work.workNo }" style="cursor: pointer;"> <i class="bi bi-star" onclick=favorCheck(${work.workNo})></i> </span>					
														</c:otherwise>
													</c:choose>	
													<p class="mb-0 fw-medium font-sans-serif"
														onclick=openModal(${work.workNo})>
														<input type="hidden" id="thisWorkNo${work.workNo}" name="workNo" value="${work.workNo}"> 
														<input type="hidden" id="WorkProjectNo${work.workNo}" name="projectNo" value="${work.projectNo}"> 
														<input type="hidden" id="workPrograss${work.workNo}" name="workPrograss" value="${work.workPrograss}">
														<input type="hidden" id="workFile${work.workNo}" name="workFile${work.workNo}" value="${work.fileNo}">
														<input type="hidden" id="workTi${work.workNo}"  value="${work.workTitle}">
														<input type="hidden" id="endDate${work.workNo }" value="${work.endDate }">
														<input type="hidden" id="field${work.workNo }" value="${work.field }">
														${work.workTitle}
													</p>
													</div>
													<div class="kanban-item-footer cursor-default">
														<span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="files"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-paperclip text-900 fs-6">
																<path
																	d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"></path></svg>
															<span> <c:choose>
																	<c:when
																		test="${work.fileNo != 0 and not empty work.fileDetailList}">
																        ${fn:length(work.fileDetailList)}
																    </c:when>
																	<c:otherwise>
																        0
																    </c:otherwise>
																</c:choose>
														</span>
														</span> <span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="Attachments"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-user text-900 fs-6">
																<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2">
		                                                    </path>
		                                                    <circle cx="12"
																	cy="7" r="4">
		                                                    </circle>
	                                                    </svg> <span>
																${fn:length(work.picList)} </span>
														</span> <span class="me-2" data-bs-toggle="tooltip"
															data-bs-original-title="Checklist"> <svg
																xmlns="http://www.w3.org/2000/svg" width="15"
																height="15" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-file-text text-900 fs-6">
															<path
																	d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
															<polyline points="14 2 14 8 20 8"></polyline>
																<line x1="16" y1="13" x2="8" y2="13">
															 </line>
																<line x1="16" y1="17" x2="8" y2="17"></line>
																<polyline points="10 9 9 9 8 9"></polyline></svg> <span>
																${work.totalcheck } </span>
														</span>
													</div>
													<div class="me-2">
														<div class="echart-pie-chart-example"
															style="min-height: 5px;" data-echart-responsive="true"></div>
														<div class="progress mb-3" style="height: 15px"
															role="progressbar" aria-valuenow="50" aria-valuemin="0"
															aria-valuemax="100">
															<div class="progress-bar" id="workField${work.workNo }" style="width: ${work.field}%">
																${work.field}%
																<input type="hidden" id="field${work.workNo }" value="${work.field}">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			<!-- 완료함 끝 -->
		</div>
	</div>
</div>


<!--  업무 생성  -->
<div class="modal fade" id="asdf" data-bs-keyboard="false"
	data-bs-backdrop="static" tabindex="-1" aria-labelledby="asdfHead"
	aria-hidden="true">
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content position-relative border-0 d-block">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button
					class="btn-close btn btn-sm d-flex flex-center transition-base border border-0"
					id="asdfCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
				<div class="position-absolute d-flex flex-column d-gap gap-1"
					style="width: 150px; left: 50px; top: -15px">
					<a href="#" class="position-relative btn btn-light border bg-light"
						data-target="#managerTab">담당자</a>
					<div
						class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none"
						id="managerTab" style="top: 40px; width: 300px; z-index: 2000">
						<div class="d-flex flex-row py-1">
							<div class="position-relative col-sm-12 py-1 text-center">담당자</div>
							<div class="position-absolute"
								style="cursor: pointer; left: 275px; top: 12px">
								<i class="bi bi-x-lg"></i>
							</div>
						</div>
						<div class="py-2">
							<input type="text" class="form-control form-control-sm"
								placeholder="멤버 검색">
						</div>
						<!-- 해당 업무 인원 추가 -->
						<div class="d-block scrollbar" style="height: 125px;">
							<c:choose>
								<c:when test="${empty result.proVO.paList }">
								해당 프로젝트에 인원이 없습니다.
							</c:when>
								<c:otherwise>
									<c:forEach items="${result.proVO.paList }" var="pro" varStatus="i">
											<div class="member-address d-flex flex-row">
												<span class="modAddedPicMemberd-flex flex-row" id="addedPicMember_${pro.memNo }">${pro.memName } ${pro.posName }
												<span>
													<input type="hidden" class="project-attendee-mem" id="paNo" value="${pro.memNo }">
													<span class="cancelAddMemberBtn${pro.memNo }" style="cursor: pointer; margin-left: 5px; width: 17px; height: 17px;">
														<i class="bi bi-x"></i>
													</span>
												</span>
												</span>
											</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<a href="#" class="position-relative btn btn-light border bg-light"
						data-target="#endDateTap">마감기한</a>
					<div
						class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none"
						id="endDateTap" style="top: 80px; width: 300px; z-index: 2000">
						<div class="d-flex flex-row">
							<div class="position-relative col-sm-12 py-1 text-center">마감기한</div>
							<div class="position-absolute"
								style="cursor: pointer; left: 275px; top: 12px">
								<i class="bi bi-x-lg"></i>
							</div>
						</div>
						<div style="z-index: 9999;">
							<input type="text" id="datepicker" class="w-50 d-none"
								style="outline: none;">
						</div>
					</div>
					<a href="#" class="position-relative btn btn-light border bg-light"
						data-target="#deleteTap">삭제</a>
					<div
						class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none"
						id="deleteTap" style="top: 160px; width: 300px; z-index: 2000">
						<div class="d-flex flex-row">
							<div class="position-relative col-sm-12 py-1 text-center">삭제</div>
							<div class="position-absolute"
								style="cursor: pointer; left: 275px; top: 12px">
								<i class="bi bi-x-lg"></i>
							</div>
						</div>
						<div class="text-center mt-2">
							<h5 style="font-size: 16px">이 업무를 삭제하시겠습니까?</h5>
							<h6 style="font-size: 14px">카드를 삭제하면 복구할 수 없습니다.</h6>
						</div>
						<div
							class="d-flex flex-row justify-content-center align-items-center my-2"
							style="height: 50px;">
							<div>
								<a class="btn btn-info d-flex align-items-center px-2 py-0 me-2"
									id="asdfConfirm"><div
										style="height: 30px; line-height: 30px">삭제</div></a>
							</div>
							<div>
								<a
									class="btn btn-falcon-default d-flex align-items-center px-2 py-0"
									id="asdfCancle" data-bs-dismiss="modal" aria-label="Close"><div
										style="height: 30px; line-height: 30px">취소</div></a>
							</div>
						</div>
					</div>
					<a href="#" class="position-relative btn btn-light border bg-light"
						data-target="#saveTap">저장</a>
					<div
						class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none"
						id="saveTap" style="top: 160px; width: 300px; z-index: 2000">
						<div class="d-flex flex-row">
							<div class="position-relative col-sm-12 py-1 text-center">저장</div>
							<div class="position-absolute"
								style="cursor: pointer; left: 275px; top: 12px">
								<i class="bi bi-x-lg"></i>
							</div>
						</div>
						<div class="text-center mt-2">
							<h5 style="font-size: 16px">이 업무를 저장하시겠습니까?</h5>
						</div>
						<div
							class="d-flex flex-row justify-content-center align-items-center my-2"
							style="height: 50px;">
							<div>
								<a class="btn btn-info d-flex align-items-center px-2 py-0 me-2"
									id="asdfConfirm">
									<div style="height: 30px; line-height: 30px"
										onclick=addNewWork()>저장</div>
								</a>
							</div>
							<div>
								<a
									class="btn btn-falcon-default d-flex align-items-center px-2 py-0"
									id="asdfCancle" data-bs-dismiss="modal" aria-label="Close">
									<div style="height: 30px; line-height: 30px">취소</div>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-body p-0">
				<div
					class="rounded-top-3 bg-body-tertiary d-flex flex-row py-3 ps-4 pe-6">
					<!--           <i class="bi bi-star-fill fs-7"></i> -->
					<h4 class="m-0" style="height: 40px; line-height: 40px"
						id="asdfHead"></h4>
				</div>
				<div class="d-block scrollbar" style="height: 700px;">
					<div class="p-3">
						<table class="table table-bordered">
							<colgroup>
								<col width="120px">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th class="text-center align-middle ps-3 py-2">제목</th>
									<td class="py-2"><input type="text" id="addNewWorkTitle"
										class="form-control form-control-sm"></td>
								</tr>
								<tr>
									<th class="text-center align-middle ps-3 py-2">설명</th>
									<td class="py-2"><textarea class="form-control"
											id="addNewWorkIntro" rows="3" cols="50" wrap="hard"></textarea>
									</td>
								</tr>
								<tr>
									<th class="text-center align-middle ps-3 py-2">담당자</th>
									<td class="py-2 d-flex flex-row" id="addNewWorkPicMem"></td>
								</tr>
								<tr>
									<th class="text-center align-middle ps-3 py-2">마감기한</th>
									<td class="py-2" id="addNewWorkEndDate"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="p-3" id="checkListDiv">
						<div class="d-flex flex-row justify-content-between">
							<div class="d-flex flex-row">
								<i class="bi bi-ui-checks me-2"></i>
								<h5>체크리스트</h5>
							</div>
							<div style="cursor: pointer;" onclick=delNewCheckList()>
								<i class="bi bi-x-lg d-none"></i>
							</div>
						</div>
						<div id="addNewCheckList">
							<div class="d-flex flex-row p-3">
								<input type="checkbox" class="form-check-input me-2"><input
									type="text" id="addNewWorkCheckList"
									class="form-control form-control-sm"><i class='bi bi-x'
									style='cursor: pointer;' id='addedCheckListDelete'></i>
							</div>
							<button id="addNewCheckListBtn" class="border-0 bg-200 ms-3"
								onclick=addNewChekListInput()>
								<span class="fas fa-plus me-2 text-500"></span>항목추가
							</button>
						</div>
					</div>
					<div class="p-3">
						<div class="d-flex flex-row">
							<i class="bi bi-paperclip fs-8 me-2"></i>
							<h5>파일첨부</h5>
						</div>
						<div
							class="d-flex justify-content-center border border-dashed my-2 p-2 scrollbar-overlay"
							id="fileForm"
							style="min-height: 50px; max-height: 200px; border-color: #999">
							<div class="simplebar-wrapper" style="margin: -8px;">
								<div class="simplebar-height-auto-observer-wrapper">
									<div class="simplebar-height-auto-observer"></div>
								</div>
								<div class="simplebar-mask">
									<div class="simplebar-offset" style="right: 0px; bottom: 0px;">
										<div class="simplebar-content-wrapper" tabindex="0"
											role="region" aria-label="scrollable content"
											style="height: auto; overflow: hidden;">
											<div class="simplebar-content" style="padding: 15px;">
												<div
													class="d-flex justify-content-center align-items-center">
													<i class="bi bi-paperclip"></i>
													<div class="d-flex align-items-center p-3">
														여기에 첨부 파일을 끌어 오세요. 또는 <label
															style="cursor: pointer; font-weight: bold; text-decoration: underline; font-size: inherit; margin-bottom: 0; padding-left: 5px">
															<input type="file" style="display: none;" multiple=""
															id="fileInput"> 파일 선택
														</label>
													</div>
												</div>
												<div id="fileList"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="simplebar-placeholder"
									style="width: 1184px; height: 48px;"></div>
							</div>
							<div class="simplebar-track simplebar-horizontal"
								style="visibility: hidden;">
								<div class="simplebar-scrollbar"
									style="width: 0px; display: none;"></div>
							</div>
							<div class="simplebar-track simplebar-vertical"
								style="visibility: hidden;">
								<div class="simplebar-scrollbar"
									style="height: 0px; display: none;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--  업무 생성 끝  -->

<!-- 프로젝트 차트 모달 ========================================================== -->
<div class="modal fade" id="chartModal" data-bs-keyboard="false"
	data-bs-backdrop="static" tabindex="-1" aria-labelledby="chartModal"
	aria-hidden="true">
	<div class="modal-dialog modal-xl mt-6" role="document">
		<div class="modal-content position-relative border-0 d-block">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="chartModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div  class="d-flex flex-row mt-3 m-3">
				<h3 class="d-flex flex-row  m-3"  > 프로젝트명 : ${result.proVO.projectTitle }</h3>
			</div>
			<div class="modal-body p-0">
				<div class="d-flex flex-colum">
					<div class="card-body bg-body-tertiary d-flex flex-row">
						 <canvas id="pie-chart1" width="300" height="300" style="display: block; width: 300px; height: 300px;"></canvas> 
	                </div>
					<div class="card-body bg-body-tertiary d-flex flex-row">
						 <canvas id="pie-chart2" width="300" height="300" style="display: block; width: 300px; height: 300px;"></canvas> 
	                </div> 
				</div>
				<div class="d-flex flex-row" id="chartTable">
				</div>
				<div class="d-flex flex-row d-none">
				 프로젝트 맴버별 정보
					<select id="selectMem">
						<option id="allPa" value="0" selected="selected">전체</option>
						<c:forEach items="${result.proVO.paList }" var="paMem">
							<option id="paMemNo" value="${paMem.memNo }">${paMem.memName } ${paMem.posName }</option>
						</c:forEach>
					</select>
				</div>	
				<div class="d-flex flex-colum d-none" id="memInfo">
					
				</div>
			</div>
		</div>
	</div>
</div>			


<!-- 프로젝트 차트 모달  종료 ========================================================== -->


<!--  잉여 공간 -->
<div id="hey"></div>
<!--  잉여 공간 -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script type="text/javascript">
var txt = '';
let fileInput = $("#fileInput");
var fileList = [];
var dbFileList = [];
let fileTotalSize = 0;




$(document).ready(function(){
	var workNoListVal = [];
	var projectNoVal = $('#projectNo').val();
	var prograssListVal = [];
	var end = 'end';
	var ing = 'ing';
	$('input[id^=endDate]').each(function(){
		
		var endDate = $(this).val()
		var today = new Date();
		var year = today.getFullYear();
		var month = (today.getMonth() + 1).toString().padStart(2, '0');
		var day = today.getDate().toString().padStart(2, '0');
		var todayVal = `\${year}-\${month}-\${day}`;
		
		var workNum = $(this).siblings('input[id^=thisWorkNo]').val();
		var workfield = $(this).siblings('input[id^=field]').val();
		var workProg = $(this).siblings('input[id^=workPrograss]').val();
		
		 if(workfield == 100 ){
			var workTitleSpace =  $(this).closest('p');
			var workTitle =  $(this).closest('p').text().trim();
			var workItem = $('#workItem'+workNum);
			workProg ='end';
			prograssListVal.push(end);
			workNoListVal.push(workNum);
			$('#endWorkDiv').append(workItem);
			
		}
		if(endDate < todayVal && workfield < 100) {
			var workTitleSpace =  $(this).closest('p');
			var workItem = $('#workItem'+workNum);
			workTitleSpace.css('color', 'red');
			workProg = 'end';
			prograssListVal.push(end);
			workNoListVal.push(workNum);
			$('#endWorkDiv').append(workItem);
		} 
		
		
	});
	
	if(workNoListVal != null && workNoListVal.length > 0){
		var workVO = {
				workList : workNoListVal
				,projectNo : projectNoVal
				,prograssList : prograssListVal
		}
		 $.ajax({
			type : "post"
			 , url : "/project/dueEnd"
			 ,data : JSON.stringify(workVO)
			 ,contentType : "application/json; charset=utf-8"
			 , success : function(re){
					var waiteDiv = $('#waitDiv');
   					var ingDiv = $('#ingDiv'); 
   					var endDiv = $('#endDiv');
   					var txt1 = '';
   					var txt2 = '';
   					var txt3 = '';
   					txt1 = `(\${re.countWork.workWite})`;
   					txt2 = `(\${re.countWork.workIng})`;
   					txt3 = `(\${re.countWork.workEnd})`;
   					waiteDiv.html(txt1);
   					ingDiv.html(txt2);
   					endDiv.html(txt3);
			 }
		});  
	}
	
	var paMemNo = $('#selectMem option:selected').val(); 
	var projectNoVal = $('#projectNo').val();
	var paVO = {
		memNo : paMemNo 
		,projectNo : projectNoVal
	}
	
	var memInfo = $('#memInfo');
	
/* 	$.ajax({
		type : "post"
		 , url : "/project/picChart"
		 ,data : JSON.stringify(paVO)
		 ,contentType :  "application/json; charset=utf-8"
		 , success : function(re){
			 if(re.res === "OK"){
				 if(re.val === 'all'){
					 txt = '';
					 txt += `
						 <table class="table table-bordered table-striped fs-10 mb-0">
						 	<thead class="bg-200">
						 		<tr>
						 			<th class="text-900 sort text-center">작업자</th>
						 			<th class="text-900 sort text-center">진행중 업무</th>
						 			<th class="text-900 sort text-center">완료한 업무</th>
						 			<th class="text-900 sort text-center">기한 초과 업무</th>
						 			<th class="text-900 sort text-center">작업한 업무</th>
						 			<th class="text-900 sort text-center">남은 작업</th>
						 		</tr>
						 	</thead>
						 	<tbody>
					 `;
					 if(re.chart != null){
						 for (var i = 0; i < re.chart.length; i++) {
							 txt += `
							 	<tr>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].memName} \${re.chart[i].posName} </td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].memNowWork}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].finishedWork}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].unfinishedWork}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].checkCount}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].ncheckCount}</td>
							 	</tr>
							 
							 `;
						}
					 } else {
						 
					 }
					 txt += `
					 		</tbody>
					 	</table>
					 `;
					 
				 }else{
					 txt = '';
					 txt += `
						 <table class="table table-bordered table-striped fs-10 mb-0">
							 	<thead class="bg-200">
						 		<tr>
						 			<th class="text-900 sort text-center">작업자</th>
						 			<th class="text-900 sort text-center">진행중 업무</th>
						 			<th class="text-900 sort text-center">완료한 업무</th>
						 			<th class="text-900 sort text-center">기한 초과 업무</th>
						 			<th class="text-900 sort text-center">작업한 업무</th>
						 			<th class="text-900 sort text-center">남은 작업</th>
						 		</tr>
						 	</thead>
					 		<tbody>
						 		<tr>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart.memName} \${re.chart.posName} </td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart.memNowWork}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart.finishedWork}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart.unfinishedWork}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart.checkCount}</td>
							 		<td style="text-align: center; vertical-align: middle;">\${re.chart.ncheckCount}</td>
						 		</tr>
					 		</tbody>
					 	</table>
				 	`;
				 	
				 }
				 $('#memInfo').html(txt)
			 }else{
				 console.log("FAILED")
			 }
			 
		 }
	}); */
	
	
	
	
	
	
});
 
	var selectMem = $('#selectMem');
	selectMem.on('change',function(){

		var paMemNo = $('#selectMem option:selected').val(); 
		var projectNoVal = $('#projectNo').val();
		var paVO = {
			memNo : paMemNo 
			,projectNo : projectNoVal
		}
		
		var memInfo = $('#memInfo');
		
		$.ajax({
			type : "post"
			 , url : "/project/picChart"
			 ,data : JSON.stringify(paVO)
			 ,contentType :  "application/json; charset=utf-8"
			 , success : function(re){
				 if(re.res === "OK"){
					 if(re.val === 'all'){
						 txt = '';
						 txt += `
							 <table class="table table-bordered table-striped fs-10 mb-0">
							 	<thead class="bg-200">
							 		<tr>
							 			<th class="text-900 sort text-center">작업자</th>
							 			<th class="text-900 sort text-center">진행중 업무</th>
							 			<th class="text-900 sort text-center">완료한 업무</th>
							 			<th class="text-900 sort text-center">기한 초과 업무</th>
							 			<th class="text-900 sort text-center">작업 완료</th>
							 			<th class="text-900 sort text-center">남은 작업</th>
							 		</tr>
							 	</thead>
							 	<tbody>
						 `;
						 if(re.chart != null){
							 for (var i = 0; i < re.chart.length; i++) {
								 txt += `
								 	<tr>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].memName} \${re.chart[i].posName} </td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].memNowWork}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].finishedWork}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].unfinishedWork}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].checkCount}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart[i].ncheckCount}</td>
								 	</tr>
								 
								 `;
							}
						 } else {
							 
						 }
						 txt += `
						 		</tbody>
						 	</table>
						 `;
						 
					 }else{
						 txt = '';
						 txt += `
							 <table class="table table-bordered table-striped fs-10 mb-0">
								 	<thead class="bg-200">
							 		<tr>
							 			<th class="text-900 sort text-center">작업자</th>
							 			<th class="text-900 sort text-center">진행중 업무</th>
							 			<th class="text-900 sort text-center">완료한 업무</th>
							 			<th class="text-900 sort text-center">마감기한 초과 업무</th>
							 			<th class="text-900 sort text-center">완료한 업무</th>
							 		</tr>
							 	</thead>
						 		<tbody>
							 		<tr>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart.memName} \${re.chart.posName} </td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart.memNowWork}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart.finishedWork}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart.unfinishedWork}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart.checkCount}</td>
								 		<td style="text-align: center; vertical-align: middle;">\${re.chart.ncheckCount}</td>
							 		</tr>
						 		</tbody>
						 	</table>
					 	`;
					 	
					 }
					 $('#memInfo').html(txt)
				 }else{
					 console.log("FAILED")
				 }
				 
			 }
		});
	});
	

var chartType = $('#chartType');
chartType.on('change',function(){
	if(chartType.val() === 'mem'){
		$('#selectDiv').removeClass('d-none');
	} else {
		$('#selectDiv').addClass('d-none');
		
	}
});

	$(document).ready(function(){
		if(sessionStorage.getItem('workId')){
			let workId = sessionStorage.getItem('workId');
			let projectId = sessionStorage.getItem('projectId');
			openModal(sessionStorage.getItem('workId'));
			sessionStorage.removeItem('workId')
			sessionStorage.removeItem('projectId')
			
		} else {
			console.log("sesion 없음")
		}
	});

	function openChart(){
		var projectNoVal = $('#projectNo').val()
		var chartModal = $('#chartModal');
		var chartVO = {
				projectNo : projectNoVal
		}
		var projectTitle = $('#proj').val()
		console.log(projectNoVal);
		$.ajax({
			type : "post"
			 , url : "/project/projectChart"
			 ,data : JSON.stringify(chartVO)
			 ,contentType :  "application/json; charset=utf-8"
			 , success : function(re){
				 console.log(re)
				 
				 createChart1(re)
				 createChart2(re)
				 
				 
				 txt = '';
				 txt += `
					 <div style="display: flex; justify-content: center; align-items: center; margin-bottom: 20px;">
					 <table class="table table-bordered table-striped fs-10 mb-0 mz-2" style="width: 70%; table-layout: fixed; border: 1px solid">
						 	<thead class="bg-200">
						 	<tr>
						 		<th colspan="3" class="text-900 sort text-center">진행도</th>
						 		<th colspan="2" class="text-900 sort text-center">완성도</th>
						 	</tr>
					 		<tr>
					 			<th class="text-900 sort text-center">대기중 업무</th>
					 			<th class="text-900 sort text-center">진행중 업무</th>
					 			<th class="text-900 sort text-center">완료한 업무</th>
					 			
					 			<th class="text-900 sort text-center">마감기한 초과 업무</th>
					 			<th class="text-900 sort text-center">완료한 업무</th>
					 		</tr>
					 	</thead>
				 		<tbody>
					 		<tr>
						 		<td style="text-align: center; vertical-align: middle;">\${re.chart1.chartWorkWite}</td>
						 		<td style="text-align: center; vertical-align: middle;">\${re.chart1.ingWork}</td>
						 		<td style="text-align: center; vertical-align: middle;">\${re.chart1.endWork}</td>
						 		
						 		<td style="text-align: center; vertical-align: middle;">\${re.chart2.unfinishedWork}</td>
						 		<td style="text-align: center; vertical-align: middle;">\${re.chart2.finishedWork}</td>
					 		</tr>
				 		</tbody>
				 	</table>
				 	</div>
			 	`;
				 $('#chartTable').html(txt)
	            chartModal.modal('show');
		        }
			 });
		
		
		};   
		
		// 커스텀 플러그인 등록 (Chart.js 2.5.0)
		/* Chart.plugins.register({
		    afterDraw: function(chart) {
		        let ctx = chart.chart.ctx;
		        chart.data.datasets.forEach(function(dataset, i) {
		            let meta = chart.getDatasetMeta(i);
		            meta.data.forEach(function(element, index) {
		                let dataValue = dataset.data[index];

		                // 퍼센트 계산
		                let total = dataset.data.reduce((a, b) => a + b, 0);
		                let percentage = ((dataValue / total) * 100).toFixed(2) + "%";

		                // 데이터 위치 (차트 도형 중심)
		                let position = element.tooltipPosition();

		                // 스타일 설정
		                ctx.fillStyle = 'black'; // 텍스트 색상
		                ctx.font = 'bold 12px Arial'; // 텍스트 스타일
		                ctx.textAlign = 'center';
		                ctx.textBaseline = 'middle';

		                // 값과 퍼센트 출력
		                ctx.fillText(`${dataValue} (${percentage})`, position.x, position.y);
		            });
		        });
		    }
		}); */

		// createChart1 함수
		function createChart1(re) {
		    const labels = ["대기중 업무", "진행중 업무", "종료한 업무"];
		    const data = [re.chart1.chartWorkWite, re.chart1.ingWork, re.chart1.endWork];

		   
		    new Chart(document.getElementById("pie-chart1"), {
		        type: 'pie',
		        data: {
		            labels: labels,
		            datasets: [{
		                backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f"],
		                data: data
		            }]
		        },
		        options: {
		            responsive: true, // 반응형 차트
		            maintainAspectRatio: false, // 고정 비율 비활성화
		            title: {
		                display: true,
		                text: "진행도"
		            },
		            tooltips: { // 툴팁 설정
		                callbacks: {
		                    label: function(tooltipItem, data) {
		                        let dataset = data.datasets[tooltipItem.datasetIndex];
		                   
		                        let total = dataset.data.reduce((a, b) => a + b, 0);
		                        let currentValue = dataset.data[tooltipItem.index];
		                        let percentage = ((currentValue / total) * 100).toFixed(2);
		             
		                        return `\${data.labels[tooltipItem.index]}: \${currentValue} (\${percentage}%)`;
		                    }
		                }
		            },
		            legend: {
		            	posistion:'top',
		            	fontColor:'black',
		            	align:'center',
		            	display:true,
		            	fullWidth:true,
		            	labels:{
		            		fontColor:'rgb(0,0,0)'
		            	}
		            },
		            plugins: {
		            	labels: {
		            		render:'value',
		            		fontColor:'black',
		            		fontSize:15,
		            		percision:2
		            	}
		            }
		        }
		    });
		}
		// 커스텀 플러그인 등록 (Chart.js 2.5.0)
		Chart.plugins.register({
		    afterDraw: function(chart) {
		        let ctx = chart.chart.ctx;
		        chart.data.datasets.forEach(function(dataset, i) {
		            let meta = chart.getDatasetMeta(i);
		            meta.data.forEach(function(element, index) {
		                let dataValue = dataset.data[index];

		                // 퍼센트 계산
		                let total = dataset.data.reduce((a, b) => a + b, 0);
		                let percentage = ((dataValue / total) * 100).toFixed(2) + "%";

		                // 데이터 위치 (차트 도형 중심)
		                let position = element.tooltipPosition();

		                // 스타일 설정
		                ctx.fillStyle = 'black'; // 텍스트 색상
		                ctx.font = 'bold 12px Arial'; // 텍스트 스타일
		                ctx.textAlign = 'center';
		                ctx.textBaseline = 'middle';

		                // 값과 퍼센트 출력
		                if(dataValue > 0){
			                ctx.fillText(`\${percentage}`, position.x, position.y);
		                	
		                }
		            });
		        });
		    }
		});

		// createChart2 함수
		function createChart2(re) {
		    const labels = ["완료한 업무", "마감기한 초과 업무"];
		    const data = [re.chart2.finishedWork, re.chart2.unfinishedWork];

		    new Chart(document.getElementById("pie-chart2"), {
		        type: 'pie',
		        data: {
		            labels: labels,
		            datasets: [{
		                label: "완성도",
		                backgroundColor: ["#3e95cd", "#8e5ea2"],
		                data: data
		            }]
		        },
		        options: {
		            responsive: true, // 반응형 차트
		            maintainAspectRatio: false, // 고정 비율 비활성화
		            title: {
		                display: true,
		                text: "완성도"
		            },
		            tooltips: { // 툴팁 설정
		                callbacks: {
		                    label: function(tooltipItem, data) {
		                        let dataset = data.datasets[tooltipItem.datasetIndex];
		                        let currentValue = dataset.data[tooltipItem.index];
		                        let total = dataset.data.reduce((a, b) => a + b, 0);
		                        let percentage = ((currentValue / total) * 100).toFixed(2);
		                        return `\${data.labels[tooltipItem.index]}: \${currentValue} (\${percentage}%)`;
		                    }
		                }
		            }
		        }
		    });
		}
		



//============================================================= 즐겨찾기 추가 =======================================
function favorCheck(e){
	var nowLogin = $('#nowLogin').val();
	var workNoVal = $('#thisWorkNo'+e).val();
	var favorStatus = $('#spanFavor'+e);
	var favorTitle = $('#workTi'+e).val();
	var workFavoriteVO = {
			memNo : nowLogin
			,workNo : workNoVal
	}
	var num=e;
	var spanFavor = $('#spanFavor'+e);

	var favorDiv = $('#favorDiv');
	$.ajax({
   	 	type : "post"
			 , url : "/project/favorInsert"
			 ,data : JSON.stringify(workFavoriteVO)
			 ,contentType :  "application/json; charset=utf-8"
			 , success : function(re){
				 console.log(re)
				 if(re.result === "SUCCESS"){
					txt = '';
					txt +=`
						<i class="bi bi-star-fill" style="color:orange;cursor:pointer" onclick=delFavorites(\${workNoVal})></i>
					`;
					spanFavor.html('');
					spanFavor.html(txt);
					txt = '';
					txt += `
						<li class="treeview-list-item">
		                <div class="treeview-item">
		                  <a class="flex-1" href="#!">
		                    <p class="treeview-text">
		                      	\${favorTitle}
		                      	<input type="hidden" id="favorWork\${workNoVal }" value="\${workNoVal }">
		                    </p>
		                  </a>
		                </div>
		              </li>
					`;
					favorDiv.append(txt);
				 }
			 }
    }); 
	
}


//============================================================= 즐겨찾기 추가 종료 =======================================
//============================================================= 즐겨찾기 삭제        =======================================
function delFavorites(e){
	var nowLogin = $('#nowLogin').val();
	var workNoVal = $('#thisWorkNo'+e).val();
	var workFavoriteVO = {
			memNo : nowLogin
			,workNo : workNoVal
	}
	console.log(e)
	console.log("즐찾삭제ㄱㄱㄱ")
	var spanFavor = $('#spanFavor'+e);
	$.ajax({
   	 	type : "post"
			 , url : "/project/delFavor"
			 ,data : JSON.stringify(workFavoriteVO)
			 ,contentType :  "application/json; charset=utf-8"
			 , success : function(re){
				 console.log(re)
				 if(re.result === "SUCCESS"){
					txt = '';
					txt +=`
						
				        	<i class="bi bi-star" onclick=favorCheck(\${workNoVal})></i>
				    			
					`;
					spanFavor.html('');
					spanFavor.html(txt);
					$('#favorWork'+e).closest('.treeview-list-item').remove()
				 }
			 }
    }); 
	
						
}
//============================================================= 즐겨찾기 삭제 종료 =======================================
	
	

	
	
//이동했을 떄 변경 ============================================================


// 페이지가 로드된 후 코드가 실행되도록 함
document.addEventListener("DOMContentLoaded", () => {
	
    // 모든 Kanban 컬럼(각각의 작업 항목이 담기는 영역)을 선택함
    const columns = document.querySelectorAll(".kanban-items-container");

    // 각 컬럼에 대해 드래그 앤 드롭 기능을 설정
    columns.forEach(column => {
        
        // Sortable 라이브러리를 사용해 해당 컬럼을 드래그 앤 드롭 가능하도록 설정
        new Sortable(column, {
            
            group: 'shared', // 이 설정으로 인해 서로 다른 컬럼 간에 항목을 드래그 가능하도록 함
            animation: 150,  // 항목을 드래그할 때 이동 효과 속도 (ms 단위)

            // 드래그 후 항목이 드롭된 후 실행되는 기능 설정
            onEnd: (event) => {
            	// 드래그한 요소 내부의 input을 찾을 때
            	var workNoVal = $(event.item).find('input[id^=thisWorkNo]').val();
            	var workPrograssVal = $(event.to).closest('.kanban-column').find('input[id^=workPrograss]').val(); 
            	var projectNoVal = $('#projectNo').val();
                console.log(workPrograssVal);
                // 이 부분에 서버로 상태를 업데이트하는 AJAX 코드를 추가할 수 있음
                // 예를 들어, 특정 URL로 이동한 데이터를 보낼 수 있음
                var workVO = {
                		workNo : workNoVal
                		, projectNo : projectNoVal
                		, workPrograss : workPrograssVal
                };
                 $.ajax({
               	 	type : "post"
       				 , url : "/project/workPrograss"
       				 ,data : JSON.stringify(workVO)
       				 ,contentType :  "application/json; charset=utf-8"
       				 , success : function(re){
       					 console.log(re)
       					var waiteDiv = $('#waitDiv');
       					var ingDiv = $('#ingDiv'); 
       					var endDiv = $('#endDiv');
       					var txt1 = '';
       					var txt2 = '';
       					var txt3 = '';
       					txt1 = `(\${re.countWork.workWite})`;
       					txt2 = `(\${re.countWork.workIng})`;
       					txt3 = `(\${re.countWork.workEnd})`;
       					waiteDiv.html(txt1);
       					ingDiv.html(txt2);
       					endDiv.html(txt3);
						
       				 
       				 }
                }) 
            }
        });
    });
});

// 이동했을 떄 변경 종료 ============================================================



$(document).on('click','.bi-x-lg',function(){
	  // x 아이콘 클릭 시 탭 닫기
    $(".bi-x-lg").on("click", function (e) {
        e.stopPropagation(); // 부모 요소의 클릭 이벤트 방지
        $(this).closest(".detailTap").addClass("d-none"); // 해당 탭 숨기기
    });
})

// =============================== work 수정 ==============================================
	
	$(document).on('click','input[id^=modCheckYn]',function(){
		if($(this).prop("checked")){
			
			$(this).val('Y');
			
			$(this).siblings('input[id^=modCheckList]').css({
				 "text-decoration": "line-through",
				 "text-decoration-thickness": "2px"
			});
			
		} else {
			$(this).val('N');
			$(this).siblings('input[id^=modCheckList]').css("text-decoration","none");
		}
			
			var workNum = $(this).siblings('input[id^=checkWorkNo]').val();
			var fieldVal = $('#field'+workNum).val()
			var workField = $('#workField'+workNum);
			var clNoVal = $(this).siblings('input[id^=modClNo]').val()
			var checkYnVal = $(this).val();
			var workNoVal = $(this).siblings('input[id^=checkWorkNo]').val();
			
			var workPrograssVal = $('#workPrograss'+workNum).val();								
			var projectNoVal = $('#projectNo').val(); 
			
			
			var checkVO = {
				
				clNo : clNoVal
				, checkYn : checkYnVal
				
			}
			var endDate = $(this).val()
			var today = new Date();
			var year = today.getFullYear();
			var month = (today.getMonth() + 1).toString().padStart(2, '0');
			var day = today.getDate().toString().padStart(2, '0');
			var todayVal = `\${year}-\${month}-\${day}`;
			console.log(checkVO)
			
			
			$.ajax({
				 type : "post"
				 , url : "/project/checkListYN"
				 ,data : JSON.stringify(checkVO)
				 ,contentType :  "application/json; charset=utf-8"
				 , success : function(re){
					if(re.result === "OK"){
						workVO = {
							workNo : workNoVal
						}
						$.ajax({
							 type : "post"
							 , url : "/project/modField"
							 ,data : JSON.stringify(workVO)
							 ,contentType :  "application/json; charset=utf-8"
							 , success : function(re){
								txt = '';
								 txt += `\${re.field}%`;
								 workField.css("width", `\${re.field}%`);
								 workField.html(txt);
								 console.log(re)
								 
								 
							 	
								 
								if(re.field == 100){
									var workItem = $('#workItem'+workNum);
									workPrograssVal='end';
									$('#endWorkDiv').append(workItem);
								}
									
								if(re.field == 0  && endDate > todayVal){
									var workItem = $('#workItem'+workNum);
									workPrograssVal = 'wait';
									$('#waitDiv').append(workItem);
								}
								
								if(re.field > 0 && re.field < 100 && endDate > todayVal){
									var workItem = $('#workItem'+workNum);
									workPrograssVal = 'ing';
									$('#ingWorkDiv').append(workItem);
								}
								
								if(re.field > 0 && re.field < 100 && endDate > todayVal){
									var workItem = $('#workItem'+workNum);
									workPrograssVal='ing';
									$('#ingWorkDiv').append(workItem);
								}
								
							
								
							/* 	
								 if(fieldVal == 0 && endDate > todayVal){
									var workItem = $('#workItem'+workNum);
									var copyWorkItem = workItem.clone();
									workPrograssVal = 'ing';
									$('#ingWorkDiv').append(copyWorkItem);
									workItem.remove();
									
								 } else if(endDate > todayVal && fieldVal > 0 && fieldVal < 100){
									var workItem = $('#workItem'+workNum);
									var copyWorkItem = workItem.clone();
									workPrograssVal = 'ing';
									$('#ingWorkDiv').append(copyWorkItem);
									workItem.remove();
									
								 } else if(re.field == 100){
									var workItem = $('#workItem'+workNum);
									var copyWorkItem = workItem.clone();
									workPrograssVal = 'end';
									$('#endWorkDiv').append(copyWorkItem);
									workItem.remove();
									
								 } else if(fieldVal == 0 && endDate < todayVal){
									var workItem = $('#workItem'+workNum);
									var copyWorkItem = workItem.clone();
									workPrograssVal = 'end';
									$('#endWorkDiv').append(copyWorkItem);
									workItem.remove();
								 } else if(endDate < todayVal && fieldVal > 0 && fieldVal < 100){
									var workItem = $('#workItem'+workNum);
									workPrograssVal = 'end';
								 } else {
									 console.log("뀨뀨")
								 }
								  */
								 
								 
								var workVO = {
									workNo : workNum
									,workPrograss : workPrograssVal
									,projectNo : projectNoVal
								}
								
								$.ajax({
									 type : "post"
									 , url : "/project/updatePrograss"
									 ,data : JSON.stringify(workVO)
									 ,contentType :  "application/json; charset=utf-8"
									 , success : function(re){
										 console.log(re)
										 console.log("뀨뀨333333")
										var waiteDiv = $('#waitDiv');
				       					var ingDiv = $('#ingDiv'); 
				       					var endDiv = $('#endDiv');
				       					var txt1 = '';
				       					var txt2 = '';
				       					var txt3 = '';
				       					txt1 = `(\${re.countWork.workWite})`;
				       					txt2 = `(\${re.countWork.workIng})`;
				       					txt3 = `(\${re.countWork.workEnd})`;
				       					waiteDiv.html(txt1);
				       					ingDiv.html(txt2);
				       					endDiv.html(txt3);
									 }
								}); 
								   
							 }
						});
						
						
					}
					 
				 }
				
			});
	});
	
	
	$(document).on('click', '[id^=addedCheckListDelete]', function(){
			if($(this).siblings('input[id^=modCheckYn]').val() === 'Y'){
				$(this).closest('div').remove();
			} else {
				$(this).closest('div').remove();
			}
	});
	
	function changeStatusMode(e) {
		
		$(document).on('click','button[id=modNewheckList'+e+']',function(){
		
			console.log("cc")
		var modNewheckList = $(this);
			
		var checkListDiv = $(this).closest('div');
			txt = ``;
			txt += `
				<div class="d-flex flex-row mb-2">
					<input type="checkbox" class="form-check-input me-2">
					<input type="text" id="modAddNewWorkCheckList\${e}" class="form-control form-control-sm">
					<i class='bi bi-x' style='cursor: pointer;' id='addedCheckListDelete'></i>
				</div>
			`;  
			modNewheckList.before(txt);
		});
	
		
		
			
		var viewFile = $('#viewFile'+e);
		viewFile.addClass('d-none');
		
		
		
		
		function modNewChekListInput(e){
			var txt = ''
			var exCheckList = $('input[id^=checkList]').val()
			var num = e;
			if(exCheckList != null && exCheckList.trim() != ''){
				txt = '';
				txt += `
					<div class="d-flex flex-row p-3" >
						<input type="checkbox" class="form-check-input me-2" id="modCheckYn\${num}" value="N">
						<input type="text" id="modNewWorkCheckList\${num}" class="form-control form-control-sm">
						<input type="hidden" id="workNo\${num}" value="\${num}">
						<i class='bi bi-x' style='cursor: pointer;' id='addedCheckListDelete\${num}'></i>
					</div>
				`;
				
				$('#checkListDiv'+e).append(txt);
				
			}
		}		
				
		var num = e;
		$('#modFileForm'+e).removeClass('d-none')
	
		// 수정 취소를 위한 기존값 저장
		
		
		var existingWorkDate = $("#modWorkEndDate"+e).val()
		var existingWorkTitle = $('#workTitle'+e).val();
		var existingWorkIntro = $('#modWorkIntro'+e).val();
		var existingCheckList = [];
		var existingPicMemList = []; // 이거 html로 바꿀 생각해 list가 아니라
		$('#checkList'+e).each(function(){
			existingCheckList.push($(this).val());
		});
		
		$('i[id^=addedCheckListDelete'+num+']').each(function(){
			$(this).css("display","");
		});
		
		
	    var modDatepicker = $('#modDatepicker' + e);
	    var modDate = $('#modDate' + e);
	    var modEndDateTap = $("#modEndDateTap" + e);
	    
		// 체크리스트 추가 버튼
		$('#modNewheckList'+e).css('display','');
		$('input[id^=modCheckList'+e+']').prop("disabled",false);
		
		
		// 업무 설정 
		$('#workIntroH'+e).addClass('d-none');
		$('#modWorkIntro'+e).toggleClass('d-none');
		
		// 업무 타이틀
		$('#modHead'+e).addClass("d-none");
		$('#workTitle'+e).removeClass("d-none");
		
		// 우측 이벤트 맴버
	    $('#modMem' + e).toggleClass('d-none');
	    $('#modBtn' + e).addClass('d-none');
	    
	    // 수정 commit
	    $('#saveMod' + e).toggleClass('d-none');
	    
	    // 마감일 수정
	    $('#modDate' + e).toggleClass('d-none');
	    
	    // 체크리스트
	    $('#modCheck' + e).toggleClass('d-none');
	    
	    // 삭제버튼
	    $('#delBtn'+e).toggleClass('d-none');
	    
	    $('input[id^=modAddNewWorkCheckList]').each(function(){
	    	$(this).closest('div').remove();
	    });
	    
	    var cancelAddMemberBtn = $(".cancelAddMemberBtn"+e);
		cancelAddMemberBtn.removeClass("d-none");

	    $("#work-modal-" + e).on("click", "a", function (s) {
	        s.preventDefault();
	        var target = $(this).data("target");

	        $(".detailTap").addClass("d-none");
	        $(target).removeClass("d-none");

	        if ($(target).attr("id") === modEndDateTap.attr("id")) {
	            f_datepicker(modDatepicker);
	        }
	    });

	    function f_datepicker(obj) {
	        $(obj).removeClass("d-none");
	        $(obj).datepicker({
	            dateFormat: 'yy-mm-dd',
	            onClose: function() {
	                $(this).datepicker("show");
	            },
	            onSelect: function(dateText) {
	                $('#modEndDateTap'+e).addClass("d-none");
	                $("#endDateSpan"+e).html(dateText);
	            }
	        }).datepicker("show");

	        $("#ui-datepicker-div").css({
	            "z-index": "9999",
	            "top": "175px",
	            "left": "1365px",
	            "width": "300px",
	            "padding": "0",
	            "border-radius": "0"
	        });
	    }
	    
	    
	    // 수정 맵버 추가
		$('.member-modAddress').on('dblclick', function() {
			var memNo = $(this).siblings('input[id^=picMember]').val();  
			var memName = $(this).find('.member-no').text();  
			var modWorkPicMem = $('#modWorkPicMem'+num);
			console.log(memNo)
			var duplication = modWorkPicMem.find('input[value='+memNo+']');
			if (duplication.length > 0) {
				duplication.closest('div[id=memDiv]').remove();
			} else {
				let txt = ` 
						<div class="border rounded-5 bg-info-subtle ms-1 px-1" id="memDiv">
	                	<span style="font-size: 13px;color: black;">
							\${memName}
							<input type="hidden" id="modPicMem\${memNo}" value="\${memNo}">
							<span class="cancelAddMemberBtn\${memNo}" style="cursor: pointer; margin-left: 5px; width:17px; height:17px;">
								<i class="bi bi-x"></i> 
							</span>
						</span>
						</div>	
				
				`;
				modWorkPicMem.append(txt);
			}
		});
		
		$(document).on('dblclick', '#addedPicMember_'+e, function() {
		    $(this).remove();
		});

		// 특정 멤버 삭제 (x 버튼 클릭 시)
		$(document).on('click', '.cancelAddMemberBtn'+e , function(s) {
		    s.stopPropagation();  // 이벤트 버블링 방지
		    $(this).closest('div[id^=memDiv]').remove();
		});
		
		// 기존 파일 삭제
		$('#delfile'+e).toggleClass('d-none');
		var delfile = $('#delfile'+e) 
		delfile.on('click',function(){
			$(this).closest('div[id^=filesClass'+e+']').remove();
		});
			
			
		 $("#modFileForm"+e).on("dragenter", function(s){
		        s.preventDefault();
		        s.stopPropagation();
		    }).on("dragover", function(s){
		        s.preventDefault();
		        s.stopPropagation();
		        $(this).css("border-color", "#25BCFD");
		    }).on("dragleave", function(e){
		        s.preventDefault();
		        s.stopPropagation();
		        $(this).css("border-color", "#999");
		    }).on("drop", function(e){
		        s.preventDefault();

		        let files = s.originalEvent.dataTransfer.files;
		        DBFileListPreview(files);
		    });
			
		 function getModFileIcon(fileName) {
			    const extension = fileName.split('.').pop().toLowerCase();
			    return fileIcons[extension] || '${pageContext.request.contextPath}/resources/icon/icon-default.png'; // 기본 아이콘 경로
			}
		 function getFileIcon(fileName) {
			    const extension = fileName.split('.').pop().toLowerCase();
			    return fileIcons[extension] || '${pageContext.request.contextPath}/resources/icon/icon-default.png'; // 기본 아이콘 경로
			}
			function formatFileSize(size) {

			    let fileSize; 

			    if (size / 1024 / 1024 / 1024 > 1) {
			        fileSize = (size / 1024 / 1024 / 1024).toFixed(1) + "GB";
			    } else if (size / 1024 / 1024 > 1) {
			        fileSize = (size / 1024 / 1024).toFixed(1) + "MB";
			    } else if (size / 1024 > 1) {
			        fileSize = (size / 1024).toFixed(1) + "KB";
			    } else {
			        fileSize = size.toFixed(1) + "Byte";
			    }
			    
			    return fileSize;
			}
	
 		
 			let modFileInput = $('#modFileInput'+e);
			modFileInput.on("change", function (event) {
			
				fileList = [];
				let files = event.target.files;
				fileListPreview(files,"update",e);
				 
				
			});
			
	
			//저장버튼
			var modConfirm = $('#modConfirm'+e);
			modConfirm.on('click',function(){
				
			
			var num = e;
			console.log(num)
			
			var isValid = true;
			
			var mngPicNoVal = $('#mngPicNo').val();
			proVO = {
					mngPicNo : mngPicNoVal
			}
			
			
			var workTitleVal = $('#workTitle'+num).val();
			 if (workTitleVal === null || workTitleVal.trim() === '' && $('#workTitleError' + num).length === 0) {
			        $('#workTitle' + num).after('<span id="workTitleError' + num + '" style="color:red;">제목을 입력해 주세요.</span>');
			        isValid = false;
			    }
			var workNoVal = $('#workNo'+num).val();
			var workIntroVal = $('#modWorkIntro'+num).val();
			var endDateVal = $('#endDateSpan'+e).text();
			var workVO = {
					workNo : workNoVal
					,workTitle : workTitleVal
					, workIntro : workIntroVal
					, endDate : endDateVal
					, fileNoList : fileNoListVal
			}
			
			// 기존 체크리스트
			var modCheckYnListVal =[];
			var modCheckListVal = [];
			var modCheckNoListVal = [];
			var modCheckDateListVal = [];
			var modCheckMemListVal = [];
			var modAddNewWorkCheckListVal = [];
			var fileNoListVal = [];
			
			$('input[id^=fileNoList'+num+']').each(function(){
				fileNoListVal.push($(this).val())
			});
			
			$('input[id^=modCheckList'+num+']').each(function(){
				modCheckListVal.push($(this).val());
			});
			$('input[id^=modCheckYn'+num+']').each(function(){
				modCheckYnListVal.push($(this).val());
			});
			$('input[id^=modClNo'+num+']').each(function(){
				modCheckNoListVal.push($(this).val());
			});
			$('input[id^=modCheckDate'+num+']').each(function(){
				modCheckDateListVal.push($(this).val());
			});
			$('input[id^=modCheckName'+num+']').each(function(){
				modCheckMemListVal.push($(this).val());
			});
			$('input[id^=modAddNewWorkCheckList]').each(function(){
				modAddNewWorkCheckListVal.push($(this).val());
			});						
			 
			var checkVO = {
					modClNameList : modCheckListVal
					, modCheckNoList : modCheckNoListVal
					, modCheckDateList : modCheckDateListVal
					, modCheckMemList : modCheckMemListVal
					, modCheckYnList : modCheckYnListVal
					, modNewList : modAddNewWorkCheckListVal
					
			};
			
			// 맴버 수정
			var workPicMemListVal = [];
			$('input[id^=modPicMem]').each(function(){
				 if ($(this).val() !== "0" && $(this).val().trim() !== "") {
						workPicMemListVal.push($(this).val());
				 }
					 
			});
			
			// 중복 제거
			workPicMemListVal = [...new Set(workPicMemListVal)];
			
			var picVO = {
					memNoList : workPicMemListVal
			}
			
			//파일
			// fileListUpdate
			
			var formData = new FormData();
			
			if (fileList.length > 0) {
				for (let i = 0; i < fileList.length; i++) {
					formData.append("files", fileList[i]);
				}		
				
			}
			
			formData.append("workVO",new Blob([JSON.stringify(workVO)], {type:"application/json; charset=utf-8"}) )
			formData.append("checkVO",new Blob([JSON.stringify(checkVO)], {type:"application/json; charset=utf-8"}) )
			formData.append("picVO",new Blob([JSON.stringify(picVO)], {type:"application/json; charset=utf-8"}) )
			formData.append("proVO",new Blob([JSON.stringify(proVO)], {type:"application/json; charset=utf-8"}) )
			
			for (let pair of formData.entries()) {
			    console.log(`${pair[0]}:`, pair[1]);
			}
	
	 		console.log(workVO);
	 		console.log(checkVO);
	 		console.log(workVO);
	 		console.log(picVO);
			console.log(formData);
			 $.ajax({
				 type : "post"
				 , url : "/project/modifyWork"
				 , data : formData
				 , processData : false
				 , contentType : false
				 , success : function(re){
						 console.log(re)
					 if(re.res == 'SUCCESS'){
						location.reload(true);
					 } else {
						console.log(re.msg)
					 }
			 	}
			});   
				
		});
		
	}
	
	
// =============================== work 수정 완료==============================================

$(function(){
	
	
    $("#asdf").on("click", "a", function (e) {
        e.preventDefault(); // 기본 링크 동작 방지
        var target = $(this).data("target"); // data-target 속성 값 가져오기
        
        // 모든 탭 숨기기
        $(".detailTap").addClass("d-none");
        
        // 클릭한 a 태그의 target에 해당하는 요소 보이기
        $(target).removeClass("d-none");
        
        if (target == '#endDateTap') {
        	f_datepicker('#datepicker');
		}
    });

    // x 아이콘 클릭 시 탭 닫기
    $(".bi-x-lg").on("click", function (e) {
        e.stopPropagation(); // 부모 요소의 클릭 이벤트 방지
        $(this).closest(".detailTap").addClass("d-none"); // 해당 탭 숨기기
    });
	
	$("#DetailDateInput").on("click", function () {
		console.log("AA");
	    this.showPicker(); // 입력 필드에 포커스가 가면 날짜 선택기를 표시
	})
    $('#asdf').on('show.bs.modal', function () {     
        var modal = $(this);
        modal.appendTo('body');
   });
	
	fileInput.on("change", function (event) {
		fileList = [];
		let files = event.target.files;
		fileListPreview(files);
	});


    $("#checkListDiv").mouseenter(function () {
        $(this).find(".bi-x-lg").removeClass("d-none");
    }).mouseleave(function () {
        $(this).find(".bi-x-lg").addClass("d-none");
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
});

function f_datepicker(obj) {
	$("#datepicker").removeClass("d-none");
    $(obj).datepicker({
    	// 데이터 포맷 변경
    	dateFormat:'yy-mm-dd',
        onClose: function() {
            $(this).datepicker("show"); // 날짜 선택 후 자동으로 다시 표시
        },
        // 선택 시 값 옮겨주기
    	onSelect: function(dateText) {
        console.log("dd");
        $("#endDateTap").addClass("d-none");
        $("#addNewWorkEndDate").html(dateText);
        console.log($("#addNewWorkEndDate").html());
    }
    }).datepicker("show");
    $("#ui-datepicker-div").css("z-index", "9999");
    $("#ui-datepicker-div").css("top", "175px");
    $("#ui-datepicker-div").css("left", "1373px");
    $("#ui-datepicker-div").css("width", "300px");
    $("#ui-datepicker-div").css("padding", "0");
    $("#ui-datepicker-div").css("border-radius", "0");
}

function fileListPreview(files,mode,num) {
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
                            "<i class='bi bi-x' style='cursor: pointer;' id='addedFileDelete'></i>" +
                            "<img src='" + fileIcon + "' alt='icon' style='width:20px;height:20px;' />" +
                        "</span>" +
                        "<span class='fileName' style='margin-right:8px;'>" + fileName + "</span>" +
                        "<span><a class='btn py-0 px-1' style='margin-right:8px;border:1px solid #999'>다운로드</a></span>" +	
                    "</div>" +
                    "<div>" +
                        "<span style='margin-right:8px'>일반첨부</span>" +
                        "<span class='fileSize'>" + fileSize + "</span>" +
                    "</div>" +
                "</div>";

        }
        if(mode==="update") {
        //	$("#fileListUpdate"+num).html('');
 	        $("#fileListUpdate"+num).append(tag);
 	        $("#fileTotalSize").text(formatFileSize(fileTotalSize));
        } else {  
	        $("#fileList").html('');
	        $("#fileList").append(tag);
	        $("#fileTotalSize").text(formatFileSize(fileTotalSize));
        }
    }
}
function getFileIcon(fileName) {
    const extension = fileName.split('.').pop().toLowerCase();
    return fileIcons[extension] || '${pageContext.request.contextPath}/resources/icon/icon-default.png'; // 기본 아이콘 경로
}
function formatFileSize(size) {

    let fileSize; 

    if (size / 1024 / 1024 / 1024 > 1) {
        fileSize = (size / 1024 / 1024 / 1024).toFixed(1) + "GB";
    } else if (size / 1024 / 1024 > 1) {
        fileSize = (size / 1024 / 1024).toFixed(1) + "MB";
    } else if (size / 1024 > 1) {
        fileSize = (size / 1024).toFixed(1) + "KB";
    } else {
        fileSize = size.toFixed(1) + "Byte";
    }
    
    return fileSize;
}

// 파일 x버튼 클릭 시 삭제
$(document).on('click', '#addedFileDelete', function () {
	$(this).closest('.fileList').remove()
});

// =================================== 최강민강 종료 =================================
	
// ======================== 신규 생성 모달창 x버튼, 취소버튼 클릭 시 ==========================	

	var asdfCloseBtn = $('#asdfCloseBtn');
	var asdfCancle = $('#asdfCancle');
	var addNewWorkTitle = $('#addNewWorkTitle');
	var addNewWorkIntro = $('#addNewWorkIntro');
	var addNewWorkCheckList = $('#addNewWorkCheckList');
	var addNewComent = $('#addNewComent');
	var addNewWorkEndDate = $('#addNewWorkEndDate');
	
	asdfCloseBtn.on('click',function(){
		
		addNewWorkTitle.val('');
		addNewWorkIntro.val('');
		addNewWorkCheckList.val('');
		$('#datepicker').val('')
		$("#endDateTap").addClass("d-none");
		addNewWorkEndDate.html('');
		$('#fileList').html('');
	});
	
	asdfCancle.on('click', function (){
		
		addNewWorkTitle.val('');
		addNewWorkIntro.val('');
		addNewWorkCheckList.val('');
		$('#datepicker').val('')
		$("#endDateTap").addClass("d-none");
		addNewWorkEndDate.html('');
		$('#fileList').html('');
		
	});
	
// ======================== 신규 생성 모달창 x버튼, 취소버튼 클릭 시 종료========================	
	
// ======================== 업무 생성 ===============================================
	
	// 체크박스 클릭 후 체크리스트 상단x버튼
	function delNewCheckList(){
		var addNewWorkCheckList = $('#addNewWorkCheckList');
		var addNewCheckList = $('#addNewCheckList');
		var addNewWorkCheckListLength = addNewCheckList.closest("#addNewWorkCheckList").length
		if(addNewWorkCheckListLength > 1) {
			addNewWorkCheckList.closest(".d-flex flex-row p-3").remove()
		} 
		
	}
	
	function addNewWork(){
		var addNewWorkTitleVal = $('#addNewWorkTitle').val();
		var addNewWorkIntroVal = $('#addNewWorkIntro').val();
		var addNewWorkEndDateVal = $('#addNewWorkEndDate').html();
		var projectNoVal = $('#projectNo').val();
		var formData = new FormData();
		
		if (fileList.length > 0) {
			for (let i = 0; i < fileList.length; i++) {
				formData.append("files", fileList[i]);
			}		
		}
		
		var workVO = {
				projectNo : projectNoVal,
				workTitle : addNewWorkTitleVal,
				workIntro : addNewWorkIntroVal,
				endDate : addNewWorkEndDateVal
		}
		
		var checkListVal = [];
		$('input[id^=addNewWorkCheckList]').each(function(){
			checkListVal.push($(this).val());
		});
		var chekVO = {
				clNameLsit : checkListVal
		}
		
		var picMemVal = [];
		$('input[id^=workPicMem]').each(function(){
			picMemVal.push($(this).val());
		});
		var picVO = {
				memNoList : picMemVal
		}
		console.log(formData.file)
		formData.append("workVO",new Blob([JSON.stringify(workVO)], {type:"application/json; charset=utf-8"}) )
		formData.append("chekVO",new Blob([JSON.stringify(chekVO)], {type:"application/json; charset=utf-8"}) )
		formData.append("picVO",new Blob([JSON.stringify(picVO)], {type:"application/json; charset=utf-8"}) )
		console.log(workVO)
		console.log(chekVO)
		console.log(picVO)
		
		$.ajax({
			 type : "post"
			 , url : "/project/insertWork"
			 , data : formData
			 , processData : false
			 , contentType : false
			 , success : function(res){
				 if(res == 'SUCCESS'){
					console.log("됐 다...>")
					$("#asdf").modal("hide");
					location.reload(true);
				 } else {
					console.log("됐겠냐...")
				 }
		 	}
		});
	}

		// === 업무 추가 [인원 추가]  ======
	$('.member-address').on('dblclick', function() {
		var memNo = $(this).find('.project-attendee-mem').val();  
		var memName = $(this).find('span[id^=addedPicMember_]').text();
		var addNewWorkPicMem = $('#addNewWorkPicMem');
		var duplication = addNewWorkPicMem.find(`input[value='\${memNo}']`);
		if (duplication.length > 0) {
			duplication.closest('.addedPicMember').remove();
		} else {
			let txt = `
				<span class="addedPicMember " id="addedPicMember_\${memNo}">
					<div class="border rounded-5 bg-info-subtle ms-1 px-1">
            			<span style="font-size: 13px;color: black;">
							\${memName} 
							<input type="hidden" id="workPicMem" value="\${memNo}">
							<span class="cancelAddMemberBtn" style="cursor: pointer; margin-left: 5px; width:17px; height:17px;">
								<i class="bi bi-x" ></i>
							</span>
						</span>
					</div>
				</span>
			`;
			addNewWorkPicMem.append(txt);
		}
	});

	$(document).on('dblclick', '.addedPicMember', function() {
		$(this).remove();
	});

	$(document).on('click', '.cancelAddMemberBtn', function(e) {
		e.stopPropagation();
		$(this).closest('.addedPicMember').remove();
	});
		// === 업무 추가 [인원 추가] 끝 ======
	
// ======================== 업무 생성 종료 ============================================	
	
	
// =================================== 체크리스트 생성 ================================
	
	// 우측 체크리스트 클릭 시 
	function addNewCheckList(){
	}
	
				$(document).on('keyup','#addNewWorkCheckList',function(e){
					if (e.keyCode === 13) {
						if($(this).val() != null && $(this).val().trim() != ''){
							txt = '';
							txt += `
							<div class="d-flex flex-row p-3" >
								<input type="checkbox" class="form-check-input me-2"><input
									type="text" id="addNewWorkCheckList"
									class="form-control form-control-sm">
							</div>
							`;
							$('#addNewCheckListBtn').before(txt);
							$(this).next().find('input[id^=addNewWorkCheckList]').focus();
							
						}
					}
				});

				
	function addNewChekListInput(){
		console.log("dasd")
		var txt = ''
		var addCheckList = $('input[id^=addNewWorkCheckList]').val()
		if(addCheckList != null && addCheckList.trim() != ''){
			txt = '';
			txt += `
				<div class="d-flex flex-row p-3" >
					<input type="checkbox" class="form-check-input me-2">
					<input type="text" id="addNewWorkCheckList" class="form-control form-control-sm">
					<i class='bi bi-x' style='cursor: pointer;' id='addedCheckListDelete'></i>
				</div>
			`;
			
			$('#addNewCheckListBtn').before(txt);
		}
	}
	
	$(document).on('click', '#addedCheckListDelete', function(){
		if($('input[id^=addNewWorkCheckList]').length > 1){
			console.log("dd")
			$(this).closest('div').remove();
		}
	});
// =================================== 체크리스트 생성 종료 =============================


		
// 댓글 달기 =========================================================================
	
	function addNewComnt(e){
		console.log("asdasd");
		var cmntContent = $('#cmntContent'+e);
		
		var workNoVal = $('#thisWorkNo'+e).val();
		var cmntContentVal = cmntContent.val();
		var cmntVO = {
				workNo : workNoVal,
				cmntContent : cmntContentVal 
		}
		var writerName = $('#loginMemName'+e).val()
		var writerPos = $('#loginMemPos'+e).val()
		var cmntContentDel = $('#cmntContent'+e);
		var nullComent = $('#nullComent'+e);
		$.ajax({
			 type : "post"
			 , url : "/project/newComent"
			 ,data : JSON.stringify(cmntVO)
			 ,contentType :  "application/json; charset=utf-8"
			 , success : function(res){
				 if(res.sr == 'OK'){
					console.log(res);
					txt = '';
					txt += `
						<div class="d-flex flex-row align-items-start">
							<img style="width: 40px; height: 40px; margin-right: 10px"
								alt=""
								src="${pageContext.request.contextPath }/resources/icon/default_profile.png">
							<div class="d-flex flex-column">
								<div>
									\${writerName } \${writerPos }<br> \${res.wcVO.cmntContent}
								</div>
							</div>
						</div>
					`;
					$('#inComntAjax'+e).append(txt);
					cmntContentDel.val('');
					nullComent.remove();
				 } else {
					 console.log("111111")
					 console.log(res)
					console.log("됐겠냐...")
				 }
		 	}
		});
	}
	
// 댓글 달기 종료  =========================================================================
	
// work 삭제================================================================================
	
	
	 
	 
	function workdel(e){
		var workNoVal = $('#thisWorkNo'+e).val();
		var fileNoVal = $('#workFile'+e).val();
		
		var workVO = {
				workNo : workNoVal
				,fileNo : fileNoVal
		}
		
		$.ajax({
			type : "post"
				 , url : "/project/delWork"
				 ,data : JSON.stringify(workVO)
				 ,contentType :  "application/json; charset=utf-8"
				 , success : function(res){
					 console.log(res)
					 location.reload(true);
				 }
		});
	
	}
	
// work 삭제 종료================================================================================
function openModal(e) {
	var workNoVal = $('#thisWorkNo'+e).val();
	var projectNoVal = $('#projectNo').val();
	var workVO = {
			workNo : workNoVal,
			projectNo : projectNoVal
	}
	
	$.ajax({
		 type : "post"
		 , url : "/project/modalOpen"
		 ,data : JSON.stringify(workVO)
		 ,contentType :  "application/json; charset=utf-8"
		 , success : function(res){
			 if(res.status === "OK"){
				 console.log(res)
				 txt=``;
				  txt += `
					 <div class="modal fade" id="work-modal-\${res.work.workNo }" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="asdfHead" aria-hidden="true">
					     <div class="modal-dialog modal-lg mt-6" role="document">
					         <div class="modal-content position-relative border-0 d-block">
					             <div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
					                 <button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="detailCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button>
					                 <div class="position-absolute d-flex flex-column d-gap gap-1"  style="width: 150px; left: 50px; top: -15px">
					                     <a href="#" class="position-relative btn btn-light border bg-light d-none" data-target="#modManagerTab\${res.work.workNo }" id="modMem\${res.work.workNo }">담당자</a>
					                     <div class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none" id="modManagerTab\${res.work.workNo }" style="top: 40px; width: 300px; z-index: 2000">
					                         <div class="d-flex flex-row py-1">
					                             <div class="position-relative col-sm-12 py-1 text-center">담당자</div>
						                             <div class="position-absolute" style="cursor: pointer; left: 275px; top: 12px">
						                                 <i class="bi bi-x-lg"></i>
						                             </div>
                    
					                         </div>
					                         <div class="py-2">
					                             <input type="text" class="form-control form-control-sm" placeholder="멤버 검색">
					                         </div>
					                         <!-- 멤버 리스트 표시 -->
					                        	 <div class="d-block scrollbar" style="height: 125px;">
										`;
										
										if (res.paMemList.length > 0 && res.paMemList) {
										     for (var i = 0; i < res.paMemList.length; i++) {
										         txt += `
	     				                        	<span id="span${res.work.workNo}" style="font-size: 13px;color: black;">
						                                 <div class="flex-1 member-modAddress" id="memberAddress_\${res.paMemList[i].memNo}">
						                                     <span class="member-no">\${res.paMemList[i].memName} \${res.paMemList[i].posName}</span>
						                                </div>  
				                                         <input type="hidden" id="picMember\${res.work.workNo}" class="modProject-attendee-mem" value="\${res.paMemList[i].memNo}">
				                                     </span>
						                             `;
										     }
										 } else {
										     txt += `
					                                 해당 프로젝트에 인원이 없습니다.
										   			 `;
										 }
										
										txt += `
												</div>
						 					</div>
						 					<a href="#" class="position-relative btn btn-light border bg-light d-none" data-target="#modEndDateTap\${res.work.workNo }" id="modDate\${res.work.workNo }">마감기한</a>
						 					<div class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none" id="modEndDateTap\${res.work.workNo }" style="top: 80px; width: 300px; z-index: 2000">
						 						<div class="d-flex flex-row">
						 							<div class="position-relative col-sm-12 py-1 text-center">마감기한</div>
						 							<div class="position-absolute" style="cursor: pointer; left: 275px; top: 12px">
						 								<i class="bi bi-x-lg"></i>
						 							</div>
						 						</div>
						 						<div style="z-index: 9999;">
						 							<input type="text" id="modDatepicker\${res.work.workNo }" class="w-50 d-none" style="outline: none;">
						 						</div>
						 					</div>
						 						<a href="#" class="position-relative btn btn-light border bg-light d-none" data-target="#detailDeleteTap\${res.work.workNo }" id="delBtn\${res.work.workNo }" >삭제</a>
						 						<div class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none" id="detailDeleteTap\${res.work.workNo }" style="top: 160px; width: 300px; z-index: 2000">
						 							<div class="d-flex flex-row">
						 								<div class="position-relative col-sm-12 py-1 text-center">삭제</div>
						 								<div class="position-absolute" style="cursor: pointer; left: 275px; top: 12px">
						 									<i class="bi bi-x-lg"></i>
						 								</div>
						 							</div>
						 							<div class="text-center mt-2">
						 								<h5 style="font-size: 16px">이 업무를 삭제하시겠습니까?</h5>
						 								<h6 style="font-size: 14px">업무를 삭제하면 복구할 수 없습니다.</h6>
						 							</div>
						 							<div class="d-flex flex-row justify-content-center align-items-center my-2" style="height: 50px;">
						 								<div> <a class="btn btn-info d-flex align-items-center px-2 py-0 me-2" id="Confirm"><div style="height: 30px; line-height: 30px" onclick=workdel(\${res.work.workNo })>삭제</div></a> </div>
						 								<div> <a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="modCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px; line-height: 30px">취소</div></a> </div>
						 							</div>
						 						</div>
						 						<a href="#" class="position-relative btn btn-light border bg-light"  id="modBtn\${res.work.workNo }" onclick=changeStatusMode(\${res.work.workNo })>수정</a> 
						 						<a href="#" class="position-relative btn btn-light border bg-light d-none" id="saveMod\${res.work.workNo }" data-target="#modSaveTap\${res.work.workNo }">저장</a>
						 						<div class="detailTap position-absolute d-flex flex-column bg-light rounded-2 p-2 d-none" id="modSaveTap\${res.work.workNo }" style="top: 160px; width: 300px; z-index: 2000">
						 							<div class="d-flex flex-row">
						 								<div class="position-relative col-sm-12 py-1 text-center">저장</div>
						 								<div class="position-absolute"style="cursor: pointer; left: 275px; top: 12px"> <i class="bi bi-x-lg"></i> </div>
						 							</div>
						 							<div class="text-center mt-2">
						 								<h5 style="font-size: 16px">수정한 업무를 저장하시겠습니까?</h5>
						 							</div>
						 							<div class="d-flex flex-row justify-content-center align-items-center my-2" style="height: 50px;">
						 								<div>
						 									<a class="btn btn-info d-flex align-items-center px-2 py-0 me-2" id="modConfirm\${res.work.workNo }">
						 									<div style="height: 30px; line-height: 30px" >저장</div></a>
						 								</div>
						 								<div> <a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="modCancle" data-bs-dismiss="modal" aria-label="Close"> <div style="height: 30px; line-height: 30px">취소</div></a> </div>
						 							</div>
						 						</div>
					 						</div>
				 						</div>
					             <div class="modal-body p-0">
					                 <div class="rounded-top-3 bg-body-tertiary d-flex flex-row py-3 ps-4 pe-6">
					                     <span class="d-flex align-items-center me-2" style="cursor: pointer;">
	                                 	 <input type="hidden" id="nowLogin" value="\${res.loginMem[0].memNo}">
					              `;
									
										if(res.favorWork && res.favorWork.length > 0){
            								for (var i = 0; i < res.favorWork.length; i++) {
												if(res.favorWork[i].workNo === res.work.workNo && favorWork[i].memNo === loginMem[0].memNo ){
													txt += `
														<i class="bi bi-star-fill" style="color: orange; cursor: pointer;" id="favoritY\${res.work.workNo }"></i>
													`;
												}else{
												     txt += `<i class="bi bi-star fs-7" id="favoriteN\${res.work.workNo }"></i>`;
												}
											} 
            							}
									 
					                txt += ` 
									     </span>
					                     <h4 class="m-0" style="height: 40px; line-height: 40px" id="modHead\${res.work.workNo}">\${res.work.workTitle}</h4>
					                     <input type="text" class="form-control form-control-sm d-none" id="workTitle\${res.work.workNo}" value="\${res.work.workTitle}">
					                     <input type="hidden" id="workNo\${res.work.workNo}" value="\${res.work.workNo}">
					                 </div>

					                 <div class="d-block scrollbar" style="height: 700px">
					                     <div class="p-3">
					                         <table class="table table-bordered">
					                             <colgroup>
					                                 <col width="120px">
					                                 <col>
					                             </colgroup>
					                             <tbody>
					                                 <tr>
					                                     <th class="text-center align-middle ps-3 py-2">설명</th>
					                                     <td class="py-2">
					                                         <h id="workIntroH\${res.work.workNo}">\${res.work.workIntro}</h>
					                                         <textarea class="form-control d-none" id="modWorkIntro\${res.work.workNo}" rows="3" cols="50" wrap="hard">\${res.work.workIntro}</textarea>
					                                     </td>
					                                 </tr>

					                                 <tr>
					                                     <th class="text-center align-middle ps-3 py-2">담당자</th>
					                                     <td class="d-flex flex-row py-2" id="modWorkPicMem\${res.work.workNo}">
					                                         `;
														
					                                         if (res.memList && res.memList.length > 0) {
															     for (var i = 0; i < res.memList.length; i++) {
															         txt += `
						                                             <div class="border rounded-5 bg-info-subtle ms-1 px-1" id="memDiv">
						     				                        	<span style="font-size: 13px;color: black;">
							                                                 \${res.memList[i].memName} 
							                                                 \${res.memList[i].posName}
							                                                 <span class="cancelAddMemberBtn\${res.work.workNo} d-none" style="cursor: pointer; margin-left: 5px; width:17px; height:17px;">
							                                                     <i class="bi bi-x"></i>
							                                                 </span>
						     				                      		  </span>
						                                                 <input type="hidden" id="modPicMem\${res.work.workNo}" value="\${res.memList[i].memNo}">
						     				                   		 </div>
												        		  `;
																     }
																 } else {
																     txt += `
								                                             인원이 없습니다.
								                                         `;
																 }
					                                         
												 txt += `
					                                     </td>
					                                 </tr>
					                                 <tr>
					                                     <th class="text-center align-middle ps-3 py-2">마감기한</th>
					                                     <td class="py-2" id="modWorkEndDate">
					                                         <div class="d-flex">
					                                             <span id="endDateSpan\${res.work.workNo}">\${res.work.endDate}</span>
					                                             <input type="hidden" id="modWorkEndDate\${res.work.workNo}" value="\${res.work.endDate}">
					                                         </div>
					                                     </td>
					                                 </tr>
					                             </tbody>
					                         </table>
					                     </div>
					                     <div class="p-3" id="modCheckListDiv">
				 							<div class="d-flex flex-row justify-content-between">
				 								<div class="d-flex flex-row">
				 									<i class="bi bi-ui-checks me-2"></i>
				 									<h5>체크리스트</h5>
				 								</div>
				 							</div>
				 							<div id="checkListDiv\${res.work.workNo } " class="d-flex flex-column">
				 						`;
				 						
				 							if(res.checkList != null && res.checkList.length > 0){
				 								for (var i = 0; i < res.checkList.length; i++) {
				 									if(res.checkList[i].checkYn === 'Y'){
				 										
				 									txt +=`
				 										<div class="d-flex flex-row mb-2">
								 								<input type="hidden" id="checkWorkNo\${res.work.workNo}" value="\${res.work.workNo}">
				 												<input type="checkbox" class="form-check-input me-2 " id="modCheckYn\${res.work.workNo }" value="\${res.checkList[i].checkYn}" checked="checked">
					 											<input type="text" id="modCheckList\${res.work.workNo }" style="text-decoration: line-through; text-decoration-thickness: 2px;" class="form-control form-control-sm " value="\${res.checkList[i].clName }" disabled="disabled">
				 												<input type="hidden" id="modClNo\${res.work.workNo }" value="\${res.checkList[i].clNo }">
				 												<input type="hidden" id="modCheckDate\${res.work.workNo }" value="\${res.checkList[i].checkDate }">
				 												<input type="hidden" id="modCheckName\${res.work.workNo }" value="\${res.checkList[i].memNo }">
				 												<i class='bi bi-x' style='display:none; cursor: pointer;' id='addedCheckListDelete\${res.work.workNo }'></i>
				 											</div>
				 									`;
				 									} else {
				 										txt +=`
				 											<div class="d-flex flex-row mb-2">
								 								<input type="hidden" id="checkWorkNo\${res.work.workNo}" value="\${res.work.workNo}">
				 												<input type="checkbox" class="form-check-input me-2 " id="modCheckYn\${res.work.workNo }" value="\${res.checkList[i].checkYn}" >
				 												<input type="text" id="modCheckList\${res.work.workNo }" style="text-decoration: none; text-decoration-thickness: 2px;" class="form-control form-control-sm" value="\${res.checkList[i].clName }" disabled="disabled">
				 												<input type="hidden" id="modClNo\${res.work.workNo }" value="\${res.checkList[i].clNo }">
				 												<input type="hidden" id="modCheckDate\${res.work.workNo }" value="\${res.checkList[i].checkDate }">
				 												<input type="hidden" id="modCheckName\${res.work.workNo }" value="\${res.checkList[i].memNo }">
				 												<i class='bi bi-x' style='display:none; cursor: pointer;' id='addedCheckListDelete\${res.work.workNo }'></i>
				 											</div>
				 										`;
				 									}
				 									
				 								}
				 							} else{
				 								txt += `
				 											<div class="d-flex flex-row mb-2">
				 												<input type="text" id="nullCheckList\${res.work.workNo }" class="form-control form-control-sm" value="체크리스트가 없습니다." disabled="disabled">
				 												<i class='bi bi-x' style='display:none; cursor: pointer;' id='addedCheckListDelete\${res.work.workNo }'></i>
				 											</div>
				 								`;
				 							}
				 						
				 						txt +=`
				 							</div>
				 								<button class="border-0 bg-200 ms-3" style="display: none;" id="modNewheckList\${res.work.workNo }"  >
				 									<span class="fas fa-plus me-2 text-500"></span>항목추가
				 								</button>
				 							
				 								
				 						</div>
				 						<div class="p-3">
				 							<div class="d-flex flex-row">
				 								<i class="bi bi-paperclip fs-8 me-2"></i>
				 								<h5>파일첨부</h5>
				 							</div>
										`;
				 						if(res.work.fileNo != 0){ 
			 								for (var i = 0; i < res.work.fileDetailList.length; i++) {
			 									txt += `
			 									<div class='fileList d-flex flex-row justify-content-between w-100' id="viewFile\${res.work.workNo }" data-size= f.fileSize data-detail-no= f.fileDetailNo >
			 										    <div class='d-flex flex-row'>
			 										    <input  type="hidden" id="fileNoList\${res.work.workNo }" value="\${res.work.fileDetailList[i].fileDetailNo}">
			 										        <span class='icon-container' style='display:flex;align-items:center;margin-right:8px;'>
			 										            <i class='bi bi-x d-none' id="delfile\${res.work.workNo }" style='cursor: pointer;'></i>
			 										            <img src= <c:url value='/resources/icon/icon-default.png' /> alt='icon' style='width:20px;height:20px;' />
			 										        </span>
			 										        <span class='fileDe\${res.work.workNo }' style='margin-right:8px;'>\${res.work.fileDetailList[i].fileOriginalname}</span>
			 										        <span><a class='btn py-0 px-1' style='margin-right:8px;border:1px solid #999'>다운로드</a></span>  
			 										    </div>
			 										</div>
			 									`;
			 									
												    const size = res.work.fileDetailList[i].fileSize;
												
												    if (size / 1024 / 1024 / 1024 > 1) {
												        const fileSize = (size / 1024 / 1024 / 1024).toFixed(1) + " GB";
												        txt += `${fileSize}`;
												    } else if (size / 1024 / 1024 > 1) {
												        const fileSize = (size / 1024 / 1024).toFixed(1) + " MB";
												        txt += `${fileSize}`;
												    } else if (size / 1024 > 1) {
												        const fileSize = (size / 1024).toFixed(1) + " KB";
												        txt += `${fileSize}`;
												    } else {
												        const fileSize = size.toFixed(1) + " Byte";
												        txt += `${fileSize}`;
												    }
																		 									
					 								}
					 							} 
				 						
	 										txt += `
	 											<div class="d-flex justify-content-center border border-dashed my-2 p-2 scrollbar-overlay d-none" id="modFileForm\${res.work.workNo }" style="height:150px; border-color: #999" data-simplebar="init">
					 								<div class="simplebar-wrapper" style="margin: -8px;">
					 									<div class="simplebar-height-auto-observer-wrapper">
					 										<div class="simplebar-height-auto-observer"></div>
						 									</div>
						 									<div class="simplebar-mask">
						 										<div class="simplebar-offset" style="right: 0px; bottom: 0px;">
						 											<div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: auto; overflow: auto;">
						 												<div class="simplebar-content">
						 													<div class="d-flex justify-content-center align-items-center">
						 														<i class="bi bi-paperclip"></i>
						 														<div class="d-flex align-items-center p-3">
						 															여기에 첨부 파일을 끌어 오세요. 또는 <label
						 																style="cursor: pointer; font-weight: bold; text-decoration: underline; font-size: inherit; margin-bottom: 0; padding-left: 5px">
						 																<input type="file" style="display: none;" multiple=""
						 																id="modFileInput\${res.work.workNo }"> 파일 선택
						 															</label>
						 														</div>
						 													</div>
		 																<div id="fileListUpdate\${res.work.workNo }">
						 											`;
												 						if(res.work.fileNo != 0){ 
											 								for (var i = 0; i < res.work.fileDetailList.length; i++) {
											 									txt += `
											 									<div class='fileList d-flex flex-row justify-content-between w-100' id="filesClass\${res.work.workNo }" data-size= f.fileSize data-detail-no= f.fileDetailNo >
											 										    <div class='d-flex flex-row'>
											 										    <input  type="hidden" id="fileNoList\${res.work.workNo }" value="\${res.work.fileDetailList[i].fileDetailNo}">
											 										        <span class='icon-container' style='display:flex;align-items:center;margin-right:8px;'>
											 										            <i class='bi bi-x d-none' id="delfile\${res.work.workNo }" style='cursor: pointer;'></i>
											 										            <img src= <c:url value='/resources/icon/icon-default.png' /> alt='icon' style='width:20px;height:20px;' />
											 										        </span>
											 										        <span class='fileDe\${res.work.workNo }' style='margin-right:8px;'>\${res.work.fileDetailList[i].fileOriginalname}</span>
											 										        <span><a class='btn py-0 px-1' style='margin-right:8px;border:1px solid #999'>다운로드</a></span>  
											 										    </div>
											 									</div>
											 									`;
											 									
																				    const size = res.work.fileDetailList[i].fileSize;
																				
																				    if (size / 1024 / 1024 / 1024 > 1) {
																				        const fileSize = (size / 1024 / 1024 / 1024).toFixed(1) + " GB";
																				        txt += `${fileSize}`;
																				    } else if (size / 1024 / 1024 > 1) {
																				        const fileSize = (size / 1024 / 1024).toFixed(1) + " MB";
																				        txt += `${fileSize}`;
																				    } else if (size / 1024 > 1) {
																				        const fileSize = (size / 1024).toFixed(1) + " KB";
																				        txt += `${fileSize}`;
																				    } else {
																				        const fileSize = size.toFixed(1) + " Byte";
																				        txt += `${fileSize}`;
																				    }
																										 									
													 								}
													 							} else {
													 								txt += `
													 								<div d-flex>
													 									파일이 없습니다.
													 								</div>	
													 								`;								
													 							}
		 											txt += `	
				 												</div>
				 											</div>
				 										</div>
		 											</div>
			 									</div>
			 								</div>
			 							</div>
				 						<div class="d-block" style="height: 300px;">
				 							<h5>댓글</h5>
				 							<div class="d-flex flex-column" id="inComntAjax\${res.work.workNo }">
				 								<div class="d-flex flex-row align-items-center mb-2">
				 									<img style="width: 40px; height: 40px; margin-right: 10px"
				 										alt=""
				 										src="${pageContext.request.contextPath }/resources/icon/default_profile.png">
				 									<div class="d-flex flex-row" id="loginMem">
				 										<input type="hidden" id="loginMemNo\${res.work.workNo }" value="\${res.loginMem[0].memNo}">
				 										<input type="hidden" id="loginMemName\${res.work.workNo }" value="\${res.loginMem[0].memName}">
				 										<input type="hidden" id="loginMemPos\${res.work.workNo }" value="\${res.loginMem[0].posName}">
				 									</div>
				 									<textarea class="form-control" rows="2" cols="50" id="cmntContent\${res.work.workNo }"></textarea>
				 								</div>
				 								<div class="d-flex">
				 									<a class="btn btn-info d-flex align-items-center px-2 py-0 ms-auto"
				 										id="addNewComnt">
				 										<div style="height: 30px; line-height: 30px" onclick=addNewComnt(\${res.work.workNo })>등록</div></a>
				 								</div>
				 								
				 								`;
				 								
				 								if(res.cmtList != null && res.cmtList.length > 0){
				 									for (var i = 0; i < res.cmtList.length; i++) {
				 									txt += `
				 										<div class="d-flex flex-row align-items-start" style="margin-top: 10px;">
				 										<input type="hidden" id="cmntNo\${res.work.workNo }" value="\${res.cmtList[i].cmntNo}">
				 											<img style="width: 40px; height: 40px; margin-right: 10px"
				 												alt=""
				 												src="${pageContext.request.contextPath }/resources/icon/default_profile.png">
				 											<div class="d-flex flex-column">
				 												<div>
				 													\${res.cmtList[i].memName} \${res.cmtList[i].posName}<br>\${res.cmtList[i].cmntContent}
				 												</div>
				 												<span class="text-500">\${res.cmtList[i].regDate}</span>
				 											</div>
				 										</div>
				 									`;
				 									} 
				 								}else {
				 										txt += `
				 										<div class="d-flex flex-row align-items-start" id="nullComent\${res.work.workNo }">
				 											<div class="d-flex flex-column">
				 												<div>
				 													작성자 <br> 댓글이 없습니다.
				 												</div>
				 												<span class="text-500"></span>
				 											</div>
				 										</div>
				 										
				 										`;
				 									}
				 								txt +=`
				 									
						 							</div>
					 							</div>
				 							</div>
				 						</div>
				 					</div>
				 				</div>
				 			</div> 
					 `;
				 		$('#hey').html(txt);
				 		$('#work-modal-'+res.work.workNo).modal('show');
				 
			 } else {
				 console.log(res);
				 console.log("모달실패");
			 }
		 }
			 
	});

	
	
}
	
	


	
</script>

<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->

