<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.treeview-list-item.active, .selected  {
    background-color: #f0f8ff; /* 강조 배경색 */
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

</style>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
<input type="hidden" value="${member.memNo}" id="userNo">
<input type="hidden" value="${member.memName}" id="userName">
<div class="d-flex flex-column w-75 ms-3 p-3">
	<div class="mb-3">
		<h3>채팅방 목록</h3>
<!-- 		<div class="d-flex flex-column" style="text-align: center;"> -->
<!-- 			<table class="table table-bordered border-500 fs-10 mb-0"> -->
<!-- 				<tr> -->
<!-- 					<th class="bg-200"><h3>방 제목</h3></th> -->
<!-- 					<th class="bg-200">방 제한인원</th> -->
<!-- 					<th class="bg-200">제한시간</th> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th align="center"><input type="text" id="roomTitle" class="form-control search-input fuzzy-search w-50"/> -->
<!-- 					<input type="hidden" id="passwd" class="input"/></th> -->
<!-- 					<th> -->
<!-- 						<input type="text" id="maxJoinCount" placeholder="default=4, max=16"/>  -->
<!-- 						<select id="maxJoinCount"> -->
<!-- 							<option value="4" selected>4명</option> -->
<!-- 							<option value="5">5명</option> -->
<!-- 							<option value="6">6명</option> -->
<!-- 							<option value="7">7명</option> -->
<!-- 							<option value="8">8명</option> -->
<!-- 							<option value="9">9명</option> -->
<!-- 							<option value="10">10명</option> -->
<!-- 							<option value="11">11명</option> -->
<!-- 							<option value="12">12명</option> -->
<!-- 							<option value="13">13명</option> -->
<!-- 							<option value="14">14명</option> -->
<!-- 							<option value="15">15명</option> -->
<!-- 							<option value="16">16명</option> -->
<!-- 						</select> -->
<!-- 					</th> -->
<!-- 					<th> -->
<!-- 					<input type="text" id="endDate" placeholder="default=40min" />  -->
<!-- 						<select id="endDate"> -->
<!-- 							<option value="1" selected>1시간</option> -->
<!-- 							<option value="2">2시간</option> -->
<!-- 							<option value="3">3시간</option> -->
<!-- 							<option value="4">4시간</option> -->
<!-- 							<option value="5">5시간</option> -->
<!-- 							<option value="6">6시간</option> -->
<!-- 							<option value="7">7시간</option> -->
<!-- 							<option value="8">8시간</option> -->
<!-- 							<option value="9">9시간</option> -->
<!-- 							<option value="10">10시간</option> -->
<!-- 							<option value="11">11시간</option> -->
<!-- 							<option value="12">12시간</option> -->
<!-- 						</select> -->
<!-- 					</th> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td><button class="btn btn-falcon-primary me-1 mb-1" id="roomCreate">생성</button></td> -->
<!-- 					<td colspan="2"><button class="btn btn-outline-dark me-1 mb-1 px-6 py-2" type="button" data-bs-toggle="modal" -->
<!-- 							data-bs-target="#inviteMemModal" id="registerBtn">대화상대 초대하기</button></td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</div>	 -->
		<input id="selectMember" type="hidden">
<!-- 		<hr /> -->
		<div id="tableExample2" data-list='{"page":10,"pagination":true}'>
			<div class="table-responsive scrollbar" style="min-height: 375px">
				<table class="table table-bordered fs-9 mb-0">
		    		<colgroup>
		    			<col width="40%">
		    			<col width="45%">
		    			<col width="15%">
		    		</colgroup>
					<thead class="bg-200">
						<tr>
							<th class="text-center text-900">채팅방 이름</th>
							<th class="text-center text-900">참가인원</th>
							<th class="text-center text-900">삭제</th>
						</tr>
					</thead>
					<tbody id='table_list' class="list">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
		    	</table>
			</div>	
			<div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
				<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			</div>
		</div>
	</div>
</div>
<!-- 모달 시작 -->
<div class="modal fade" id="inviteMemModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<!-- 모달 헤더 -->
			<div class="modal-header">
				<h5 class="modal-title">양식 선택 및 결재 라인 설정</h5>
			</div>

			<!-- 모달 본문 -->
			<div class="modal-body">
				<div class="row">
					<!-- 직원 주소록 -->
					<div class="col-4">
						<h6>주소록</h6>
						<ul class="mb-1 treeview" id="memberList">
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
							<li class="skeleton-item"></li>
						</ul>
					</div>

					<!-- 결재 라인, 참조, 열람 설정 -->
					<div class="col-4" id="approvalSettings">
						<h6>초대할 인원</h6>
						<div class="d-flex">
							<div class="d-flex flex-column align-items-center">
								<button class="btn btn-outline-secondary mb-2 add-to-line sidebar-btn"
									data-approval="approvalLine" data-btn="memberList">→</button>
								<button class="btn btn-outline-secondary remove-from-line sidebar-btn"
									data-approval="approvalLine">←</button>
							</div>
							<ul id="approvalLine" class="ms-2"></ul>
						</div>
					</div>
				</div>
			</div>
				<input type="hidden" name="approvalLine" id="approvalLineInput">
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary"
						id="registerApprBtn" data-bs-dismiss="modal">확인</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 모달 끝 -->
				
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
var memNo = $("#userNo").val();

// 비동기 통신으로 axios를 사용했다.
// 리스트를 조회하여 출력해준다.
function pageListRender() {
	
	axios.get('/ffChat/list/' + memNo)
	.then((response) => {
	    let res = response.data;
	    let table_list = "";
	    let li_list = "";

	    for (var i = 0; i < res.length; i++) {
	        table_list += `<tr>
	                           <td class="align-middle ps-2 py-0"><a href="http://biz.gooroomee.com/\${res[i][0].roomUrlId}" style="color:inherit">\${res[i][0].roomTitle}</a></td>
	                           <td class="align-middle ps-2 py-0">
	                           	   <div class="d-flex flex-row flex-wrap">`;

	        // 두 번째 반복문에서 변수 이름을 변경
	        for (var j = 0; j < res[i].length; j++) {
	            table_list += `	<span id="span" style="font-size: 13px;color: black;">
				                    <div class="border rounded-5 bg-info-subtle m-1 px-1">
				                        \${res[i][j].memName} \${res[i][j].posName}
				                    </div>
						        </span>`;
	        }

	        table_list += `
			    				</div>			
	        			   </td>
	                       <td class="text-center align-middle py-1"><a class='btn btn-danger' data-urlid="\${res[i][0].roomUrlId}">대화방 삭제하기</a></td>
	                   </tr>`;

	        li_list += `<li class="treeview-list-item">
	                        <div class="treeview-item">
	                            <p class="treeview-text">
	                                <a class="mailList flex-1" href="http://biz.gooroomee.com/\${res[i][0].roomUrlId}"> <span style="height: 20px">\${res[i][0].roomTitle}</span></a>
	                            </p>
	                        </div>
	                    </li>`;
	    }

	    document.querySelector('#table_list').innerHTML = table_list;
	    document.querySelector('#treeviewExample-1-1').innerHTML = li_list;

	    document.querySelector('#table_list').querySelectorAll('.btn').forEach((btn) => {
	        // del버튼에 방을 닫는 기능을 추가해준다.
	        btn.addEventListener('click', function() {
	            axios.get('/ffChat/close/' + this.dataset.urlid)
	            .then((res) => {
	                pageListRender();
	            });
	        });
	    });
	})
	.catch((err) => console.error(err));

}

//로딩시 리스트 불러오기
pageListRender();
window.onload = function(){
	var memNo = $("#userNo").val();
	var currentDate = new Date();
	
	document.querySelectorAll('.num_page').forEach((btn) => {
		btn.addEventListener('click', function(){
			pageListRender(this.innerText);
		});
	});
	
	// 방생성 버튼 클릭 이벤트
	$("#roomCreate").on('click', function(){
		console.log("방생성 클릭이벤트")
		
		console.log($("#roomTitle").val())
		let queryMap = {};		
		// 타이틀과 UrlId를 같은값으로 저장한다.
		// 필수로 값을 받는다.
		// UrlId가 없을 경우 랜덤으로 설정되어 구루미API가 제공하는 서비스를 사용하기 어려워진다.
		// UrlId는 중복이 불가능하다. 모든 API사용자들과 공유하기 때문에 특정 문자열추가를 추천
		if($("#roomTitle").val() != null && $("#roomTitle").val() != "" &&
				$("#selectMember").val() != null && $("#selectMember").val() != "") {
			queryMap.roomTitle = $("#roomTitle").val();
			queryMap.roomUrlId = $("#roomTitle").val()+currentDate;
			queryMap.selectedMem = $("#selectMember").val();
		} else {
			$("#roomTitle").focus();
			return;				
		}
		
		queryMap.maxJoinCount = document.querySelector('#maxJoinCount > option:checked').value;
		
		// 종료시간을 정해진 양식에 맞춰 추출한다.
		let date = new Date();
		date.setHours(date.getHours() + document.querySelector('#endDate > option:checked').value);
		queryMap.endDate = date.toString().substring(0, 25).concat(date.toString().substring(28, 33));
		
		console.log(queryMap);
		
		axios.post('/ffChat/room', queryMap)
		.then((res) => {
			// 입장링크 설정
			// http://biz.gooroomee.com/wer08128uoi232y3891u9.. 의 형식의 링크로 바로 접속이 가능하다.
			let link = 'http://biz.gooroomee.com/' + res.data.data.room.roomId;
// 			document.querySelector('#enter').setAttribute('href', link);
			
			pageListRender();
		})
		.catch((err) => console.error(err));
		
	});
	
}

function addToLine(listId,btnId) {
	const selectedMember = $(`#\${btnId} li.selected a`); // 선택된 직원 가져오기
    if (selectedMember.length) {
        const targetList = $(`#\${listId}`); // 목표 리스트 선택

        // 중복 체크: 이미 해당 이름의 직원이 리스트에 있는지 확인
        const isAlreadyAdded = targetList.find(`[data-mem-no='\${selectedMember.data('mem-no')}']`).length > 0;
        if (isAlreadyAdded) {
            alert('해당 직원은 이미 추가되었습니다.'); // 이미 추가된 경우 경고
            return; // 함수 종료
        }

        console.log("No값: " + selectedMember.data('mem-no'));
        
      //href="#!"
        // 새로운 항목 추가
        const newItem = $(`
            <li class="treeview-list-item">
                        <p class="flex-1 employee-item"  
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
        alert('직원을 선택하세요.'); // 선택된 직원이 없을 경우 경고
    }
}

function removeFromLine(listId) {
    const selectedItem = $(`#\${listId} li.selected`); // 선택된 항목 가져오기
    if (selectedItem.length) {
        selectedItem.remove(); // 선택된 항목 삭제
    } else {
        alert('삭제할 직원을 선택하세요.'); // 선택된 항목이 없을 경우 경고
    }
}

//직원 목록에서 선택 시 하이라이트(선택) 표시
$('#memberList li').click(function () {
    $('#memberList li').removeClass('selected'); // 다른 선택 제거
    $(this).addClass('selected'); // 클릭한 항목 선택
});

// 결재 라인, 참조, 열람 목록에서도 항목 선택 시 하이라이트 표시
$('#approvalLine li').click(function () {
    // 각 리스트 항목에서 selected 클래스 하이라이트
    $(this).toggleClass('selected'); // 선택/해제
});

// 버튼 클릭 이벤트 연결
$('.add-to-line').click(function () {
    const listId = $(this).data('approval'); // 버튼에 지정된 리스트 ID 가져오기
    const btnId = $(this).data('btn');
    
    if ($(this).hasClass('sidebar-btn')) {
        // 사이드바에서 추가
        addToLine(listId, btnId);
    }
});

$('.remove-from-line').click(function () {
    const listId = $(this).data('approval'); // 버튼에 지정된 리스트 ID 가져오기
    
    if ($(this).hasClass('sidebar-btn')) {
        removeFromLine(listId); // 직원 삭제
    }
});

// 선택된 항목 강조 표시 함수
function selectItem(item) {
    item.toggleClass('selected'); // 선택/해제
}

    $('#registerBtn').on('click',function(){
    	loadDeptAndMemData('memberList');
    });

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
    //href="#!"
    function updateMemList(memList,btn) {
        memList.forEach(mem => {
            const memRow = `
                <li class="treeview-list-item">
                    <div class="treeview-item">
                        <p class="treeview-text">
                            <a class="flex-1 employee-item"  
                               data-member-name="\${mem.memName}" 
                               data-position="\${mem.posName}" 
                               data-mem-no="\${mem.memNo}">
                                <span class="me-2 text-success"></span> \${mem.memName} \${mem.posName}
                            </a>
                        </p>
                    </div>
                </li>
            `;
            
            // 직원의 부서 번호에 맞는 부서 리스트에 직원 추가
            console.log(memRow);
            const areaId = `#\${btn}\${mem.deptNo}`;
            $(areaId).append(memRow); // 부서별 직원 리스트 추가
        });
    }

    // 직원 추가 기능: 직원명 클릭 시 선택
    $(document).on('click', '.employee-item', function() {
        const memberName = $(this).data('member-name'); // 클릭한 직원의 이름 가져오기
        const position = $(this).data('position'); // 클릭한 직원의 직위 가져오기

        // 현재 선택된 직원 리스트에 하이라이트 추가
        $('#memberList li').removeClass('selected'); // 다른 선택 제거
        $(this).closest('li').addClass('selected'); // 클릭한 직원 선택

        // 선택된 직원의 정보를 알림 또는 다른 UI 요소로 표시할 수 있음
        console.log(`Selected member: \${memberName}, Position: \${position}`);
    });
    
 	// 결재 작성 버튼 클릭 이벤트
    $('#registerApprBtn').click(function() {
	    const formNo = $('#formNo').val();
	    let approvalLine = '';
	
	    // 결재라인 가져오기
	    $('#approvalLine li p.employee-item').each(function() {
	        approvalLine += $(this).data('mem-no') + ',';
	    });
		
	    approvalLine += $("#userNo").val()
	    
	    console.log("결재라인:" + approvalLine);
		
		$('#selectMember').val(approvalLine)
		console.log($('#selectMember').val())
	});
</script>