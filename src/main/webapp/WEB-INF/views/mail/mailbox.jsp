<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=more_vert" />
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
 .btn{ 
 --falcon-btn-box-shadow:none; */
 } 
.btn{
/* 	border: 1px solid; */
}
.dropdown-toggle{
	padding: 5px;
}
.disabled { 
    pointer-events: none; 
    color: gray; 
    text-decoration: none; 
    opacity: 0.6; 
}
</style>

<div class="d-flex flex-column w-100 position-relative">
	<div class="d-flex flex-column justify-content-between position-relative" style="height: 120px">
		<div>
			<h4 class="p-3 m-0 align-middel" id="categoryName">
				<c:if test="${pagingVO.keyword eq '1' }">
					받은메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '2' }">
					보낸메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '3' }">
					수신확인
				</c:if>
				<c:if test="${pagingVO.keyword eq '4' }">
					임시메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '5' }">
					예약메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '6' }">
					스팸메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '7' }">
					휴지통
				</c:if>
				<c:if test="${pagingVO.keyword eq '8' }">
					중요메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '9' }">
					안읽은메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '10' }">
					읽은메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '11' }">
					첨부메일함
				</c:if>
				<c:if test="${pagingVO.keyword eq '12' }">
					내가쓴메일함
				</c:if>
				<c:if test="${pagingVO.keyword > 100 }">
					${mailBoxVO.mailboxName }
				</c:if>
			</h4>
		</div>
		<div class="d-flex flex-row justify-content-between p-2">
			<div class="d-flex d-gid gap-2 flex-row align-items-center ms-2" id="mailFnBtn">
				<div class='d-flex flex-row'>
					<div class="form-check d-flex justify-content-end align-middle align-items-center fs-8 mb-0 pb-2">
						<input type="checkbox" class='form-check-input' id='allCheckbox'>
					</div>
					<c:if test="${pagingVO.keyword ne '3' }">
						<div class="btn-group">
						  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
						  <div class="dropdown-menu">
						    <a class="dropdown-item" onclick="allCheck()">전체선택</a>
						    <a class="dropdown-item" onclick="readedMailCheck()">읽은메일</a>
						    <a class="dropdown-item" onclick="unReadedMailCheck()">안읽은메일</a>
						    <a class="dropdown-item" onclick="favMailCheck()">중요메일</a>
						    <a class="dropdown-item" onclick="unFavMailCheck()">중요표시안한메일</a>
						    <a class="dropdown-item" onclick="allUnCheck()">선택해제</a>
						  </div>
						</div>
					</c:if>
				</div>
				<c:if test="${pagingVO.keyword eq '1' }">
					<span class="FnBtn btn p-1 disabled" onclick="openAddSpamModal()"> 
						<span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
								<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
							</svg>
						</span> <span>스팸등록</span>
					</span>					
				</c:if>
				<c:if test="${(pagingVO.keyword eq '6') or (pagingVO.keyword eq '7')}">
					<span class="FnBtn btn p-1 disabled" onclick="openUnSpamModal()"> 
						<span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
								<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
							</svg>
						</span> <span>스팸해제</span>
					</span>			
				</c:if>
				<c:if test="${!((pagingVO.keyword eq '3') or (pagingVO.keyword eq '4') or (pagingVO.keyword eq '5'))}">
					<span class="FnBtn btn-group disabled">
					  	<button class="replyBtn btn p-1" type="button" onclick="mailReply()"><i class="bi bi-arrow-return-right me-1"></i>답장</button>
					  	<button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only"></span></button>
					 	<div class="dropdown-menu">
					  	 	 <a class="replyBtn dropdown-item" href="#" onclick="mailReply()">답장</a>
					  	 	 <a class="allReplyBtn dropdown-item" href="#" onclick="mailAllReply()">전체답장</a>
					 	</div>
					</span>		
				</c:if>
				<c:if test="${pagingVO.keyword ne 3 }">
					<span class="FnBtn btn-group disabled">
						<button class="btn p-1" type="button" 
							<c:if test="${pagingVO.keyword eq 7 }">
								onclick="trashDeleteModalOpen()">
							</c:if>
							<c:if test="${pagingVO.keyword ne 7 }">
								onclick="deleteMail()">
							</c:if>
							<span>
							  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
									<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
								</svg>
						  	</span><span>삭제</span>
					  	</button>
						<button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only"></span></button>
						<div class="dropdown-menu">
						    <a class="dropdown-item" href="#" onclick="deleteMail()">삭제</a>
						    <a class="dropdown-item" href="#" onclick="completelyDeleteModalOpen()">완전삭제</a>
						    <a class="dropdown-item" href="#" onclick="fileDeleteModalOpen()">첨부파일삭제</a>
						</div>
					</span>
				</c:if>
				<c:if test="${pagingVO.keyword eq 3}">
				    <div class="FnBtn btn-group disabled">
				        <button class="btn p-1" type="button" onclick="deleteConfirmationMail()">
				            <span>
				                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
				                    <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
				                </svg>
				            </span>
				            <span>삭제</span>
				        </button>
				    </div>
				</c:if>
				<c:if test="${pagingVO.keyword eq 1 or pagingVO.keyword eq 12 }">
					<div class="FnBtn btn-group disabled">
						<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">태그</button>
						<div class="dropdown-menu" id="tagDropdownMenu" style="width: 250px">
	
						</div>
					</div>
				</c:if>
				<c:if test="${!((pagingVO.keyword eq '3') or (pagingVO.keyword eq '4') or (pagingVO.keyword eq '5'))}">
					
					<span class="FnBtn btn p-1 disabled" onclick="mailForward()"> 
						<span>
							<i class="bi bi-arrow-right"></i>
						</span> <span>전달</span>
					</span>
					
					<span class="FnBtn btn-group disabled">
					  	<button class="btn p-1" type="button" onclick="readMail()">
					  	<span>
							<i class="bi bi-envelope"></i>
					  	</span><span>읽음</span></button>
					  	<button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only"></span></button>
					  	<div class="dropdown-menu">
					   	 	<a class="dropdown-item" href="#" onclick="readMail()">읽음</a>
					   	 	<a class="dropdown-item" href="#" onclick="unreadMail()">안읽음</a>
					  	</div>
					</span>			
				</c:if>	
				<c:if test="${pagingVO.keyword eq 1 or pagingVO.keyword == 7 or pagingVO.keyword > 12}">
					<div class="FnBtn btn-group disabled">
					  	<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">이동</button>
					  	<div class="dropdown-menu">
						  	<a class="dropdown-item" href="#" onclick="moveInbox()">받은메일함</a>
						  	<a class="dropdown-item" href="#" onclick="deleteMail()">휴지통</a>
		   					<div class="dropdown-divider"></div>
		   					<div id="mailBoxDropdown" class="d-flex flex-column justify-content-center">
		   						
		   					</div>
					  	</div>
					</div>			
				</c:if>
				<c:if test="${pagingVO.keyword eq '3' }">
					<span class="FnBtn btn p-1 disabled" onclick="cancleSend()"> 
						<span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
								<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
							</svg>
						</span> <span>전송취소</span>
					</span>	
					<span class="FnBtn sendAgainBtn btn p-1" onclick="sendAgain()"> 
					    <span>
					        <i class="bi bi-arrow-right"></i>
					    </span> 
					    <span>다시보내기</span>
					</span>
				</c:if>
			</div>	
			<div>
				<form class="p-3 search-box align-middle" action="/mail/mailbox/${pagingVO.keyword}" method="get">
				    <div class="position-relative">
				        <input class="form-control search-input" type="text" value="${searchWord }" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/>
				        <span class="fas fa-search search-box-icon"></span>
				    </div>
				</form>
			</div>
		</div>
	</div>

	<div id="tableExample2" class="d-flex flex-column py-2 px-3 position-relative" data-list='{"valueNames":["name","title","security","date"],"page":10,"pagination":true}'>
	  	<div class="table-responsive scrollbar h-75" style="flex: 1;max-height: 450px">
	    	<table class="table table-bordered border-500 fs-9 mb-0" style="border-collapse: collapse;">
				<c:choose>
					<c:when  test="${pagingVO.keyword == 3}">
			      		<thead class="bg-200">
			       			<tr>
					            <th class="text-900" style="width: 2%;"></th>
					            <th class="text-900 text-center" style="width: 8%;">수신자</th>
					            <th class="text-900 text-center" style="width: 45%">제목</th>
					            <th class="text-900 text-center" style="width: 9%">보낸날짜</th>
					            <th class="text-900 text-center" style="width: 13%">읽은날짜</th>
					            <th class="text-900 text-center" style="width: 7%">전송취소</th>
			        		</tr>
			      		</thead>					
				    </c:when>
				    <c:otherwise>
			      		<thead class="bg-200">
			       			<tr>
					            <th class="text-900" style="width: 10%"></th>
					            <th class="text-900 sort text-center" data-sort="name" style="width: 10%">발신자</th>
					            <th class="text-900 sort text-center" data-sort="title">제목</th>
					            <th class="text-900 sort text-center" data-sort="security" style="width: 10%">보안</th>
					            <c:if test="${pagingVO.keyword == 5 }">
						            <th class="text-900 sort text-center" data-sort="date" style="width: 13%">예약날짜</th>
					            </c:if>
					            <c:if test="${pagingVO.keyword != 5 }">
						            <th class="text-900 sort text-center" data-sort="date" style="width: 13%">날짜</th>
					            </c:if>
			        		</tr>
			      		</thead>
				    </c:otherwise>
				</c:choose>
	      		<tbody class="list" id="mailList">
	      		<c:choose>
      			    <c:when test="${empty pagingVO.dataList && empty pagingVO.confirmationMailList}">
				    	<tr>
			                <td colspan="5" class="text-center p-4">메일이 없습니다.</td>
			            </tr>
				    </c:when>
	      			<c:when test="${pagingVO.keyword != 3}">
						<c:forEach items="${pagingVO.dataList}" var="mailList">
				            <tr data-no="${mailList.mailNo}" data-rec-no="${mailList.recNo }" data-rowNo="${mailList.mailRowNo }" data-read="${mailList.mailReadYn}"
				            	data-fav="${mailList.mailFavYn}" data-from="${mailList.memNo}" data-fileNo="${mailList.fileNo }" data-gb="${mailList.mailGb }"
				            	<c:if test="${pagingVO.keyword eq 1 or pagingVO.keyword eq 12 or pagingVO.keyword > 100}">data-rec-no="${mailList.recNo }"</c:if>>
				                <td class="align-middle ${mailList.mailReadYn eq 'N' ? 'text-1000 fs-8' : 'text-500 fs-8'} px-2">
				                    <span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span>
				                    <span class='favIcon me-1 text-center' style="cursor: pointer;">
				                        <c:choose>
				                            <c:when test="${mailList.mailFavYn eq 'N'}">
				                                <i class="bi bi-star"></i>
				                            </c:when>
				                            <c:otherwise>
				                                <i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i>
				                            </c:otherwise>
				                        </c:choose>
				                    </span>
				                    <span class='me-1 text-center'>
				                    	<c:choose>
				                    		<c:when test="${mailList.mailReadYn eq 'N'}">
						                    	<i class="bi bi-envelope"></i>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<i class="bi bi-envelope-open"></i>
				                    		</c:otherwise>
				                    	</c:choose>
				                    </span>
				                    <c:if test="${mailList.fileNo != 0}">
				                        <span class='me-1 text-center'><i class="bi bi-paperclip"></i></span>
				                    </c:if>
				                </td>
				                <td class="name align-middle text-center ${mailList.mailReadYn eq 'N' ? 'text-1000' : 'text-500'}">${mailList.memName}</td>
				                <td class="title align-middle ${mailList.mailReadYn eq 'N' ? 'text-1000' : 'text-500'}">
				                	<a style="color: inherit;" href="/mail/read/${pagingVO.keyword }/${mailList.mailRowNo }"> <c:if test="${mailList.mailImp eq 'Y' }"><span style="color: #D10000;font-size: 17px;margin-right: 3px;">[중요]</span></c:if>${mailList.mailTitle}</a>
				                </td>
				                <td class="security align-middle text-center ${mailList.mailReadYn eq 'N' ? 'text-1000' : 'text-500'}">
									<c:if test="${mailList.mailSecurityYn eq 'Y' }">보안메일</c:if>
									<c:if test="${mailList.mailSecurityYn eq 'N' }">일반메일</c:if>
								</td>
								<c:if test="${pagingVO.keyword != 5 }">
					                <td class="date align-middle text-center ${mailList.mailReadYn eq 'N' ? 'text-1000' : 'text-500'}">${fn:substring(mailList.mailDate, 0, 16)}</td>
								</c:if>
								<c:if test="${pagingVO.keyword == 5 }">
					                <td class="date align-middle text-center ${mailList.mailReadYn eq 'N' ? 'text-1000' : 'text-500'}">${fn:substring(mailList.mailResDate, 0, 16)}</td>
								</c:if>
				            </tr>
				        </c:forEach>
	      			</c:when>
	      			<c:otherwise>
						<c:forEach items="${pagingVO.confirmationMailList}" var="mailList">
							<c:set var="recipientList" value="${mailList.recipientList }"></c:set>
							<c:set var="readCnt" value="0"></c:set>
							<c:if test="${not empty recipientList }">
								<c:forEach items="${recipientList}" var="recipient">
								    <c:if test="${recipient.readYn == 'Y'}">
								        <c:set var="readCnt" value="${readCnt + 1}"></c:set>
								    </c:if>
								</c:forEach>
							</c:if>
				            <tr data-no="${mailList.mailNo}" data-rowNo="${mailList.mailRowNo }" data-read="${mailList.mailReadYn}"
				            	data-fav="${mailList.mailFavYn}" data-from="${mailList.memNo}" data-fileNo="${mailList.fileNo }" data-gb="S">
				            	<td class="align-middle text-1000 px-1 text-end fs-9"><span class='me-1 text-center'><input type='checkbox' class='form-check-input'></span></td>
				                <td class="align-middle text-1000 text-center">
				                	<c:choose>
				                		<c:when test="${fn:length(recipientList) > 1 }">
				                			${recipientList[0].recipientName } 외 ${fn:length(recipientList) }명
				                		</c:when>
				                		<c:otherwise>
				                			${recipientList[0].recipientName }
				                		</c:otherwise>
				                	</c:choose>
				                </td>
				                <td class="name align-middle text-1000"><a style="color: inherit;" href="/mail/read/2/${mailList.mailRowNo }">${mailList.mailTitle}</a></td>
				                <td class="title align-middle text-1000 text-center">${fn:substring(mailList.mailDate, 0, 16) }</td>
				                <td class="date align-middle text-1000 text-center">
				                	<c:choose>
				                		<c:when test="${fn:length(recipientList) > 1 }">
				                			<span>${fn:length(recipientList) }명 중 ${readCnt }명 읽음</span>
				                		</c:when>
				                		<c:when test="${recipientList[0].recTime != null }">
				                			<i class="bi bi-envelope-open me-1"></i>${recipientList[0].recTime }
				                		</c:when>
				                		<c:when test="${recipientList[0].recTime == null }">
				                			<span>읽지않음</span>
				                		</c:when>
				                		<c:when test="${mailList.mailStatus == '전송실패' }">
				                			<span>전송실패</span>
				                		</c:when>
				                	</c:choose>
				                </td>
				                <td class="date align-middle text-1000 text-center">
									<c:choose>
									    <c:when test="${fn:length(recipientList) > 1}">
									        <c:set var="hasCancellation" value="false"/>
									        
									        <c:forEach items="${recipientList}" var="recipient">
									            <c:if test="${recipient.recStatus == '전송취소'}">
									                <c:set var="hasCancellation" value="true"/>
									            </c:if>
									        </c:forEach>
									        
									        <c:if test="${hasCancellation}">
									            전송취소완료
									        </c:if>
									        <c:if test="${!hasCancellation}">
									             <a href="#" class="btn border-800 text-1000 py-0 px-1" onclick="cancleSend(${mailList.mailNo})"><i class="bi bi-x" style="color: red"></i>전송취소</a>
									        </c:if>
									    </c:when>
									    
									    <c:when test="${fn:length(recipientList) == 1}">
									        <c:if test="${recipientList[0].recStatus == '전송취소'}">
									           	전송취소완료
									        </c:if>
									        <c:if test="${recipientList[0].recStatus != '전송취소'}">
									            <c:if test="${recipientList[0].recTime == null}">
									                <a href="#" class="btn border-800 text-1000 py-0 px-1" onclick="cancleSend(${mailList.mailNo})"><i class="bi bi-x" style="color: red"></i>전송취소</a>
									            </c:if>
									        </c:if>
									    </c:when>
									</c:choose>
				                </td>
				            </tr>
				        </c:forEach>
	      			</c:otherwise>
	      		</c:choose>
	      		</tbody>
	      	</table>
		</div>
       	<div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
 		</div>
	</div>	    
