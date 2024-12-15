<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.treeview-list-item.active, .selected  {
    background-color: #f0f8ff;
}
.slash {
	background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');
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
.skeleton-item {
    height: 20px; /* 높이는 항목에 따라 조정 */
    background-color: #e0e0e0; /* 스켈레톤 색상 */
    margin: 5px 0; /* 간격 조정 */
    border-radius: 4px; /* 모서리 둥글게 */
    animation: pulse 1.5s infinite; /* 애니메이션 효과 */
}

@keyframes pulse {
    0% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
    100% {
        opacity: 1;
    }
}

#approvalModal .modal-dialog {
    max-width: 800px;
    max-height: 600px;
    overflow: hidden;
}

#approvalModal .modal-body {
    max-height: 450px;
    overflow-y: auto;
}

#formTree {
    max-height: 300px;
    overflow-y: auto;
}

#memberList {
    height: 300px;
    overflow-y: auto;
}

#approvalLine, #referenceList, #readList {
    max-height: 100px;
    overflow-y: auto;
    list-style: none;
    padding-left: 0px;
    margin-bottom: 0px
}

#updateApprovalLineList, #updateReferenceList, #updateReadList {
    max-height: 100px;
    overflow-y: auto;
    list-style: none;
    padding-left: 0px;
    margin-bottom: 0px
}

