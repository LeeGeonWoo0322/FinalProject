<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<style type="text/css">
.display-none {
    display: none;
}

.chat-content-body {
    overflow-y: auto;
}

.chat-info-panel {
    position: absolute;
    right: 0;
    top: 0;
    width: 300px;
    height: 100%;
    background: #fff;
    border-left: 1px solid #e9ecef;
    padding: 10px;
    z-index: 900;
}

.chat-info-header {
    display: flex;
    justify-content: space-between;
}

.modal {
    z-index: 1050 !important; /* 모달을 가장 위로 보이게 설정 */
}

.modal-backdrop {
    z-index: 1045 !important; /* 모달 배경이 모달 아래로 설정되도록 */
}

.link-preview.card {
    max-width: 300px; /* 카드의 최대 너비 설정 */
    margin: 10px; /* 카드 간의 간격 */
    transition: transform 0.2s;
}

.link-preview.card:hover {
    transform: scale(1.05); /* 마우스 오버 시 약간 확대 */
}

.link-image img {
    height: auto; /* 이미지 비율 유지 */
    width: 100%; /* 카드의 폭에 맞게 조정 */
    border-radius: 8px; /* 모서리 둥글게 */
}

.card-title {
    font-size: 1.2rem; /* 제목 크기 조정 */
}

.card-text {
    font-size: 0.9rem; /* 설명 텍스트 크기 조정 */
}

.chat-editor-area {
    display: flex; /* flexbox로 레이아웃 설정 */
    align-items: flex-start; /* 아이템을 상단 정렬 */
    padding: 10px; /* 안쪽 여백 */
    background-color: #f8f9fa; /* 배경색 */
    border-top: 1px solid #dee2e6; /* 상단 테두리 */
}

.emojiarea-editor {
    flex-grow: 1; /* 남은 공간을 차지 */
    min-height: 60px; /* 최소 높이 설정 */
    max-height: 120px; /* 최대 높이 설정 */
    padding: 10px; /* 안쪽 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    resize: vertical; /* 세로로만 크기 조절 가능 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 가능 */
}

.selected-files {
    position: absolute; /* 절대 위치 설정 */
    top: 800px;
    left: auto;
    right: auto;
    background-color: rgba(255, 255, 255, 0.8); /* 반투명 배경 */
    padding: 5px;
    border-radius: 4px;
    margin-bottom: 5px; /* 입력란과의 간격 조정 */
    max-height: 100px; /* 파일 목록의 최대 높이 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 가능 */
    z-index: 1; /* 다른 요소 위에 표시되도록 설정 */
}

.selected-files span {
    display: inline-block;
    margin-right: 10px;
}

.selected-files .remove-file {
    cursor: pointer;
    color: red; /* X 버튼 색상 */
    margin-left: 5px;
}

.card-chat {
    height: 100%;
}

.modal-dialog {
    max-width: 700px; /* 최대 너비 */
    width: 100%; /* 기본 너비 */
}

.room-member:hover {
    background-color: #f8f9fa;
    color: #000;
}

.highlight {
  background-color: orange;
}

.search-box {
    position: relative;
    display: inline-flex;
    align-items: center;
}

.search-input {
    padding-right: 90px; /* 버튼들이 들어갈 공간 확보 */
}

.search-box-icon {
    position: absolute;
    top: 50%;
    left: 10px;
    transform: translateY(-50%);
    color: #aaa;
}

#prevButton, #nextButton, #clearButton {
    display: inline-block;
    position: relative;
    margin-left: 5px;
}

#prevButton, #nextButton, #clearButton {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 0.8rem;
    padding: 0 5px;
}