</div>
<!-- 잘못된 메일 모달 -->
<c:if test="${errorMessage != null }">
	<div class="modal fade" id="errorMessageModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="errorMessageModalHead" aria-hidden="true">
	  <div class="modal-dialog modal-sm mt-6" role="document">
	    <div class="modal-content border-0">
	      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="errorMessageModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
	      <div class="modal-body p-0">
			<div>
				<p>${errorMessage }</p>
			</div>
			<div id="deleteTagListModaltagNoData" class="d-none"></div>
			<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
				<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="errorMessageCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
</c:if>
<!-- 태그 추가 모달 -->
<div class="modal fade" id="addTagListModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addTagListModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addTagListCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addTagListModalHead">태그 추가</h4>
        </div>
		<div class="d-flex flex-column justify-content-center align-items-center align-middle p-3">
			<span class="p-0 my-1" id="addTagListModalMent">새 태그 이름을 입력하세요.</span>
			<input class="form-control form-control-sm" type="text" id="tagListNameInput" spellcheck="false" autocomplete="off">
			<span class="p-0 my-1">태그 색상을 선택하세요</span>
			<div class="d-flex flex-row flex-wrap d-gap gap-1" style="width: 170px">
				<div class="tag-color" data-color="#905341" style="background: #905341;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#D06B64" style="background: #D06B64;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#D75269" style="background: #D75269;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FA573C" style="background: #FA573C;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FF7537" style="background: #FF7537;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FFAD46" style="background: #FFAD46;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#42D692" style="background: #42D692;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#16A765" style="background: #16A765;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#7BD148" style="background: #7BD148;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#B3DC6C" style="background: #B3DC6C;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FBE983" style="background: #FBE983;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#FAD165" style="background: #FAD165;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#F691B2" style="background: #F691B2;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#CD74E6" style="background: #CD74E6;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#9A9CFF" style="background: #9A9CFF;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#B99AFF" style="background: #B99AFF;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#6691E5" style="background: #6691E5;width: 15px;height: 15px;border: 1px solid #FFF"></div>
				<div class="tag-color" data-color="#9FC6E7" style="background: #9FC6E7;width: 15px;height: 15px;border: 1px solid #FFF"></div>
			</div>
			<div id="addTagListModaltagNoData" class="d-none"></div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addTagListConfirm"><div id="contirmText" style="height: 30px;line-height: 30px"></div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addTagListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 태그 리스트 삭제 모달 -->
