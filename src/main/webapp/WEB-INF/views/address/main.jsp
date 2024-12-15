<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.input-container {
    display: flex; /* flexbox 사용 */
    align-items: center; /* 수직 가운데 정렬 */
    margin-top: 10px;
}

.input-container input {
    flex-grow: 1; /* input이 가용 공간을 차지하도록 설정 */
    margin-right: 10px; /* input과 버튼 사이의 간격 설정 */
}
    
.dropend .dropdown-menu {
	display: none;
	position: absolute;
	top: 0;
	left: 100%;
	margin-top: -1px;
}
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/list.js/2.3.1/list.min.js"></script>
<div class="d-flex flex-column w-100 p-3">
	<input type="hidden" id="addId" value="${address}">
	<h3 id="displayArea" style="margin-top: 10px; margin-left: 20px;"></h3><!-- 주소록 명 -->
	<div class="d-flex flex-row justify-content-between align-items-center p-2">
		<div class="d-flex d-gid gap-2 flex-row align-items-center">
			<div class="d-flex d-gid gap-2 flex-row align-items-center">
				<a class="btn p-1" style="box-shadow: none" id="quickRegister"> 
					<span>
						<span class="fas fa-forward me-1"></span>
					</span> <span>빠른등록</span>
				</a>
				<a class="btn p-1" style="box-shadow: none" id="quickRegister"> 
					<span>
						<i class="bi bi-envelope"></i>
					</span> <span>메일발송</span>
				</a>
				<a class="btn p-1" style="box-shadow: none" id="deleteButton"> 
					<span>
						<i class="bi bi-trash"></i>
					</span> <span>삭제</span>
				</a>
				<div class="FnBtn btn-group disabled">
				  	<button class="btn dropdown-toggle" style="box-shadow: none" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">이동</button>
				  	<div class="dropdown-menu">
					  	<a class="dropdown-item" href="#" onclick="moveInbox()">중요주소록</a>
					  	<a class="dropdown-item" href="#" onclick="deleteMail()">외부주소록</a>
	   					<div class="dropdown-divider"></div>
	   					<div id="mailBoxDropdown" class="d-flex flex-column justify-content-center">
	   						
	   					</div>
				  	</div>
				</div>	
			</div>
		</div>
		<div>
			<form class="search-box align-middle" action="/mail/mailbox/${pagingVO.keyword}" method="get">
			    <div class="position-relative">
			        <input class="form-control search-input" type="text" value="${searchWord }" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/>
			        <span class="fas fa-search search-box-icon"></span>
			    </div>
			</form>
		</div>
	</div>
	
	<div id="inputFields" style="margin-top: 10px;"></div>
	
	<div id="tableExample2" data-list='{"valueNames":["name","position","phone","email","depart","deptTel","memo"],"page":10,"pagination":true}'>
		<div class="table-responsive scrollbar" style="height: 540px">
			<table class="table table-bordered fs-9 mb-0">
	    		<colgroup>
	    			<col width="5%">
	    			<col width="10%">
	    			<col width="10%">
	    			<col width="15%">
	    			<col width="15%">
	    			<col width="10%">
	    			<col width="10%">
	    			<col width="25%">
	    		</colgroup>
				<thead class="bg-200">
					<tr>
			            <th class="text-900 text-center align-middle p-0"><input type='checkbox' id='checkAll' class='form-check-input'> 전체 </th>
			            <th class="text-900 sort text-center align-middle" data-sort="name" style="width: 9%">이름</th>
			            <th class="text-900 sort text-center align-middle" data-sort="position" style="width: 8%">직위</th>
			            <th class="text-900 sort text-center align-middle" data-sort="phone" style="width: 12% white-space: nowrap;">휴대폰</th>
			            <th class="text-900 sort text-center align-middle" data-sort="email" style="width: 12% white-space: nowrap;">이메일</th>
			            <th class="text-900 sort text-center align-middle" data-sort="depart" style="width: 12% white-space: nowrap;">부서</th>
			            <th class="text-900 sort text-center align-middle" data-sort="deptTel" style="width: 10%">회사</th>
			            <th class="text-900 sort text-center align-middle" data-sort="memo" style="width: 8%">메모</th>
					</tr>
				</thead>
		    	<tbody class="list" id="addrList">
		    		<tr>
		    			<td></td>
		    			<td></td>
		    			<td></td>
		    			<td></td>
		    			<td></td>
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
	
