<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>

/* style.css */
.page-content {
    display: flex;
    margin-top: 20px;
}

#page-sidebar {
    width: 200px;
    background-color: #f5f5f5;
    padding: 20px;
    border-right: 1px solid #ddd;
}

#page-sidebar ul {
    list-style-type: none;
    padding: 0;
}

#page-sidebar ul li {
    margin-bottom: 10px;
}

#page-sidebar ul li a {
    text-decoration: none;
    color: #333;
    display: block;
    padding: 10px;
    background-color: #e9e9e9;
    border-radius: 4px;
}

#calendar-container {
    flex-grow: 1;
    padding: 20px;
}
#calendar {
    width: 100%;
    height: 600px;
    border: 1px solid #ccc;
    background-color: #fff;
}

/* 주소록 style */
.treeview-list-item.active, .selected  {
    background-color: #f0f8ff; /* 강조 배경색 */
}

/* Datepicker를 위한 스타일 설정 */
.datepicker-input {
    width: 45%;
    display: inline-block;
    margin-right: 5px;
    padding-right: 30px; /* 아이콘과의 간격을 위한 패딩 */
    background: url('http://jqueryui.com/resources/demos/datepicker/images/calendar.gif') no-repeat right 5px center;
    cursor: pointer; /* 클릭 가능 커서 */
}

/* jQuery UI에서 자동 생성하는 아이콘 숨기기 */
.ui-datepicker-trigger {
    display: none; /* 기본 아이콘 숨기기 */
}

#memberList_ {
    max-height: 300px;
    overflow-y: auto;
}

#approvalLine {
        background-color: #f8f9fa; /* 밝은 배경색 */
        border: 1px solid #ddd; /* 회색 테두리 */
        border-radius: 4px; /* 모서리 둥글게 */
        padding: 10px; /* 내부 여백 */
        height: 260px;
        width: 350px;
        overflow-y: auto;
    }
</style>
   <!-- 캘린더 영역 -->
   <div style="width: 90%;">
	<div style="margin-top: 20px; margin-left: 20px;">
        <h2>일정수정</h2>
    </div>
    <div id="calendar-container" style="padding-bottom: 0;">
	<form action="/calendar/update" method="post" id="form">
		
		<table class="table table-bordered" style="width: 900px">
			<input id="selectMember" type="hidden">
				<colgroup>
				<col width="20%">
				<col>
			</colgroup
			<tr>
				<th>일정명</th>
				<td class="d-flex flex-row align-items-center">
					<input type="text" id="schdlName" name="schdlName" class="form-control form-control-sm" style="width: 450px" value="${schedule.schdlName }">
					<div class="form-check m-0 pt-2 ms-2"><input class="form-check-input" id="scret" type="checkbox" name="blind"/><label class="form-check-label" for="scret">비공개</label></div>
					<div class="form-check m-0 pt-2 ms-2"><input class="form-check-input" id="alarm" type="checkbox" name="alarm"/><label class="form-check-label" for="alarm">알림설정</label></div>
				</td>
			</tr>
			<tr>
				<th>일정 선택</th>
				<td class="d-flex flex-row align-items-center">
					<input type="text" id="datepicker" class="form-control datepicker-input" name="startDate" style="width: 150px; display: inline-block; margin-right: 5px;" value="${schedule.startDate}">
				     <select name="startTime" id="startTime">
				        <c:forEach var="i" begin="0" end="143"> <!-- 0부터 143까지 반복 -->
				            <c:set var="hours" value="${(10 * i) / 60}" /> <!-- 시간 계산 -->
				            <fmt:parseNumber var="hoursInt" value="${hours}" integerOnly="true"/>
				            <c:set var="minutes" value="${(10 * i) % 60}" /> <!-- 분 계산 -->
				            
				            <option value="${hoursInt}:${minutes}">
				                <fmt:formatNumber value="${hoursInt}" pattern="00"/>:
				                <fmt:formatNumber value="${minutes}" pattern="00"/>
				            </option>
				        </c:forEach>
				    </select>
				    <span class="align-middle mx-2 pt-1">~</span>
					<input type="text" id="datepicker1" class="form-control datepicker-input" name="endDate" style="width: 150px; display: inline-block; margin-right: 5px;" value="${schedule.endDate}">
				     <select name="endTime" id="endTime">
				        <c:forEach var="i" begin="0" end="143"> <!-- 0부터 143까지 반복 -->
				            <c:set var="hours" value="${(10 * i) / 60}" /> <!-- 시간 계산 -->
				            <fmt:parseNumber var="hoursInt" value="${hours}" integerOnly="true"/>
				            <c:set var="minutes" value="${(10 * i) % 60}" /> <!-- 분 계산 -->
				            
				            <option value="${hoursInt}:${minutes}">
				                <fmt:formatNumber value="${hoursInt}" pattern="00"/>:
				                <fmt:formatNumber value="${minutes}" pattern="00"/>
				            </option>
				        </c:forEach>
				    </select>
				    <div class="form-check m-0 pt-0 ms-2 d-flex align-items-center"> <!-- flexbox 사용 -->
				        <input class="form-check-input" id="allDay" type="checkbox" name="ALLDAY_YN" style="margin-right: 5px;"/>
				        <label class="form-check-label mb-0" for="allDay">종일</label>
				    </div>