<div class="modal fade" id="deleteTagListModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="deleteTagListModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="deleteTagListCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="deleteTagListModalHead">태그 삭제</h4>
        </div>
		<div>
			<p>태그를 삭제하시겠습니까?</p>
		</div>
		<div id="deleteTagListModaltagNoData" class="d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="deleteTagListConfirm"><div id="contirmText" style="height: 30px;line-height: 30px"></div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="deleteTagListCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 스팸등록 -->
<div class="modal fade" id="addSpamModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addSpamModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addSpamModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addSpamModalHead">스팸등록</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<div class="ps-3 text-dark">스팸을 등록합니다.</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="addSpamCheck" checked="checked">보낸 사람을 수신거부 목록에 추가</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="addTrashCheck" checked="checked">신고한 메일을 휴지통으로 이동</div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addSpamConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addSpamCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 스팸해제 -->
<div class="modal fade" id="unSpamModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="unSpamModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="unSpamModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="unSpamModalHead">스팸등록</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<div class="ps-3 text-dark">스팸을 해제합니다.</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="unSpamCheck" checked="checked">보낸 사람을 수신거부 목록에서 삭제</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="unTrashCheck" checked="checked">스팸등록한 메일을 받은메일함으로 이동</div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="unSpamConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="unSpamCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 휴지통 삭제 모달 -->
<div class="modal fade" id="trashDeleteModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="trashDeleteModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="trashDeleteModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="trashDeleteModalHead">메일 삭제</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<p>휴지통에서 삭제한 메일은 복구가 되지 않습니다. 메일을 삭제하시겠습니까?</p>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="trashDeleteConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="trashDeleteCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 완전삭제 모달 -->
<div class="modal fade" id="completelyDeleteModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="completelyDeleteModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="completelyDeleteModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="completelyDeleteModalHead">완전삭제</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<p><span id="completelyDeleteCnt"></span>개의 메일이 완전 삭제됩니다. 완전삭제한 메일은 복구되지 않습니다. 메일을 삭제하시겠습니까?</p>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="completelyDeleteConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="completelyDeleteCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 첨부파일삭제 모달 -->
<div class="modal fade" id="fileDeleteModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="fileDeleteModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="fileDeleteModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="fileDeleteModalHead">첨부파일삭제</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<p>첨부파일을 삭제하시겠습니까?</p>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="fileDeleteConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="fileDeleteCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
getTag();
$(function () {
	
	$("#mailBoxDropdown").on("click", "a", function () {
		let moveNoList = [];
		let mailboxNo = $(this).data("no");
		let checkInput = $("#mailList .form-check-input");
		for (let i = 0; i < checkInput.length; i++) {
			if(checkInput.eq(i).is(":checked")){
				moveNoList.push(checkInput.eq(i).closest("tr").data("rec-no"));
			}
		}
		axios({
			url : "/mail/moveMail.do",
			method : "post",
			data : JSON.stringify({moveNoList : moveNoList, mailboxNo : mailboxNo}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			location.reload(true);
		});		
	});

    $("#trashDeleteConfirm").on("click", function () {
		let completelyDeleteList = [];
		let mailGbList = [];
		let checkInput = $("#mailList .form-check-input");
		for (let i = 0; i < checkInput.length; i++) {
			if(checkInput.eq(i).is(":checked")){
				completelyDeleteList.push(checkInput.eq(i).closest("tr").data("no"));
				mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
			}
		}
		completelyDelete(completelyDeleteList, mailGbList);		
	});
	
    $("#completelyDeleteConfirm").on("click", function () {
		let completelyDeleteList = [];
		let mailGbList = [];
		let checkInput = $("#mailList .form-check-input");
		for (let i = 0; i < checkInput.length; i++) {
			if(checkInput.eq(i).is(":checked")){
				completelyDeleteList.push(checkInput.eq(i).closest("tr").data("no"));
				mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
			}
		}
		completelyDelete(completelyDeleteList, mailGbList);		
	});
    
    $("#fileDeleteConfirm").on("click", function () {
		let fileDeleteList = [];
		let mailGbList = [];
		let checkInput = $("#mailList .form-check-input");
		for (let i = 0; i < checkInput.length; i++) {
			if(checkInput.eq(i).is(":checked")){
				fileDeleteList.push(checkInput.eq(i).closest("tr").data("fileno"));
				mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
			}
		}
		fileDelete(fileDeleteList, mailGbList);			
	});
    
    $("#fileDeleteConfirm").on("click", function () {
		let fileDeleteList = [];
		let mailGbList = [];
		let checkInput = $("#mailList .form-check-input");
		for (let i = 0; i < checkInput.length; i++) {
			if(checkInput.eq(i).is(":checked")){
				fileDeleteList.push(checkInput.eq(i).closest("tr").data("fileno"));
				mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
			}
		}
		fileDelete(fileDeleteList, mailGbList);			
	});
    
    if ($('#errorMessageModal').length) {
        $('#errorMessageModal').modal('show');
    }
	
	$("#mailFnBtn").on("change", "#allCheckbox", function () {
		if ($(this).is(":checked")) {
			$("#mailList .form-check-input").prop("checked", true);
			$("#mailFnBtn .FnBtn").removeClass("disabled");
		}else {
			$("#mailList .form-check-input").prop("checked", false);
			$("#mailFnBtn .FnBtn").addClass("disabled");
		}
	});	
	
	$('#mailList').on('change', ".form-check-input", function() {
		let checkedRecNoList = []; 
		let mailboxId = ${mailboxId};
		let checked = $("#mailList .form-check-input:checked");
		console.log(checked.closest("tr").data("rowno"));
		
		for (var i = 0; i < checked.length; i++) {
			checkedRecNoList.push(checked.eq(i).closest("tr").data("rec-no"));
		}
	    let checkedCount = checked.length;
	    let totalCount = $('#mailList .form-check-input').length;
	    let allChecked = checkedCount === totalCount;

	    $('#allCheckbox').prop('checked', allChecked);

	    if (checkedCount > 0) {
	        $("#mailFnBtn .FnBtn").removeClass("disabled");
	        $("#mailFnBtn .replyBtn").removeClass("disabled");
	        $("#mailFnBtn .replyBtn").next().removeClass("disabled");
	        $("#mailFnBtn .allReplyBtn").removeClass("disabled");
	        $("#mailFnBtn .sendAgainBtn").removeClass("disabled");

	        if (checkedCount > 1) {
	            $("#mailFnBtn .replyBtn").addClass("disabled");
	            $("#mailFnBtn .replyBtn").next().addClass("disabled");
	            $("#mailFnBtn .allReplyBtn").addClass("disabled");
	            $("#mailFnBtn .sendAgainBtn").addClass("disabled");
	        }
	    } else {
	        $("#mailFnBtn .FnBtn").addClass("disabled");
	    }
	    if (mailboxId == 1 || mailboxId == 12) {
		    axios({
		    	url : "/mail/tagCheck.do",
		    	method : "post",
		    	data : JSON.stringify(checkedRecNoList),
			    headers: {
			        "Content-Type": "application/json",
			      } 	
		    })
		    .then(function (response) {
		        let res = response.data;
		        let mailTagList = $("#tagDropdownMenu").find(".mailTag"); 
		        
		        for (var i = 0; i < mailTagList.length; i++) {
		            let tagNo = mailTagList.eq(i).data("tag-no");
		            
		            if (res.includes(tagNo) && mailTagList.eq(i).find(".deleteTagBtn").length === 0) {
		                mailTagList.eq(i).find(".applyTagBtn").before(`<span class='deleteTagBtn border border-1000 rounded-1 py-0 px-1 ms-1 float-end' style='font-size:12px;cursor:pointer'>해제</span>`);
		            }
		        }
			});
		}
	});

    
    $("#mailFnBtn").on("click", ".disabled", function (e) {
		e.preventDefualt();
	});

    $("#addSpamConfirm").on("click", function () {
    	$("#addSpamModalCloseBtn").click();
    	let blockList = [];
    	let trashList = [];
    	let mailGbList = [];
    	let checkInput = $("#mailList .form-check-input");
		if ($("#addSpamCheck:checked").length && $("#addTrashCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					blockList.push(checkInput.eq(i).closest("tr").data("from"));
					trashList.push(checkInput.eq(i).closest("tr").data("no"));
					mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
				}
			}
			addSpamAndTrash(blockList, trashList, mailGbList);
			return;
		}
		if ($("#addSpamCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					blockList.push(checkInput.eq(i).closest("tr").data("from"));
				}
			}
			addSpam(blockList);
			return;
		}
		if ($("#addTrashCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					trashList.push(checkInput.eq(i).closest("tr").data("no"));
					mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
				}
			}
			addTrash(trashList, mailGbList);
			return;
		}
	});

    $("#unSpamConfirm").on("click", function () {
    	$("#unSpamModal").modal("hide");
    	let unblockList = [];
    	let untrashList = [];
    	let mailGbList = [];
    	let checkInput = $("#mailList .form-check-input");
		if ($("#unSpamCheck:checked").length && $("#unTrashCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					unblockList.push(checkInput.eq(i).closest("tr").data("from"));
					untrashList.push(checkInput.eq(i).closest("tr").data("no"));
					mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
				}
			}
			unSpamAndTrash(unblockList, untrashList, mailGbList);
			return;
		}
		if ($("#unSpamCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					unblockList.push(checkInput.eq(i).closest("tr").data("from"));
				}
			}
			unSpam(unblockList);
			return;
		}
		if ($("#unTrashCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					untrashList.push(checkInput.eq(i).closest("tr").data("no"));
					mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
				}
			}
			unTrash(untrashList, mailGbList);
			return;
		}
	});
    
    $(".favIcon").on('click', function () {
		let mailNo = $(this).closest("tr").data("no");
		let favIcon = $(this).find("i");
		let fav = $(this).find("i").hasClass("bi-star") ? 'Y' : 'N';
		let keyword = ${pagingVO.keyword}
		if (fav == 'Y') {
			favIcon.removeClass("bi-star");
			favIcon.addClass("bi-star-fill");
			favIcon.css("color", "orange");
			favIcon.css("cursor", "pointer");
		}else {
			favIcon.removeClass("bi-star-fill");
			favIcon.addClass("bi-star");
			favIcon.css("color", "");
			favIcon.css("cursor", "");
		}
		$.ajax({
			url : "/mail/changeFav.do",
			method : "post",
			data : JSON.stringify({
				mailNo : mailNo,
				recFavYn : fav,
				keyword : keyword
			}),
			contentType : "application/json; charset=utf-8",
			success : function (res) {
				console.log(res);
			}
		});
	});
    
    
    
});

