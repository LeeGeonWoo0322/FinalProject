<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.nav-menu{
	display: flex;
	justify-content: space-around;
	align-items: center;
	height: 30px;
}

.nav-menu a{
	font-size: 16px;
	text-decoration: none;
	position: relative;
	cursor: pointer;
	color: #748194;
}

.nav-menu a::after{
	content: "";
	position: absolute;
	bottom: -4px;
	left: 50%;
	transform: translateX(-50%);
	width: 0;
	height: 1px;
	background: black;
	transition: all .1s ease-out;
	color: black;
}

.nav-menu a.active::after{
	width: 100%
}

.fc .fc-toolbar-title {
    font-size: 18px; /* Adjust to desired font size */
}

.fc-button {
    font-size: 12px; /* Adjust to desired button font size */
    padding: 4px 8px; /* Adjust button padding if necessary */
}

.fc-toolbar-chunk button.fc-prev-button, .fc-toolbar-chunk button.fc-next-button {
    font-size: 12px; /* Adjust size */
    padding: 4px; /* Adjust padding */
}

.fc .fc-toolbar.fc-header-toolbar {
	margin-bottom: 5px;
}

.fc-daygrid-day-frame {
    padding: 2px; /* 기본 패딩을 줄입니다 */
    height: 40px; /* 기본 높이를 줄입니다 */
}

.fc-daygrid-day-top {
    font-size: 12px; /* 날짜 글씨 크기 조정 */
}

.fc-daygrid-day-events {
    font-size: 10px; /* 이벤트 글씨 크기 조정 */
}

.fc-day-sun .fc-daygrid-day-number{
    color: #ff574c !important; /* 일요일에 있는 날짜 글자 색상을 빨간색으로 설정 */
}

.fc-day-sun .fc-col-header-cell-cushion{
	color: #ff574c !important;
}

.fc-scrollgrid-sync-table tr:last-child {
	display: none;
}

.fc-scrollgrid-sync-table tr:nth-last-child(2) {
	border-bottom: 1px solid var(--fc-border-color);
}

.fc-daygrid-day-events{
	display: none;
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: black; /* 화살표 배경색을 검정색으로 설정 */
    border-radius: 50%; /* 원형으로 만들기 위해 테두리 반경을 설정 */
}

.carousel-control-prev,
.carousel-control-next {
    filter: invert(1); /* 아이콘 색상을 반전시켜 검정색으로 보이게 함 */
}

.carousel-indicators button {
    background-color: gray; /* 비활성 인디케이터 색상 */
    opacity: 0.5; /* 비활성 상태 투명도 설정 */
}

.carousel-indicators button.active {
    background-color: black; /* 활성 인디케이터 색상 */
    opacity: 1; /* 활성 상태 투명도 설정 */
}

.fc-toolbar-chunk{
	display: flex;
	flex-direction: row;
}

.fc-direction-ltr .fc-toolbar > * > :not(:first-child){
	margin-left: 0.5em;
}

.fcBadge {
    position: absolute; /* 절대 위치 */
    top: -5px; /* 위쪽 위치 조정 */
    right: -10px; /* 오른쪽 위치 조정 */
    font-size: 12px; /* 폰트 크기 */
    z-index: 100;
    padding: 2px 8px;
}

#scheduleList .schedule {
	cursor: pointer;
}

#workSt:focus{
	box-shadow: none;
}

</style>

