<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 전체 보기</title>
<style>
    .notification {
        padding: 1rem;
        border-bottom: 1px solid #ddd;
    }
    .notification-unread {
	    background-color: #f8d7da;
	    color: #721c24;
	    font-weight: bold;
	}
	.notification-body {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    width: 100%; /* 전체 너비 사용 */
	}
	
	.notification-time {
	    font-size: 0.875rem;
	    color: #6c757d;
	    margin-right: auto; /* 시간 요소를 왼쪽으로 밀어 버튼을 오른쪽으로 이동 */
	}

</style>
</head>
<body>
    <div class="card overflow-hidden">
        <div class="card-header bg-body-tertiary">
            <div class="row flex-between-center">
                <div class="col-sm-auto">
                    <h5 class="mb-1 mb-md-0">알림 </h5>
                    
                </div>
                <div class="col-sm-auto fs-10">
                    <a class="font-sans-serif" href="#" id="markAllAsRead">모두 읽음처리</a>
                </div>
            </div>
        </div>
        <div class="card-body fs-10 p-0" id="alarmListArea">
            <div id="notificationAllList">
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            loadNotifications();

            $('#markAllAsRead').on('click', function() {
                $.ajax({
                    url: '/notification/markAllAsRead',
                    method: 'GET',
                    success: function(response) {
                    	updateUnreadNotificationCount();
                        loadNotifications();
                    },
                    error: function(error) {
                        console.error('Error marking all as read:', error);
                    }
                });
            });

            function loadNotifications() {
                $.ajax({
                    url: '/notification/notificationList',
                    method: 'GET',
                    success: function(alarmList) {
                        let notificationList = $('#notificationAllList');
                        notificationList.empty();

                        if (alarmList.length > 0) {
                            $.each(alarmList, function(index, alarm) {
                                let notificationItem = `
                                    <a class="notification \${alarm.isRead === 'N' ? 'notification-unread' : ''}" href="\${alarm.alarmUrl}">
                                        <div class="notification-body">
                                            <div>
                                                <p class="mb-1"><strong>[\${alarm.alarmCategory}]</strong> \${alarm.alarmContent}</p>
                                                <span class="notification-time">알림시각: \${alarm.regDate}</span>
                                            </div>
                                            <button class="btn-close" data-id="\${alarm.alarmNo}" style="margin-left: 10px;"></button>
                                        </div>
                                    </a>
                                `;
                                notificationList.append(notificationItem);
                            });
                        } else {
                            notificationList.append('<div class="text-center">새로운 알림이 없습니다.</div>');
                        }
                    },
                    error: function(error) {
                        console.error('Error loading notifications:', error);
                    }
                });
            }
            
            $('#notificationAllList').on('click', '.btn-close', function(event) {
                event.preventDefault();
				console.log($(this));
                let alarmNo = $(this).data('id');
                console.log("삭제할 알람 No:", alarmNo);

                $.ajax({
                    url: '/notification/deleteNotification',
                    method: 'POST',
                    data: {alarmNo: alarmNo},
                    success: function(response) {
                        console.log('알림이 삭제되었습니다:', response);
                        updateUnreadNotificationCount();
                        loadNotifications();
                    },
                    error: function(error) {
                        console.error('알림 삭제 중 오류 발생:', error);
                    }
                });
            });
            
            
        });
    </script>
</body>
</html>