function sendAgain() {
	let checkInput = $("#mailList .form-check-input:checked");
	let sendAgainNo = checkInput.closest("tr").data("rowno");
	location.href="/mail/new?type=again&mailboxId=2&mailNo="+sendAgainNo;
}

function cancleSend(mailNo) {
	let cancleSendNo = [];
	if (mailNo) {
		cancleSendNo.push(mailNo);		
	}else {
		let checkInput = $("#mailList .form-check-input");
		for (let i = 0; i < checkInput.length; i++) {
			if(checkInput.eq(i).is(":checked")){
				cancleSendNo.push(checkInput.eq(i).closest("tr").data("no"));
			}
		}
	}
	axios({
		url : "/mail/cancleSend.do",
		method : "post",
		data : JSON.stringify({cancleSendNo : cancleSendNo}),
		headers : {
			"Content-Type" : "application/json; charset=utf-8"
		}
	})
	.then(function (response) {
		location.reload(true);
	});	
}

function deleteConfirmationMail() {
	let deleteConfirmationNo = [];
	let checkInput = $("#mailList .form-check-input");
	for (let i = 0; i < checkInput.length; i++) {
		if(checkInput.eq(i).is(":checked")){
			deleteConfirmationNo.push(checkInput.eq(i).closest("tr").data("no"));
		}
	}	
	axios({
		url : "/mail/deleteConfirmationMail.do",
		method : "post",
		data : JSON.stringify({deleteConfirmationNo : deleteConfirmationNo}),
		headers : {
			"Content-Type" : "application/json; charset=utf-8"
		}
	})
	.then(function (response) {
		location.reload(true);
	});
}

