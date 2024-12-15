<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<style>
#sidebar-content {
	height: calc(100% - 240px);
}
#tableExample2{
	height: calc(100% - 120px);
}
.table > :not(caption) > * > * {
	padding: 5px;
}

.custom-modal {
    width: 1000px; /* 원하는 너비로 설정 */
    max-width: 900px; /* 최대 너비 설정 */
}

    /* 테이블 스타일 */
    #commentsTable {
        width: 100%;
        border-collapse: separate; /* 경계선이 서로 겹치지 않도록 설정 */
        border-spacing: 0 1rem; /* 행 간격 설정 (세로 간격) */
        margin-bottom: 1rem;
    }
    
    #commentsTable th, #commentsTable td {
        padding: 1rem; /* 여백을 늘려 가독성을 높임 */
        vertical-align: top;
        border-top: 1px solid #dee2e6;
        background-color: #fff; /* 기본 배경색 */
    }

    /* 모든 행에 배경색 적용 */
    #commentsTable tr {
        background-color: #f9f9f9; /* 모든 행의 배경색 */
    }

    /* 댓글 내용 스타일 */
    .comment-content {
        display: block;
        margin-top: 0.5rem; /* 댓글 간격 조정 */
        padding-left: 0; /* 왼쪽 여백 제거 */
        border-left: none; /* 왼쪽 테두리 제거 */
        font-size: 0.95rem; /* 내용 글자 크기 조정 (필요 시) */
    }

    /* 아이콘 스타일 */
    .fas {
        color: #007bff; /* 아이콘 색상 */
    }

    /* 아이콘 호버 효과 */
    .fas:hover {
        color: #0056b3; /* 호버 시 색상 변경 */
    }

    /* 댓글 행 스타일 */
    .comment-row {
        margin-bottom: 1rem; /* 댓글 간격 조정 */
    }

</style>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->

<div class="container my-4 scrollbar d-block">
<div id="print-area" class="print-area">

    <h4 class="p-3 border-bottom">${board.postType}</h4>
    		<div class="d-flex d-gid gap-2 flex-row align-items-center">

					<!-- 게시글 수정 및 삭제 -->
		   			 <c:if test="${currentMemNo eq board.memNo}">
							<div class="btn p-1" onclick="openEditBoardModal()" style="cursor: pointer;"> 
								<span>
									<i class="text-info" data-feather="edit" style="margin-bottom: 3px;"></i>
								</span> 
								<span>수정하기</span>
							</div>
							
						<form id="deleteForm" action="${pageContext.request.contextPath}/board/delete/${board.boardNo}" method="post" style="display:inline;">
							<div class="btn p-1" id="confirmDelete"> 
								<span>
									<i class="text-danger" data-feather="trash-2" style="margin-bottom: 3px;"></i>
						                <input type="hidden" name="boardType" value="${board.boardType}">
						                <input type="hidden" name="postType" value="${board.postType}">
								</span> 
								<span>삭제하기</span>
							</div>
					    </form>
		    		</c:if>
    		
			</div>

    <div class="mb-3">
        <div class="card-header d-flex justify-content-between align-items-center">
        	
            <h3 class="card-title">${board.boardTitle}</h3>
            <div class="card-tools d-flex align-items-center">
                <span class="me-2">${board.memName} |</span>
                <span class="me-2">${board.boardCreate} |</span>
                <span class="me-2">조회수 : ${board.boardHit}</span>
                <button type="button" onclick="printDiv('print-area')" class="btn btn-outline-primary ms-2">인쇄</button>
            </div>
        </div>

        <div class="card-body">
            <table class="table table-bordered" >
                    <tr>
                        <td colspan="2" style="height: 150px; padding: 10px; background-color: #f9f9f9">${board.boardContent}</td>
                    </tr>
            </table>
        </div>
        
    </div>

    <hr>
		<div class="d-flex align-items-center p-3" style="margin-bottom: -5px;">
		    <h5 class="mb-0">첨부 파일</h5>
		    <span id="toggleIcon" class="far fa-caret-square-down fs-7 ms-2" onclick="toggleFiles()"></span> <!-- 아이콘 클릭 시 toggleFiles 함수 호출 -->
		</div>
		
		<div id="fileList" style="display: block;"> <!-- 기본적으로 보이게 -->
		    <c:choose>
		        <c:when test="${empty attachedFiles}">
		            <table class="table table-bordered fs-10 mb-0">
		                <tr>
		                    <td> 첨부파일 없음 </td>
		                </tr>
		            </table>
		        </c:when>
		        <c:otherwise>
		            <table class="table table-bordered fs-10 mb-0">
		                <c:forEach items="${attachedFiles}" var="file">
		                    <tr>
		                        <td>
		                            <i class="fas fa-paperclip" style="margin-right: -12px;"></i> <!-- 아이콘 추가 -->
		                            <a href="${pageContext.request.contextPath}/board/download/${file.fileDetailNo}" class="btn btn-link">
		                                ${file.fileOriginalname}
		                            </a>
		                        </td>
		                    </tr>
		                </c:forEach>
		            </table>
		        </c:otherwise>
		    </c:choose>
		</div>
    
    
    