<div class="d-flex flex-column px-1 w-100" style="height: 100%">
<input type="hidden" value="${member.memNo}" id="userNo">
	<div class="d-flex flex-row justify-content-between mb-3">
		<div class="card d-flex flex-column p-3" style="width: 32.7%;">
			<div class="d-flex flex-row">
				<div class="col-sm-6 text-center">
					<img alt="" src="${pageContext.request.contextPath }/resources/icon/default_profile.png" style="width: 120px;height: 120px">
				</div>
				<div class="d-flex flex-column col-sm-6">
					<h5>${member.memName }</h5>
					<span class="mb-2" style="font-size: 14px">${member.deptName }/${member.posName }</span>
					<span style="font-size: 13px">사원번호 :${member.memId }</span>
					<span style="font-size: 13px">이메일 :${member.memEmail }</span>
					<span style="font-size: 13px">연락처 :${member.memTel }</span>
				</div>
			</div>
			<hr class="my-3">
			<div class="d-flex flex-row">
				<div class="d-flex flex-column col-sm-6">
					<div style="font-size: 14px" id="curDate">::</div>
					<div style="font-size: 33px" id="curTime">::</div>
				</div>
				<div class="d-flex flex-column col-sm-6">
					<div class="d-flex flex-row justify-content-between">
						<div style="font-size: 14px">출근시간</div>
						<div style="font-size: 14px" id="gTime">--:--:--</div>
					</div>
					<div class="d-flex flex-row justify-content-between">
						<div style="font-size: 14px">퇴근시간</div>
						<div style="font-size: 14px" id="lTime">--:--:--</div>
					</div>
					<div class="d-flex flex-row justify-content-between">
						<div style="font-size: 14px">주간 누적근무시간</div>
						<div style="font-size: 14px" id="glSumTime">--h --m --s</div>
					</div>
				</div>
			</div>
			<div class="d-flex flex-row justify-content-center d-gap gap-1 mt-2">
				<button class="btn border" id="gMWork" data-bs-toggle="modal" data-bs-target="#QRModal">출근하기</button>
				<button class="btn border" id="lMWork" data-bs-toggle="modal" data-bs-target="#QRModal">퇴근하기</button>
			</div>
		</div>
		<div class="card d-flex flex-row" style="width: 66.3%;height: 100%">
			<div id="calendar" class="w-50 p-3"></div>
			<div class="vr text-300"></div>
			<div class="d-flex flex-column w-50" style="height: 100%">
				<div class="d-flex flex-column" style="height: 100%">
					<h5 class="border-bottom p-3 m-0" id="selectDate"></h5>
					<div id="scheduleList" class="p-3" style="flex: 1 0 auto;">
						<c:choose>
							<c:when test="${empty scheduleList }">
								<div class="text-500">등록된 일정이 없습니다.</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${scheduleList }" var="schedule">
									<form action="/calendar/detail" method="post" class="scheduleForm">
										<input type="hidden" name="schdlNo" value="${schedule.schdlNo }">
										<div class="schedule d-flex flex-column mb-2">
											<div class="text-900" style="font-size: 14px;font-weight: bold;">${schedule.schdlName }</div>
											<div class="text-500" style="font-size: 13px">
												<c:choose>
													<c:when test="${schedule.startDate eq schedule.endDate }">
														${fn:substring(schedule.startTime,0,5) } ~ ${fn:substring(schedule.endTime,0,5) }
													</c:when>
													<c:otherwise>
														${fn:substring(schedule.startDate,5,10) } ${fn:substring(schedule.startTime,0,5) } ~ ${fn:substring(schedule.endDate,5,10) } ${fn:substring(schedule.endTime,0,5) }
													</c:otherwise>
												</c:choose>
											</div>
										</div>	
									</form>								
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="d-flex flex-row justify-content-between mb-3">
		<div class="card d-flex flex-column p-3" style="width: 49.5%">
			<div class="d-flex flex-row justify-content-between">
				<h5>전자결재</h5>
				<a href="/approval/approvalHome.do"><span class="fas fa-plus" style="width: 20px;height: 20px;cursor: pointer;color: #5F6E82"></span></a>
			</div>
			<div class="d-flex align-items-end border-bottom">
				<nav class="nav-menu align-bottom d-gap gap-3">
			        <a href="#" class="active" data-target="wait">결재 대기함</a>
				</nav>
			</div>
			<table>
				<colgroup>
					<col width="65%">
					<col width="10%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<tbody class="list">
					<c:choose>
                       <c:when test="${empty apprList}">
                           <tr>
                               <td colspan="6">결재 대기 문서가 존재하지 않습니다</td>
                           </tr>
                       </c:when>
                       <c:otherwise>
                           <c:forEach items="${apprList}" var="approval">
                               <tr>
                               		<td class="align-middle py-1 text-truncate" style="font-size: 14px">
                                       <a style="color: inherit; font-size: 14px;" href="/approval/detail.do?apprId=${approval.apprId}">${approval.apprTitle}</a>
                                   	</td>
                                   <td>
                                       <c:if test="${approval.apprImport == 'Y'}">
                                           <span class="badge rounded-pill bg-danger">긴급</span>
                                       </c:if>
                                   </td>
                                   <td class="senderName">${approval.senderName}</td>
                                   <td>${approval.regDate}</td>
                               </tr>
                           </c:forEach>
                       </c:otherwise>
                   </c:choose>
				</tbody>
			</table>
		</div>
		<div class="card d-flex flex-column p-3" style="width: 49.5%">
			<div class="d-flex flex-row justify-content-between">
				<h5>메일</h5>
				<a href="/mail/mailbox/1"><span class="fas fa-plus" style="width: 20px;height: 20px;cursor: pointer;color: #5F6E82"></span></a>
			</div>
			<div class="d-flex align-items-end border-bottom">
				<nav class="mailnav nav-menu align-bottom d-gap gap-3">
			        <a href="#" class="active" data-target="inbox">받은메일함</a>
			        <c:if test="${not empty mailBoxList }">
			        	<c:forEach items="${mailBoxList }" var="mailBox">
			        		 <a style="color: inherit;" href="#" data-target="${mailBox.mailboxName }" data-no="${mailBox.mailboxRowNo }">${mailBox.mailboxName }</a>
			        	</c:forEach>
			        </c:if>
				</nav>
			</div>
			<div id="inbox" class="optionContent w-100">
				<div id="inboxTable" data-list='{"page":5,"pagination":true}' class="w-100">
 					<div class="table-responsive scrollbar w-100"  style="height: 145px">
						<table class="w-100">
							<colgroup>
								<col width="65%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
							</colgroup>
							<tbody class="list">
								<c:choose>
									<c:when test="${empty pagingVO.dataList }">
										<tr>
											<td colspan="4">메일이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${pagingVO.dataList }" var="mail">
											<tr>
												<td class="align-middle py-1 text-truncate" style="font-size: 14px">
													<a style="color: inherit;" href="/mail/read/${pagingVO.keyword }/${mail.mailRowNo }"> <c:if test="${mail.mailImp eq 'Y' }"><span style="color: #D10000;font-size: 14px;margin-right: 3px;">[중요]</span></c:if>${mail.mailTitle}</a>
												</td>
												<td class="text-center align-middle py-1 px-1" style="font-size: 14px">${mail.memName }</td>
												<td class="text-center align-middle py-1 px-1" style="font-size: 14px">
													<c:if test="${mail.mailSecurityYn eq 'Y' }">보안메일</c:if>
													<c:if test="${mail.mailSecurityYn eq 'N' }">일반메일</c:if>
												</td>
												<td class="text-center align-middle py-1" style="font-size: 14px">${fn:substring(mail.mailDate, 0, 10) }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				    <div class="d-flex justify-content-center"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
				    	<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
				    </div>
			    </div>
		    </div>
		    <c:if test="${not empty mailBoxList }">
	        	<c:forEach items="${mailBoxList }" var="mailBox">
					<div id="${mailBox.mailboxName }" class="optionContent w-100 d-none">
						<div id="${mailBox.mailboxName }Table" data-list='{"page":5,"pagination":true}' class="w-100">
		 					<div class="table-responsive scrollbar w-100"  style="height: 145px">
								<table class="w-100">
									<colgroup>
										<col width="65%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
									</colgroup>
									<tbody class="list">
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
							</div>
						    <div class="d-flex justify-content-center"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
						    	<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
						    </div>
					    </div>
				    </div>
	        	</c:forEach>
		    </c:if>
		</div>
	</div>
	<div class="d-flex flex-row justify-content-between" style="flex: 1 0 auto;">
		<div class="d-flex flex-column card" style="width: 32.7%">
			<div class="d-flex flex-row justify-content-between border-bottom">
				<h5 class="p-3 border-bottom m-0">To Do List - 오늘의 할일</h5>
				<div class="align-middle p-3"><a href="#"><span class="fas fa-plus" style="width: 20px;height: 20px;cursor: pointer;color: #5F6E82"></span></a></div>
			</div>
			<div id="todayTodoList" class="d-flex flex-column scrollbar p-3" style="height: 197px">
			<c:choose>
				<c:when test="${empty todoVO }">
						<div class="form-check"><input class="form-check-input" id="flexCheckDefault1" type="checkbox" value="" /><label class="form-check-label" for="flexCheckDefault1">할일이 없습니다.</label></div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${todoVO }" var="todo">
						<div class="form-check">
						<c:choose>
							<c:when test="${todo.finYn eq 'Y' }">
								<input class="form-check-input " id="flexCheckDefault${todo.tdNo }" type="checkbox" value="${todo.finYn }" onclick="changYn(${todo.tdNo})" checked="checked"/> <label class="form-check-label text-truncate" for="flexCheckDefault1" style="text-decoration: line-through; background-color: transparent; border: none;" ><c:if test="${todo.importYn eq 'Y' }"><span style="color: red;">[중요]</span></c:if>${todo.tdContent }</label>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" id="flexCheckDefault${todo.tdNo }" type="checkbox" value="${todo.finYn }" onclick="changYn(${todo.tdNo})"/> <label class="form-check-label text-truncate" for="flexCheckDefault1"><c:if test="${todo.importYn eq 'Y' }"><span style="color: red;">[중요]</span></c:if>${todo.tdContent }</label>
							</c:otherwise>
						</c:choose>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div class="d-flex flex-column card" style="width: 32.7%">
			<div class="d-flex flex-row justify-content-between border-bottom">
				<h5 class="p-3 m-0">프로젝트</h5>
				<div class="align-middle p-3"><a href="#"><span class="fas fa-plus" style="width: 20px;height: 20px;cursor: pointer;color: #5F6E82"></span></a></div>
			</div>
			<div id="projectCarousel" class="carousel slide" data-bs-ride="carousel">
				<div class="carousel-indicators m-0">
					<c:choose>
						<c:when test="${not empty pro.proVO }">
							<c:forEach items="${pro.proVO }" var="proVO" varStatus="status">
								<button type="button" data-bs-target="#projectCarousel" data-bs-slide-to="${status.index }" <c:if test="${status.index eq 0 }">class="active" aria-current="true" </c:if> aria-label="Slide ${status.index }"></button>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
			    <div class="carousel-inner">
			    	<c:choose>
			    		<c:when test="${empty pro.proVO }">
							<div class="carousel-item active">
					            <div class="d-flex justify-content-center align-items-center" style="height: 200px">
					                <div class="d-flex flex-column p-3 border rounded-4" style="width: 60%">
					                    <table class="w-100">
					                        <colgroup>
					                            <col width="100px">
					                            <col width="200px">
					                        </colgroup>
					                        <tbody>
					                            <tr>
					                                <th>프로젝트명</th>
					                                <td><div style="width: 200px" class="text-truncate">프로젝트가 없습니다.</div></td>
					                            </tr>
					                            <tr>
					                                <th>마감기한</th>
					                                <td>0000-00-00</td>
					                            </tr>
					                            <tr>
					                                <th>담장자</th>
					                                <td>000</td>
					                            </tr>
					                            <tr>
					                                <th>진척도</th>
					                                <td>00%</td>
					                            </tr>
					                        </tbody>
					                    </table>
					                </div>
					            </div>
					        </div>
			    		</c:when>
			    		<c:otherwise>
			    			<c:forEach items="${pro.proVO }" var="pro" varStatus="status">
								<div class="carousel-item <c:if test="${status.index eq 0 }">active</c:if>">
                               	<span onclick=goDetail(${pro.projectNo}) style="cursor:pointer">
						            <div class="d-flex justify-content-center align-items-center" style="height: 200px">
						                <div class="d-flex flex-column p-3 border rounded-4" style="width: 60%">
						                    <table class="w-100">
						                        <colgroup>
						                            <col width="100px">
						                            <col width="200px">
						                        </colgroup>
						                        <tbody>
						                            <tr>
						                                <th>프로젝트명</th>
						                                <td>
							                                	<div style="width: 200px" class="text-truncate">
							                                		${pro.projectTitle }
							                                	</div>
						                                </td>
						                            </tr>
						                            <tr>
						                                <th>마감기한</th>
						                                <td>${pro.endDate }</td>
						                            </tr>
						                            <tr>
						                                <th>담장자</th>
						                                <td>${pro.mngMemName } ${pro.mngPosName }</td>
						                            </tr>
						                            <tr>
						                                <th>진척도</th>
						                                <td>${pro.totalField }%</td>
						                            </tr>
						                        </tbody>
						                    </table>
						                </div>
						            </div>
                               	</span>
						        </div>
			    			</c:forEach>
			    		</c:otherwise>
			    	</c:choose>
				    <button class="carousel-control-prev" type="button" data-bs-target="#projectCarousel" data-bs-slide="prev">
				        <span class="carousel-control-prev-icon" st aria-hidden="true"></span>
				        <span class="visually-hidden">Previous</span>
				    </button>
				    <button class="carousel-control-next" type="button" data-bs-target="#projectCarousel" data-bs-slide="next">
				        <span class="carousel-control-next-icon" aria-hidden="true"></span>
				        <span class="visually-hidden">Next</span>
				    </button>
				</div>
			</div>
		</div>
		<div class="d-flex flex-column card" style="width: 32.7%">
			<div class="d-flex flex-row justify-content-between border-bottom">
				<h5 class="p-3 border-bottom m-0">공지사항</h5>
				<div class="align-middle p-3"><a href="/board/boardList?boardType=전사게시판&postType=사내공지"><span class="fas fa-plus" style="width: 20px;height: 20px;cursor: pointer;color: #5F6E82"></span></a></div>
			</div>
			<div class="d-flex flex-column p-3">
				<div style="height: 140px">
					<table class="w-100">
						<colgroup>
							<col width="70%">
							<col width="20%">
						</colgroup>
						<tbody class="list">
							<c:forEach items="${boardList }" var="board" varStatus="status">
								<tr>
							        <td class="align-middle py-1 text-truncate" style="font-size: 14px">
							            <span class="new" style="display: none; color: red;">NEW</span>
							            <a href='/board/detail/${board.boardNo}' class="text-900">${board.boardTitle}</a>
							        </td>
									<td class="text-center align-middle py-1" style="font-size: 14px"> ${board.boardCreate }</td>
								</tr>
								    <script>
								        // 게시글 생성 날짜를 Date 객체로 변환
								        var createDate = new Date('${board.boardCreate}');
								        var currentDate = new Date();
								        
								        // 현재 날짜와 생성 날짜의 차이를 계산 (밀리초 단위)
								        var timeDiff = currentDate - createDate;
								        var dayDiff = timeDiff / (1000 * 3600 * 24); // 밀리초를 일로 변환
								
								        // NEW 태그를 추가할지 여부 결정
								        if (dayDiff <= 3) {
								            var newBadge = document.querySelectorAll('.new')[${status.index}];
								            if (newBadge) {
								               // newBadge.style.display = 'block'; //** inline과 block 차이 알기!
								                newBadge.style.display = 'inline'; // NEW 태그 보이기
								            }
								        }
								    </script>
							</c:forEach>
						</tbody>
					</table>
				</div>
			    <div class="d-flex justify-content-center"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			    	<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			    </div>
			</div>		
		</div>
	</div>