.treeview-list-item.active, .selected  {
    background-color: #f0f8ff;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="card card-chat">
	<div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
		<div class="card-body d-flex p-0" style="height: 100%">
			<div class="chat-sidebar border-end">
				<div class="d-flex flex-row justify-content-between pt-2">
		            <h4 class="align-middle m-0 px-3" style="height: 36px;line-height: 36px">채팅방 목록</h4>
		            <button class="btn" data-bs-toggle="modal" data-bs-target="#deptModal">
					    <i class="bi bi-person-lines-fill"></i>
					</button>
				</div>
				
				<div class="modal fade" id="deptModal" tabindex="-1" role="dialog" aria-hidden="true">
				    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document" style="max-width: 400px;">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title">부서별 직원 리스트</h5>
				                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				            </div>
				            <div class="d-flex flex-row justify-content-center w-100">
				                <div class="modal-body scrollbar" style="max-height: 300px; overflow-y: auto;">
				                    <ul class="mb-1 treeview" id="MemArea"></ul>
				                </div>
				                <div class="col-6 p-3" id="chatSetting">
				                    <h6 class="mb-0 text-start" style="padding-left: 55px">초대목록</h6>
				                    <div class="d-flex mb-2">
				                        <div class="d-flex flex-column align-items-center justify-content-center">
				                            <button class="btn btn-outline-secondary mb-2 add-to-line content-btn"
				                                data-list="inviteMember" data-btn="MemArea">→</button>
				                            <button class="btn btn-outline-secondary remove-from-line content-btn"
				                                data-list="inviteMember" data-btn="MemArea">←</button>
				                        </div>
				                        <ul id="inviteMember" class="ms-2 overflow-x-auto border bg-200 w-100" style="height: 250px;"></ul>
				                    </div>
				                </div>
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-info" id="openChatNameModal">등록</button>
				            </div>
				        </div>
				    </div>
				</div>

				
				<!-- 채팅방 이름 입력 모달 -->
				<div class="modal fade" id="chatNameModal" tabindex="-1" role="dialog" aria-hidden="true">
				    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 400px;">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title">채팅방 이름 설정</h5>
				                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				            </div>
				            <div class="modal-body">
				                <input type="text" class="form-control" id="chatRoomName" placeholder="채팅방 이름을 입력하세요">
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-primary" id="createChatRoom">확인</button>
				            </div>
				        </div>
				    </div>
				</div>
				<div class="contacts-list scrollbar-overlay border-0">
					<div class="nav nav-tabs border-0 flex-column" role="tablist" aria-orientation="vertical">
						
					</div>
					
				</div>
			</div>
			

			<div class="tab-content card-chat-content display-none " id="chatRoom">
				<div class=" card-chat-pane active" id="chat-0" role="tabpanel" aria-labelledby="chat-link-0">
					<div class=" card-chat-pane" id="chat-10" role="tabpanel" aria-labelledby="chat-link-10">
						<div class="chat-content-header">
							<div class="row flex-between-center">
								<div class="col-6 col-sm-8 d-flex align-items-center">
									
									<div class="min-w-0 d-flex justify-content-between align-items-center">
										<h5 class="mb-0 text-truncate fs-9 align-middle p-3" id="roomName"></h5>
										<form class="p-3 search-box align-middle" id="searchForm">
										    <div class="position-relative search-box">
											    <input class="form-control search-input" type="text" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/>
											    <span class="fas fa-search search-box-icon"></span>
											    <!-- 버튼을 검색 입력란 오른쪽에 배치 -->
											    <div style="display: inline-flex;">
											        <button type="button" id="prevButton" style="display: none;">▲</button>
											        <button type="button" id="nextButton" style="display: none;">▼</button>
											        <button type="button" id="clearButton" style="display: none;">X</button>
											    </div>
											</div>
										</form>
									</div>
								</div>
								<div class="col-auto">
								    <button class="btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasChatInfo" aria-controls="offcanvasChatInfo">
									  <span class="fas fa-bars"></span>
									</button>
								</div>
							</div>
							
						</div>
						<div class="chat-content-body scrollbar">
						
						</div>
						<div class="offcanvas offcanvas-end" id="offcanvasChatInfo" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" aria-labelledby="offcanvasChatInfoLabel" style="padding-top: 70px; height: 98vh">
						    <div class="offcanvas-header">
						      <h5 class="offcanvas-title" id="offcanvasChatInfoLabel">채팅방 정보
							      <button class="btn" data-bs-toggle="modal" data-bs-target="#chatDrawerModal">
							        <i class="bi bi-inboxes-fill"></i>
							      </button>
						      </h5>
						      <button class="btn-close text-reset" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
						    </div>
						    <div class="offcanvas-body">
						        <h3>채팅방 인원</h3><hr>
						        <div id="chatRoomMemArea">
						        
						        </div>
						    </div>
						  </div>
					</div>
					<form class="chat-editor-area" enctype="multipart/form-data">
					    <!-- 입력란의 너비를 줄이기 위해 flex-basis 설정 -->
					    <div class="emojiarea-editor outline-none scrollbar" contenteditable="true" style="flex-basis: 80%;"></div>
					    <label class="chat-file-upload cursor-pointer mx-2 align-middle" style="padding-top: 20px" for="chat-file-upload">
					        <span class="fas fa-paperclip fa-lg"></span>
					    </label>
					    <input class="d-none" type="file" id="chat-file-upload" multiple />
					    <button class="btn btn-md btn-send shadow-none mx-1 align-middle" style="padding-top: 20px" type="submit">Send</button>
					    <div class="selected-files mt-2"></div>
					</form>
					
					<!-- 모달: 톡서랍 -->
					<div class="modal fade" id="chatDrawerModal" tabindex="-1" role="dialog" aria-hidden="true">
					    <div class="modal-dialog modal-dialog-centered" role="document" style="width: 1000px; height: 700px;">
					        <div class="modal-content position-relative" style="width: 800px;">
					            <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
					                <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body p-0">
					                <div class="rounded-top-3 py-3 ps-4 pe-6 bg-body-tertiary">
					                    <h4 class="mb-1">톡서랍</h4>
					                </div>
					                <!-- 탭 추가 -->
					                <ul class="nav nav-tabs nav-fill" id="chatDrawerTabs">
					                    <li class="nav-item d-flex justify-content-center flex-fill">
					                        <a class="nav-link active" href="#photosTab" data-bs-toggle="tab">사진<i class="bi bi-card-image"></i></a>
					                    </li>
					                    <li class="nav-item d-flex justify-content-center flex-fill">
					                        <a class="nav-link" href="#filesTab" data-bs-toggle="tab">파일<i class="bi bi-file-earmark-text"></i></a>
					                    </li>
					                    <li class="nav-item d-flex justify-content-center flex-fill">
					                        <a class="nav-link" href="#linksTab" data-bs-toggle="tab">링크<i class="bi bi-link-45deg"></i></a>
					                    </li>
					                </ul>
					                <!-- 탭 콘텐츠 -->
					                <div class="tab-content p-4 scrollbar" style="height: calc(700px - 150px); overflow-y: auto;">
									    <div class="tab-pane fade show active" id="photosTab">
									        <h6>사진 목록</h6>
									        <div class="row" id="photoList">
									            <!-- 사진 목록 -->
									        </div>
									    </div>
									    <div class="tab-pane fade" id="filesTab">
									        <h6>파일 목록</h6>
									        <div class="row" id="fileList">
									            <!-- 파일 목록 -->
									        </div>
									    </div>
									    <div class="tab-pane fade" id="linksTab">
									        <h6>링크 목록</h6>
									        <div class="row" id="linkList">
									            <!-- 링크 목록 -->
									        </div>
									    </div>
									</div>
					            <div class="modal-footer">
					                <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
					            </div>
					        </div>
					    </div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	CKEDITOR.disableAutoInline = true;
	let websocket;
	let isAlertVisible = false;
	let memNo = "${memberVO.memNo}"; // 회원 번호
	console.log(memNo);
	const chatContainer = $('.chat-content-body');
	let chatImgFile = $("#chat-file-upload");
	const selectedFilesDiv = $('.selected-files');
	loadDeptAndMemData('MemArea');
	selectedFilesDiv.hide();
	let rmNo=0;
	$(document).ready(function() {
		
        loadChatRooms();
        
        $('#participantsModal, #chatDrawerModal, #deptModal, #chatNameModal').appendTo('body');

        // 모달이 show될 때마다 loadDeptAndMemData 호출
        $('#deptModal').on('show.bs.modal', function() {
            loadDeptAndMemData(); // 모달이 열릴 때 데이터 로드
        });
        
        $('#openChatNameModal').on('click', function() {
            $('#deptModal').modal('hide'); // 부서 모달을 닫고
            $('#chatNameModal').modal('show'); // 채팅방 이름 모달을 띄움
        });

        // '확인' 버튼 클릭 시 선택된 직원들과 함께 채팅방 생성
        $('#createChatRoom').on('click', function() {
            const chatRoomName = $('#chatRoomName').val().trim();

            if (chatRoomName === "") {
            	requiredAlert("채팅방 이름을 입력하세요.",isAlertVisible);
                return;
            }

            // 선택된 직원들의 memNo 수집
            const selectedMembers = $('#inviteMember div').map(function() {
			    return $(this).data('mem-no'); // data-mem-no 속성에서 memNo 값을 가져옴
			}).get().join(',');
            console.log("체크한 직원 번호:"+selectedMembers);
            console.log("방이름:"+chatRoomName);

            // 선택된 직원 memNo와 방 이름을 서버에 전송
            $.ajax({
                url: "/chat/createGroupChat",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ chatRoomName: chatRoomName, members: selectedMembers }),
                success: function(response) {
                	requiredAlert("채팅방이 생성되었습니다!",isAlertVisible);
                    $('#chatNameModal').modal('hide'); // 채팅방 이름 모달 닫기
                    loadChatRooms();
                    enterChatRoom(response,chatRoomName);
                },
                error: function(xhr, status, error) {
                    console.error("채팅방 생성 중 오류:", error);
                }
            });
        });
        
          // 탭 전환 시 스크롤을 최상단으로 초기화
        $('#chatDrawerTabs a[data-bs-toggle="tab"]').on('shown.bs.tab', function () {
            $('.tab-content').scrollTop(0);
        });
          
        let currentMatchIndex = 0;
        let matches = [];

        // 검색어 입력 시
        $('.search-input').on('input', function () {
            hideNavigationButtons();
            clearHighlights();
        });

        // 엔터 키 입력 시 검색 시작
        $('#searchForm').on('submit', function (e) {
            e.preventDefault();
            const searchWord = $('.search-input').val().trim();
            console.log("검색어:"+searchWord);
            if (searchWord) {
                highlightMatches(searchWord);
            } else {
            	requiredAlert('검색어를 입력해주세요.',isAlertVisible);
            }
        });

        // 하이라이트 검색
        function highlightMatches(searchWord) {
            clearHighlights();

            const chatContainer = $('.chat-content-body');
            const messages = chatContainer.find('.chat-message');
            matches = [];

            messages.each(function () {
                const message = $(this);
                const messageText = message.text();
                // 검색어가 메시지에 포함되는지 확인
                if (messageText.toLowerCase().includes(searchWord.toLowerCase())) {
                    matches.push(message);
                    // 검색어를 하이라이트 처리
                    const highlightedText = messageText.replace(
                        new RegExp(`(\${searchWord})`, 'gi'), // 정규 표현식 수정
                        '<span class="highlight">$1</span>'
                    );
                    message.html(highlightedText); // 하이라이트된 텍스트로 업데이트
                }
            });
            console.log("메시지 포함:"+matches);

            if (matches.length > 0) {
                currentMatchIndex = 0;
                $('#prevButton, #nextButton, #clearButton').show();
                scrollToMatch();
            } else {
            	requiredAlert('검색 결과가 없습니다.',isAlertVisible); // 검색 결과가 없을 때만 알림 표시
            }
        }

        // 하이라이트로 스크롤
        function scrollToMatch() {
        	const match = matches[currentMatchIndex];

            if (match) {
                const chatContainer = $('.chat-content-body');
                // 메시지의 위치
                const matchTop = match.offset().top - chatContainer.offset().top;
                // 채팅방의 위치
                const containerHeight = chatContainer.height();

                // 화면 중앙에 위치하도록 스크롤 위치 계산
                chatContainer.animate({
                    scrollTop: matchTop + chatContainer.scrollTop() - containerHeight / 2
                }, 500); // 부드러운 스크롤 애니메이션
            }
        }

        // 이전 검색어로 이동
        $('#prevButton').on('click', function () {
            if (matches.length > 0) {
                currentMatchIndex = (currentMatchIndex - 1 + matches.length) % matches.length;
                scrollToMatch();
            }
        });

        // 다음 검색어로 이동
        $('#nextButton').on('click', function () {
            if (matches.length > 0) {
                currentMatchIndex = (currentMatchIndex + 1) % matches.length;
                scrollToMatch();
            }
        });

        // 하이라이트 제거
        $('#clearButton').on('click', function () {
            clearHighlights();
            $('.search-input').val('');
            $('.chat-content-body').scrollTop($('.chat-content-body')[0].scrollHeight);
        });

        // 하이라이트 제거 기능
        function clearHighlights() {
            $('.chat-content-body .highlight').each(function () {
                const text = $(this).text();
                $(this).replaceWith(text);
            });
            matches = [];
            $('#prevButton, #nextButton, #clearButton').hide();
        }

        // 검색 버튼 숨기기
        function hideNavigationButtons() {
            $('#prevButton, #nextButton, #clearButton').hide();
        }
          
        
        
        rmNo = sessionStorage.getItem("alarmRoomNo");
        const alarmTitle = sessionStorage.getItem("alarmTitle");
        
        if (rmNo && alarmTitle) {
        	console.log(rmNo);
        	loadChatRooms();
            enterChatRoom(rmNo, alarmTitle);
            // 사용 후 데이터 삭제
            sessionStorage.removeItem("alarmRoomNo");
            sessionStorage.removeItem("alarmTitle");
        }
          
    });
	
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
	
	
	function chatRoomMemberList(rmNo) {
		$.ajax({
            url: "/chat/chatRoomMemberList/"+rmNo,
            type: "GET",
            success: function(memberList) {
            	console.log(memberList);
            	updateChatRoomMemberList(memberList);
            },
            error: function(xhr, status, error) {
                console.error("채팅방 직원 목록을 불러오는 중 오류 발생:", error);
            }
        });
	}
	
	function updateChatRoomMemberList(memberList) {
	    let chatRoomMemberHTML = '';
	    
	    memberList.forEach(member => {
	    	const me = (memNo==member.memNo)?'(나)':'';
	        // 업무 또는 출근 상태에 따라 클래스를 설정
	        const statusClass = (member.memStatus === '업무' || member.memStatus === '출근') ? 'status-online' : 'status-do-not-disturb';
	        chatRoomMemberHTML += `
	            <div class="col-auto d-flex align-items-center p-2 room-member cursor-pointer dropdown">
	                <div class="avatar avatar-2xl \${statusClass} me-3" data-bs-toggle="dropdown" aria-expanded="false">
	                    <img class="rounded-circle" src="/resources/icon/default_profile.png" alt="Profile" />
	                </div>
	                <div data-bs-toggle="dropdown" aria-expanded="false">
	                    <div class="fw-bold">\${member.memName} \${member.posName}\${me}</div>
	                </div>
	                <ul class="dropdown-menu">
	                    <li><a class="dropdown-item" href="#" onclick="startSingleChat('\${member.memNo}','\${member.memName}')">1:1 채팅</a></li>
	                </ul>
	            </div>
	        `;
	    });
	    
	    $('#chatRoomMemArea').html(chatRoomMemberHTML);  // 채팅방 목록 업데이트
	}
	
	
	window.toggleChatInfo = function() {
        $('#chatInfoPanel').toggleClass('d-none');
    };
    
    $(document).on('click', '.modal-backdrop', function () {
        // 배경 클릭 시 모달 닫기
        $('.modal').modal('hide');
    });
    

	// 텍스트를 지정한 길이로 자르는 함수
	function truncateText(text, maxLength) {
	    if (!text) return ""; // text가 undefined이거나 빈 문자열일 경우 빈 문자열 반환
	    return text.length > maxLength ? text.substring(0, maxLength) + "..." : text;
	}

    
	
	function loadChatRooms() {
	    return new Promise((resolve, reject) => {
	        $.ajax({
	            url: "/chat/chatRoomList.do",
	            type: "POST",
	            success: function(roomList) {
	                console.log(roomList);
	                updateChatRoomList(roomList);  // 채팅방 목록 업데이트 후 resolve 호출
	            },
	            error: function(xhr, status, error) {
	                console.error("채팅방 목록을 불러오는 중 오류 발생:", error);
	            }
	        });
	    });
	}
	
	// 채팅방 목록을 업데이트하는 함수
	function updateChatRoomList(roomList) {
		    let chatRoomHTML = '';
		    
		    roomList.forEach(room => {
		    	const rmMsg = room.chatMsg ? JSON.parse(room.chatMsg) : { msgContent: "" };
		    	const rmMessage = rmMsg.msgContent
		    	  .replace(/<div[^>]*>/g, '')
		    	  .replace(/<\/div>/g, '') // </div> 태그 제거
		    	  .split('<br>')[0];
		    	const isActive = (rmNo == room.rmNo) ? 'active' : '';
		    	const unreadBadge = ((rmNo!=room.rmNo) && room.unreadCount > 0) 
                ? `<span class="badge bg-danger">\${room.unreadCount}</span>` : '';
                
		        chatRoomHTML += `
		        	<div class="hover-actions-trigger chat-contact nav-item \${isActive}" role="tab" id="chat-link-\${room.rmNo}" data-bs-toggle="tab" data-bs-target="#chat-\${room.rmNo}" aria-controls="chat-\${room.rmNo}" aria-selected="true">
	                <div class="d-md-none d-lg-block">
	                    <div class="dropdown dropdown-active-trigger dropdown-chat">
	                        <button
	                            class="hover-actions btn btn-link btn-sm text-400 dropdown-caret-none dropdown-toggle end-0 fs-9 mt-4 me-1 z-1 pb-2 mb-n2"
	                            type="button" data-boundary="viewport"
	                            data-bs-toggle="dropdown" aria-haspopup="true"
	                            aria-expanded="false">
	                            <span class="fas fa-cog" data-fa-transform="shrink-3 down-4"></span>
	                        </button>
	                        <div class="dropdown-menu dropdown-menu-end border py-2 rounded-2">
	                            <a class="dropdown-item text-danger" href="#!">채팅방 나가기</a>
	                        </div>
	                    </div>
	                </div>
	                <div class="d-flex p-3">
	                    <div class="avatar avatar-xl">
	                        <img class="rounded-circle" src="/resources/icon/default_profile.png" alt="" />
	                    </div>
	                    <div class="flex-1 chat-contact-body ms-2 d-md-none d-lg-block">
	                        <div class="d-flex justify-content-between">
	                        <h6 class="mb-0 chat-contact-title" id="room\${room.rmNo}">
		                        \${room.rmName}
		                        \${room.rmType == '그룹' ? `<span class="ms-1 room-people">\${room.roomPeople}</span>` : ''}
		                    </h6>
	                            <span class="message-time fs-11">\${room.chatDate || ''}</span>
	                        </div>
	                        <div class="min-w-0 d-flex justify-content-between">
	                            <div class="chat-contact-content pe-3">\${rmMessage}</div>
	                            \${unreadBadge}
	                        </div>
	                    </div>
	                </div>
	            </div>`;
		    });
		    
		    $('.contacts-list').html(chatRoomHTML);  // 채팅방 목록 업데이트
	}
	
	// 채팅방에 들어가는 함수
	function enterChatRoom(roomNo, roomNameText) {
	    rmNo = roomNo;
	    $('#chatRoom').removeClass("display-none");
	    $("#roomName").text(roomNameText); // 채팅방 이름 설정
	    chatContainer.html("");
	
	    if (websocket) {
	        websocket.close(); // 이전 연결 닫기
	    }
	    
	    let host = location.href.split("/")[2];
	    websocket = new WebSocket(`ws://\${host}/ws-chat/\${roomNo}`);
	
	    websocket.onopen = function() {
	        console.log('웹소켓 연결 성공:', roomNo);
	        loadChatRooms(); // 채팅방 목록 갱신 
	    };
	
	    websocket.onmessage = function(event) {
	        const messageData = JSON.parse(event.data);
	
	        if (messageData.type === 'newConnection' && messageData.rmNo === roomNo) {
	            console.log("다른사람 입장으로 채팅 새로고침");
	            loadChatHistory(roomNo);
	        } else if (messageData.fileNo) {
	            console.log("파일 메시지 받음:" + messageData.fileNo + messageData);
	            fetchFileDetails(messageData.fileNo, messageData).then(updatedMessage => {
	                displayChatMessage(updatedMessage);
	            });
	        } else {
	            displayChatMessage(messageData);
	        }
	        loadChatHistory(roomNo);
	        loadChatRooms();
	    };
	
	    console.log("방 번호:" + roomNo);
	    chatRoomMemberList(roomNo);
	    loadChatRooms();
	    
	}
	
	$('#chatDrawerModal').on('show.bs.modal', function () {
    	console.log("모달에서 roomNo:"+rmNo);
    	loadChatHistory(rmNo);
    	
    	$('.nav-link').removeClass('active');
        $('.tab-pane').removeClass('active show');

        // 사진 탭에 active 클래스 추가
        $('a[href="#photosTab"]').addClass('active');
        $('#photosTab').addClass('active show');
	 });
	
	$(document).on('dblclick', '.chat-contact', function() {
		
		$('#offcanvasChatInfo').offcanvas('hide');
	    const rmNo = $(this).attr('id').split('-')[2];
	    const roomNameText = $(this).find('h6').clone().children('.room-people').remove().end().text().trim();
	    console.log("채팅방 번호:", rmNo);
	    console.log("채팅방 이름:", roomNameText);
	    
	    enterChatRoom(rmNo, roomNameText); // 채팅방으로 진입
	});
	
	// 채팅방 생성 시 호출하는 함수
	function startSingleChat(memNo, memName) {
		$('#deptModal').modal('hide');
	    console.log("1대1채팅할 번호:" + memNo);
	    $.ajax({
	        url: "/chat/createSingleChatRoom.do",
	        type: "POST",
	        data: { memNo: memNo },
	        success: function(roomNo) {
	            console.log(roomNo);
	            $('#offcanvasChatInfo').offcanvas('hide');
	            loadChatRooms();
	            const rmName = $("#room" + roomNo).text();
	            console.log("뽑아온 방이름:" + rmName);
	            enterChatRoom(roomNo, rmName);
	        },
	        error: function(xhr, status, error) {
	            console.error("채팅방 생성 중 오류 발생:", error);
	        }
	    });
	}
	
	function loadChatHistory(rmNo) {
		 $('#photoList').empty();
         $('#fileList').empty();
         $('#linkList').empty();
	    axios.get("/chat/chatList/" + rmNo)
	        .then(function(response) {
	            const data = response.data;
	            // 기존 리스트 초기화
	            $('#photoList').empty();
	            $('#fileList').empty();
	            $('#linkList').empty();

	            const promises = data.map(chat => {
	                if (chat.fileNo) {
	                    // 파일 세부정보를 가져옴
	                    return fetchFileDetails(chat.fileNo, chat);
	                } else {
	                    return Promise.resolve({ ...chat, fileDetails: null });
	                }
	            });

	            Promise.all(promises).then(chatListWithDetails => {
	                // 메시지를 날짜별로 그룹화
	                $('.chat-content-body').empty();
	                const groupedByDate = chatListWithDetails.reduce((acc, chat) => {
	                	displayChatMessage(chat);
	                    const date = new Date(chat.regDate).toLocaleDateString(); // 날짜 형식화
	                    if (!acc[date]) {
	                        acc[date] = {
	                            photos: [],
	                            files: [],
	                            links: []
	                        };
	                    }
	                    if (chat.fileDetails) {
	                        chat.fileDetails.forEach(fileDetail => {
	                            const fileName = fileDetail.fileOriginalname || "Unnamed file";
	                            if (isImageFile(fileName)) {
	                                acc[date].photos.push(chat); // 이미지인 경우 photos 배열에 추가
	                            } else {
	                                acc[date].files.push(chat); // 일반 파일인 경우 files 배열에 추가
	                            }
	                        });
	                    } else if (chat.msgContent) {
	                        acc[date].links.push(chat); // 링크가 포함된 메시지
	                    }
	                    return acc;
	                }, {});

	                
	                
	                // 톡서랍
	                // 날짜 그룹을 내림차순으로 정렬
	                const sortedDates = Object.keys(groupedByDate).sort((a, b) => new Date(b) - new Date(a));

	                // 정렬된 날짜 그룹을 순회
	                sortedDates.forEach(date => {
	                    const chats = groupedByDate[date];
	                    let headerAdded = false; // 링크 헤더 추가 여부 확인

	                    // 사진 리스트에 날짜 헤더 및 메시지 추가
	                    if (chats.photos.length > 0) {
	                        $('#photoList').append(`<h5>\${date}</h5>`);
	                        chats.photos.forEach(chat => {
	                            chat.fileDetails.forEach(fileDetail => {
	                                const fileName = fileDetail.fileOriginalname || "Unnamed file";
	                                $('#photoList').append(`
	                                		
	                                    <div class="col-md-4 mb-3">
	                                        <div class="card" style="height: 200px;">
		                                        <div class="hoverbox rounded-3 text-center">
		                                        <img src="/chat/displayFile?fileDetailNo=\${fileDetail.fileDetailNo}" class="card-img-top" alt="\${fileName}" style="max-height: 150px; object-fit: cover;">
		                                        <div class="hoverbox-content bg-dark p-5 flex-center" data-bs-theme="light">
		                                          <div>
		                                          <a href="/chat/downloadFile.do?fileDetailNo=\${fileDetail.fileDetailNo}" class="btn">
	                                                  <i class="bi bi-download"></i>
	                                              </a>
		                                          </div>
		                                        </div>
		                                      </div>
	                                            <div class="card-body text-center" style="overflow: hidden;">
	                                                <p class="card-text" style="overflow: hidden; text-overflow: ellipsis; white-space: normal;">
	                                                	\${fileName}
	                                                	
	                                                </p>
	                                                
	                                            </div>
	                                        </div>
	                                    </div>
	                                `);
	                            });
	                        });
	                    }

	                    // 파일 리스트에 날짜 헤더 및 메시지 추가
	                    if (chats.files.length > 0) {
	                        $('#fileList').append(`<h5>\${date}</h5>`);
	                        chats.files.forEach(chat => {
	                            chat.fileDetails.forEach(fileDetail => {
	                                const fileName = fileDetail.fileOriginalname || "Unnamed file";
	                                const downloadLink = `/chat/downloadFile.do?fileDetailNo=\${fileDetail.fileDetailNo}`;
	                                $('#fileList').append(`
	                                    <div class="col-md-4 mb-3">
	                                        <div class="card" style="height: 200px; display: flex; flex-direction: column; justify-content: space-between;">
	                                            <div class="card-body d-flex flex-column align-items-center">
	                                                <i class="fas fa-file-alt" style="font-size: 2rem;"></i>
	                                                <p class="card-text mt-2" style="flex-grow: 1; overflow: hidden; text-overflow: ellipsis; white-space: normal;">\${fileName}</p>
	                                                <a href="\${downloadLink}" class="btn btn-primary">
	                                                    <i class="bi bi-download"></i> 다운로드
	                                                </a>
	                                            </div>
	                                        </div>
	                                    </div>
	                                `);
	                            });
	                        });
	                    }

	                    // 링크 리스트에 날짜 헤더 및 메시지 추가
	                    if (chats.links.length > 0) {
	                        chats.links.forEach(chat => {
	                            // JSON 형식의 메시지에서 URL 추출
	                            let text;
	                            try {
	                                const parsedMessage = JSON.parse(chat.msgContent); // JSON 파싱
	                                text = parsedMessage.msgContent; // msgContent에서 URL 추출
	                            } catch (error) {
	                                console.error("Failed to parse message:", error);
	                                return; // JSON 파싱 실패 시 함수 종료
	                            }

	                            const urlPattern = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/g;
	                            // 모든 URL을 배열로 추출
	                            const urls = text.match(urlPattern);

	                            urls.forEach(url => {
	                                console.log("OG URL:", url);
	                                $.get(`/fetch-og-data?url=\${encodeURIComponent(url)}`, function(data) {
	                                    const title = data.title || url;
	                                    const image = data.image || "data:image/jpeg;base64,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"; // 이미지가 없으면 기본 이미지 경로 설정
	                                    const linkUrl = data.url || url;
	                                        if (!headerAdded) {
	                                            $('#linkList').append(`<h5>\${date}</h5>`); // 첫 번째 링크가 추가되면 날짜 추가
	                                            headerAdded = true; // 헤더가 추가되었음을 표시
	                                        }
	                                        $('#linkList').append(`
	                                            <div class="col-md-4 mb-3">
	                                                <div class="card" style="height: 200px; display: flex; flex-direction: column; justify-content: space-between;"> <!-- 카드 높이 및 레이아웃 조정 -->
	                                                    <a href="\${linkUrl}" target="_blank" class="stretched-link" style="text-decoration: none; color: inherit;">
	                                                        <div class="card-body d-flex flex-column align-items-center" style="flex-grow: 1;">
	                                                            <div class="link-image">
	                                                                <img src="\${image}" alt="\${title}" class="card-img-top" style="height: 100px; object-fit: cover; width:100px;"> <!-- 이미지 크기 조정 -->
	                                                            </div>
	                                                            <h5 class="card-title">\${truncateText(title, 15)}</h5>
	                                                            <p class="card-text">\${truncateText(linkUrl, 20)}</p>
	                                                        </div>
	                                                    </a>
	                                                </div>
	                                            </div>
	                                        `);
	                                }).fail(function() {
	                                    console.log('OG 데이터 가져오기에 실패했습니다.');
	                                });
	                            });
	                        });
	                    }
	                });
	                //톡서랍 끝
	            });
	        })
	        .catch(function(error) {
	            console.error('채팅 내역을 불러오는 중 오류 발생:', error);
	        });
	}

	// 파일 세부정보를 가져오는 함수
	function fetchFileDetails(fileNo, messageData) {
	    return axios.post('/chat/getFileDetails/' + fileNo)
	        .then(function(response) {
	            const fileDetails = response.data;
	            return {...messageData, fileDetails};
	        })
	        .catch(function(error) {
	            console.error('파일 세부정보를 가져오는 중 오류 발생:', error);
	            return messageData;
	        });
	}

	
	
	// 메시지 화면에 표시 함수
	function displayChatMessage(chat) {
	  const messageElement = $('<div>').addClass('d-flex p-3');
	  const msg = JSON.parse(chat.msgContent);
	  const isMyMessage = chat.memNo == memNo;
	  
	  function isURL(text) {
		  const urlPattern = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
		  return urlPattern.test(text);
		}
	
	  function linkify(text, isMyMessage) {
		  const urlPattern = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/g;
		  const linkColorClass = isMyMessage ? 'text-white' : 'text-dark'; // 내 메시지면 흰색, 상대방 메시지면 검은색
		  return text.replace(urlPattern, (url) => `<a href="\${url}" target="_blank" class="\${linkColorClass}">\${url}</a>`);
		}
	  
	  // 메시지 컨텐츠 부분 생성
	  function createMessageContent(content, isMyMessage) {
		  
		  const linkedContent = isURL(content) ? linkify(content, isMyMessage) : content;

		  
	    return isMyMessage ? 
	      `<div class="flex-1 d-flex justify-content-end">
	        <div class="w-100 w-xxl-75">
	          <div class="hover-actions-trigger d-flex flex-end-center">
	            <div class="bg-primary text-white p-2 rounded-2 chat-message">
	              \${linkedContent}
	            </div>
	          </div>
	          <div class="text-400 fs-11 text-end">
	          	\${new Date(chat.regDate).toISOString().slice(0, 10)}
	            \${chat.unreadCount > 0 ? `<span class="text-danger ms-2">\${chat.unreadCount}</span>` : ''}
	          </div>
	        </div>
	      </div>` :
	      `<div class="avatar avatar-l me-2">
	          <img class="rounded-circle" src="/resources/icon/default_profile.png" alt="" />
	        </div>
	        <div class="flex-1">
	          <div class="w-xxl-75">
	          <span>\${chat.memName} (\${chat.senderPosName})</span>
	            <div class="hover-actions-trigger d-flex align-items-center">
	              <div class="chat-message bg-200 p-2 rounded-2">
	              
	                \${linkedContent}
	              </div>
	            </div>
	            <div class="text-400 fs-11">
	              <span>\${chat.regDate}</span>
	              \${chat.unreadCount > 0 ? `<span class="text-danger ms-2">\${chat.unreadCount}</span>` : ''}
	            </div>
	          </div>
	        </div>`;
	  }
	
	  // 이미지 갤러리 생성 함수
	  function createImageGallery(images, isMyMessage) {
	    const galleryClasses = isMyMessage ? 'chat-gallery mt-2 text-end' : 'chat-gallery mt-2';
	    const singleImageClass = images.length === 1 ? 'single-image' : '';
	    
	    return `<div class="\${galleryClasses}">
	      <div class="row mx-n1 d-flex flex-wrap \${isMyMessage ? 'justify-content-end' : ''} \${singleImageClass}">
	        \${images.map(file => `
	          <div class="\${images.length === 1 ? 'col-12' : 'col-6'} col-md-4 px-1" 
	               >
	            <div class="position-relative" style="margin-bottom: 8px;">
	              <a href="/chat/displayFile?fileDetailNo=\${file.fileDetailNo}" 
	                 class="d-block">
	                <img src="/chat/displayFile?fileDetailNo=\${file.fileDetailNo}" 
	                     alt="" 
	                     class="img-fluid rounded">
	              </a>
	              <a href="/chat/downloadFile.do?fileDetailNo=\${file.fileDetailNo}">
		              <span class="bi-download fs-9"></span>
		          </a>
	            </div>
	          </div>
	        `).join('')}
	      </div>
	    </div>`;
	  }
	
	  // 일반 파일 링크 생성 (이전과 동일)
	  function createFileLinks(files, isMyMessage) {
	    const fileContainerClasses = isMyMessage ? 'file-details mt-2 text-end' : 'file-details mt-2';
	    return `<div class="\${fileContainerClasses}">
	      \${files.map(file => `
	        <div class="file-link mb-1">
	          <a href="/chat/downloadFile.do?fileDetailNo=\${file.fileDetailNo}" 
	             class="text-decoration-none" 
	             download>
	            \${isMyMessage ? '' : '<i class="bi bi-file-earmark me-1"></i>'}
	            \${file.fileOriginalname}
	            \${isMyMessage ? '<i class="bi bi-file-earmark ms-1"></i>' : ''}
	          </a>
	        </div>
	      `).join('')}
	    </div>`;
	  }
	
	  // 메시지 렌더링
	  const messageContent = createMessageContent(msg.msgContent, isMyMessage);
	  messageElement.html(messageContent);
	
	  // 파일 처리
	  if (chat.fileDetails && chat.fileDetails.length > 0) {
	    const fileContainer = $('<div>').addClass(isMyMessage ? 'file-container d-flex justify-content-end' : 'file-container');
	    const innerContainer = $('<div>').addClass(isMyMessage ? 'w-xxl-75' : 'w-xxl-75 ms-5');
	    
	    const images = chat.fileDetails.filter(file => isImageFile(file.fileOriginalname));
	    const otherFiles = chat.fileDetails.filter(file => !isImageFile(file.fileOriginalname));
	
	    if (images.length > 0) {
	      innerContainer.append(createImageGallery(images, isMyMessage));
	    }
	
	    if (otherFiles.length > 0) {
	      innerContainer.append(createFileLinks(otherFiles, isMyMessage));
	    }
	
	    fileContainer.append(innerContainer);
	    messageElement.find('.w-xxl-75').append(fileContainer);
	  }
	
	  // 메시지 추가 및 스크롤
	  chatContainer.append(messageElement);
	  chatContainer.scrollTop(chatContainer[0].scrollHeight);
	}

