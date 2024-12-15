<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=more_vert" />
<style>
#sidebar-content {
	height: calc(100% - 240px);
}
#tableExample2{
	height: calc(100% - 120px);
}
.table > :not(caption) > * > * {
	padding: 5px;
}
/* .btn{ */
/* --falcon-btn-box-shadow:none; */
/* } */
.btn{
	border: 1px solid;
}
.dropdown-toggle{
	padding: 5px;
}
.disabled {
    pointer-events: none; 
    color: gray; 
    text-decoration: none; 
    opacity: 0.6; 
}
</style>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->
<div class="d-flex flex-column w-100 position-relative">
	<div class="d-flex flex-column justify-content-between position-relative" style="height: 120px">
		<div>
			<h4 class="p-3 m-0 align-middel" id="categoryName"></h4>
		</div>
		<div class="d-flex flex-row justify-content-between p-2">
			<div class="d-flex d-gid gap-2 flex-row align-items-center" id="mailFnBtn">
				
			</div>
			
			<!-- search-box 추가 부분 시작 -->
			<div>
				<div class="p-3 search-box align-middle">
			    	<div class="position-relative" data-bs-toggle="search" data-bs-display="static">
			    		<input class="form-control search-input fuzzy-search" type="search" placeholder="Search..." aria-label="Search" id="searchInput" name="searchWord"/>
			    		<span class="fas fa-search search-box-icon"></span>
			    	</div>
			    <div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
			    	<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
			        </div>
			    </div>	
			</div>
			<!-- search-box 추가 부분 끝 -->
		</div>
	</div>
	<div id="tableExample2" class="d-flex flex-column p-2 position-relative" data-list='{"valueNames":["name","title","date","size"],"page":10}'>
	  <div class="table-responsive scrollbar h-75" style="flex: 1;">
	    <table class="table table-bordered border-500 fs-10 mb-0" style="border-collapse: collapse;">
	      <thead class="bg-200">
	        <tr>
	          <th class="text-900" style="width: 9%"></th>
	          <th class="text-900 sort" data-sort="name" style="width: 10%">이름</th>
	          <th class="text-900 sort" data-sort="title">제목</th>
	          <th class="text-900 sort" data-sort="date" style="width: 10%">날짜</th>
	          <th class="text-900 sort" data-sort="size" style="width: 5%">크기</th>
	        </tr>
	      </thead>
	      <tbody class="list" id="mailList">
			<!-- 테이블 들어가는 부분 -->
			  <tr>
			    <td class="name align-middle text-500">-</td>
			    <td class="title align-middle text-500">No Data</td>
			    <td class="date align-middle text-500">-</td>
			    <td class="size align-middle text-500">-</td>
			  </tr>
	      </tbody>
	    </table>
	   <!-- 페이징 번호 시작 -->
	  </div>
		  <div class="d-flex flex-row justify-content-center card-footer clearfix h-25" id="pagingArea">
	  </div>
	  <!-- 페이징 번호 끝 -->
	</div>
</div>
<!-- 태그 추가 모달 -->
<div class="modal fade" id="addTagListModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addTagListModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addTagListCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addTagListModalHead">태그 추가</h4>
        </div>
		<div class="d-flex flex-column justify-content-center align-items-center align-middle p-3">
			<span class="p-0 my-1" id="addTagListModalMent">새 태그 이름을 입력하세요.</span>
			<input class="form-control-sm border-1" type="text" id="tagListNameInput">
			<span class="p-0 my-1">태그 색상을 선택하세요</span>
			<div class="d-flex flex-row flex-wrap d-gap gap-1" style="width: 170px">
				<div class="tag-color" data-color="#905341" style="background: #905341;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#D06B64" style="background: #D06B64;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#D75269" style="background: #D75269;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FA573C" style="background: #FA573C;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FF7537" style="background: #FF7537;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FFAD46" style="background: #FFAD46;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#42D692" style="background: #42D692;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#16A765" style="background: #16A765;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#7BD148" style="background: #7BD148;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#B3DC6C" style="background: #B3DC6C;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FBE983" style="background: #FBE983;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FAD165" style="background: #FAD165;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#F691B2" style="background: #F691B2;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#CD74E6" style="background: #CD74E6;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#9A9CFF" style="background: #9A9CFF;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#B99AFF" style="background: #B99AFF;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#6691E5" style="background: #6691E5;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#9FC6E7" style="background: #9FC6E7;width: 15px;height: 15px;border: 1px solid #FFF"></div>
			</div>
			<div id="addTagListModaltagNoData" class="d-none"></div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addTagListConfirm"><div id="contirmText" style="height: 30px;line-height: 30px"></div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addTagListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 태그 리스트 삭제 모달 -->