<%-- 				    <div class="form-check m-0 pt-0 ms-2 d-flex align-items-center"> <!-- flexbox 사용 --> --%>
<%-- 				        <input class="form-check-input" id="rept" type="checkbox" name="REPT_YN" style="margin-right: 5px;"/> --%>
<%-- 				        <label class="form-check-label mb-0" for="rept">반복</label> --%>
<%-- 				    </div> --%>
				</td>
			</tr>
			<tr>
				<th>내 캘린더</th>
			    <td>
					<select id="schdlGroup" name="schdlGroup" class="form-select form-select-sm" style="width: 150px">
			            <option value="my">나의 일정</option>
			            <c:if test="${member.posNo >= 4}">
			                <option value="group">그룹 일정</option>
			            </c:if>
			            <c:if test="${member.posNo >= 7}">
			                <option value="all">전사 일정</option>
			            </c:if>
			        </select>
	            </td>
			</tr>
			<tr>
			    <th>참석자
			        <button class="border-0 bg-200" type="button" data-bs-toggle="modal" data-bs-target="#inviteMemModal" id="registerBtn_">
			            <span class="fas fa-plus me-2 text-500"></span>참석자 추가
			        </button>
			    </th>
			    <td>
			        <c:choose>
			            <c:when test="${not empty attendMember.schdlAttendeeVO}">
			                <c:forEach var="attendee" items="${attendMember.schdlAttendeeVO}">  
			                    <span class="fas fa-user-circle" style="font-size: 20px; margin-right: 5px;"></span>  
			                    ${attendee.memName} (${attendee.deptName}) &nbsp;&nbsp;  
			                </c:forEach> 
			            </c:when>
			            <c:otherwise>
			                <!-- 비어있을 때 출력할 내용이 없으므로 아무것도 없음 -->
			            </c:otherwise>
			        </c:choose>
			        <p id="selectedAddressName" name="memName" style="display: inline; margin: 0;"></p>
			        <div id="selectedAddressInputs" style="display: none;"></div>
			    </td>
			</tr>

			<tr>
				<th>외부 참석자</th>
				<td></td>
			</tr>
			<tr>
				<th>장소</th>
				<td><input type="text" id="schdlPlace" name="schdlPlace" class="form-control form-control-sm w-100" value="${schedule.schdlPlace }"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="schdlContent" id="schdlContent" cols="30" rows="5" style="width: 100%;" class="form-control">${schedule.schdlContent }</textarea></td>
			</tr>
		</table>
		
		<div style="text-align: right; padding-top: 10px; width: 900px">
			<input type="button" class="btn btn-info" id="updBtn" value="수정"/>
			<input type="button" class="btn btn-secondary" id="listBtn" value="취소"/>
		</div>
	</form>
	</div>
</div>


<!-- 모달 시작 -->
<div class="modal fade" id="inviteMemModal" tabindex="-1"aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<!-- 모달 헤더 -->
			<div class="modal-header">
				<h5 class="modal-title">참석자 추가</h5>
			</div>

			<!-- 모달 본문 -->
			<div class="modal-body">
				<div class="row">
					<!-- 직원 주소록 -->
					<div class="col-4">
						<h6>주소록</h6>
						<ul class="mb-1 treeview" id="memberList_">
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
									data-list="approvalLine" data-btn="memberList_">→</button>
								<button class="btn btn-outline-secondary remove-from-line sidebar-btn"
									data-list="approvalLine">←</button>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
