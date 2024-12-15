<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>

/* style.css */
.page-content {
    display: flex;
    margin-top: 20px;
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
/* 외부 이벤트 스타일 시작 */
#external-events {
    margin-bottom: 20px;
    padding: 10px;
    border: 1px solid #ccc;
    background: #f9f9f9;
}
.fc-event {
    cursor: move;
    margin: 5px 0;
    padding: 5px;
    background-color: #4CAF50; /* 바의 배경색 */
    border: 1px solid #388E3C; /* 바의 테두리 색상 */
    padding: 5px; /* 바의 안쪽 여백 */
    margin: 2px 0; /* 바의 바깥 여백 */
    color: white;
    text-align: center;
}
/* 외부 이벤트 스타일 끝*/

.fc-event-resizer {
    width: 10px;               /* 리사이즈 핸들의 너비 */
    height: 10px;              /* 리사이즈 핸들의 높이 */
    background-color: red;      /* 핸들의 색상 (명확히 보이도록 설정) */
    position: absolute;
    bottom: 0;                 /* 이벤트 요소의 하단에 배치 */
    right: 0;                  /* 이벤트 요소의 오른쪽에 배치 */
    cursor: se-resize;          /* 리사이즈 커서 설정 (우하단 방향 리사이즈) */
    z-index: 10;
}
.fc-event.fc-draggable .fc-resizer-start {
    cursor: w-resize;           /* 왼쪽 리사이즈 */
}

.fc-event.fc-draggable .fc-resizer-end {
    cursor: e-resize;           /* 오른쪽 리사이즈 */
}
</style>

<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.min.js"></script>
 
<!-- calendarPage.jsp -->
<div class="page-content w-100">

    <!-- 캘린더 영역 -->
    <div id="calendar-container" class="w-100">
        <div id="calendar"></div>
		<form action="/calendar/detail" method="post" id="calForm1">
			<input type="hidden" name="schdlNo" id="schdlNo" value=""/>
			<input type="hidden" name="schdlName" id="schdlName" value="${schedule.schdlName }"/>
			<input type="hidden" name="schdlGroup" id="schdlGroup" value="${schedule.schdlGroup }"/>
			<input type="hidden" name="startDate" id="startDate" value="${schedule.startDate }" />
			<input type="hidden" name="endDate" id="endDate" value="${schedule.endDate }" />
			<input type="hidden" name="startTime" id="startTime" value="${schedule.startTime }" />
			<input type="hidden" name="endTime" id="endTime" value="${schedule.endTime }" />
			<input type="hidden" name="schdlPlace" id="schdlPlace" value="${schedule.schdlPlace }" />
			<input type="hidden" name="schdlContent" id="schdlContent" value="${schedule.schdlContent }" />
			<input type="hidden" name="memNo" id="memNo" value="${schedule.memNo }" />
		</form>
    </div>
</div>

<!------------------- 모달 추가 ----------------------->
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventModalLabel">일정등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
                <form id="eventForm" action="/calendar/register" method="get">
                	<input type="hidden" name="memNo" id="memNo" value="${schedule.memNo }" />
                	<input type="hidden" name="depNo" id="depNo" value="${schedule.depNo }" />
	           		<div class="modal-body">
	                    <div class="mb-3">
		                    <p>일정명
								<input type="text" id="schdlModalName" name="schdlName" >
							</p>
							<p>일정을 선택해주세요.
							<br>
								<input type="text" id="datepicker" style="margin-right: 10px;" name="startDate" >
								<input type="time">
								<input type="text" id="datepicker1" style="margin-right: 10px;" name="endDate" >
								<input type="time">
							</p>
							<p>내 캘린더
								<select id="schdlGroup" name="schdlGroup">
									<option value="mySchedule">나의 일정</option>
									<option value="groupSchedule">그룹 일정</option>
									<option value="allSchedule">전사 일정</option>
								</select>
							</p>
							<p>장소</p>
								<input type="text" id="schdlModalPlace" name="schdlPlace">
	                    </div>
	                    <input type="hidden" id="eventStart">
	                    <input type="hidden" id="eventEnd">
		            </div>
		            <div class="modal-footer">
		                <button type="submit" class="btn btn-primary">상세입력</button>
		                <button type="button" class="btn btn-success" id="saveEventBtn">저장</button>
		                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		            </div>
               </form>
        </div>
    </div>
</div>

<script type="text/javascript">

