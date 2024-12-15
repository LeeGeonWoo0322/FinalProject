<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.exAddress:hover {
	background: #F7F7F7;
}
</style>
<div class="navbar-vertical-content h-100 border-end border-end-1 position-relative" style="width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">주소록</h4>
		</div>
			<div style="text-align: center;">
			<a class="btn border-dark me-1 mb-1 px-5 py-2" href="/address/addContact?memNo=${member.memNo}" style="font-size: 15px">외부연락처 추가</a>
		</div>
	</div>
 <!-- 사이드 메뉴 (content 영역에만 포함되는 사이드바) -->
    <div class="p-3 position-relative" id="sidebar-content">
    	<ul class="mb-0 treeview" id="treeviewExample">
    		<li class="treeview-list-item">
					<p class="treeview-text">
					    <sec:authentication property="principal.member" var="user"/> 
					    <a data-bs-toggle="collapse" href="#treeviewExample-1-2" role="button" aria-expanded="false" id="allAddress" value="전사 주소록">
					    	<span style="color: black; font-weight: 500; font-size: 15px">전사 주소록</span>
					    </a>
					   <ul class="collapse treeview-list ps-1" id="groupAddress" data-show="true">
							<!-- 그룹 연락처 동적 쿼리 -->
						</ul>
					</p>
				</li>
          	<ul class="mb-0 treeview position-relative" id="treeviewExample">
	          	<li class="treeview-list-item">
					<p class="treeview-text">
						<a data-bs-toggle="collapse" href="#" role="button" id="myGroupAddress" value="그룹 주소록" aria-expanded="false"> 
							<span style="color: black; font-weight: 500; font-size: 15px">그룹 주소록</span>
						</a>
					</p>
	          	</li>
				<!-- ------------------------ 중요 주소록 --------------------------- -->
				<li class="treeview-list-item">
					<p class="treeview-text">
						<a data-bs-toggle="collapse" href="#" role="button" aria-expanded="false" id="importAddress" value="중요 주소록"> 
							<span style="color: black; font-weight: 500; font-size: 15px">중요 주소록</span>
						</a>
					</p>
				</li>
				<!-- ------------------------ 외부 주소록 --------------------------- -->
				<li class="treeview-list-item">
					<p class="treeview-text">
						<a data-bs-toggle="collapse" href="#" role="button" aria-expanded="false"> 
							<span style="color: black; font-weight: 500; font-size: 15px">외부 주소록</span>
						</a>
					</p>
					<ul class="collapse treeview-list ps-1" data-show="true">
						<c:forEach var="addr" items="${address}">  <!-- address는 로그인정보(memNo)에 해당하는 주소록(AddressVO)를 가져옴 -->
				            <li class="treeview-list-item">
				                <div class="treeview-item" style="display: flex; justify-content: space-between; align-items: center;">
								    <c:if test="${addr.abGb == '외부'}">
								    <p class="treeview-text" style="flex: 1;">
									        <a class="mailList flex-1 externalAddress" id="externalAddress" href="#" data-ab-no="${addr.abNo }" value="외부 주소록 (${addr.abName})">
									            <span style="height: 20px;">${addr.abName}</span>
									        </a>
								    </p>
								    <span class="fas fa-pencil-alt" style="opacity: 0.5;" id="addressModify" data-abname="${addr.abName}" data-abno="${addr.abNo}"></span>		<!-- opacity: 0.5; 투명도 50% 설정 -->
								    <span style="margin-left: 10px; opacity: 0.7;" id="addressDel" data-abname="${addr.abName}" data-abno="${addr.abNo}">  <!-- data-abname="${addr.abName}" 속성을 추가 -->
								        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
								            <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
								        </svg>
								    </span>
									</c:if>
								</div>
				            </li>
				        </c:forEach>
					</ul>
				</li>
				<li class="treeview-list-item">
					<div class="treeview-item">
						<p class="treeview-text mb-2">
							<a class="flex-1" href="#" id="addAddress"> <span class="me-1" data-feather="plus" style="width: 15px; height: 15px"></span>
								주소록 추가
							</a>
						</p>
					</div>
				</li>
          	</ul>
		</ul>
	</div>
