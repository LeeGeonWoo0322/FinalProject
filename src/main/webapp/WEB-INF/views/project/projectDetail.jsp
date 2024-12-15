<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  
<tiles:insertAttribute name = "siderbar">  </tiles:insertAttribute>
<style>
    
.sortable-ghost {
    opacity: 0.4;
    border: 2px dashed #007bff; /* 드래그 중일 때의 스타일 */
}
</style>
<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->

<!-- <style>
#modalClose {
	margin-left: auto;
}
.workDiv {s
	border: solid;
	margin-right: 15px;
	margin-left: 20px; 
	width: 400px;
	height: 100%;
	display: flex;
	flex-direction: column;
	overflow-y: scroll;
	overflow-x: hidden;
}

.projectTitle{
	border: solid;
	margin-bottom: 10px; 
	margin-right: 10px; 
	margin-left: 10px; 
	margin-top: 10px; 
	height : 60px;
	width: 100%;
	display : flex;
	justify-content: center;
    align-items: center;
}
.workUser{
	border: solid;
	margin-bottom: 10px; 
	margin-right: 10px; 
	margin-left: 10px; 
	margin-top: 10px; 
	height : 60px;
	width: 100%;
	display : flex;
	
}
.allWorkDiv{
	border: solid;
	margin-bottom: 10px; 
	margin-right: 10px; 
	margin-left: 10px; 
	margin-top: 10px; 
	height : 800px;
	width: 100%;
	display : flex;
	align-content: flex-start;
}

.workPlus{
	border: solid;
	margin-bottom: 10px; 
	margin-right: 10px; 
	margin-left: 10px; 
	margin-top: 10px; 
	height : 80px;
	width: 95%;
	display : flex;
}
.work{
	border: solid;
	margin-bottom: 10px; 
	margin-right: 10px; 
	margin-left: 10px; 
	margin-top: 10px; 
	height : 240px;
	width: 95%;
	display : flex;
}
/* .modal-newWok {
	display: none;
	background-color: white;
	height: 950px;
	width: 750px;
	position: fixed;
	top: 6%;
	left: 24%;
	z-index: 1020;
	overflow-y: scroll; 
} */
#fontColor {
	color: black;
}

.fileUploadDiv {
	border-style: dotted; 
    margin-right: 50px;
    margin-left: 50px;
    margin-top: 30px;
	border-color: gray;
	height: 100px;
}
.newWorkInput{
	background-color:transparent;
	color : black;
	border: solid;
}
.modal-head {
	position: fixed;
}
.newProjectTitle {
	position: fixed;
}
.memberModal  {
	display: none;
	background-color: white;
	height: 200px;
	width: 200px;
	position: fixed;
	top: 20%;
	left: 60%;
	color: black;
}
#newCheckList {
	display: none;
	color: black;
}
.delMem {
	display: none;	
}
</style> -->