function moveInbox() {
	let moveInboxList = [];
	let checkInput = $("#mailList .form-check-input");
	for (let i = 0; i < checkInput.length; i++) {
		if(checkInput.eq(i).is(":checked")){
			moveInboxList.push(checkInput.eq(i).closest("tr").data("rec-no"));
		}
	}
	axios({
		url : "/mail/moveInbox.do",
		method : "post", 
		data : JSON.stringify({moveInboxList : moveInboxList}),
		headers : {
			"Content-Type" : "application/json; charset=utf-8"
		}
	})
	.then(function () {
		location.reload(true);	
	});
}

function deleteMail() {
	let trashList = [];
	let mailGbList = [];
	let checkInput = $("#mailList .form-check-input");
	for (let i = 0; i < checkInput.length; i++) {
		if(checkInput.eq(i).is(":checked")){
			trashList.push(checkInput.eq(i).closest("tr").data("no"));
			mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
		}
	}
	addTrash(trashList, mailGbList);
}

function readMail() {
	let mailNoList = [];
	let mailGbList = [];
	let checkInput = $("#mailList .form-check-input");
	for (let i = 0; i < checkInput.length; i++) {
		if(checkInput.eq(i).is(":checked")){
			mailNoList.push(checkInput.eq(i).closest("tr").data("no"));
			mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
		}
	}
	axios({
		url : "/mail/readMail.do",
		method : "post",
		data : JSON.stringify({mailNoList : mailNoList, mailGbList : mailGbList}),
		headers:{
			"Content-Type" : "application/json; charset=utf-8"
		}
	})
	.then(function (response) {
		location.reload(true);
	});
}