/* -------------------- modal 시작 ------------------------ */
$(document).ready(function() {
	var saveEventBtn = $("#saveEventBtn");
	
	saveEventBtn.on("click" , function(){
		var schdlName = $("#schdlModalName").val();
		var startDate = $("#datepicker").val().toString();
		var endDate = $("#datepicker1").val().toString();
		var schdlGroup = $("#schdlGroup").val();
		var schdlPlace = $("#schdlModalPlace").val();
		var memNo = $("#memNo").val();
		var depNo = $("#depNo").val();
		
		var schedObject = {
				schdlName : schdlName,
				startDate : startDate,
				endDate : endDate,
				schdlGroup : schdlGroup,
				schdlPlace : schdlPlace,
				memNo : memNo,
				depNo : depNo
		}
		
		console.log("## ajax 타기 전 :",schedObject);
		$.ajax({
			url : "/calendar/modal",
			type : "post", 	
			data : JSON.stringify(schedObject),
			contentType : "application/json; charset=utf-8",
			success : function(res) {
				console.log("res : " + res);
				if(res == "SUCCESS") {
					Swal.fire({
						  position: "center",
						  icon: "success",
						  title: "정상적으로 등록 되었습니다.",
						  showConfirmButton: false,
						  timer: 1500,
						  willClose: () => {
							window.location.href="/calendar/main";							  
						  }
					});
				}
			}
		});
	});
	
	
	
     $("#datepicker,#datepicker1").datepicker({
        timeFormat: 'HH:mm', // 시간을 포맷팅하는 방법
        dateFormat: 'yy-mm-dd', // 날짜 포맷
        showOtherMonths: true,
        showMonthAfterYear: true,
        changeYear: true,
        changeMonth: true,
        showOn: "button", 
        buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif", 
        buttonImageOnly: true,
        yearSuffix: "년",
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
    }); 
	
})
/* ---------------------- modal 끝 ------------------------ */

$(function() {

});

/* ------------------------------ 캘린더 --------------------------------- */

var calendar;

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    let calForm1 = document.querySelector("#calForm1");

    calendar = new FullCalendar.Calendar(calendarEl, {
    	timeZone: 'UTC',
        themeSystem: 'bootstrap5',
        editable: true,		// 이벤트 적용 (드래그앤 드롭 /리사이즈 등등)
        resizableFromStart: true,
        eventResizableFromStart: true,
        durationEditable:true, // 리사이즈 가능 여부 설정
        eventDurationEditable:true,
        eventOverlap:true,
        droppable:true,
        dayMaxEvents: true, // 너무 많은 이벤트가 있을 경우 팝오버 표시
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'customMonth,customWeek,customDay'
        },
        customButtons: {
            customMonth: {
                text: '월간', // 원하는 명칭으로 변경
                click: function() {
                    calendar.changeView('dayGridMonth');
                }
            },
            customWeek: {
                text: '주간', // 원하는 명칭으로 변경
                click: function() {
                    calendar.changeView('timeGridWeek');
                }
            },
            customDay: {
                text: '일간', // 원하는 명칭으로 변경
                click: function() {
                    calendar.changeView('timeGridDay');
                }
            }
        },
        weekNumbers: false,	// 사이드에 주 번호
        dayMaxEvents: 3, // allow "more" link when too many events
        
        initialView: 'dayGridMonth',		// 캘린더 초기값 설정(처음 화면)
        selectable: true,
        slotDuration: '00:30:00', // 슬롯 길이를 30분으로 설정
        events:[],

        /* ---------------- 클릭 시 이벤트 (detail) ------------------- */
        eventClick: function(e){
        	console.log("들어옴? eventClick...!")
        	
            let schdlNoEle = document.querySelector("#schdlNo");
            let schdlEle = document.querySelector("#schdlName");
            let startEle = document.querySelector("#startDate");
            let endEle = document.querySelector("#endDate");
            let startTimeEle = document.querySelector("#startTime");
            let endTimeEle = document.querySelector("#endTime");
            let schdlPlaceEle = document.querySelector("#schdlPlace");
            let schdlContentEle = document.querySelector("#schdlContent");
            
            let memNoEle = document.querySelector("#memNo");
        	
            schdlNoEle.value = e.event.id;
            schdlEle.value = e.event.title;
            startEle.value = e.event.startStr;
            endEle.value = e.event.endStr;
            
         	// extendedProps에서 데이터를 가져옴
            schdlPlaceEle.value = e.event.extendedProps.schdlPlace || ''; // 장소
            schdlContentEle.value = e.event.extendedProps.schdlContent || ''; // 내용
            memNoEle.value = e.event.extendedProps.memNo || '';
            
            if (e.event.start) {
                let startTime = e.event.start.toISOString().split('T')[1];
                startTimeEle.value = startTime ? startTime.substring(0, 5) : '';
            } else {
                startTimeEle.value = ''; // start 시간이 없을 때
            }
            
            if (e.event.end) {
                let endTime = e.event.end.toISOString().split('T')[1];
                endTimeEle.value = endTime ? endTime.substring(0, 5) : '';
            } else {
                endTimeEle.value = ''; // end 시간이 없을 때
            }
            
        	calForm1.submit();
        },
        
        /* 선택(select) - 모달창 생성.... */
        select: function(e) {
        	let startStr = e.startStr;
        	let endDate = new Date(e.end);
        	endDate.setDate(endDate.getDate() - 1);
        	
        	console.log(e.startStr + " ~ " + endDate.toISOString().split('T')[0]);
        	
        	// 모달의 입력 필드에 값 설정
            $("#schdlName").val(''); // 일정명 초기화
            $("#datepicker").val(startStr); // startStr 값 설정
            $("#datepicker1").val(endDate.toISOString().split('T')[0]); // endDate 값 설정
            $("#schdlGroup").val('mySchedule'); // 그룹 설정 (기본값 설정)
            $("#schdlPlace").val(''); // 장소 초기화
            
        	// 모달 보여주기
            var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
            myModal.show();
        	
        },
        
        // 이벤트 리사이즈 처리
        eventResize: function(info) {
            console.log('이벤트가 리사이즈되었습니다:', info.event);
            
            saveEvent({
                id: info.event.id,
                title: info.event.title,
                start: info.event.startStr.substring(0,info.event.startStr.indexOf("T")),
                end: info.event.endStr.substring(0,info.event.endStr.indexOf("T")),
                schdlContent : info.event.schdlContent,
                schdlPlace : info.event.schdlPlace,
                memNo : info.event.memNo
            });
        },
        
        // 이벤트 드롭 처리
        eventDrop: function(info) {
        	
        	console.log('드롭된 이벤트의 extendedProps:', info.event.extendedProps);
        	var schdlContent = info.event.extendedProps.schdlContent || "";
            var schdlPlace = info.event.extendedProps.schdlPlace || "";
            var memNo = info.event.extendedProps.memNo || "";
        	
            console.log('이벤트가 드롭되었습니다:', info.event);
            saveEvent({
                id: info.event.id,
                title: info.event.title,
                start: info.event.startStr.substring(0,info.event.startStr.indexOf("T")),
                end: info.event.endStr.substring(0,info.event.endStr.indexOf("T")),
                schdlContent : schdlContent,
                schdlPlace : schdlPlace,
                memNo: memNo
            });
        },
        
    });
    calendar.render();