</div>
	<!-- 모달창 시작 -->
	<div class="modal fade" id="QRModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" id="QrCancel"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<div id="reader" style="width:500px; display:none;"></div>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	<div id="alertBox" style="position: fixed; top: 100px; left: 60%; transform: translateX(-50%); display: none;">
		<div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
	</div>
   	
<script src="${pageContext.request.contextPath}/resources/design/public/vendors/fullcalendar/index.global.min.js"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/2.3.8/html5-qrcode.min.js"></script>
<script type="text/javascript">

let today = new Date();
let dayOfToday = today.getDate();

let weekdays = ['일', '월', '화', '수', '목', '금', '토'];
let weekdayOfToday = weekdays[today.getDay()];

$("#selectDate").text(dayOfToday + " " + weekdayOfToday);

$("#curDate").text(today.getFullYear() + "년" + (today.getMonth()+1) + "월"+ dayOfToday + "일" + "(" + weekdayOfToday + ")")
var attendanceDate = today.getFullYear()+""+(today.getMonth()+1)+""+dayOfToday; // YYYYMMDD
var glSumTime = $("#glSumTime").val();
var userNo = $("#userNo").val();

const links = $('.mailnav a');
const contents =$('.optionContent');
printTime();
//현재시간 불러오기, Interval
setInterval(printTime, 1000);
printGlTime()		//출근시간, 퇴근시간 출력
overTimePrint();	// 주간 누적 근무시간 출력하기

	let isAlertVisible = false;

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