<script type="text/javascript">

$(function() {
    $("#deleteButton").hide(); // 페이지 로드 시 삭제 버튼 숨기기
    $("#move2").hide();
    $("#move1").show();

    // .importAddress 클릭 시 이벤트 처리
    $(document).on("click", "#importAddress", "#externalAddress", function(e) {
        e.stopPropagation(); // 이벤트 전파 방지
        // 모든 .importAddress에서 active 클래스 제거
        $(".importAddress").removeClass("active");
        $(".externalAddress").removeClass("active");

        // 현재 클릭한 .importAddress에 active 클래스 추가
        $(this).addClass("active");

        // 삭제 버튼 보이기
        $("#deleteButton").show();
        $("#move2").show();
        $("#move1").hide();
    });

    // .deptList, #allAddress, #myGroupAddress 클릭 시 삭제 버튼 숨기기
    $(document).on("click", ".deptList, #allAddress, #myGroupAddress", function() {
        $(".importAddress").removeClass("active"); // 모든 .importAddress에서 active 클래스 제거
        $(".externalAddress").removeClass("active"); 
        $("#deleteButton").hide(); // 삭제 버튼 숨기기
        $("#move2").hide();
        $("#move1").show();
    });
});


/* ---------------- 빠른 등록 ---------------- */
$(function() {
    $('#quickRegister').on('click', function(e) {
        e.preventDefault();  // 기본 동작인 링크 이동을 막습니다.

        // 입력 필드가 이미 추가되었는지 확인
        if ($('#inputFields').is(':empty')) {
            // 동적으로 입력 필드 추가
            var inputFields = `
            	<a style="margin-right: 20px;"></a>
                <input type="text" placeholder="이름(표시명)">
                <input type="text" placeholder="휴대폰" style="margin-right: 10px;">
                <span class="fas fa-address-book" id="addressIcon" style="display: none; margin-right: 10px; font-size: 22px;"></span><p id="selectedAddressName" name="abName" style="display: inline; margin: 0;"></p>
				<input type="hidden" id="selectedAddressNo" name="abNo">			
                <input type="button" class="btn btn-info" id="submitButton" value="등록"/>
                <select>
                	<option>외부 주소록</option>
                </select>
            	<div class="dropdown-menu">
	            <div class="dropend">
		            <a class="dropdown-item dropdown-toggle" href="#" id="dropdownMenuLink" role="button" aria-expanded="false">
		            	외부주소록
		            </a>
		            	<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						    <c:choose>
						        <c:when test="\${empty address}">
						            <span class="dropdown-item" href="#">비어있음</span>
						        </c:when>
						        <c:otherwise>
						            <c:set var="hasImportant" value="false" />
						            <c:forEach var="addr" items="\${address}">
						                <c:if test="\${addr.abGb == '외부'}">
						                    <a class="dropdown-item addr-item" href="#" data-ab-name="\${addr.abName}" data-ab-no="\${addr.abNo}">${addr.abName}</a>
						                    <c:set var="hasImportant" value="true" />
						                </c:if>
						            </c:forEach>
						            <c:if test="\${!hasImportant}">
						                <span class="dropdown-item" href="#">비어있음</span>
						            </c:if>
						        </c:otherwise>
						    </c:choose>
						</ul>
					</div>
				</div>
            `;

            $('#inputFields').html(inputFields);  // 입력 필드들을 지정된 div에 추가
        }
        
        $(document).on('click', '#submitButton', function() {
            // 입력 필드 값 가져오기
            var name = $('#nameField').val();
            var phone = $('#phoneField').val();

            // 데이터 객체 생성
            var data = {
                conName: name,
                conTel: phone
            };

            // AJAX 요청
            $.ajax({
                url: '/address/addExContact',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(data), // 데이터를 JSON 형식으로 변환
                success: function(response) {
                    console.log("서버로부터 응답:", response);
                    // 성공 시 추가 작업 (예: 알림, 입력 필드 초기화 등)
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("AJAX 요청 실패:", textStatus, errorThrown);
                    // 오류 처리
                }
            });
        });

        // 입력 필드를 보이거나 숨깁니다.
        $('#inputFields').toggle();
    });
});
/* -------------------- .dropend(오른쪽으로 메뉴 확장) -------------------- */
$(document).ready(function() {
    // '중요 연락처'에 마우스를 올리면 오른쪽으로 확장되는 dropend가 열리도록 설정
    $('.dropend').on('mouseenter', function() {
        $(this).find('.dropdown-menu').css({
            display: 'block',  // 드롭다운 메뉴를 표시
            position: 'absolute',
            top: 0,
            left: '100%',  // 오른쪽으로 드롭다운 확장
            marginTop: '-1px',
        });
    }).on('mouseleave', function() {
        $(this).find('.dropdown-menu').css('display', 'none');  // 마우스가 벗어나면 서브메뉴를 숨김
    });
});