</div>	
	
<!-- =================== 모달 창 등록 ======================= -->

<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventModalLabel">주소록 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
              	<input type="hidden" name="memNo" id="memModalNo" value="${member.memNo }" />
          		<div class="modal-body">
          			<table class="table table-borderless">
          				<tbody>
                           <tr>
                           	<td style="width: 3ㄴ0%;">주소록 이름</td>
                           	<td>
                           		<input type="text" class="form-control datepicker-input" id="abModalNameAdd" name="abName" value="" >  <!-- value 부분이 문제였음 (address => addr) -->
                           	</td>
                           </tr>
                           <tr>
                           	<td>주소록 선택</td>
                           	<td>
                           		<select id="abModalGb" name="abGb" class="form-select" aria-label="Default select example">
									<option value="외부">외부연락처</option>
								</select>
                           	</td>
                           </tr>
                      </tbody>
               	</table>
                   <input type="hidden" id="eventStart">
                   <input type="hidden" id="eventEnd">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="saveEventBtn">저장</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- =================== 모달 창 수정 ======================= -->

<div class="modal fade" id="eventModal1" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventModalLabel">주소록 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
              	<input type="hidden" name="memNo" id="memModalNo" value="${member.memNo }" />
          		<div class="modal-body">
          			<table class="table table-borderless">
          				<tbody>
                           <tr>
                           	<td style="width: 30%;">주소록 이름</td>
                           	<td>
                           		<input type="text" class="form-control datepicker-input" id="abModalNameUpt" name="abName" value="" >  <!-- value 부분이 문제였음 (address => addr) -->
                           	</td>
                           </tr>
                           <tr>
                           	<td>주소록 선택</td>
                           	<td>
                           		<select id="abModalGb" name="abGb" class="form-select" aria-label="Default select example">
									<option value="외부">외부연락처</option>
								</select>
                           	</td>
                           </tr>
                      </tbody>
               	</table>
                   <input type="hidden" id="eventStart">
                   <input type="hidden" id="eventEnd">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="saveEventBtn1">수정</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

/* ------------------------------ 그룹 주소록 메뉴 항목 만듬 (dept별로) ------------------------------ */
var memNo;

$(function(){
	$.ajax({
		url : '/address/deptList',
		type : 'GET',
		success: function(data) {
			
			memNo = data.memNo;
			var deptList = data.deptList;
			
            var groupAddress = $('#groupAddress');
            groupAddress.empty();  // 기존 내용을 비웁니다

            for (let i = 0; i < deptList.length; i++) {
                let dept = deptList[i];  // 각 부서 정보

                let liItem = `
                    <li class="treeview-list-item">
                        <div class="treeview-item">
                            <p class="treeview-text">
                                <a class="deptList flex-1" href="#" id="\${dept.deptNo}" value="\${dept.deptNo}팀  \${dept.deptName}">
                                    <span style="height: 20px">\${dept.deptNo}팀  \${dept.deptName}</span>
                                </a>
                            </p>
                        </div>
                    </li>`;
                // <ul>에 <li> 요소 추가
                groupAddress.append(liItem);
            }
        }
	});
});