// 현재시간 출력하기
function printTime(){
	let today = new Date();
	var mm = "";
	var ss = "";
	
	inTime = `\${today.toTimeString().split(' ')[0]}`;
	
	if (today.getMinutes() < 10){
		mm =  `0\${today.getMinutes()}`	
	} else {
		mm = `\${today.getMinutes()}`
	}
	if(today.getSeconds() < 10){
		ss = `0\${today.getSeconds()}`
	} else {
		ss = `\${today.getSeconds()}`
	}
	
	$("#curTime").html(today.getHours() + ":" + mm + ":" + ss);
}

// 출근 버튼 누를시
	
	function gWorkBtn() {
		const today = new Date();
		var dateD = today.getDay();

		$.ajax({
			url : "/attend/gWork",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				inTime : inTime,
				dateD : dateD,
				monoverTime : glSumTime,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				console.log(res)
				if (res != 0){
					overTimePrint();
					printGlTime();
					requiredAlert("출근했습니다.",isAlertVisible);
					$("#QRModal").modal('hide')
				} else {
					requiredAlert("출근은 한번만 가능합니다.",isAlertVisible);
					$("#QRModal").modal('hide')
				}
			}
		})
	}
	
	// 퇴근버튼 누를시
	function lWorkBtn() {
		$.ajax({
			url : "/attend/lWork",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				outTime : inTime,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				if(res != 0){
					overTimeUpdate();
					printGlTime();
					requiredAlert("퇴근했습니다.",isAlertVisible);
					$("#QRModal").modal('hide')
				} else {
					requiredAlert("퇴근이 불가능한 상태입니다!.",isAlertVisible);
					$("#QRModal").modal('hide')
				}
			}
		})
	}

	// 시간 계산
	function overTimeUpdate() {
			$.ajax({
				url : "/attend/overTimeUpd",
				method : "post",
				data : JSON.stringify({
					memNo : userNo,
					attendanceDate : attendanceDate
				}),
				contentType : "application/json; charset=utf-8",
				success : function (attendance){
					let gtArr = [];		// 출근시간 배열
					let ltArr = [];		// 퇴근시간 배열
					let overArr = [];	// 기존 주간 누적 근무시간 배열
					let otArr = [];		// 근무시간 계산을 위한 빈 배열
					
					// DB에서 가져오는 값
					let gTime = attendance.inTime;			// 출근시간 
					let lTime = attendance.outTime;			// 퇴근시간
					let oTime = attendance.movertimeTime;	// 누적근무시간
					if (!oTime){
						oTime = "0:0:0";
					}

					// 0:0:0 형식으로 된 시간 형식을 split을 통해 나눠 배열형식으로 바꿈
					gtArr = gTime.split(":");
					ltArr = lTime.split(":");
					overArr = oTime.split(":");
					
					// 출근시간과 퇴근시간을 이용해 누적 근무시간 계산을 위한 배열에 값을 넣는다.
					// [0]=h, [1]=m, [2]=s
					otArr[0] = ltArr[0] - gtArr[0] 
					otArr[1] = ltArr[1] - gtArr[1]
					otArr[2] = ltArr[2] - gtArr[2]
					
					// ex) 출근 1:30:0, 퇴근 2:20:0, 누적 근무시간 0:50:0
					// 위와 같은 경우 계산
					if (otArr[2] < 0){
						otArr[1] = otArr[1] - 1
						otArr[2] = (60 - gtArr[2]) + parseInt(ltArr[2])
					}
					
					// ex) 출근 1:0:30, 퇴근 1:1:20, 누적 근무 시간 0:0:50
					// 위와 같은 경우 계산
					if (otArr[1] < 0){
						otArr[0] = otArr[0] - 1
						otArr[1] = (60 - gtArr[1]) + parseInt(ltArr[1])
					}
					
					// 기존 주간 누적 근무시간 + 오늘 근무시간 계산
					overArr[0] = parseInt(overArr[0]) + otArr[0]
					overArr[1] = parseInt(overArr[1]) + otArr[1]

					// 초 단위 먼저 계산해야함
					overArr[2] = parseInt(overArr[2]) + otArr[2]
					if (overArr[2] >= 60){
						overArr[1] += 1
						overArr[2] -= 60
					}
					
					if (overArr[1] >= 60){
						overArr[0] += 1
						overArr[1] -= 60
					}
					
					if (otArr[1] < 10) {
						otArr[1] = "0" + otArr[1]
					}
					
					if(otArr[2] < 10) {
						otArr[2] = "0" + otArr[2]
					}
					
					if (overArr[1] < 10) {
						overArr[1] = "0" + overArr[1]
					}
					
					if(overArr[2] < 10) {
						overArr[2] = "0" + overArr[2]
					}
					oTime = `\${overArr[0]}:\${overArr[1]}:\${overArr[2]}`
					otArr = `\${otArr[0]}:\${otArr[1]}:\${otArr[2]}`

					updOverTime(oTime, otArr);
			}
		})
	}
		
	// 누적 주간근무시간 업데이트
	function updOverTime(oTime, otArr) {
		$.ajax({
			url : "/attend/updOverTime",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate,
				overtimeTime : oTime,
				monoverTime : otArr
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance){
				console.log(attendance);
				overTimePrint()
			}
		})
	}
	
	//누적근무시간 출력
	function overTimePrint(){
		$.ajax({
			url : "/attend/otPrint",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance) {
				console.log(attendance)
				if(attendance.movertimeTime != null || attendance.movertimeTime == "") {
						let monoverTime = attendance.monoverTime;
						let movertimeTime = attendance.movertimeTime;
						if (movertimeTime != "00:00:00" && weekdayOfToday == "월"){
							movertimeTime = "00:00:00";
						}
						glSumTime = movertimeTime;
						if(movertimeTime.split(":")[0] < 10){
							console.log("0" + movertimeTime.split(":")[0])
							console.log(movertimeTime.split(":")[1])
							console.log(movertimeTime.split(":")[2])
							movertimeTime = "0" + movertimeTime.split(":")[0] + ":" +  movertimeTime.split(":")[1] + ":" + movertimeTime.split(":")[2]
							console.log(movertimeTime);
						}
						$("#glSumTime").html(movertimeTime);
				} else {
					$("#glSumTime").html("00:00:00");
				}
			}
		})
	}
	
	//출근시간, 퇴근시간 출력
	function printGlTime() {
	
		$.ajax({
			url : "/glWorkTime",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				attendanceDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function (attendance){
				if(attendance.inTime != null) {
					let gTime = attendance.inTime;
					$("#gTime").html(gTime);
				}
				if(attendance.outTime != null) {
					let lTime = attendance.outTime;
					$("#lTime").html(lTime);
				}
			}
		})
	}
	
	let html5QrCode = null;
	
	$("#gMWork").on("click",function(){
	 $('#reader').show(); // 스캐너 영역을 표시
		
	    // Html5QrCode 객체를 생성하여 QR 코드 스캔 기능을 활성화
	    // "reader"는 QR 코드를 스캔할 영역의 ID로, 이 영역애서 실시간으로 QR 코드를 스캔
	    html5QrCode = new Html5Qrcode("reader");
	
	    // html5QrCode.start(...) : QR 코드 스캔을 시작하는 메서드
	    html5QrCode.start(
	    		
	    	// "user" : 전면 카메라 사용
	    	// "environment : 후면 카메라 사용"
	        { facingMode: "environment" },
	        {
	        	// 초당 프레임 수
	            fps: 10,  
	            // QR 코드 인식 영역 크기
	            // qrbox: {width: 250, height: 250} -> 가로, 세로 각각 설정 가능
	            qrbox: 250
	            
	        },
	        
			// QR 코드 스캔을 성공하면 qrCodeMessage에 QR 코드의 데이터가 들어가고 콜백함수 실행
			function () {
				// QR 코드 데이터에서 JSON을 추출
				$.ajax({
				    url: '/account/memberQrCodeValue',
				    type: 'GET',
				    success: function(result) {
				
				// QR 코드 스캔을 중지하고 카메라를 끕니다.
				// 중지 성공 시 then() 실행, 실패 시 catch() 실행
			            html5QrCode.stop().then(() => {
			            	gWorkBtn();
			                console.log('QR code scanning stopped.');
			                $('#reader').hide();
			            }).catch((err) => {
			                console.error('Failed to stop QR code scanning:', err);
			                $('#reader').hide();
			            });
			        },error: function(xhr, status, error) {
			            console.error('Error fetching member data:', error);
			        }
			    });
			},
	       // 스캔 실패 시
	       function (error) {
	           console.warn(`QR 코드 스캔 실패: ${error}`);
	       }
		    // 시작 실패 시
		   ).catch(err => {
		       console.log(`QR 스캐너 시작 중 오류: ${err}`);
		   });
	})
	
	$("#lMWork").on("click",function(){
	 $('#reader').show(); // 스캐너 영역을 표시
		
	    // Html5QrCode 객체를 생성하여 QR 코드 스캔 기능을 활성화
	    // "reader"는 QR 코드를 스캔할 영역의 ID로, 이 영역애서 실시간으로 QR 코드를 스캔
	    html5QrCode = new Html5Qrcode("reader");
	
	    // html5QrCode.start(...) : QR 코드 스캔을 시작하는 메서드
	    html5QrCode.start(
	    		
	    	// "user" : 전면 카메라 사용
	    	// "environment : 후면 카메라 사용"
	        { facingMode: "environment" },
	        {
	        	// 초당 프레임 수
	            fps: 10,  
	            // QR 코드 인식 영역 크기
	            // qrbox: {width: 250, height: 250} -> 가로, 세로 각각 설정 가능
	            qrbox: 250
	            
	        },
	        
			// QR 코드 스캔을 성공하면 qrCodeMessage에 QR 코드의 데이터가 들어가고 콜백함수 실행
			function () {
				// QR 코드 데이터에서 JSON을 추출
				$.ajax({
				    url: '/account/memberQrCodeValue',
				    type: 'GET',
				    success: function(result) {
				
				// QR 코드 스캔을 중지하고 카메라를 끕니다.
				// 중지 성공 시 then() 실행, 실패 시 catch() 실행
			            html5QrCode.stop().then(() => {
			            	lWorkBtn();
			                console.log('QR code scanning stopped.');
			                $('#reader').hide();
			            }).catch((err) => {
			                console.error('Failed to stop QR code scanning:', err);
			                $('#reader').hide();
			            });
			        },error: function(xhr, status, error) {
			            console.error('Error fetching member data:', error);
			        }
			    });
			},
	       // 스캔 실패 시
	       function (error) {
	           console.warn(`QR 코드 스캔 실패: ${error}`);
	       }
		    // 시작 실패 시
		   ).catch(err => {
		       console.log(`QR 스캐너 시작 중 오류: ${err}`);
		   });
	})
	
	$("#QrCancel").on("click",function(){
		html5QrCode.stop();
	})

