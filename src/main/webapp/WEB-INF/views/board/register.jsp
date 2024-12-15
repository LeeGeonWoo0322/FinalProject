<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
</style>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->


<div class="container mt-4 scrollbar d-block">
    <div id="alertBox" style="position: fixed; top: 100px; left: 60%; transform: translateX(-50%); display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
	<h4 class="p-3">${postType}</h4>

	<form action="/board/registerForm" method="post" enctype="multipart/form-data">
	
	    <table class="table table-bordered">
	        <tr>
	            <td><input type="text" name="boardTitle" class="form-control" placeholder="제목"></td>
	        </tr>
	
	        <tr>
	            <td>
	                <textarea id="boContent" name="boardContent" rows="15" cols="30" wrap="hard" class="form-control" placeholder="내용"></textarea>
	            </td>
	        </tr>
	        
	        <tr>
	            <td>
	                <div class="custom-file">
	                    <input type="file" class="form-control" name="attachedFiles" multiple >
	                </div>
	            </td>
	        </tr>
	        
	        <!-- memNo가 1인 경우에만 아래 체크박스가 보이도록 설정 -->
		        <c:if test="${currentMemNo == 4 || currentMemNo == 8 }">
		        	<tr>
		        		<td>
			        		<div class="form-check">
			        			<input type="checkbox" class="form-check-input" id="noticeCheckBox" name="boardNotice" value="Y">
			        			<label class="form-check-label" for="noticeCheckbox">공지사항으로 등록</label>
			        		</div>
			        		<div class="form-check">
			        			<input type="checkbox" class="form-check-input" id="alarmCheckBox" name="boardAlarm" value="Y">
			        			<label class="form-check-label" for="alarmCheckBox">알림글로 등록</label>
			        		</div>
		        		</td>
		        	</tr>
		        </c:if>
		        
	        
	    </table>
	    <div class="d-flex justify-content-end">
		    <input type="button" value="등록" id="addBtn" class="btn btn-info me-1 mb-1 float-right">
		    <input type="button" value="취소" id="backBtn" class="btn btn-light me-1 mb-1 float-right" onclick="location.href='/board/boardList?boardType=${boardType}&postType=${postType}'">
		</div>    
		
	    <input type="hidden" name="boardType" value="${boardType}"/>
	    <input type="hidden" name="postType" value="${postType}"/>
	    <sec:csrfInput/>
	</form>
	
</div>

<script type="text/javascript">
	$(function(){
		let isAlertVisible = false; // 알러트 창 변경!
		
		let fileList = [];
		CKEDITOR.replace("boContent", {
			filebrowserUploadUrl: "/imageUpload.do?${_csrf.parameterName}=${_csrf.token}",
		});
		CKEDITOR.config.height = "300px"; // 높이 조절
		
		
		$("input[name='attachedFiles']").on("change", function (event) {
			let files = event.target.files;
			for (let i = 0; i < files.length; i++) {
				fileList.push(files[i]);
			}
		})
		
		$("#addBtn").on("click", function () {
			let title = $("input[name='boardTitle']").val();
			let content = CKEDITOR.instances.boContent.getData();
			let notice = $("input[name='boardNotice']:checked").val() || 'N';
			let alarm = $("input[name='boardAlarm']:checked").val() || 'N';
			let boardType = $("input[name='boardType']").val();
			let postType = $("input[name='postType']").val();
			
			if (title == null || title == "") {
// 				alert("제목을 입력해주세요!");
				requiredAlert("제목을 입력해주세요!", isAlertVisible);
				return false;
			}
			if (content == null || content == "") {
// 				alert("내용을 입력해주세요!");
				requiredAlert("내용을 입력해주세요!", isAlertVisible);
				return false;
			}
			
			data = {
				boardTitle: title,
				boardContent: content,
				boardNotice: notice,
				boardAlarm: alarm,
				boardType: boardType,
				postType: postType
			};
			
			let formData = new FormData();
			for (let i = 0; i < fileList.length; i++) {
				formData.append("file", fileList[i]);
			}	
			formData.append("boardVO", new Blob([JSON.stringify(data)], {type:"application/json; charset=utf-8"}));
			
			$.ajax({
				url : "/board/registerForm",
				method : "post",
				data : formData,
				processData : false,
				contentType : false,
				success : function (res) {
					console.log("결과는? :: " + res);
					let boardType = res.boardType;
					let postType = res.postType;
					
					
				}
				
			});
			
			location.href = "/board/boardList?boardType=" + boardType + "&postType=" + postType;
			
		});
		
		
		function requiredAlert(comment, isAlertVisible) {
		    let alertBox = $('#alertBox');
		    $("#alertDiv").html(comment);
		    if (!isAlertVisible) { // 알림이 보이지 않을 때만 실행
		        isAlertVisible = true; // 알림을 표시 중임을 설정
		        alertBox.css('display', "block");
		        setTimeout(function() {
		            alertBox.css('display', "none");
		            isAlertVisible = false; // 알림이 사라진 후 플래그를 초기화
		        }, 2000);
		    }
		    return false;
		}
		
	});
	
	
	


</script>





<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->