<!-- ================================메인 화면 ============================================================================================-->
<div class="content">
    <div class="col d-flex align-items-center">
        프로젝트명: ${result.proVO[0].projectTitle} <button onclick=delProject(${result.proVO[0].projectNo })> 삭제 삭제</button>
        <input type="hidden" id="delProjectNo" name="projectNo" value="${result.proVO[0].projectNo }">
        <input type="hidden" id="delProjectMem" name="projectMem" value="${result.proVO[0].mngPicNo }">
       
       <c:if test="${!empty result.proVO[0].fileNoList }"></c:if> 
       <c:forEach items="${result.proVO[0].fileNoList }" var="file">
       	<input type="hidden" id="delFile${file.fileNo }" name="delFile${file.fileNo }" value="${file.fileNo }">
       </c:forEach>

       <c:if test="${!empty result.proVO[0].paMemList  }">
	       <c:forEach items="${result.proVO[0].paMemList }" var="mem">
	       		<input type="hidden" id="delPaMem${mem.memNo }" name="delFile${mem.memNo }" value="${mem.memNo }">
	       </c:forEach>
       </c:if>
    </div>

    <div class="row gx-0 kanban-header rounded-2 px-x1 py-2 mt-2 mb-3">
        <!-- 3분할로 나눔 -->
        <div class="kanban-container scrollbar me-n3">
            <!-- 분류함 -->
            <div class="kanban-column" id="waitWork">
                <div class="kanban-column-header">
                     	대기함 <span class="text-500" id="countwait">
                        <h5 id="countNum"></h5>
                    </span>
                </div>
                <div class="kanban-items-container scrollbar" data-sortable="data-sortable" id="plusNew">
                    <!-- 한칸 -->
                    <c:choose>
                        <c:when test="${empty result.proVO[0].workNoList }">
                            <div id="nullWork">
				                                업무가 없습니다.<br/>
				                                생성해 주세요.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${result.proVO[0].workNoList }" var="work">
                            	<c:if test="${work.workPrograss eq 'wait' }">
                                <div class="kanban-item sortable-item-wrapper" draggable="true" id="workItem${work.workNo }">
                                    <div class="card sortable-item kanban-item-card hover-actions-trigger">
                                        <div class="card-body">
                                        	<!-- 숨긴버튼 -->
                                        	<div class="position-relative">
                                        	<div class="dropdown font-sans-serif">
												<button class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions" type="button" data-boundary="viewport" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<svg class="svg-inline--fa fa-ellipsis-h fa-w-16" data-fa-transform="shrink-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-h" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.5em;">
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
                                            <p class="mb-0 fw-medium font-sans-serif stretched-link" data-bs-toggle="modal" data-bs-target="#work-modal-${work.workNo}">  
                                                <input type="hidden" id="thisWorkNo${work.workNo}" name="workNo" value="${work.workNo}">
                                                <input type="hidden" id="WorkProjectNo${work.workNo}" name="projectNo" value="${work.projectNo}">
                     					         <input type="hidden" id="workPrograss${work.workNo}" name="workPrograss" value="${work.workPrograss}"> 
                     					         	<c:forEach items="${result.proVO[0].memNoList }" var="mem">
											       	<input type="hidden" id="delpicMem${mem.memNo }" name="delpicMem${mem.memNo }" value="${mem.memNo }">
											       </c:forEach>
                                                ${work.workTitle}
                                            </p>
                                            <div class="kanban-item-footer cursor-default">
                                                <span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Attachments">
                                                    <svg class="svg-inline--fa fa-paperclip fa-w-14 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paperclip" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                                                        <path fill="currentColor" d="M43.246 466.142c-58.43-60.289-57.341-157.511 1.386-217.581L254.392 34c44.316-45.332 116.351-45.336 160.671 0 43.89 44.894 43.943 117.329 0 162.276L232.214 383.128c-29.855 30.537-78.633 30.111-107.982-.998-28.275-29.97-27.368-77.473 1.452-106.953l143.743-146.835c6.182-6.314 16.312-6.422 22.626-.241l22.861 22.379c6.315 6.182 6.422 16.312.241 22.626L171.427 319.927c-4.932 5.045-5.236 13.428-.648 18.292 4.372 4.634 11.245 4.711 15.688.165l182.849-186.851c19.613-20.062 19.613-52.725-.011-72.798-19.189-19.627-49.957-19.637-69.154 0L90.39 293.295c-34.763 35.56-35.299 93.12-1.191 128.313 34.01 35.093 88.985 35.137 123.058.286l172.06-175.999c6.177-6.319 16.307-6.433 22.626-.256l22.877 22.364c6.319 6.177 6.434 16.307.256 22.626l-172.06 175.998c-59.576 60.938-155.943 60.216-214.77-.485z"></path>
                                                    </svg><span>1</span></span>
                                                <span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Checklist">
                                                    <svg class="svg-inline--fa fa-check fa-w-16 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
                                                        <path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"></path>
                                                    </svg>
                                                    <span></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            	</c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- 분류함 대기함은 plus포함 -->
                <div class="kanban-column-footer">
                    <div class="fs-9 mb-0">
                        <div class="kanban-item sortable-item-wrapper" draggable="false">
                            <div class="card sortable-item kanban-item-card hover-actions-trigger">
                                <div class="card-body">
                                    <p class="mb-0 fw-medium font-sans-serif stretched-link" data-bs-toggle="modal" data-bs-target="#newWorkModal">
                                        <button class="btn btn-link btn-sm d-block w-100 btn-add-card text-decoration-none text-600" type="button">
                                            <svg class="svg-inline--fa fa-plus fa-w-14 me-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                                                <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
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
                <div class="kanban-column-header">진행함 
                	<span class="text-500" id="counting"></span>
                </div>
                <div class="kanban-items-container scrollbar" data-sortable="data-sortable" id="plusNew">
                	                    <!-- 한칸 -->
                    <c:choose>
                        <c:when test="${empty result.proVO[0].workNoList }">
                            <div id="nullWorkIng">
				                             진행중인 업무가 없습니다.<br/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${result.proVO[0].workNoList }" var="work">
                            	<c:if test="${work.workPrograss eq 'ing' }">
                                <div class="kanban-item sortable-item-wrapper" draggable="true" id="workItem${work.workNo }">
                                    <div class="card sortable-item kanban-item-card hover-actions-trigger">
                                        <div class="card-body">
                                        <!-- 숨긴버튼 -->
                                        	<div class="position-relative">
                                        	<div class="dropdown font-sans-serif">
												<button class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions" type="button" data-boundary="viewport" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<svg class="svg-inline--fa fa-ellipsis-h fa-w-16" data-fa-transform="shrink-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-h" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.5em;">
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
                                            <p class="mb-0 fw-medium font-sans-serif stretched-link" data-bs-toggle="modal" data-bs-target="#work-modal-${work.workNo}">
                                                <input type="hidden" id="thisWorkNo${work.workNo}" name="workNo" value="${work.workNo}">
                                                <input type="hidden" id="WorkProjectNo${work.workNo}" name="projectNo" value="${work.projectNo}">
                                                <input type="hidden" id="workPrograss${work.workNo}" name="workPrograss" value="${work.workPrograss}">
                                                ${work.workTitle}
                                            </p>
                                            <div class="kanban-item-footer cursor-default">
                                                <span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Attachments">
                                                    <svg class="svg-inline--fa fa-paperclip fa-w-14 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paperclip" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                                                        <path fill="currentColor" d="M43.246 466.142c-58.43-60.289-57.341-157.511 1.386-217.581L254.392 34c44.316-45.332 116.351-45.336 160.671 0 43.89 44.894 43.943 117.329 0 162.276L232.214 383.128c-29.855 30.537-78.633 30.111-107.982-.998-28.275-29.97-27.368-77.473 1.452-106.953l143.743-146.835c6.182-6.314 16.312-6.422 22.626-.241l22.861 22.379c6.315 6.182 6.422 16.312.241 22.626L171.427 319.927c-4.932 5.045-5.236 13.428-.648 18.292 4.372 4.634 11.245 4.711 15.688.165l182.849-186.851c19.613-20.062 19.613-52.725-.011-72.798-19.189-19.627-49.957-19.637-69.154 0L90.39 293.295c-34.763 35.56-35.299 93.12-1.191 128.313 34.01 35.093 88.985 35.137 123.058.286l172.06-175.999c6.177-6.319 16.307-6.433 22.626-.256l22.877 22.364c6.319 6.177 6.434 16.307.256 22.626l-172.06 175.998c-59.576 60.938-155.943 60.216-214.77-.485z"></path>
                                                    </svg><span>1</span></span>
                                                <span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Checklist">
                                                    <svg class="svg-inline--fa fa-check fa-w-16 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
                                                        <path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"></path>
                                                    </svg>
                                                    <span></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            	</c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <!-- 한칸 끝 -->
                </div>
            </div>
            <!-- 진행함 끝 -->

            <!-- 완료함 -->
            <div class="kanban-column" id="endWork">
                <div class="kanban-column-header">완료함 <span class="text-500" id="countend"></span></div>
                <div class="kanban-items-container scrollbar" data-sortable="data-sortable" id="plusNew">
                                	                    <!-- 한칸 -->
                    <c:choose>
                        <c:when test="${empty result.proVO[0].workNoList }">
                            <div id="nullWorkEnd">
				               	완료된 업무가 없습니다.<br/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${result.proVO[0].workNoList }" var="work">
                            	<c:if test="${work.workPrograss eq 'end' }">
                                <div class="kanban-item sortable-item-wrapper" draggable="true" id="workItem${work.workNo }">
                                    <div class="card sortable-item kanban-item-card hover-actions-trigger">
                                        <div class="card-body">
                                        <!-- 숨긴버튼 -->
                                        	<div class="position-relative">
                                        	<div class="dropdown font-sans-serif">
												<button class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions" type="button" data-boundary="viewport" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<svg class="svg-inline--fa fa-ellipsis-h fa-w-16" data-fa-transform="shrink-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-h" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.5em;">
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
                                            <p class="mb-0 fw-medium font-sans-serif stretched-link" data-bs-toggle="modal" data-bs-target="#work-modal-${work.workNo}">
                                                <input type="hidden" id="thisWorkNo${work.workNo}" name="workNo" value="${work.workNo}">
                                                <input type="hidden" id="WorkProjectNo${work.workNo}" name="projectNo" value="${work.projectNo}">
                                                <input type="hidden" id="workPrograss${work.workNo}" name="workPrograss" value="${work.workPrograss}">

                                                ${work.workTitle}
                                            </p>
                                            <div class="kanban-item-footer cursor-default">
                                                <span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Attachments">
                                                    <svg class="svg-inline--fa fa-paperclip fa-w-14 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paperclip" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                                                        <path fill="currentColor" d="M43.246 466.142c-58.43-60.289-57.341-157.511 1.386-217.581L254.392 34c44.316-45.332 116.351-45.336 160.671 0 43.89 44.894 43.943 117.329 0 162.276L232.214 383.128c-29.855 30.537-78.633 30.111-107.982-.998-28.275-29.97-27.368-77.473 1.452-106.953l143.743-146.835c6.182-6.314 16.312-6.422 22.626-.241l22.861 22.379c6.315 6.182 6.422 16.312.241 22.626L171.427 319.927c-4.932 5.045-5.236 13.428-.648 18.292 4.372 4.634 11.245 4.711 15.688.165l182.849-186.851c19.613-20.062 19.613-52.725-.011-72.798-19.189-19.627-49.957-19.637-69.154 0L90.39 293.295c-34.763 35.56-35.299 93.12-1.191 128.313 34.01 35.093 88.985 35.137 123.058.286l172.06-175.999c6.177-6.319 16.307-6.433 22.626-.256l22.877 22.364c6.319 6.177 6.434 16.307.256 22.626l-172.06 175.998c-59.576 60.938-155.943 60.216-214.77-.485z"></path>
                                                    </svg><span>1</span></span>
                                                <span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Checklist">
                                                    <svg class="svg-inline--fa fa-check fa-w-16 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
                                                        <path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"></path>
                                                    </svg>
                                                    <span></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            	</c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <!-- 한칸 끝 -->
                </div>
            </div>
            <!-- 완료함 끝 -->
        </div>
    </div>