<%--     <c:choose> --%>
<%--         <c:when test="${empty attachedFiles}"> --%>
<!--             <p>첨부파일 없음</p> -->
<%--         </c:when> --%>
<%--         <c:otherwise> --%>
<!--             <ul class="list-unstyled"> -->
<%--                 <c:forEach items="${attachedFiles}" var="file"> --%>
<!--                     <li> -->
<!--                     	<i class="fas fa-paperclip" style="margin-right: -12px"></i> -->
<%--                         <a href="${pageContext.request.contextPath}/board/download/${file.fileDetailNo}" class="btn btn-link"> --%>
<%--                             ${file.fileOriginalname} --%>
<!--                         </a> -->
<!--                     </li> -->
<%--                 </c:forEach> --%>
<!--             </ul> -->
<%--         </c:otherwise> --%>
<%--     </c:choose> --%>



    <hr>
    	<div class="d-flex align-items-center p-3" style="margin-bottom: -5px;">
		    <h5 class="mb-0">댓글</h5>
		    <span id="toggleIcon2" class="far fa-caret-square-down fs-7 ms-2" onclick="toggleComment()"></span> <!-- 아이콘 클릭 시 toggleFiles 함수 호출 -->
		</div>
    
		<div id="commentList" style="display: block">
		    <table class="table table-striped" id="commentsTable">
		        <c:forEach items="${comments}" var="comment">
		            <tr id="commentRow-${comment.cmntNo}" class="comment-row">
		                <td id="commentInfo-${comment.cmntNo}" style="position: relative;">
		                	<img style="width: 40px;height: 40px;margin-right: 10px" alt="프로필" src="${pageContext.request.contextPath }/resources/icon/default_profile.png">
		                    <span class="fw-bold">${comment.commentWriter}</span>
		                    
		                    <span class="text-muted ms-2">
							    <fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd HH:mm" />
							</span>
		                    
		                    <span class="comment-content">${comment.cmntContent}</span> <!-- 내용 통합 -->
		                    
		                    <c:if test="${currentMemNo eq comment.memNo}">
		                        <div style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%);">
		                            <i class="fas fa-edit ms-2" 
		                               onclick="openEditCommentModal('${comment.cmntNo}', '${comment.cmntContent}')" 
		                               style="cursor: pointer;" 
		                               aria-label="수정"></i>
		                            
		                            <form action="/board/comment/delete" method="post" style="display: inline;">
		                                <input type="hidden" name="cmntNo" value="${comment.cmntNo}">
		                                <input type="hidden" name="boardNo" value="${board.boardNo}">
		                                <input type="hidden" name="boardType" value="${board.boardType}">
		                                <i class="fas fa-trash-alt ms-2" 
		                                   onclick="this.parentNode.submit();" 
		                                   style="cursor: pointer;" 
		                                   aria-label="삭제"></i>
		                            </form>
		                        </div>
		                    </c:if>
		                </td>
		            </tr> 
		        </c:forEach>
		    </table>
		</div>
    
    
<!-- 		<ul class="list-unstyled"> -->
<%-- 		    <c:forEach items="${comments}" var="comment"> --%>
<!-- 		        <li class="mb-3 border-bottom pb-2" > -->
<%-- 		            <span class="fw-bold">${comment.commentWriter}</span> --%>
<%-- 		            <span class="text-muted ms-2">${comment.regDate}</span> --%>
<%-- 		            <c:if test="${currentMemNo eq comment.memNo}"> --%>
		            
<%-- 					<i class="fas fa-edit ms-2" onclick="openEditCommentModal('${comment.cmntNo}', '${comment.cmntContent}')" style="cursor: pointer;"></i> --%>

