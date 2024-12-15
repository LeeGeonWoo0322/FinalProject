<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        
        <div class="dd-flex flex-column w-100">
        	<div class="d-flex align-items-center p-3" style="background-color: #f9fafd; height: 70px; line-height: 70px">
        		<h4>TodoList 자동 생성</h4>
        	</div>
        	<div class="d-flex flex-row">
			   <div class="d-flex flex-row mb-1 w-50 " id="todoListInsert">
		       		<div id="newTodoDiv" class="d-flex flex-row align-items-center d-none" style="gap: 10px;">
				        <span>중요여부</span>
				        <input class="form-check-input" type="checkbox" id="newImportYn" name="importYn" value="N" style="flex: 0 0 auto;">
				        <input class="form-control" id="newTdContent" type="text" placeholder="오늘 할 일" style="flex: 1;">
				        <select id="newTdType" name="tdType">
				            <option value="day" selected="selected">오늘</option>
				            <option value="week">주간</option>
				            <option value="month">월간</option>
				        </select>
				        <input type="hidden" id="autoMake" value="N">
				  
				        <button id="insertBtn" style="flex: 0 0 auto;">등록</button>
				        <button id="insertXBtn" style="flex: 0 0 auto;">X</button>
				    </div>
	            </div>	
        	</div>
        	<div class="btn btn-sm btn-link d-block d-flex flex-row ps-3" onclick=insertForm()>
	        	<button id="addBtn" class="btn btn-link btn-sm d-block btn-add-card text-decoration-none text-600 p-0" type="button">
					<svg style="width: 15px; height: 15px" class="svg-inline--fa fa-plus fa-w-14 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
						<path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
					</svg>
		        	<label for="addBtn" class="m-0 fs-9 text-600" style="font-weight: bold;">추가하기</label>
				</button>
			</div>
        </div>
 <script type="text/javascript">
var txt = '';

	 
	 function insertForm(){
	     $('#newTodoDiv').removeClass('d-none');
	 }
	 
	$('#insertXBtn').on('click',function(){
		 console.log("Dd")
		 $(this).closest('div[id=newTodoDiv]').addClass('d-none');
	});
	
	 var newImportYn = $('#newImportYn');
	 newImportYn.on('click', function() {

		    if ($(this).prop("checked")) { 
		        $(this).val('Y');
		    } else {
		        $(this).val('N');
		    }
		    console.log($(this).val())

		    
	});

	
	$('#insertBtn').on('click',function(){
		var tdContentVal = $('#newTdContent').val();
		var importYnVal = $('#newImportYn').val();
		var tdTypeVal = $('#newTdType').val();
		var autoYnVal = autoMake.val();
		var todo = {
			tdContent : tdContentVal,
        	importYn : importYnVal,
        	tdType : tdTypeVal,
        	autoYn : autoYnVal
		}
		console.log("tododladw:  ",todo);
		$.ajax({
			type : "post",
			url : "/todo/insertTodo1",
			data : JSON.stringify(todo),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				if(res.status === "OK"){
				txt = ``;
				txt += `
				
				
				`;
		    		$('#todoListInsert').before(txt); 
		    	
				} 
			}
		});
	});
	
   
</script>

        