<!-- ================================ 신규 Work 입력 모달 ============================================================================================-->
<!-- <div class="modal-newWok"> -->
<div class="modal fade" id="newWorkModal" tabindex="-1" aria-labelledby="kanban-modal-label-2" aria-hidden="true" data-bs-backdrop="static" >
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content border-0">
		<!-- X버튼 -->
		<div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" onclick=cancelBtn()></button></div>
			<div class="modal-body p-0" id="projectTitleDiv">
				<!-- 제목 입력칸  <헤더느낌> -->
				<div class="bg-body-tertiary rounded-top-lg py-3 ps-4 pe-6">
					<h3 class="mb-1"> 
					<input type="hidden" id="projectNo" name="projectNo" value="${result.proVO[0].projectNo }">
							제목 입력 : 
						<input class="workTitle" type="text" name="workTitle" id= "newWorkTitle"> ✎
					</h3>
				</div> 
				<!-- 제목 입력칸 끝 -->
				<!-- 바디 느낌 -->		
				<div class="p-4">
					<div class="row">
						<div class="col-lg-9">
						<!-- 입력마다 구역지역 -->
							<div class="d-flex">
								<div class="mb-3 fs-9">
									<h3 > 업무 정보 입력 : </h3>	
								<div class="position-relative border rounded-1 mb-3">
									<textarea class="newWorkInput" id="newWorkIntro" name="workIntro" rows="5" cols="55"></textarea>  
								</div>
								</div>
							</div>
						<!-- 입력마다 구역지역  끝-->
						<!-- 입력마다 구역지역 -->
							<div class="d-flex">
								중요 여부 :	<input type="checkbox" name="importYn" id="importYn" value="N"> <br/>
								<span id="fontColor">마감일 : &nbsp;</span>
								<input type="date" class="newWorkInput" id="endDate" naem="endDate"> 
							</div>
						<!-- 입력마다 구역지역  끝-->
						<!-- 입력마다 구역지역-->
						<!-- 입력마다 구역지역  끝-->
							<div class="d-flex">
								<h3> 
									<span id="fontColor">😄 업무 담당자 지정</span>
								</h3>
									<button class="showMemList" onclick=showMemList()>+</button>
							</div>
							<div class="d-flex">
								<div id="hiddenMemList" style="display: none;">
									<div class="row">
									<c:choose>
										<c:when test="${empty result.proVO[0].paMemList }">
											인원이 없음
										</c:when>
										<c:otherwise>
											<c:forEach items="${result.proVO[0].paMemList }" var="mem" >
												<div id="memberNo"><span>김${mem.memNo}</span> <input type="hidden" id="memNo" name="memNo" value="${mem.memNo }">
												<button  style="display: none;">X</button></div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
										<button onclick=memListHidden()>닫기버튼</button>
									</div>
								</div>
									<div class="workMem" id="workMem">
									</div>
							</div>
							
								 <div>
									<h3 style=>
										<span id="fontColor"> ▥ 체크 리스트 </span> <button id="addCheckListBtn">+</button>
									</h3>
										 
									
									<div class="checkList scrollbar" id="checkListDiv" >
									</div>  
								 </div>
								 <div>
									 <h3> 
										<span id="fontColor"> ▥  파일 첨부 </span>
										<form method="post" enctype="multipart/form-data">
											<input type="file"  class="custom-file-input" id="newAttachedFiles" name="newAttachedFiles" multiple class="form-control">
										</form>
										<div class="fileUploadDiv" id="fileUploadDiv">
											파일을 올려주세요.
										</div>
									 </h3> 
								</div>
								<div>
									 <button data-bs-dismiss="modal" aria-label="Close" id="insertBtn" onclick=insert()>등록</button> <button data-bs-dismiss="modal" aria-label="Close" onclick=cancelBtn()>취소</button>
								</div>
							</div>
						</div>
					</div>		
				</div>
			</div>
		</div>
	</div>
