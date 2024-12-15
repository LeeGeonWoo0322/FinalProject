<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재 설정</title>
    <style>
        .tab-content {
            border: 1px solid #dee2e6;
            padding: 20px;
            border-radius: 0.25rem;
        }
        .employee-item {
        	cursor: pointer;
        	transition: background-color 0.3s;
    	}

    	.employee-item:hover {
        	background-color: #f8f9fa;
        	color: #000;
    	}
    	.tab-content {
		    visibility: hidden;
		}
    </style>
</head>
<body>
    <div id="alertBox" style="position: fixed; top: 10px; left: 50%; transform: translateX(-50%); z-index:9999;display: none;">
       	<div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
    <div class="container card d-flex flex-column w-100 ms-3">
        <h2 class="pt-2">전자결재 설정</h2>
        <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="signature-tab" data-bs-toggle="tab" data-bs-target="#signature" type="button" role="tab" aria-controls="signature" aria-selected="true">서명관리</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="absence-tab" data-bs-toggle="tab" data-bs-target="#absence" type="button" role="tab" aria-controls="absence" aria-selected="false">부재설정</button>
            </li>
        </ul>
		
	<div class="tab-content" id="myTabContent">
	    <div class="tab-pane fade show active" id="signature" role="tabpanel" aria-labelledby="signature-tab">
	        <button type="button" class="btn btn-secondary mb-3" data-bs-toggle="modal" data-bs-target="#addSealModal">직인 추가</button>
	        <table style="width: 200px">
	        	<colgroup>
	        		<col width="100px">
	        		<col>
	        	</colgroup>
	        	<tbody>
	        		<tr>
	        			<th>
					        <input type="radio" id="defaultSeal" name="seal" value="/resources/design/public/assets/img/seal/default.png"
					               <c:if test="${empty sealList || sealList[0].selImg eq '/resources/design/public/assets/img/seal/default.png' || sealList[0].selImg == null || sealList[0].selImg == '/resources/design/public/assets/img/seal/default.png'}">checked</c:if>>
					        <label for="defaultSeal">기본 직인</label>
	        			</th>
	        			<td>
	        				<img src="${pageContext.request.contextPath}/resources/design/public/assets/img/seal/default.png" alt="기본 직인" style="width: 100px; height: 100px;">
	        			</td>
	        		</tr>
	        		<c:choose>
	        			<c:when test="${not empty sealList }">
	        				<c:forEach items="${sealList }" var="seal">
			        			<th>
				                    <input type="radio" id="seal_${seal.sealName}" name="seal" value="${seal.sealImg}" 
				                    	<c:if test="${seal.selImg eq seal.sealImg}">checked</c:if>>
				                    <label for="seal_${seal.sealName}">${seal.sealName}</label>
			        			</th>
			        			<td>
			        				<img src="${pageContext.request.contextPath }/resources/upload${seal.sealImg}" alt="추가 직인" style="width: 100px; height: 100px;">
			        			</td>
	        				</c:forEach>
	        			</c:when>
	        		</c:choose>
	        	</tbody>
	        </table>
	        <div style="width: 200px" class="d-flex justify-content-center mt-3">
		        <button type="button" class="btn btn-primary" id="selSealBtn">저장</button>
	        </div>
	    </div>
	    <div class="tab-pane fade" id="absence" role="tabpanel" aria-labelledby="absence-tab">
	        <h5>부재설정 목록</h5>
	        <table class="table">
	            <thead>
	                <tr>
	                    <th>부재 시작</th>
	                    <th>부재 종료</th>
	                    <th>대결자</th>
	                    <th>부재 사유</th>
	                </tr>
	            </thead>
	            <tbody>
	            
	            <c:choose>
					<c:when test="${empty agencyList }">
						<tr>
							<td colspan="5">부재설정이 존재하지 않습니다.</td>
						</tr>
					</c:when>
	            	<c:otherwise>
		            	<c:forEach items="${agencyList }" var="agency">
			            	<tr>
			                    <td>${agency.startDate }</td>
			                    <td>${agency.endDate }</td>
			                    <td>${agency.agencyName }</td>
			                    <td>${agency.agencyContent }</td>
			                </tr>
			            </c:forEach>
	            	</c:otherwise>
	            </c:choose>
	            </tbody>
	        </table>
	        <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#absence-modal">부재설정 추가</button>
	    </div>
	</div>
	
	<!-- 추가 직인 모달 -->
	<div class="modal fade" id="addSealModal" tabindex="-1" aria-labelledby="addSealModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="addSealModalLabel">직인 추가</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <form id="addSealForm" action="/approval/registerSeal" method="post" enctype="multipart/form-data">
	                    <input type="hidden" name="memNo" value="${memberVO.memNo }">
	                    <div class="mb-3">
	                        <label for="sealName" class="form-label">직인 이름</label>
	                        <input type="text" class="form-control" name="sealName" required>
	                    </div>
	                    <div class="mb-3">
	                        <label for="sealFile" class="form-label">파일 업로드</label>
	                        <input type="file" class="form-control" id="sealImg" name="sealImgFile" accept="image/*" required>
	                    </div>
	                    <img class="profile-user-img img-fluid img-circle d-none" id="sealImage"
							src="" alt="직인"
							style="width: 150px;">
	                </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="saveSealButton">저장</button>
	            </div>
	        </div>
	    </div>
	</div>
    </div>

    <!-- 부재설정 모달 -->
    <div class="modal fade" id="absence-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
            <div class="modal-content position-relative">
                <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
                    <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-0">
                    <div class="rounded-top-3 py-3 ps-4 pe-6 bg-body-tertiary">
                        <h4 class="mb-1">부재설정 추가</h4>
                    </div>
                    <div class="p-4 pb-0">
                        <form id="absence-form" method="post" action="/approval/saveAbsence">
                       		<input type="hidden" name="granterNo" value="${memberVO.memNo }">
                       		<input type="hidden" name="agencyNo" id="agencyNo" value="">
                            <div class="mb-3">
                                <label class="col-form-label" for="startDate">부재 시작:</label>
                                <input class="form-control" name="startDate" id="startDate" type="date" required />
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label" for="endDate">부재 종료:</label>
                                <input class="form-control" name="endDate" id="endDate" type="date" required />
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label" for="agencyName">대결자:</label>
                                <div class="input-group">
                                    <input class="form-control" id="agencyName" name="agencyName" type="text" readonly />
                                    <button class="btn btn-outline-secondary" type="button" id="select-delegate">선택</button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="col-form-label" for="agencyContent">부재 사유:</label>
                                <textarea class="form-control" id="agencyContent" name="agencyContent" required></textarea>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
                    <button class="btn btn-primary" type="button" id="save-absence">저장</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 대결자 선택 모달 -->
    <div class="modal fade" id="delegate-modal" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
	        <div class="modal-content position-relative">
	            <div class="modal-header">
	                <h5 class="modal-title">대결자 선택</h5>
	                <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <ul class="list-group">
	                    <c:forEach items="${deptMemList }" var="deptMem">
	                        <li class="list-group-item employee-item" data-no="${deptMem.memNo}" data-name="${deptMem.memName }">${deptMem.memName } ${deptMem.posName }</li>
	                    </c:forEach>
	                </ul>
	            </div>
	            <div class="modal-footer">
	                <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
	            </div>
	        </div>
	    </div>
	</div>
 </div>
  