<!-- 					<form action="/board/comment/delete" method="post" style="display: inline;"> -->
<%-- 					    <input type="hidden" name="cmntNo" value="${comment.cmntNo}"> --%>
<%-- 					    <input type="hidden" name="boardNo" value="${board.boardNo}"> --%>
<%-- 					    <input type="hidden" name="boardType" value="${board.boardType}"> --%>
<!-- 					    <i class="fas fa-trash-alt ms-2"  -->
<!-- 					       onclick="this.parentNode.submit();"  -->
<!-- 					       style="cursor: pointer;"  -->
<!-- 					       aria-label="삭제"></i> -->
<!-- 					</form> -->
		                
<%-- 		            </c:if> --%>
<%-- 		            <p>${comment.cmntContent}</p> --%>
<!-- 		        </li> -->
<%-- 		    </c:forEach> --%>
<!-- 		</ul> -->
		
    <form action="/board/comment" id="contentForm" method="post" class="mt-3 mb-4"> <!-- mb-4 추가 -->
	    <input type="hidden" name="boardNo" value="${board.boardNo}">
	    <input type="hidden" name="boardType" value="${board.boardType}">
	    <input type="hidden" name="postType" value="${board.postType}">
		    <div class="input-group">
		        <textarea name="cmntContent" id="ckContent" class="form-control" placeholder="댓글을 입력하세요" rows="1"></textarea>
		        	&emsp;
		        <button type="button" id="ckBtn" class="btn btn-info me-1 mb-1" style="margin-top: 3px;">등록</button>
		    </div>
	</form>

	<div style="margin-top: 20px;"> <!-- margin-top 추가 -->
	    <c:forEach items="boardList" var="board">
	        <table class="table table-bordered fs-9 mb-0" style="border-collapse: collapse;">
	            <tr>
	                <td style="text-align: center;">다음글 ▲</td>
	                <td style="text-align: center; background-color: #f9f9f9;">
	                    <c:choose>
	                        <c:when test="${not empty boardList[1]}">
	                            <a href='/board/detail/${boardList[1].boardNo}'>${boardList[1].boardTitle}</a>
	                        </c:when>
	                        <c:otherwise>
		                            <c:out value="다음글이 없습니다."/>
	                        </c:otherwise>
	                    </c:choose>
	                </td>
	            </tr>
	            <tr>
	                <td style="text-align: center;">이전글 ▼</td>
	                <td style="text-align: center; background-color: #f9f9f9;">
	                    <c:choose>
	                        <c:when test="${not empty boardList[0]}">
	                            <a href='/board/detail/${boardList[0].boardNo}'>${boardList[0].boardTitle}</a>
	                        </c:when>
	                        <c:otherwise>
	                            <c:out value="이전글이 없습니다."/>
	                        </c:otherwise>
	                    </c:choose>
	                </td>
	            </tr>
	        </table>
	    </c:forEach>
	</div>

    
    

    <a href="/board/boardList?boardType=${board.boardType}&postType=${board.postType}" class="btn btn-outline-secondary mt-3" style="float: right;">목록으로 돌아가기</a>
</div>
</div>


<!-- 게시글 수정 모달 start-->
<div id="editBoardModal" class="modal" tabindex="-1" >
	<div class="modal-dialog custom-modal">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">게시글 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="editBoardForm" action="${pageContext.request.contextPath}/board/update" method="post" enctype="multipart/form-data">
					<input type="hidden" name="boardNo" value="${board.boardNo}">
					<input type="hidden" name="boardType" value="${board.boardType} }" />
	    			<input type="hidden" name="postType" value="${board.postType} }"/>
	    			<input type="hidden" name="memNo" value="${board.memNo}">
	    			<input type="hidden" name="fileNo" value="${board.fileNo }">
					<!-- 제목 -->
					<div class="mb-3">
<!-- 						<label for="boardTitle" class="form-label">제목</label> -->
						<input type="text" class="form-control" name="boardTitle" value="${board.boardTitle}">
					</div>
					<!-- 내용 -->
					<div class="mb-3">
<!-- 						<label for="boardContent" class="form-label">내용</label> -->
						<textarea id="editContent" name="boardContent" class="form-control">${board.boardContent}</textarea>
					</div>
					<!-- 첨부 파일 삭제 기능 -->
					<div class="mb-3">
						<label for="attachedFiles" class="form-label">첨부 파일 목록</label>
						<ul>
							<c:forEach items="${attachedFiles}" var="file">
								<li>
									${file.fileOriginalname}
									<input type="checkbox" name="deleteFileNos" value="${file.fileDetailNo }" style="margin-left: 10px;"> 삭제
								</li>
							</c:forEach>
						</ul>
					</div>
					
					<!-- 새 파일 추가 -->
					<div class="mb-3">
						<label for="attachedFiles" class="form-label">첨부파일</label>
						<input type="file" class="form-control" name="attachedFiles" multiple>
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-light me-1 mb-1 float-right" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-info me-1 mb-1 float-right">저장</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 게시글 수정 모달 end-->