/* ---------------------- 체크박스 클릭 이벤트 ---------------------- */
$(document).ready(function() {
    // 전체 체크박스 클릭 이벤트
    $('#checkAll').on('click', function() {
        var isChecked = $(this).is(':checked');
        $('.form-check-input[type="checkbox"]').prop('checked', isChecked);

        // 체크된 항목의 데이터를 수집
        if (isChecked) {
            collectCheckedData1();
        } else {
            console.log("전체 체크박스 해제됨");
        }
    });

    // 개별 체크박스 클릭 이벤트
    $(document).on('click', '.form-check-input:not(#checkAll)', function() {
        if (!$(this).is(':checked')) {
            $('#checkAll').prop('checked', false);
        } else {
            var allChecked = $('.form-check-input[type="checkbox"]').not('#checkAll').length === $('.form-check-input[type="checkbox"]:checked').not('#checkAll').length;
            $('#checkAll').prop('checked', allChecked);
        }
        collectCheckedData1();
    });

    // 드롭다운 항목 클릭 이벤트 (이동1 insert)
    $(document).on('click', '.addr-item', function(e) {
        e.preventDefault();
        let selectedAbName = $(this).data('ab-name');
        let abNo = $(this).data('ab-no');
        let checkedData = collectCheckedData1();
        console.log("선택된 연락처:", selectedAbName);
        console.log("## checkedData:", checkedData);

        // 체크된 데이터 수집 및 AJAX 요청
        let checkedData1 = {
        		abNo: abNo,
        		checkedData: checkedData
        }
        console.log("## JSON형식으로... ",checkedData1);
        
        if (checkedData.length > 0) {
            Swal.fire({
                title: "중요 주소록에 등록하시겠습니까?",
                text: `선택된 항목 "\${selectedAbName}" 에서 목록을 확인할 수 있습니다.`,
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "네, 등록하겠습니다!",
                cancelButtonText: "아니요, 취소할게요."
            }).then((result) => {
                if (result.isConfirmed) {
                	
                    // 등록 확인 후에 AJAX 요청을 보냄
                    $.ajax({
                        url: '/address/moveAddress',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(checkedData1),
                        success: function(response) {
                            Swal.fire({
                                title: "등록 완료!",
                                text: "주소록에 성공적으로 등록되었습니다.",
                                icon: "success"
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // SweetAlert2가 닫힌 후 리디렉션
                                    window.location.href = "/address/main"; // 여기에 이동할 URL을 입력하세요
                                }
                            });
                            console.log("주소록에 등록 성공:", response);
                        },
                        error: function(error) {
                            Swal.fire({
                                title: "오류 발생!",
                                text: "등록 중 오류가 발생했습니다.",
                                icon: "error"
                            });
                            console.error("주소록 등록 실패:", error);
                        }
                    });
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire({
                        title: "취소되었습니다.",
                        text: "등록이 취소되었습니다.",
                        icon: "error"
                    });
                }
            });
        }
    });

   
    // 선택된 체크박스의 데이터를 수집하는 함수
    function collectCheckedData1() {
        let checkedData = [];
        var addId = $("#addId").val()
		console.log(addId);
        
        // 체크된 체크박스들만 순회
        $('.form-check-input[type="checkbox"]:checked:not(#checkAll)').each(function() {
            var $row = $(this).closest('tr'); // 체크박스의 부모 tr 찾기
          	console.log("선택",$(this).closest('tr').data("no"));
            
            // tr 요소가 존재하는지 확인
            if ($row.length > 0) {
                // 데이터 가져오기
                var memNo = $row.data("from"); 
                var memName = $row.find('td[data-sort="name"]').text().trim(); // 이름
                var posName = $row.find('td[data-sort="position"]').text().trim(); // 직위
                var memTel = $row.find('td[data-sort="phone"]').text().trim(); // 전화번호
                var memEmail = $row.find('td[data-sort="email"]').text().trim(); // 이메일
                var deptName = $row.find('td[data-sort="depart"]').text().trim(); // 부서명

                /* memNo가 undifind인 애들이 나와서 값이 있는 애들만 선별 */
                if (memNo) {
                    checkedData.push({
                    	memNo: memNo,
                        memName: memName,
                        posName: posName,
                        memTel: memTel,
                        memEmail: memEmail,
                        deptName: deptName
                    });
                }
            }
        });
        console.log("선택된 데이터:", checkedData);
        return checkedData; // 수집한 데이터를 반환
    }
    
    
    function collectCheckedData2() {
    	let checkedData = [];

        // 체크된 체크박스들만 순회
        $('.form-check-input1[type="checkbox"]:checked:not(#checkAll)').each(function() {
            var $row = $(this).closest('tr'); // 체크박스의 부모 tr 찾기

            // tr 요소가 존재하는지 확인
            if ($row.length > 0) {
                // 데이터 가져오기
                var memNo = $row.data("from"); // memNo or abNo
                var conNo = $row.data("no"); // data-no (conNo)
                var conName = $row.find('td[data-sort="conName"]').text().trim(); // 이름
                var conPos = $row.find('td[data-sort="conPosition"]').text().trim(); // 직위
                var conTel = $row.find('td[data-sort="conPhone"]').text().trim(); // 전화번호
                var conEmail = $row.find('td[data-sort="conEmail"]').text().trim(); // 이메일
                var conDept = $row.find('td[data-sort="conDepart"]').text().trim(); // 부서명
                var conCom = $row.find('td[data-sort="conCompany"]').text().trim(); // 회사명
                var conMemo = $row.find('td[data-sort="conMemo"]').text().trim(); // 회사명

                /* memNo가 undifind인 애들이 나와서 값이 있는 애들만 선별 */
                if (memNo) {
                    checkedData.push({
                    	memNo: memNo,
                        conNo: conNo,
                        conName: conName,
                        conPos: conPos,
                        conTel: conTel,
                        conEmail: conEmail,
                        conDept: conDept,
                        conCom: conCom,
                        conMemo: conMemo
                    });
                }
            }
        });
        
        console.log("## 선택된 데이터:", checkedData);
        return checkedData;
    }

    /* ---------------------- 삭제 버튼 이벤트 ------------------------ */

    $("#deleteButton").on('click', function() {
        // 선택된 데이터 수집
        let checkedData = collectCheckedData2();
        
        let checkedObjects = checkedData.map(data => ({
            abNo: data.abNo,
            conNo: data.conNo,
            conName: data.conName,
            conPos: data.conPos,
            conTel: data.conTel,
            conEmail: data.conEmail,
            conDept: data.conDept,
            conCom: data.conCom,
            conMemo: data.conMemo
        }));
        console.log("## checkedObjects : " , checkedObjects);

        if (checkedData.length > 0) {
            // 확인 메시지 표시
            Swal.fire({
                title: "선택된 항목을 삭제하시겠습니까?",
                text: "삭제 후에는 복구할 수 없습니다.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "네, 삭제하겠습니다!",
                cancelButtonText: "아니요, 취소할게요."
            }).then((result) => {
                if (result.isConfirmed) {
                    // AJAX 요청을 통해 선택된 데이터 삭제
                    $.ajax({
                        url: '/address/deleteChecked',  // 서버의 삭제 경로 설정
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(checkedObjects),  // 선택된 데이터 전송
                        success: function(response) {
                            Swal.fire({
                                title: "삭제 완료!",
                                text: "선택된 항목이 성공적으로 삭제되었습니다.",
                                icon: "success"
                            }).then(() => {
                                // 삭제 성공 후 페이지 새로고침
                                location.reload();
                            });
                        },
                        error: function(error) {
                            Swal.fire({
                                title: "오류 발생!",
                                text: "삭제 중 오류가 발생했습니다.",
                                icon: "error"
                            });
                            console.error("삭제 실패:", error);
                        }
                    });
                }
            });
        } else {
            Swal.fire({
                title: "선택된 항목 없음",
                text: "삭제할 항목을 선택해 주세요.",
                icon: "info"
            });
        }
    });
});



</script>
</html>
