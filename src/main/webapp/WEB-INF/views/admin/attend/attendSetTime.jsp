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
			<div class="p-2 position-relative">
				<div class="row">
					<div class="col-lg-8">
						<h4 class="mb-0"><b>근무 그룹 설정</b></h4>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-3">
			<label class="form-label">그룹명</label>
			<input class="form-control" id="groupName" type="text"/>
			<label class="form-label">업무 시작</label>
			<input class="form-control" id="workStartH" type="text"/>
			<input class="form-control" id="workStartM" type="text"/>
			<input class="form-control" id="workStarts" type="text"/>
			<label class="form-label">점심 시작 시간</label>
			<input class="form-control" id="lunchStartH" type="text"/>
			<input class="form-control" id="lunchStartM" type="text"/>
			<input class="form-control" id="lunchStartS" type="text"/>
			<label class="form-label">점심 종료 시간</label>
			<input class="form-control" id="lunchEndH" type="text"/>
			<input class="form-control" id="lunchEndM" type="text"/>
			<input class="form-control" id="lunchEndS" type="text"/>
			<label class="form-label">최대 근무 시간</label>
			<input class="form-control" id="MaxTimeH" type="text"/>
			<input class="form-control" id="MaxTimeM" type="text"/>
			<input class="form-control" id="MaxTimes" type="text"/>
			<label class="form-label">최소 근무 시간</label>
			<input class="form-control" id="MinTimeH" type="text"/>
			<input class="form-control" id="MinTimeM" type="text"/>
			<input class="form-control" id="MinTimeS" type="text"/>
		</div>
		<div class="card mb-3">
			<table>
				<thead>
					<tr>
						<th>그룹명</th>
						<th>근무시간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>근무 유형 A</td>
						<td>09:00:00 ~ 18:00:00</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script src="vendors/flatpickr/flatpickr.min.js"></script>
<script type="text/javascript">
$(function () {

})
</script>