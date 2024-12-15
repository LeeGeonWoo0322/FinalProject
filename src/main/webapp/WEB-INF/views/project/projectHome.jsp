<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 	
 <style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
}

h3 {
	margin: 20px;
}

/* My Surveys Section */
.survey-container {
	display: flex;
	align-items: center;
}

.arrow {
	cursor: pointer;
	font-size: 2em;
	user-select: none;
}

.survey-cards {
	display: flex;
	overflow: hidden;
	width: 1000px;
}

.survey-card {
	flex: 0 0 200px;
	margin: 0 10px;
	padding: 20px;
	background-color: #f1f1f1;
	text-align: center;
	border-radius: 10px;
}

/* Recently Created Surveys Section */
.survey-list {
	margin-top: 30px;
}

.survey-list table {
	width: 100%;
	border-collapse: collapse;
}

.survey-list th, .survey-list td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: left;
}

.tag {
	padding: 3px 8px;
	border-radius: 5px;
	color: white;
}

.tag.not-participated {
	background-color: #ff6b6b;
}

.tag.participated {
	background-color: #6bcf6b;
}
</style>
  
<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->

								
<!-- ========================= 홈 리스트 화면 ================================ -->
	<div class="d-flex flex-column w-100 ms-3">
		<div class="row g-3 mb-2">
			<div class="card mb-3">
				달력모양    <span class="far fa-chart-bar"></span>
				<div class="me-n3">
					<div class="p-2 position-relative">
						<div class="row">
							<div class="col-lg-8">
								<h4 class="mb-0"><b>즐겨찾기 프로젝트</b></h4>
								<div class="survey-container">
									<div class="arrow" id="prev">&#9664;</div>
										<div class="survey-cards">
										<c:choose>
											<c:when test="${empty pro}">
												<div class="survey-card" style="flex: 0 0 200px; margin: 0 10px; padding: 15px; background-color: white; border: 1px solid #ccc; border-radius: 10px; position: relative; text-align: left;">
													<div>
														<span><i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i></span>
													</div>
													<h3 class="survey-title" style="font-size: 1.2em; margin: 20px 0 10px;">
														즐겨찾기 된 프로젝트가 없습니다.
													</h3>
													<p class="survey-duration" style="font-size: 0.8em; color: gray;">
													
													</p>
													<p class="survey-author" style="font-size: 0.9em; margin: 5px 0;">
													
													</p>
													<p class="survey-visibility" style="font-size: 0.9em; margin: 5px 0;">
													
													</p>
												</div>
											</c:when>
											<c:otherwise>
												<c:forEach items="${pro }" var="pro" varStatus="i">
														<div class="survey-card" style="flex: 0 0 200px; margin: 0 10px; padding: 15px; background-color: white; border: 1px solid #ccc; border-radius: 10px; position: relative; text-align: left;">
															<div>
																<span><i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i></span>
															</div>
															<h3 class="survey-title" style="font-size: 1.2em; margin: 20px 0 10px;">
																${pro.projectTitle }
															</h3>
															<p class="survey-duration" style="font-size: 0.8em; color: gray;">
																2024.10.10	- 2024.10.17
															</p>
															<p class="survey-author" style="font-size: 0.9em; margin: 5px 0;">
															담당자: ${pro.mngPicNo }
															</p>
															<p class="survey-visibility" style="font-size: 0.9em; margin: 5px 0;">
															결과 공개 여부: 공개
															</p>
															  <input type="hidden" id="projectNo${pro.projectNo }" value="${pro.projectNo }">
															<button class="participate-btn" style="width: 30ex; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;" onclick=detailPaging(${pro.projectNo})>
															  상세보기
															</button> 
														</div>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										</div>
											<div class="arrow" id="next">&#9654;</div>
										</div>
								
							</div>
						</div>
					</div>
					<!-- 수신 관련 게시판들, 한 줄에 두 개씩 나열 -->
					<div class="row g-3 mb-2">
						<div class="col-lg-6">
						
						</div>
					</div>
					<br/>
				<div class="p-2 position-relative">
						<div class="row">
							<div class="col-lg-8">
								<h4 class="mb-0"><b>그룹 프로젝트</b></h4>
							</div>
						</div>
					</div>
					<!-- 수신 관련 게시판들, 한 줄에 두 개씩 나열 -->
					<div class="row g-3 mb-2">
						<div class="col-lg-6">
							<h5>담당 프로젝트</h5>
						<div class="d-flex flex-column p-2 position-relative" data-list='{"valueNames":["name","title","date","size"],"page":5}'>
							<div class="table-responsive scrollbar">
								<table class="table table-bordered border-500 fs-10 mb-0" style="border-collapse: collapse;">
									<thead class="bg-200">
										<tr>
											<th class="text-900 sort" style="width: 9%">-</th>
											<th class="text-900 sort">제목</th>
											<th class="text-900 sort">업무</th>
										</tr>
									</thead>	
									<tbody class="list">
							           <c:choose>
											<c:when test="${empty pro}">
											<tr>
												<td>즐겨찾기 된 프로젝트가 없습니다.</td>
											</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${pro }" var="pro" varStatus="i">
													<tr>
														 <td class="name align-middle text-500">
															<span><i class="bi bi-star"></i></span>
														</td>
											            <td class="title align-middle text-500">
											            <a href="/project/projectDetail/\${pro.workNo }"></a>
											            ${pro.projectTitle }</td>
													    <td class="size align-middle text-500">${paVO[i.index] }</td>  
										             </tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
	        						</tbody>
								</table>
							</div>
						</div>
					</div>
						<div class="col-lg-6">
							<h5>참여 프로젝트</h5>
						<div class="d-flex flex-column p-2 position-relative" data-list='{"valueNames":["name","title","date","size"],"page":5}'>
							<div class="table-responsive scrollbar">
								<table class="table table-bordered border-500 fs-10 mb-0" style="border-collapse: collapse;">
									<thead class="bg-200">
										<tr>
											<th class="text-900 sort" style="width: 9%">-</th>
											<th class="text-900 sort">제목</th>
											<th class="text-900 sort">업무</th>
										</tr>
									</thead>
									<tbody class="list">
							           <c:choose>
											<c:when test="${empty pro}">
											<tr>
												<td>즐겨찾기 된 프로젝트가 없습니다.</td>
											</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${pro }" var="pro" varStatus="i">
													<tr>
														 <td class="name align-middle text-500">
															<span><i class="bi bi-star"></i></span>
														</td>
											            <td class="title align-middle text-500">${pro.projectTitle }</td>
													    <td class="size align-middle text-500">${paVO[i.index] }</td>  
										             </tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
	        						</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
			
<!-- ========================= 홈 리스트 화면 끝================================ -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		let currentPosition = 0;
		const cardWidth = 220; // 200px card width + 10px margin on each side
		const visibleCards = 3;
		const totalCards = $('.survey-card').length;
	
		$('#next').click(function() {
			if (currentPosition > -(totalCards - visibleCards) * cardWidth) {
				currentPosition -= cardWidth;
				$('.survey-cards').animate({
					scrollLeft : -currentPosition
				}, 300);
			}
		});
	
		$('#prev').click(function() {
			if (currentPosition < 0) {
				currentPosition += cardWidth;
				$('.survey-cards').animate({
					scrollLeft : -currentPosition
				}, 300);
			}
		});
	});
	
	function detailPaging(e){
		var projectNo = $('#projectNo'+e).val();
		location.href = "/project/projectDetail/"+projectNo;
	}

	var txt = '';
		function favoritN(e){
			console.log("d");
		
		}
		function favoritY(e){
			console.log("d");
		
		}
		
	$(function(){
		
	})


</script>

<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->
  