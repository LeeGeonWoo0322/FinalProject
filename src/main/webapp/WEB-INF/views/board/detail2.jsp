<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
</style>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->

<div class="container my-4 scrollbar d-block">
<div id="print-area" class="print-area">

    <h4 class="p-3 border-bottom">${board.postType}</h4>

    <div class="card mb-3">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h3 class="card-title">${board.boardTitle}</h3>
            <div class="card-tools d-flex align-items-center">
                <span class="me-2">${board.memName}</span>
                <span class="me-2">${board.boardCreate}</span>
                <span class="me-2">${board.boardHit}</span>
                <button type="button" onclick="printDiv('print-area')" class="btn btn-primary ms-3">인쇄</button>
            </div>
        </div>

        <div class="card-body">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <td colspan="2">${board.boardContent}</td>
                    </tr>
<!--                     <tr> -->
<!--                         <td colspan="2"> -->
<%--                             <c:if test="${not empty board.postImg}"> --%>
<%--                                 <img src="${board.postImg}" alt="첨부 이미지" class="img-fluid"> --%>
<%--                             </c:if> --%>
<!--                         </td> -->
<!--                     </tr> -->
                </tbody>
            </table>
        </div>
    </div>

    <hr>
    <h5>첨부 파일</h5>
    <c:choose>
        <c:when test="${empty attachedFiles}">
            <p>첨부파일 없음</p>
        </c:when>
        <c:otherwise>
            <ul class="list-unstyled d-flex flex-wrap gap-3">
                <c:forEach items="${attachedFiles}" var="file">
                    <li>
                        <a href="${pageContext.request.contextPath}/board/download/${file.fileDetailNo}" class="btn btn-link">
                            ${file.fileOriginalname}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <!-- 게시글 수정 및 삭제 -->
    <c:if test="${currentMemNo eq board.memNo}">
        <hr>
        <div class="d-flex">
            <button type="button" class="btn btn-primary me-3" onclick="openEditBoardModal()">수정하기</button>
            <form id="deleteForm" action="${pageContext.request.contextPath}/board/delete/${board.boardNo}" method="post" style="display:inline;">
                <input type="hidden" name="boardType" value="${board.boardType}">
                <input type="hidden" name="postType" value="${board.postType}">
                <button type="button" id="confirmDelete" class="btn btn-danger">삭제하기</button>
            </form>
        </div>
    </c:if>

    <hr>
    <h5>댓글</h5>
		<ul class="list-unstyled">
		    <c:forEach items="${comments}" var="comment">
		        <li class="mb-3 border-bottom pb-2">
		            <span class="fw-bold">${comment.commentWriter}</span>
		            <span class="text-muted ms-2">${comment.regDate}</span>
		            <c:if test="${currentMemNo eq comment.memNo}">
		                <button type="button" onclick="openEditCommentModal('${comment.cmntNo}', '${comment.cmntContent}')" class="btn btn-primary btn-sm ms-2">수정</button>
		                <form action="/board/comment/delete" method="post" style="display: inline;">
		                    <input type="hidden" name="cmntNo" value="${comment.cmntNo}">
		                    <input type="hidden" name="boardNo" value="${board.boardNo}">
		                    <input type="hidden" name="boardType" value="${board.boardType}">
		                    <button type="submit" class="btn btn-danger btn-sm ms-2">삭제</button>
		                </form>
		            </c:if>
		            <p>${comment.cmntContent}</p>
		        </li>
		    </c:forEach>
		</ul>

    <form action="/board/comment" id="contentForm" method="post" class="mt-3">
        <input type="hidden" name="boardNo" value="${board.boardNo}">
        <input type="hidden" name="boardType" value="${board.boardType}">
        <div class="input-group">
            <textarea name="cmntContent" id="ckContent" class="form-control" placeholder="댓글을 입력하세요"></textarea>
            <button type="button" id="ckBtn" class="btn btn-success">등록</button>
        </div>
    </form>

    <a href="/board/boardList?boardType=${board.boardType}&postType=${board.postType}" class="btn btn-outline-secondary mt-3">목록으로 돌아가기</a>
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
						<label for="boardTitle" class="form-label">제목</label>
						<input type="text" class="form-control" name="boardTitle" value="${board.boardTitle}">
					</div>
					<!-- 내용 -->
					<div class="mb-3">
						<label for="boardContent" class="form-label">내용</label>
						<textarea id="editContent" name="boardContent" class="form-control">${board.boardContent}</textarea>
					</div>
					<!-- 첨부 파일 삭제 기능 -->
					<div class="mb-3">
						<label for="attachedFiles" class="form-label">첨부 파일 목록</label>
						<ul>
							<c:forEach items="${attachedFiles}" var="file">
								<li>
									${file.fileOriginalname}
									<input type="checkbox" name="deleteFileNos" value="${file.fileDetailNo }"> 삭제
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
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">저장</button>
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
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">저장</button>
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
