<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


	<tiles:insertAttribute name = "siderbar"></tiles:insertAttribute>


<style type="text/css">
#tdContentInput {
	background-color: gray;
	width: 1000px;
	height: 30px; 
}
</style>


	<div class="d-flex flex-column w-100" id="ContentDiv">
		<div class="h-100">
			<div class="card-header">
                  <h2 class="mb-0">오늘</h2>
                 
            </div>
            <div class="p-3">
	            <c:choose>
	            	<c:when test="${empty todoVO}">
	            		작성된 리스트가 없습니다.
	            	</c:when>
	            	<c:otherwise>
	            		<c:forEach items="${todoVO }" var="todo">
	            		
	            		<div class="tdl todoList${todo.tdNo } d-flex flex-row mb-1 w-50" id="todoList">
	            			
	         
	            			<c:choose>
	            				<c:when test="${todo.finYn eq 'Y' }">
	            					<input type="checkbox"  class="finYnCheck form-check-input me-2 " id="finYn${todo.tdNo }" value="${todo.finYn }" onclick=changYn(${todo.tdNo }) checked="checked">  
				   			   			<c:choose>
				            				<c:when test="${todo.importYn eq 'Y' }">
				            					<span style="color: red;"><strong>[중요]</strong></span>
				            				</c:when>
				            				<c:otherwise>
				            				</c:otherwise>
				            			</c:choose> 
	            					<div class="tdContent${todo.tdNo } ms-1 text-truncate "  style="text-decoration: line-through;" id="tdContent${todo.tdNo } " name="tdContent">${todo.tdContent }</div>
	            				</c:when>
	            				<c:otherwise>
	            					<input type="checkbox"  class="finYnCheck form-check-input me-2" id="finYn${todo.tdNo }" value="${todo.finYn }" onclick=changYn(${todo.tdNo })>
				   			   			<c:choose>
				            				<c:when test="${todo.importYn eq 'Y' }">
				            					<span style="color: red;"><strong>[중요]</strong></span>
				            				</c:when>
				            				<c:otherwise>
				            				</c:otherwise>
				            			</c:choose> 
				            			
	            					<div class="tdContent${todo.tdNo } text-truncate <c:if test="${todo.finYn eq 'Y' }">line-through</c:if>" id="tdContent${todo.tdNo }"   name="tdContent">${todo.tdContent }</div>
	            				</c:otherwise>
	            			</c:choose>
				            <select id="tdType${todo.tdNo }"  style="display:none;">
				            <option value="day" selected="selected">오늘</option>
				            <option value="week">주간</option>
				            <option value="month">월간</option>
				       		</select>
				            <input  type="hidden" id="tdNo${todo.tdNo }"  value="${todo.tdNo }" >
	            			<c:choose>
	            				<c:when test="${todo.importYn eq 'Y' }">
						          	<span class="d-none" id="importText${todo.tdNo }">중요 여부</span>   <input class="form-check-input d-none" type="checkbox" id="importYn${todo.tdNo }" name="importYn" value="${todo.importYn }" style="flex: 0 0 auto;" checked="checked">
	            				</c:when>
	            				<c:otherwise>
						          	<span class="d-none" id="importText${todo.tdNo }">중요 여부</span>   <input class="form-check-input d-none" type="checkbox" id="importYn${todo.tdNo }" name="importYn" value="${todo.importYn }" style="flex: 0 0 auto;" >
	            				</c:otherwise>
	            			</c:choose> 
				            <button class="Btn d-none updateBtn" id="sysBtn${todo.tdNo}" onclick=sys(${todo.tdNo}) style="height: 24px" >✐</button>
				            <div id="sysForm${todo.tdNo }" class="sysForm${todo.tdNo} d-flex flex-row d-none"> 
								<button class="Btn" id="delBtn${todo.tdNo }" onclick=del(${todo.tdNo}) >X</button> 
								<button class="Btn" id="modBtn${todo.tdNo }" onclick=modify(${todo.tdNo }) >수정</button> 
							</div>
	            		</div>
	            		</c:forEach>
	            	</c:otherwise>
	            </c:choose>
	            <div class="d-flex flex-row " id="todoListInsert">
		       		<div id="newTodoDiv" class="d-flex flex-row align-items-center d-none" style="gap: 10px;">
				        <span>중요여부</span>
				        <input class="form-check-input" type="checkbox" id="newImportYn" name="importYn" value="N" style="flex: 0 0 auto;">
				        <input class="form-control" id="newTdContent" type="text" placeholder="오늘 할 일" style="flex: 1;">
				        <select id="newTdType" name="tdType" style="display:none;">
				            <option value="day" selected="selected">오늘</option>
				            <option value="week">주간</option>
				            <option value="month">월간</option>
				        </select>
				        <button id="insertBtn" style="flex: 0 0 auto;">등록</button>
				        <button id="insertXBtn" onclick=insertXBtn() style="flex: 0 0 auto;">X</button>
				    </div>
	            </div>
				<div class="btn btn-sm btn-link d-block d-flex flex-row ps-3" onclick=insertForm()>
					<button id="addBtn" class="btn btn-link btn-sm d-block btn-add-card text-decoration-none text-600 p-0" type="button">
						<svg style="width: 15px; height: 15px" class="svg-inline--fa fa-plus fa-w-14 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
							<path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
						</svg>
					</button>
					<label for="addBtn" class="m-0 fs-9 text-600" style="font-weight: bold;">추가하기</label>
				</div>    
            </div>
            
        </div>
    </div>
                  
                  
