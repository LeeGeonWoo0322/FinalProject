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
.img-preview {
	max-width: 200xp; 
	max-height: 300px;
	margin: 5px;
	display: inline-block;
}

 #thumbnailPreview { 
     display: flex; /* Flexbox 사용 */
     flex-direction: column; /* 세로 방향으로 정렬 */
     align-items: center; /* 수평 중앙 정렬 */
     justify-content: center; /* 수직 중앙 정렬 */
     padding: 20px; /* 여백 추가 */
/*      width: 465px;  */
/*      height: 315px;   */
     background-color: #f0f0f0; /* 배경색 설정 */ 
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

	<form action="/board/albumRegisterForm" method="post" enctype="multipart/form-data">
	
	    <table class="table table-bordered">
	        <tr>
	            <td><input type="text" name="boardTitle" class="form-control" placeholder="제목"></td>
	        </tr>
	
			<tr>
	            <td>
	                <div id="thumbnailPreview"></div><br>
	                <div class="custom-file">
	                	<label for=thumbnailImg" class="btn btn-outline-info me-1 mb-1" id="thumbnailImgLabel">썸네일 등록 </label>
	                    <input type="file" class="custom-file-input" id="thumbnailImg" name="thumbnailImg"
	                     class="form-control" accept="image/*" style="display: none;">
	                </div>
	            </td>
	        </tr>
	        
	        
	        <tr>
	            <td>
	                <textarea id="boContent" name="boardContent" rows="15" cols="30" wrap="hard" class="form-control" placeholder="내용"></textarea>
	            </td>
	        </tr>
	        
	        <tr>
	            <td>
	                <div class="custom-file">
	                    <input type="file" class="form-control" name="attachedFiles" multiple class="form-control">
	                </div>
<!-- 	                <div id="imagePreviewContainer"></div> -->
	            </td>
	        </tr>
	        
	        <!-- memNo가 1인 경우에만 아래 체크박스가 보이도록 설정 -->
<%-- 		        <c:if test="${currentMemNo == 1}"> --%>
<!-- 		        	<tr> -->
<!-- 		        		<td> -->
<!-- 			        		<div class="form-check"> -->
<!-- 			        			<input type="checkbox" class="form-check-input" id="alarmCheckBox" name="boardAlarm" value="Y"> -->
<!-- 			        			<label class="form-check-label" for="alarmCheckBox">알림글로 등록</label> -->
<!-- 			        		</div> -->
<!-- 		        		</td> -->
<!-- 		        	</tr> -->
<%-- 		        </c:if> --%>
		        
	        
	    </table>
	    
	    <div class="d-flex justify-content-end">
		    <input type="button" value="등록" id="addBtn" class="btn btn-info me-1 mb-1 float-right">
		    <input type="button" value="취소" id="backBtn" class="btn btn-light me-1 mb-1 float-right" onclick="location.href='/board/albumList?boardType=${boardType}&postType=${postType}'">
	    </div>
	    
	    <input type="hidden" name="boardType" value="${boardType}"/>
	    <input type="hidden" name="postType" value="${postType}"/>
	    <input type="hidden" name="boardNotice" value="N"/>
	    <sec:csrfInput/>
	</form>
	
</div>

<script type="text/javascript">
	$(function(){
		let isAlertVisible = false; // 알러트 창 변경!
		
		let fileList = [];
		CKEDITOR.replace("boContent", {
			filebrowserUploadUrl: "/imageUpload.do?${_csrf.parameterName}=${_csrf.token}"
		});
		CKEDITOR.config.height = "300px"; // 높이 조절
		
		$("input[name='attachedFiles']").on("change", function (event) {
			let files = event.target.files;
			fileList= [];	//기존 파일 리스트 초기화
			$("#imagePreviewContainer").empty();	//기존 미리보기 이미지 초기화
			for (let i = 0; i < files.length; i++) {
				fileList.push(files[i]);
				
				//이미지 미리보기 추가
				let reader = new FileReader();
				reader.onload = function(e){
					let img = $("<img>").attr("src", e.target.result).addClass("img-preview");
					$("#imagePreviewContainer").append(img);
				};
				reader.readAsDataURL(files[i]);
			}
		})
		
		//썸네일 미리보기
		$("#thumbnailImg").on("change", function(event){
			let file = event.target.files[0];
			$("#thumbnailPreview").empty();		//기존 섬네일 미리보기 이미지 초기화
			
			if(file){
				let reader = new FileReader();
				reader.onload = function(e){
					let img = $("<img>").attr("src", e.target.result).addClass("img-preview");
					
					$("#thumbnailPreview").append(img);

				};
				reader.readAsDataURL(file);
			}
		})
		
		$("#thumbnailImgLabel").on("click", function(){
			$("#thumbnailImg").click();
		})
		
		
		$("#addBtn").on("click", function () {
			let title = $("input[name='boardTitle']").val();
			let content = CKEDITOR.instances.boContent.getData();
			let notice = 'N';
			let alarm = $("input[name='boardAlarm']:checked").val() || 'N';
			let boardType = $("input[name='boardType']").val();
			let postType = $("input[name='postType']").val();
			let thumbnail = $("#thumbnailImg")[0].files[0];
			
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
			
		    if (!thumbnail) {  // 썸네일 체크 추가
// 		        alert("썸네일을 등록해주세요!"); 
		    	requiredAlert("썸네일을 등록해주세요!", isAlertVisible);
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
			//첨부파일 추가
			for (let i = 0; i < fileList.length; i++) {
				formData.append("file", fileList[i]);
			}
			if(thumbnail){
				formData.append("thumbnailImg", thumbnail);
			}
			
			formData.append("boardVO", new Blob([JSON.stringify(data)], {type:"application/json; charset=utf-8"}));
			
			$.ajax({
				url : "/board/albumRegisterForm",
				method : "post",
				data : formData,
				processData : false,
				contentType : false,
				success : function (res) {
					console.log("결과는? :: " + res);
					let boardType = res.boardType;
					let postType = res.postType;
					
					location.href = "/board/albumList?boardType=" + boardType + "&postType=" + postType;
					
				}
				
			});
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




