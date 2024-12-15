<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>

/* style.css */
.page-content {
    display: flex;
    margin-top: 20px;
}

#page-sidebar {
    width: 200px;
    background-color: #f5f5f5;
    padding: 20px;
    border-right: 1px solid #ddd;
}

#page-sidebar ul {
    list-style-type: none;
    padding: 0;
}

#page-sidebar ul li {
    margin-bottom: 10px;
}

#page-sidebar ul li a {
    text-decoration: none;
    color: #333;
    display: block;
    padding: 10px;
    background-color: #e9e9e9;
    border-radius: 4px;
}

#calendar-container {
    flex-grow: 1;
    padding: 20px;
}

#calendar {
    width: 100%;
    height: 600px;
    border: 1px solid #ccc;
    background-color: #fff;
}
</style>
<!-- calendarPage.jsp -->
<div style="width: 90%;">
    <div style="margin-top: 20px; margin-left: 20px;">
        <h2>일정상세</h2>
    </div>
		<div id="calendar-container" style="padding-bottom: 0;">
		<form action="/calendar/delete" method="post" id="form">
			<input type="hidden" name="schdlNo" value="${schedule.schdlNo}"/>
			
			<table class="table table-bordered" style="width: 900px">
			
				<colgroup>
					<col width="20%">
					<col>
				</colgroup>
				
				<tr>
					<th>일정명</th>
					<td class="d-flex flex-row align-items-center">
						${schedule.schdlName } <span style="width: 20px"></span>
					</td>
				</tr>
				<tr>
					<th>일정</th>
					<td>
						${schedule.startDate }&nbsp ${schedule.startTime.substring(0, 5)} &nbsp ~ &nbsp ${schedule.endDate }&nbsp ${schedule.endTime.substring(0, 5)} <br/>
					</td>
				</tr>
				<tr>
					<th>캘린더</th>
					<td>
						<c:if test="${schedule.schdlGroup == 'my'}">
					        나의 일정
					    </c:if>
					    <c:if test="${schedule.schdlGroup == 'group'}">
					        그룹 일정
					    </c:if>
					</td>
				</tr>
				<tr>
					<th>참석자</th>
					<td>
					    <c:choose>
					        <c:when test="${empty attendMember.schdlAttendeeVO || (not empty attendMember.schdlAttendeeVO[0] && empty attendMember.schdlAttendeeVO[0].memName)}">
					        </c:when>
					        <c:otherwise>
					            <c:forEach var="attendee" items="${attendMember.schdlAttendeeVO}">
					                <span class="fas fa-user-circle" style="font-size: 20px; margin-right: 5px;"></span>
					                ${attendee.memName} (${attendee.deptName}) &nbsp;&nbsp;
					            </c:forEach>
					        </c:otherwise>
					    </c:choose>
					</td>
				</tr>
				<tr>
					<th>외부 참석자 </th>
					<td>
					</td>
				</tr>
				<tr>
					<th>장소</th>
					<td>
						${schedule.schdlPlace}						
					</td>
				</tr>
				<tr>
					<th>내용</th> 
					<td>
						${schedule.schdlContent}
					</td>
				</tr>
			</table>
			<div style="text-align: right; padding-top: 10px; width: 900px">
				<sec:authentication property="principal.member" var="member"/>
				<c:if test="${member.memNo eq scheduleVO.memNo }">
					<input type="button" class="btn btn-info" id="updBtn" value="수정"/>
					<input type="button" class="btn btn-danger" id="delBtn" value="삭제"/>
				</c:if>
					<input type="button" class="btn btn-secondary" id="listBtn" value="이전"/>
			</div>
		</form>
		</div>
    </div>
</div>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
<script type="text/javascript">

let isAlertVisible = false;

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

$(function(){
	
	var form = $("#form");
	var updBtn = $("#updBtn");
	var delBtn = $("#delBtn");
	var listBtn = $("#listBtn");
	
	var schdlNo = "${schedule.schdlNo}";
	
	updBtn.on("click" , function(){
		location.href ="/calendar/update?schdlNo="+schdlNo;
	
	});
	
	delBtn.on("click" , function(){

		Swal.fire({
			  title: "일정을 삭제하시겠습니까?",
			  text: "삭제된 일정은 다시 복구되지 않습니다!",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네, 삭제하겠습니다!",
			  cancelButtonText: "이전으로"
			}).then((result) => {
				if (result.isConfirmed) {
		            $.ajax({
		                url: "/calendar/delete",
		                type: "POST",
		                data: { schdlNo: schdlNo },
		                success: function(response) {
		                    sessionStorage.setItem("successMessage", "삭제가 정상적으로 되었습니다.");
		                    window.location.href = "/calendar/main";
		                },
		                error: function(error) {
		                    console.error("삭제 실패:", error);
		                    Swal.fire("오류", "삭제에 실패했습니다.", "error");
		                }
		            });
// 				  if (result.isConfirmed) {
// 					  form.submit();
// 					  sessionStorage.setItem("successMessage", "삭제가 정상적으로 되었습니다.");
// 					  console.log("sessionStorage" , sessionStorage.getItem("successMessage"));
// 					  window.location.href = "/calendar/main";
						
// 	 					requiredAlert("삭제가 정상적으로 되었습니다." ,isAlertVisible);
// 	 			        setTimeout(function() {
// 	 			            window.location.href = "/calendar/main"; // 페이지 이동
// 	 			        }, 1000);
	 			        
// 					  Swal.fire({
// 						  position: "center",
// 						  icon: "success",
// 						  title: "삭제완료!",
// 						  text: "삭제가 정상적으로 되었습니다.",
// 						  timer: 1500,
// 						  willClose: () => {
// 							  window.location.href = "/address/main"
// 						  }
// 					  }, 100);
				  	}
			 	});
	});
	
	listBtn.on("click" , function(){
		location.href = "/calendar/main";
	});
});

</script>