function unreadMail() {
	let mailNoList = [];
	let mailGbList = [];
	let checkInput = $("#mailList .form-check-input");
	for (let i = 0; i < checkInput.length; i++) {
		if(checkInput.eq(i).is(":checked")){
			mailNoList.push(checkInput.eq(i).closest("tr").data("no"));
			mailGbList.push(checkInput.eq(i).closest("tr").data("gb"));
		}
	}
	axios({
		url : "/mail/unreadMail.do",
		method : "post",
		data : JSON.stringify({mailNoList : mailNoList, mailGbList : mailGbList}),
		headers:{
			"Content-Type" : "application/json; charset=utf-8"
		}
	})
	.then(function (response) {
		location.reload(true);
	});
}

function trashDeleteModalOpen() {
	$("#trashDeleteModal").modal("show");
}

function completelyDeleteModalOpen() {
	$("#completelyDeleteModal").modal("show");
}

function fileDeleteModalOpen() {
	$("#fileDeleteModal").modal("show");
}

function mailReply() {
	let type = "reply";
	let mailboxId = ${pagingVO.keyword};
	let checkedCheckbox = $("#mailList .form-check-input:checked").eq(0);
	let mailRowNo = checkedCheckbox.closest('tr').data('rowno');
	location.href = `/mail/new?type=\${type}&mailboxId=\${mailboxId}&mailNo=\${mailRowNo}`;
}

