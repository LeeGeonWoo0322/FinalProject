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
    <div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
	<div class="d-flex flex-column justify-content-between position-relative" style="height: 120px">
		<div>
			<h4 class="p-3 m-0 align-middel" id="categoryName">
				<c:if test="${mailboxId eq '1' }">
					받은메일함
				</c:if>
				<c:if test="${mailboxId eq '2' }">
					보낸메일함
				</c:if>
				<c:if test="${mailboxId eq '3' }">
					임시메일함
				</c:if>
				<c:if test="${mailboxId eq '4' }">
					예약메일함
				</c:if>
				<c:if test="${mailboxId eq '5' }">
					스팸메일함
				</c:if>
				<c:if test="${mailboxIdd eq '6' }">
					휴지통
				</c:if>
				<c:if test="${mailboxId eq '7' }">
					중요메일함
				</c:if>
				<c:if test="${mailboxId eq '8' }">
					안읽은메일함
				</c:if>
				<c:if test="${mailboxId eq '9' }">
					읽은메일함
				</c:if>
				<c:if test="${mailboxId eq '10' }">
					첨부메일함
				</c:if>
				<c:if test="${mailboxId eq '11' }">
					내가쓴메일함
				</c:if>
			</h4>
		</div>
		<div class="d-flex flex-row justify-content-between p-2">
			<div class="d-flex d-gid gap-2 flex-row align-items-center ms-2" id="mailFnBtn">
				<c:if test="${pagingVO.keyword eq '1' }">
					<span class="FnBtn btn p-1" onclick="openAddSpamModal()"> 
						<span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
								<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
							</svg>
						</span> <span>스팸등록</span>
					</span>					
				</c:if>
				<c:if test="${(pagingVO.keyword eq '6') or (pagingVO.keyword eq '7')}">
					<span class="FnBtn btn p-1" onclick="openUnSpamModal()"> 
						<span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
								<path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
							</svg>
						</span> <span>스팸해제</span>
					</span>			
				</c:if>
				<c:if test="${!((pagingVO.keyword eq '3') or (pagingVO.keyword eq '4') or (pagingVO.keyword eq '5'))}">
					<span class="FnBtn btn-group">
					  	<button class="replyBtn btn p-1" type="button" onclick="location.href='/mail/new?type=reply&mailboxId=${mailboxId}&mailNo=${mailRowNo}'"><i class="bi bi-arrow-return-right me-1"></i>답장</button>
					  	<button class="btn dropdown-toggle dropdown-toggle-split" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="sr-only"></span></button>
					 	<div class="dropdown-menu">
					  	 	 <a class="replyBtn dropdown-item" href="/mail/new?type=reply&mailboxId=${mailboxId}&mailNo=${mailRowNo}">답장</a>
					  	 	 <a class="allReplyBtn dropdown-item" href="/mail/new?type=allReply&mailboxId=${mailboxId}&mailNo=${mailRowNo}">전체답장</a>
					 	</div>
					</span>		
				</c:if>
				<c:if test="${pagingVO.keyword ne 3 }">
					<span class="FnBtn btn-group">
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
				    <div class="FnBtn btn-group">
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
					<div class="FnBtn btn-group">
						<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">태그</button>
						<div class="dropdown-menu" id="tagDropdownMenu" style="width: 250px">
	
						</div>
					</div>
				</c:if>
				<c:if test="${!((pagingVO.keyword eq '3') or (pagingVO.keyword eq '4') or (pagingVO.keyword eq '5'))}">
					
					<span class="FnBtn btn p-1" onclick="location.href='/mail/new?type=forward&mailboxId=${mailboxId}&mailNo=${mailRowNo}'"> 
						<span>
							<i class="bi bi-arrow-right"></i>
						</span> <span>전달</span>
					</span>
					
					<span class="FnBtn btn-group">
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
				<c:if test="${pagingVO.keyword eq 1 or pagingVO.keyword > 12}">
					<div class="FnBtn btn-group">
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
					<span class="FnBtn btn p-1" onclick="cancleSend()"> 
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
	<div class="p-3 scrollbar d-flex flex-column" style="height: 100%">
		<div class="mb-3">
			<div class="d-flex flex-row justify-content-between">
				<div class="d-flex flex-row d-gap gap-3">
					<c:if test="${mailRecipientInfo.recFavYn eq 'N' }">
						<span><i class="bi bi-star"></i></span>
					</c:if>
					<c:if test="${mailRecipientInfo.recFavYn eq 'Y' }">
						<span><i class="bi bi-star-fill" style="color:orange;cursor:pointer"></i></span>
					</c:if>
					<h3 id="mailTitle">${mail.mailTitle }</h3>
				</div>
				<div>
					<a href="/mail/mailbox/${mailboxId }" class="btn border-500">목록</a>
				</div>
			</div>
			<div>
				<table>
					<colgroup>
						<col width="100px">
						<col width="auto">
					</colgroup>		
					<tbody>
						<tr>
							<th><i class="bi bi-dash-square me-1"></i><span>보낸사람:</span></th>
							<td class="p-1">
				                <div class="memInfo d-flex flex-row align-items-center">
				                    <div class="border rounded-5 bg-info-subtle ms-1 px-1">
				                        <span style="font-size: 13px;color: black;">${mail.memName} &lt;${mail.memEmail }&gt;</span>
				                    </div>
				                </div>
							</td>
						</tr>
					</tbody>		
				</table>
			</div>
			<c:set var="hasCC" value="false" />
			<c:set var="hasBCC" value="false" />
				<c:forEach items="${mail.recipientList}" var="recipient">
				    <c:if test="${recipient.recType == 'CC'}">
				        <c:set var="hasCC" value="true" />
				    </c:if>
				    <c:if test="${recipient.recType == 'BCC'}">
				        <c:set var="hasBCC" value="true" />
				    </c:if>
				</c:forEach>
			<div>
				<table>
					<colgroup>
						<col width="100px">
						<col width="600px">
					</colgroup>	
					<tbody>
						<tr>
							<th class="align-top"><span style="margin-left: 20px;">받는사람:</span></th>
							<td class="d-flex flex-row flex-wrap p-1 d-gap gap-1" style="width: 1000px">
								<c:forEach items="${mail.recipientList }" var="recipientList">
									<c:if test="${(recipientList.recType eq '받는사람' ) and (recipientList.recipientNo != mail.memNo)}">
						                <div class="memberInfo d-flex flex-row align-items-center">
						                    <div class="border rounded-5 bg-info-subtle ms-1 px-1" style="white-space: nowrap;">
						                        <span style="font-size: 13px;color: black;">${recipientList.recipientName} &lt;${recipientList.recipientEmail }&gt;</span>
						                    </div>
						                </div>								
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<c:if test="${hasCC}">
								<th class="align-top"><span style="margin-left: 20px">참조:</span></th>
								<td class="d-flex flex-row p-1 d-gap gap-1" style="width: 1000px">
									<c:forEach items="${mail.recipientList }" var="recipientList">
										<c:if test="${recipientList.recType eq 'CC' }">
							                <div class="memberInfo d-flex flex-row align-items-center">
							                    <div class="border rounded-5 bg-info-subtle ms-1 px-1">
							                        <span style="font-size: 13px;color: black;">${recipientList.recipientName}&lt;${recipientList.recipientEmail }&gt;</span>
							                    </div>
							                </div>								
										</c:if>
									</c:forEach>
								</td>
							</c:if>
						</tr>
						<tr>
							<c:if test="${hasBCC}">
								<th class="align-top"><span style="margin-left: 20px">참조:</span></th>
								<td class="d-flex flex-row p-1 d-gap gap-1" style="width: 1000px">
									<c:forEach items="${mail.recipientList }" var="recipientList">
										<c:if test="${recipientList.recType eq 'BCC' }">
							                <div class="memberInfo d-flex flex-row align-items-center">
							                    <div class="border rounded-5 bg-info-subtle ms-1 px-1">
							                        <span style="font-size: 13px;color: black;">${recipientList.recipientName}&lt;${recipientList.recipientEmail }&gt;</span>
							                    </div>
							                </div>								
										</c:if>
									</c:forEach>
								</td>
							</c:if>
						</tr>
						<tr>
							<th><span style="margin-left: 20px">보낸날짜:</span></th>
							<td><span id="sendDate" style="font-size: 13px;padding-left: 7px;color: black;">${mail.mailDate }</span></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div id="readPage" class="<c:if test="${mail.mailSecurityYn eq 'Y' }">d-none</c:if>">
			<div class="border border-300 mb-3 p-2 w-100 scrollbar" style="max-height: 300px">
				<div class="d-flex flex-row">
					<div>
					    <span class='me-1 text-center'><i class="bi bi-paperclip"></i></span>
					    <c:if test="${empty fileList }">
					        첨부파일이 없습니다
					    </c:if>
					    <c:if test="${not empty fileList }">
					        <span>첨부파일 ${fn:length(fileList) }개</span>
					        <span class="ms-2">
					            <a href="#" class="btn border py-0 px-1" id="allSaveBtn">모두저장</a> | 
					            <a href="#" class="btn border py-0 px-1" id="fileAllDelete">모두삭제</a>
					        </span>
					    </c:if>
					</div>
				</div>
				<div id="fileList">
					
				</div>
			</div>
			<div class="border scrollbar p-3" style="min-height: 500px">
				${mail.mailContent }
			</div>
		</div>
		<div id="securityPage" class="d-flex flex-column w-100 d-none border border-300" style="flex: 1 0 auto;">
			<div class="bg-300 p-2 text-center"><h4 class="m-0">보안 메일</h4></div>
			<div>
				<div class="d-flex flex-column justify-content-center text-center p-3" style="height: 500px">
					<div class="d-flex flex-column justify-content-center">
						<div class="text-center"><img alt="" src="${pageContent.request.contextPath }/resources/icon/security_mail.png" style="width: 150px;height: 150px"></div>
						<h4>이 메일은 보안을 위해 암호화되어 있습니다</h5>
						<span style="color: #666;font-size: 14px">메일을 확인하려면 송신자가 보낸 힌트를 확인한 후,<br>
						<span style="color: #666;font-size: 14px">첨부파일을 클릭하여 힌트에 해당하는 비밀번호를 입력해야 합니다.</span>
					</div>
					<div class="d-flex flex-row p-3 mt-3 justify-content-center">
						<span class="me-2">비밀번호 : </span>
						<input type="password" class="form-control form-control-sm w-25" id="passwordInput">
						<button type="button" class="btn btn-info px-2 py-0 ms-2" id="submitPassword">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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
			<input class="form-control-sm border-1" type="text" id="tagListNameInput" spellcheck="false" autocomplete="off">
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
			<div class="ps-3 text-dark">관리자에게 스팸메일을 신고합니다.</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="addSpamCheck" checked="checked">보낸 사람을 수신거부 목록에 추가</div>
			<div class="ps-3"><input type="checkbox" class="form-check-input me-1" id="addTrashCheck" checked="checked">신고한 메일을 휴지통으로 이동</div>
		</div>
		<div id="deleteTagListModaltagNoData" class="d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addSpamConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addSpamCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 첨부파일 삭제 모달 -->
