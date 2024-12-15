<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.table caption{
		caption-side : top;
	}
</style>
<div class="d-flex flex-column bg-100 w-100 p-3">
	<div>
		<span>조직 관리</span>
		<h4>조직설계</h4>
	</div>
	<div class="d-flex flex-row">
		<div class="card p-3 scrollbar me-3" style="height: 81vh;width: 300px">
			<div class="d-flex flex-column">
				<h5>조직도</h5>
				<div class="d-flex flex-row d-gap gap-1 align-middle">
					<span class="text-900">부서</span>
					<button class="btn btn-secondary px-2 py-0" type="button" data-bs-toggle="modal" data-bs-target="#addDept"><i class="bi bi-plus-lg me-1"></i></button>
					<button class="btn btn-secondary px-2 py-0" type="button" id="delDept"><i class="bi bi-x-lg me-1"></i></button>
				</div>
				<div>
				<ul class="mb-0 treeview" id="deptList">
				  <li class="treeview-list-item">
				    <a data-bs-toggle="collapse" href="#deptList-1-1" role="button" aria-expanded="false">
				      <p class="treeview-text">
				        대덕인재회사</p>
				    </a>
				    <ul class="collapse treeview-list" id="deptList-1-1" data-show="false">
					<!-- 
						부서 리스트 출력부분
					 -->
				    </ul>
				  </li>
				</ul>
				</div>
			</div>
		</div>
		<div class="card p-3" style="height: 100%;width: 100%;">
			<div class="d-flex flex-column">
				<div id="deptName"></div>
				<div>
					<table>
						<colgroup>
							<col width="100px">
							<col width="300px">
						</colgroup>
						<tbody>
							<tr>
								<th>부서 코드</th>
								<td id="deptNo"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

	<!-- 부서 추가 모달창 시작 -->
	<div class="modal fade" id="addDept" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	      	<table class="table table-bordered fs-10 mb-0">
	      		<caption><h3>부서 추가</h3></caption>
	      		<tbody>
	      			<tr>
	      				<td>부서명</td>
	      				<td><input type="text" id="modalDeptName"></td>
	      			</tr>
	      			<tr>
	      				<td>부서번호</td>
	      				<td><input type="text" id="modalDeptNo"></td>
	      			</tr>
	      		</tbody>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
	        <button class="btn btn-info" type="button" id="btnAddDept" data-bs-dismiss="modal"> 추가 </button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
	
	<!-- 부서 삭제 모달창 시작 -->
	<div class="modal fade" id="delDept" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	    <div class="modal-content position-relative">
	      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-0">
	      <h2>삭제시 해당 부서원들의 부서도 사라집니다.</h2>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-primary" type="button" data-bs-dismiss="modal">취소</button>
	        <button class="btn btn-danger" type="button" id="btndelDept" data-bs-dismiss="modal">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 종료 -->
<script>
$(function(){
	var btnAddDept = $("#btnAddDept");
	var btnDelDept = $("#btnDelDept");
	
	printDept();
	
	btnAddDept.on("click", function(){
		var modalDeptName = $("#modalDeptName").val();
		var modalDeptNo = $("#modalDeptNo").val();
		
		$.ajax({
			url : "/admin/organization/addDept",
			method : "post",
			data : JSON.stringify({
				deptNo : modalDeptNo,
				deptName : modalDeptName
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res);
			}
		})
	})
	
	function printDept(){
		$.ajax({
			url : "/admin/organization/printDept",
			method : "post",
			contentType : "application/json; charset=utf-8",
			success : function(res){
				var printDept = "";
				$.each(res, function (idx, val) {
					console.log(val.deptName); 
					printDept += `
						<li class="treeview-list-item">
							<div class="treeview-item">
								<p class="treeview-text">
									<a class="deptList flex-1" href="#" data-dept-no="\${val.deptNo}">\${val.deptName}</a>
								</p>
							</div>
						</li>
						`
				})
				$("#deptList-1-1").html(printDept);
			}
		})
	}
	
	$(document).on('click','.deptList',function(){
		var deptNo = $(this).data("dept-no")
		$.ajax({
			url : "/admin/organization/deptDetail",
			method : "post",
			data : JSON.stringify({
				deptNo : deptNo
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res) {
				var printDeptName = "";
				printDeptName =
							`
								<h4>\${res.deptName}</h4>	
							`
				$("#deptName").html(printDeptName);
				
				var printDeptNo = "";
				printDeptNo =
						`
							\${res.deptNo}
						`
				$("#deptNo").html(printDeptNo);
			}
		})
	})
	
})
</script>