<div style="display:none;">
	<div class="echart-pie-chart-example" style="min-height: 320px;" data-echart-responsive="true"></div>
	<div class="progress mb-3" style="height:15px" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
  		<div class="progress-bar" style="width: 50%">50%</div>
	</div>
</div> 
<!-- ================================ 신규 Work 입력 모달 끝============================================================================================-->


<!--  잉여 공간 -->
<div id="hey"></div>
<!--  잉여 공간 -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">

function delProject(e){
	console.log("삭제삭제")
	console.log(e)
	var projectNoVal = $('#delProjectNo').val();
	var workListVal = [];
	
	if($('input[id^=thisWorkNo]').val() != null){
		workListVal.push($('input[id^=thisWorkNo]').val());
	} else {
		workListVal = null;
	}
	
	var fileNoListVal = [];
	if($('input[id^=delFile]').val() != null){
		fileNoListVal.push($('input[id^=delFile]').val());
	} else {
		fileNoListVal = null
	}
	
	
	var projectMemVal = $('#delProjectMem').val()
	
	console.log($('input[id^=delFile]').val())
	
	var proData = {
			projectNo : projectNoVal,
			workList : workListVal,
			fileNoList : fileNoListVal,
			memNo : projectMemVal
	}
	console.log(proData);
	$.ajax({
		type : "post",
		url : "/project/delProject",
		data : JSON.stringify(proData),
		contentType :  "application/json; charset=utf-8",
		success : function(res){
			if(res.re === "OK"){
				 window.location.href = "/project/projectHome";
			} else {
				console.log("xxx")
			}
			//	window.location.href = "/project/projectHome";
		}
		
	})
}


function workdel(e) {
	console.log()
	var workNoVal = $('#thisWorkNo'+e).val()
	var projectNoVal = $('#WorkProjectNo'+e).val();
	var memNoVal = $('#projectMem').val();
	var fileNoVal = $('#fileNo'+e).val();
	
/* 	var checkListVal = [];
	checkListVal.push($('input[id^=clNo]').val());
	
	var comentListVal =[];
	comentListVal.push($('inupt[id^=cmntNo]').val());
	
	var fileListVal = [];
	fileListVal.push($('input[id=fileNo'+e+']').val());
	 */

	
	console.log(fileList)
	var delData = {
		workNo : workNoVal,
		projectNo : projectNoVal,
		writerNo : memNoVal,
		fileNo : fileNoVal
		
	}
	 $.ajax({
		type : "post",
		url : "/project/delWork",
		data : JSON.stringify(delData),
		contentType :  "application/json; charset=utf-8",
		success : function(res){
			if(res === 'OK'){
				window.location.reload();
			}
		}
			
	}); 
	 
	
}


 $('div[id^=item]').on('contextmenu', function(e){
	 e.preventDefault();
	 console.log($(this).html())
 })

$(function(){
    
})
 
function cmntSave(e) {
	var cmntContentVal = $("#cmntContent"+e).val();
	var workNoVal = $("#workNo"+e).val();
	console.log(cmntContentVal)
	var cmntData = {
			cmntContent : cmntContentVal
			, workNo : workNoVal
	}
	console.log(cmntData)
	$.ajax({
		type : "post",
		url : "/project/newComent",
		data : JSON.stringify(cmntData),
		contentType :  "application/json; charset=utf-8",
		success : function(res){
			appendCmnt(res)
		}
	});
	
	
	
	
	function appendCmnt(res){
		var nullCmnt = $('#nullCmnt').val();
		if(nullCmnt === "Y"){
			$('#nullCmnt').parent('div').remove();    
			var cmntListDiv = $('#cmntListDiv');
			txt = 
				 `
				<div class="flex-1 ms-2 fs-10" id="cmntNoDiv\${res.cmntNo}">
                  <p class="mb-1 bg-200 rounded-3 p-2"><a>
                  <input type="hidden" id="nullCmnt" value="N">
                  <input type="hidden" id="cmntNo\${res.wcVO.cmntNo}" name="cmntNo\${res.wcVO.cmntNo}" value="\${res.wcVO.cmntNo}">
                  <input type="hidden" id="writerNo\${res.wcVO.cmntNo}" name="writerNo1\${res.wcVO.cmntNo}" value="\${res.wcVO.writer}">
                  <input type="hidden" id="workNo${res.wcVO.cmntNo}" name="workNo1\${res.wcVO.cmntNo}" value="\${res.wcVO.workNo}">
                  \${res.memName}
                  	</a> \${res.wcVO.cmntContent}</p>
                  	<button id="modifyCmntBtn">수정</button><button id="delCmntBtn" onclick=delCmnt(\${res.wcVO.cmntNo})>삭제</button>
               	 </div><br/>
			`; 
			cmntListDiv.append(txt)
		}
	};
	
}

	function delCmnt(e){ 
		var workNoVal = $('#workNo'+e).val();
		var cmntNoVal = $('#cmntNo'+e).val();
		var writerVal = $('#writerNo'+e).val();
		var delCmntData = {
				workNo : workNoVal,
				cmntNo : cmntNoVal,
				writer : writerVal
		}
		console.log(delCmntData)
		$.ajax({
			type : "post",
			url : "/project/delComent",
			data : JSON.stringify(delCmntData),
			contentType :  "application/json; charset=utf-8",
			success : function(res){
				console.log(res); 
			}
				
			
		});
		$('#cmntNoDiv'+e).parent('div').remove();  
		console.log("삭제"); 
	}

  
function showMemList() {
	console.log("ee");  
	var hiddenMemList = $('#hiddenMemList').show();
	// 열기
}
 
function memListHidden() {
	var hiddenMemList = $('#hiddenMemList').hide();
	// 닫기
}   
// 업데이트============================
	
	
		
		
// =================================


           



