<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
body {
	font-family: Arial, sans-serif;
}

.arrow {
	cursor: pointer;
	font-size: 3em;
	user-select: none;
}

.survey-cards {
  transition: transform 0.5s ease;
}

 
</style>


<div class="d-flex flex-column w-100 position-relative">
	<h3 class="text-center align-middle" style="height: 70px;line-height: 70px">즐겨찾기 프로젝트</h3>
	<div class="survey-container d-flex flex-row justify-content-center w-100 mb-5">
		<div class="arrow d-flex justify-content-center align-items-center" style="width: 10%" id="prev"><div>◀</div></div>
		<div class="d-flex flex-row survey-cards" style="width:1080px;overflow-x: hidden; ">
			<!-- 각각의 즐겨찾기된 work 구역 -->
			<input type="hidden" id="loginMem" value="${pro.loginMem[0].memNo }">
			<c:choose>
				<c:when test="${empty pro.favorWork }">
					<div class="survey-card" style="padding: 10px;margin: 0 10px; background-color: white; border: 1px solid #ccc; border-radius: 10px; position: relative; text-align: left;flex: 0 0 250px">
						<div>
						</div>
						<h4 class="survey-title" style="font-size: 1.2em; margin: 20px 0 10px;">
							즐겨찾기 된 업무가 없습니다.
						</h4>
						<p class="survey-duration" style="font-size: 0.8em; color: gray;">
						</p>
						<p class="survey-author" style="font-size: 0.9em; margin: 5px 0;">
						</p>
						<p class="survey-visibility" style="font-size: 0.9em; margin: 5px 0;">
						</p>
						  <input type="hidden" id="projectNo101" value="101">
						<button class="participate-btn" style="width: 100%; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;" >
						</button> 
					</div>
				</c:when>   
				
				<c:otherwise>
					<c:forEach items="${pro.favorWork}" var="favorite">
						<div class="survey-card" id="favor${favorite.workNo }" style="padding: 10px;margin: 0 10px; background-color: white; border: 1px solid #ccc; border-radius: 10px; position: relative; text-align: left;flex: 0 0 250px">
								<div>
									<span><i class="bi bi-star-fill" style="color:orange;cursor:pointer; font-size: 24px;" onclick=delFavorites(${favorite.workNo})></i></span>
								</div>
							<table class="m-1" style="width: 250px">
								<tr>
									<th class="survey-titletext-truncate"  style="font-size: 0.9em; margin: 20px 0 10px; max-width: 250px; font: bold;">
										업무명
									</th>
		 							<td class="survey-title text-truncate" style="font-size: 0.9em; margin: 20px 0 10px;max-width: 200px;">
										${favorite.workTitle }
									</td>
								</tr>
								<tr>
									<th><p class="survey-duration" style="font-size: 0.9em; margin: 5px 0">일정  </p></th>
									<td><p class="survey-duration" style="font-size: 0.9em; margin: 5px 0"> ${favorite.regDate } ~ ${favorite.endDate }</p></td>
								</tr>
								<tr>
									<th>
										<p class="survey-author" style="font-size: 0.9em; margin: 5px 0;">
										<span class="d-inline-block text-truncate" style="max-width: 250px;">담당자 </span>
										</p>
									</th>
									<td>
										<div class="d-flex flex-row text-truncate" style="max-width: 200px;"">
											<p class="survey-author" style="font-size: 0.9em; margin: 5px 0;">
											<c:forEach items="${favorite.faPicList }" var="pic">
												<span class="border rounded-5 bg-info-subtle ms-1 px-1" style="font-size: 13px;color: black;">${pic.memName } ${pic.posName } </span>
											</c:forEach> 
											</p>
										</div>	
									</td>
								</tr>
								<tr>
									<th>
										<p class="survey-visibility" style="font-size: 0.9em; margin: 5px 0;">
											상태
										</p>
									</th>
									<td>
										<p class="survey-visibility" style="font-size: 0.9em; margin: 5px 0;">
										<c:choose>
											<c:when test="${favorite.workPrograss eq 'wait' } ">대기중</c:when>
											<c:when test="${favorite.workPrograss eq 'ing' } ">진행중</c:when>
											<c:otherwise>완료</c:otherwise>
										</c:choose>
										</p>
									</td>
								</tr>
							</table>
							  <input type="hidden" id="projectNo${favorite.projectNo }" value="${favorite.projectNo }">
							  <input type="hidden" id="workNo${favorite.workNo }" value="${favorite.workNo }">
							<button class="participate-btn" style="width: 100%; height: 40px; background-color: white; color: black; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; font-size: 0.8em; display: block;" onclick=detailPaging(${favorite.projectNo},${favorite.workNo})>
							  상세보기
							</button> 
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose> 
			<!-- 각각의 즐겨찾기된 work 구역  종료-->
		</div>
		<div class="arrow d-flex justify-content-center align-items-center" style="width: 10%" id="next"><div>▶</div></div>
	</div>
	<h3 class="text-center align-middle" style="height: 70px;line-height: 70px">그룹 프로젝트</h3>
	<div class="d-flex flex-row justify-content-center w-100 px-5">
		<div id="tableExample2" class="w-100" data-list='{"valueNames":["Rownum","projectTitle","mngPic","attendee","work"],"page":5,"pagination":true}'>
			<div class="table-responsive scrollbar" style="min-height: 275px">
				<table class="table table-bordered table-striped fs-10 mb-0">
					<thead class="bg-200">
						<tr>
							<th class="text-900 sort text-center">No.</th>
							<th class="text-900 sort text-center" >프로젝트명</th>
							<th class="text-900 sort text-center" >담당자</th>
							<th class="text-900 sort text-center" >참여자</th>
							<th class="text-900 sort text-center" >기간</th>
						</tr>
					</thead>
					<tbody class="list">
					<c:choose>
						<c:when test="${empty pro }">
							<tr>
								<td class="Rownum" style="text-align: center; vertical-align: middle;">-</td>
								<td class="projectTitle" style="text-align: center; vertical-align: middle;"></td>
								<td class="mngPic" style="text-align: center; vertical-align: middle;">현재 프로젝트가 없습니다.</td>
								<td class="attendee" style="text-align: center; vertical-align: middle;"></td>
								<td class="ing" style="text-align: center; vertical-align: middle;"></td>
							</tr>
						</c:when>
					 	<c:otherwise>
							<c:forEach items="${pro.project }" var="proVO" varStatus="i">
								<tr>
									<td class="Rownum" style="text-align: center; vertical-align: middle;">${i.index+1 }</td>
									<td class="projectTitle" style=" vertical-align: middle;">
										<span onclick=goDetail(${proVO.projectNo}) class="text-truncate" style="cursor:pointer; max-width: 250px;" >
											${proVO.projectTitle }
											<input type="hidden" id="selectedProjectNo" value="${proVO.projectNo }">
										</span> 
									</td>
									<td class="mngPic text-truncate" style="text-align: center; vertical-align: middle; max-width: 250px;">${proVO.mngMemName } ${proVO.mngPosName }</td>
										<td class="attendee d-flex" style="text-align: center; vertical-align: middle;">
								            <c:forEach items="${proVO.paList}" var="paMap" varStatus="j">
											    <div class="d-flex flex-row"> 
											        <span id="span" style="font-size: 13px;color: black;">
							                            <div class="border rounded-5 bg-info-subtle ms-1 px-1 text-truncate" style=" max-width: 250px;">
							                                ${paMap.memName} ${paMap.posName}
							                            </div>
											        </span>
											    </div>
											</c:forEach>
										</td>
									<td class="ing text-truncate" style="text-align: center; vertical-align: middle; max-width: 250px;">${proVO.regDate } ~ ${proVO.endDate }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>   
					</tbody>
				</table>
			</div>
			<div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			  	<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

