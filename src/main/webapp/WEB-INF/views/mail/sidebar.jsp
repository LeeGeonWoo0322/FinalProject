<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.mailTag{
    display: block;
    width: 100%;
    padding: var(--falcon-dropdown-item-padding-y) var(--falcon-dropdown-item-padding-x);
    clear: both;
    font-weight: 400;
    color: var(--falcon-dropdown-link-color);
    text-align: inherit;
    white-space: nowrap;
    background-color: transparent;
    border: 0;
    border-radius: var(--falcon-dropdown-item-border-radius, 0);
}
.mailTag:hover {
	background-color: #EEE;
}
#tagDropdownMenu .deleteTagBtn:hover{
	background-color: #FFF;
}
#tagDropdownMenu .applyTagBtn:hover{
	background-color: #FFF
}
</style>

<div class="navbar-vertical-content h-100 border-end border-end-1 position-relative" style="width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">메일</h4>
			<a href="/mail/option"><i class="bi bi-gear text-dark-emphasis fs-7 me-3"></i></a>
		</div>
		<div style="text-align: center;">
			<a class="btn border-dark me-1 mb-1 px-6 py-2" href="/mail/new" id="registerBtn">메일 쓰기</a>
		</div>
	</div>
	<div class="p-3 position-relative" id="sidebar-content"">
		<ul class="mb-0 treeview position-relative" id="treeviewExample">
			<li class="treeview-list-item">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">메일함</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-1-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/1"> <span style="height: 20px">받은메일함</span></a>
								<c:if test="${inboxUnreadCnt > 0 }">
									<span class="ms-1">${inboxUnreadCnt }</span>
								</c:if>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text d-flex flex-row justify-content-between w-100">
								<span class="d-flex flex-row"><a class="mailList flex-1 d-inline-block" href="/mail/mailbox/2"> <span style="height: 20px">보낸메일함</span></a>
									<span class="d-flex align-items-center align-middle ms-1">
										<c:if test="${sentUnreadCnt > 0 }">
											${sentUnreadCnt }
										</c:if>
									</span>
								</span>
								<a class="d-inline-block" href="/mail/mailbox/3" style="cursor: pointer;"><span class="d-inline-block border py-0 fs-11" style="padding: 0 2px">수신확인</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/4"> <span style="height: 20px">임시메일함</span></a>
								<c:if test="${tempUnreadCnt > 0 }">
									<span class="ms-1">${tempUnreadCnt }</span>
								</c:if>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/5"> <span style="height: 20px">예약메일함</span></a>
								<c:if test="${resUnreadCnt > 0 }">
									<span class="ms-1">${resUnreadCnt }</span>
								</c:if>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text d-flex flex-row justify-content-between w-100">
								<span class="d-flex flex-row"><a class="mailList flex-1" href="/mail/mailbox/6"> <span style="height: 20px">스팸메일함</span></a>
									<span class="d-flex align-items-center align-middle ms-1">
										<c:if test="${spamUnreadCnt > 0 }">
											${spamUnreadCnt }
										</c:if>
									</span>
								</span>
								<a class="d-inline-block" onclick="openEmptySpamModal()" style="cursor: pointer;"><span class="d-inline-block border py-0 fs-11" style="padding: 0 2px">비우기</span></a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text d-flex flex-row justify-content-between w-100">
								<span class="d-flex flex-row"><a class="mailList flex-1" href="/mail/mailbox/7"> <span>휴지통</span></a>
									<span class="d-flex align-items-center align-middle ms-1">
										<c:if test="${trashUnreadCnt > 0 }">
											${trashUnreadCnt }
										</c:if>
									</span>
								</span>
								<a class="d-inline-block" onclick="openEmptyTrashModal()" style="cursor: pointer;"><span class="d-inline-block border py-0 fs-11" style="padding: 0 2px">비우기</span> </a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text mb-2">
								<a class="flex-1" href="#" id="addMailBoxBtn" onclick="addMailBox()"> <span class="me-1" data-feather="plus" style="width: 15px; height: 15px"></span>메일함 추가
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			<li class="treeview-list-item mb-2">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-2-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">빠른검색</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-2-1" data-show="true">
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/8"> <span class="me-2 text-warning"></span> 중요메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/9"> <span class="me-2 text-warning"></span> 안읽은메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/10"> <span class="me-2 text-primary"></span> 읽은메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/11"> <span class="me-2 text-primary"></span> 첨부메일함
								</a>
							</p>
						</div>
					</li>
					<li class="treeview-list-item">
						<div class="treeview-item">
							<p class="treeview-text">
								<a class="mailList flex-1" href="/mail/mailbox/12"> <span class="me-2 text-info"></span> 내가쓴메일함
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
			<li class="treeview-list-item position-relative">
				<p class="treeview-text">
					<a data-bs-toggle="collapse" href="#treeviewExample-3-1" role="button" aria-expanded="false"> <span style="color: black; font-weight: 500; font-size: 15px">태그</span>
					</a>
				</p>
				<ul class="collapse treeview-list ps-1" id="treeviewExample-3-1" data-show="true">
					
					<li class="treeview-list-item" id="addTagList">
						<div class="treeview-item">
							<p class="treeview-text mb-2">
								<a class="flex-1" href="#" onclick="openAddTagListModal()"> <span class="me-1" data-feather="plus" style="width: 15px; height: 15px"></span>태그 추가
								</a>
							</p>
						</div>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="border-top border-300 d-flex flex-column align-items-center justify-content-center" style="height: 120px">
		<div class="d-flex flex-column justify-content-center w-75">
			<div class="progress" style="height: 10px" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
				<div class="progress-bar bg-info" id="mailCapacityProgressBar"></div>
			</div>
			<div>
				<span style="font-size: 12px" id="UsedMailCapacity"></span>
			</div>
			<button class="btn border border-1 border-dark fs-9 mt-1 d-none" id="reqAddCapBtn" type="button" onclick="openReqAddCapModal()">용량 추가 요청</button>
			<button class="btn border border-1 border-dark fs-10 mt-1 d-none" id="reqAddCapWaitingBtn" type="button" onclick="openReqAddCapWaitingModal()">용량 추가 요청 대기중</button>
		</div>
	</div>