//workDetail()		///
$(document).ready(function() {

	$(".kanban-items-container").sortable({
        connectWith: '.kanban-items-container',  
        handle: "div", 
        cancel: ".kanban-column-footer", 
        placeholder: "sortable-placeholder",     
       
        start: function(event, ui) {
        	console.log(event);
            var order = $(this).sortable("toArray");
            console.log("start: " + order);
            console.log("1")
        },
        update: function(e, ui) {
            var order = $(this).sortable("toArray");
            console.log("업데이트: " + order);
            console.log("2")
        },
        receive: function(e, ui) {
            var order = $(this).sortable("toArray");
            console.log("recive: " + order);
            console.log("3")
        },
        remove: function(event, ui) {
            console.log("4")
            // 필요한 경우 구현
        },
        stop: function(e, ui) {
            console.log("5")
            console.log("dd");
        }
    });
	
	
	 var countwait = $('#countwait');
	 var counting = $('#counting');
	 var countend = $('#countend');
	 
	 
	 $('input[id^=workPrograss]').each(function(){
		var waitCount = 0;
		var ingCount = 0;
		var endCount = 0;
		 if($(this).val() === 'wait'){
			 waitCount++;
		 } else if($(this).val() === 'ing'){
			 ingCount++;
		 } else {
			 endCount++;
		 }
		 countwait.html("("+waitCount+")"); 
		 counting.html("("+ingCount+")");
		 countend.html("("+endCount+")");
	 });
	 
	 
	 // work 1개 이상일떼 디테일 모달 생성
	 var countwaitClumn = $('div[id^=workItem]').length; 
	 if(countwaitClumn > 0 ){
		 
		 var workListVal = [];
		 $("input[id^=thisWorkNo]").each(function(){
			workListVal.push($(this).val())
			 
		 });
			var projectVal = $('#projectNo').val();
			    
			var workVO = {
					
					workList : workListVal,
					projectNo : projectVal
			}        
			$.ajax({
				type : "post",
				url : "/project/workDetail",
				data : JSON.stringify(workVO),
				contentType :  "application/json; charset=utf-8",
				success : function(result){ 
					viewDetail(result);
					if(result.detailVal.res === 'OK'){
					console.log("성공")
					
					} else {
					console.log("실패")
						
					}
				}
			});
			                        
			function viewDetail(result){
				var txt = ''
				var hey = $('#hey');
				console.log(result.detailVal.workVO[0])
				
				if(result.detailVal.workVO != null){
					for (var i = 0; i < result.detailVal.workVO.length; i++) {   
						txt += `  
						
							<div class="modal fade" id="work-modal-\${result.detailVal.workVO[i].workNo}" tabindex="-1" aria-labelledby="kanban-modal-label-2" aria-hidden="true" data-bs-backdrop="static" >
								<div class="modal-dialog modal-lg mt-6" role="document">
									<div class="modal-content border-0">
									<!-- X버튼 -->
									<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
										<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" onclick=cancelBtn(\${result.detailVal.workVO[i].workNo})></button>
									</div>
										<div class="modal-body p-0" id="projectTitleDiv">
											<!-- 제목 입력칸  <헤더느낌> -->
											<div class="bg-body-tertiary rounded-top-lg py-3 ps-4 pe-6">
												<h3 class="mb-1"> 
												<input type="hidden" id="projectNo\${result.detailVal.workVO[i].workNo}" name="projectNo" value="\${result.detailVal.workVO[i].projectNo}">
												<input type="hidden" id="workNo\${result.detailVal.workVO[i].workNo}" name="workNo" value="\${result.detailVal.workVO[i].workNo}">
												`;
												if(result.detailVal.workVO[i].importYn === 'Y'){
													txt += `<span style="color : red;">[긴급]</span>`;
												}
												
												
												txt +=`
														업무명 : <span id="workTitleSpan\${result.detailVal.workVO[i].workNo}"> \${result.detailVal.workVO[i].workTitle} <span>
													<input class="workTitle" type="text" name="workTitle" id="workdetailTitle\${result.detailVal.workVO[i].workNo}" value="\${result.detailVal.workVO[i].workTitle}" style="display:none;"> ✎ 
												</h3>
											</div> 
											<!-- 제목 입력칸 끝 -->
											<!-- 바디 느낌 -->		
											<div class="p-4">
												<div class="row">
													<div class="col-lg-9">
													<!-- 입력마다 구역지역 -->
														<div class="d-flex">
															<div class="mb-3 fs-9">
																<div id="importDiv" style="display:none;">
																	중요 여부 :	<input type="checkbox" name="importYn" id="importYn\${result.detailVal.workVO[i].workNo}" value="\${result.detailVal.workVO[i].importYn}" >
																</div>
																<br/>
																<h3 > 업무 정보 : </h3>	
																<textarea class="newWorkInput" id="newWorkIntro\${result.detailVal.workVO[i].workNo}" name="workIntro" rows="5" cols="55" disabled>\${result.detailVal.workVO[i].workIntro}</textarea>  
															</div>
														</div>
													<!-- 입력마다 구역지역  끝-->
													<!-- 입력마다 구역지역 -->
													<div class="d-flex">
														
														<span id="fontColor"> 마감일 : &nbsp;  \${result.detailVal.workVO[i].endDate} </span>
														<input type="date" class="newWorkInput" id="endDate\${result.detailVal.workVO[i].workNo}"  naem="endDate" style="display:none;"> 
													</div>
												<!-- 입력마다 구역지역  끝-->
												<!-- 입력마다 구역지역 -->
												<div class="d-flex">
													<h3> 
														<span id="fontColor">😄 업무 담당자 지정</span>
													</h3>
													<button class="showMemList" onclick=showMemList() id="showMemList\${result.detailVal.workVO[i].workNo}" style="display: none;">+</button>
												</div>
											<div class="d-flex">
												<div id="hiddenMemList\${result.detailVal.workVO[i].workNo}" style="display: none;">
													<div class="row">
														<div id="memberNo">
														`;
														
														if(result.detailVal.workVO[i].paMemList != null){
															for (var pa = 0; pa < result.detailVal.workVO[i].paMemList.length; pa++) {
																
																txt+= `
																	<span>김$\${result.detailVal.workVO[i].paMemList[pa].memNo}</span>
																	<input type="hidden" id="paMemNo\${result.detailVal.workVO[i].paMemList[pa].memNo}" name="memNo" value="\${result.detailVal.workVO[i].paMemList[pa].memNo}">
																	<button  style="display: none;">X</button>
																	`;
															}
														}
										txt += `		<!-- 입력마다 구역지역  끝-->
														</div>
														<button onclick=memListHidden(\${result.detailVal.workVO[i].workNo})>닫기버튼</button>
													</div>
												</div>
										`;
									
									if(result.detailVal.workVO[i].memList != null ){
										for (var j = 0; j < result.detailVal.workVO[i].memList.length; j++) {
										txt += `
											<div id="workMem">
												<input type="hidden" id="memNo" name="memNo" value="\${result.detailVal.workVO[i].memList[j].memNo}">  
												이름 : \${result.detailVal.workVO[i].memList[j].memNo}
												<button  style="display: none;">X</button>
											</div>
										`;	
										}
									} else {
										txt += `해당 업무에 인원이 설정되어있지 않습니다.`
									}
						
									txt += `
									</div>	
									<div  class="d-flex">
										<h3>
											<span id="fontColor"> ▥ 체크 리스트 </span> <button id="addCheckListBtn\${result.detailVal.workVO[i].workNo}" style="display:none;">+</button>
										</h3>
										<br/>
										<hr/>
									</div> 
									<div  class="d-flex">
										<div class="checkList" id="checkListDiv" >
									`;
									if(result.detailVal.workVO[i].checkList != null ){
										for (var c = 0; c < result.detailVal.workVO[i].checkList.length; c++) {
										txt += `	
											<div id="inputNew">
												<input type="hidden" id="clNo\${result.detailVal.workVO[i].checkList[c].clNo}" value="\${result.detailVal.workVO[i].checkList[c].clNo}">
												<input type="checkbox" id="ckeckYn\${result.detailVal.workVO[i].checkList[c].clNo}" value="\${result.detailVal.workVO[i].checkList[c].checkYn}" > &nbsp;&nbsp;
												<input type="text" id="clName" name="clName" value="\${result.detailVal.workVO[i].checkList[c].clName}" disabled>
												&nbsp;&nbsp;<button id="\${result.detailVal.workVO[i].checkList[c].clNo}"  style="display:none;" >X</button>
											</div>
										`;
											
										}
									}
									
									txt += `	
										</div>  
									</div>	
									 <div>
										 <h3> 
											<span id="fontColor"> ▥  파일 첨부 </span>
										</h3> 
										<div id="inputFiles" style="display:none;">
												<form method="post" enctype="multipart/form-data">
													<input type="file"  class="custom-file-input" id="attachedFiles" name="attachedFiles" multiple class="form-control" style="display:none;">
												</form>
										</div>		
											<div class="fileUploadDiv" id="fileUploadDiv">
									`;
										if(result.detailVal.workVO[i].fileDetailList != null){
											for (var f = 0; f < result.detailVal.workVO[i].fileDetailList.length; f++) {
												txt += `
												<div id="files"> 
												<input type="hidden" id="fileNo\${result.detailVal.workVO[i].workNo}" value="\${result.detailVal.workVO[i].fileDetailList[f].fileNo}">
													\${result.detailVal.workVO[i].fileDetailList[f].fileOriginalname} 
													<button id="upFiles\${result.detailVal.workVO[i].fileDetailList[f].fileDetailNo}" style="display:none;">X</button>
												</div>
												`;
											}
										} else {  
											txt += `파일이 없습니다.`;										
										}  
	  
									txt += `
														</div>
													
												</div>
												<div>
													<div>
														<div class="d-flex">
															<span class="mb-3 fs-9">댓글</span>
															<div class="avatar avatar-l me-2">
																프로필
															</div>
															<div class="position-relative border rounded-1 mb-3">
																<textarea id="cmntContent\${result.detailVal.workVO[i].workNo}" name="cmntContent" rows="1"></textarea> 
																<div class="d-flex flex-between-center bg-body-tertiary rounded-bottom p-2 mt-1">
																	<button class="btn btn-sm btn-primary" onclick=cmntSave(\${result.detailVal.workVO[i].workNo})>저장</button>
																</div>
															</div>
														</div>  
													<!-- 댓글 하나 -->
														<div class="kanban-items-container scrollbar" id="cmntListDiv"> 
															<a href="">  
							                              		 
							                            	</a>`;
							                            if(result.detailVal.workVO[i].cmtList.cmntContent != null){ 
							                            	for (var cm = 0; cm < result.detailVal.workVO[i].cmtList.length; cm++) { 
							                            		txt += `
							                            		<div class="d-flex mb-3">
							                            			<div class="avatar avatar-l">
							                            			\${result.detailVal.workVO[i].cmtList[cm].writerNo}
								                              		</div> 
							                            			 <div class="flex-1 ms-2 fs-10" id="cmntNoDiv\${result.detailVal.workVO[i].cmtList[cm].cmntNo}">
											                              <p class="mb-1 bg-200 rounded-3 p-2"><a>
											                              <input type="hidden" id="nullCmnt" value="N">
											                              <input type="text" id="cmntNo\${result.detailVal.workVO[i].cmtList[cm].cmntNo}" name="\${result.detailVal.workVO[i].cmtList[cm].cmntNo}" value="\${result.detailVal.workVO[i].cmtList[cm].cmntNo}">
											                              <input type="text" id="writerNo\${result.detailVal.workVO[i].cmtList[cm].writerNo}" name="wirterNo" value="\${result.detailVal.workVO[i].cmtList[cm].writerNo}">
											                              <input type="text" id="cmntWrokNo\${result.detailVal.workVO[i].cmtList[cm].writerNo}" name="workNo" value="\${result.detailVal.workVO[i].cmtList[cm].workNo}">
											                              	</a> \${result.detailVal.workVO[i].cmtList[cm].cmntContent}</p>
											                            	<button id="modifyCmntBtn">수정</button><button id="delCmntBtn" onclick=delCmnt(\${result.detailVal.workVO[i].cmtList[cm].cmntNo})>삭제</button>
										                           	 </div>
										                          </div> 	 
							                            		`;
							                            		
															} 
							                            } else {
							                            	txt += `
							                            		 <div class="flex-1 ms-2 fs-10" id="cmntDiv">
									                              <p class="mb-1 bg-200 rounded-3 p-2" ><a>
									                              <input type="hidden" id="nullCmnt" value="Y">
									                              	</a> 댓글이 없습니다.</p>
									                           	 </div>
							                            	`;
							                            }
							                           
							                           	txt += 
							                            	`
							                          	</div>
														
												 		<div>
												 			<button id="saveUpBtn" style="display:none;">저장</button>
												 			<button id="upBtn" onclick=upBtn(\${result.detailVal.workVO[i].workNo})>수정</button> <button data-bs-dismiss="modal" aria-label="Close" onclick=cancelBtn(\${result.detailVal.workVO[i].workNo})>취소</button>
												 			
												 		</div>
												 	</div> 
											 	</div>
											</div>
										</div>
									</div>		
								</div>
							</div>
						</div>
					</div> 
				</div>
			</div> 
		</div>
	</div>
</div>`;   
				}
				hey.html(txt);
				console.log(${result.detailVal.workVO[1].fileDetailList})
			} else {
				alert("모달 불러오기 실패");
			}
		}
		 
	 }
	
		var upCheckDel = $('button[id^=upCheckDel]');
		upCheckDel.on('click',function(){
			console.log("dd")
			$(this).parent().remove();   
			
		});
})
 
 		 function upBtn(e){
		 
			console.log("dd")
			console.log($('#workTitle'+e).val())  
				$('#workTitleSpan'+e).hide();
				$('#workdetailTitle'+e).show(); 
				$('#importDiv').show();
				$('#workIntro'+e).removeAttr("disabled");
				$('#endDate'+e).show();
				$('#hiddenMemList'+e).show();
				
				var impoertYn = $('#importYn'+e).val()
				if(importYn === 'Y'){
					$('#importYn'+e).checked = true;
				} else {
					$('#importYn'+e).checked = false;
				}
				
				$('#addCheckListBtn'+e).show();
				$('.showMemList'+e).show();
				
				$('button[id^=upCheckDel]').show();
				$('#memDelBtn'+e).show();
				$('#workTitleSpan').hide();
				
			var addCheckListBtn = $('#addCheckListBtn'+e);
			addCheckListBtn.on('click', function(){
				
				txt = '';
				txt += '<div id="inputNew">';
				txt += '&nbsp;&nbsp;체크리스트 : <input type="text" id="newClName" name="clName">'
				txt += '&nbsp;&nbsp;<button id="newCheckDel" >X</button>'
				txt += '<div>'
				var checkListDiv = $('#checkListDiv');
				checkListDiv.append(txt);
				var clName = $('#newClName').val();  
				
			function cancelBtn() {
				$('#workTitleSpan'+e).show();
				$('#workdetailTitle'+e).hide(); 
				$('#importDiv').hide();
				$('#workIntro'+e).attr("disabled");
				$('#endDate'+e).hide();
				$('#hiddenMemList'+e).hide();
				
				$('#addCheckListBtn'+e).hide();
				$('.showMemList'+e).hide();
				$('#hiddenMemList'+e).hide(); 
				$('button[id^=upCheckDel]').hide();
				$('#memDelBtn'+e).show();
				$('#workTitleSpan').show();
				
			}	
				
			});	
			
			$(document).on('click','#newCheckDel',function(){
				$(this).parent().remove();
				console.log($(this))
			})
	 }
	// ====================== 신규 work 추가 모달창 출력 =============================
	