<script type="text/javascript">

$(function() {
    $("#datepicker,#datepicker1").datepicker({
    	 dateFormat: 'yy-mm-dd'
    	,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    	,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
    	,changeYear: true //option값 년 선택 가능
    	,changeMonth: true //option값  월 선택 가능 
    	,showOn: "button" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
    	,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
    	,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
    	,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
    	,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
    	,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
    });
    
	 // 아이콘 클릭 시 Datepicker가 열리도록 input 클릭 이벤트 처리
    $(".datepicker-input").on("click", function() {
        $(this).datepicker("show");
    });
    
 	// 달력 버튼 이미지 크기 조정
    $(".ui-datepicker-trigger").css({
        width: "24px", // 원하는 크기로 조정
        height: "24px" // 원하는 크기로 조정
    });
    
});



$(function(){
	var form = $("#form");
	var updBtn = $("#updBtn");
	var listBtn = $("#listBtn");
	var schdlNo = ${schedule.schdlNo};
	
	updBtn.on("click" , function(){
		 setTimeout(function() {
			 
			var schdlName = $("#schdlName").val();
			var schdlGroup = $("#schdlGroup").val();
			var startDate = $("#datepicker").val().toString();
			var endDate = $("#datepicker1").val().toString();
			var startTime = formatTime($("#startTime").val());
			var endTime = formatTime($("#endTime").val());
			var schdlPlace = $("#schdlPlace").val();
			var schdlContent = $("#schdlContent").val();
			
			console.log("## input[name='memNo'] 요소 개수: ", $("input[name='memNo']").length);
			
			var memNosArray = $("input[name='memNo']").map(function() {
			    return $(this).val();
			}).get();
			console.log("## memNosArray: ", memNosArray);
			
			var memNameArray = $("input[name='memName']").map(function() {
			    return $(this).val();
			}).get();
			
			var deptNameArray = $("input[name='deptName']").map(function() {
			    return $(this).val();
			}).get();
			
			console.log($("#selectedAddressInputs").html());
			
			var attendList = $("input[name='memNo']").map(function() {
				return {
					memNo: $(this).val(),
			        memName: $(this).siblings("input[name='memName']").val(),
			        deptName: $(this).siblings("input[name='deptName']").val()
			    };
			}).get();
			
			console.log("## attendList : " , attendList);
			
			if (schdlName == null || schdlName == "") {
				alert("일정명을 입력해주세요!");
				return false;
			}
			
			var schedObject = {
					schdlNo : schdlNo,
					schdlName : schdlName,
					schdlGroup : schdlGroup,
					startDate : startDate,
					endDate : endDate,
					startTime : startTime,
					endTime : endTime,
					memNosArray : memNosArray,
					schdlPlace : schdlPlace,
					schdlAttendeeVO : attendList,
					schdlContent : schdlContent
			}
			
			$.ajax({
				url : "/calendar/update",
				type : "post", 	
				data : JSON.stringify(schedObject),
				contentType : "application/json; charset=utf-8",
				success : function(res) {
					console.log("## update 결과값 : " + res);
					if(res == "SUCCESS") {
						Swal.fire({
							  position: "center",
							  icon: "success",
							  title: "정상적으로 수정이 되었습니다!",
							  showConfirmButton: false,
							  timer: 1500,
							  willClose: () => {
								window.location.href="/calendar/main";							  
							  }
						});
					}else {
						Swal.fire({
							  icon: "error",
							  title: "수정에 실패하였습니다...",
							  text: "다시한번 확인해주세요",
							  timer: 3000
							});
					}
				}
			});
		 }, 100); 
	});
	
	listBtn.on("click" , function(){
		location.href = "/calendar/main";
	});
});

function formatTime(time) {
	let timeArr = time.split(":");
	if(timeArr[0].length==1){
		timeArr[0] = "0" + timeArr[0];
	}
	if(timeArr[1].length==1){
		timeArr[1] = "0" + timeArr[1];
	}
	return timeArr[0]+":"+timeArr[1]+":00";
}

