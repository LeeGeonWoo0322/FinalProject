<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
.selected {
    background-color:#f0f8ff !important; /* 파란색 글씨 */
    font-weight: bold !important; /* 굵은 글씨 */
}
</style>

<div style="width: 250px"> 
	<div
		class="navbar-vertical-content h-100 scrollbar border-end border-end-1"
		style="width: 250px;">
		<div class="flex-column mb-2">
			<div class="p-3">
				<h4>드라이브</h4>
				<button style="display: none;" id="fileListFromController" value='${jsonFileList }'></button>
				<button style="display: none;" id="folderListFromController" value='${jsonFolderList }'></button>
				<button style="display: none;" id="underFolderListFromController" value='${jsonUnderFolder }'></button>
				<button style="display: none;" id="underFileListFromController" value='${jsonUnderFile }'></button>
			</div>
			<div style="text-align: center;">
				<button id="uploadBtn" class="btn btn-outline-dark me-1 mb-1 px-6 py-2" type="button" data-bs-toggle="modal" data-bs-target="#uploadModal">업로드</button>
			</div>
		</div>
		<!-- <div class="border-top border-300 d-flex flex-column align-items-center justify-content-center" style="height: 120px"> -->
		<!-- 	<div class="d-flex flex-column justify-content-center w-75"> -->
		<!-- 		<div class="progress" style="height: 10px" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"> -->
		<!-- 			<!-- 이게 퍼센트 표시하는 친구 -->
		<!-- 			<div class="progress-bar bg-info" style="width: 20%"></div>  -->
		<!-- 		</div> -->
		<!-- 		<div> -->
		<!-- 			<span style="font-size: 12px">2.0GB중 3.3MB 사용</span> -->
		<!-- 		</div> -->
		<!-- 		<button class="btn border border-1 border-dark" type="button">용량 추가 요청</button> -->
		<!-- 	</div> -->
		<!-- </div>-->
		<div class="p-3" style="height: 70%; overflow-y: auto;" id="sidebarTree">
			<ul class="mb-0 treeview" id="treeviewExample">
				<li class="treeview-list-item">

					<p class="treeview-text fw-bold">
						<a data-bs-toggle="collapse" href="#sideMyFolderView" role="button" aria-expanded="false"> </a> <span role="button" onclick="firstFolderView(1)">개인 드라이브</span>
					</p>
					<ul class="collapse treeview-list" id="sideMyFolderView" data-show="true">
					</ul>
				</li>

				<li class="treeview-list-item">
					<p class="treeview-text">
						<a data-bs-toggle="collapse" href="#sideCompanyFolderView" role="button" aria-expanded="false"> </a> <span role="button" onclick="firstFolderView(2)">전사 드라이브</span>
					</p>
					<ul class="collapse treeview-list" id="sideCompanyFolderView" data-show="true">
						<li class="treeview-list-item"></li>
					</ul>
				</li>
			</ul>
		</div>
		<!-- 옮겨두긴 했는데 영... -->
		<div
			class="border-top border-300 d-flex flex-column align-items-center justify-content-center"
			style="height: 120px">
			<div class="d-flex flex-column justify-content-center w-75">
				<div class="progress" style="height: 10px" role="progressbar"
					aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
					<!-- 이게 퍼센트 표시하는 친구 -->
					    <c:set var="absoluteSize" value="${totalSize < 0 ? -totalSize : totalSize}" />
					<div class="progress-bar bg-info" style="width: ${absoluteSize >= 2*1024*1024*1024 ? 100 : absoluteSize / (2*1024*1024*1024) * 100}%"></div>
				</div>
				<div>
					<span style="font-size: 12px">
					    2.0GB 중
						<c:choose>
						    <c:when test="${absoluteSize >= 1024*1024*1024}">
						        <fmt:formatNumber value="${absoluteSize / (1024.0 * 1024 * 1024)}" maxFractionDigits="2"/> GB
						    </c:when>
						    <c:when test="${absoluteSize >= 1024*1024}">
						        <fmt:formatNumber value="${absoluteSize / (1024.0 * 1024)}" maxFractionDigits="2"/> MB
						    </c:when>
						    <c:when test="${absoluteSize >= 1024}">
						        <fmt:formatNumber value="${absoluteSize / 1024.0}" maxFractionDigits="2"/> KB
						    </c:when>
						    <c:otherwise>
						        <fmt:formatNumber value="${absoluteSize}" maxFractionDigits="2"/> Byte
						    </c:otherwise>   
						</c:choose> 사용
					</span>
				</div>
				<button class="btn border border-1 border-dark" type="button">용량
					추가 요청</button>
			</div>
		</div>

	</div>