<div class="modal fade" id="deleteTagListModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="deleteTagListModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="deleteTagListCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="deleteTagListModalHead">태그 삭제</h4>
        </div>
		<div>
			<p>태그를 삭제하시겠습니까?</p>
		</div>
		<div id="deleteTagListModaltagNoData" class="d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="deleteTagListConfirm"><div id="contirmText" style="height: 30px;line-height: 30px"></div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="deleteTagListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 스팸등록 -->
<div class="modal fade" id="addSpamModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addSpamModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addSpamModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addSpamModalHead">스팸등록</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<div class="ps-3 text-dark">관리자에게 스팸메일을 신고합니다.</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="addSpamCheck" checked="checked">보낸 사람을 수신거부 목록에 추가</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="addTrashCheck" checked="checked">신고한 메일을 휴지통으로 이동</div>
		</div>
		<div id="deleteTagListModaltagNoData" class="d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addSpamConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addSpamCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function () {
	
	// 페이징 처리 시작
	let searchInput = $("#searchInput");
	let keyword = "받은";
	getMailList("page",1, keyword);
	getTagList();
	
	$("#pagingArea").on("click", "a", function (e) {
	    e.preventDefault(); 
	    let page = $(this).data("page"); 
	    getMailList("page", page, keyword); 
	});
	
	searchInput.on("keydown", function (event) {
		if (event.keyCode == 13) {
			let searchWord = searchInput.val();
			getMailList("search", searchWord, keyword);
		}
	});
	// 페이징 처리 끝
	
	// 태그 추가
	let addTagListConfirm = $("#addTagListConfirm");
	let modifyTagListConfirm = $("#modifyTagListConfirm");
	let deleteTagListConfirm = $("#deleteTagListConfirm");
	let addTagListCancle = $("#addTagListCancle");
	let tagListNameInput = $("#tagListNameInput");
	
	$(".tag-color").on("click", function () {
		$(".tag-color").css('border-color', '#fff'); 
	    $(this).css('border-color', 'black');
	});
	
	addTagListConfirm.on("click", function () {
		$("#addTagListCloseBtn").click();
		if ($("#contirmText").text() == "추가") {
			let result = getTagListInfo();
			addTagList(result[0], result[1]);
		}else {
			let result = getTagListInfo();
			let tagNo = $("#addTagListModaltagNoData").html();
			let tagListDiv = $(".tagListDiv");
			for (let i = 0; i < tagListDiv.length; i++) {
				if (tagListDiv.eq(i).data("no") == tagNo) {
					console.log(tagListDiv.eq(i).find(".aTag"));
					console.log(tagListDiv.eq(i).find(".iTag"));
					tagListDiv.eq(i).find(".aTag").text(result[0]);
					tagListDiv.eq(i).find(".iTag").css("color", result[1]);
					tagListDiv.eq(i).find(".tag-modify").data("name", result[0]);
					tagListDiv.eq(i).find(".tag-modify").data("color", result[1]);
				}
			}
			modifyTagList(result[0], result[1], tagNo);
		}
	})
	
	deleteTagListConfirm.on("click", function () {
		$("#deleteTagListCloseBtn").click();
		let tagNo = $("#deleteTagListModaltagNoData").html();
		let tagListDiv = $(".tagListDiv");
		for (let i = 0; i < tagListDiv.length; i++) {
			if (tagListDiv.eq(i).data("no") == tagNo) {
				tagListDiv.eq(i).remove();
			}
		}		
		deleteTagList(tagNo);
	})
	
	$("#tagListNameInput").on("keydown", function (event) {
		if(event.keyCode == 13){
			$("#addTagListConfirm").click();
		}
		if(event.keyCode == 27){
			$("#addTagListCloseBtn").click();
		}
	});
	
	let lastTarget = null; // 전역 변수로 설정

	$(document).on('click', function (event) {
	    if ($(event.target).closest('.tagModifyBtn').length == 0) {
	        // 태그 수정 버튼이 아닌 곳을 클릭했을 경우 모든 드롭다운을 닫습니다.
	        $(".tag-toggle").removeClass("show");
	        lastTarget = null; // lastTarget 초기화
	    } else if ($(event.target).closest('.tagModifyBtn').length) {
	        // 태그 수정 버튼을 클릭한 경우
	        const currentTarget = $(event.target).closest('.tagModifyBtn').parent().next();

	        if (lastTarget !== currentTarget[0]) {
	            // 이전 클릭한 요소와 다르다면 모든 드롭다운을 닫고 현재 요소만 열기
	            $(".tag-toggle").removeClass("show");
	            currentTarget.toggleClass("show");
	            lastTarget = currentTarget[0]; // 현재 클릭한 요소로 lastTarget 업데이트
	        } else {
	            // 이전 클릭한 요소와 같으면 현재 요소 닫기
	            currentTarget.toggleClass("show");
	            lastTarget = null; // 닫았으므로 초기화
	        }
	    }
	});

	
	$("#treeviewExample-3-1").on("click", ".tag-modify", function(e){
		e.preventDefault();
		let name = $(this).data("name");
		let color = $(this).data("color");
		let no = $(this).data("no");
		openModifyTagListModal(name, color, no);
	});

	$("#treeviewExample-3-1").on("click", ".tag-delete", function(e){
		e.preventDefault();
		let no = $(this).data("no");
		$(this).closest(".tagListDiv").remove();
		deleteTagList(no);
	});
	
	// 메일 버튼 기능
	
	$("#mailFnBtn").on("change", "#allCheckbox", function () {
		if ($(this).is(":checked")) {
			$("#mailList .form-check-input").prop("checked", true);
			$("#mailFnBtn .FnBtn").removeClass("disabled");
		}else {
			$("#mailList .form-check-input").prop("checked", false);
			$("#mailFnBtn .FnBtn").addClass("disabled");
		}
	});	
	
    $('#mailList').on('change', ".form-check-input", function() {
        let allChecked = $('#mailList .form-check-input:checked').length == $('#mailList .form-check-input').length ? true : false;
        $('#allCheckbox').prop('checked', allChecked);
        console.log($("#mailList .form-check-input:checked").length);
        
        if ($("#mailList .form-check-input:checked").length) {
			$("#mailFnBtn .FnBtn").removeClass("disabled");
		}else{
			$("#mailFnBtn .FnBtn").addClass("disabled");
		}
    });
    
    $("#mailFnBtn").on("click", ".disabled", function (e) {
		e.preventDefualt();
	});

    $("#addSpamConfirm").on("click", function () {
    	$("#addSpamModalCloseBtn").click();
    	let blockList = [];
    	let trashList = [];
    	let checkInput = $("#mailList .form-check-input");
		if ($("#addSpamCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					blockList.push(checkInput.eq(i).closest("tr").data("from"));
				}
			}
			addSpam(blockList);
		}
		if ($("#addTrashCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					trashList.push(checkInput.eq(i).closest("tr").data("no"));
				}
			}
			addTrash(trashList);
		}
	});
    

});

