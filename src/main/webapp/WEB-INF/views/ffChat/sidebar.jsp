<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar-vertical-content h-100 border-end border-end-1 position-relative" style="width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">화상대화</h4>
		</div>
		<div style="text-align: center;">
			<a class="btn border-dark me-1 mb-1 px-5 py-2" href="/mail/new" id="registerBtn">채팅방 생성하기</a>
		</div>
	</div>
	<div class="p-3 position-relative" id="sidebar-content"">
		<ul class="mb-0 treeview position-relative" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">채팅방 목록</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-1" data-show="true">
				
				</ul>
			</li>
		</ul>
	</div>
</div>