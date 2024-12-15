<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.input-border {
    border: none; 
    border-bottom: 1px solid #000; 
    outline: none; 
    padding: 8px 0; 
    width: 100%; 
}

.input-border:focus {
    border-bottom: 2px solid #007bff; 
}

.treeview .treeview-border {
    border-width: 0px;
}
</style>
<div class="navbar-vertical-content h-100 border-end border-end-1 position-relative" style="width: 250px;">
	<div class="flex-column" style="height: 60px">
		<div class="d-flex flex-row justify-content-center align-middle align-items-center ps-3 pt-3 pe-3 mb-3">
			<div class="d-flex flex-row align-middle align-items-center input-border p-0" style="width: 90%">
				<span class="fas fa-search"></span>
	            <input type="text" class="position-relative border-0 p-0">
	            <span class="position-absolute" style="cursor: pointer;left: 200px"><i class="bi bi-x"></i></span>
	        </div>
		</div>
	</div>
	<div class="fs-10 ps-3">Management</div>
	<div class="scrollbar ps-3 pe-3 pb-3 position-relative d-block" style="height: 90%" id="sidebar-content"">
		<ul class="mb-0 treeview position-relative" id="treeviewExample">
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">기본관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/admin/basic/capacityRequest"> <span style="height: 20px">용량 요청 관리</span></a>
							</p>
						</div>
					</li>
			
				</ul>
			</li>
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-2-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">보안 관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-2-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/admin/security/loginLog"> <span style="height: 20px">멤버 접근 로그</span></a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-3-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">조직 관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-3-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/admin/organization/design"> <span style="height: 20px">조직설계</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/admin/organization/memberManage"> <span style="height: 20px">멤버통합관리</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/admin/organization/register"> <span style="height: 20px">조직 일괄등록</span></a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-4-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">메뉴 관리</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-4-1" data-show="true">

					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-2" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">홈</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-2" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">대시보드</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-3" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">전자결재</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-3" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/approval/approvalFormList"> <span style="height: 20px">결재 양식</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/approval/chart"> <span style="height: 20px">전자결재 통계</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-4" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">커뮤니티</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-4" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/board/main"> <span style="height: 20px">커뮤니티 기본설정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/board/statistics"> <span style="height: 20px">커뮤니티 통계</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-5" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">메일</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-5" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/mail/statistics"> <span style="height: 20px">메일 통계</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-6" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">일정관리</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-6" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">전사 일정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">전사 기념일 / 공휴일</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-7" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">자원 예약</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-7" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/reservation/assetManage"> <span style="height: 20px">자원 관리</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-8" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">근태관리</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-8" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">근태관리 기본설정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/attend/attendSetTime"> <span style="height: 20px">기본설정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/attend/attendSetState"> <span style="height: 20px">근태 유형</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">근무지 설정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/attend/attendSetVaca"> <span style="height: 20px">연차 유형</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/attend/attendDelVaca"> <span style="height: 20px">연차 현황</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-9" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">설문</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-9" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">설문 기본설정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">전체 설문</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-10" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">주소록</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-10" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">주소록 기본 설정</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">공용 주소록</span></a>
									</p>
								</div>
							</li>
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="#"> <span style="height: 20px">전체 주소록 통계</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="treeview-list-item mb-2">
						<p class="treeview-text">
							<a data-bs-toggle="collapse" href="#treeviewExample-4-11" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">프로젝트</span>
							</a>
						</p>
						<ul class="collapse treeview-list ps-1" id="treeviewExample-4-11" data-show="false">
							<li class="treeview-list-item">
								<div class="treeview-item">
									<p class="treeview-text">
										<a class="mailList flex-1" href="/admin/project"> <span style="height: 20px">프로젝트 통계</span></a>
									</p>
								</div>
							</li>
						</ul>
					</li>
				</ul>
			</li>
			
		</ul>
	</div>
</div>
<script type="text/javascript">

let isAlertVisible = false;
let arrDay = ["일", "월", "화", "수", "목", "금", "토"];
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

function getWeekend(dateStr) {
	let date = new Date(dateStr);
	let day = arrDay[date.getDay()];
	return day;
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
</script>