// 이미지 파일인지 확인하는 함수
function isImageFile(fileName) {
    const ext = fileName.split('.').pop().toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif'].includes(ext);
}

	// 메시지 보내기 (폼 제출 시)
$('.chat-editor-area').on('submit', function(e) {
    e.preventDefault();
    sendMessage(); // 메시지 전송 함수 호출
});

// 입력 영역에서 키 이벤트 처리
$('.emojiarea-editor').on('keydown', function(e) {
    if (e.key === 'Enter') { // Enter 키
        if (e.shiftKey) {
            document.execCommand('insertHTML', false, '<br>');
        } else {
            e.preventDefault(); // 기본 Enter 동작 방지 (줄바꿈 방지)
            sendMessage(); // 메시지 전송
        }
    }
});

chatImgFile.on('change', function() {
    const files = this.files;
    selectedFilesDiv.empty(); // 기존 파일 목록 비우기
	
    for (let i = 0; i < files.length; i++) {
        const fileName = files[i].name;
        
        // 파일 이름과 삭제 버튼을 포함하는 요소 생성
        const fileElement = $('<div class="file-item">').text(fileName);
        const removeButton = $('<span class="remove-file">X</span>').on('click', function() {
            // 클릭한 파일의 인덱스를 찾기 위해 현재의 files 목록을 다시 가져옴
            const updatedFiles = Array.from(chatImgFile[0].files).filter((_, index) => index !== i);
            const dataTransfer = new DataTransfer();
            updatedFiles.forEach(file => dataTransfer.items.add(file));
            chatImgFile[0].files = dataTransfer.files; // 실제 input 파일 목록 업데이트

            $(this).parent().remove(); // 해당 파일 항목 제거

            // 파일 목록이 비어 있으면 숨김
            if (dataTransfer.files.length === 0) {
                selectedFilesDiv.hide();
            }
        });
        
        // 파일 이름과 삭제 버튼을 파일 요소에 추가
        fileElement.append(removeButton);
        selectedFilesDiv.append(fileElement);
    }

    // 파일이 하나라도 있으면 보여주기
    if (files.length > 0) {
        selectedFilesDiv.show();
    } else {
        selectedFilesDiv.hide(); // 파일이 없으면 숨김
    }
});


