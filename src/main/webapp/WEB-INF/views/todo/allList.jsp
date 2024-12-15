<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
 
 	<tiles:insertAttribute name = "siderbar">
 	</tiles:insertAttribute>
 
   <div class="modal fade" tabindex="-1" aria-labelledby="kanban-modal-label-1" id="kanban-modal-list" aria-modal="true" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg mt-6" role="document" id="modalVal">
    
    </div>
    </div>	
    
    
    	<c:choose>
    		<c:when test="${empty todoVO }">
			<div class="d-flex flex-column w-100">
				<br/><H1>모든 Todo</H1>
	    		<div id="tableExample2" class="d-flex flex-column p-2" data-list='{"valueNames":["rownum","tdType","date","finTodo","totalTodo"],"page":10,"pagination":true}'>
					<div class="table-responsive scrollbar" style="flex: 1;">
						<table class="table table-bordered fs-10 mb-0">
							<thead class="bg-200">
								<tr>
									<th class="text-900 " name="rownum" style="width: 50px">NO</th>
									<th class="text-900 " name="tdType" style="width: 200px">타입</th>
									<th class="text-900 " name="date" style="width: 200px">등록일</th>
									<th class="text-900" name="finTodo,totalTodo" style="width: 200px">진행도</th>
								</tr>
							</thead>
							<tbody class="list" id="bulk-select-body">
									<td class="tdType">
									</td>
									<td class="tdType">
										TodoList가 없습니다.
									</td>
									<td class="tdType">
									</td>
									<td class="tdType">
									</td>
							</tbody>
					</table>
				</div>
			</div>
		</div>	
					
    		</c:when>
    		<c:otherwise>
						<c:forEach items="${todoVO }" var="todoVO" varStatus="i">
						<div style="display: none;"> <input type="text" class="tdTypeVal${i.count }" name="tdType" value="${todoVO.tdType }"> <input type="text" class="regDateVal${i.count }" name="regDate" value="${todoVO.regDate }"></div>
						</c:forEach>
			<div class="d-flex flex-column w-100">
				<H1>모든 Todo</H1><br/><hr/>
				<div id="tableExample2" class="d-flex flex-column p-2" data-list='{"valueNames":["rownum","tdType","date","finTodo","totalTodo"],"page":10,"pagination":true}'>
					<div class="table-responsive scrollbar" style="flex: 1;">
						<table class="table table-bordered fs-10 mb-0">
							<thead class="bg-200">
								<tr>
									<th class="text-900 " name="rownum" style="width: 50px">NO</th>
									<th class="text-900 " name="tdType" style="width: 200px">타입</th>
									<th class="text-900 " name="date" style="width: 200px">등록일</th>
									<th class="text-900" name="finTodo,totalTodo" style="width: 200px">진행도</th>
								</tr>
							</thead>
						<tbody class="list" id="bulk-select-body">
    			<c:forEach items="${todoVO }" var="todoVO" varStatus="i" >
					<tr>
						<td>${i.count }</td>
						<td class="tdType">
							<c:choose>
								<c:when test="${todoVO.tdType eq 'day' }">
									<button tyo class="tdTypeBtn" id="tdType${i.count }"  data-bs-toggle="modal" data-bs-target="#kanban-modal-list" onclick=modalList(${i.count}) >[일간]</button>
									<input type="hidden" id="tdTypeVal${i.count }" name="tdType" value="${todoVO.tdType }">
									<input type="hidden" id="regDate${i.count }" name="regDate" value="${todoVO.regDate }">
								</c:when>
								<c:when test="${todoVO.tdType eq 'week' }">
									<button tyo class="tdTypeBtn" id="tdType${i.count }"  data-bs-toggle="modal" data-bs-target="#kanban-modal-list" onclick=modalList(${i.count}) >[주간]</button>
									<input type="hidden" id="tdTypeVal${i.count }" name="tdType" value="${todoVO.tdType }">
									<input type="hidden" id="regDate${i.count }" name="regDate" value="${todoVO.regDate }">
								</c:when>
								<c:otherwise>
									<button tyo class="tdTypeBtn" id="tdType${i.count }"  data-bs-toggle="modal" data-bs-target="#kanban-modal-list" onclick=modalList(${i.count}) >[월간]</button>
									<input type="hidden" id="tdTypeVal${i.count }" name="tdType" value="${todoVO.tdType }">
									<input type="hidden" id="regDate${i.count }" name="regDate" value="${todoVO.regDate }">
								</c:otherwise>
							</c:choose>
						</td>
 						<td>
 							<div id="regDate" name="regDate">${todoVO.regDate }
 							 </div> 
 						</td> 
 						<td>
 							<div id="progress${i.count }" name="progress"> </div> 
 						</td>
 					</tr>   			
    				</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-center mb-3">
					<button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" id="prevBtn" data-list-pagination="prev">
						<span class="fas fa-chevron-left"></span></button>
						<ul class="pagination mb-0">
							<button class="page" type="button" data-i="${i.count }" data-page="10">${i.count }</button>
						</ul>
						<button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" id="nextBtn" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
				</div>
			</div>
		</div>
 		</c:otherwise>
 	</c:choose>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">

		
		var page = $('#nextBtn');
		
		$(function(){
			
		var ulBtn = $('.page');
		
		ulBtn.on('click',function(){
			$(document).ready(function(){
				var tdTypeListVal = []; 
				var regDateListVal = []; 
				
				 $('input[class^="tdTypeVal"]').each(function () {
					 tdTypeListVal.push($(this).val());
				 });
				 $('input[class^="regDate"]').each(function () {
					 regDateListVal.push($(this).val());
				 });
				 
				 var finDate = {
						 tdTypeList : tdTypeListVal,
						 regDateList : regDateListVal
					 } 
				$.ajax({
				    type: "POST",
				    url: "/todo/finTotal",
				    data: JSON.stringify(finDate),
				    contentType: "application/json; charset=utf-8",
				    success: function(response) {
				        if (response.status === "success") {
				            totalFin(response.todoVO); // 응답 데이터 사용
				        } 
				    }
				});
				function totalFin(todoVO) {
					 if (todoVO && todoVO.length > 0) {
					    	for (var i = 0; i < todoVO.length; i++) {
								txt = '';
								txt +=  todoVO[i].FINTODO +'/'+ todoVO[i].TOTALTODO
								$('#progress'+(i+1)).html(txt);
							}
								
								
					    } else {
					        alert("불러올 데이터가 없습니다."); // 데이터가 없을 때 메시지
					    }
				} 
			});
		});
	});
		
		page.on('click',function(){
			$(document).ready(function(){
				var tdTypeListVal = []; 
				var regDateListVal = []; 
				
				 $('input[class^="tdTypeVal"]').each(function () {
					 tdTypeListVal.push($(this).val());
				 });
				 $('input[class^="regDate"]').each(function () {
					 regDateListVal.push($(this).val());
				 });
				 
				 var finDate = {
						 tdTypeList : tdTypeListVal,
						 regDateList : regDateListVal
					 } 
				$.ajax({
				    type: "POST",
				    url: "/todo/finTotal",
				    data: JSON.stringify(finDate),
				    contentType: "application/json; charset=utf-8",
				    success: function(response) {
				        if (response.status === "success") {
				            totalFin(response.todoVO); // 응답 데이터 사용
				   	 	}
				    }
				});
				function totalFin(todoVO) {
					 if (todoVO && todoVO.length > 0) {
					    	for (var i = 0; i < todoVO.length; i++) {
								txt = '';
								txt +=  todoVO[i].FINTODO +'/'+ todoVO[i].TOTALTODO
								$('#progress'+(i+1)).html(txt);
							}
								
					} 
				}
			});
		});
		
	
	$(document).ready(function(){
		
		var tdTypeListVal = []; 
		var regDateListVal = []; 
		
		
		
		 $('input[class^="tdTypeVal"]').each(function () {
			 tdTypeListVal.push($(this).val());
		 });
		 $('input[class^="regDate"]').each(function () {
			 regDateListVal.push($(this).val());
		 });
		 
		 var finDate = {
				 tdTypeList : tdTypeListVal,
				 regDateList : regDateListVal
			 } 


		$.ajax({
		    type: "POST",
		    url: "/todo/finTotal",
		    data: JSON.stringify(finDate),
		    contentType: "application/json; charset=utf-8",
		    success: function(response) {
		        if (response.status === "success") {
		            totalFin(response.todoVO); // 응답 데이터 사용
		        } else {
		        	totalFin(response.todoVO);
		        }
		    }
		});
		 function totalFin(todoVO) {
			 if (todoVO && todoVO.length > 0) {
			    	for (var i = 0; i < todoVO.length; i++) {
						txt = '';
						txt +=  todoVO[i].FINTODO +'/'+ todoVO[i].TOTALTODO
						$('#progress'+(i+1)).html(txt);
					}
						
						
			    } else {
			    	for (var i = 0; i < todoVO.length; i++) {
						txt = '';
						
			    		txt += `
			    			
			    		`; // 데이터가 없을 때 메시지
						$('#progress'+(i+1)).html(txt);
					}
			    }
			}
		
		
	});

	function modalList(num){
		
		var tdTypeVal = $('#tdTypeVal'+num).val()
		var regDateVal = $('#regDate'+num).val();
		var date = {
				tdType : tdTypeVal,
				regDate : regDateVal
		}
		console.log(regDateVal)
		
		$.ajax({
			type : "POST",
			url :  "/todo/modalList",
			data : JSON.stringify(date),
			contentType : "application/json; charset=utf-8",
			success : function(todoVO){
				if(todoVO.status === 'success'){
					statusChange(todoVO);
				} else {
					statusChange(todoVO);
				}
			}
		});
		
	}
	
	function statusChange(todoVO) {
	    txt = '';
	    
	    if (todoVO === null || todoVO.todo.length <= 0) {  
	        txt += "Todo가 없습니다.";
	    } else {
	    	console.log("ww")
	   		txt += '<div class="modal-content border-0">';
	    	txt += '<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">';
	    	txt += '<button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>';
	    	txt += '</div>';
	    	txt += '<div class="modal-body p-0">';
	 	    txt += '<div class="bg-body-tertiary rounded-top-lg py-3 ps-4 pe-6">';
	 	    txt += ' 제목 ';
	 	    txt += '</div>';
	 	    txt += '<div class="p-4">';
	 	    txt += '<div class="col-lg-9">';
	 	    txt += '<div class="table-responsive scrollbar">';
	 	    txt += '<table class="table table-bordered" style="border : 2px; brodercolor : black">';
	 	    txt += '<thead>';
	 	    txt += '<tr><th  style="text-align: center; vertical-align: middle;">No.</th>';
	 	    txt += '<th style="text-align: center; vertical-align: middle;">중요</th>';
	 	    txt += '<th style="text-align: center; vertical-align: middle;">내용</th></tr>';
	 	    txt += '<tbody>';
	 				
	        for (var i = 0; i < todoVO.todo.length; i++) {
	        	console.log("ddd");
	        	  if (todoVO.todo[i].finYn === 'Y') {
		        	txt += '<tr class="table-active">'
	        	  } else {
		        	txt += '<tr>'
	        		  
	        	  }
	            txt +='<td style="text-align: center; vertical-align: middle;">'+(i+1)+'</td>'	
	        	txt += '<td style="text-align: center; vertical-align: middle;">'
	            	
	            if (todoVO.todo[i].finYn === 'Y') {
	                if (todoVO.todo[i].importYn === 'Y') {
	                    txt += '<del><span style="color: red;"><strong>[중요]</strong></span></del></td>';
	                } else {
	                    txt += '</td>';
	                }
	                txt += '<td><del>' + todoVO.todo[i].tdContent + '</del></td>';
	            } else {
	                if (todoVO.todo[i].importYn === 'Y') {
	                    txt += '<span style="color: red;"><strong>[중요]</strong></span></td>';
	                } else {
	                    txt += '<span>-</span></td>';
	                }
	                txt += '<td>' + todoVO.todo[i].tdContent + '</td>';
	            }
	        	txt += '</tr>'
	        }
	 	    txt += '</tbody></table>';
	        txt += '</div></div></div></div>';
	    }
	    $('#modalVal').html(txt)
	}
	
	
	$(function(){
		var  closeBtn = $('#close');
		var tdTypeBtn = $('.tdTypeBtn');
		var txt = '';
		closeBtn.on('click',function(){
			$('.modal').hide();
			txt = '';
			
		})
		
		tdTypeBtn.on("click",function(){
			$('.modal').show();
		});
	
		
		var monthTodo=$('#monthTodo');
		monthTodo.on('click',function(){
			location.href = "/todo/monthTodo";
		});
		var weekTodo = $('#weekTodo');
		weekTodo.on('click',function(){
			location.href = "/todo/weekTodo";
		});
	    var dayTodo = $('#dayTodo');
		
		dayTodo.on('click', function(){
			location.href = "/todo/dayTodo";
		});
		var allTodo = $('#allToDo');
		 allTodo.on('click',function(){
			location.href = "/todo/allTodo";
		 });
	
		
	});

</script>

  