function delFavorites(e){
	var nowLogin = $('#loginMem').val();
	var workNoVal = $('#workNo'+e).val();
	var workFavoriteVO = {
			memNo : nowLogin
			,workNo : workNoVal
	}
	console.log(workFavoriteVO)
	console.log("즐찾삭제ㄱㄱㄱ")
	var favorStatus = $('#favorStatus'+e);
	$.ajax({
   	 	type : "post"
			 , url : "/project/delFavor"
			 ,data : JSON.stringify(workFavoriteVO)
			 ,contentType :  "application/json; charset=utf-8"
			 , success : function(re){
				 console.log(re)
				 if(re.result === "SUCCESS"){
					$('#favor'+e).remove();
				 }
			 }
    }); 
	
						
} 

	function goDetail(e){
		location.href = "/project/projectDetail/"+e
	}

	$(document).ready(function() {
		let currentPosition = 0;
		const cardWidth = 270; // 200px card width + 10px margin on each side
		const visibleCards = 4;
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

	function detailPaging(e, s){
		console.log("awdawdawd")
		var workNoVal = $('#workNo'+s).val();
		var projectNoVal = $('#projectNo'+e).val();
		console.log("workNoVal"+workNoVal);
		console.log("projectNoVal"+projectNoVal);
		
		
		if(sessionStorage.getItem('workId')){
			let workId = sessionStorage.getItem('workId');
			let projectId = sessionStorage.getItem('projectId');
			sessionStorage.removeItem('workId')
			sessionStorage.removeItem('projectId')
		}
		sessionStorage.setItem('workId',workNoVal);
		sessionStorage.setItem('projectId',projectNoVal);
		
		location.href = "/project/projectDetail/"+e
		
	}
	
	
	
</script>