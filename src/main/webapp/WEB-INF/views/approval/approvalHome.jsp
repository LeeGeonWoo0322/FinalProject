<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.approval-table{
	min-height: 225px;
}
.table tr td:first-chiid {
	padding-left: 0.5rem;
}
.skeleton {
  background-color: #e0e0e0;
  border-radius: 4px;
  position: relative;
  overflow: hidden;
}

.skeleton::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(255,255,255,0.6) 50%, rgba(255,255,255,0) 100%);
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(100%);
  }
}
.skeleton-table-row {
  width: 100%;
  height: 15px;
  margin-bottom: 10px;
}

</style>
		<div class="d-flex flex-column w-100 ms-3" style="height: 100%">
			<!-- 수신함 카드 -->
			<div class="card mb-3 p-3">
				<div class="position-relative">
					<div class="row">
						<div class="col-lg-8">
							<a href="/approval/allApprList"><h4 class="mb-1"><b>수신함</b></h4></a>
						</div>
					</div>
				</div>

				<!-- 수신 관련 게시판들, 한 줄에 두 개씩 나열 -->
				<div class="row g-3 mb-2">
					<div class="approval-table col-lg-6">
						<h5>
							결재 대기함
							<a href="/approval/waitingApprovalList">+</a>
						</h5>
						<div class="table-responsive scrollbar">
							<table class="table table-sm mb-0">
								<colgroup>
									<col width="60%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
								<thead class="bg-body-tertiary">
									<tr>
										<th class="text-center">제목</th>
										<th class="text-center">긴급</th>
										<th class="text-center">기안자</th>
										<th class="text-center">기안일</th>
									</tr>
								</thead>
								<tbody id="waitingApprovalList">
									<tr><td colspan="4"><div class="skeleton skeleton-table-row text-center"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row text-center"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row text-center"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row text-center"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row text-center"></div></td></tr>
								</tbody>
							</table>
						</div>
					</div>

					<div class="approval-table col-lg-6">
						<h5>결재 처리함<a href="/approval/processingApprovalList">+</a></h5>
						<div class="table-responsive scrollbar">
							<table class="table table-sm mb-0">
								<colgroup>
									<col width="60%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
								<thead class="bg-body-tertiary">
									<tr>
										<th scope="col" class="text-center">제목</th>
										<th scope="col" class="text-center">긴급</th>
										<th scope="col" class="text-center">기안자</th>
										<th scope="col" class="text-center">기안일</th>
									</tr>
								</thead>
								<tbody id="processingApprovalList">
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="row g-3">
					<div class="approval-table col-lg-6">
						<h5>결재 예정함<a href="/approval/scheduledApprovalList">+</a></h5>
						<div class="table-responsive scrollbar">
							<table class="table table-sm mb-0">
								<colgroup>
									<col width="60%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
								<thead class="bg-body-tertiary">
									<tr>
										<th scope="col" class="text-center">제목</th>
										<th scope="col" class="text-center">긴급</th>
										<th scope="col" class="text-center">기안자</th>
										<th scope="col" class="text-center">기안일</th>
									</tr>
								</thead>
								<tbody id="scheduledApprovalList">
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
								</tbody>
							</table>
						</div>
					</div>

					<div class="approval-table col-lg-6">
						<h5>결재 완료함<a href="/approval/completedApprovalList">+</a></h5>
						<div class="table-responsive scrollbar">
							<table class="table table-sm mb-0">
								<colgroup>
									<col width="60%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
								<thead class="bg-body-tertiary">
									<tr>
										<th scope="col" class="text-center">제목</th>
										<th scope="col" class="text-center">긴급</th>
										<th scope="col" class="text-center">기안자</th>
										<th scope="col" class="text-center">기안일</th>
									</tr>
								</thead>
								<tbody id="completedApprovalList">
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<!-- 발신함 카드 -->
			<div class="card p-3" style="flex: 1 0 auto">
			    <div class="position-relative">
			        <div class="row">
			            <div class="col-lg-8">
			                <a href="/approval/allSendApprList"><h4 class="mb-1"><b>발신함</b></h4></a>
			            </div>
			        </div>
			    </div>
			
			    <!-- 발신 관련 게시판들, 한 줄에 두 개씩 나열 -->
			    <div class="row g-3 mb-3">
			        <div class="approval-table col-lg-6">
			            <h5>결재 반려함<a href="/approval/sendReturnApprList">+</a></h5>
			            <div class="table-responsive scrollbar">
			                <table class="table table-sm mb-0">
			                    <colgroup>
									<col width="60%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
			                    <thead class="bg-body-tertiary">
			                        <tr>
										<th scope="col" class="text-center">제목</th>
										<th scope="col" class="text-center">긴급</th>
										<th scope="col" class="text-center">기안자</th>
			                            <th scope="col" class="text-center">기안일</th>
			                        </tr>
			                    </thead>
			                    <tbody id="rejectedApprovalList">
			                    	<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
			                    </tbody>
			                </table>
			            </div>
			        </div>
			
			        <div class="approval-table col-lg-6">
			            <h5>결재 완료함<a href="/approval/sendCompletedApprList">+</a></h5>
			            <div class="table-responsive scrollbar">
			                <table class="table table-sm mb-0">
			                	<colgroup>
									<col width="60%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
								</colgroup>
			                    <thead class="bg-body-tertiary">
			                        <tr>
										<th scope="col" class="text-center">제목</th>
										<th scope="col" class="text-center">긴급</th>
										<th scope="col" class="text-center">기안자</th>
			                            <th scope="col" class="text-center">기안일</th>
			                        </tr>
			                    </thead>
			                    <tbody id="completedSentApprovalList">
			                    	<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
									<tr><td colspan="4"><div class="skeleton skeleton-table-row"></div></td></tr>
			                    </tbody>
			                </table>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</div>