/* ------------------------------ 전사 주소록  시작 ------------------------------ */
$(function() {
    var allAddress = $("#allAddress");

    // allAddress 버튼 클릭 이벤트 핸들러
    allAddress.on("click", function() {
        $('#displayArea').empty();
        var value = $(this).attr("value");
        $("#displayArea").text(value);
        
        let memNo = ${member.memNo};
        var requestData = { memNo: memNo };
        
        $.ajax({
            url: '/address/allAddress',
            type: 'POST',
            data: JSON.stringify(requestData),
            contentType: 'application/json; charset=utf-8',
            success: function(data) {
                // addrList tbody의 이전 데이터를 비움
                $('#addrList').empty();
                console.log("## 모든 주소록이 넘어오나요???", data);
                for (let i = 0; i < data.length; i++) {

                	let myGroupAddress = data[i];
                        
                    let starIcon = (myGroupAddress.importYn && myGroupAddress.importYn.toUpperCase() === 'Y')
               			? `<i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i>`
               			: `<i class="bi bi-star"></i>`
                    
                    let row = `
                        <tr data-no="\${data[i].abNo}" data-read="" data-imp="" data-from="\${data[i].memNo}">
                            <td class="d-flex flex-row justify-content-between align-middle px-2" style="border-right:none">
                                <span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
                                <span class='favIcon me-1 text-center'>\${starIcon}</span>
                            </td>
                            <td class="title align-middle text-center" data-sort="name">\${data[i].memName || ''}</td>
                            <td class="date align-middle text-center" data-sort="position">\${data[i].posName || ''}</td>
                            <td class="size align-middle text-center" data-sort="phone">\${data[i].memTel || ''}</td>
                            <td class="size align-middle" data-sort="email">\${data[i].memEmail || ''}</td>
                            <td class="size align-middle text-center" data-sort="depart">\${data[i].deptName || ''}</td>
                            <td class="size align-middle text-center" data-sort="company">대덕(본사)</td>
                            <td class="size align-middle" data-sort="memo"></td>
                        </tr>`;
                    
                    // 새 행을 addrList tbody에 추가
                    $('#addrList').append(row);
                }
                /* 페이징 처리 ..... */
                var options = {
                	    valueNames: ['name', 'position', 'phone', 'email', 'depart', 'deptTel', 'memo'],
                	    page: 10,
                	    pagination: true
                	};

                var userList = new List('tableExample2', options);
            }
        });
    });

    // 페이지 로드 시 allAddress 클릭 이벤트 트리거
    allAddress.trigger('click');
});



/* ------------------------------ 내 그룹 주소록  시작 ------------------------------ */
$(function(){
	var myGroupAddress = $("#myGroupAddress");
	
	var deptNo = ${member.deptNo};
	
	var deptNoObject = {
			deptNo : deptNo
	}
	
	myGroupAddress.on("click" , function(){
		$('#displayArea').empty();
		var value = $(this).attr("value");
		
		$("#displayArea").text(value);
		$.ajax({
			url : '/address/myGroupAddress',
			type : 'POST',
			data : JSON.stringify(deptNoObject),
			contentType : 'application/json; charset=utf-8',
			success: function(data){
				$('#addrList').empty();  // tbody 비우기

			    for (let i = 0; i < data.length; i++) {
			        let myGroupAddress = data[i];

			        let row = `
			            <tr data-no="\${myGroupAddress.abNo}" data-read="" data-imp="" data-from="\${myGroupAddress.memNo}">
			                <td class="d-flex flex-row justify-content-center align-middle px-2" style="border-right:none">
			                    <span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
			                </td>
			                <td class="title align-middle text-center" data-sort="name">\${myGroupAddress.memName}</td>
			                <td class="date align-middle text-center" data-sort="position">\${myGroupAddress.posName}</td>
			                <td class="size align-middle text-center" data-sort="phone">\${myGroupAddress.memTel}</td>
			                <td class="size align-middle" data-sort="email">\${myGroupAddress.memEmail}</td>
			                <td class="size align-middle text-center" data-sort="depart">\${myGroupAddress.deptName}</td>
			                <td class="size align-middle text-center" data-sort="company">대덕(본사)</td>
			                <td class="size align-middle" data-sort="memo"></td>
			            </tr>`;

			        // tbody에 row 추가
			        $('#addrList').append(row);
				}
                /* 페이징 처리 ..... */
                var options = {
                	    valueNames: ['name', 'position', 'phone', 'email', 'depart', 'deptTel', 'memo'],
                	    page: 10,
                	    pagination: true
                	};

                var userList = new List('tableExample2', options);
			}
		});
	});
});

/* --------------- 그룹 별로 동적 쿼리로 출력 ------------------- */
 

