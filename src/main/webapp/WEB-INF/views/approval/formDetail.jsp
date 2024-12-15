<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card">
		<button class="btn btn-info" id="favoriteApprRegister">결재상신</button>
		${approvalFormVO.formContent }
		<form action="/approval/register.do" method="post" id="favoriteApprRegisterForm">
			<input type="hidden" name="formNo" value="${approvalFormVO.formNo }">
			<input type="hidden" name="approvalLine" value="">
			<input type="hidden" name="referenceList" value="">
			<input type="hidden" name="readList" value="">
		</form>
	</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#favoriteApprRegister').on('click',function(){
		$('#favoriteApprRegisterForm').submit();
	});
});

</script>
</html>