</body>
<script type="text/javascript">
	isAlertVisible=false;
    $(document).ready(function() {
    	$('.tab-content').css('visibility', 'visible');
    	let sealImg = $("#sealImg");
    	let agencyAlert = sessionStorage.getItem("agency");
    	let sealAlert = "${seal}";
	    if (agencyAlert) {
	        $('#absence-tab').tab('show');
	        requiredAlert("부재설정이 완료되었습니다.", isAlertVisible);
	        sessionStorage.removeItem("agency");
	    } else {
	        // 기본으로 직인 탭 활성화
	        $('#signature-tab').tab('show');
	    }
	    
	    if (sealAlert) {
	    	console.log("직인설정");
	        requiredAlert("직인설정이 완료되었습니다.", isAlertVisible);
	    }
    	
        $('#select-delegate').on('click', function() {
            var delegateModal = new bootstrap.Modal($('#delegate-modal'));
            delegateModal.show();
        });
        

        $('#delegate-modal .list-group-item').on('click', function() {
            $('#agencyName').val($(this).data('name'));
            $('#agencyNo').val($(this).data('no'));
            var delegateModal = bootstrap.Modal.getInstance($('#delegate-modal'));
            delegateModal.hide();
        });

        $('#save-absence').on('click', function() {
            var absenceModal = bootstrap.Modal.getInstance($('#absence-modal'));
            absenceModal.hide();
            sessionStorage.setItem("agency", "agency");
        	
            $('#absence-form').submit();
        });

        $('#saveSealButton').on('click', function() {
            $('#addSealForm').submit(); // 폼 제출
        });

        $('#selSealBtn').on('click', function() {
            console.log($("input:radio[name='seal']:checked").val());
            let sealImg = $("input:radio[name='seal']:checked").val();
            location.href = "/approval/selSealUpdate?sealImg=" + sealImg;
        });
        
        sealImg.on("change", function(event){
    		var file = event.target.files[0];	// Open파일로 선택한 이미지 파일
    		
    		if(isImageFile(file)){	// 이미지 라면
    			var reader = new FileReader();
    			reader.onload = function(e){
    				$("#sealImage").attr("src", e.target.result);	
    			}
    			reader.readAsDataURL(file);
    		}else{					// 이미지 파일이 아닐 때
    			requiredAlert("이미지 파일을 선택해주세요!",isAlertVisible);
    		}
    		$("#sealImage").removeClass("d-none");
    	});
        
     // 이미지 파일인지 확인
        function isImageFile(file){
        	var ext = file.name.split(".").pop().toLowerCase();	// 파일명에서 확장자를 추출
        	return ($.inArray(ext, ["jpg","jpeg","png","gif"]) === -1) ? false : true;
        }
    });
</script>
</html>