$(function(){
    // 동적으로 생성된 요소에 이벤트 위임을 사용합니다.
    $(document).on("click", ".deptList", function(e){
        e.preventDefault();  // 기본 링크 동작을 막습니다.

        var deptNo = $(this).attr('id');  // 클릭한 요소의 id (부서번호) 가져오기
        var depNoObject = { deptNo: deptNo, memNo: memNo };
        
        $('#displayArea').empty();
		var value = $(this).attr("value");
		
		$("#displayArea").text(value);
        console.log("## 클릭한 부서 번호:", deptNo);

        $.ajax({
            url : '/address/groupAddress',
            type: 'POST',
            data: JSON.stringify(depNoObject),
            contentType : 'application/json; charset=utf-8',
            success: function(data) {
            	$('#addrList').empty();  // tbody 비우기
            	
                console.log("## 부서별 import 되서 나오나?" , data);
			    
            	for (let i = 0; i < data.length; i++) {
			        let myGroupAddress = data[i];
			        
	            	let starIcon = (myGroupAddress.importYn && myGroupAddress.importYn.toUpperCase() === 'Y')
		                ? `<i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i>`
		                : `<i class="bi bi-star"></i>`
                
			        let row = `
			            <tr data-no="\${myGroupAddress.abNo}" data-con-no="\${myGroupAddress.conNo}" data-read="" data-imp="" data-from="\${myGroupAddress.memNo}">
			                <td class="d-flex flex-row justify-content-between align-middle px-2" style="border-right:none">
			                    <span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
			                    <span class='favIcon me-1 text-center'>\${starIcon}</span>
			                </td>
			                <td class="title align-middle text-center" data-sort="name">\${myGroupAddress.memName}</td>
			                <td class="date align-middle text-center" data-sort="position">\${myGroupAddress.posName}</td>
			                <td class="size align-middle text-center" data-sort="phone">\${myGroupAddress.memTel}</td>
			                <td class="size align-middle" data-sort="email">\${myGroupAddress.memEmail}</td>
			                <td class="size align-middle text-center" data-sort="depart">\${myGroupAddress.deptName}</td>
			                <td class="size align-middle text-center" data-sort="company">대덕(본사)</td>
			                <td class="size align-middle" data-sort="memo"></td>
			            </tr>`;

			        // tbody에 row 추가
			        $('#addrList').append(row);
				}
                var options = {
                	    valueNames: ['name', 'position', 'phone', 'email', 'depart', 'deptTel', 'memo'],
                	    page: 10,
                	    pagination: true
                	};

                var userList = new List('tableExample2', options);
			}
        });
    });
    
    
    
    function collectionStar() {
        let starredItems = [];  // 별이 채워진 항목을 저장할 배열

        $(".bi-star-fill").each(function() {
            let $row = $(this).closest("tr");
            starredItems.push({
                abNo: $row.data("no"),  // abNo 데이터 가져오기
                memNo: $row.data("from"),
                memName: $row.find("[data-sort='name']").text(),
                deptName: $row.find("[data-sort='depart']").text(),
                posName: $row.find("[data-sort='position']").text(),
                memTel: $row.find("[data-sort='phone']").text(),
                memEmail: $row.find("[data-sort='email']").text()
            });
        });

        return starredItems;
    }

    
 	// 즐겨찾기 아이콘 클릭 이벤트 (전사 즐겨찾기)
    $(document).on("click", ".favIcon", function() {
        var $icon = $(this).find("i");
        var memNo = $(this).closest("tr").data("from");  // memNo 가져오기
        var abNo = $(this).closest("tr").data("no");     // abNo 가져오기
        var conNo = $(this).closest("tr").data("con-no");     // conNo 가져오기
        
        // 아이콘이 채워진 별로 바뀔 경우 insert, 빈 별일 경우 delete 수행
        if ($icon.hasClass("bi-star")) {
            // 채워진 별로 변경하여 insert 수행
            $icon.removeClass("bi-star").addClass("bi-star-fill").css("color", "orange");
            
            // insert할 데이터 객체 생성
            var insertData = {
                abNo: abNo,
                favorites: collectionStar()
            };

            $.ajax({
                url: '/address/favorites',
                type: 'POST',
                data: JSON.stringify(insertData),
                contentType: 'application/json; charset=utf-8',
                success: function(response) {
                    console.log("데이터가 성공적으로 추가되었습니다." , response);
                },
                error: function(xhr, status, error) {
                    console.error("추가에 실패했습니다.", error);
                }
            });
        } else {
            // 빈 별로 변경하여 delete 수행
            $icon.removeClass("bi-star-fill").addClass("bi-star").css("color", "");


            // delete할 데이터 생성
            var deleteData = [ { conNo: conNo } ];  // 삭제할 conNo 목록
            
           	console.log("## delete :", deleteData);
            
            $.ajax({
                url: '/address/delFavorites',
                type: 'POST',
                data: JSON.stringify(deleteData),
                contentType: 'application/json; charset=utf-8',
                success: function(response) {
                    console.log("데이터가 성공적으로 삭제되었습니다.");
                }
            });
        }
    });
});
    