function mailForward() {
	let type = "forward";
	let mailboxId = ${pagingVO.keyword};
	let checkedCheckbox = $("#mailList .form-check-input:checked").eq(0);
	let mailRowNo = checkedCheckbox.closest('tr').data('rowno');
	location.href = `/mail/new?type=\${type}&mailboxId=\${mailboxId}&mailNo=\${mailRowNo}`;
}

function mailAllReply() {
	let type = "allReply";
	let mailboxId = ${pagingVO.keyword};
	let checkedCheckbox = $("#mailList .form-check-input:checked").eq(0);
	let mailRowNo = checkedCheckbox.closest('tr').data('rowno');
	location.href = `/mail/new?type=\${type}&mailboxId=\${mailboxId}&mailNo=\${mailRowNo}`;
}

function allCheck() {
	let allCheckbox = $("#mailFnBtn .form-check-input").eq(0);
	let dataListCheckbox = $("#mailList .form-check-input");
	allCheckbox.prop("checked", true);
	dataListCheckbox.prop("checked", true);
}

function allUnCheck() {
	let allCheckbox = $("#mailFnBtn .form-check-input").eq(0);
	let dataListCheckbox = $("#mailList .form-check-input");
	allCheckbox.prop("checked", false);
	dataListCheckbox.prop("checked", false);
}