</style>
		
	<div class="d-flex flex-row" style="height: 100%">
	<div id="alertBox" style="position: fixed; top: 100px; left: 60%; transform: translateX(-50%); display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   </div>
	<div style="width: 265px; height: 100% ">
	<div class="navbar-vertical-content scrollbar border-end border-end-1 card mb-2 p-2" style="width: 250px;height: 100%;">
		<div class="flex-column mb-2 pb-2">
			<div class="d-flex flex-row justify-content-between p-3">
				<h4 class="mb-0 p-1 ms-2">전자결재</h4>
				<a href="/approval/setApproval"><i class="bi bi-gear text-dark-emphasis fs-7 me-3"></i></a>
			</div>
			<div style="text-align: center;">
				<button class="btn btn-outline-dark me-1 mb-1 px-6 py-2"
					type="button" data-bs-toggle="modal"
					data-bs-target="#approvalModal" id="registerBtn">결재상신</button>
				<!-- 상신모달 시작 -->
				<div class="modal fade" id="approvalModal" tabindex="-1" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered modal-lg">
						<div class="modal-content">
							<!-- 모달 헤더 -->
							<div class="modal-header">
								<h5 class="modal-title">양식 선택 및 결재 라인 설정</h5>
								<button type="button" class="btn btn-outline-primary d-none" id="addToFavoritesBtn">자주 쓰는 양식 추가</button>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>

							<!-- 모달 본문 -->
							<div class="modal-body">
								<div class="row">
									<!-- 양식 목록 -->
									<div class="col-4">
										<h6>양식 목록</h6>
										<ul class="mb-0 treeview" id="formTree">
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#favorite" role="button"
														aria-expanded="false"> 자주 쓰는 양식 </a>
												</p>
												<ul class="collapse treeview-list" id="favorite"
													data-show="false">
												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form1" role="button"
														aria-expanded="false"> 교육 </a>
												</p>
												<ul class="collapse treeview-list" id="form1"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form2" role="button"
														aria-expanded="false"> 보고/시행문 </a>
												</p>
												<ul class="collapse treeview-list" id="form2"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form3" role="button"
														aria-expanded="false"> 인사 </a>
												</p>
												<ul class="collapse treeview-list" id="form3"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form4" role="button"
														aria-expanded="false"> 일반기안 </a>
												</p>
												<ul class="collapse treeview-list" id="form4"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form5" role="button"
														aria-expanded="false"> 지출결의서 </a>
												</p>
												<ul class="collapse treeview-list" id="form5"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form6" role="button"
														aria-expanded="false"> 출장 </a>
												</p>
												<ul class="collapse treeview-list" id="form6"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form7" role="button"
														aria-expanded="false"> 회계/총무 </a>
												</p>
												<ul class="collapse treeview-list" id="form7"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form8" role="button"
														aria-expanded="false"> 휴가 </a>
												</p>
												<ul class="collapse treeview-list" id="form8"
													data-show="false">

												</ul>
											</li>
											<li class="treeview-list-item">
												<p class="treeview-text fw-bold">
													<a data-bs-toggle="collapse" href="#form9" role="button"
														aria-expanded="false"> 기타 </a>
												</p>
												<ul class="collapse treeview-list" id="form9"
													data-show="false">

												</ul>
											</li>
										</ul>
									</div>

									<!-- 직원 주소록 -->
									<div class="col-4">
										<h6>주소록</h6>
										<ul class="mb-1 treeview" id="memberList">
										</ul>
									</div>

									<!-- 결재 라인, 참조, 열람 설정 -->
									<div class="col-4" id="approvalSettings">
										<h6 class="mb-0 text-start" style="padding-left: 55px">결재라인</h6>
										<div class="d-flex mb-2">
											<div class="d-flex flex-column align-items-center">
												<button class="btn btn-outline-secondary mb-2 add-to-line sidebar-btn"
													data-list="approvalLine" data-btn="memberList">→</button>
												<button class="btn btn-outline-secondary remove-from-line sidebar-btn"
													data-list="approvalLine">←</button>
											</div>
											<ul id="approvalLine" class="ms-2 overflow-x-auto border bg-200 w-100 scrollbar"></ul>
										</div>

										<h6 class="mb-0 text-start" style="padding-left: 55px">참조</h6>
										<div class="d-flex mb-2">
											<div class="d-flex flex-column align-items-center">
												<button class="btn btn-outline-secondary mb-2 add-to-line sidebar-btn"
													data-list="referenceList" data-btn="memberList">→</button>
												<button class="btn btn-outline-secondary remove-from-line sidebar-btn"
													data-list="referenceList">←</button>
											</div>
											<ul id="referenceList" class="ms-2 overflow-x-auto border bg-200 w-100 scrollbar">
												
											</ul>
										</div>

										<h6 class="mb-0 text-start" style="padding-left: 55px">열람</h6>
										<div class="d-flex">
											<div class="d-flex flex-column align-items-center">
												<button class="btn btn-outline-secondary mb-2 add-to-line sidebar-btn"
													data-list="readList" data-btn="memberList">→</button>
												<button class="btn btn-outline-secondary remove-from-line sidebar-btn"
													data-list="readList">←</button>
											</div>
											<ul id="readList" class="ms-2 overflow-x-auto border bg-200 w-100 scrollbar"></ul>
										</div>
									</div>
								</div>
							</div>

							<form id="approvalForm" action="/approval/register.do"
								method="POST">
								<input type="hidden" name="formNo" id="formNo">
								<input type="hidden" name="approvalLine" id="approvalLineInput">
								<input type="hidden" name="referenceList" id="referenceListInput">
								<input type="hidden" name="readList" id="readListInput">
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">취소</button>
									<button type="submit" class="btn btn-primary"
										id="registerApprBtn">결재 작성</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- 상신모달 끝 -->
			</div>
		</div>
		<div class="p-3">
			<ul class="mb-0 treeview" id="treeviewExample">
				<li class="treeview-list-item">
					<p class="treeview-text">
						<a href="/approval/approvalHome.do">
						 전자결재 홈
						</a>
					</p>
				</li>
				<li class="treeview-list-item">
					<p class="treeview-text fw-bold">
						<a data-bs-toggle="collapse" href="#treeviewExample-1-1"
							role="button" aria-expanded="false"> 결재 상신 </a>
					</p>
					<ul class="collapse treeview-list" id="treeviewExample-1-1"
						data-show="true">
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/favoriteForm.do"> <span
										class="me-2 text-success"></span> 자주 쓰는 양식
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/tempAppr"> <span
										class="me-2 text-warning"></span> 임시 보관함
									</a>
								</p>
							</div>
						</li>
					</ul>
				</li>
				<li class="treeview-list-item">
					<p class="treeview-text">
						<a data-bs-toggle="collapse" href="#treeviewExample-1-2"
							role="button" aria-expanded="false"> 수신함 </a>
					</p>
					<ul class="collapse treeview-list" id="treeviewExample-1-2"
						data-show="true">
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/importApprList"> <span
										class="me-2 text-warning"></span> 긴급
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/allApprList"> <span
										class="me-2 text-warning"></span> 전체 결재수신함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/waitingApprovalList"> <span
										class="me-2 text-primary"></span> 결재 대기함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/scheduledApprovalList"> <span
										class="me-2 text-primary"></span> 결재 예정함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/processingApprovalList">
										<span class="me-2 text-danger"></span> 결재 처리함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/completedApprovalList"> <span
										class="me-2 text-info"></span> 결재 수신 완료함
									</a>
								</p>
							</div>
						</li>
					</ul>
				</li>
				<li class="treeview-list-item">
					<p class="treeview-text fw-bold">
						<a data-bs-toggle="collapse" href="#treeviewExample-1-3"
							role="button" aria-expanded="false"> 발신함 </a>
					</p>
					<ul class="collapse treeview-list" id="treeviewExample-1-3"
						data-show="true">
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/allSendApprList"> <span
										class="me-2 text-success"></span> 전체 결재 발신함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/sendGoingApprList"> <span
										class="me-2 text-success"></span> 결재 진행함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/sendReturnApprList"> <span
										class="me-2 text-success"></span> 결재 반려함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/sendCompletedApprList"> <span
										class="me-2 text-warning"></span> 결재 발신 완료함
									</a>
								</p>
							</div>
						</li>
					</ul>
				</li>
				<li class="treeview-list-item">
					<p class="treeview-text fw-bold">
						<a data-bs-toggle="collapse" href="#treeviewExample-1-4"
							role="button" aria-expanded="false"> 기타함 </a>
					</p>
					<ul class="collapse treeview-list" id="treeviewExample-1-4"
						data-show="true">
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/refApprList"> <span
										class="me-2 text-success"></span> 참조함
									</a>
								</p>
							</div>
						</li>
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="flex-1" href="/approval/readApprList"> <span
										class="me-2 text-success"></span> 열람함
									</a>
								</p>
							</div>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>

