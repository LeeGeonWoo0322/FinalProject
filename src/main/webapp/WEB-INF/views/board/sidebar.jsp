<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    
<!-- ===============================================-->
<!--    sidebar 시작    -->
<!-- ===============================================-->


<div class="navbar-vertical-content h-100 scrollbar border-end border-end-1" style="width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">게시판</h4>
<!-- 			<a href=""><i class="bi bi-gear text-dark-emphasis fs-7 me-3"></i></a>    -->
		</div>
		<div style="text-align: center;">
			<c:if test="${not empty board}">
				<c:set var="boardType" value="${board.boardType}"/>
			</c:if>
			<c:choose>
				<c:when test="${boardType == '앨범게시판'}">
					<a class="btn btn-outline-dark me-1 mb-1 px-6 py-2"  href="/board/albumRegisterForm?boardType=${boardType}&postType=${postType}">글 쓰기</a>
				</c:when>
				<c:otherwise>
					<a class="btn btn-outline-dark me-1 mb-1 px-6 py-2"  href="/board/registerForm?boardType=${boardType}&postType=${postType}">글 쓰기</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="p-3" id="sidebar-content">
		<ul class="mb-0 treeview" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-3-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">전사 게시판</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-3-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/boardList?boardType=전사게시판&postType=사내공지"> <span style="height: 20px">사내 공지</span> 
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/boardList?boardType=전사게시판&postType=사내식단표"> <span style="height: 20px">사내 식단표</span>
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/boardList?boardType=전사게시판&postType=실적게시판"> <span style="height: 20px">실적 게시판</span>
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			


			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-2" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">일반 게시판</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-2" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/boardList?boardType=일반게시판&postType=세미나회의"> <span class="me-2 text-warning"></span> 세미나 & 회의
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/boardList?boardType=일반게시판&postType=자유게시판"> <span class="me-2 text-warning"></span> 자유 게시판
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			
			
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-2" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">앨범 게시판</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-2" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/albumList?boardType=앨범게시판&postType=공모전"> <span class="me-2 text-warning"></span> 공모전
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/albumList?boardType=앨범게시판&postType=행사활동"> <span class="me-2 text-warning"></span> 행사 활동
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="flex-1" href="/board/albumList?boardType=앨범게시판&postType=프로모션"> <span class="me-2 text-warning"></span> 이달의 프로모션
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>

		</ul>
	</div>


</div>
<!-- ===============================================-->
<!--    sidebar 끝    -->
<!-- ===============================================-->