</div>
<!-- ===============================================-->
<!--    sidebar 끝    -->
<!-- ===============================================-->
<script>
	//사이드바에서 쓸 폴더구조
	$(function() {
		
		var totalSize = ${totalSize};
		console.log(typeof(totalSize));
		console.log(totalSize);
		
		
		let $selectedItem = null;

		$('#sidebarTree').on('click', 'span', function(event) {
	        event.stopPropagation(); // 이벤트 전파 방지
	        // 이전 선택된 항목이 있으면 원래 스타일로 되돌리기
	        if ($selectedItem) {
	            $selectedItem.removeClass('selected');
	        }
	        // 현재 클릭한 항목을 선택 상태로 변경
	        $selectedItem = $(this).parent();
	        $selectedItem.addClass('selected');
	    });
		
		(function() {

			// 사이드바의 각 영역들 불러옴
			var myDrive = $("#sideMyFolderView");
			var companyDrive = $("#sideCompanyFolderView");

			// 사이드바에 넣어줄 폴더들 
			var upperFolderList = JSON.parse($("#folderListFromController")
					.val());
			var underFolderList = JSON
					.parse($("#underFolderListFromController").val());

			// 사이드바에 넣어줄 파일들
			var upperFileList = JSON.parse($("#fileListFromController").val());
			var underFileList = JSON.parse($("#underFileListFromController")
					.val());

			// html넣어줄 녀석
			var upper1 = "";
			var upperNo = 0;

			// 1. 최상위 폴더를 집어넣어준다. 개인/전사를 구분한다.
			for (let i = 0; i < upperFolderList.length; i++) {
				upperNo = 0;
				upper1 += "";
				upper1 += "<li class='treeview-list-item'>";
				upper1 += "		<p class='treeview-text'>";
				for (let j = 0; j < underFolderList.length; j++) {
					if (upperFolderList[i].folderNo == underFolderList[j].folderParentNo) {
						upperNo += 1
					}
				}
				if (upperNo == 0) {
					upper1 += "			<span class='text-truncate' role='button' onclick='view("
							+ upperFolderList[i].folderNo
							+ ")'>"
							+ upperFolderList[i].folderName + "</span>";
				} else {
					upper1 += "			<a data-bs-toggle='collapse' role='button' aria-expanded='false' href='#sideFolderNo"+upperFolderList[i].folderNo+"'>";
					upper1 += "			</a>";
					upper1 += "			<span class='text-truncate' role='button' onclick='view("
							+ upperFolderList[i].folderNo
							+ ")'>"
							+ upperFolderList[i].folderName + "</span>";
				}
				upper1 += "		</p>";
				upper1 += "		<ul class='collapse treeview-list ps-1' id='sideFolderNo"+upperFolderList[i].folderNo+"' data-show='false'>";
				upper1 += "		</ul>";
				upper1 += "</li>";
				upper1 += "";
				if ($("#sideFolderNo" + upperFolderList[i].folderNo).length == 0) {
					if (upperFolderList[i].folderType == 1) {
						myDrive.append(upper1);
					} else {
						companyDrive.append(upper1);
					}
				}
				upper1 = "";
			}

			var under1 = "";
			var underNo = 0;

			// 하위폴더는 최상위폴더의 구분을 따라가기 때문에 개인/전사를 구분하지 않는다.	for문i가 비교적 상위폴더, for문 j가 비교적 하위폴더를 생성한다.
			for (let k = 0; k < 6; k++) {
				for (let i = 0; i < underFolderList.length; i++) {
					underNo = 0;
					under1 += "<li class='treeview-list-item ms-3'>";
					under1 += "<p class='treeview-text'>";
					for (let j = 0; j < underFolderList.length; j++) {
						if (underFolderList[i].folderNo == underFolderList[j].folderParentNo) {
							underNo += 1;
						}
					}
					if (underNo == 0) {
						under1 += "<span class='text-truncate ms-3' role='button' onclick='view("
								+ underFolderList[i].folderNo
								+ ")'>"
								+ underFolderList[i].folderName + "</span>";
					} else {
						under1 += "<a data-bs-toggle='collapse' role='button' aria-expanded='false' href='#sideFolderNo"+underFolderList[i].folderNo+"'>";
						under1 += "</a>";
						under1 += "<span class='text-truncate' role='button' onclick='view("
								+ underFolderList[i].folderNo
								+ ")'>"
								+ underFolderList[i].folderName + "</span>";
					}
					under1 += "</p>";
					under1 += "<ul class='collapse treeview-list' id='sideFolderNo"+underFolderList[i].folderNo+"' data-show='true'>";
					under1 += "</ul>";
					under1 += "</li>";
					if ($("#sideFolderNo" + underFolderList[i].folderParentNo).length != 0
							&& $("#sideFolderNo" + underFolderList[i].folderNo).length == 0) {
						var upperFolder = $("#sideFolderNo"
								+ underFolderList[i].folderParentNo);
						upperFolder.append(under1);
					}
					under1 = "";
				}
			}

			// 		var upper2 = "";

			// 		// 최상위 파일을 집어넣어준다.
			// 		for(let i=0; i<upperFileList.length; i++){
			// 			upper2 += "";
			// 			upper2 += "<li class='treeview-list-item'>";
			// 			upper2 += "		<p class='treeview-text'>";
			// 			upper2 += "			<a role='button' aria-expanded='false' onclick='view("+upperFileList[i].folderNo+")'>";
			// 			upper2 += "				<span style='color: black; font-weight: 500; font-size: 13px'>"+upperFileList[i].dfName+"</span>";
			// 			upper2 += "			</a>";
			// 			upper2 += "		</p>";
			// 			upper2 += "</li>";
			// 			upper2 += "";
			// 			if(upperFileList[i].dfType == 1){
			// 				myDrive.append(upper2);
			// 			}else{
			// 				companyDrive.append(upper2);
			// 			}
			// 			upper2 = ""; 
			// 		}

			// 		var under2 = "";

			// 		// 하위 파일을 집어넣어준다.
			// 		for(let i=0; i<underFileList.length; i++){ 
			// 			under2 += "";
			// 			under2 += "<li class='treeview-list-item'>";
			// 			under2 += "		<p class='treeview-text'>";
			// 			under2 += "			<a role='button' aria-expanded='false' onclick='view("+underFileList[i].folderNo+")'>"; 
			// 			under2 += "				<span style='color: black; font-weight: 500; font-size: 13px'>"+underFileList[i].dfName+"</span>";
			// 			under2 += "			</a>";
			// 			under2 += "		</p>";
			// 			under2 += "</li>";
			// 			under2 += "";
			// 			var upperFolder = $("#sideFolderNo"+underFileList[i].folderNo);
			// 			upperFolder.append(under2);
			// 			under2 = ""; 
			// 		}

		})();

	});
</script>