function getMailList(type, value, keyword) {
	keyword = keyword;
	if (type == "page") {
		data = {currentPage : value,
				keyword : keyword};	
	}
	if (type == "search") {
		data = {searchWord : value,
				currentPage : 1,
				keyword : keyword};	
	}
	$.ajax({
		url : "/mail/paging.do",
		method : "post",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		success : function (pagingVO) {
			let dataListHTML = "";
			if (pagingVO.dataList.length) {
				pagingVO.dataList.forEach(function (mailList) {
	                if (mailList.readYn == 'N') {
	                    dataListHTML += `
	                        <tr data-no="\${mailList.mailNo}" data-read="\${mailList.readYn}" data-imp="\${mailList.recImpYn}"
	                        	data-from="\${mailList.memNo}">
	                            <td class="align-middle text-1000 fs-8 px-2">
	                            	<span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
	                            		`;
	                	if (mailList.recImpYn == 'N') {
	                		dataListHTML += `
	                            	<span class='me-1 text-center'><i class="bi bi-star"></i></span>
	                           				`;
						}else{
							dataListHTML += `
	                            	<span class='me-1 text-center'><i class="bi bi-star-fill" style="color:'yellow'"></i></span>
											`;
						}
	                	dataListHTML += `
	                            	<span class='me-1 text-center'><i class="bi bi-envelope"></i></span>
	                            		`;
	                    if (mailList.fileNo != 0) {
							dataListHTML += `	
	                            	<span class='me-1 text-center'><i class="bi bi-paperclip"></i></span>
	                            			`;
						}
	                    dataListHTML += `
	                            </td>
	                            <td class="name align-middle text-1000">\${mailList.memName}</td>
	                            <td class="title align-middle text-1000">\${mailList.mailTitle}</td>
	                            <td class="date align-middle text-1000">\${mailList.mailDate.substring(0, 16)}</td>
	                            <td class="size align-middle text-1000">15.2KB</td>
	                        </tr>
	                    `;
	                } else {
	                    dataListHTML += `
	                        <tr data-no="\${mailList.mailNo}" data-read="\${mailList.readYn}" data-imp="\${mailList.recImpYn}">
	                            <td class="align-middle fs-8 px-2">
	                            	<span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
	                            		`;
	                	if (mailList.recImpYn == 'N') {
	                		dataListHTML += `
	                            	<span class='me-1 text-center'><i class="bi bi-star"></i></span>
	                           				`;
						}else{
							dataListHTML += `
	                            	<span class='me-1 text-center'><i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i></span>
											`;
						}
	                	dataListHTML += `
	                            	<span class='me-1 text-center'><i class="bi bi-envelope"></i></span>
	                            		`;
	                    if (mailList.fileNo != 0) {
							dataListHTML += `	
	                            	<span class='me-1 text-center'><i class="bi bi-paperclip"></i></span>
	                            			`;
						}
	                    dataListHTML += `
	                            </td>
	                            <td class="name align-middle text-500">\${mailList.memName}</td>
	                            <td class="title align-middle text-500">\${mailList.mailTitle}</td>
	                            <td class="date align-middle text-500">\${mailList.mailDate.substring(0, 16)}</td>
	                            <td class="size align-middle text-500">15.2KB</td>
	                        </tr>
	                    `;
	                }
				});
			}else{
				dataListHTML  = "<div>메일이 없습니다.</div>";
			}

			let FunctionHTML = getMailFunctionBtn(pagingVO.keyword);
			let categoryName = keyword != "휴지통" ? keyword + "메일함" : keyword
			$("#mailList").html(dataListHTML);
			$("#pagingArea").html(pagingVO.pagingHTML);
			$("#mailFnBtn").html(FunctionHTML);
			$("#categoryName").html(categoryName)
			
		    if (pagingVO.dataList.length > 0) {
		        let listInstance = new List('tableExample2', {
		            valueNames: ['name', 'title', 'date', 'size'],
		            page: 10
		        });
		    }
		}
	});
}