function readedMailCheck() {
	allUnCheck();
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("read") == 'Y') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function unReadedMailCheck() {
	allUnCheck();
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("read") == 'N') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function favMailCheck() {
	allUnCheck();
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("fav") == 'Y') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function unFavMailCheck() {
	allUnCheck();
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("fav") == 'N') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function openAddSpamModal() {
	$("#addSpamModal").modal("show");
}

function openUnSpamModal() {
	$("#unSpamModal").modal("show");
}

function addSpam(blockList) {
	$.ajax({
		url : "/mail/addSpam.do",
		method : "post",
		data : JSON.stringify(blockList),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function addTrash(trashList, mailGbList) {
	$.ajax({
		url : "/mail/addTrash.do",
		method : "post",
		data : JSON.stringify({trashList : trashList, mailGbList : mailGbList}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			location.reload();
		}
	});
}

function addSpamAndTrash(blockList, trashList, mailGbList) {
	let mailboxId = ${pagingVO.keyword};
	$.ajax({
		url : "/mail/addSpamAndTrash.do",
		method : "post",
		data : JSON.stringify({blockList : blockList, trashList : trashList, mailGbList : mailGbList}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			location.reload();
		}
	});
}

function unSpam(unblockList) {
	$.ajax({
		url : "/mail/unSpam.do",
		method : "post",
		data : JSON.stringify(unblockList),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function unTrash(untrashList, mailGbList) {
	$.ajax({
		url : "/mail/unTrash.do",
		method : "post",
		data : JSON.stringify({untrashList : untrashList, mailGbList : mailGbList}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			location.reload();
		}
	});
}

function unSpamAndTrash(unblockList, untrashList, mailGbList) {
	$.ajax({
		url : "/mail/unSpamAndTrash.do",
		method : "post",
		data : JSON.stringify({unblockList : unblockList, untrashList : untrashList, mailGbList : mailGbList}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			location.reload();
		}
	});
}

function completelyDelete(completelyDeleteList, mailGbList) {
	$.ajax({
		url : "/mail/completelyDelete.do",
		method : "post",
		data : JSON.stringify({completelyDeleteList : completelyDeleteList, mailGbList : mailGbList}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			location.reload();
		}
	});
}

function fileDelete(fileDeleteList, mailGbList) {
	$.ajax({
		url : "/mail/deleteFile.do",
		method : "post",
		data : JSON.stringify({fileDeleteList : fileDeleteList, mailGbList : mailGbList}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			location.reload();
		}
	});	
}

function getTag() {
    axios({
        method: 'get',
        url: '/mail/getTag.do',
    })
    .then(function (response) {
        let tagList = response.data;
        let trList = $("#mailList").find("tr");

        for (var i = 0; i < tagList.length; i++) {  // tagList의 길이까지 루프
            for (var j = 0; j < trList.length; j++) {  // trList의 길이까지 루프
                if (trList.eq(j).data("rec-no") == tagList[i].recNo) {  // recNo 비교
                    trList.eq(j).find(".title").html(`<i class="bi bi-tag-fill fs-9" style="color: \${tagList[i].mailTagColor}"></i>` + trList.eq(j).find(".title").html());
                }
            }
        }
    })
    .catch(function (error) {
        console.error('Error fetching tags:', error);
    });
}


</script>