<script type="text/javascript">

let memNo="${memberVO.memNo}";
console.log(memNo);
let isAlertVisible = false;
$(document).ready(function() {
	
	loadApprovalData('memberList');
	$(document).on('click', '.employee-item', function() {
        const memberName = $(this).data('member-name'); // 클릭한 직원의 이름 가져오기
        const position = $(this).data('position'); // 클릭한 직원의 직위 가져오기

        // 현재 선택된 직원 리스트에 하이라이트 추가
        $('#memberList li, #memberList2 li').removeClass('selected'); // 다른 선택 제거
        $(this).closest('li').addClass('selected'); // 클릭한 직원 선택

        // 선택된 직원의 정보를 알림 또는 다른 UI 요소로 표시할 수 있음
        console.log(`선택한 직원: \${memberName}, Position: \${position}`);
    });
});
function requiredAlert(comment, isAlertVisible) {
    let alertBox = $('#alertBox');
    isAlertVisible = false;
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

function addToLine(listId,btnId) {
	const selectedMember = $(`#\${btnId} li.selected a`); // 선택된 직원 가져오기
    if (selectedMember.length) {
        const targetList = $(`#\${listId}`); // 목표 리스트 선택

        // 중복 체크: 이미 해당 이름의 직원이 리스트에 있는지 확인
        const isAlreadyAdded = targetList.find(`[data-mem-no='\${selectedMember.data('mem-no')}']`).length > 0;
        if (isAlreadyAdded) {
        	requiredAlert('해당 직원은 이미 추가되었습니다.', isAlertVisible); // 이미 추가된 경우 경고
            return; // 함수 종료
        }

        console.log("No값: " + selectedMember.data('mem-no'));
        
        // 새로운 항목 추가
        const newItem = $(`
            <li class="treeview-list-item">
                        <p class="flex-1 employee-item mb-1 text-start fs-10" href="#!" 
                           data-member-name="\${selectedMember.data('member-name')}" 
                           data-position="\${selectedMember.data('position')}" 
                           data-mem-no="\${selectedMember.data('mem-no')}">
                            <span class="me-2 text-success"></span> \${selectedMember.text()}
                        </p>
            </li>
        `);

        // 클릭 시 선택되도록 이벤트 추가
        newItem.find('a').click(function () {
            selectItem($(this)); // 클릭 시 선택되도록
        });

        targetList.append(newItem); // 목표 리스트에 추가
    } else {
    	requiredAlert('직원을 선택하세요.', isAlertVisible); // 선택된 직원이 없을 경우 경고
    }
}


function removeFromLine(listId) {
    const selectedItem = $(`#\${listId} li.selected`); // 선택된 항목 가져오기
    if (selectedItem.length) {
        selectedItem.remove(); // 선택된 항목 삭제
    } else {
    	requiredAlert('삭제할 직원을 선택하세요.', isAlertVisible); // 선택된 항목이 없을 경우 경고
    }
}

// 직원 목록에서 선택 시 하이라이트(선택) 표시
$('#memberList li, #memberList2 li').click(function () {
    $('#memberList li').removeClass('selected'); // 다른 선택 제거
    $(this).addClass('selected'); // 클릭한 항목 선택
});

// 결재 라인, 참조, 열람 목록에서도 항목 선택 시 하이라이트 표시
$('#approvalLine li, #referenceList li, #readList li, #updateApprovalLine li, #updateReferenceList li, #updateReadList li').click(function () {
    // 각 리스트 항목에서 selected 클래스 하이라이트
    $(this).toggleClass('selected'); // 선택/해제
});

// 버튼 클릭 이벤트 연결
$('.add-to-line').click(function () {
    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
    const btnId = $(this).data('btn');
    
    if ($(this).hasClass('sidebar-btn')) {
        // 사이드바에서 추가
        addToLine(listId, btnId);
    }
});

$('.remove-from-line').click(function () {
    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
    
    if ($(this).hasClass('sidebar-btn')) {
        removeFromLine(listId); // 직원 삭제
    }
});

// 선택된 항목 강조 표시 함수
function selectItem(item) {
    item.toggleClass('selected'); // 선택/해제
}

    
    
    
    
    
    function loadApprovalData(btn) {
        // 전자결재 양식 불러오기
        $.ajax({
            url: "/approval/approvalFormList",
            type: "GET",
            success: function(response) {
                console.log(response);
                updateApprovalFormList(response);
                loadDeptAndMemData(btn); // 부서 및 직원 리스트 로드
            },
            error: function(xhr, status, error) {
                console.error("전자결재 양식을 불러오는 중 오류 발생:", error);
            }
        });
    }

    function loadDeptAndMemData(btn) {
        // 부서 및 직원 리스트 불러오기
        $.ajax({
            url: "/approval/approvalDeptList",
            type: "GET",
            success: function(deptResponse) {
                console.log(deptResponse);
                updateDeptList(deptResponse,btn); // 부서 리스트 업데이트

                // 부서 리스트를 업데이트한 후에 직원 리스트를 가져옴
                $.ajax({
                    url: "/approval/approvalMemList",
                    type: "GET",
                    success: function(memResponse) {
                        console.log(memResponse);
                        updateMemList(memResponse,btn); // 직원 리스트 업데이트
                        $('.skeleton-item').remove();
                    },
                    error: function(xhr, status, error) {
                        console.error("직원 리스트를 불러오는 중 오류 발생:", error);
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("부서 리스트를 불러오는 중 오류 발생:", error);
            }
        });
    }
    
    function updateDeptList(deptList,btn) {
        const deptArea = $(`#\${btn}`);
        deptArea.empty();
        deptList.forEach(dept => {
            const deptRow = `
                <li class="treeview-list-item">
                    <p class="treeview-text fw-bold">
                        <a data-bs-toggle="collapse" href="#\${btn}\${dept.deptNo}" role="button" aria-expanded="false"> 
                            \${dept.deptName}
                        </a>
                    </p>
                    <ul class="collapse treeview-list" id="\${btn}\${dept.deptNo}" data-show="false">
                        
                    </ul>
                </li>
            `;
            deptArea.append(deptRow);
        });
    }

    function updateMemList(memList,btn) {
        memList.forEach(mem => {
            const memRow = `
                <li class="treeview-list-item">
                    <div class="treeview-item">
                        <p class="treeview-text mb-1 text-start">
                            <a class="flex-1 employee-item fs-10" href="#!" 
                               data-member-name="\${mem.memName}" 
                               data-position="\${mem.posName}"
                               data-mem-no="\${mem.memNo}">
                                <span class="me-2 text-success"></span> \${mem.memName} \${mem.posName}
                            </a>
                        </p>
                    </div>
                </li>
            `;
            
            const areaId = `#\${btn}\${mem.deptNo}`;
            $(areaId).append(memRow); // 부서별 직원 리스트 추가
        });
    }

    
 	// 결재 작성 버튼 클릭 이벤트
    $('#registerApprBtn').click(function() {
	    const formNo = $('#formNo').val();
	    let approvalLine = '';
	    let referenceList = '';
	    let readList = '';
		
	    if(!formNo){
	    	requiredAlert("양식을 반드시 선택해야합니다!", isAlertVisible);
	    	return false;
	    }
	    
	    // 결재라인 가져오기
	    $('#approvalLine li p.employee-item').each(function() {
	        approvalLine += $(this).data('mem-no') + ',';
	    });
	
	    // 참조 리스트 가져오기
	    $('#referenceList li p.employee-item').each(function() {
	        referenceList += $(this).data('mem-no') + ',';
	    });
	
	    // 열람 리스트 가져오기
	    $('#readList li p.employee-item').each(function() {
	        readList += $(this).data('mem-no') + ',';
	    });
	
	    // 마지막 쉼표 제거 (리스트가 비어 있으면 빈 문자열로 유지)
	    approvalLine = approvalLine ? approvalLine.slice(0, -1) : '';
	    referenceList = referenceList ? referenceList.slice(0, -1) : '';
	    readList = readList ? readList.slice(0, -1) : '';
	
	    console.log("결재라인:" + approvalLine);
	    console.log("참조:" + referenceList);
	    console.log("열람:" + readList);
	
	    // 값을 hidden input에 설정
	    $('#approvalLineInput').val(approvalLine);
	    $('#referenceListInput').val(referenceList);
	    $('#readListInput').val(readList);
	
	    // 폼 제출
	    $('#approvalForm').submit();
	});

    
    function updateApprovalFormList(data) {
        // 결재 대기함, 처리함, 예정함, 완료함 데이터 분리
        let edu = data.filter(item => item.formCategory == '교육');
        let report = data.filter(item => item.formCategory == '보고/시행문');
        let personnel = data.filter(item => item.formCategory == '인사');
        let draft = data.filter(item => item.formCategory == '일반기안');
        let expenditure = data.filter(item => item.formCategory == '지출결의서');
        let businessTrip = data.filter(item => item.formCategory == '출장');
        let accounting = data.filter(item => item.formCategory == '회계/총무');
        let vacation = data.filter(item => item.formCategory == '휴가');
        let etc = data.filter(item => item.formCategory == '기타');

        // 각 리스트에 데이터 추가
        appendApprovalForm('#form1', edu);
        appendApprovalForm('#form2', report);
        appendApprovalForm('#form3', personnel);
        appendApprovalForm('#form4', draft);
        appendApprovalForm('#form5', expenditure);
        appendApprovalForm('#form6', businessTrip);
        appendApprovalForm('#form7', accounting);
        appendApprovalForm('#form8', vacation);
        appendApprovalForm('#form9', etc);
    }
    
    function appendApprovalForm(tableId,formList) {
		const formArea=$(tableId);
		formArea.empty();
		formList.forEach(form => {
	        const row = `
	        	<li class="treeview-list-item">
	            <div class="treeview-item">
	              <p class="treeview-text">
	              	<a class="flex-1" href="#!" data-form-no="\${form.formNo}"> 
                  		<span class="me-2 text-success"></span> \${form.formTitle}
              		</a>
	              </p>
	            </div>
	          </li>
	        `;
	        formArea.append(row);
	    });
		// 클릭 이벤트 핸들러 추가
		formArea.find('a.flex-1').click(function() {
	        $('#formTree').find('.treeview-list-item').removeClass('active');
	        $(this).closest('.treeview-list-item').addClass('active'); // 현재 선택 추가

	        const formNo = $(this).data('form-no'); // 클릭한 양식의 formNo 가져오기
	        $('#formNo').val(formNo);
	        console.log("선택한 formNo:", formNo); // formNo 출력 또는 다른 작업 수행
	        
	        $('#addToFavoritesBtn').removeClass('d-none');
	    });
		
	}
		$('#addToFavoritesBtn').click(function() {
		    const formNo = $('#formNo').val(); // 선택한 양식의 formNo 가져오기
		    // 확인 창 표시
		    if (confirm("자주 쓰는 양식에 추가하시겠습니까?")) {
		    	$.ajax({
                    url: '/approval/registerFavoriteForm',
                    type: 'GET',
                    data: { formNo: formNo },
                    dataType: 'text',
                    success: function(response) {
                    	requiredAlert("추가완료", isAlertVisible);
                    },
                    error: function(xhr, status, error) {
                        console.error(error);
                    }
                });
		    	console.log(formNo+"추가");
		    }
		});
</script>