/* ------------------------------ 중요 주소록 (개별) ------------------------------ */
	
$(function(){
    var importAddress = $("#importAddress");
    var abNo; // 전역 변수로 abNo를 정의
    
    importAddress.on("click", function() {
    	
    	var self = this; // 현재의 this를 self에 저장
    	
    	$('#displayArea').empty();
    	var value = $(self).attr("value");
    	console.log("## 클릭한 요소의 value:", value);
    	$("#displayArea").text(value);

        $.ajax({
            url: '/address/importAbNo',
            type: 'GET',
            success: function(data) {
                console.log("## data : ", data);
                abNo = data; // data 값을 전역 변수에 할당
                console.log("## abNo : ", abNo); // 이제 abNo를 사용할 수 있음

                if (abNo !== null) {
                    $('#displayArea').empty();
                    var value = $(self).attr("value");
                    $("#displayArea").text(value);
                    
                    $.ajax({
                        url: '/address/exAddress',
                        type: 'POST',
                        data: JSON.stringify({ abNo: abNo }), // 전역 변수 사용
                        contentType: 'application/json; charset=utf-8',
                        success: function(data) {
                            console.log("## 중요 주소록 : ", data);
                            $('#addrList').empty();
                            
                            for (let i = 0; i < data.length; i++) {
                                let impAddrList = data[i];
                                console.log("## 중요주소록 Y/N :", impAddrList.importYn); // 템플릿 리터럴 수정

                                let starIcon = (impAddrList.importYn && impAddrList.importYn.toUpperCase() === 'Y')
                                    ? `<i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i>`
                                    : `<i class="bi bi-star"></i>`;
                                
                                let row = `
                                    <tr data-no="\${impAddrList.conNo}" data-read="" data-imp="" data-from="\${impAddrList.abNo}">
                                        <td class="d-flex flex-row justify-content-between align-middle px-2" style="border-right:none">
                                            <span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
                                            <span class='favIcon me-1 text-center' style="cursor: pointer;">\${starIcon}</span>
                                        </td>
                                        <td class="title align-middle text-center" data-sort="conName">\${impAddrList.conName}</td>
                                        <td class="date align-middle text-center" data-sort="conPosition">\${impAddrList.conPos}</td>
                                        <td class="size align-middle text-center" data-sort="conPhone">\${impAddrList.conTel}</td>
                                        <td class="size align-middle" data-sort="conEmail">\${impAddrList.conEmail}</td>
                                        <td class="size align-middle text-center" data-sort="conDepart">\${impAddrList.conDept}</td>
                                        <td class="size align-middle text-center" data-sort="conCompany">\${impAddrList.conCom}</td>
                                        <td class="size align-middle" data-sort="conMemo"></td>
                                    </tr>`;
                                    
                                // 생성한 row를 tbody에 추가
                                $('#addrList').append(row);
                            }
                            /* 페이징 처리 ..... */
                            var options = {
                            	    valueNames: ['name', 'position', 'phone', 'email', 'depart', 'deptTel', 'memo'],
                            	    page: 10,
                            	    pagination: true
                            	};

                            var userList = new List('tableExample2', options);
                        }
                    });
                } else {
                    console.log("abNo 값이 설정되지 않았습니다.");
                }
            }
        });
    });
});