</div>
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
			<input class="form-control form-control-sm border-1" type="text" id="tagListNameInput" spellcheck="false" autocomplete="off">
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
<!-- 스팸메일함 비우기 -->
<div class="modal fade" id="emptySpamModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="emptySpamModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="emptySpamModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="emptySpamModalHead">스팸메일함 비우기</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<p>스팸메일함을 비우면 메일이 완전히 삭제됩니다. 스팸메일함을 비우겠습니까?</p>
		</div>
		<div id="deleteTagListModaltagNoData" class="d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="emptySpamConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="emptySpamCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 휴지통 비우기 -->
<div class="modal fade" id="emptyTrashModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="emptyTrashModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="emptyTrashModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="emptyTrashModalHead">휴지통 비우기</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 mt-3">
			<p>휴지통을 비우면 메일이 완전히 삭제됩니다. 휴지통을 비우겠습니까?</p>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="emptyTrashConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="emptyTrashCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 메일함 추가 모달 -->
<div class="modal fade" id="addMailBoxModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addMailBoxModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addMailBoxModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addMailBoxModalHead">메일함 추가</h4>
        </div>
		<div class="d-flex flex-column justify-content-center align-items-center fs-9 mt-3">
			<div style="width: 80%"><p class="m-0">메일함 이름</p></div>
			<div style="width: 80%"><input type="text" class="form-control form-control-sm" id="mailboxNameInput" spellcheck="false" autocomplete="off"></div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addMailBoxConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addMailBoxCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 메일함 비우기 모달 -->
<div class="modal fade" id="emptyMailBoxModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="emptyMailBoxModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="emptyMailBoxModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="emptyMailBoxModalHead">메일함 비우기</h4>
        </div>
        <div>
        	<span>메일함을 비우면 메일함에 있던 모든 메일이 휴지통으로 이동됩니다.</span>
        	<span>메일함을 비우시겠습니까?</span>
        </div>
        <div class="mailboxNo d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="emptyMailBoxConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="emptyMailBoxCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 메일함 수정 모달 -->
<div class="modal fade" id="modifyMailBoxModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="modifyMailBoxModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="modifyMailBoxModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="modifyMailBoxModalHead">메일함 수정</h4>
        </div>
		<div class="d-flex flex-column justify-content-center align-items-center fs-9 mt-3">
			<div style="width: 80%"><p class="m-0">메일함 이름</p></div>
			<div style="width: 80%"><input type="text" class="form-control form-control-sm" id="modifyMailboxNameInput" spellcheck="false" autocomplete="off"></div>
		</div>
		<div class="mailboxNo d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="modifyMailBoxConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="modifyMailBoxCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 메일함 삭제 모달 -->
