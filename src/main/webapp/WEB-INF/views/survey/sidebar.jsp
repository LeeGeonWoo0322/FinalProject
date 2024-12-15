<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!-- ===============================================-->
  <!--    sidebar 시작    -->
  <!-- ===============================================-->
<style>
ul li p span:hover{
 background : rgb(224, 224, 224);
}
ul li.selected{
 color: blue;
}
</style>
<div class="navbar-vertical-content h-100 scrollbar" style="width: 250px;">
	<div class="flex-column mb-2">
		<div class="p-3">
			<h4>설문</h4>
		</div>
		<div style="text-align: center;">
			<button class="btn btn-outline-dark me-1 mb-1 px-6 py-2" type="button" onclick="location.href='registerForm1'">설문 작성</button>
		</div>
	</div>
	<ul class="mb-0 treeview" id="treeviewExample" style="margin-left: 20px">    
		<li class="treeview-list-item">
			<p class="treeview-text fw-bold">
				<a data-bs-toggle="collapse" href="#sideSurveyView" role="button" aria-expanded="flase">
					설문
				</a>
			</p>
			<ul class="mb-0 treeview" id="sideSurveyView" data-show="flase"> 
				<li class="treeview-list-item">
					<p class="treeview-text fw-bold">
						<span href="#treeviewExample-1-1" role="button" onclick="location.href='ongoingSurvey'" aria-expanded="false">
							&emsp;&emsp;진행중인 설문
						</span>
					</p>
				</li>
				<li class="treeview-list-item">
				<p class="treeview-text fw-bold">
					<span href="#treeviewExample-1-1" role="button" onclick="location.href='completedSurvey'" aria-expanded="false">
						&emsp;&emsp;마감된 설문
					</span>
				</p>
				</li>
			</ul>
		</li>
	</ul>
</div>
  <!-- ===============================================-->
  <!--    sidebar 끝    -->
  <!-- ===============================================-->