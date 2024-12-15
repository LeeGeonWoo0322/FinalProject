<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
  <style>
  	.table caption{
  		caption-side : top;
  	}
  </style>
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	
	<div class="d-flex flex-column w-100 scrollbar" style="text-align: center;">
		<table class="table table-bordered border-500 fs-10 mb-0 w-75" align="center">
			<caption><h2>내 인사정보</h2></caption>
			<thead>
				<tr>
					<td class="bg-200">사진</td>
					<td class="bg-200">이름</td>
					<td class="bg-200">소속</td>
					<td colspan="3">기술 개발 본부</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="3"></td>
					<td rowspan="3">${member.memName}</td>
					<td class="bg-200">사번</td>
					<td>527352</td>
					<td class="bg-200">내선번호</td>
					<td>123-456-7890</td>
				</tr>
				<tr>
					<td class="bg-200">이메일</td>
					<td>chmod754@gmail.com</td>
					<td class="bg-200">휴대전화</td>
					<td>01055551234</td>
				</tr>
				<tr>
					<td class="bg-200">직책</td>
					<td>사원</td>
					<td class="bg-200">대표전화</td>
					<td>04255551234</td>
				</tr>
			</tbody>
		</table>
			
			<!-- 기본  -->
			<div id="basic">
				<table class="table table-bordered border-500 fs-10 mb-0 w-75" align="center">
					<caption><h4>기본 정보</h4></caption>
					<tbody>
						<tr>
							<td class="bg-200">입사일</td><td>2024/10/01</td> <td class="bg-200">직무</td><td>평가</td> <td class="bg-200">부서</td><td>인사</td>
						</tr>
						<tr>
							<td class="bg-200">상태</td><td>재직중</td><td class="bg-200">생년월일</td><td>2001/04/14</td><td class="bg-200">주소</td><td>대전시 서구 어디지</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<!-- 인사평가  -->
			<div id="evaluation">
				<table class="table table-bordered border-500 fs-10 mb-0 w-75" align="center">
					<caption><h4>인사 평가</h4></caption>
					<thead>
						<tr>
							<th class="bg-200">평가일</th>
							<th class="bg-200">역량</th>
							<th class="bg-200">평가작성자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2024/10/10</td>
							<td>A</td>
							<td>DDIT</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<!-- 자격  -->
			<div id="career">
				<table class="table table-bordered border-500 fs-10 mb-0 w-75" align="center">
					<caption><h4>자격</h4></caption>
					<thead>
						<tr>
							<th class="bg-200">자격증 이름</th>
							<th class="bg-200">자격증 취득일</th>
							<th class="bg-200">자격증 만료일</th>
							<th class="bg-200">발급 기관</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>정보처리기사</td>
							<td>2024/12/11</td>
							<td>-</td>
							<td>한국산업인력공단</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<!-- 경력  -->
			<div id="certificate">
				<table class="table table-bordered border-500 fs-10 mb-0 w-75" align="center">
					<caption><h4>경력 정보</h4></caption>
					<thead>
						<tr>
							<th class="bg-200">경력 이름</th>
							<th class="bg-200">시작일</th>
							<th class="bg-200">종료일</th>
							<th class="bg-200">근무처</th>
							<th class="bg-200">직급</th>
							<th class="bg-200">담당업무</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>ddit</td>
							<td>2021/04/05</td>
							<td>2023/04/31</td>
							<td>저기</td>
							<td>대리</td>
							<td>이것저것</td>
						</tr>
					</tbody>
				</table>
			</div>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
$(function () {

})
</script>