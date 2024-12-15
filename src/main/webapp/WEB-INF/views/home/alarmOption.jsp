<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container card h-100">
        <h2 class="p-3">알림 설정</h2>
        <form id="notificationSettingsForm">
            <div class="form-group p-2">
                <div class="form-check form-switch">
	              	<label for="approvalNotifications">전자결재 알림</label>
				  	<input class="form-check-input" id="approvalNotifications" type="checkbox" checked="" />
				</div>
            </div>
            <div class="form-group p-2">
                <div class="form-check form-switch">
                	<label for="smsNotifications">메일 알림</label>
				 	<input class="form-check-input"  id="smsNotifications" type="checkbox" checked="" />
				</div>
            </div>
            <div class="form-group p-2">
                <div class="form-check form-switch">
	                <label for="projectNotifications">프로젝트 알림</label>
				  	<input class="form-check-input" id="projectNotifications" type="checkbox" checked="" />
				</div>
            </div>
            <div class="form-group p-2">
                <div class="form-check form-switch">
	                <label for="boardNotifications">커뮤니티 알림</label>
				  	<input class="form-check-input" id="boardNotifications" type="checkbox" checked="" />
				</div>
            </div>
            <div class="form-group p-2">
                <div class="form-check form-switch">
	                <label for="calendarNotifications">캘린더 알림</label>
				  	<input class="form-check-input" id="calendarNotifications" type="checkbox" checked="" />
				</div>
            </div>
            <button type="button" class="btn btn-primary" id="saveSettings">저장</button>
        </form>
    </div>
    </div>
</body>
<script type="text/javascript">
$('#saveSettings').on('click', function() {
    let settings = {};

    $('#notificationSettingsForm input[type="checkbox"]').each(function() {
        const techCategory = $(this).data('tech-category');
        settings[techCategory] = $(this).is(':checked');
    });

    $.ajax({
        url: '/alarmOption/save',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(settings),
        success: function(response) {
            if (response === 'success') {
                alert('알림 설정이 저장되었습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
});
</script>
</html>