<!-- 댓글 수정 모달 start -->
<div id="editCommentModal" class="modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">댓글 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="editCommentForm" action="/board/comment/update" method="post">
					<input type="hidden" name="cmntNo" id="editCmntNo">
					<input type="hidden" name="boardNo" value="${board.boardNo}">
					<input type="hidden" name="boardType" value="${board.boardType}">
					<textarea id="editCmntContent" name="cmntContent" class="form-control" rows="3"></textarea>
					<div class="modal-footer">
						<button type="button" class="btn btn-light me-1 mb-1 float-right" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-info me-1 mb-1 float-right">저장</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 댓글 수정 모달 end -->

<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->



<!-- 댓글 수정 모달 창 열기 -->
<script>
	
	// 첨부파일 목록
	function toggleFiles() {
	    var fileList = document.getElementById("fileList");
	    var toggleIcon = document.getElementById("toggleIcon");
	
	    if (fileList.style.display === "block") {
	        fileList.style.display = "none"; // 파일 목록 보이기
	        toggleIcon.classList.remove("far", "fa-caret-square-down");
	        toggleIcon.classList.add("far", "fa-caret-square-up"); // 아이콘 변경
	    } else {
	        fileList.style.display = "block"; // 파일 목록 숨기기
	        toggleIcon.classList.remove("far", "fa-caret-square-up");
	        toggleIcon.classList.add("far", "fa-caret-square-down"); // 아이콘 원래대로 변경
	    }
	}
	
	// 댓글 목록
	function toggleComment() {
	    var commentList = document.getElementById("commentList");
	    var toggleIcon2 = document.getElementById("toggleIcon2");
	
	    if (commentList.style.display === "block") {
	    	commentList.style.display = "none"; // 댓글 목록 보이기
	        toggleIcon2.classList.remove("far", "fa-caret-square-down");
	        toggleIcon2.classList.add("far", "fa-caret-square-up"); // 아이콘 변경
	    } else {
	    	commentList.style.display = "block"; // 댓글 목록 숨기기
	        toggleIcon2.classList.remove("far", "fa-caret-square-up");
	        toggleIcon2.classList.add("far", "fa-caret-square-down"); // 아이콘 원래대로 변경
	    }
	}


	// 영역 지정 인쇄
	function printDiv(divId) {
	    var printContents = document.getElementById(divId).innerHTML;
	    var originalContents = document.body.innerHTML;
	    console.log(printContents);
	
	    document.body.innerHTML = printContents;
	    window.print();
	    document.body.innerHTML = originalContents;
	}
	
	// 삭제버튼
	if($("#confirmDelete").length){
		document.querySelector("#confirmDelete").addEventListener("click",function(){
	        if (confirm("정말로 삭제하겠습니까?")) {
	            document.getElementById("deleteForm").submit(); // 폼 서브밋
	        }
	 	 });
	}
	
	
	// 댓글 입력 검사 ckContent
	document.querySelector("#ckBtn").addEventListener("click",function(){
		console.log(this);
		let ckContent = document.getElementById("ckContent").value;
        if (ckContent == null || ckContent == "") {
            alert("댓글을 입력해주세요!");
            return false;
        }
        
        document.getElementById("contentForm").submit(); // 폼 서브밋
        
 	 });
	
	
	
	

	function openEditCommentModal(cmntNo, cmntContent){
		document.getElementById('editCmntNo').value = cmntNo;
		document.getElementById('editCmntContent').value = cmntContent;
		var myModal = new bootstrap.Modal(document.getElementById('editCommentModal'), {});
		myModal.show();
	}
	
	
	function openEditBoardModal(){
		var myModal = new bootstrap.Modal(document.getElementById('editBoardModal'),{});
		myModal.show();
		
		if(CKEDITOR.instances['editContent']){
			CKEDITOR.instances['editContent'].destroy(true);
		}
		CKEDITOR.replace('editContent', {
			filebrowserUploadUrl: "/imageUpload.do"
		});
	}
</script>