// 메시지 전송 함수
function sendMessage() {
    const messageInput = $('.emojiarea-editor');
    const messageContent = $.trim(messageInput.html()); // HTML로 줄바꿈 포함
    const files = $('#chat-file-upload')[0].files; // 파일 가져오기

    // 파일이 없고 메시지만 있을 경우
    if (messageContent !== '' && files.length === 0) {
        // 웹소켓으로 메시지 보내기
        const messageData = { msgContent: messageContent };
        websocket.send(JSON.stringify(messageData));
        messageInput.html(''); // 입력창 초기화
    }
    // 파일이 있는 경우
    else if (files.length > 0) {
        let fileNames = []; // 파일 이름을 저장할 배열

        // 파일 추가 (여러 개의 파일을 전송)
        for (let i = 0; i < files.length; i++) {
            fileNames.push(files[i].name); // 파일 이름 저장
        }

        // 메시지 내용 설정: 파일이 하나일 경우 파일명, 두 개 이상일 경우 첫 번째 파일명
        const messageData = {
            msgContent: messageContent !== '' ? messageContent : (fileNames.length === 1 ? fileNames[0] : fileNames[0] + '...'), // 메시지가 있을 때는 messageContent 우선 사용
            fileNo: null // 파일 전송 후 fileNo를 받을 것이므로 초기값으로 null 설정
        };

        // FormData 객체 생성
        const formData = new FormData();

        // 파일 추가
        for (let i = 0; i < files.length; i++) {
            formData.append('fileList', files[i]);
        }

        formData.append('fileCategory', '채팅');
        formData.append('memNo', memNo);

        // AJAX 요청으로 파일 전송
        $.ajax({
            url: '/chat/uploadAjax', // 파일 전송을 위한 엔드포인트 URL
            type: 'POST',
            data: formData,
            processData: false, // FormData를 자동으로 변환하지 않도록 설정
            contentType: false, // Content-Type을 자동으로 설정하지 않도록 설정
            dataType: 'text',
            success: function(fileNo) {
                console.log('파일 전송 성공:', fileNo);

                // 파일 전송 후 메시지 내용에 fileNo 추가
                messageData.fileNo = fileNo; // 전송할 메시지에 fileNo 추가

                // 웹소켓으로 메시지 보내기
                websocket.send(JSON.stringify(messageData)); // 메시지 전송

                messageInput.html(''); // 입력창 초기화
                selectedFilesDiv.empty();
                chatImgFile.val(''); // 파일 입력 초기화
            },
            error: function(error) {
                console.error('파일 전송 중 오류 발생:', error);
            }
        });
    }
}