<div class="modal fade" id="deleteFileModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="deleteFileModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="deleteFileModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="deleteFileModalHead">첨부파일 삭제</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<p>첨부파일을 삭제하시면 복구가 불가능합니다.</p>
			<p>첨부파일을 삭제하시겠습니까?</p>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="deleteFileConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="deleteFileCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
fileListPreview(${mail.fileNo});
$(function () {
	let fileNo = null;
	let files = [];
	
	
	let readPage = $("#readPage");
	let securityPage = $("#securityPage");
	let passwordInput = $("#passwordInput");
	let submitPassword = $("#submitPassword");
	let isPasswordCorrect = localStorage.getItem("isPasswordCorrect");
	
	if (${mail.mailSecurityYn == 'Y'}) {
		securityPage.removeClass("d-none");
		securityPage.addClass("d-block");
	}else {
		readPage.removeClass("d-none");
	}
	
	$("#allSaveBtn").on("click", function () {
		let fileDetailNoList = [];
		let fileListLi = $("#fileList").find("li");
		for (var i = 0; i < fileListLi.length; i++) {
			fileDetailNoList.push(fileListLi.eq(i).data("no"));
		}
		let mailTitle = $("#mailTitle").text();
		axios({
			url : "/mail/downloadZipFile.do",
			method : "post",
			responseType : 'blob',
			data : {
				fileDetailNoList : fileDetailNoList,
				mailTitle : mailTitle
			},
			headers : {
				"Content-Type" : "application/json; chartset=utf-8"
			}
		})
		.then(function (response) {
			console.log(response.data);
			const objectURL = URL.createObjectURL(response.data);
			const aTag = document.createElement("a");
			aTag.href = objectURL;
			aTag.download = mailTitle;
			aTag.click();
		});
	});
	
	submitPassword.on("click", function () {
		let inputval = passwordInput.val();
		axios({
			url : "/mail/securityMail.do",
			method : "post",
			data : JSON.stringify({inputval : inputval}),
			headers : {
				"Content-Type" : "application/json; chartset=utf-8"
			}
		})
		.then(function (response) {
			let res = response.data;
		    if (res) {
		        readPage.removeClass("d-none");
		        securityPage.removeClass("d-block");
		        securityPage.removeClass("d-none");
		        securityPage.addClass("d-none");
		    } else {
		    	requiredAlert("비밀번호가 틀렸습니다.", isAlertVisible);
		    }
		});
	});
	
	passwordInput.on("keydown", function (event) {
		let keyCode = event.keyCode;
		if (keyCode == 13) {
			let inputval = passwordInput.val();
			axios({
				url : "/mail/securityMail.do",
				method : "post",
				data : JSON.stringify({inputval : inputval}),
				headers : {
					"Content-Type" : "application/json; chartset=utf-8"
				}
			})
			.then(function (response) {
				let res = response.data;
			    if (res) {
			        readPage.removeClass("d-none");
			        securityPage.removeClass("d-block");
			        securityPage.removeClass("d-none");
			        securityPage.addClass("d-none");
			    } else {
			    	requiredAlert("비밀번호가 틀렸습니다.", isAlertVisible);
			    }
			});
		}
	});
	
	
	$("#sendDate").text(formatDate($("#sendDate").text()));
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
        let allChecked = $('#mailList .form-check-input:checked').length == $('#mailList .form-check-input').length ? true : false;
        $('#allCheckbox').prop('checked', allChecked);
        console.log($("#mailList .form-check-input:checked").length);
        
        if ($("#mailList .form-check-input:checked").length) {
			$("#mailFnBtn .FnBtn").removeClass("disabled");
		}else{
			$("#mailFnBtn .FnBtn").addClass("disabled");
		}
    });
    
    $("#mailFnBtn").on("click", ".disabled", function (e) {
		e.preventDefualt();
	});

    $("#addSpamConfirm").on("click", function () {
    	$("#addSpamModalCloseBtn").click();
    	let blockList = [];
    	let trashList = [];
    	let checkInput = $("#mailList .form-check-input");
		if ($("#addSpamCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					blockList.push(checkInput.eq(i).closest("tr").data("from"));
				}
			}
			addSpam(blockList);
		}
		if ($("#addTrashCheck:checked").length) {
			for (let i = 0; i < checkInput.length; i++) {
				if(checkInput.eq(i).is(":checked")){
					trashList.push(checkInput.eq(i).closest("tr").data("no"));
				}
			}
			addTrash(trashList);
		}
	});
    
    $("#fileList").on("click", ".bi-x", function () {
    	fileNo = $(this).closest("li").data("no");
		$("#deleteFileModal").modal("show");
	});
    
    $("#fileAllDelete").on("click", function () {
		let deleteFileNo = ${mail.fileNo};
		let mailGb = "${mailRecipientInfo.mailGb}";
		axios({
			url : "/mail/fileAllDelete.do",
			method : "post",
			data : JSON.stringify({deleteFileNo : deleteFileNo, mailGb : mailGb}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			$("#fileList").html("");
			fileListPreview(${mail.fileNo});
		})
	});
    
    $("#deleteFileConfirm").on("click", function () {
    	$.ajax({
    		url : "/mail/deleteFileDetail.do",
    		method : "post",
    		data : JSON.stringify({fileNo : fileNo, writer : ${member.memNo}}),
    		contentType : "application/json; charset=utf-8",
    		success : function (res) {
				if (res == "SUCCESS") {
					$("#deleteFileModal").modal("hide");
					let fileList = $("#fileList").find("li");
					for (let i = 0; i < fileList.length; i++) {
						if (fileNo == fileList.eq(i).data("no")) {
							fileList.eq(i).addClass("disabled");
							fileList.eq(i).find(".fileName").css("text-decoration", "line-through");
						}
					}
				}
    		}
    	});
	});
});

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

