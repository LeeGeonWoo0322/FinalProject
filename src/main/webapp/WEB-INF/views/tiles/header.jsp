<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style type="text/css">
.cke_notification.cke_notification_warning { display: none; }
#messageNotification {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
    width: 350px;
    cursor: pointer;
    border-radius: 8px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    transform: translateY(100px);
    opacity: 0;
    animation: slideInUp 0.5s forwards;
}

/* 채팅방 이름 영역 */
#messageNotification .toast-header {
    background-color: #2874cc;
    color: white;
    padding: 15px; /* 패딩을 늘려 높이를 확대 */
    border-radius: 8px 8px 0 0;
}

/* 채팅 내용 영역 */
#messageNotification .toast-body {
    background-color: #e6f4ff;
    color: #333;
    padding: 20px; /* 패딩을 늘려 높이를 확대 */
    min-height: 80px; /* 최소 높이 설정 */
    border-radius: 0 0 8px 8px;
}

#messageTitle {
    font-size: 16px;
    font-weight: bold;
}

#messageSender {
    font-size: 12px;
    color: #666;
    margin-bottom: 5px; /* 간격 추가 */
}

#messageContent {
    font-size: 14px;
}

/* 슬라이드 애니메이션 */
@keyframes slideInUp {
    from {
        transform: translateY(100px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

#toastNotification {
    cursor: pointer;
}
</style>

<script type="text/javascript">
const fileIcons = {
    'ai': '${pageContext.request.contextPath}/resources/icon/icon-ai.png',
    'avi': '${pageContext.request.contextPath}/resources/icon/icon-avi.png',
    'csv': '${pageContext.request.contextPath}/resources/icon/icon-csv.png',
    'doc': '${pageContext.request.contextPath}/resources/icon/icon-doc.png',
    'exe': '${pageContext.request.contextPath}/resources/icon/icon-exe.png',
    'gif': '${pageContext.request.contextPath}/resources/icon/icon-gif.png',
    'html': '${pageContext.request.contextPath}/resources/icon/icon-html.png',
    'jpg': '${pageContext.request.contextPath}/resources/icon/icon-jpg.png',
    'jpeg': '${pageContext.request.contextPath}/resources/icon/icon-jpg.png',
    'mp3': '${pageContext.request.contextPath}/resources/icon/icon-mp3.png',
    'mp4': '${pageContext.request.contextPath}/resources/icon/icon-mp4.png',
    'pdf': '${pageContext.request.contextPath}/resources/icon/icon-pdf.png',
    'png': '${pageContext.request.contextPath}/resources/icon/icon-png.png',
    'ppt': '${pageContext.request.contextPath}/resources/icon/icon-ppt.png',
    'pptx': '${pageContext.request.contextPath}/resources/icon/icon-ppt.png',
    'txt': '${pageContext.request.contextPath}/resources/icon/icon-txt.png',
    'xls': '${pageContext.request.contextPath}/resources/icon/icon-xls.png',
    'xlsx': '${pageContext.request.contextPath}/resources/icon/icon-xls.png',
    'zip': '${pageContext.request.contextPath}/resources/icon/icon-zip.png',
};
</script>
<nav class="navbar navbar-light navbar-glass navbar-top navbar-expand">
  <button class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarVerticalCollapse" aria-controls="navbarVerticalCollapse" aria-expanded="false" aria-label="Toggle Navigation"><span class="navbar-toggle-icon"><span class="toggle-line"></span></span></button>
  <a class="navbar-brand me-1 me-sm-3" href="/">
  	<input type="hidden" value="${member.memNo}" id="userNo">
    <div class="d-flex align-items-center"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/IRIS3.png" alt="" width="40" /><span class="font-sans-serif text-primary">IRIS</span>
    </div>
  </a>
  <ul class="navbar-nav align-items-center ms-auto d-none d-lg-block">
    <li class="nav-item">

    </li>
  </ul>
  <ul class="navbar-nav navbar-nav-icons flex-row align-items-center">
 		 <span> 
		<select name="workState" id="workSt" class="form-select" aria-label="Default select example">
		    <option id="0" value="workDefault">근무상태변경</option>
		    <option id="3" value="work">업무</option>
		    <option id="4" value="workComp">업무종료</option>
		    <option id="5" value="workOut">외근</option>
		    <option id="6" value="busiTrip">출장</option>
		    <option id="7" value="away">자리비움</option>
		 </select>
		 </span>
    <li class="nav-item dropdown">
      <a class="nav-link notification-indicator notification-indicator-danger px-0 fa-icon-wait" id="navbarDropdownNotification" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-hide-on-body-scroll="data-hide-on-body-scroll">
        <span class="fas fa-bell" data-fa-transform="shrink-6" style="font-size: 33px;"></span>
        <span id="notificationCount" class="notification-indicator-number">0</span>
      </a>
      <div class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg" aria-labelledby="navbarDropdownNotification">
        <div class="card card-notification shadow-none">
          <div class="card-header">
            <div class="row justify-content-between align-items-center">
              <div class="col-auto">
                <h6 class="card-header-title mb-0">알림</h6>
              </div>
            </div>
          </div>
          <div class="scrollbar-overlay" style="max-height:19rem">
            <div id="notificationList" class="list-group list-group-flush fw-normal fs-10">
            </div>
          </div>
          <div class="card-footer text-center border-top">
            <a class="card-link d-block" href="/notification/alarmList">전체보기</a>
          </div>
        </div>
      </div>
    </li>
    <li class="nav-item ps-2 pe-0">
      <a href="#settings-offcanvas" data-bs-toggle="offcanvas"><i class="bi bi-gear-fill fs-7 me-1" style="color: rgba(0,0,0,0.55);"></i></a>
    </li>
    <li class="nav-item dropdown"><a class="nav-link pe-0 ps-2" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <div class="avatar avatar-xl">
          <img class="rounded-circle" src="${pageContext.request.contextPath}/resources/icon/default_profile.png" alt="" />

        </div>
      </a>
      <div class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end py-0" aria-labelledby="navbarDropdownUser">
        <div class="bg-white dark__bg-1000 rounded-2 py-2">
          <a class="dropdown-item" href="/account/myPage.do" id="myPageATag">마이페이지</a>
          <a class="dropdown-item" href="/notification/alarmOption">알림 설정</a>
          <a class="dropdown-item" href="/account/logoutLog.do">Logout</a>
        </div>
      </div>
		
    </li>
  </ul>
</nav>

<div id="messageNotification" class="toast show" role="alert" data-bs-autohide="false" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
        <strong id="messageTitle" class="me-auto">채팅방 이름</strong>
        <button id="closeNotification" type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
        <p id="messageSender" class="text-muted small mb-1">작성자</p>
        <p id="messageContent">채팅 내용</p>
    </div>
</div>

<div id="toastNotification" class="toast align-items-center text-white bg-primary border-0" role="alert" style="position: fixed; top: 70px; right: 10px; z-index: 1050;" aria-live="assertive" aria-atomic="true">
    <div class="d-flex flex-between-center">
        <div class="toast-body text-bg-primary" id="toastBody"></div>
        <button class="btn-close me-2 m-auto" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.7.7/axios.min.js" integrity="sha512-DdX/YwF5e41Ok+AI81HI8f5/5UsoxCVT9GKYZRIzpLxb8Twz4ZwPPX+jQMwMhNQ9b5+zDEefc+dcvQoPWGNZ3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	checkMemberAuth();
	
	var attendanceDate
	var workSt = $("#workSt");
	var userNo = $("#userNo").val();
	$("#messageNotification").hide();
	printWorkSt()

	workSt.change(function() {
		
		var curStateVal = $(this).val();
		var curState = $("select[id=workSt] option:selected").text();
		if (curStateVal == "work" || curStateVal == "workOut" || curStateVal == "busiTrip" || curStateVal == "workComp" || curStateVal == "away"){
			$.ajax({
				url : "/workState/changeWork",
				method : "post",
				data : JSON.stringify({
					memNo : userNo,
					stateType : curState
				}),
				contentType : "application/json; charset=utf-8",
				success : function (atstate){
					requiredAlert("근무상태 변경완료",isAlertVisible);
					printWorkSt2()
					printWorkSt()
				}
			})
		} else {
			console.log(curStateVal);
		}
	})

	function printWorkSt(){
		
		let curToday = new Date();
		
		year = curToday.getFullYear();
		mon = curToday.getMonth()+1
		date = curToday.getDate();
		
		if(date < 10){
			attendanceDate = `\${year}\${mon}0\${date}`;
		} else {
			attendanceDate = `\${year}\${mon}\${date}`;
		}
		
		$.ajax({
			url : "/workState/printWorking",
			method : "post",
			data : JSON.stringify({
				memNo : userNo,
				stateDate : attendanceDate
			}),
			contentType : "application/json; charset=utf-8",
			success : function(res){
				
				console.log(res.atstateType)
				
				$.ajax({
					url : "/workState/printLWork",
					method : "post",
					data : JSON.stringify({
						memNo : userNo
					}),
					contentType : "application/json; charset=utf-8",
					success : function(mem) {
						
						console.log("으아아아")
						
						if(res.atstateType != null){
							if(res.atstateType == "업무"){
								$("select[name=workState]").val("work").prop("selected",true);
							}
							if(res.atstateType == "업무종료"){
								$("select[name=workState]").val("workComp").prop("selected",true);
							}
							if(res.atstateType == "외근"){
								$("select[name=workState]").val("workOut").prop("selected",true);
							}
							if(res.atstateType == "출장"){
								$("select[name=workState]").val("busiTrip").prop("selected",true);
							}
							if(res.atstateType == "자리비움"){
								$("select[name=workState]").val("away").prop("selected",true);
							}
						} else {
							if(res.stateType == "업무"){
								$("select[name=workState]").val("work").prop("selected",true);
							}
							if(res.stateType == "업무종료"){
								$("select[name=workState]").val("workComp").prop("selected",true);
							}
							if(res.stateType == "외근"){
								$("select[name=workState]").val("workOut").prop("selected",true);
							}
							if(res.stateType == "출장"){
								$("select[name=workState]").val("busiTrip").prop("selected",true);
							}
							if(res.stateType == "자리비움"){
								$("select[name=workState]").val("away").prop("selected",true);
							}
						}
						
						if(mem.memStatus == "출근"){
							$("select[name=workState]").val("workDefault").prop("selected",true);
						}
						
						if(mem.memStatus == "퇴근"){
							$("select[name=workState]").val("workDefault").prop("selected",true);
						}
					}
				})
			}
		})
	}

$(document).ready(function() {
	$("#messageNotification").hide();
    // 페이지 로드 시 안읽은 알림 개수 업데이트
    updateUnreadNotificationCount();

    // 알림 아이콘을 클릭하면 최근 알림 목록 가져오기
    $('#navbarDropdownNotification').on('click', function() {
        loadRecentNotifications();
    });

    // SSE로 실시간 알림 수 업데이트
    const eventSource = new EventSource('/notification/alarm');
    
    eventSource.onmessage = function(event) {
    	const data = JSON.parse(event.data);
    	console.log("카테고리:"+data.alarmCategory);
        if (data.alarmCategory != 'chatOp') {
        	updateUnreadNotificationCount();  // 새로운 알림이 오면 알림 수 업데이트
            loadRecentNotifications();  	// 알림 목록 업데이트 (채팅이 아닌 경우)
            
            showToastNotification(data.alarmCategory, data.alarmContent, data.alarmUrl);
            
        }else{
        	const content= JSON.parse(data.alarmContent);
        	console.log("들어왔다:"+content.msgContent);
        	
        	let message = content.msgContent;

            // HTML 태그 제거
            message = message.replace(/<\/?[^>]+(>|$)/g, "");

            const maxLength = 50;
            if (message.length > maxLength) {
                message = message.substring(0, maxLength) + "...";
            }
        	
        	console.log("알람 타이틀:", data.alarmTitle);
        	// 알림 창 데이터 업데이트
        	if(data.alarmTitle=='채팅'){
        		$("#messageTitle").text(data.alarmUrl);
        	}else{
	            $("#messageTitle").text(data.alarmTitle);  // 채팅방 이름 설정
        	}
        	
            $("#messageSender").text(data.alarmUrl);  // 보낸사람 이름 설정
            $("#messageContent").text(message);  // 채팅 내용 설정
            let host = location.href;
            let hosts = location.href.split("/")[2];
            if(host==`http://\${hosts}/chat/chatHome.do`){
            	console.log("새로고침");
            	loadChatRooms();
            }
            // 알림 창 표시
            $("#messageNotification").fadeIn();
            // 5초 후에 알림 창 숨기기
            setTimeout(function() {
                $("#messageNotification").fadeOut();
            }, 5000);
            
            $("#messageNotification").off("click").on("click", function() {
                sessionStorage.setItem("alarmRoomNo", data.alarmNo);
                sessionStorage.setItem("alarmTitle", data.alarmTitle);
                window.location.href = "/chat/chatHome.do";  // URL 이동
            });
        }
    };

    $('#notificationList').on('click', '.notification', function(event) {
        event.preventDefault();

        let alarmNo = $(this).data("id");
        console.log("알람 No:", alarmNo);

        $.ajax({
            url: '/notification/readNotification',
            method: 'GET',
            data: { alarmNo: alarmNo },
            dataType: 'text',
            success: function(response) {
                console.log(response);
                updateUnreadNotificationCount();
                loadRecentNotifications();
            },
            error: function(error) {
                console.error("Error reading notification:", error);
            }
        });

        let alarmUrl = $(this).attr("href");
        window.location.href = alarmUrl;
    });
    
});

// 안읽은 알림 수 업데이트
function updateUnreadNotificationCount() {
    $.ajax({
        url: '/notification/unreadCount',
        method: 'GET',
        success: function(data) {
            $('#notificationCount').text(data);
        },
        error: function(error) {
            console.error('안읽은 알림 수 에러:', error);
        }
    });
}

// 최근 알림 목록 가져오기
function loadRecentNotifications() {
    $.ajax({
        url: '/notification/notificationList',
        method: 'GET',
        success: function(alarmList) {
            let notificationList = $('#notificationList');
            notificationList.empty();  // 기존 알림 목록 초기화

            if (alarmList.length > 0) {
                // 최근 5개의 알림만 출력
                let recentAlarms = alarmList.slice(0, 5); 

                $.each(recentAlarms, function(index, alarm) {
                    let listItem = `
                        <div class="list-group-item">
                            <a class="notification notification-flush \${alarm.isRead === 'N' ? 'notification-unread' : ''}" href="\${alarm.alarmUrl}" data-id="\${alarm.alarmNo}">
                                <div class="notification-body">
                                    <p class="mb-1"><strong>[\${alarm.alarmCategory}]</strong> \${alarm.alarmContent}</p>
                                </div>
                            </a>
                        </div>
                    `;
                    notificationList.append(listItem);
                });
            } else {
                notificationList.append('<div class="text-center">새로운 알림이 없습니다.</div>');
            }
        },
        error: function(error) {
            console.error('최근 알림 에러:', error);
        }
    });
}

$("#closeNotification").on("click", function() {
	event.stopPropagation();
    $("#messageNotification").fadeOut();
});

function showToastNotification(category, content, url) {
    const toastNotification = $("#toastNotification");
    const toastBody = $("#toastBody");
    
    // 메시지 설정
    toastBody.html(`[\${category}] \${content}`);

    toastNotification.fadeIn();

    // 클릭 시 URL 이동 설정
    toastNotification.on("click", function() {
        window.location.href = url;
    });

    // 5초 후 자동 숨기기
    setTimeout(function() {
        toastNotification.fadeOut();
    }, 5000);

    console.log("토스트메시지:", category, content);
}



function checkMemberAuth() {
	axios({
		url : "/account/checkMemberAuth.do",
		method : "get"
	}).then(function (response) {
		if (response.data == 'SUCCESS') {
			$("#myPageATag").after(`<a class="dropdown-item" href="/account/otpLogin.do">관리자페이지</a>`);
		}
	});
}

</script>