function getMailFunctionBtn(keyword) {
	let FunctionHTML = "";
	FunctionHTML += `
						<div class='d-flex flex-row'>
							<div class="form-check d-flex justify-content-end align-middle align-items-center mb-0 pb-2">
								<input type="checkbox" class='form-check-input' id='allCheckbox'>
							</div>
							<div class="btn-group">
							  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
							  <div class="dropdown-menu">
							    <a class="dropdown-item" onclick="allCheck()">전체선택</a>
							    <a class="dropdown-item" onclick="readedMailCheck()">읽은메일</a>
							    <a class="dropdown-item" onclick="unReadedMailCheck()">안읽은메일</a>
							    <a class="dropdown-item" onclick="impMailCheck()">중요메일</a>
							    <a class="dropdown-item" onclick="unImpMailCheck()">중요표시안한메일</a>
							    <a class="dropdown-item" onclick="allUnCheck()">선택해제</a>
							  </div>
							</div>
						</div>

					`;
	if (keyword == "받은") {
		FunctionHTML += `
							<span class="FnBtn btn p-1 disabled" onclick="openAddSpamModal()"> 
								<span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
										<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
									</svg>
								</span> <span>스팸등록</span>
							</span>		
						`;
	}
	if (keyword == "스팸" || keyword == "휴지통") {
		FunctionHTML += `
							<span class="FnBtn btn p-1 disabled"> 
								<span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
										<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
									</svg>
								</span> <span>스팸해제</span>
							</span>
						`;		
	}
	if (!(keyword == "임시" || keyword == "예약")) {
		FunctionHTML += `
							<span class="FnBtn btn-group disabled">
							  <button class="btn p-1" type="button"><i class="bi bi-arrow-return-right me-1"></i>답장</button>
							  <button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only">Toggle Dropdown</span></button>
							  <div class="dropdown-menu">
							    <a class="dropdown-item" href="#">답장</a>
							    <a class="dropdown-item" href="#">전체답장</a>
							  </div>
							</span>
						`;
	}
	FunctionHTML += `
						<span class="FnBtn btn-group disabled">
						  <button class="btn p-1" type="button">
						  <span>
						  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
								<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
							</svg>
						  </span><span>삭제</span></button>
						  <button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only">Toggle Dropdown</span></button>
						  <div class="dropdown-menu">
						    <a class="dropdown-item" href="#">삭제</a>
						    <a class="dropdown-item" href="#">완전삭제</a>
						    <a class="dropdown-item" href="#">첨부파일삭제</a>
						  </div>
						</span>
					`;
	if (!(keyword == "임시" || keyword == "예약")) {
		FunctionHTML += `
							<span class="FnBtn btn-group disabled">
							  <button class="btn p-1" type="button">
							  <span>
								<i class="bi bi-tag"></i>
							  </span><span>태그</span></button>
							  <button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only">Toggle Dropdown</span></button>
							  <div class="dropdown-menu">
							    <a class="dropdown-item" href="#">중요자료</a>
							    <a class="dropdown-item" href="#">참고자료</a>
							  </div>
							</span>
							
							<span class="FnBtn btn p-1 disabled"> 
								<span>
									<i class="bi bi-arrow-right"></i>
								</span> <span>전달</span>
							</span>
							
							<span class="FnBtn btn-group disabled">
							  <button class="btn p-1" type="button">
							  <span>
								<i class="bi bi-envelope"></i>
							  </span><span>읽음</span></button>
							  <button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only">Toggle Dropdown</span></button>
							  <div class="dropdown-menu">
							    <a class="dropdown-item" href="#">읽음</a>
							    <a class="dropdown-item" href="#">안읽음</a>
							  </div>
							</span>
						`;
	}
	if (keyword != "예약") {
		FunctionHTML += `
							<div class="FnBtn btn-group disabled">
							  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">이동</button>
							  <div class="dropdown-menu">
							    <a class="dropdown-item" href="#">스팸메일함</a>
							    <a class="dropdown-item" href="#">휴지통</a>
							    <div class="dropdown-divider"></div>
							    <a class="dropdown-item" href="#">커스텀1</a>
							  </div>
							</div>
						`;
	}

		FunctionHTML +=	`<div class="FnBtn btn-group disabled">
						  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">더보기</button>
						  <div class="dropdown-menu">
						    <a class="dropdown-item" href="#">저장</a>
						    <a class="dropdown-item" href="#">인쇄</a>
						    <a class="dropdown-item" href="#">수신거부</a>
						  </div>
						</div>
					`;
	return FunctionHTML;
}

