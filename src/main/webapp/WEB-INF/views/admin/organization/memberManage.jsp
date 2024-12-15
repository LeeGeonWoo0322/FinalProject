<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.table caption{
		caption-side : top;
	}
</style>
<div class="d-flex flex-column bg-100 w-100 p-3">
	<div>
		<span>조직 관리</span>
		<h4>사원통합관리</h4>
	</div>
	<div class="card w-100 p-3" style="height: 100%">
		<div class="d-flex flex-column mb-2">
			<div>
				총 계정 수 : <span id="count"></span>&nbsp;&nbsp;
				정상 계정 수 : <span id="enabled1Mem"></span>&nbsp;&nbsp;
				탈퇴된 계정 수 : <span id="enabled2Mem"></span>
			</div>
			<div class="d-flex flex-row justify-content-between">
				<div class="d-flex flex-row align-items-center d-gap gap-1 align-middle">
					<button class="btn btn-secondary" type="button" id="createMem" data-bs-toggle="modal" data-bs-target="#createMemModal"><i class="bi bi-plus-lg me-1"></i>계정 생성</button>
					<div class="btn-group">
						<button class="btn dropdown-toggle btn-secondary" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="bi bi-person me-1"></i>직위 변경</button>
						<div class="dropdown-menu" id="dropdown-pos">
							<a class="dropdown-item" href="#">직위 변경</a>
							<a class="dropdown-item" href="#">계정상태 변경</a>
						</div>
					</div>
					<button class="btn btn-secondary" type="button" id="delBtn"><i class="bi bi-x-lg me-1"></i>계정 삭제</button>
					
					<!-- EXCEL 다운로드 버튼 -->
					<form action="/admin/organization/excelDown" method="post" enctype="multipart/form-data" id="downloadForm">
						<button class="btn btn-secondary" type="button" id="excelDown"><i class="bi bi-download me-1"></i>목록 다운로드</button>
					</form>
					<!-- EXCEL 다운로드 버튼 -->
					
				</div>
				<div>
					<form class="px-1 search-box align-middle" action="/admin/organization/memberManage" method="get">
					    <div class="position-relative">
					        <input class="form-control search-input" type="text" value="${searchWord }" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/>
					        <span class="fas fa-search search-box-icon"></span>
					    </div>
					</form>
				</div>
			</div>
		</div>
		<div id="tableExample2" data-list='{"valueNames":["name","pos","email","status"],"page":10,"pagination":true}'>
			<div class="table-responsive scrollbar" style="min-height: 550px">
				<table class="table table-bordered mb-0" style="font-size: 15px">
					<thead class="bg-200" id="memListTable">
						<tr>
							<th class="text-900"><input type='checkbox' class='form-check-input' id="allCheckBox"></th>
							<th class="text-900 sort" data-sort="name">이름</th>
							<th class="text-900 sort" data-sort="pos">직위</th>
							<th class="text-900 sort" data-sort="email">이메일</th>
							<th class="text-900 sort" data-sort="status">계정상태</th>
						</tr>
					</thead>
					<tbody class="list" id="memList">
						<c:set value="${ memberList}" var="memberList"/>
							<c:forEach items="${memberList }" var="member">
								<tr data-memno="${member.memNo }">
									<td><input type='checkbox' class='form-check-input'></td>
									<td class="name">${member.memName }</td>
									<td class="pos">${member.posName }</td>
									<td class="email">${member.memEmail }</td>
									<c:choose>
										<c:when test="${member.enabled == 1}">
											<td class="status"><span class="badge badge-subtle-success">정상</span></td>
										</c:when>
										<c:otherwise>
											<td class="status"><span class="badge badge-subtle-danger">탈퇴</span></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			 	 <ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			</div>
		</div>
	</div>
	
	<!-- 모달창 시작 -->
	<div class="modal fade" id="createMemModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<table class="table table-bordered fs-10 mb-0">
	      		<caption><h3>사원 생성</h3></caption>
	      		<tbody>
	      			<tr>
	      				<td>이름</td>
	      				<td> <input type="text" id="modalName"> </td>
	      				<td>부서</td>
	      				<td> <select id="modalDept">
	      					<option>재무부</option>
	      					</select> </td>
	      				<td>직급</td>
	      				<td> <select id="modalPos">
	      					<option>부장</option>
	      					</select> </td>
	      			</tr>
	      			<tr>
	      				<td>아이디</td>
	      				<td> <input type="text" id="modalPass"> </td>
	      				<td>비밀번호</td>
	      				<td> <input type="password"> </td>
	      				<td>고용일</td>
						<td> <input type="date"> </td>	      				
	      			</tr>
	      		</tbody>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-primary" type="button" data-bs-dismiss="modal">취소</button>
	        <button class="btn btn-primary" type="button" id="atstateUpdate" data-bs-dismiss="modal"> 수정 </button>
	        <button class="btn btn-danger" type="button" id="atstateDelete" data-bs-dismiss="modal"> 삭제 </button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	