<div class="modal fade" id="deleteMailBoxModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="deleteMailBoxModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="deleteMailBoxModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="deleteMailBoxModalHead">메일함 삭제</h4>
        </div>
		<div class="d-flex flex-column justify-content-center align-items-center fs-9 mt-3">
			<span>메일함을 삭제하면 메일함에 있던 모든 메일이 완전 삭제됩니다.</span>
			<span>메일함을 삭제하시겠습니까?</span>
		</div>
		<div class="mailboxNo d-none"></div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="deleteMailBoxConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="deleteMailBoxCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 용량 추가 요청 모달 -->
<div class="modal fade" id="reqAddCapModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reqAddCapModalHead" aria-hidden="true">
  <div class="modal-dialog modal-md mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="reqAddCapModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="reqAddCapModalHead">용량 추가 요청</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 p-3">
			<span class="fs-10 text-900">용량 추가 결과는 메일로 알려드립니다.</span>
			<textarea rows="4" cols="50" class="form-control" placeholder="요청사항을 입력해 주세요." id="reqComent" wrap="hard"></textarea>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center pe-3 mb-3">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-2" id="reqAddCapConfirm"><div style="height: 30px;line-height: 30px">요청하기</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="reqAddCapCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 용량 추가 요청 대기중 모달 -->
<div class="modal fade" id="reqAddCapWaitingModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reqAddCapWaitingModalHead" aria-hidden="true">
  <div class="modal-dialog modal-sm mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="reqAddCapWaitingModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="reqAddCapWaitingModalHead">용량 추가 요청</h4>
        </div>
		<div class="d-flex flex-column justify-content-center fs-9 p-3">
			<span class="fs-10 text-900">이미 요청한 상태입니다.</span>
			<div class="d-flex flex-column p-2 bg-200">
				<span class="fs-10 text-900" id="reqComentContent"></span>
				<span class="fs-10 text-500" id="reqDate"></span>
			</div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center pe-3 mb-3">
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="reqAddCapWaitingCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
getTagList();
getMailBoxList();
checkReqAddCapacity();

let addTagListConfirm = $("#addTagListConfirm");
let modifyTagListConfirm = $("#modifyTagListConfirm");
let deleteTagListConfirm = $("#deleteTagListConfirm");
let addTagListCancle = $("#addTagListCancle");
let tagListNameInput = $("#tagListNameInput");
let myMailCapacity = ${member.mailVolume};
let isAlertVisible = false;
	
window.addEventListener('beforeunload', function(event) {
    // 페이지 새로 고침
    location.reload();
});