function getTagList() {
	$.ajax({
		url : "/mail/getTagList.do",
		method : "get",
		success : function (tagList) {
			let tagListHTML = "";
			if (tagList.length) {
				for (let i = 0; i < tagList.length; i++) {
					tagListHTML += `
									<div class="tagListDiv d-flex flex-row position-relative" data-no="\${tagList[i].mailTagNo}">
									    <li class="treeview-list-item w-100">
									        <div class="treeview-item d-flex flex-row align-items-center justify-content-between">
									            <div class="treeview-text">
									                <a class="aTag flex-1" href=""> <i class="iTag bi bi-tag-fill" style="color: \${tagList[i].mailTagColor}"></i> \${tagList[i].mailTagName}
									                </a>
									            </div>
									            <div class="tagModifyBtn d-flex align-items-center m-0" style="height: 26.38px; line-height: 26.38px">
									                <a class="d-inline-block" style="cursor: pointer; height: 26.38px; line-height: 26.38px">
									                    <span class="material-symbols-outlined" style="color: #AAA; padding-top: 2px">more_vert</span>
									                </a>
									            </div>
									        </div>
									        <div class="dropdown-menu tag-toggle" style="position: absolute; margin-top: 10px; left: 175px; top: -5px; z-index: 10000">
									            <a class="dropdown-item tag-modify" href="#" onclick="openModifyTagListModal()" data-name="\${tagList[i].mailTagName}" data-color="\${tagList[i].mailTagColor}" data-no="\${tagList[i].mailTagNo}">태그 수정</a>
									            <a class="dropdown-item tag-delete" href="#" data-no="\${tagList[i].mailTagNo}">태그 삭제</a>
									        </div>
									    </li>
									</div>	
									`;
				}
			}
			$("#addTagList").before(tagListHTML);
		}
	})
}