function loadDeptAndMemData() {
    // 부서 및 직원 리스트 불러오기
    $.ajax({
        url: "/approval/approvalDeptList",
        type: "GET",
        success: function(deptResponse) {
            console.log(deptResponse);
            updateDeptList(deptResponse); // 부서 리스트 업데이트

            // 부서 리스트를 업데이트한 후에 직원 리스트를 가져옴
            $.ajax({
                url: "/approval/approvalMemList",
                type: "GET",
                success: function(memResponse) {
                    console.log(memResponse);
                    updateMemList(memResponse); // 직원 리스트 업데이트
                    
                    // 모달을 표시
                    $('#employeeModal').modal('show');
                },
                error: function(xhr, status, error) {
                    console.error("직원 리스트를 불러오는 중 오류 발생:", error);
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("부서 리스트를 불러오는 중 오류 발생:", error);
        }
    });
}


function updateDeptList(deptList) {
    const deptArea = $('#MemArea');
    console.log("부서 출력 함수");
    deptArea.empty();
    deptList.forEach(dept => {
        const deptRow = `
            <li class="treeview-list-item">
                <p class="treeview-text fw-bold">
                    <a data-bs-toggle="collapse" href="#dept\${dept.deptNo}" role="button" aria-expanded="false"> 
                        \${dept.deptName}
                    </a>
                </p>
                <ul class="collapse treeview-list" id="dept\${dept.deptNo}" data-show="false">
                    <!-- 부서별 직원 목록이 여기에 추가됨 -->
                </ul>
            </li>
        `;
        deptArea.append(deptRow);
    });
}

function updateMemList(memList) {
    memList.forEach(mem => {
    	const memRow = `
    	    <li class="treeview-list-item mem" data-mem-no="\${mem.memNo}" data-mem-name="\${mem.memName}">
    	        <div class="treeview-item">
    	            <p class="treeview-text">
    	                <a class="flex-1 employee-item" href="#!" 
    	                   data-mem-no="\${mem.memNo}" 
    	                   data-member-name="\${mem.memName}"
    	                   data-position="\${mem.posName}">
    	                    <span class="me-2 text-success"></span> \${mem.memName} \${mem.posName}
    	                </a>
    	            </p>
    	        </div>
    	    </li>
    	`;
        
        $(`#dept\${mem.deptNo}`).append(memRow);
    });
}

function addToLine(listId, btnId) {
    const selectedMember = $(`#\${btnId} li.selected a`);
    if (selectedMember.length) {
        const targetList = $(`#\${listId}`);
        const memNo = selectedMember.data('mem-no');

        const isAlreadyAdded = targetList.find(`[data-mem-no='\${memNo}']`).length > 0;
        if (isAlreadyAdded) {
            alert('해당 직원은 이미 추가되었습니다.');
            return;
        }

        const newItem = $(`
            <div class="treeview-list-item mem" data-mem-no="\${memNo}">
                <divclass="employee-item">\${selectedMember.text()}</div>
            </div>
        `);

        targetList.append(newItem);
    } else {
        alert('직원을 선택하세요.');
    }
}


//직원 목록에서 선택 시 하이라이트(선택) 표시


$('#MemArea').on('click', '.mem', function (e) {
    e.stopPropagation(); // 이벤트 전파 방지
    $('#MemArea li').removeClass('selected'); // 다른 선택 제거
    $(this).closest('li').addClass('selected'); // 클릭한 직원의 li에만 selected 추가
});

$('#inviteMember').on('click', 'div', function () {
    $(this).toggleClass('selected'); // 선택/해제
});

// 버튼 클릭 이벤트 연결
$('.add-to-line').click(function () {
    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
    const btnId = $(this).data('btn');
    
    console.log("btn:"+btnId);
    
    if ($(this).hasClass('content-btn')) {
        addToLine(listId, btnId);
    }
    
});

function removeFromLine(listId) {
    const selectedItems = $(`#\${listId} div.selected`); // div.selected로 변경
    if (selectedItems.length) {
        selectedItems.remove(); // 선택된 항목 삭제
    } else {
        alert('삭제할 직원을 선택하세요.'); // 선택된 항목이 없을 경우 경고
    }
}

$('.remove-from-line').click(function () {
    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
    
    if ($(this).hasClass('content-btn')) {
        removeFromLine(listId); // 직원 삭제
    }
});





// 부서별 직원에서 직원 더블클릭시 일대일 채팅방으로
$(document).on('dblclick', '.employee-item', function() {
    const memNo = $(this).data('mem-no');
    const memName = $(this).data('member-name');
    startSingleChat(memNo, memName);
});



</script>
</html>