/* ------------------------------ 외부 주소록 (개별) ------------------------------ */
$(function(){
	
	$(document).on("click", ".externalAddress", function() {		/* id가 아닌 .externalAddress 클래스로 클릭 이벤트 바인딩 */
																/* id속성은 중복되는 경우 하나의 첫번째 요소만 가져옴 , 즉 클릭이벤트가 여러번 정의되면 첫번째만 이벤트가 적용된다는 소리 */
		var abNo = $(this).data('ab-no');
		console.log("## ajax 파라미터 값 : ", abNo);
		
		$('#displayArea').empty();
		var value = $(this).attr("value");
		
		$("#displayArea").text(value);
		$.ajax({
			url : '/address/exAddress',
			type : 'POST',
			data : JSON.stringify({abNo : abNo}),
			contentType : 'application/json; charset=utf-8',
			success: function(data){
				console.log("## 외부 주소록 : ",data);
				
				$('#addrList').empty();
				
				// for 문으로 data를 순회하며 테이블에 row 추가
		        for (let i = 0; i < data.length; i++) {
		            let impAddrList = data[i];
		            
		            // 각 필드에 대해 null 체크 후 빈 문자열로 대체
		            let conName = impAddrList.conName || '';
		            let conPos = impAddrList.conPos || '';
		            let conTel = impAddrList.conTel || '';
		            let conEmail = impAddrList.conEmail || '';
		            let conDept = impAddrList.conDept || '';
		            let conCom = impAddrList.conCom || '';
		            let conMemo = impAddrList.conMemo || ''; // 추가된 부분
		            
// 		            let starIcon = (impAddrList.importYn && impAddrList.importYn.toUpperCase() === 'Y')
// 	                    ? `<i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i>`
// 	                    : `<i class="bi bi-star"></i>`;
		            
		            let row = `
		            	<tr class="exAddress" style="cursor:pointer" data-no="\${impAddrList.conNo}" data-from="\${impAddrList.abNo}">
		                    <td class="d-flex flex-row justify-content-center align-middle px-2" style="border-right:none">
		                        <span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
		                    </td>
		                    <td class="title align-middle text-center" data-sort="conName">\${conName}</td>
		                    <td class="date align-middle text-center" data-sort="conPosition">\${conPos}</td>
		                    <td class="size align-middle text-center" data-sort="conPhone">\${conTel}</td>
		                    <td class="size align-middle" data-sort="conEmail">\${conEmail}</td>
		                    <td class="size align-middle text-center" data-sort="conDepart">\${conDept}</td>
		                    <td class="size align-middle text-center" data-sort="conCompany">\${conCom}</td>
		                    <td class="size align-middle" data-sort="conMemo">\${conMemo}</td>
		                </tr>`;
		                
		        	 // 생성한 row를 tbody에 추가
		            $('#addrList').append(row);
				}
			}
		});
	});
});



/* --------------- 주소록 추가 (modal) --------------- */
$(function(){
	var addAddress = $("#addAddress");
	
	addAddress.on("click" , function(){
		// 모달 보여주기
        var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
        myModal.show();
	})
});