</div>
<script>
$(function() {
	var createMem = $("#createMem");
	
	// 부서생성
	createMem.on("click", function(){
		
	})
	
	printModalDept();
	printModalPos();
	memcount();
	enabled1Mem();
	enabled2Mem();
	dropDownPos();
	
	// 모달 부서 선택
	function printModalDept() {
		$.ajax({
			url : "/admin/organization/printDept",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res)
				var printModalDept
				$.each(res, function (index, value) {
					console.log(value)
					printModalDept += 
						
						`<option value="\${value.deptNo}">\${value.deptName}</option>`
				})
					$("#modalDept").html(printModalDept)
			}
		})
	}
	
	// 모달 직급 선택
	function printModalPos() {
		$.ajax({
			url : "/admin/organization/printPos",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res)
				var printModalPos
				$.each(res, function (index, value) {
					console.log(value)
					printModalPos += 
						
						`<option value="\${value.posNo}">\${value.posName}</option>`
				})
					$("#modalPos").html(printModalPos)
			}
		})
	}
	
	// 모달에서 부서 바꿀시 
	console.log($("#modalDept option:selected").val());
	$("#modalDept").on("change", function() {
		console.log($("#modalDept option:selected").val());
	})
	
	// 직원 목록 다운로드
	$("#excelDown").on("click", function(){
		Swal.fire({
			  title: "회원 목록을 다운로드 하시겠습니까?",
			  icon: "question",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네",
			  cancelButtonText: "아니요"
			}).then((result) => {
				if (result.isConfirmed) {
					$("#downloadForm").submit();
				  }
		});
	})
	
	function memcount() {
		$.ajax({
			url : "/admin/organization/memCount",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res);
				
				$("#count").html(res);
			}
		})
	}
	
	function enabled1Mem() {
		$.ajax({
			url : "/admin/organization/enabled1Mem",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res);
				
				$("#enabled1Mem").html(res);
			}
		})
	}
	
	function enabled2Mem() {
		$.ajax({
			url : "/admin/organization/enabled2Mem",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res);
				
				$("#enabled2Mem").html(res);
			}
		})
	}
	
	let checkedMemNoList = [];
	$("#memList").on("change", ".form-check-input", function(){
		checkedMemNoList = []; 
		let checked = $("#memList .form-check-input:checked");
		// data-memno에 저장된 memNo 출력
		console.log(checked.closest("tr").data("memno"));
		
		// checked에 들어오는 값을 checkedMemNoList 배열에 대입
		for (var i = 0; i < checked.length; i++) {
			checkedMemNoList.push(checked.eq(i).closest("tr").data("memno"));
		}
		
		console.log(checkedMemNoList);
		let checkedCount = checked.length;
	    let totalCount = $('#memList .form-check-input').length;
	    console.log(totalCount)
		let allChecked = checkedCount === totalCount;
	    
	    console.log(allChecked)
		
		$('#allCheckBox').prop('checked', allChecked);
		
	})
	
	$("#memListTable").on("change", "#allCheckBox", function () {
		if ($(this).is(":checked")) {
			$("#memList .form-check-input").prop("checked", true);
			for (var i = 0; i < $("#memList .form-check-input:checked").length; i++) {
				checkedMemNoList.push($("#memList .form-check-input:checked").eq(i).closest("tr").data("memno"));
			}
			console.log(checkedMemNoList);
		}else {
			$("#memList .form-check-input").prop("checked", false);
			checkedMemNoList = [];
			console.log(checkedMemNoList);
		}
	});
	
	// 삭제하기 버튼
	$("#delBtn").on("click", function() {
    	console.log(checkedMemNoList)
		Swal.fire({
			  title: "선택한 직원계정을 삭제하시겠습니까?",
			  text: "",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네, 삭제하겠습니다!",
			  cancelButtonText: "이전으로"
			}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						  url : "/admin/organization/delete",
						  method : "post",
						  data : JSON.stringify({
							  checkedMemNoList : checkedMemNoList
							}),
							contentType : "application/json; charset=utf-8",
							success : function(res){ 
								if (res == 0){
									Swal.fire({
										  position: "center",
										  icon: "warning",
										  title: "삭제 실패",
										  text: "잘못된 멤버를 선택하셨습니다.",
										  timer: 1500,
//	 									  willClose: () => {
//	 										  window.location.href = "/address/main"
//	 									  }
									  }, 100);
								} else{
								Swal.fire({
									  position: "center",
									  icon: "success",
									  title: "삭제완료!",
									  text: "삭제가 정상적으로 되었습니다.",
									  timer: 1500,
									  willClose: () => {
										  window.location.href = "/admin/organization/memberManage"
									  }
								  }, 100);
								}
							}
					  })
				  	}
			 	});
	})
	
	function dropDownPos() {
		$.ajax({
			url : "/admin/organization/printPos",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res) {
				var printPos = "";
				$.each(res, function(idx,val) {
					printPos +=
						`
							<a class="dropdown-item" href="#" data-posno="\${val.posNo}">\${val.posName}</a>
						`
				})
				$("#dropdown-pos").html(printPos);
			}
		})
	}
	
	$("#dropdown-pos").on("click",".dropdown-item",function(){
		var posNo = $(this).data("posno");
		
		$.ajax({
			url : "/admin/organization/changePos",
			method : "post",
			data : JSON.stringify({
				checkedMemNoList : checkedMemNoList,
				posNo : posNo
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				window.location.href = "/admin/organization/memberManage";
			}
		})
	})
	
})
</script>