function impMailCheck() {
	allUnCheck();
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("imp") == 'Y') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function unImpMailCheck() {
	allUnCheck();
	let dataListCheckbox = $("#mailList .form-check-input");
	let dataListTr = $("#mailList tr");
	for (let i = 0; i < dataListTr.length; i++) {
		if (dataListTr.eq(i).data("imp") == 'N') {
			dataListTr.eq(i).find(".form-check-input").prop("checked", true);
		}
	}
}

function openAddSpamModal() {
	$("#addSpamModal").modal("show");
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

function addTrash(trashList) {
	$.ajax({
		url : "/mail/addTrash.do",
		method : "post",
		data : JSON.stringify(trashList),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function formatDate(originalDate) {
    const dateParts = originalDate.split(" "); // 날짜와 시간 분리
    const date = dateParts[0]; // '2024년 10월 15일'
    const time = dateParts[1]; // '09:12'
    
    // 날짜에서 년, 월, 일 추출
    const [year, month, day] = date.match(/\d+/g);

    // 시간에서 시, 분 추출
    const [hour, minute, second] = time.split(":").map(Number);
    
    // 오전, 오후 설정
    const amPm = hour < 12 ? '오전' : '오후';
    const formattedHour = hour % 12 || 12; // 12시간제로 변환

    // 요일 계산 (일요일=0, 월요일=1, ..., 토요일=6)
    const weekdayNames = ['일', '월', '화', '수', '목', '금', '토'];
    const dateObj = new Date(year, month - 1, day); // Date 객체 생성
    const weekday = weekdayNames[dateObj.getDay()]; // 요일

    // 최종 형식
    return `\${year}년 \${month}월 \${day}일 (\${weekday}) \${amPm} \${formattedHour}:\${minute < 10 ? '0' + minute : minute}`;
}

function getFileIcon(fileName) {
    let extension = fileName.split('.').pop().toLowerCase();
    return fileIcons[extension] || '${pageContext.request.contextPath}/resources/icon/icon-default.png'; // 기본 아이콘 경로
}

function fileListPreview(fileNo) {
	$.ajax({
		url : "/mail/fileListPreview.do",
		method : "post",
		data : JSON.stringify({fileNo : fileNo}),
		contentType : "application/json; charset=utf-8",
		success : function (files) {
		    if(files != null && files != undefined){
		    	let tag = "";
		        for(i=0; i<files.length; i++){
		            let f = files[i];
		            let fileName = f.fileOriginalname;
		            let extension = fileName.split('.').pop().toLowerCase();
		            let fileIcon = getFileIcon(fileName);
		            let fileSize = null;
		            if (f.fileSize / 1024 / 1024 / 1024 > 1) {
						fileSize = (f.fileSize / 1024 / 1024 / 1024).toFixed(1) + " GB";
					}else if (f.fileSize / 1024 / 1024 > 1) {
						fileSize = (f.fileSize / 1024 / 1024).toFixed(1) + " MB";
					}else if (f.fileSize / 1024 > 1) {
						fileSize = (f.fileSize / 1024).toFixed(1) + " KB";
					}else{
						fileSize = f.fileSize + " B";
					}
		            
		            tag += 
		                "<li class='fileList d-flex flex-row justify-content-between w-100;"
		            if ((${member.memNo} == ${mail.memNo} && f.delYn == 'Y') || (${member.memNo} != ${mail.memNo} && f.recDelYn == 'Y')) {
						tag += " disabled";
					}
		            tag += "' data-no='"+f.fileDetailNo+"'>" +
		                    "<div class='d-flex flex-row'>" +
		                        "<span class='icon-container' style='display:flex;align-items:center;margin-right:8px;'>" +
		                            "<img src='" + fileIcon + "' alt='icon' style='width:20px;height:20px;' />" +
		                        "</span>" +
		                        "<a href='/downloadFile.do?fileDetailNo="+f.fileDetailNo+"' class='fileName' style='margin-right:8px;color:black;"
   		            if ((${member.memNo} == ${mail.memNo} && f.delYn == 'Y') || (${member.memNo} != ${mail.memNo} && f.recDelYn == 'Y')) {
   						tag += "text-decoration:line-through";
   					}	                        
		            tag += "'>" + fileName + "</a>" +
		                   "<span class='fileSize'>(" + fileSize + ")</span>";
		            if (extension == "JPG" || extension == "JPEG" || extension == "PNG" || extension == "GIF") {
		            	tag += "<span><a class='btn py-0 px-1' style='margin-right:8px;border:1px solid #999'>미리보기</a></span>";
					}
		            tag += "<i class='bi bi-x' style='cursor: pointer;font-size:20px'></i>" +
		                   "</div>" +
		                "</li>";

		        }
		        $("#fileList").append(tag);
		    }	
		}
	});
}


</script>