links.on("click", function (event) {
    event.preventDefault(); // 기본 링크 동작 방지
    
    // 현재 활성화된 링크에서 active 클래스 제거
    links.removeClass("active");

    // 클릭한 링크에 active 클래스 추가
    $(this).addClass("active");

    const targetId = $(this).data('target');
    
    if (targetId != 'inbox') {
		let mailboxRowNo = $(this).data("no");
		if (!$("#"+targetId.replace(" ", "\\ ")).find("td").eq(0).text()) {
			axios({
				url : "/getMailboxList.do",
				method : "post",
				data : {
					mailboxRowNo : mailboxRowNo
				},
				headers : {
					"Content-Type" : "application/json; charset=utf-8"
				}
			}).then(function (response) {
				let res = response.data;
				let mailBoxListHTML = "";
				for (var i = 0; i < res.length; i++) {
					mailBoxListHTML += `
										<tr>
											<td class="align-middle py-1 text-truncate" style="font-size: 14px">
												<a style="color: inherit;" href="/mail/read/\${mailboxRowNo+100 }/\${res[i].mailRowNo }">
										`;
				if (res[i].mailImp == 'Y') {
					mailBoxListHTML += `<span style="color: #D10000;font-size: 14px;margin-right: 3px;">[중요]</span>`;
				}
				mailBoxListHTML += `
											\${res[i].mailTitle}</a>
										</td>
										<td class="text-center align-middle py-1 px-1" style="font-size: 14px">\${res[i].memName }</td>
									`;
				if (res[i].mailSecurityYn == 'Y') {
					mailBoxListHTML += `<td class="text-center align-middle py-1 px-1" style="font-size: 14px">보안메일</td>`;
				}else {
					mailBoxListHTML += `<td class="text-center align-middle py-1 px-1" style="font-size: 14px">일반메일</td>`;
				}
				mailBoxListHTML += `
										<td class="text-center align-middle py-1" style="font-size: 14px">\${res[i].mailDate.substring(0,10) }</td>
									</tr>
									`;
				}
				$("#"+targetId.replace(" ", "\\ ")).find(".list").html(mailBoxListHTML);
			    // 모든 content div 숨김
			    contents.addClass("d-none");

			    // 클릭한 링크와 관련된 div 표시
			    const targetContent = $("#" + targetId.replace(" ", "\\ "));
			    if (targetContent.length) {
			        targetContent.removeClass("d-none");
			    }
			});
		}else {
		    // 모든 content div 숨김
		    contents.addClass("d-none");

		    // 클릭한 링크와 관련된 div 표시
		    const targetContent = $("#" + targetId.replace(" ", "\\ "));
		    if (targetContent.length) {
		        targetContent.removeClass("d-none");
		    }				
		}
	}else {
	    // 모든 content div 숨김
	    contents.addClass("d-none");

	    // 클릭한 링크와 관련된 div 표시
	    const targetContent = $("#" + targetId.replace(" ", "\\ "));
	    if (targetContent.length) {
	        targetContent.removeClass("d-none");
	    }		
	}
});

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	
	var calendar = new FullCalendar.Calendar(calendarEl, {
	    timeZone: 'local',
	    locale: 'ko',
	    themeSystem: 'bootstrap5',
	    initialView: 'dayGridMonth',
	    customButtons: {
	        customButton: {
	            click: function() {
	                location.href = "/calendar/main";
	            }
	        }
	    },
	    headerToolbar: {
	        left: 'title prev,next',
	        center: '',
	        right: 'customButton'
	    },
	    titleFormat: { 
	        year: 'numeric',
	        month: '2-digit'
	    },
	    height: 300,
	    events: "/getMyScheduleList.do",
	    dayCellContent: function (info) {
	        var number = document.createElement("a");
	        number.classList.add("fc-daygrid-day-number");
	        number.innerHTML = info.dayNumberText.replace("일", '').replace("日","");
	        if (info.view.type === "dayGridMonth") {
	            return {
	            html: number.outerHTML 
	            };
	        }
	        return {
	            domNodes: []
	        };
	    },
	    titleFormat: function (date) {
	        var currentDate = new Date(date.date.year, date.date.month, date.date.day);
	        var year = currentDate.getFullYear();
	        var month = currentDate.getMonth() + 1; 
	
	        return `\${year}년 \${month}월`;
	    },
	    eventDidMount: function(info) {
	        var eventDate = info.event.startStr.split("T")[0];
	        var badge = document.querySelector(`.fc-daygrid-day[data-date='\${eventDate}'] .fc-daygrid-day-number`);
	        
	        if (badge) {
	            var badgeSpan = badge.querySelector(".fcBadge");
	            
	            if (!badgeSpan) {
	                badgeSpan = document.createElement("span");
	                badgeSpan.classList.add("fcBadge", "badge", "rounded-pill", "bg-info");
	                badgeSpan.textContent = "1";
	                badge.appendChild(badgeSpan);
	            } else {
	                badgeSpan.textContent = parseInt(badgeSpan.textContent) + 1;
	            }
	        }
	    }
	});
	
	calendar.render();
	$(".fc-customButton-button").html(`<span class="fas fa-plus" style="width: 20px;height: 20px;color: #5F6E82"></span>`);
	$(".fc-prev-button, .fc-next-button, .fc-customButton-button").css("background", "white");
	$(".fc-prev-button, .fc-next-button, .fc-customButton-button").css("color", "#5F6E82");
	$(".fc-prev-button, .fc-next-button, .fc-customButton-button").css("border", "0");
	$(".fc-prev-button, .fc-next-button, .fc-customButton-button").css("box-shadow", "none");
	$(".fc-prev-button, .fc-next-button").css("display", "flex");
	$(".fc-prev-button, .fc-next-button").css("align-items", "flex-start");
	$(".fc-prev-button, .fc-next-button").css("vertical-align", "top");
	$(".fc-prev-button, .fc-next-button, .fc-customButton-button").addClass("p-0");
	$(".fc-prev-button").addClass("me-1");
	
	$(".fc-day").on("click", function () {
		let startDate = $(this).data("date");
		let selectDate = new Date(startDate);
		
		// 일(day) 가져오기
		var day = selectDate.getDate();

		// 요일 정보 가져오기
		var weekday = weekdays[selectDate.getDay()];
		
		$("#selectDate").text(day + " " + weekday);
		 
		axios({
			url : "/getScheduleList.do",
			method : "post",
			data : {
				startDate : startDate
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			scheduleListHTML = "";
			for (var i = 0; i < res.length; i++) {
				scheduleListHTML += `
									<form action="/calendar/detail" method="post" class="scheduleForm">
										<input type="hidden" name="schdlNo" value="\${res[i].schdlNo }">
										<div class="schedule d-flex flex-column mb-2">
											<div class="text-900" style="font-size: 14px;font-weight: bold;">\${res[i].schdlName}</div>
									`;
				if (res[i].startDate == res[i].endDate) {
					scheduleListHTML += `	<div class="text-500" style="font-size: 13px">\${res[i].startTime.substring(0,5)} ~ \${res[i].endTime.substring(0,5)}</div>`;
				}else {
					scheduleListHTML += `	<div class="text-500" style="font-size: 13px">\${res[i].startDate.substring(5,10)} \${res[i].startTime.substring(0,5)} ~ \${res[i].endDate.substring(5,10)} \${res[i].endTime.substring(0,5)}</div>`;
				}
				scheduleListHTML += `
										</div>
									</form>
									`;
			}
			$("#scheduleList").html(scheduleListHTML);
		});
	});
	
	$("#scheduleList").on("click", ".scheduleForm", function () {
		$(this).submit();
	});
	
	
	
	
		
	
});

function changYn(e){
	
	var finYN = $('#flexCheckDefault'+e);
	finYN.on('change',function(){
		
	 	if ($(this).prop("checked")) {
	        $(this).val('Y');
	        
	    } else {
	        $(this).val('N');
	       
	    }
			var tdNoVal = e
			var finYnVal = finYN.val();
			
			var finData = {
		    				tdNo : tdNoVal,
		    				finYn : finYnVal
			}
			console.log(finYnVal)
			 
			 $.ajax({
				type : "post",
	    		url : "/todo/finTodo",
	    		data : JSON.stringify(finData),
	    		contentType :  "application/json; charset=utf-8",
	    		success : function(response){
					if(response.status === "success"){
						console.log("r")
						if(finYN.val() === 'Y'){
							finYN.siblings('label').css("text-decoration", "line-through");
						}else {
							finYN.siblings('label').css("text-decoration", "");
						}
					} else {
						console.log("s")
					}
				}
			 }); 
		    console.log("아작스 실행");
	});
}
function goDetail(e){
	location.href = "/project/projectDetail/"+e
}
</script>
  