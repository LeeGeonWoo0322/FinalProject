<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


	<tiles:insertAttribute name = "siderbar"></tiles:insertAttribute>


<style type="text/css">
#tdContentInput {
	background-color: gray;
	width: 200px;
	height: 30px; 
}

#newTodoDiv{

	display: none;
}

</style>


	<div class="d-flex flex-column w-100" id="ContentDiv">
		<c:choose>
			<c:when test="${empty todoVO }">
				<div class="h-100">
				
					<div class="card-header border-bottom">
		                  <h2 class="mb-0">To Do List</h2>
		            </div>
				오늘의 Todo가 없습니다.
							<div id="newTodoDiv">
								중요여부 <input type="checkbox" id="newImportYn" name="importYn" value="N">
								<input type="text" id="newTdContent" name="tdContent" >
								<select id="newTdType" name="tdType" style="display:none">
									<option value="day" selected="selected">오늘</option>
									<option value="week">주간</option>
									<option value="month">월간</option>
								</select>
								<button id="insertBtn">등록</button>
								<button id="insertXBtn" onclick=insertXBtn()>X</button>
							</div>
						<div class="btn btn-sm btn-link d-block py-2"  onclick=insertForm()>
							<button class="btn btn-link btn-sm d-block w-100 btn-add-card text-decoration-none text-600" type="button">
											<svg style="width: 15px; height: 15px" class="svg-inline--fa fa-plus fa-w-14 me-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                                                <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
                                            </svg>
										</button>
							투두 리스트 추가
						</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="card overflow-hidden" style="box-shadow: none">
					<div class="card-header border-bottom">
		                  <h2 class="mb-0">To Do List</h2>
		            </div>
					오늘의 Todo
					
					
				
			 	<div class="card-body p-0" id="listDiv">
					<c:choose>
						<c:when test="${todo.finYn eq 'Y' }">
						<div>
								<input type="checkbox" name="finYn" class="finYn" id="finYn${todo.tdNo }" value="Y" checked="checked" disabled="disabled">
								<input type="hidden" id="tdNo${todo.tdNo }" name="tdNo" value="${todo.tdNo}">
								 <div id="importYnModify" class="importYnModify${todo.tdNo}" style="display: none"  >
								 	중요 여부 <input type="checkbox" class="importYnMod" id="importYn${todo.tdNo }" name="importYn" value="${todo.importYn }" >
											<select id="tdType${todo.tdNo }" name="tdType">
											<c:choose>
												<c:when test="${todo.tdType eq 'day'}">
													<option value="day" selected="selected">오늘</option>
													<option value="week">주간</option>
													<option value="month">월간</option>
												</c:when>
												<c:when test="${todo.tdType eq 'month'}">
													<option value="day" >오늘</option>
													<option value="week" >주간</option>
													<option value="month" selected="selected">월간</option>
												</c:when>
												<c:otherwise>
													<option value="day">오늘</option>
													<option value="week" selected="selected">주간</option>
													<option value="month">월간</option>
												</c:otherwise>
											</c:choose>
											</select>
								 </div>
								<c:if test="${todo.importYn eq 'Y' }">
									<del><span style="color: red;"><strong>[중요]</strong></span></del>
								</c:if>
								 <input type="text" class="tdContent${todo.tdNo }" id="tdContent" name="tdContent" value="${todo.tdContent }" disabled="true" style="text-decoration: line-through;"> 
								<button class="Btn" id="sysBtn${todo.tdNo}" onclick=sys(${todo.tdNo}) >✐</button>
							</div>
						</c:when>
						<c:otherwise>
							<div id="listDiv">
								<input type="checkbox" class="finYn" name="finYn" id="finYnCheck${todo.tdNo }" value="N" data-fin-val="${todo.finYn }" onclick=finYnStatus(${todo.tdNo})>
								<input type="hidden" id="tdNo${todo.tdNo }" name="tdNo" value="${todo.tdNo}">
								 <div id="importYnModify" class="importYnModify${todo.tdNo}" style="display: none"  >
								 	중요 여부 <input type="checkbox" class="importYnMod" id="importYn${todo.tdNo }" name="importYn" value="${todo.importYn }" >
											<select id="tdType${todo.tdNo }" name="tdType">
											<c:choose>
												<c:when test="${todo.tdType eq 'day'}">
													<option value="day" selected="selected">오늘</option>
													<option value="week">주간</option>
													<option value="month">월간</option>
												</c:when>
												<c:when test="${todo.tdType eq 'month'}">
													<option value="day" >오늘</option>
													<option value="week" >주간</option>
													<option value="month" selected="selected">월간</option>
												</c:when>
												<c:otherwise>
													<option value="day">오늘</option>
													<option value="week" selected="selected">주간</option>
													<option value="month">월간</option>
												</c:otherwise>
											</c:choose>
											</select>
								 </div>
								<c:if test="${todo.importYn eq 'Y' }">
									<span style="color: red;"><strong>[중요]</strong></span>
								</c:if>
								<input type="text" class="tdContent${todo.tdNo }" id="tdContent" name="tdContent" value="${todo.tdContent }" disabled="true">
								<button class="Btn" id="sysBtn${todo.tdNo}" onclick=sys(${todo.tdNo}) >✐</button>
								
							</div>
						</c:otherwise>
					</c:choose>
							
								<div id="sysForm" class="sysForm${todo.tdNo}" style="display : none"> 
									<button class="Btn" id="delBtn${todo.tdNo }" onclick=del(${todo.tdNo}) >X</button> 
									<button class="Btn" id="modBtn${todo.tdNo }" onclick=modify(${todo.tdNo }) >수정</button> 
									<button class="Btn" id="xBtn" onclick=cancel(${todo.tdNo})>↩️</button> 
								</div>
					</table>
			</c:otherwise>
		</c:choose>
				
						
			
		</div>
	
	

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">

	//====================== 완료 투두 만들기 함수 시작 ===================
		
		
		
		 
	function finYnStatus(num){
		var finYN = $('.finYn');
		var finYnCheck = $('#finYnCheck'+num);
		finYN.on('change',function(){
			
//			var CfinYnVal = event.target.dataset.finVal;
//			var CfinYnId = event.target.id;
		 	if (finYnCheck.prop("checked")) { 
		 		finYnCheck.val('Y');
		 		 if(finYnCheck.val() === 'Y'){
						var tdContentVal = $('.tdContent'+num).val();
						var importYnVal = $('#importYn'+num).val();
						var tdNoVal = $('#tdNo'+num).val();
						var finYnVal = $('#finYnCheck'+num).val();
						var tdTypeVal = $('#tdType'+num).val();
						var finData = {
									importYn : importYnVal,
					    			tdContent : tdContentVal,
					    				tdNo : tdNoVal,
					    				finYn : finYnVal,
					    				tdType : tdTypeVal,
						}
						 
						 $.ajax({
							type : "post",
				    		url : "/todo/finTodo",
				    		data : JSON.stringify(finData),
				    		contentType :  "application/json; charset=utf-8",
				    		success : function(response){
								if(response.status === "success"){
									statusChange(response.todo);
								} else {
									alert("수정 실패");
								}
							}
						 }); 
					    console.log("아작스 실행");
				}
		    } else {
		    	finYnCheck.val('N');
		    }
		});
		
		
	}


	//====================== 완료 투두 만들기 함수 끝 ===================
	//====================== 수정 시작 ===================
	function modify(num) {
		    	
		    	var tdContentVal = $('.tdContent'+num).val();
				var importYnVal = $('#importYn'+num).val();
				var tdNoVal = $('#tdNo'+num).val();
				var finYnVal = $('#finYnCheck'+num).val();
				var tdTypeVal = $('#tdType'+num).val();
				
		    	var updateData = {
		    			importYn : importYnVal,
		    			tdContent : tdContentVal,
		    				tdNo : tdNoVal,
		    				finYn : finYnVal,
		    				tdType : tdTypeVal,
		    	}
		    	console.log(updateData)
		    	
		    	$.ajax({
		    		type : "post",
		    		url : "/todo/updateTodo",
		    		data : JSON.stringify(updateData),
		    		contentType :  "application/json; charset=utf-8",
		    		success : function(response){
						if(response.status === "success"){
							statusChange(response.todo);
						} else {
							alert("수정 실패");
						}
					}
		    	});
	}
	//====================== 수정  끝 ===================
	//====================== 삭제 시작 ===================
	 function del(num){
		if(confirm("삭제하시겠습니까?")){
		
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
					statusChange(response.todo);
				} else {
					alert("수정 실패");
					statusChange(response.todo);
				}
			}
		});
		}
	};
	//====================== 삭제 끝 ===================
	var inputSave = {};
		
		
	// =============== 연필모양 버튼 클릭 시 =========================
	function sys(num) {
		inputSave = $('.tdContent' + num).val();
    	// 모든 폼 안보이게
	    document.querySelectorAll('[id^=sysForm]').forEach(function(e) {
    		e.style.display = 'none'; 
		});
    	// 모든 체크박스 안보이게
	    document.querySelectorAll('[id^=importYnModify]').forEach(function(e) {
    		e.style.display = 'none';  
		});
	    document.querySelectorAll('[id^=tdContent').forEach(function(e) {
    		e.disabled = true;  
		});
	    document.querySelectorAll('[id^=finYn').forEach(function(e) {
    		e.disabled = true;  
		});
    	// 해당 num에 관련된 요소 열기
    	$('#finYn'+num).prop('disabled',false); 
    	$('#finYn'+num).on('click',function(){
    		if ($('#finYn'+num).prop("checked")) { 
    			$('#finYn'+num).val('Y');
    		} else {
    			$('#finYn'+num).val('N');
    		}
    		console.log($('#finYn'+num).val())
    	}); 
    	$('.importYnModify'+num).show();
		$('.sysForm'+num).show();
		$('.tdContent' + num).prop('disabled',false);
	}
	// =============== 연필모양 버튼 클릭 시 종료=========================
	// ================== 뒤로 돌아가는 버튼 만들기 ====================
	function cancel(num) {
		$('.sysForm'+num).hide();
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
	}
		
	// ================== 뒤로 돌아가는 버튼 만들기 끝 ====================
		
	// ==============인서트 후 동적으로 생성된 등록 이벤트================ 
	function newTodoInsert(){
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
			url : "/todo/insertTodo",
			data : JSON.stringify(todo),
			contentType : "application/json; charset=utf-8",
			success : function(response){
				if(response.status === "success"){
					statusChange(response.todo);
				} else {
					alert("수정 실패");
					statusChange(response.todo);
				}
			}
		});
	}
	
	// 신규등록 상황에서 중요버튼 클릭 시 상태변화
	// 상위 요소에 걸고 이벤트 입력해야함....진짜...믾이햇다..너란 자식 진짜 
	   $('#ContentDiv').on('click', '#newImportYn', function() {
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
        $('#newTodoDiv').show()
    }
    // x 버튼 클릭시 input hide
    function insertXBtn(){
    	$('#newTdType').val('day');
    	$('#newTdContent').val('');
    	$('#newImportYn').prop('checked',false);
        $('#newTodoDiv').hide();
    }
	
    function statusChange(todo){
		
		ContentDiv = $('#ContentDiv');
		
		if(todo === null && todo.length === 0){
			txt = '';
			txt += `
			<div class="d-flex flex-column w-100" id="ContentDiv">
				<div class="h-100">
					
					<div class="card-header border-bottom">
		                  <h2 class="mb-0">To Do List</h2>
		            </div>
				오늘의 Todo가 없습니다.
				</div>
			`;
			txt += '<div id="newTodoDiv">';
			txt += '중요여부 <input type="checkbox" id="importYnBtn" name="importYn" value="N">'
			txt += '<input type="text" id="tdContent" name="tdContent" >';
			txt += '<select name="tdType">';
			txt +=	'<option value="day" selected="selected">오늘</option><option value="week">주간</option><option value="month">월간</option>';
			txt += '</select>';
			txt += `
				<div class="btn btn-sm btn-link d-block py-2"  onclick=insertForm()>
				<svg class="svg-inline--fa fa-plus fa-w-14 me-1 fs-11" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path></svg>
				투두 리스트 추가
			</div>
			</div>
				
			`	
		} else {
			
			txt = '';
			txt += `
		<div class="d-flex flex-column w-100" id="ContentDiv">
			<div class="h-100">
				
				<div class="card-header border-bottom">
	                  <h2 class="mb-0">To Do List</h2>
	            </div>
            </div>
			
			`;
				for(var i=0; i<todo.length; i++){
					 	txt += '<div id="listDiv">'
					if(todo[i].finYn == "Y"){
					 	txt += '<input type="checkbox" name="finYn" class="finYn" id="finYnCheck'+todo[i].tdNo +'" value="Y" checked="checked" disabled="disabled">'
						txt += '<input type="hidden" id="tdNo'+todo[i].tdNo +'" name="tdNo" value="'+todo[i].tdNo +'">'
						txt += '<div id="importYnModify" class="importYnModify'+todo[i].tdNo +'" style="display: none"  >'
						txt += '중요 여부 <input type="checkbox" class="importYnMod" id="importYn'+todo[i].tdNo +'" name="importYn" value="'+todo[i].importYn +'" >' 
						txt += '<select id="tdType'+todo[i].tdNo +'" name="tdType">'
						if(todo[i].tdType == 'day'){
							txt += '<option value="day" selected="selected">오늘</option>'
							txt += '<option value="week">주간</option>'
							txt += '<option value="month">월간</option>'
						} else if (todo[i].tdType =='month'){
							txt += '<option value="day" >오늘</option>'
							txt += '<option value="week" >주간</option>'
							txt += '<option value="month" selected="selected">월간</option>'
						} else {
							txt += '<option value="day">오늘</option>'
							txt += '<option value="week" selected="selected">주간</option>'
							txt += '<option value="month">월간</option>'	
						}
						txt += '</select>'
						txt += '</div>'
						if(todo[i].importYn == 'Y'){
							txt += '<del><span style="color: red;"><strong>[중요]</strong></span></del>'
						}
						txt += '<input type="text" class="tdContent'+todo[i].tdNo +'" id="tdContent" name="tdContent" value="'+todo[i].tdContent +'" disabled="true" style="text-decoration: line-through;">' 
					} else {
						
					
					txt += '<input type="checkbox" class="finYn" name="finYn" id="finYnCheck'+todo[i].tdNo +'" value="N" data-fin-val="'+todo[i].finYn +'" onclick=finYnStatus('+todo[i].tdNo +')>';		
					txt += '<input type="hidden" id="tdNo'+todo[i].tdNo+'" value="'+todo[i].tdNo+'">';
					txt += ' <div id="importYnModify'+todo[i].tdNo+'" style="display: none"  >';
					txt += '중요 여부 <input type="checkbox" class="importYnMod" id="importYn'+todo[i].tdNo+'" name="importYn" value="'+todo[i].importYn+'" >';
					txt += '<select id="tdType'+todo[i].tdNo+'" name="tdType">';
						if(todo[i].tdType === 'day'){
							txt += '<option value="day" selected="selected">오늘</option><option value="week">주간</option><option value="month">월간</option>';
						} else if(todo[i].tdType === 'month') {
							txt += '<option value="day">오늘</option><option value="week">주간</option><option value="month"  selected="selected">월간</option>';
						} else {
							txt += '<option value="day">오늘</option><option value="week"  selected="selected">주간</option><option value="month" >월간</option>';
						}
					txt += '</select>';
					txt += '</div>';
						if(todo[i].importYn === 'Y'){
							txt += '<span style="color: red;"><strong>[중요]</strong></span>';
						};
					txt += '<input type="text" class="tdContent'+todo[i].tdNo+'" id="tdContent" name="tdContent" value="'+todo[i].tdContent+'" disabled="true">';
					
					
					
					}
					txt += '<button class="Btn" id="sysBtn'+todo[i].tdNo+'" onclick=sys('+todo[i].tdNo+') >✐</button>';
					txt += '</div>';
					
					txt += '<div id="sysForm" class="sysForm'+todo[i].tdNo+'" style="display : none"> ';
					txt += ' <button class="Btn" id="delBtn'+todo[i].tdNo+'" onclick=del('+todo[i].tdNo+') >X</button>';
					txt += ' <button class="Btn" id="modBtn'+todo[i].tdNo+'" onclick=modify('+todo[i].tdNo+')>수정</button>';
					txt += '<button class="Btn" id="xBtn'+todo[i].tdNo+'" onclick=cancel('+todo[i].tdNo+')>↩️</button> ';
					txt += '</div>';
				} 
					
					txt += '<div id="newTodoDiv">';
					txt += '중요여부 <input type="checkbox" id="newImportYn" name="importYn" value="N">'
					txt += '<input type="text" id="newTdContent" name="tdContent" >';
					txt += '<select id="newTdType" name="tdType" style="display:none">';
					txt += '<option value="day" selected="selected">오늘</option>';
					txt += '<option value="week">주간</option>';
					txt += '<option value="month">월간</option></select>';
					txt += '<button id="insertBtn" onclick=newTodoInsert()>등록</button>';
					txt += '<button id="insertXBtn" onclick=insertXBtn()>X</button></div>';
					txt += `
						<div class="btn btn-sm btn-link d-block py-2"  onclick=insertForm()>
						<button class="btn btn-link btn-sm d-block w-100 btn-add-card text-decoration-none text-600" type="button">
						<svg style="width: 15px; height: 15px" class="svg-inline--fa fa-plus fa-w-14 me-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
                            <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
                        </svg>
					</button>
						투두 리스트 추가
					</div>
					`;
					txt += ' </div>';
				
		} 
		ContentDiv.html(txt);
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
				url : "/todo/insertTodo",
				data : JSON.stringify(todo),
				contentType : "application/json; charset=utf-8",
				success : function(response){
					if(response.status === "success"){
						statusChange(response.todo);
					} else {
						alert("추가 실패");
					}
				}
			});
		});
	// ================================ 신규등록  끝================================

	// ================================ 수정 시작 ================================	
		// ========= 수정 상황에서 중요버튼 클릭 시 상태변화 ===============
		var importYnMod = $('.importYnMod');
		importYnMod.on('click', function() {

		    if ($(this).prop("checked")) { 
		        $(this).val('Y');
		    } else {
		        $(this).val('N');
		    }
		    console.log($(this).val());
		});
		
		
		
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

 <!-- ===============================================-->
  <!--    설정 시작    -->
  <!-- ===============================================-->
  
    <div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1"
    aria-labelledby="settings-offcanvas">
    <div class="offcanvas-header settings-panel-header justify-content-between bg-shape">
      <div class="z-1 py-1">
        <div class="d-flex justify-content-between align-items-center mb-1">
          <h5 class="text-white mb-0 me-2"><span class="fas fa-palette me-2 fs-9"></span>Settings</h5>
          <button class="btn btn-primary btn-sm rounded-pill mt-0 mb-0" data-theme-control="reset"
            style="font-size:12px"> <span class="fas fa-redo-alt me-1"
              data-fa-transform="shrink-3"></span>Reset</button>
        </div>
        <p class="mb-0 fs-10 text-white opacity-75"> Set your own customized style</p>
      </div>
      <div class="z-1" data-bs-theme="dark">
        <button class="btn-close z-1 mt-0" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
    </div>
    <div class="offcanvas-body scrollbar-overlay px-x1 h-100" id="themeController">
      <h5 class="fs-9">Color Scheme</h5>
      <p class="fs-10">Choose the perfect color mode for your app.</p>
      <div class="btn-group d-block w-100 btn-group-navbar-style">
        <div class="row gx-2">
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherLight" name="theme-color" type="radio" value="light"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherLight"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-default.jpg" alt="" /></span><span
                class="label-text">Light</span></label>
          </div>
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherDark" name="theme-color" type="radio" value="dark"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherDark"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-dark.jpg" alt="" /></span><span class="label-text">
                Dark</span></label>
          </div>
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherAuto" name="theme-color" type="radio" value="auto"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherAuto"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-auto.jpg" alt="" /></span><span class="label-text">
                Auto</span></label>
          </div>
        </div>
      </div>
      <hr />
      <div class="d-flex justify-content-between">
        <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/left-arrow-from-left.svg"
            width="20" alt="" />
          <div class="flex-1">
            <h5 class="fs-9">RTL Mode</h5>
            <p class="fs-10 mb-0">Switch your language direction </p><a class="fs-10"
              href="documentation/customization/configuration.html">RTL Documentation</a>
          </div>
        </div>
        <div class="form-check form-switch">
          <input class="form-check-input ms-0" id="mode-rtl" type="checkbox" data-theme-control="isRTL" />
        </div>
      </div>
      <hr />
      <div class="d-flex justify-content-between">
        <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/arrows-h.svg" width="20" alt="" />
          <div class="flex-1">
            <h5 class="fs-9">Fluid Layout</h5>
            <p class="fs-10 mb-0">Toggle container layout system </p><a class="fs-10"
              href="documentation/customization/configuration.html">Fluid Documentation</a>
          </div>
        </div>
        <div class="form-check form-switch">
          <input class="form-check-input ms-0" id="mode-fluid" type="checkbox" data-theme-control="isFluid" />
        </div>
      </div>
      <hr />
      <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/paragraph.svg" width="20" alt="" />
        <div class="flex-1">
          <h5 class="fs-9 d-flex align-items-center">Navigation Position</h5>
          <p class="fs-10 mb-2">Select a suitable navigation system for your web application </p>
          <div>
            <select class="form-select form-select-sm" aria-label="Navbar position" data-theme-control="navbarPosition">
              <option value="vertical">Vertical
              </option>
              <option value="top">Top</option>
              <option value="combo">Combo</option>
              <option value="double-top">Double
                Top</option>
            </select>
          </div>
        </div>
      </div>
      <hr />
      <h5 class="fs-9 d-flex align-items-center">Vertical Navbar Style</h5>
      <p class="fs-10 mb-0">Switch between styles for your vertical navbar </p>
      <p> <a class="fs-10" href="modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See
          Documentation</a></p>
      <div class="btn-group d-block w-100 btn-group-navbar-style">
        <div class="row gx-2">
          <div class="col-6">
            <input class="btn-check" id="navbar-style-transparent" type="radio" name="navbarStyle" value="transparent"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-transparent"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/default.png" alt="" /><span class="label-text">
                Transparent</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-inverted" type="radio" name="navbarStyle" value="inverted"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-inverted"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/inverted.png" alt="" /><span class="label-text">
                Inverted</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-card" type="radio" name="navbarStyle" value="card"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-card"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/card.png" alt="" /><span class="label-text">
                Card</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-vibrant" type="radio" name="navbarStyle" value="vibrant"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-vibrant"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/vibrant.png" alt="" /><span class="label-text">
                Vibrant</span></label>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- ===============================================-->
  <!--    설정 끝    -->
  <!-- ===============================================-->
  

