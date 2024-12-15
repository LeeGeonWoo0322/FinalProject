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
	height: 2px;
	background: black;
	transition: all .1s ease-out;
	color: black;
}

.nav-menu a.active::after{
	width: 100%
}

table tr{
	
}

table tr:last-child td {
	border-bottom: 0
}

</style>

<div class="d-flex flex-column w-100 position-relative">
    <div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
	<div class="d-flex flex-column border-bottom position-relative" style="height: 120px">
		<div class="mb-2" style="height: 60px">
			<h4 class="p-3 m-0 align-middel" id="categoryName">
				환경설정
			</h4>
		</div>
		<div class="d-flex align-items-end ms-2" style="width: 25%;height: 60px">
			<nav class="nav-menu align-bottom d-gap gap-4">
		        <a href="#" class="active" data-target="spam">스팸</a>
		        <a href="#" data-target="outOfOffice">부재중응답</a>
<!-- 		        <a href="#" data-target="businessCard">명함관리</a> -->
			</nav>
		</div>
	</div>
	<div class="p-3">
	    <!-- 스팸 설정 -->
	    <div id="spam" class="optionContent w-100">
	    	<h5>스팸 기본설정</h5>
			<div class="d-flex flex-row w-100 mt-3" style="min-height: 300px">
			    <div style="width: 10%">차단단어 목록</div>
			    <div style="width: 90%">
			        <div class="d-flex flex-row mb-1">
			            <input type="text" class="form-control form-control-sm me-2" id="blockWordInput" style="width: 200px">
			            <button class="btn border-0 py-0 px-1 fs-9" id="addBlockWordBtn" style="box-shadow: none">
			                <span class="far fa-plus-square me-1"></span><span>추가</span>
			            </button>
			            <button class="btn border-0 py-0 px-1 fs-9" id="deleteAllBlockWordBtn" style="box-shadow: none">
			                <span class="far fa-trash-alt me-1"></span><span>전체삭제</span>
			            </button>
			        </div>
			        <div>
			            <table class="table w-100 m-0">
			                <colgroup>
			                    <col class="col-sm-11" style="height: 37px;">
			                    <col class="col-sm-1" style="height: 37px;">
			                </colgroup>
			                <thead>
			                    <tr class="bg-200">
			                        <th class="text-center">차단단어 목록</th>
			                        <th class="text-center">관리</th>
			                    </tr>
			                </thead>
			            </table>
			            <div style="max-height: 190px; overflow-y: auto;">
			                <table class="table table-bordered w-100 m-0" id="blockWordTable">
				                <colgroup>
				                    <col class="col-sm-11" style="height: 37px;">
				                    <col class="col-sm-1" style="height: 37px;">
				                </colgroup>
			                    <tbody>
			                    	
			                    </tbody>
			                </table>
			            </div>
			        </div>
			    </div>
			</div>
			<div class="d-flex flex-row w-100 mt-3" style="min-height: 300px">
				<div style="width: 10%">수신차단 목록</div>
				<div style="width: 90%">
					<div class="d-flex flex-row mb-1">
						<input type="email" class="form-control form-control-sm me-2" id="blockListInput" placeholder="Email" style="width: 200px">
						<button class="btn border-0 py-0 px-1 fs-9" id="addBlockListBtn" style="box-shadow: none"><span class="far fa-plus-square me-1"></span><span>추가</span></button>
						<button class="btn border-0 py-0 px-1 fs-9" id="deleteAllBlockListBtn" style="box-shadow: none"><span class="far fa-trash-alt me-1"></span><span>전체삭제</span></button>
					</div>
					<div style="max-height: 225px; overflow-y: auto;">
					    <table class="table w-100 m-0">
					        <colgroup>
					            <col class="col-sm-11" style="height: 37px;">
					            <col class="col-sm-1" style="height: 37px;">
					        </colgroup>
					        <thead>
					            <tr class="bg-200">
					                <th class="text-center">차단단어 목록</th>
					                <th class="text-center">관리</th>
					            </tr>
					        </thead>
					    </table>
			            <div style="max-height: 190px; overflow-y: auto;">
			                <table class="table table-bordered w-100 m-0" id="blockListTable">
				                <colgroup>
				                    <col class="col-sm-11" style="height: 37px;">
				                    <col class="col-sm-1" style="height: 37px;">
				                </colgroup>
			                    <tbody>
			                    	
			                    </tbody>
			                </table>
			            </div>
					</div>
				</div>
			</div>
	    </div>
	    <!-- 부재중응답 설정 -->
	    <div id="outOfOffice" class="optionContent d-none">
	    	<div class="d-flex flex-row">
		    	<h5>부재중응답 설정</h5>
		    	<div class="ms-3">
		    		<c:choose>
		    			<c:when test="${empty outOfOffice }">
				    		<div class="form-check form-check-inline"><input class="form-check-input" id="inlineRadio1" type="radio" name="inlineRadioOptions" value="Y" /><label class="form-check-label" for="inlineRadio1">적용함</label></div>
							<div class="form-check form-check-inline"><input class="form-check-input" id="inlineRadio2" type="radio" name="inlineRadioOptions" value="N" checked="checked" /><label class="form-check-label" for="inlineRadio2">적용하지 않음</label></div>
		    			</c:when>
		    			<c:otherwise>
				    		<div class="form-check form-check-inline"><input class="form-check-input" id="inlineRadio1" type="radio" name="inlineRadioOptions" value="Y" <c:if test="${outOfOffice.autoUseYn eq 'Y' }">checked="checked"</c:if> /><label class="form-check-label" for="inlineRadio1">적용함</label></div>
							<div class="form-check form-check-inline"><input class="form-check-input" id="inlineRadio2" type="radio" name="inlineRadioOptions" value="N" <c:if test="${outOfOffice.autoUseYn eq 'N' }">checked="checked"</c:if> /><label class="form-check-label" for="inlineRadio2">적용하지 않음</label></div>
		    			</c:otherwise>
		    		</c:choose>
		    	</div>
	    	</div>
	    	<div class="w-50">
		    	<table>
					<colgroup>
			            <col class="col-sm-3">
			            <col class="col-sm-9">
			        </colgroup>
			        <tbody>
			            <tr>
			            	<th class="p-2">부재중응답 제목</th>
			            	<td class="p-2"><input id="outOfOfficeTitle" type="text" <c:if test="${not empty outOfOffice }">value="${outOfOffice.autoTitle }"</c:if> class="form-control form-control-sm"></td>
			            </tr>
			            <tr>
			            	<th class="p-2">부재중응답 메세지</th>
			            	<td class="p-2"><textarea id="outOfOfficeContent" rows="3" class="form-control" wrap="hard"><c:if test="${not empty outOfOffice }">${fn:trim(outOfOffice.autoContent) }</c:if></textarea></td>
			            </tr>
			        </tbody>
		    	</table>
	    	</div>
			<div class="d-flex flex-row justify-content-center w-50 mt-3">
				<div><a class="btn btn-info border-400 d-flex align-items-center me-3" id="oufOfOfficeSave">저장</a></div>
				<div><a class="btn d-flex align-items-center">취소</a></div>
			</div>
	    </div>
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
<script type="text/javascript">
getBlockWordList();
getBlockList();
let outOfOfficeIsExist = ${outOfOfficeExist};
$(function () {
    const links = $('.nav-menu a');
    const contents =$('.optionContent');
    let isAlertVisible = false;
    let myEmail = "${member.memEmail}";

    links.on("click", function (event) {
        event.preventDefault(); // 기본 링크 동작 방지

        // 현재 활성화된 링크에서 active 클래스 제거
        links.removeClass("active");

        // 클릭한 링크에 active 클래스 추가
        $(this).addClass("active");

        const targetId = $(this).data('target');

        // 모든 content div 숨김
        contents.addClass("d-none");

        // 클릭한 링크와 관련된 div 표시
        const targetContent = $("#" + targetId);
        if (targetContent.length) {
            targetContent.removeClass("d-none");
        }
    });
    
    $("#blockWordInput").on("keydown", function (event) {
		let keyCode = event.keyCode;
		let blockWordInput = $(this);
		let blockWord = blockWordInput.val();
		
		if (keyCode == 13) {
			axios({
				url : "/mail/addBlockWord.do",
				method : "post",
				data : JSON.stringify({blockWord : blockWord}),
				headers : {
					"Content-Type" : "application/json; charset=utf-8"
				}
			}).then(function (response) {
				let res = response.data;
				blockWordInput.val("");
				let blockWordHTML = `
						            <tr>
						                <td style='border-right:0'>\${res.blockWord}</td>
						                <td class="d-flex flex-row justify-content-center" style='border-left:0'><button class="btn py-0 px-1 fs-9 deleteBtn" data-no="\${res.bwNo}"><span class="far fa-trash-alt me-1"></span><span>삭제</span></button></td>
						            </tr>				
									`;
				if ($("#blockWordTable").find(".emptyList").length > 0) {
					$("#blockWordTable").find(".emptyList").remove();
					$("#blockWordTable").find("tbody").html(blockWordHTML)
				}else {
					$("#blockWordTable").find("tr").eq(0).before(blockWordHTML);
				}
			});
		}
    });
    
    $("#addBlockWordBtn").on("click", function () {
		let blockWordInput = $("#blockWordInput");
		let blockWord = blockWordInput.val();
		
		axios({
			url : "/mail/addBlockWord.do",
			method : "post",
			data : JSON.stringify({blockWord : blockWord}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			blockWordInput.val("");
			let blockWordHTML = `
					            <tr>
					                <td style='border-right:0'>\${res.blockWord}</td>
					                <td class="d-flex flex-row justify-content-center" style='border-left:0'><button class="btn py-0 px-1 fs-9 deleteBtn" data-no="\${res.bwNo}"><span class="far fa-trash-alt me-1"></span><span>삭제</span></button></td>
					            </tr>				
								`;
				if ($("#blockWordTable").find(".emptyList").length > 0) {
					$("#blockWordTable").find(".emptyList").remove();
					$("#blockWordTable").find("tbody").html(blockWordHTML)
				}else {
					$("#blockWordTable").find("tr").eq(0).before(blockWordHTML);
				}
		});
    });
    
    $("#deleteAllBlockWordBtn").on("click", function () {
		axios({
			url : "/mail/deleteAllBlockWord.do",
			method : "get",
		}).then(function (response) {
			$("#blockWordTable").find("tbody").html(`
													<tr>
									            	    <td colspan="2" class="emptyList text-center p-5">차단단어 목록이 없습니다.</td>
										            </tr>`);
		});
	});
    
    $("#blockWordTable").on("click", ".deleteBtn",function () {
		let deleteNo = $(this).data("no");
		let thisTr = $(this).closest("tr");
		axios({
			url : "/mail/deleteBlockWord.do",
			method : "post",
			data : JSON.stringify({deleteNo : deleteNo}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			thisTr.remove();
			if ($("#blockWordTable").find("tr").length == 0) {
				$("#blockWordTable").find("tbody").html(`
						<tr>
		            	    <td colspan="2" class="emptyList text-center p-5">차단단어 목록이 없습니다.</td>
			            </tr>`);				
			}
		});
	});
    
    $("#blockListInput").on("keydown", function (event) {
		let keyCode = event.keyCode;
		let blockListInput = $(this);
		let blockList = blockListInput.val();
		if (myEmail == blockList) {
			requiredAlert("본인의 이메일 주소는 등록할 수 없습니다.", isAlertVisible);
			blockListInput.val("");
			return false;
		}
		
		if (keyCode == 13) {
			axios({
				url : "/mail/addBlockList.do",
				method : "post",
				data : JSON.stringify({blockList : blockList}),
				headers : {
					"Content-Type" : "application/json; charset=utf-8"
				}
			}).then(function (response) {
				let res = response.data;
				if (res) {
					blockListInput.val("");
					let blockListHTML = `
							            <tr>
							                <td style='border-right:0'>\${res.blockedMemEmail}</td>
							                <td class="d-flex flex-row justify-content-center" style='border-left:0'><button class="btn py-0 px-1 fs-9 deleteBtn" data-no="\${res.blNo}"><span class="far fa-trash-alt me-1"></span><span>삭제</span></button></td>
							            </tr>				
										`;
					if ($("#blockListTable").find(".emptyList").length > 0) {
						$("#blockListTable").find(".emptyList").remove();
						$("#blockListTable").find("tbody").html(blockListHTML);
					}else {
						$("#blockListTable").find("tr").eq(0).before(blockListHTML);
					}
				}else {
					requiredAlert("메일주소가 유효하지 않습니다.", isAlertVisible);
					blockListInput.val("");
				}
			});
		}
	});
    
    $("#addBlockListBtn").on("click", function () {
		let blockListInput = $("#blockListInput");
		let blockList = blockListInput.val();
		if (myEmail == blockList) {
			requiredAlert("본인의 이메일 주소는 등록할 수 없습니다.", isAlertVisible);
			blockListInput.val("");
			return false;
		}
		axios({
			url : "/mail/addBlockList.do",
			method : "post",
			data : JSON.stringify({blockList : blockList}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			blockListInput.val("");
			let blockListHTML = `
					            <tr>
					                <td>\${res.blockedMemEmail}</td>
					                <td class="d-flex flex-row justify-content-center"><button class="btn py-0 px-1 fs-9 deleteBtn" data-no="\${res.blNo}"><span class="far fa-trash-alt me-1"></span><span>삭제</span></button></td>
					            </tr>				
								`;
				if ($("#blockListTable").find(".emptyList").length > 0) {
					$("#blockListTable").find(".emptyList").remove();
					$("#blockListTable").find("tbody").html(blockListHTML)
				}else {
					$("#blockListTable").find("tr").eq(0).before(blockListHTML);
				}
		});
    });
    
    $("#deleteAllBlockListBtn").on("click", function () {
		axios({
			url : "/mail/deleteAllBlockList.do",
			method : "get",
		}).then(function (response) {
			$("#blockListTable").find("tbody").html(`
													<tr>
									            	    <td colspan="2" class="emptyList text-center p-5">차단단어 목록이 없습니다.</td>
										            </tr>`);
		});
	});
    
    $("#blockListTable").on("click", ".deleteBtn",function () {
		let deleteNo = $(this).data("no");
		let thisTr = $(this).closest("tr");
		axios({
			url : "/mail/deleteBlockList.do",
			method : "post",
			data : JSON.stringify({deleteNo : deleteNo}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			thisTr.remove();
			if ($("#blockListTable").find("tr").length == 0) {
				$("#blockListTable").find("tbody").html(`
						<tr>
		            	    <td colspan="2" class="emptyList text-center p-5">수신차단 목록이 없습니다.</td>
			            </tr>`);				
			}
		});
	});
    
    $("#oufOfOfficeSave").on("click", function () {
		let outOfOfficeTitle = $("#outOfOfficeTitle").val();
		let outOfOfficeContent = $("#outOfOfficeContent").val();
		let outOfOfficeSave = $("input[name='inlineRadioOptions']:checked").val();
		axios({
			url : "/mail/outOfOfficeSave.do",
			method : "post",
			data : JSON.stringify({title : outOfOfficeTitle, content : outOfOfficeContent, outOfOfficeSave : outOfOfficeSave, outOfOfficeIsExist : outOfOfficeIsExist}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			requiredAlert(res, isAlertVisible);
		});
	});
});

function getBlockWordList() {
	axios({
		url : "/mail/getBlockWordList.do",
		method : "get",
	}).then(function (response) {
		let res = response.data;
		console.log(res);
		let blockWordListHTML = "";
		if (res.length) {
			for (var i = 0; i < res.length; i++) {
				blockWordListHTML += `
							          <tr>
							              <td style='border-right:0'>\${res[i].blockWord}</td>
							              <td class="d-flex flex-row justify-content-center" style='border-left:0'><button class="btn py-0 px-1 fs-9 deleteBtn align-center" data-no="\${res[i].bwNo}"><span class="far fa-trash-alt me-1"></span><span>삭제</span></button></td>
							          </tr>				
									`;
			}
		}else {
			blockWordListHTML += `
								<tr>
					        	    <td colspan="2" class="emptyList text-center p-5">차단단어 목록이 없습니다.</td>
					            </tr>	
								`;
		}
        $("#blockWordTable").find("tbody").html(blockWordListHTML);
	});
}

function getBlockList() {
	axios({
		url : "/mail/getBlockList.do",
		method : "get",
	}).then(function (response) {
		let res = response.data;
		console.log(res);
		let blockListHTML = "";
		if (res.length) {
			for (var i = 0; i < res.length; i++) {
				blockListHTML += `
							          <tr>
							              <td style='border-right:0'>\${res[i].blockedMemEmail}</td>
							              <td class="d-flex flex-row justify-content-center" style='border-left:0'><button class="btn py-0 px-1 fs-9 deleteBtn align-center" data-no="\${res[i].blNo}"><span class="far fa-trash-alt me-1"></span><span>삭제</span></button></td>
							          </tr>				
									`;
			}
		}else {
			blockListHTML += `
								<tr>
					        	    <td colspan="2" class="emptyList text-center p-5">수신차단 목록이 없습니다.</td>
					            </tr>	
								`;
		}
        $("#blockListTable").find("tbody").html(blockListHTML);
	});
}

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

function validEmail(emailVal) {
	let regexp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	return regexp.test(emailVal);
}
</script>