/* 체크박스(비공개) 체크 시 모달 생성 */
$(function() {
    var secret = $("#scret");
    var schdlOpenValue = "Y";

    // 체크박스 상태 변경 시 동작
    secret.on("change", function() {
        var schdlGroupValue = $("#schdlGroup").val(); // schdlGroup의 값을 가져옴
        
        if ($(this).is(":checked")) {
            if (schdlGroupValue === "my") {
                schdlOpenValue = "N";
                console.log("SCHDL_OPEN 값을 'N'으로 변경했습니다.");
            } else {
                // 'my'가 아닐 경우 체크박스의 체크 상태를 원래대로 되돌림
                $(this).prop("checked", false);
                schdlOpenValue = "Y"; // 기본값으로 되돌림
                console.log("체크박스를 체크할 수 없습니다. 'my'로 설정된 경우에만 가능합니다.");
                Swal.fire({
                    title: "비공개 설정 불가",
                    html: "비공개는 참석자 그룹을<br> '나의 일정'으로선택해야 설정 가능합니다.",
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        } else {
            // 체크박스가 해제된 상태일 때
            schdlOpenValue = "Y";
            console.log("SCHDL_OPEN 값을 'Y'로 변경했습니다.");
        }
    });

    // schdlGroup 변경 시 동작
    $("#schdlGroup").on("change", function() {
        var newGroupValue = $(this).val();

        if (secret.is(":checked") && newGroupValue !== "my") {
            // 선택한 그룹이 'my'가 아닐 경우 체크박스를 해제
            secret.prop("checked", false);
            schdlOpenValue = "Y"; // 기본값으로 되돌림
            console.log("체크박스를 체크할 수 없습니다. 'my'로 설정된 경우에만 가능합니다.");
            Swal.fire({
                title: "비공개 설정 불가",
                html: "비공개는 참석자 그룹을<br> '나의 일정'으로선택해야 설정 가능합니다.",
                icon: "error",
                confirmButtonText: "확인"
            });
        }
    });
});


/* -------------------------- 주소록 가져오기 -------------------------- */

var memNo = $("#userNo").val();
console.log(memNo)

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
$('#memberList_ li').click(function () {
    $('#memberList_ li').removeClass('selected'); // 다른 선택 제거
    $(this).addClass('selected'); // 클릭한 항목 선택
});

// 결재 라인, 참조, 열람 목록에서도 항목 선택 시 하이라이트 표시
$('#approvalLine li').click(function () {
    // 각 리스트 항목에서 selected 클래스 하이라이트
    $(this).toggleClass('selected'); // 선택/해제
});

// $('#memberList_').on('click', 'li', function () {
//     $('#memberList_ li').removeClass('selected'); // 다른 선택 제거
//     $(this).addClass('selected'); // 클릭한 항목 선택
//     console.log("## Selected item:", $(this).text());
// });

// 버튼 클릭 이벤트 연결
$('.add-to-line').click(function () {
    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
    const btnId = $(this).data('btn');
    addToLine(listId, btnId);
//     if ($(this).hasClass('sidebar-btn')) {
//         // 사이드바에서 추가
//         addToLine(listId, btnId);
//     }
});

$('.remove-from-line').click(function () {
    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
    removeFromLine(listId);
//     if ($(this).hasClass('sidebar-btn')) {
//         removeFromLine(listId); // 직원 삭제
//     }
});

// 선택된 항목 강조 표시 함수
function selectItem(item) {
    item.toggleClass('selected'); // 선택/해제
}

    $('#registerBtn_').on('click',function(){
    	loadDeptAndMemData('memberList_');
    	restoreApprovalLine(); // 기존의 결재 라인 데이터를 memberList_에 복원
    	$("#inviteMemModal").modal("show");
    }); 	
    
    function restoreApprovalLine() {
    	
    	$("#selectedAddressInputs input[name='memNo']").each(function () {
            const memNo = $(this).val();
            const memName = $(this).siblings("input[name='memName']").val();
            const deptName = $(this).siblings("input[name='deptName']").val();

            // 중복 체크
            const isAlreadyAdded = $('#approvalLine .employee-item').filter(function () {
                return $(this).data('mem-no') === memNo;
            }).length > 0;

            if (!isAlreadyAdded) {
                // 중복되지 않는 경우 결재 라인에 추가
                const newItem = `
                    <li class="treeview-list-item">
                        <p class="flex-1 employee-item" 
                           data-member-name="\${memName}" 
                           data-position="\${deptName}" 
                           data-mem-no="\${memNo}">
                            <span class="me-2 text-success"></span> \${memName} (\${deptName})
                        </p>
                    </li>
                `;
                $('#approvalLine').append(newItem);
            }
        });
    }

    function loadDeptAndMemData(btn) {
        // 부서 및 직원 리스트 불러오기
        $.ajax({
            url: "/approval/approvalDeptList",
            type: "GET",
            success: function(deptResponse) {
                console.log("## deptResponse: ",deptResponse);
                updateDeptList(deptResponse,btn); // 부서 리스트 업데이트

                // 부서 리스트를 업데이트한 후에 직원 리스트를 가져옴
                $.ajax({
                    url: "/approval/approvalMemList",
                    type: "GET",
                    success: function(memResponse) {
                        console.log("## memResponse :" ,memResponse);
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
        var deptArea1 = $("#inviteMemModal").find("#memberList_");
        deptArea.empty();
        deptArea1.empty();
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
            $("#inviteMemModal").find("#memberList_").append(deptRow);		/* modal안에 memberList_<li>에 append 시킨다 */
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
            console.log("## memRow : ",memRow);
            const areaId = `#\${btn}\${mem.deptNo}`;	
            $(areaId).append(memRow); // 부서별 직원 리스트 추가
        });
    }

    // 직원 추가 기능: 직원명 클릭 시 선택
    $(document).on('click', '.employee-item', function() {
        const memberName = $(this).data('member-name'); // 클릭한 직원의 이름 가져오기
        const position = $(this).data('position'); // 클릭한 직원의 직위 가져오기

        // 현재 선택된 직원 리스트에 하이라이트 추가
        $('#memberList_ li').removeClass('selected'); // 다른 선택 제거
        $(this).closest('li').addClass('selected'); // 클릭한 직원 선택

        // 선택된 직원의 정보를 알림 또는 다른 UI 요소로 표시할 수 있음
        console.log(`Selected member: \${memberName}, Position: \${position}`);
    });
    
    
    // 더블클릭으로 memberList_ 항목을 approvalLine으로 이동
    $(document).on('dblclick', '#memberList_ .employee-item', function() {
	    const $item = $(this).closest('li'); // 항목을 복제하지 않고 직접 선택
	    const memNo = $item.find('.employee-item').data('mem-no'); // 직원의 memNo
	
	    // 결재 라인에 이미 존재하는지 확인 (memNo 기준으로 중복 체크)
	    const isAlreadyAdded = $('#approvalLine .employee-item').filter(function() {
	        return $(this).data('mem-no') === memNo; // data-mem-no 값이 일치하는지 확인
	    }).length > 0;
	    
	    if (isAlreadyAdded) {
	        alert('해당 직원은 이미 결재 라인에 추가되었습니다.'); // 이미 추가된 경우 경고
	        return; // 더 이상 진행하지 않음
	    }
	
	    // 결재 라인에 항목 추가
	    const $clonedItem = $item.clone(); // 항목 복제
	    $('#approvalLine').append($clonedItem); // 결재 라인에 추가
	    updateApprovalLineInput(); // 결재 라인 정보 업데이트
	});

    // approvalLine 항목을 더블클릭 시 원래 memberList_로 이동
    $(document).on('dblclick', '#approvalLine .employee-item', function() {
        const $item = $(this).closest('li').clone(); // 항목을 복제하여 이동
        const originalDeptId = $(this).data('original-dept-id');
        
     	// 원래 deptList로 항목을 이동
        if (originalDeptId) {
            const originalDeptList = $(`#deptList_${originalDeptId}`); // deptList 찾기
            originalDeptList.append($item); // 해당 deptList에 항목 추가
        }
        
        $(this).closest('li').remove(); // approvalLine에서 제거
        updateApprovalLineInput();
    });

    // 결재 라인 정보 업데이트
    function updateApprovalLineInput() {
        const approvalLineData = [];
        $('#approvalLine li').each(function() {
        	const memNo = $(this).find('.employee-item').data('mem-no');
        	
        	if (!approvalLineData.includes(memNo)) {
                approvalLineData.push(memNo);
                $("#selectedAddressInputs").append(`
                    <input type="hidden" name="memNo" value="\${memNo}">
                `);
            }
        });
        	
//         	const memName = $(this).find('.employee-item').data('member-name');
//             const deptName = $(this).find('.employee-item').data('position');
        
//         	 // 중복 확인
//             const isAlreadyInSelected = $('#selectedAddressInputs input[name="memNo"]').filter(function() {
//                 return $(this).val() === String(memNo);
//             }).length > 0;

//             if (!isAlreadyInSelected) {
//                 // 새로운 항목만 추가
//                 approvalLineData.push(String(memNo));

//                 $("#selectedAddressInputs").append(`
//                     <input type="hidden" name="memNo" value="\${memNo}">
//                     <input type="hidden" name="memName" value="\${memName}">
//                     <input type="hidden" name="deptName" value="\${deptName}">
//                 `);
//             }
//         });
        $('#approvalLineInput').val(approvalLineData.join(','));
    }
    
    $(document).on('click', '.remove-from-line', function() {
        // approvalLine을 비우고 원래 상태로 복원
        const listId = $(this).data('list'); // approvalLine의 데이터

        // approvalLine에서 모든 항목 제거
        $(`#\${listId}`).empty(); // #approvalLine의 모든 항목을 비움

   		// #memberList_로 복원: 각 부서별로 복원할 항목들을 찾아서 복원
        $('#approvalLine .employee-item').each(function() {
            const memNo = $(this).data('mem-no'); // 직원의 memNo
            const deptNo = $(this).data('dept-no'); // 직원이 속한 부서 번호

            // 직원의 부서 리스트를 찾기 위해 부서 번호에 맞는 ul 선택
            const targetDeptList = $(`#memberList_ #\${listId}\${deptNo}`);

            if (targetDeptList.length) {
                // 해당 부서 목록에 직원 항목을 복원
                const memRow = $(this).clone(); // 직원 항목을 복제
                targetDeptList.append(memRow); // 복제한 항목을 해당 부서 리스트에 추가
            }
        });

        // 필요 시 입력값을 초기화할 수 있음
        $('#approvalLineInput').val(''); // input 필드 초기화
        updateApprovalLineInput(); // 결재 라인 정보 업데이트
    });
    
 	// 결재 작성 버튼 클릭 이벤트
     $('#registerApprBtn').click(function() {
    	updateApprovalLineInput();
    	
	    const formNo = $('#formNo').val();
	    let approvalLine = $('#approvalLineInput').val();
	
// 	    approvalLine += $("#userNo").val()
	    
	    console.log("결재라인:" + approvalLine);
		
		$('#selectMember').val(approvalLine); /*memNo값을 value값으로....  */
		console.log("selectMember 값:", $('#selectMember').val());
		const selectMember = $('#selectMember').val().split(',').filter(Boolean);
		console.log("AJAX 전송할 멤버 리스트:", selectMember);
		
		$.ajax({	
			url : '/calendar/attendMember',
			type : 'POST',
			data : JSON.stringify({memList : selectMember}),
			contentType : 'application/json; charset=UTF-8',
			success : function(res) {
				console.log("## res : " , res);
				
				memNos = res;
				
				let names = '';  // names 변수를 초기화
				let inputFields= '';
				
				res.forEach(function(event, index) {
		            console.log("## memName : ", event.memName);
		            console.log("## deptName : ", event.deptName);
		            console.log("## memNo : ", event.memNo);
		            
		            names += `<span class="fas fa-user-circle" style="font-size: 20px; margin-right: 5px;"></span> \${event.memName} (\${event.deptName}) &nbsp;&nbsp;`;
					
		            inputFields += `
		            		<input type="hidden" name="memNo" value="\${event.memNo}">
		            		<input type="hidden" name="memName" value="\${event.memName}">
		            	    <input type="hidden" name="deptName" value="\${event.deptName}">
		            		`;

					if ((index + 1) % 4 === 0) {
		                names += '<br>'; // 4명마다 줄바꿈
		            }
					
					
		        });
				$("#selectedAddressName").html(names.trim());		/* HTML에 아이콘 출력 - append이후 html을 쓰면 기존의 내용을 모두 지우고 새로운 내용을 삽입함 (중복을 피함) */
				console.log($("#selectedAddressName").html());
				
				$("#selectedAddressInputs").html(inputFields);
			}
		});
	});

</script>