$(function(){
	let saveEventBtn = $("#saveEventBtn");
	
	saveEventBtn.on("click",function(){
		let memModalNo = $("#memModalNo").val();
		let abModalName = $("#abModalNameAdd").val();
		let abModalGb = $("#abModalGb").val();
		
		let addressObject = {
				memNo : memModalNo,
				abName : abModalName,
				abGb : abModalGb
		}
		$.ajax({
			url : "/address/addModalAddress",
			type : "POST",
			data : JSON.stringify(addressObject),
			contentType : "application/json; charset=utf-8",
			success: function(data) {
				console.log("## Modal 데이터가 넘어왔니??" , data);

				Swal.fire({
					  position: "center",
					  icon: "success",
					  title: "정상적으로 등록 되었습니다.",
					  showConfirmButton: false,
					  timer: 1500,
				}).then(() => {
			        window.location.href = "/address/main";  // 타이머 후 리다이렉트
			    });
			}
		});
	});
});
/* ------------------- 주소록 삭제  ------------------- */
$(function() {
    // 이벤트 위임으로 동적으로 생성된 요소 처리
    $(document).on("click", "#addressDel", function() {
        let abName = $(this).data("abname"); // 버튼의 data-abname 속성에서 값 가져오기
        let abNo = $(this).data("abno"); 
        console.log("삭제할 주소 이름: ", abName); // 콘솔로 값 확인
        console.log("삭제할 주소 번호: ", abNo);
        
        // SweetAlert로 삭제 여부 확인
        Swal.fire({
            title: "일정을 삭제하시겠습니까?",
            text: "삭제된 일정은 다시 복구되지 않습니다!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "네, 삭제하겠습니다!",
            cancelButtonText: "이전으로"
        }).then((result) => {
            if (result.isConfirmed) {
                let abObject = {
                    abName: abName,
                    abNo: abNo
                };

                // AJAX 요청으로 abName과 abNo 전달
                $.ajax({
                    url: '/address/delModalAddress',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(abObject),
                    success: function(response) {
                        console.log("삭제 성공: ", response); // 성공 시 응답 확인
                        Swal.fire({
                            position: "center",
                            icon: "success",
                            title: "삭제완료!",
                            text: "삭제가 정상적으로 되었습니다.",
                            timer: 1500,
                            willClose: () => {
                                window.location.href = "/address/main";
                            }
                        });
                    },
                    error: function(error) {
                        console.error("삭제 실패: ", error); // 실패 시 에러 확인
                    }
                });
            }
        });
    });
});

/* ------------------- 주소록 수정  ------------------- */
$(function() {
    // 이벤트 위임으로 동적으로 생성된 요소 처리
    $(document).on("click", "#addressModify", function() {
        let abName = $(this).data("abname"); // 버튼의 data-abname 속성에서 값 가져오기
        let abNo = $(this).data("abno"); 
        console.log("수정할 주소 이름: ", abName); // 콘솔로 값 확인
        console.log("수정할 주소 번호: ", abNo);
       
	   	// 모달 보여주기
       	var myModal = new bootstrap.Modal(document.getElementById('eventModal1'));
        
        $("#abModalNameUpt").val(abName); // abName을 입력 필드에 설정
        myModal.show();

        let saveEventBtn = $("#saveEventBtn1");

        saveEventBtn.off("click").on("click", function() {
            let abModalName = $("#abModalNameUpt").val();

            let addressObject = {
                abName : abModalName,
                abNo : abNo
            }

	       // AJAX 요청으로 abName과 abNo 전달
	       $.ajax({
	           url: '/address/modifyModalAddress',
	           type: 'POST',
	           contentType: 'application/json; charset=utf-8',
	           data: JSON.stringify(addressObject),
	           success: function(response) {
	               console.log("수정 성공: ", response); // 성공 시 응답 확인
	               Swal.fire({
	                   position: "center",
	                   icon: "success",
	                   title: "수정완료!",
	                   text: "수정이 정상적으로 되었습니다.",
	                   timer: 1500,
	                   willClose: () => {
	                       window.location.href = "/address/main";
	                   }
	               });
	           },
	           error: function(error) {
	               console.error("수정 실패: ", error); // 수정 시 에러 확인
	           }
	       });
    	});
	});
});

$(function () {
	$("#addrList").on("click", ".exAddress", function () {
		let conNo = $(this).data('no');
		location.href = `/address/detail?conNo=\${conNo}`;
	});
});

</script>