$(function () {
	getMailCapacity();
	
	$("#treeviewExample-3-1").on("click", ".aTag", function () {
		let tagNo = $(this).closest(".tagListDiv").data("no");
		axios({
			url : "/mail/getTagMail.do",
			method : "post",
			data : {
				tagNo : tagNo,
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			let res = response.data;
			console.log(res);
		});		
	});
	
	$("#reqAddCapConfirm").on("click", function () {
		let reqComent = $("#reqComent").val();
		axios({
			url : "/mail/reqAddCapacity.do",
			method : "post",
			data : {
				reqComent : reqComent,
				reqGb : 1
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			let res = response.data;
			$("#reqAddCapModal").modal("hide");
			requiredAlert("용량 추가 신청이 완료되었습니다. 결과는 메일로 전달드립니다.", isAlertVisible);
			$("#reqAddCapBtn").addClass("d-none");
			$("#reqAddCapWaitingBtn").removeClass("d-none");
		});
	});
	
	$("#emptyMailBoxConfirm").on("click", function () {
		$("#emptyMailBoxModal").modal("hide");
		let emptyMailBoxNo = $("#emptyMailBoxModal").find(".mailboxNo").val();
		axios({
			url : "/mail/emptyMailBox.do",
			method : "post",
			data : JSON.stringify({emptyMailBoxNo : emptyMailBoxNo}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			location.reload(true);	
		});
	});
	
	$("#modifyMailBoxConfirm").on("click", function () {
		$("#modifyMailBoxModal").modal("hide");
		let modifyMailBoxNo = $("#modifyMailBoxModal").find(".mailboxNo").val();
		let modifyMailboxNameVal = $("#modifyMailboxNameInput").val();
		axios({
			url : "/mail/modifyMailBox.do",
			method : "post",
			data : JSON.stringify({modifyMailBoxNo : modifyMailBoxNo, modifyMailboxNameVal : modifyMailboxNameVal}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			location.reload(true);	
		});
	});
	
	$("#deleteMailBoxConfirm").on("click", function () {
		$("#deleteMailBoxModal").modal("hide");
		let deleteMailBoxNo = $("#deleteMailBoxModal").find(".mailboxNo").val();
		axios({
			url : "/mail/deleteMailBox.do",
			method : "post",
			data : JSON.stringify({deleteMailBoxNo : deleteMailBoxNo}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			location.reload(true);	
		});
	});
	
	$("#addMailBoxConfirm").on("click", function () {
		$("#addMailBoxModal").modal("hide");
		let mailboxName = $("#mailboxNameInput").val();
		axios({
			url : "/mail/addMailBox.do",
			method : "post",
			data : JSON.stringify({mailboxName : mailboxName}),
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		})
		.then(function (response) {
			let res = response.data;
			let mailboxHTML = `
							<div class="mailboxDiv d-flex flex-row position-relative" data-no="\${res.mailboxNo}">
							    <li class="treeview-list-item w-100">
							        <div class="treeview-item d-flex flex-row align-items-center justify-content-between">
							            <div class="treeview-text">
							                <a class="flex-1" href="">\${res.mailboxName}</a>
							            </div>
							            <div class="mailboxBtn d-flex align-items-center m-0" style="height: 26.38px; line-height: 26.38px">
							                <a class="d-inline-block" style="cursor: pointer; height: 26.38px; line-height: 26.38px">
							                    <span class="material-symbols-outlined" style="color: #AAA; padding-top: 2px">more_vert</span>
							                </a>
							            </div>
							        </div>
							        <div class="dropdown-menu mailbox-toggle" style="position: absolute; margin-top: 10px; left: 175px; top: -5px; z-index: 1000">
							        <a class="dropdown-item tag-delete" data-no="\${res.mailboxNo}" href="#">메일함 비우기</a>
							       	 	<div class="dropdown-divider"></div>
							            <a class="dropdown-item mailbox-modify" href="#"  data-name="\${res.mailboxName}" data-no="\${res.mailboxNo}">메일함 수정</a>
							            <a class="dropdown-item mailbox-delete" data-no="\${res.mailboxNo}" href="#">메일함 삭제</a>
							        </div>
							    </li>
							</div>	
							  `;
			let dropdownMailBoxListHTML = `
										<a class="dropdown-item" href="#" data-no="\${res.mailboxNo}" data-row-no="\${res.mailboxRowNo}">\${res.mailboxName}</a>
									`;
			$("#addMailBoxBtn").closest("li").before(mailboxHTML);
			if ($("#mailBoxDropdown").find("a").length) {
				$("#mailBoxDropdown").find("a").last().after(dropdownMailBoxListHTML);
			}else{
				$("#mailBoxDropdown").html(dropdownMailBoxListHTML);
			}
		});
	});
	
	$("#tagDropdownMenu").on("click", ".mailTag", function () {
		let tagNo = $(this).data("tag-no");
		applyTag(tagNo);
	});
	
	$("#tagDropdownMenu").on("click", ".applyTagBtn", function (event) {
		event.stopPropagation();
		let tagNo = $(this).closest(".mailTag").data("tag-no");
		applyTag(tagNo);
	});
	
	$("#tagDropdownMenu").on("click", ".deleteTagBtn", function (event) {
		event.stopPropagation();
		let tagNo = $(this).closest(".mailTag").data("tag-no");
		deleteTag(tagNo);
	});

	$(".tag-color").on("click", function () {
		$(".tag-color").css('border-color', '#fff'); 
	    $(this).css('border-color', 'black');
	});

	addTagListConfirm.on("click", function () {
	    $("#addTagListCloseBtn").click();
	    if ($("#contirmText").text() == "추가") {
	        let result = getTagListInfo();
	        addTagList(result[0], result[1]);
	    } else {
	        let result = getTagListInfo();
	        let tagNo = $("#addTagListModaltagNoData").html();
	        let tagListDiv = $(".tagListDiv");

	        for (let i = 0; i < tagListDiv.length; i++) {
	            if (tagListDiv.eq(i).data("no") == tagNo) {
	                // 아이콘을 가져와서 텍스트와 함께 설정
	                let icon = tagListDiv.eq(i).find(".iTag").clone(); // 아이콘 복제
	                tagListDiv.eq(i).find(".aTag").empty(); // 기존 내용을 비움
	                tagListDiv.eq(i).find(".aTag").append(icon); // 아이콘 추가
	                tagListDiv.eq(i).find(".aTag").append(result[0]); // 텍스트 추가
	                tagListDiv.eq(i).find(".iTag").css("color", result[1]);
	                tagListDiv.eq(i).find(".tag-modify").data("name", result[0]);
	                tagListDiv.eq(i).find(".tag-modify").data("color", result[1]);
	            }
	        }
	        modifyTagList(result[0], result[1], tagNo);
	    }
	});

	deleteTagListConfirm.on("click", function () {
		$("#deleteTagListCloseBtn").click();
		let tagNo = $("#deleteTagListModaltagNoData").html();
		let tagListDiv = $(".tagListDiv");
		for (let i = 0; i < tagListDiv.length; i++) {
			if (tagListDiv.eq(i).data("no") == tagNo) {
				tagListDiv.eq(i).remove();
			}
		}		
		deleteTagList(tagNo);
	})

	$("#tagListNameInput").on("keydown", function (event) {
		if(event.keyCode == 13){
			$("#addTagListConfirm").click();
		}
		if(event.keyCode == 27){
			$("#addTagListCloseBtn").click();
		}
	});

	let lastTagTarget = null;  // 태그 드롭다운의 마지막 클릭된 요소
	let lastMailboxTarget = null;  // 메일함 드롭다운의 마지막 클릭된 요소

	$(document).on('click', function (event) {
	    // 태그 드롭다운 처리
	    if ($(event.target).closest('.tagModifyBtn').length == 0) {
	        $(".tag-toggle").removeClass("show");
	        lastTagTarget = null; // lastTagTarget 초기화
	    } else if ($(event.target).closest('.tagModifyBtn').length) {
	        const currentTagTarget = $(event.target).closest('.tagModifyBtn').parent().next();

	        if (lastTagTarget !== currentTagTarget[0]) {
	            $(".tag-toggle").removeClass("show");
	            currentTagTarget.toggleClass("show");
	            lastTagTarget = currentTagTarget[0]; // 현재 클릭한 요소로 lastTagTarget 업데이트
	        } else {
	            currentTagTarget.toggleClass("show");
	            lastTagTarget = null; // 닫았으므로 초기화
	        }
	    }

	    // 메일함 드롭다운 처리
	    if ($(event.target).closest('.mailboxBtn').length == 0) {
	        $(".mailbox-toggle").removeClass("show");
	        lastMailboxTarget = null; // lastMailboxTarget 초기화
	    } else if ($(event.target).closest('.mailboxBtn').length) {
	        const currentMailboxTarget = $(event.target).closest('.mailboxBtn').parent().next();

	        if (lastMailboxTarget !== currentMailboxTarget[0]) {
	            $(".mailbox-toggle").removeClass("show");
	            currentMailboxTarget.toggleClass("show");
	            lastMailboxTarget = currentMailboxTarget[0]; // 현재 클릭한 요소로 lastMailboxTarget 업데이트
	        } else {
	            currentMailboxTarget.toggleClass("show");
	            lastMailboxTarget = null; // 닫았으므로 초기화
	        }
	    }
	});


	$("#treeviewExample-3-1").on("click", ".tag-modify", function(e){
		e.preventDefault();
		let name = $(this).data("name");
		let color = $(this).data("color");
		let no = $(this).data("no");
		openModifyTagListModal(name, color, no);
	});

	$("#treeviewExample-3-1").on("click", ".tag-delete", function(e){
		e.preventDefault();
		let no = $(this).data("no");
		$(this).closest(".tagListDiv").remove();
		deleteTagList(no);
	});

});

function applyTag(tagNo) {
	let recList = [];
	let checkInput = $("#mailList .form-check-input:checked");
	for (let i = 0; i < checkInput.length; i++) {
		recList.push(checkInput.eq(i).closest("tr").data("rec-no"));
	}
	axios({
	    method: 'post',
	    url: '/mail/applyTag.do',
	    data: {
	    	tagNo: tagNo,
	    	recList : recList
	    },
	    headers:{
	    	"Content-Type" : "application/json"
	    }
	})
	.then(function (response) {
		location.reload(true);
	})
	.catch(function (error) {
	    console.log(error);
	});
}

function deleteTag(tagNo) {
	let recList = [];
	let checkInput = $("#mailList .form-check-input:checked");
	for (let i = 0; i < checkInput.length; i++) {
		recList.push(checkInput.eq(i).closest("tr").data("rec-no"));
	}
	axios({
	    method: 'post',
	    url: '/mail/unApplyTag.do',
	    data: {
	    	tagNo: tagNo,
	    	recList : recList
	    },
	    headers:{
	    	"Content-Type" : "application/json"
	    }
	})
	.then(function (response) {
		location.reload(true);
	})
	.catch(function (error) {
	    console.log(error);
	});
}

function getTagList() {
	$.ajax({
		url : "/mail/getTagList.do",
		method : "get",
		success : function (tagList) {
			let tagListHTML = "";
			let dropdownTagListHTML = "";
			if (tagList.length) {
				for (let i = 0; i < tagList.length; i++) {
					tagListHTML += `
									<div class="tagListDiv d-flex flex-row position-relative" data-no="\${tagList[i].mailTagNo}">
									    <li class="treeview-list-item w-100">
									        <div class="treeview-item d-flex flex-row align-items-center justify-content-between">
									            <div class="treeview-text">
									                <a class="aTag flex-1" href="#"> <i class="iTag bi bi-tag-fill" style="color: \${tagList[i].mailTagColor}"></i> \${tagList[i].mailTagName}
									                </a>
									            </div>
									            <div class="tagModifyBtn d-flex align-items-center m-0" style="height: 26.38px; line-height: 26.38px">
									                <a class="d-inline-block" style="cursor: pointer; height: 26.38px; line-height: 26.38px">
									                    <span class="material-symbols-outlined" style="color: #AAA; padding-top: 2px">more_vert</span>
									                </a>
									            </div>
									        </div>
									        <div class="dropdown-menu tag-toggle" style="position: absolute; margin-top: 10px; left: 175px; top: -5px; z-index: 1000">
									            <a class="dropdown-item tag-modify" href="#" onclick="openModifyTagListModal()" data-name="\${tagList[i].mailTagName}"
									            	data-color="\${tagList[i].mailTagColor}" data-no="\${tagList[i].mailTagNo}">태그 수정</a>
									            <a class="dropdown-item tag-delete" href="#" data-no="\${tagList[i].mailTagNo}">태그 삭제</a>
									        </div>
									    </li>
									</div>	
									`;
					dropdownTagListHTML += `
										<div class="mailTag" style='cursor:pointer' data-tag-no="\${tagList[i].mailTagNo}">
											<i class="iTag bi bi-tag-fill" style="color: \${tagList[i].mailTagColor}"></i> \${tagList[i].mailTagName}
											<span class='applyTagBtn border border-1000 rounded-1 py-0 px-1 float-end' style='font-size:12px;cursor:pointer'>적용</span>
										</div>
											`;
				}
			}
		$("#addTagList").before(tagListHTML);
		$("#tagDropdownMenu").html(dropdownTagListHTML);
		}
	});
}

function getMailBoxList() {
	axios({
		url : "/mail/getMailBoxList.do",
		method : "get",
	})
	.then(function (response) {
		let mailBoxList = response.data;
		let mailBoxListHTML = "";
		let dropdownMailBoxListHTML = "";
		if (mailBoxList.length) {
			for (let i = 0; i < mailBoxList.length; i++) {
				mailBoxListHTML += `
									<div class="mailboxDiv d-flex flex-row position-relative" data-no="\${mailBoxList[i].mailboxNo}" data-row-no="\${mailBoxList[i].mailboxRowNo}">
									    <li class="treeview-list-item w-100">
									        <div class="treeview-item d-flex flex-row align-items-center justify-content-between">
									            <div class="treeview-text">
									                <a class="flex-1" href="/mail/mailbox/\${mailBoxList[i].mailboxRowNo+100}">\${mailBoxList[i].mailboxName}</a>
									            </div>
									            <div class="mailboxBtn d-flex align-items-center m-0" style="height: 26.38px; line-height: 26.38px">
									                <a class="d-inline-block" style="cursor: pointer; height: 26.38px; line-height: 26.38px">
									                    <span class="material-symbols-outlined" style="color: #AAA; padding-top: 2px">more_vert</span>
									                </a>
									            </div>
									        </div>
									        <div class="dropdown-menu mailbox-toggle" style="position: absolute; margin-top: 10px; left: 175px; top: -5px; z-index: 1000">
									        <a class="dropdown-item mailbox-delete" data-no="\${mailBoxList[i].mailboxNo}" href="#" onclick="openEmptyMailBoxModal(\${mailBoxList[i].mailboxNo})">메일함 비우기</a>
									       	 	<div class="dropdown-divider"></div>
									            <a class="dropdown-item mailbox-modify" href="#" onclick="openModifyMailBoxModal(\${mailBoxList[i].mailboxNo})" data-name="\${mailBoxList[i].mailboxName}" data-no="\${mailBoxList[i].mailboxNo}">메일함 수정</a>
									            <a class="dropdown-item mailbox-delete" onclick="openDeleteMailBoxModal(\${mailBoxList[i].mailboxNo})" data-no="\${mailBoxList[i].mailboxNo}" href="#">메일함 삭제</a>
									        </div>
									    </li>
									</div>	
								`;
				dropdownMailBoxListHTML += `
											<a class="dropdown-item" href="#" data-no="\${mailBoxList[i].mailboxNo}" data-row-no="\${mailBoxList[i].mailboxRowNo}">\${mailBoxList[i].mailboxName}</a>
										`;
			}
		}else {
			dropdownMailBoxListHTML = `<span class='text-800'>메일함이 없습니다.</span>`;
		}
	$("#addMailBoxBtn").closest("li").before(mailBoxListHTML);	
	$("#mailBoxDropdown").html(dropdownMailBoxListHTML);
	});
}
		
function getTagListInfo(){
	let tagListColor = null;
	let tagListName = tagListNameInput.val();
	for (let i = 0; i < $(".tag-color").length; i++) {
		if ($(".tag-color").eq(i).css('border-color') === 'rgb(0, 0, 0)') {
			tagListColor = $(".tag-color").eq(i).data("color");
		}
	}
	return [tagListName, tagListColor];
}

function openAddTagListModal() {
	$(".tag-color").css('border-color', '#FFF');
	$("#addTagListModalHead").html("태그 추가");
	$("#contirmText").html("추가");
	$("#tagListNameInput").val("");
	$("#addTagListModalMent").text("새 태그 이름을 입력하세요.");
	if ($("#modifyTagListConfirm")) {
		$("#modifyTagListConfirm").attr('id', 'addTagListConfirm');
	}
	$('#addTagListModal').modal('show');
}

function openModifyTagListModal(tagName, tagColor, tagNo) {
	$(".tag-color").css('border-color', '#FFF');
	$("#addTagListModalHead").html("태그 수정");	
	$("#contirmText").html("수정");
	$("#tagListNameInput").val(tagName);
	$("#addTagListModalMent").text("수정할 태그 이름을 입력하세요.");
	$("#addTagListConfirm").attr('id', 'addTagListConfirm');
	for (let i = 0; i < $(".tag-color").length; i++) {
		if ($(".tag-color").eq(i).data("color") == tagColor) {
			$(".tag-color").eq(i).css('border-color', 'black');
		}
	}
	if ($("#addTagListConfirm")) {
		$("#addTagListConfirm").attr('id', 'modifyTagListConfirm');
	}
	$("#addTagListModaltagNoData").html(tagNo);
	$('#addTagListModal').modal('show');
}

function openDeleteTagListModal(tagNo) {
	$("#deleteTagListModaltagNoData").html(tagNo);
	$("#deleteTagListModal").modal('show');
}

function getTagListInfo(){
	let tagListColor = null;
	let tagListName = tagListNameInput.val();
	for (let i = 0; i < $(".tag-color").length; i++) {
		if ($(".tag-color").eq(i).css('border-color') === 'rgb(0, 0, 0)') {
			tagListColor = $(".tag-color").eq(i).data("color");
		}
	}
	return [tagListName, tagListColor];
}

function addTagList(tagListName, tagListColor) {
	$("#addTagListCloseBtn").click();
	$.ajax({
		url : "/mail/addTagList.do",
		method : "post",
		data : JSON.stringify({
			mailTagName : tagListName,
			mailTagColor : tagListColor
		}),
		contentType : "application/json; charset=utf-8",
		success : function (tag) {
			tagHTML = `
						<div class="tagListDiv d-flex flex-row position-relative" data-no="\${tag.mailTagNo}">
						    <li class="treeview-list-item w-100">
						        <div class="treeview-item d-flex flex-row align-items-center justify-content-between">
						            <div class="treeview-text">
						                <a class="aTag flex-1" href=""> <i class="iTag bi bi-tag-fill" style="color: \${tag.mailTagColor}"></i> \${tag.mailTagName}
						                </a>
						            </div>
						            <div class="tagModifyBtn d-flex align-items-center m-0" style="height: 26.38px; line-height: 26.38px">
						                <a class="d-inline-block" style="cursor: pointer; height: 26.38px; line-height: 26.38px">
						                    <span class="material-symbols-outlined" style="color: #AAA; padding-top: 2px">more_vert</span>
						                </a>
						            </div>
						        </div>
						        <div class="dropdown-menu tag-toggle" style="position: absolute; margin-top: 10px; left: 175px; top: -5px; z-index: 1000">
						            <a class="dropdown-item tag-modify" href="#"  data-name="\${tag.mailTagName}" data-color="\${tag.mailTagColor}" data-no="\${tag.mailTagNo}">태그 수정</a>
						            <a class="dropdown-item tag-delete" data-no="\${tag.mailTagNo}" href="#">태그 삭제</a>
						        </div>
						    </li>
						</div>					
						`;
			let dropdownTagListHTML = `
					<div class="mailTag" style='cursor:pointer' data-tag-no="\${tag.mailTagNo}">
						<i class="iTag bi bi-tag-fill" style="color: \${tag.mailTagColor}"></i> \${tag.mailTagName}
						<span class='applyTagBtn border border-1000 rounded-1 py-0 px-1 float-end' style='font-size:12px;cursor:pointer'>적용</span>
					</div>
						`;
			$("#addTagList").before(tagHTML);
			$("#tagDropdownMenu").append(dropdownTagListHTML);
		}
	});
}

function modifyTagList(tagName, tagColor, tagNo) {
	$.ajax({
		url : "/mail/modifyTagList.do",
		method : "post",
		data : JSON.stringify({
			mailTagNo : tagNo,
			mailTagName : tagName,
			mailTagColor : tagColor
		}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function deleteTagList(tagNo) {
	$.ajax({
		url : "/mail/deleteTagList.do",
		method : "post",
		data : JSON.stringify({
			mailTagNo : tagNo
		}),
		contentType : "application/json; charset=utf-8",
		success : function (res) {
			console.log(res);
		}
	});
}

function openEmptySpamModal() {
	$("#emptySpamModal").modal("show");
}

function openEmptyTrashModal() {
	$("#emptyTrashModal").modal("show");
}

function openEmptyMailBoxModal(mailboxNo) {
	$("#emptyMailBoxModal").find(".mailboxNo").val(mailboxNo);
	$("#emptyMailBoxModal").modal("show");
}

function openModifyMailBoxModal(mailboxNo) {
	$("#modifyMailboxNameInput").val("");
	$("#modifyMailBoxModal").find(".mailboxNo").val(mailboxNo);
	$("#modifyMailBoxModal").modal("show");
}

function openDeleteMailBoxModal(mailboxNo) {
	$("#deleteMailBoxModal").find(".mailboxNo").val(mailboxNo);
	$("#deleteMailBoxModal").modal("show");
}

function addMailBox() {
	$("#mailboxNameInput").val("");
	$("#addMailBoxModal").modal("show");
}

function formatFileSize(size) {

    let fileSize; 

    if (size / 1024 / 1024 / 1024 > 1) {
        fileSize = (size / 1024 / 1024 / 1024).toFixed(1) + "GB";
    } else if (size / 1024 / 1024 > 1) {
        fileSize = (size / 1024 / 1024).toFixed(1) + "MB";
    } else if (size / 1024 > 1) {
        fileSize = (size / 1024).toFixed(1) + "KB";
    } else {
        fileSize = size.toFixed(1) + "Byte";
    }
    
    return fileSize;
}

function getMailCapacity() {
	axios({
		url : "/mail/getMailCapacity.do",
		method : "get"
	}).then(function (response) {
		let res = response.data;
		let formatMyMailCapacity = formatFileSize(myMailCapacity);
		let formatMyUsedMailCapacity = res == 0 || res == "" ? "0Byte" : formatFileSize(res);
		let mailCapacityProgressBarWidth = Math.round(( res / myMailCapacity ) * 100 );
		let UsedMailCapacityHTML = formatMyMailCapacity + "중 " + formatMyUsedMailCapacity + " 사용";
		$("#UsedMailCapacity").text(UsedMailCapacityHTML);
		$("#mailCapacityProgressBar").css("width", `\${mailCapacityProgressBarWidth}%`);
	});
}

function checkReqAddCapacity() {
	axios({
		url : "/mail/checkReqAddCapacity.do",
		method : "get"
	}).then(function (response) {
		let res = response.data;
		let formatDate = res.reqDate;
		if (res) {
			$("#reqAddCapWaitingBtn").removeClass("d-none");
			$("#reqComentContent").text(`요청 내용 : \${res.reqComent}`);
			$("#reqDate").text(`요청 일자 : \${formatDate}`);
		}else {
			$("#reqAddCapBtn").removeClass("d-none");
		}
	});
}

function openReqAddCapModal() {
	$("#reqAddCapModal").modal("show");
}

function openReqAddCapWaitingModal() {
	$("#reqAddCapWaitingModal").modal("show");
}

function requiredAlert(comment, isAlertVisible) {
    let alertBox = $('#alertBox');
    $("#alertDiv").html(comment);
    if (!isAlertVisible) { // 알림이 보이지 않을 때만 실행
        isAlertVisible = true; // 알림을 표시 중임을 설정
        alertBox.css('display', "block");
        setTimeout(function() {
            alertBox.css('display', "none");
            isAlertVisible = false; // 알림이 사라진 후 플래그를 초기화
        }, 2000);
    }
    return false;
}
</script>