<script type="text/javascript">

$(document).ready(function() {
	let memNo="${memberVO.memNo}";
    loadApprovalList(); // 페이지 로드 시 전자결재 리스트 불러오기
    console.log(memNo);
});

function loadApprovalList() {
    $.ajax({
        url: "/approval/approvalList.do",  // 서버에서 리스트를 불러오는 URL
        type: "GET",
        success: function(response) {
            updateApprovalLists(response);
            $("#content").show();
        },
        error: function(xhr, status, error) {
            console.error("전자결재 목록을 불러오는 중 오류 발생:", error);
        }
    });
}
function updateApprovalLists(data) {
    // 결재 대기함, 처리함, 예정함, 완료함 데이터 분리
    let scheduledList = data.filter(item => item.apprStatus === '진행중' && item.myOrder > (item.apprOrder + 1)&& item.memNo!=memNo);
    let waitingList = data.filter(item => item.apprStatus === '진행중' && item.myOrder === (item.apprOrder + 1)&& item.memNo!=memNo);
    let processingList = data.filter(item => item.apprStatus === '진행중' && item.myOrder < (item.apprOrder + 1)&& item.memNo!=memNo);
    let completedList = data.filter(item => item.apprStatus === '완료'&& item.memNo!=memNo);
    
    let rejectedList = data.filter(item => item.apprStatus === '반려'&& item.memNo==memNo); // 결재 반려함
    let completedSentList = data.filter(item => item.apprStatus === '완료'&& item.memNo==memNo); // 결재 완료함
    $("#waitingApprovalList").empty();
    $("#processingApprovalList").empty();
    $("#scheduledApprovalList").empty();
    $("#completedApprovalList").empty();
    $("#rejectedApprovalList").empty();
    $("#completedSentApprovalList").empty();
    // 각 리스트에 데이터 추가
    appendApprovalRows('#waitingApprovalList', waitingList.slice(0, 5));
    appendApprovalRows('#processingApprovalList', processingList.slice(0, 5));
    appendApprovalRows('#scheduledApprovalList', scheduledList.slice(0, 5));
    appendApprovalRows('#completedApprovalList', completedList.slice(0, 5));
    
    appendApprovalRows('#rejectedApprovalList', rejectedList.slice(0, 5));
    appendApprovalRows('#completedSentApprovalList', completedSentList.slice(0, 5));
}

function appendApprovalRows(tableId, list) {
    const tbody = $(tableId);
    tbody.empty(); // 기존 행 제거

    list.forEach(item => {
        const urgentText = item.apprImport === 'Y' ? '<span class="text-danger">긴급</span>' : '<span class="text-info">보통</span>';
        const row = `
            <tr>
                <td><a href=/approval/detail.do?apprId=\${item.apprId}>\${item.apprTitle}</a></td>
                <td class="text-center">\${urgentText}</td>
                <td class="text-center">\${item.senderName}</td>
                <td class="text-center">\${item.regDate}</td>
            </tr>
        `;
        tbody.append(row);
    });
}

</script>