function getTagListInfo(){
	let tagListColor = null;
	let tagListName = tagListNameInput.val();
	for (let i = 0; i < $(".tag-color").length; i++) {
		if ($(".tag-color").eq(i).css('border-color') === 'rgb(0, 0, 0)') {
			tagListColor = $(".tag-color").eq(i).data("color");
		}
	}
	return [tagListName, tagListColor];
}

function openAddTagListModal() {
	$(".tag-color").css('border-color', '#FFF');
	$("#addTagListModalHead").html("태그 추가");
	$("#contirmText").html("추가");
	$("#tagListNameInput").val("");
	$("#addTagListModalMent").text("새 태그 이름을 입력하세요.");
	if ($("#modifyTagListConfirm")) {
		$("#modifyTagListConfirm").attr('id', 'addTagListConfirm');
	}
	$('#addTagListModal').modal('show');
}

function openModifyTagListModal(tagName, tagColor, tagNo) {
	$(".tag-color").css('border-color', '#FFF');
	$("#addTagListModalHead").html("태그 수정");	
	$("#contirmText").html("수정");
	$("#tagListNameInput").val(tagName);
	$("#addTagListModalMent").text("수정할 태그 이름을 입력하세요.");
	$("#addTagListConfirm").attr('id', 'addTagListConfirm');
	for (let i = 0; i < $(".tag-color").length; i++) {
		if ($(".tag-color").eq(i).data("color") == tagColor) {
			$(".tag-color").eq(i).css('border-color', 'black');
		}
	}
	if ($("#addTagListConfirm")) {
		$("#addTagListConfirm").attr('id', 'modifyTagListConfirm');
	}
	$("#addTagListModaltagNoData").html(tagNo);
	$('#addTagListModal').modal('show');
}

