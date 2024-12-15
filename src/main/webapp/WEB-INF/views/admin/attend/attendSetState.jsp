<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <style>
  	.table caption{
  		caption-side : top;
  	}
  </style>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<div class="d-flex flex-column ms-3 w-75 scrollbar">
		<div class="card mb-3">
			<div class="table-responsive">
				<table class="table table-bordered fs-10 mb-0 w-75" align="center">
				<caption><h3>업무 유형 설정</h3></caption>
					<thead class="bg-100">
						<tr>
							<th class="text-900 sort">항목</th>
							<th class="text-900 sort">근무시간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="text-900 sort">업무</td>
							<td class="text-900 sort">포함</td>
						</tr>
						<tr>
							<td class="text-900 sort">업무종료</td>
							<td class="text-900 sort">포함안함</td>
						</tr>
						<tr>
							<td class="text-900 sort">외근</td>
							<td class="text-900 sort">포함</td>
						</tr>
						<tr>
							<td class="text-900 sort">출장</td>
							<td class="text-900 sort">포함</td>
						</tr>
					</tbody>
				</table>
				<button class="btn btn-falcon-default me-1 mb-1" type="button" >추가</button>
			</div>
		</div>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
$(function () {

})
</script>