//     fetchEvents(); // 전체를 가져옴
}); 

function saveEvent(event) {
	
	console.log("## saveEvent function ::" , event);
	
	var eventObject = {
		schdlNo : event.id,
		schdlName : event.title,
		startDate : event.start,
		endDate : event.end,
		schdlPlace : event.schdlPlace,
		schdlContent : event.schdlContent,
		memNo: event.memNo
		
	}	
	console.log("## 콘솔", eventObject);
		
    $.ajax({
        url: '/calendar/saveEvent', // 이벤트 저장 API 경로
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(eventObject),
        success: function(result) {
            console.log("이벤트가 저장되었습니다.", result);
            calendar.render();
        },
        error: function(xhr, status, error) {
            console.error("이벤트 저장에 실패했습니다.", {
                status: status,
                error: error,
                response: xhr.responseText
            });
        }
    });
}

/*  켈린더에 데이터를 받아오는 곳 LIST */
function fetchEvents() {
    $.ajax({
        url: '/calendar/events', 
        method: 'GET',
        success: function(data) {
            // 받은 데이터가 이벤트 배열이라고 가정
            data.forEach(event => {
            	
            	let backgroundColor = '#4CAF50'; // 기본 색상 (연두색)
                let borderColor = '#388E3C'; // 기본 테두리색
                let textColor = "#000000"; // 기본 검정색

                // deptNo 값에 따른 색상 지정
                if (event.deptNo === 1) {
                	backgroundColor = '#87CEEB'; // 하늘색
                    borderColor = '#87CEEB'; // 하늘색 테두리
                } else if (event.deptNo === 2) {
                	backgroundColor = '#FFFF00'; // 노란색
                    borderColor = '#FFFF00'; // 노란색 테두리
                } else if (event.deptNo === 3) {
                    backgroundColor = '#FF0000'; // 빨간색
                    borderColor = '#FF0000'; // 빨간 테두리
                } else if (event.deptNo === 4) {
                	backgroundColor = '#0000FF'; // 파란색
                    borderColor = '#0000FF'; // 파란색 테두리
                } else if (event.deptNo === 6) {
                    backgroundColor = '#90EE90'; // 연두색
                    borderColor = '#90EE90'; // 연두 테두리
                    textColor : "#000000";
                }
            	
                calendar.addEvent({
                	id : event.schdlNo,
                    title: event.schdlName, // 일정 제목
                    start: event.startDate + (event.startTime ? 'T' + event.startTime : ''), // 일정 시작일
                    end: event.endDate + (event.endTime ? 'T' + event.endTime : ''), // 일정 종료일
                    backgroundColor: backgroundColor, // 조건에 따른 배경색
                    borderColor: borderColor, // 조건에 따른 테두리색
                    textColor: textColor, // 텍스트 색상 추가
                    allDay : true,
                    
                    extendedProps: {
                        schdlPlace: event.schdlPlace, // 일정 장소
                        schdlContent: event.schdlContent, // 일정 내용
                        memNo: event.memNo
                    },
                });
            });
            calendar.render();
        },
        error: function(xhr, status, error) {
            console.error("이벤트를 가져오는 데 실패했습니다.", {
                status: status,
                error: error,
                response: xhr.responseText
            });
        }
    });
}

function addEventToCalendar(event) {
	calendar.addEvent(event);
	
}

</script>
