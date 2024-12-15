<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- ===============================================-->
<!--    sidebar 시작    -->
<!-- ===============================================-->

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
.Btn{
 	border: none;
	background-color:transparent;
}

#allToDo {
 	border: none;
	background-color:transparent;
}
#dayTodo {
 	border: none;
	background-color:transparent;
}
#weekTodo {
 	border: none;
	background-color:transparent;
}
#monthTodo {
 	border: none;
	background-color:transparent;
}
#todolist {
	border: solid 2px black;
}
#tdContent{
border: none;
	background-color:transparent;
}

</style>
<div class="navbar-vertical-content h-100 scrollbar border-end border-end-1" style="width: 250px;">
	<div class="flex-column">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">To Do List</h4>
			<!-- <i class="bi bi-gear text-dark-emphasis fs-7 me-3"  style="cursor:pointer" onclick=autoMake()></i> -->
		</div>
	</div>
	<div class="p-3" id="sidebar-content"">
		<ul class="mb-0 treeview" id="treeviewExample">
			<li class="treeview-list-item"><div class="treeview-row"></div>
				<p class="treeview-text">
					<a href="/todo/dayTodo"><span style="color: #232e3c; font-weight: 500; font-size: 18px; cursor:pointer">오늘 To Do</span></a>
				</p>
			</li>
			<li class="treeview-list-item"><div class="treeview-row"></div>
				<p class="treeview-text">
					<a href="/todo/weekTodo"><span style="color: #232e3c; font-weight: 500; font-size: 18px;cursor:pointer">주간 To Do</span></a>
				</p>
			</li>
			<li class="treeview-list-item"><div class="treeview-row"></div>
				<p class="treeview-text">
					<a href="/todo/monthTodo"><span style="color: #232e3c; font-weight: 500; font-size: 18px; cursor:pointer">월간 To Do</span></a>
				</p>
			</li>
			<li class="treeview-list-item"><div class="treeview-row"></div>
				<p class="treeview-text">
					<a href="/todo/allTodo"><span style="color: #232e3c; font-weight: 500; font-size: 18px; cursor:pointer">모든 To Do</span></a>
				</p>
			</li>
		</ul>
	</div>
</div>
<!-- ===============================================-->
<!--    sidebar 끝    -->
<!-- ===============================================-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
function todohome(){
	location.href = "/todo/list"
}

/* function autoMake(){
	location.href = "/todo/autoHome"
} */
$(function(){
	// ===================== 사이드바 이동 =======================
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
	// ===================== 사이드바 이동 끝 =======================
	
});
</script>