<script type="text/javascript">
	//====================== 완료 투두 만들기 함수 시작 ===================
		
var txt = '';
		
	$('.tdl').hover(
        function() {
            $(this).find('.updateBtn').removeClass("d-none");
        }, 
        function() {
            $(this).find('.updateBtn').addClass("d-none");
        }
    );
	
	function changYn(e){
		
		var finYN = $('#finYn'+e);
		finYN.on('change',function(){
			
//			var CfinYnVal = event.target.dataset.finVal;
//			var CfinYnId = event.target.id;
		 	if ($(this).prop("checked")) {
		        $(this).val('Y');
		        
		    } else {
		        $(this).val('N');
		       
		    }
    
		 	
		 		var tdContent = $('#tdContent'+e);
		 		var tdContentVal = $('#tdContent'+e).val();
				var importYnVal = $('#importYn'+e).val();
				var tdNoVal = $('#tdNo'+e).val();
				var finYnVal = $('#finYn'+e).val();
				var tdTypeVal = $('#tdType'+e).val();
				var finData = {
							importYn : importYnVal,
			    			tdContent : tdContentVal,
			    				tdNo : tdNoVal,
			    				finYn : finYnVal,
			    				tdType : tdTypeVal
				}
				console.log(finYnVal)
				 
				 $.ajax({
					type : "post",
		    		url : "/todo/finTodo",
		    		data : JSON.stringify(finData),
		    		contentType :  "application/json; charset=utf-8",
		    		success : function(response){
						if(response.status === "success"){
							console.log("r")
							if(finYN.val() === 'Y'){
								finYN.siblings('div[id^=tdContent]').css("text-decoration", "line-through");
							}else {
								finYN.siblings('div[id^=tdContent]').css("text-decoration", "");
							}
						} else {
							console.log("s")
						}
					}
				 }); 
			    console.log("아작스 실행");
		});
	}
		
		


	//====================== 완료 투두 만들기 함수 끝 ===================
	//====================== 수정 시작 ===================
	function modify(num) {
		    	
		    	var tdContentVal = $('.tdContent'+num).val();
				var importYnVal = $('#importYn'+num).val();
				var tdNoVal = $('#tdNo'+num).val();
				var finYnVal = $('#finYn'+num).val();
				var tdTypeVal = $('#tdType'+num).val();
				
		    	var updateData = {
		    			importYn : importYnVal,
		    			tdContent : tdContentVal,
		    				tdNo : tdNoVal,
		    				finYn : finYnVal,
		    				tdType : tdTypeVal
		    	}
		    	
		    	$.ajax({
		    		type : "post",
		    		url : "/todo/updateTodo",
		    		data : JSON.stringify(updateData),
		    		contentType :  "application/json; charset=utf-8",
		    		success : function(response){
						if(response.status === "success"){
							location.reload();
						} else {
							alert("수정 실패");
						}
					}
		    	});
	}
	//====================== 수정  끝 ===================
	//====================== 삭제 시작 ===================
	 function del(num){
			var todoDiv = $('.todoList'+num)
			var tdNum = $('#tdNo'+num).val(); 
			var tdTypeVal = $('#tdType'+num).val();
			
		var todoData = {
			tdNo : tdNum,
			tdType : tdTypeVal,
		}
		
		$.ajax({
			type : "post",
			url : 	"/todo/delTodo",
			data : JSON.stringify(todoData),
			contentType :  "application/json; charset=utf-8",
			success : function(response){
				if(response.status === "success"){
					todoDiv.remove();
				} else {
					alert("수정 실패");
				}
			}
		});
	};
	//====================== 삭제 끝 ===================
	var inputSave = {};
		
		
	// =============== 연필모양 버튼 클릭 시 =========================
	function sys(num) {
		inputSave = $('.tdContent' + num).val();
		document.querySelectorAll('[id^=tdContent').forEach(function(e) {
    		e.disabled = true;  
		});
	    document.querySelectorAll('[id^=finYn').forEach(function(e) {
    		e.disabled = true;  
		});
		$('div[id^=sysForm]').each(function(){
			$(this).addClass('d-none');
		})
		$('span[id^=importText]').each(function(){
			$(this).addClass('d-none');
		})
		$('input[id^=importYn]').each(function(){
			$(this).addClass('d-none');
		})
		$('#importText'+num).removeClass('d-none');
    	/* $('#finYn'+num).prop('disabled',false);
    	$('#finYn'+num).on('click',function(){
    		if ($('#finYn'+num).prop("checked")) { 
    			$('#finYn'+num).val('Y');
    		} else {
    			$('#finYn'+num).val('N');
    		}
    		console.log($('#finYn'+num).val())
    	});  */
    	$('#importYn'+num).removeClass('d-none');
		$('#sysForm'+num).removeClass('d-none');
		$('.tdContent' + num).prop('disabled',false);
	}
	// =============== 연필모양 버튼 클릭 시 종료=========================
	// ================== 뒤로 돌아가는 버튼 만들기 ====================
	function cancel(num) {
		$('.sysForm'+num).addClass('d-none');
		$('.tdContent' + num).val(inputSave)
	    document.querySelectorAll('[id^=sysForm]').forEach(function(e) {
    		e.style.display = 'none'; 
		});
	    document.querySelectorAll('[id^=importYnModify]').forEach(function(e) {
    		e.style.display = 'none';  
		});
	    document.querySelectorAll('[id^=tdContent').forEach(function(e) {
    		e.disabled = true;  
		});
	    document.querySelectorAll('[id^=finYn').forEach(function(e) {
    		e.disabled = true;  
		});
	    $('#importText'+num).addClass('d-none');
	    $('#importYn'+num).addClass('d-none');
	}
		
	// ================== 뒤로 돌아가는 버튼 만들기 끝 ====================
		
	// 신규등록 상황에서 중요버튼 클릭 시 상태변화
	// 상위 요소에 걸고 이벤트 입력해야함....진짜...믾이햇다..너란 자식 진짜 
	   $('#ContentDiv').on('click', '#importYn', function() {
	    if ($(this).prop("checked")) { 
	        $(this).val('Y');
	    } else {
	        $(this).val('N');
	    }
	
	    console.log($(this).val());
		});
	
	// ==============인서트 후 동적으로 생성된 등록 이벤트 End================ 

	
	// ================================ 신규등록 ================================
	// 회색 div 클릭시 등록하는 영역 생성
    function insertForm(){
        $('#newTodoDiv').removeClass('d-none');
    }
    // x 버튼 클릭시 input hide
    function insertXBtn(){
    	$('#newTdType').val('day');
    	$('#newTdContent').val('');
    	$('#newImportYn').prop('checked',false);
    	$('#newImportYn').val('N');
        $('#newTodoDiv').addClass('d-none');
    }
	 
	// ================================ 신규등록  끝================================
    
	$(function () {
		
	    // ================================ 신규등록 ================================
	    // 신규등록 상황에서 중요버튼 클릭 시 상태변화
	    var newImportYn = $('#newImportYn');
	    newImportYn.on('click', function() {

		    if ($(this).prop("checked")) { 
		        $(this).val('Y');
		    } else {
		        $(this).val('N');
		    }

		    
		});
	    
	    $('#insertBtn').on('click', function(){
			var tdContentVal = $('#newTdContent').val();
			var importYnVal = $('#newImportYn').val();
			var tdTypeVal = $('#newTdType').val();
			
			var todo = {
				tdContent : tdContentVal,
            	importYn : importYnVal,
            	tdType : tdTypeVal
			}
			$.ajax({
				type : "post",
				url : "/todo/insertTodo1",
				data : JSON.stringify(todo),
				contentType : "application/json; charset=utf-8",
				success : function(res){
					if(res.status === "OK"){
					/* 	statusChange(response.todo); */
					console.log(res)
			    	$('#newTdContent').val('');
			    	$('#newImportYn').prop('checked',false);
			    	
			    	txt = '';
			    	txt += `
			    		<div class="todoList\${res.todo.tdNo } d-flex flex-row" id="todoList">
            			<input type="checkbox"  class="finYnCheck form-check-input" id="finYn\${res.todo.tdNo }" value="\${res.todo.finYn }" onclick=changYn(\${res.todo.tdNo })>
            			`;
            			
            				if(res.todo.finYn === 'Y'){
            					txt += `
            					<input type="text" class="tdContent\${res.todo.tdNo } no-border-input w-50" id="tdContent${todo.tdNo } " name="tdContent" value="${todo.tdContent }" style="text-decoration: line-through; background-color: transparent; border: none; " disabled="true">
            					`;
            				} else {
            					txt += `
	            					<input type="text" class="tdContent\${res.todo.tdNo } no-border-input w-50" id="tdContent\${res.todo.tdNo }" name="tdContent" value="\${res.todo.tdContent }" style="border: none; background-color: transparent; "disabled="true">
            					`;
            				}
            				if(res.todo.importYn === 'Y'){
                				txt += `
                					<span style="color: red;"><strong>[중요]</strong></span>
                				`;
                			}else {
                				txt += `
                					<span ><strong>[일반]</strong></span>
                				`;
                			}
            			txt += `
			            <select id="tdType\${res.todo.tdNo }"  style="display:none;">
			            <option value="day" selected="selected">오늘</option>
			            <option value="week">주간</option>
			            <option value="month">월간</option>
			       		</select>
			            `;
			            if(res.todo.importYn === 'Y'){
			            	txt +=`
					          	<span class="d-none" id="importText\${res.todo.tdNo }">중요 여부</span>   <input class="form-check-input d-none" type="checkbox" id="importYn${todo.tdNo }" name="importYn" value="\${res.todo.importYn }" style="flex: 0 0 auto;" checked="checked">
			            	`;
			            } else {
			            	txt += `
					          	<span class="d-none" id="importText\${res.todo.tdNo }">중요 여부</span>   <input class="form-check-input d-none" type="checkbox" id="importYn${todo.tdNo }" name="importYn" value="\${res.todo.importYn }" style="flex: 0 0 auto;" >
			            	`;
			            }
			           txt +=` 
			            <input  type="hidden" id="tdNo\${res.todo.tdNo }"  value="\${res.todo.tdNo }" >
			            <button class="Btn" id="sysBtn\${res.todo.tdNo }" onclick=sys(\${res.todo.tdNo }) >✐</button>
			            <div id="sysForm\${res.todo.tdNo }" class="sysForm\${res.todo.tdNo } d-flex flex-row d-none"> 
							<button class="Btn" id="delBtn\${res.todo.tdNo }" onclick=del(\${res.todo.tdNo }) >X</button> 
							<button class="Btn" id="modBtn\${res.todo.tdNo }" onclick=modify(\${res.todo.tdNo }) >수정</button> 
						</div>
            		</div>
			    	`;
			    		$('#todoListInsert').before(txt); 
			    	
					} 
				}
			});
		});
	// ================================ 신규등록  끝================================

	// ================================ 수정 시작 ================================	
		// ========= 수정 상황에서 중요버튼 클릭 시 상태변화 ===============
		$('input[id^=importYn]').on('click',function(){
			if ($(this).prop("checked")) { 
		        $(this).val('Y');
		    } else {
		        $(this).val('N');
		    }
		    console.log($(this).val());
		})
		
		
		
		// ========= 수정 상황에서 중요버튼 클릭 시 상태변화 끝===============
	// ================================ 수정 시작 2 ================================	
	   
		
		
		function modify(num) {
	    	
	    	var tdContentVal = $('#newTdContent'+num).val();
			var importYnVal = $('#importYn'+num).val();
			var tdNoVal = $('#tdNo'+num).val();
			
	    	var updateData = {
	    			importYn : importYnVal,
	    			tdContent : tdContentVal,
	    				tdNo : tdNoVal
	    	}
	    }
	});
	
</script>

