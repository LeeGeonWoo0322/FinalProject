<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Approval Form</title>
</head>
<style>
    /* 테두리 및 여백 스타일 추가 */
    .content-wrapper {
        border: 1px solid #ddd; /* 연한 회색 테두리 */
        padding: 15px; /* 내부 패딩 추가 */
        margin-left: 10px; /* 오른쪽으로 이동 */
        border-radius: 5px; /* 모서리 둥글게 */
        text-align: center
    }
</style>
<body>
	<div class="container mt-4">
		<div class="card p-4 shadow-sm h-100">
			<!-- 양식 정보 표시 -->
			<div class="mb-4">
				<h5 class="card-title fw-bold mb-1">${approvalFormVO.formTitle}</h5>
				<p class="mb-1 text-muted">카테고리: ${approvalFormVO.formCategory}</p>
				<p class="mb-3 text-muted">생성 날짜: ${approvalFormVO.regDate}</p>
			</div>

			<!-- 양식 내용 -->
			<div class="scrollbar mb-4 align-center content-wrapper">
				<div style="text-align: center;">
					${approvalFormVO.formContent}
				</div>
			</div>

			<!-- 수정 및 삭제 버튼 -->
			<div class="d-flex justify-content-end">
				<button type="button" id="updateBtn" class="btn btn-dark me-2">수정</button>
				<button type="button" id="deleteBtn" class="btn btn-danger">삭제</button>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	const formNo = "${approvalFormVO.formNo}";
	$('#updateBtn').on('click',function(){
		location.href="/admin/approval/update.do?formNo=" + formNo;
	});
	
	$('#deleteBtn').on('click',function(){
		Swal.fire({
			  title: "양식을 삭제하시겠습니까?",
			  text: "삭제된 양식은 다시 복구되지 않습니다!",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네, 삭제하겠습니다!",
			  cancelButtonText: "이전으로"
			}).then((result) => {
			  if (result.isConfirmed) {
				  location.href="/admin/approval/delete.do?formNo=" + formNo;
			  }
			});
		
	});
});
</script>
</html>