function openDeleteTagListModal(tagNo) {
	$("#deleteTagListModaltagNoData").html(tagNo);
	$("#deleteTagListModal").modal('show');
}

function getTagListInfo(){
	let tagListColor = null;
	let tagListName = tagListNameInput.val();
	for (let i = 0; i < $(".tag-color").length; i++) {
		if ($(".tag-color").eq(i).css('border-color') === 'rgb(0, 0, 0)') {
			tagListColor = $(".tag-color").eq(i).data("color");
		}
	}
	return [tagListName, tagListColor];
}

function addTagList(tagListName, tagListColor) {
	$("#addTagListCloseBtn").click();
	$.ajax({
		url : "/mail/addTagList.do",
		method : "post",
		data : JSON.stringify({
			mailTagName : tagListName,
			mailTagColor : tagListColor
		}),
		contentType : "application/json; charset=utf-8",
		success : function (tag) {
			let tagHTML = "";
			tagHTML += `
						<div class="tagListDiv d-flex flex-row position-relative" data-no="\${tag.mailTagNo}">
						    <li class="treeview-list-item w-100">
						        <div class="treeview-item d-flex flex-row align-items-center justify-content-between">
						            <div class="treeview-text">
						                <a class="aTag flex-1" href=""> <i class="iTag bi bi-tag-fill" style="color: \${tag.mailTagColor}"></i> \${tag.mailTagName}
						                </a>
						            </div>
						            <div class="d-flex align-items-center m-0" style="height: 26.38px; line-height: 26.38px">
						                <a class="d-inline-block" style="cursor: pointer; height: 26.38px; line-height: 26.38px">
						                    <span class="material-symbols-outlined" style="color: #AAA; padding-top: 2px">more_vert</span>
						                </a>
						            </div>
						        </div>
						        <div class="dropdown-menu tag-toggle" style="position: absolute; margin-top: 10px; left: 175px; top: -5px; z-index: 10000">
						            <a class="dropdown-item tag-modify" href="#"  data-name="\${tag.mailTagName}" data-color="\${tag.mailTagColor}" data-no="\${tag.mailTagNo}">태그 수정</a>
						            <a class="dropdown-item tag-delete" data-no="\${tag.mailTagNo}" href="#">태그 삭제</a>
						        </div>
						    </li>
						</div>					
						`;
			$("#addTagList").before(tagHTML);
		}
	});
}

function modifyTagList(tagName, tagColor, tagNo) {
	$.ajax({
		url : "/mail/modifyTagList.do",
		method : "post",
		data : JSON.stringify({
			mailTagNo : tagNo,
			mailTagName : tagName,
			mailTagColor : tagColor
		}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function deleteTagList(tagNo) {
	$.ajax({
		url : "/mail/deleteTagList.do",
		method : "post",
		data : JSON.stringify({
			mailTagNo : tagNo
		}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function allCheck() {
	let allCheckbox = $("#mailFnBtn .form-check-input").eq(0);
	let dataListCheckbox = $("#mailList .form-check-input");
	allCheckbox.prop("checked", true);
	dataListCheckbox.prop("checked", true);
}

function allUnCheck() {
	let allCheckbox = $("#mailFnBtn .form-check-input").eq(0);
	let dataListCheckbox = $("#mailList .form-check-input");
	allCheckbox.prop("checked", false);
	dataListCheckbox.prop("checked", false);
}

function readedMailCheck() {
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("read") == 'Y') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function unReadedMailCheck() {
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("read") == 'N') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function impMailCheck() {
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("imp") == 'Y') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function unImpMailCheck() {
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("imp") == 'N') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function openAddSpamModal() {
	$("#addSpamModal").modal("show");
}

function addSpam(blockList) {
	$.ajax({
		url : "/mail/addSpam.do",
		method : "post",
		data : JSON.stringify(blockList),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function addTrash(trashList) {
	$.ajax({
		url : "/mail/addTrash.do",
		method : "post",
		data : JSON.stringify(trashList),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}


</script>
<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->