//========================= 신규 work 모달창 출력 끝 =============================
//========================= 신규 work 모달창 취소버튼 2개 =============================

	function cancelBtn(){
		
		txt = '';
		var checkListDiv = $('#checkListDiv');
		checkListDiv.html(txt);
 
		var fileUploadDiv = $('#fileUploadDiv');
		fileUploadDiv.html(txt);
		
		var fileNo = $('#attachedFiles');
		fileNo.val(txt);
		
		var endDate = $('#endDate');
		endDate.val(txt);
		
		var workIntro = $('#newWorkIntro');
		workIntro.val(txt);
		
		var workMem = $('#workMem')
		workMem.html('');
		
		var workTitle = $('#newWorkTitle');
		workTitle.val('');
		
		$('.modal-newWok').hide();
	}
//========================= 신규 work 모달창 취소버튼 2개 끝 =============================
//=========================  신규 work 생성 ============================
	//================= 신규 맴버 추가 =================
	function showMemList() {
		var hiddenMemList = $('#hiddenMemList').show();
		// 열기
	}
	
	function memListHidden() {
		var hiddenMemList = $('#hiddenMemList').hide();
		// 닫기
	}

	$('div[id^=memberNo]').each(function() {
	    $(this).on('dblclick', function() {
	        var workMem = $('#workMem');
	        var memId = $(this).find('input').val(); // 멤버 ID를 가져옴
	        var existingMem = workMem.find('input[value="' + memId + '"]').closest('div'); // 이미 추가된 멤버 확인

	        if (existingMem.length > 0) {
	            // 이미 추가된 멤버가 있으면 삭제
	            	existingMem.remove();
	           // console.log("맴버가 삭제되었습니다: ", memId);
	        } else {
	            // 추가된 멤버가 없으면 추가
	            var mem = $(this).clone(); // 요소 복제
	            
	            // 버튼을 보이게 설정
	            var button = mem.find('button');
		            if (button.length > 0) {
		                button[0].style.display = 'inline'; // 버튼을 보이게 처리
		                
		                // 버튼 클릭 시 삭제 기능 추가
		                button.on('click', function() {
		                    $(this).closest('div').remove(); // 해당 멤버 삭제
		                   /// console.log("버튼 클릭으로 맴버가 삭제되었습니다: ", memId);
		                });
		            } else {
		                // console.warn("버튼이 없습니다: ", mem); // 버튼이 없는 경우 경고
		            }
	
		            workMem.append(mem); // memberList에 추가
		            console.log("맴버가 추가되었습니다: ", memId);
	        }

	        // 현재 리스트의 상태 출력
	       // console.log("현재 memberList: ", memberList.html());
	    });
	});

	//================= 신규 맴버 추가 끝================= 
	// ================ 체크리스트 추가 ====================
	var addCheckListBtn = $('#addCheckListBtn');
	addCheckListBtn.on('click', function(){
		
		txt = '';
		txt += '<div id="inputNew">';
		txt += '&nbsp;&nbsp;체크리스트 : <input type="text" id="newClName" name="clName">';
		txt += '&nbsp;&nbsp;<button id="newCheckDel" >X</button>';
		txt += '<div>';
		var checkListDiv = $('#checkListDiv');
		checkListDiv.append(txt);
	});	
	
	$(document).on('click','#newCheckDel',function(){
		$(this).parent().remove();
		console.log($(this))
	})
	
	
	// ================ 체크리스트 추가 끝 ====================
		
	var fileList = [];
	$("input[name='newAttachedFiles']").on('change',function(e){
		var files = e.target.files;
		fileList = [];
		for (var i = 0; i < files.length; i++) {
			fileList.push(files[i]);
		}
	});
		
	function insert(){
		
		$('input[id^=newClName]').each(function(){
			if($(this).val() === ''){
				// 입력해야하는 강제성 부여해야함
				return false
			} 
		});	
			
				var workTitleVal = $('#newWorkTitle').val();
				var endDateVal = $('#endDate').val();
				var workIntroVal = $('#newWorkIntro').val();
				var projectNoVal = $('#projectNo').val();
				var importYnVal = $('#importYn').val();
				var memNoListVal = [];
				var clNameLsitVal = []
				var checkYnListVal = [];
					for (var i = 0; i < $('#workMem').find('input[id="memNo"]').length; i++) {
						
						memNoListVal.push($('#workMem').find('input[id="memNo"]').eq(i).val());
						
					}
					for (var i = 0; i < $('input[id^=newClName]').length; i++) {
						clNameLsitVal.push($('input[id^=newClName]').eq(i).val())
					}

					
				var newWorkData = {
						workTitle : workTitleVal
						, endDate : endDateVal
						, workIntro : workIntroVal
						, projectNo : projectNoVal
						, importYn : importYnVal
				};
				var memListData	= {
						memNoList : memNoListVal
				}
					console.log(newWorkData);
				
				var checkListData = {
						clNameLsit : clNameLsitVal
				};
					console.log(checkListData);
					
				var formData = new FormData();
				for (var i = 0; i < fileList.length; i++) {
					formData.append("files",fileList[i]);
				};
				console.log("ad"+fileList)
				
				formData.append("workVO", new Blob([JSON.stringify(newWorkData)], {type:"application/json; charset=utf-8"}));
				formData.append("chekVO", new Blob([JSON.stringify(checkListData)], {type:"application/json; charset=utf-8"}));
				formData.append("picVO", new Blob([JSON.stringify(memListData)], {type:"application/json; charset=utf-8"}));

				console.log(formData);
				
				$.ajax({
					 type : "post"
					 , url : "/project/insertWork"
					 , data : formData
					 , processData : false
					 , contentType : false
					 , success : function(res){
						 
						
						 addNewWork(res)
						
					 },
					 error : function(){
						 alert("실패")
					 }
					 
				 });
				 
				 function addNewWork(res){  
					var nullWork = $('#nullWork');
					nullWork.remove()
					  cancelBtn();
					 
					 txt = '';
							if(res.workVO != null ){     
								   
					 txt += `
							<div class="kanban-item sortable-item-wrapper" draggable="true" id="item\${res.workVO.workNo }">
								<div class="kanban-item sortable-item-wrapper" draggable="false">
									<div class="card sortable-item kanban-item-card hover-actions-trigger">
										<div class="card-body">
										<!-- 숨긴버튼 -->
                                    	<div class="position-relative">
                                    	<div class="dropdown font-sans-serif">
											<button class="btn btn-sm btn-falcon-default kanban-item-dropdown-btn hover-actions" type="button" data-boundary="viewport" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<svg class="svg-inline--fa fa-ellipsis-h fa-w-16" data-fa-transform="shrink-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-h" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.5em;">
													<g transform="translate(256 256)">
														<g transform="translate(0, 0)  scale(0.875, 0.875)  rotate(0 0 0)">
															<path fill="currentColor" d="M328 256c0 39.8-32.2 72-72 72s-72-32.2-72-72 32.2-72 72-72 72 32.2 72 72zm104-72c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72zm-352 0c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72z" transform="translate(-256 -256)">
															</path>
														</g>
													</g>
												</svg>
											</button>
									        <div class="dropdown-menu dropdown-menu-end py-0" style="">
										        <a class="dropdown-item text-danger" id="workDel" draggable="false" onclick=workdel(\${res.workVO.workNo })>Remove</a>
									    	</div>
										</div>
                                    	</div>
                                    	<!-- 숨긴버튼 끝-->
						                        <p class="mb-0 fw-medium font-sans-serif stretched-link" data-bs-toggle="modal" data-bs-target="#work-modal-\${res.workVO.workNo}" >
						                        <input type="hidden" id="thisWorkNo\${res.workVO.projectNo}" name="workNo" value="\${res.workVO.workNo}"> 
						                        <input type="hidden" id="WorkProjectNo\${res.workVO.projectNo}" name="projectNo" value="\${res.workVO.projectNo}">
						                        <input type="hidden" id="workPrograss\${res.workVO.projectNo}" name="workPrograss" value="\${res.workVO.workPrograss}">
													\${res.workVO.workTitle }
												</p>
				                        <div class="kanban-item-footer cursor-default">
				                        	<span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Attachments"><svg class="svg-inline--fa fa-paperclip fa-w-14 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paperclip" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M43.246 466.142c-58.43-60.289-57.341-157.511 1.386-217.581L254.392 34c44.316-45.332 116.351-45.336 160.671 0 43.89 44.894 43.943 117.329 0 162.276L232.214 383.128c-29.855 30.537-78.633 30.111-107.982-.998-28.275-29.97-27.368-77.473 1.452-106.953l143.743-146.835c6.182-6.314 16.312-6.422 22.626-.241l22.861 22.379c6.315 6.182 6.422 16.312.241 22.626L171.427 319.927c-4.932 5.045-5.236 13.428-.648 18.292 4.372 4.634 11.245 4.711 15.688.165l182.849-186.851c19.613-20.062 19.613-52.725-.011-72.798-19.189-19.627-49.957-19.637-69.154 0L90.39 293.295c-34.763 35.56-35.299 93.12-1.191 128.313 34.01 35.093 88.985 35.137 123.058.286l172.06-175.999c6.177-6.319 16.307-6.433 22.626-.256l22.877 22.364c6.319 6.177 6.434 16.307.256 22.626l-172.06 175.998c-59.576 60.938-155.943 60.216-214.77-.485z"></path></svg><span>1</span></span>
				                        	<span class="me-2" data-bs-toggle="tooltip" data-bs-original-title="Checklist"><svg class="svg-inline--fa fa-check fa-w-16 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
				                        	<path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"></path></svg>
				                        	<span></span>
				                        	</span>
				                        </div>
										</div>
									</div>
								</div>
							</div>
						`
						}
							   // "대기함" ID를 가진 열에 새로운 업무 항목 추가
					        document.getElementById('plusNew').insertAdjacentHTML('beforeend', txt);
					
							   
					         // Sortable 재초기화 (Sortable 라이브러리 사용 시)
					        new Sortable(document.querySelector('.kanban-items-container'), {
					            group: 'shared',
					            animation: 150
					        });
					         
							
				 }
	}
	

//=========================  신규 work 생성 =============================


</script>

<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->

  