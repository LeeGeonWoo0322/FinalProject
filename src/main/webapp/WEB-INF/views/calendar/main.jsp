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

.fc-daygrid-dot-event {
    display: flex; /* dot 스타일을 없애고 bar 형태로 변경 */
    align-items: center; /* 수평 정렬 */
    padding: 2px 5px; /* 바 스타일로 보이게 패딩 조정 */
    border-radius: 3px; /* 모서리를 둥글게 */
    background-color: #FFF9C4; 
    borderColor : #FFF59D; 
    color: #000000; /* 글자색 */
     
}

.fc-event-title {
    color: #000000; /* 글자색 */
}

.fc .fc-event-title{
	font-weight: 600 !important;
}

/* dot 부분 스타일링 제거 */
.fc-daygrid-event-dot {
    display: none; /* dot을 보이지 않게 설정 */
}

/* 이벤트 제목을 강조하기 위한 추가 스타일 */
.fc-daygrid-event {
    border: none; /* 기본 테두리 제거 */
    text-align: center; /* 텍스트 중앙 정렬 */
}


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

/* 달력 관련 */
.fc-event.fc-draggable .fc-resizer-start {
    cursor: w-resize;           /* 왼쪽 리사이즈 */
}

.fc-event.fc-draggable .fc-resizer-end {
    cursor: e-resize;           /* 오른쪽 리사이즈 */
}

/* Datepicker를 위한 스타일 설정 */
.datepicker-input {
    width: 45%;
    display: inline-block;
    margin-right: 5px;
    padding-right: 30px; /* 아이콘과의 간격을 위한 패딩 */
    background: url('http://jqueryui.com/resources/demos/datepicker/images/calendar.gif') no-repeat right 5px center;
    cursor: pointer; /* 클릭 가능 커서 */
}

/* jQuery UI에서 자동 생성하는 아이콘 숨기기 */
.ui-datepicker-trigger {
    display: none; /* 기본 아이콘 숨기기 */
}

/*  */

.i_datepicker input{cursor: pointer;}
.i_datepicker img{position: absolute; right: 15px; top: 50%; transform: translateY(-50%); width: 16px; height: 16px; background: url(../img/ico_datepicker.svg) no-repeat center/cover;}
.ui-widget-header { border: 0px solid #dddddd; background: #fff; }

.ui-datepicker-calendar>thead>tr>th { font-size: 14px !important; }

.ui-datepicker .ui-datepicker-header { position: relative; padding: 10px 0; }

.ui-state-default,
.ui-widget-content .ui-state-default,
.ui-widget-header .ui-state-default,
.ui-button,
html .ui-button.ui-state-disabled:hover,
html .ui-button.ui-state-disabled:active { border: 0px solid #c5c5c5; background-color: transparent; font-weight: normal; color: #454545; text-align: center; }

.ui-datepicker .ui-datepicker-title { margin: 0 0em; line-height: 16px; text-align: center; font-size: 14px; padding: 0px; font-weight: bold; }

.ui-datepicker { display: none; background-color: #fff; border-radius: 4px; margin-top: 10px; margin-left: 0px; margin-right: 0px; padding: 20px; padding-bottom: 10px; width: 300px; box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.1); }

.ui-widget.ui-widget-content { border: 1px solid #eee; }

#datepicker:focus>.ui-datepicker { display: block; }

.ui-datepicker-prev,
.ui-datepicker-next { cursor: pointer; }

.ui-datepicker-next { float: right; }

.ui-state-disabled { cursor: auto; color: hsla(0, 0%, 80%, 1); }

.ui-datepicker-title { text-align: center; padding: 10px; font-weight: 100; font-size: 20px; }

.ui-datepicker-calendar { width: 100%; }

.ui-datepicker-calendar>thead>tr>th { padding: 5px; font-size: 20px; font-weight: 400; }

.ui-datepicker-calendar>tbody>tr>td>a { color: #000; font-size: 12px !important; font-weight: bold !important; text-decoration: none;}

.ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover { cursor: auto; background-color: #fff; }

.ui-datepicker-calendar>tbody>tr>td { border-radius: 100%; width: 44px; height: 30px; cursor: pointer; padding: 5px; font-weight: 100; text-align: center; font-size: 12px; }

.ui-datepicker-calendar>tbody>tr>td:hover { background-color: transparent; opacity: 0.6; }

.ui-state-hover,
.ui-widget-content .ui-state-hover,
.ui-widget-header .ui-state-hover,
.ui-state-focus,
.ui-widget-content .ui-state-focus,
.ui-widget-header .ui-state-focus,
.ui-button:hover,
.ui-button:focus { border: 0px solid #cccccc; background-color: transparent; font-weight: normal; color: #2b2b2b; }

/* .ui-widget-header .ui-icon { background-image: url('./btns.png'); }  */

/* .ui-icon-circle-triangle-e { background-position: -20px 0px; background-size: 36px; }

.ui-icon-circle-triangle-w { background-position: -0px -0px; background-size: 36px; }  */

.ui-datepicker-calendar>tbody>tr>td:first-child a { color: red !important; }

.ui-datepicker-calendar>tbody>tr>td:last-child a { color: #0099ff !important; }

.ui-datepicker-calendar>thead>tr>th:first-child { color: red !important; }

.ui-datepicker-calendar>thead>tr>th:last-child { color: #0099ff !important; }

.ui-state-highlight,
.ui-widget-content .ui-state-highlight,
.ui-widget-header .ui-state-highlight { border: 0px; background: #f1f1f1; border-radius: 50%; padding-top: 7px; padding-bottom: 8px; }

.inp { padding: 10px 10px; background-color: #f1f1f1; border-radius: 4px; border: 0px; }


/* 툴팁 테마 스타일 */
.tippy-box[data-theme~='custom'] {
    background-color: #4a90e2; /* 원하는 배경색 */
    color: #fff;               /* 글자 색상 */
    border-radius: 8px;        /* 모서리 둥글게 */
    padding: 10px;             /* 여백 추가 */
}

/* 사라지는 애니메이션 */
.tippy-box[data-theme~='custom'][data-state='hidden'] {
    animation: custom-fade-out 0.3s ease-in;
}

/* 툴팁 안의 텍스트 정렬 */
.tippy-box[data-theme~='custom'] .tippy-content {
    text-align: left; /* 왼쪽 정렬 또는 center, right */
    font-size: 14px;  /* 글자 크기 조절 */
}

/* 반짝반짝 효과 */
.sparkle {
    font-size: 2em; /* 글자 크기 */
    font-weight: bold; /* 글자 두께 */
    color: #ff6600; /* 기본 글자 색상 */
    animation: sparkle 1.5s infinite alternate; /* 애니메이션 설정 */
}

@keyframes sparkle {
    0% {
        text-shadow: 
            0 0 5px #ffcc00, 
            0 0 10px #ffcc00, 
            0 0 15px #ff9900, 
            0 0 20px #ff6600; /* 시작 상태 */
    }
    100% {
        text-shadow: 
            0 0 10px #ffcc00, 
            0 0 20px #ff9900, 
            0 0 30px #ff6600, 
            0 0 40px #ff3300; /* 끝 상태 */
    }
}

/* --------------------- bounce 효과 시작 --------------------- */
.bounce {
    animation: bounce 1s 1; /* 1회 실행 */
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-15px);
    }
    60% {
        transform: translateY(-7.5px);
    }
}
/* --------------------- bounce 효과 끝  ---------------------*/

.blink {
    animation: blink 4s infinite;
}

@keyframes blink {
    0% {
        opacity: 0; /* 시작할 때 보이지 않음 */
    }
    25% {
        opacity: 1; /* 1초에 완전히 나타남 */
    }
    62.5% {
        opacity: 1; /* 3초에 완전히 유지 */
    }
    100% {
        opacity: 0; /* 4초에 완전히 사라짐 */
    }
}

.slide-in {
    opacity: 0; /* 시작할 때 완전히 투명 */
    transform: translateX(-100%); /* 시작할 때 왼쪽 밖에서 시작 */
    animation: slideIn 1s forwards; /* 애니메이션 설정 */
}


@keyframes slideIn {
    to {
        opacity: 1; /* 최종 상태는 불투명 */
        transform: translateX(0); /* 원래 위치로 돌아감 */
    }
}

@keyframes slideOut {
    0% {
        transform: translateX(0); /* 원래 위치 */
        opacity: 1;
    }
    100% {
        transform: translateX(100%); /* 오른쪽으로 슬라이드 아웃 */
        opacity: 0;
    }
}

.fc-event.slide-out {
    animation: slideOut 0.5s forwards; /* 0.5초 동안 슬라이드 아웃 */
}

</style>

<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.15/index.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/public/vendors/fullcalendar/index.global.min.js"></script>
 
<div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
       <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
</div>
 
<!-- calendarPage.jsp -->
<div class="page-content w-100">
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
			<input type="hidden" name="attendNo" id="attendNo" value="" />
		</form>
    </div>
</div>

<!------------------- 모달 추가 ----------------------->
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventModalLabel">일정등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="#" action="#" method="#">
                <input type="hidden" name="memNo" id="memModalNo" value="${member.memNo }" />
                <input type="hidden" name="depNo" id="deptModalNo" value="${member.deptNo }" />
                <input type="hidden" name="posNo" id="posModalNo" value="${member.posNo }" />
                
                <div class="modal-body">
                    <table class="table table-borderless">
                        <tbody>
                            <tr>
                                <td style="width: 20%;"><label for="schdlModalName">일정명</label></td>
                                <td>
                                	<input type="text" id="schdlModalName" name="schdlName" class="form-control">
	                                <input type="checkbox" name="blind" value="blind" id="scret" checked/> 비공개
									<input type='checkbox' name='alarm' value='alarm'/> 알림설정
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;"><label>일정 선택</label></td>
                                <td>
								    <input type="text" id="datepicker" class="form-control datepicker-input" name="startDate">
								    <input type="text" id="datepicker1" class="form-control datepicker-input" name="endDate">
								</td>
                            </tr>
                            <tr>
                                <td style="width: 20%;"><label for="schdlGroup">내 캘린더</label></td>
                                <td>
                                    <select id="schdlGroup1" name="schdlGroup">
							            <option value="my">나의 일정</option>
							            <c:if test="${member.posNo >= 4}">
							                <option value="group">그룹 일정</option>
							            </c:if>
							            <c:if test="${member.posNo >= 7}">
							                <option value="all">전사 일정</option>
							            </c:if>
							        </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;"><label for="schdlModalPlace">장소</label></td>
                                <td><input type="text" id="schdlModalPlace" name="schdlPlace" class="form-control"></td>
                            </tr>
                        </tbody>
                    </table>
                    <input type="hidden" id="eventStart">
                    <input type="hidden" id="eventEnd">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="detailBtn">상세입력</button>
                    <button type="button" class="btn btn-info" id="saveEventBtn">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://unpkg.com/@popperjs/core@2"></script><!-- tippy 사용 위찬 연결-->
<script src="https://unpkg.com/tippy.js@6"></script><!-- tippy 사용 위찬 연결-->
<script type="text/javascript">

/* ---------------------- modal 등록 ------------------------ */
$(document).ready(function() {
	var saveEventBtn = $("#saveEventBtn");
	console.log("## saveEventBtn: ",saveEventBtn);
	console.log("memNo: ", memModalNo);
	console.log("deptNo: ", deptModalNo);
	
	saveEventBtn.on("click" , function(){
		var schdlName = $("#schdlModalName").val();
		var startDate = $("#datepicker").val().toString();
		var endDate = $("#datepicker1").val().toString();
		var schdlGroup = $("#schdlGroup1").val();
		var schdlPlace = $("#schdlModalPlace").val();
		var memModalNo = $("#memModalNo").val();
		var deptModalNo = $("#deptModalNo").val();
		var posModalNo = $("#posModalNo").val();
		
		console.log("## schdlGroup1",schdlGroup);
		
		var schedObject = {
				schdlName : schdlName,
				startDate : startDate,
				endDate : endDate,
				schdlGroup : schdlGroup,
				schdlPlace : schdlPlace,
				memNo : memModalNo,
				depNo : deptModalNo,
				posNo : posModalNo
		}
		
		console.log("## ajax 타기 전 schedObject :",schedObject);
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
	
	/* ------------------- modal 상세입력 버튼 ------------------- */
	var detailBtn = $("#detailBtn");
	detailBtn.on("click" , function(e){
		e.preventDefault();
		
		var posModalNo = $("#posModalNo").val(); // detailBtn에서도 posModalNo 확인
        console.log("## detailBtn 클릭 시 posModalNo 값 확인:", posModalNo);
		
		var detailObject = {
		        memNo: $("#memModalNo").val(),
		        depNo: $("#deptModalNo").val(),
		        schdlName: $("#schdlModalName").val(),
		        startDate: $("#datepicker").val(),
		        endDate: $("#datepicker1").val(),
		        schdlGroup: $("#schdlGroup1").val(),
		        schdlPlace: $("#schdlModalPlace").val(),
		        posNo: posModalNo
		    };
		
		console.log("detailBtn 클릭 시 detailObject 확인:", detailObject);
		
		// 데이터를 sessionStorage에 저장
	    sessionStorage.setItem('scheduleData', JSON.stringify(detailObject));

	    // /register 페이지로 이동
	    window.location.href = '/calendar/register'; 
		
	});
});
/* ---------------------- modal 끝 ------------------------ */

$(function() {
    $("#datepicker,#datepicker1").datepicker({
    	 dateFormat: 'yy-mm-dd'
    	,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    	,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
//     	,changeYear: true //option값 년 선택 가능
//     	,changeMonth: true //option값  월 선택 가능 
    	,showOn: "button" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
    	,buttonImage: "${pageContext.request.contextPath }/resources/icon/calendarIcon.png" //버튼 이미지 경로
    	,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
    	,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
    	,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
    	,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
    });
    
 	// 아이콘 클릭 시 Datepicker가 열리도록 input 클릭 이벤트 처리
    $(".datepicker-input").on("click", function() {
        $(this).datepicker("show");
    });
    
 	// 달력 버튼 이미지 크기 조정
    $(".ui-datepicker-trigger").css({
        width: "24px", // 원하는 크기로 조정
        height: "24px" // 원하는 크기로 조정
    });
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
        displayEventTime:false,
        
        initialView: 'dayGridMonth',	// 캘린더 초기값 설정(처음 화면)
        selectable: true,
        slotDuration: '00:30:00', // 슬롯 길이를 30분으로 설정
        height: '800px',
        
        events:[],

        /* ---------------- 일정 클릭 시 이벤트 (detail) ------------------- */
        eventClick: function(e){
        	console.log("클릭한 이벤트" , e);
        	
        	console.log("Event Title:", e.event.title);         // 이벤트 제목
            console.log("Event Start Date:", e.event.start);    // 시작 시간
            console.log("Event End Date:", e.event.end);        // 종료 시간
            
        	 // 확장 정보 (extendedProps 사용)
            console.log("schdlGroup : " , e.event.extendedProps.schdlGroup);
            console.log("Event Place:", e.event.extendedProps.schdlPlace);    // 장소
            console.log("Event Content:", e.event.extendedProps.schdlContent); // 내용
            console.log("Member No:", e.event.extendedProps.memNo);           // 멤버 번호
            console.log("Attend No:", e.event.extendedProps.attendNo);        // 참석자 번호

            // 클릭된 요소와 관련된 정보
            console.log("Clicked Element:", e.el);              // 클릭한 HTML 요소
            console.log("Click Event:", e.jsEvent);

            calForm1.schdlNo.value = e.event.id;
            calForm1.schdlName.value = e.event.title;
            calForm1.startDate.value = e.event.startStr.split('T')[0];
            calForm1.endDate.value = e.event.endStr.split('T')[0];
            
         	// extendedProps에서 데이터를 가져옴
            calForm1.schdlGroup.value = e.event.extendedProps?.schdlGroup || '';
            calForm1.schdlPlace.value = e.event.extendedProps?.schdlPlace || '';
            calForm1.schdlContent.value = e.event.extendedProps?.schdlContent || '';
            calForm1.memNo.value = e.event.extendedProps?.memNo || '';
            calForm1.attendNo.value = e.event.extendedProps?.attendNo || '';
            
            calForm1.startTime.value = e.event.start ? e.event.start.toISOString().split('T')[1].substring(0, 5) : '';
            calForm1.endTime.value = e.event.end ? e.event.end.toISOString().split('T')[1].substring(0, 5) : '';
            
        	calForm1.submit();
        },
        
        /* 선택(select) - 모달창 생성.... */
        select: function(e) {
        	let startStr = e.startStr;
        	let endDate = new Date(e.end);
        	endDate.setDate(endDate.getDate() - 1);
        	
        	console.log("## 드래그 했었을때 일정 : " ,e.startStr + " ~ " + endDate.toISOString().split('T')[0]);
        	
        	// 모달의 입력 필드에 값 설정
            $("#schdlName").val(''); // 일정명 초기화
            $("#datepicker").val(startStr); // startStr 값 설정
            $("#datepicker1").val(endDate.toISOString().split('T')[0]); // endDate 값 설정
            $("#schdlGroup").val("my"); // 그룹 설정 (기본값 설정)
            $("#schdlPlace").val(''); // 장소 초기화
            $("#posModalNo").val();
            
            console.log("## posNo : " , $("#posModalNo").val());	
            console.log($("#schdlGroup").val());
        	// 모달 보여주기
            var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
            myModal.show();
            console.log("모달이 열릴 때 schdlGroup 값 확인:", $("#schdlGroup").val());
        	
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
		    // 드롭된 이벤트의 extendedProps에서 memNo 가져오기
		    var droppedEventMemNo = info.event.extendedProps.memNo;
		
		    // 콘솔 로그 추가: 드롭된 이벤트의 memNo 확인
		    console.log('드롭된 이벤트 memNo:', droppedEventMemNo);
		    console.log('현재 사용자의 memNo:', ${member.memNo});
		
		    // 드롭된 이벤트의 memNo와 현재 사용자의 memNo 비교
		    if (droppedEventMemNo !== ${member.memNo}) {
		        console.log('이벤트 드롭이 허용되지 않습니다. 사용자의 memNo와 다릅니다.');
		        // 드롭된 위치로의 이동을 원래 위치로 되돌리기
		        info.revert(); // 드롭을 취소하고 원래 위치로 되돌림
		        return; // 추가 로직 실행 방지
		    }
		
		    console.log('드롭된 이벤트의 extendedProps:', info.event.extendedProps);
		    var schdlContent = info.event.extendedProps.schdlContent || "";
		    var schdlPlace = info.event.extendedProps.schdlPlace || "";
		    var memNo = info.event.extendedProps.memNo || "";
		
		    console.log('이벤트가 드롭되었습니다:', info.event);
		    saveEvent({
		        id: info.event.id,
		        title: info.event.title,
		        start: info.event.startStr.substring(0, info.event.startStr.indexOf("T")),
		        end: info.event.endStr.substring(0, info.event.endStr.indexOf("T")),
		        schdlContent: schdlContent,
		        schdlPlace: schdlPlace,
		        memNo: memNo
		    });
		},

        eventDidMount: function(info) {
            // description 속성이 존재할 때만 Tooltip 생성
            if (info.event.extendedProps.description) {
            	console.log('이벤트에 대한 tooltip 생성:', info.event.title);
            	
           	  tippy(info.el, {
           		content: info.event.extendedProps.description,
           	    placement: "bottom",
           	    offset: [0, 0],
           	    interactive: true,
           	    maxWidth: "300px", // 툴팁의 최대 너비 설정
           	    theme: "custom",
           	 	animation: "fade"
           		  })
            }
        }
        
    });
//     calendar.render();
	mainList();
//     fetchEvents(); // 전체를 가져옴
}); 

function saveEvent(event) {
	
	console.log("## saveEvent function ::" , event);
	
	var eventObject = {
		schdlNo : event.id,
		schdlName: event.title.replace(event.deptNo + "팀) ", ""),
		startDate : event.start,
		endDate : event.end,
		schdlGroup: event.schdlGroup,
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
            calendar.refetchEvents();
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


/* 처음 캘린더 랜더링 될때 (내 일정 표시) */
function mainList() {
    var memNo = ${member.memNo};
    $.ajax({
        url: '/calendar/getMain',
        method: 'GET',
        data: { memNo: memNo },
        success: function(data) {
            console.log("## detail success :", data);
            
            // 기존 이벤트를 모두 제거하고 새로운 이벤트를 캘린더에 추가
            calendar.getEvents().forEach(event => event.remove());
            
            // myEvents와 groupEvents를 각각 처리
            const myEventsY = data.myEventsY || []; // 공개 이벤트
            const myEventsN = data.myEventsN || []; // 비공개 이벤트
            const groupEventsY = data.groupEventsY || []; // 공개 그룹 이벤트
            
            // 개인일정 비공개 이벤트 추가
            myEventsN.forEach(event => {
            	let textColor = "#000000"; // 기본 검정색
                calendar.addEvent({
                    id: event.schdlNo,
                    title: event.schdlName,
                    start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
                    end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
                    textColor: textColor,
                    extendedProps: {
                        schdlPlace: event.schdlPlace,
                        schdlContent: event.schdlContent,
                        memNo: event.memNo,
                        schdlGroup: event.schdlGroup,
                        attendNo: event.attendNo,
                        description: `
                            ① 일정 내용 :　　　　　　　　　　　　
                                \${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
                            ② 장소 : \${event.schdlPlace}`
                    },
//                     classNames: ['bounce'], // 반짝임 효과 적용
                });
            });
            
            // 개인일정 공개 이벤트 추가
            myEventsY.forEach(event => {
            	let textColor = "#000000"; // 기본 검정색
			    calendar.addEvent({
			        id: event.schdlNo,
			        title: event.schdlName,
			        start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
			        end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
			        textColor: textColor,
			        extendedProps: {
			            schdlPlace: event.schdlPlace,
			            schdlContent: event.schdlContent,
			            memNo: event.memNo,
			            schdlGroup: event.schdlGroup,
			            attendNo: event.attendNo,
			            description: `
			                ① 일정 내용 :　　　　　　　　　　　　
			                    ${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
			                ② 장소 : ${event.schdlPlace}`
			        },
			        classNames: ['bounce'], // bounce 효과
			        backgroundColor: '#00ff00' // 바 색상 변경
			    });
			});

            // 공개 그룹 이벤트 추가
            groupEventsY.forEach(event => {
            	addCalendarEvent1(event);
            });

            calendar.render(); // 캘린더 리렌더링
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
/*  켈린더에 데이터를 받아오는 곳  (그룹 전체) */
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
				    backgroundColor = '#B3E5FC'; // 파스텔 하늘색
				    borderColor = '#B3E5FC';     // 파스텔 하늘색 테두리
				} else if (event.deptNo === 2) {
				    backgroundColor = '#A5D6A7'; // 파스텔 연두색
				    borderColor = '#81C784';     // 약간 짙은 파스텔 연두 테두리
				} else if (event.deptNo === 3) {
				    backgroundColor = '#FFCDD2'; // 파스텔 빨간색
				    borderColor = '#EF9A9A';     // 약간 짙은 파스텔 빨간 테두리
				} else if (event.deptNo === 4) {
				    backgroundColor = '#BBDEFB'; // 파스텔 파란색
				    borderColor = '#90CAF9';     // 약간 짙은 파스텔 파란 테두리
				} else if (event.deptNo === 5) {
				    backgroundColor = '#FFCC80'; // 파스텔 주황색
				    borderColor = '#FFB74D';     // 약간 짙은 파스텔 주황 테두리
				} else if (event.deptNo === 6) {
				    backgroundColor = '#C8E6C9'; // 파스텔 연두색
				    borderColor = '#A5D6A7';     // 약간 짙은 파스텔 연두 테두리
				    textColor = '#000000';       // 검정색 텍스트
				} else if (event.deptNo === 7) {
				    backgroundColor = '#FFF9C4'; // 파스텔 노란색
				    borderColor = '#FFF59D';     // 약간 짙은 파스텔 노란 테두리
				} else if (event.deptNo === 8) {
				    backgroundColor = '#D1C4E9'; // 파스텔 보라색
				    borderColor = '#B39DDB';     // 약간 짙은 파스텔 보라 테두리
				} else if (event.deptNo === 9) {
				    backgroundColor = '#F8BBD0'; // 파스텔 핑크색
				    borderColor = '#F48FB1';     // 약간 짙은 파스텔 핑크 테두리
				}

                calendar.addEvent({
                	id : event.schdlNo,
                    title: event.schdlName, // 일정 제목
                    start: event.startDate + (event.startTime ? 'T' + event.startTime : ''), // 일정 시작일
                    end: event.endDate + (event.endTime ? 'T' + event.endTime : ''), // 일정 종료일
                    backgroundColor: backgroundColor, // 조건에 따른 배경색
                    borderColor: borderColor, // 조건에 따른 테두리색
                    textColor: textColor, // 텍스트 색상 추가
//                     allDay : true,
                    
                    extendedProps: {
                        schdlPlace: event.schdlPlace,
                        schdlContent: event.schdlContent,
                        memNo: event.memNo,
                        schdlGroup: event.schdlGroup,
	                    description: `
	                    	① 일정 내용 :　　　　　　　　　　　　
	                    		\${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
            				② 장소 : \${event.schdlPlace}`
                    },
                    classNames: ['bounce']
                   
                });
            });
            calendar.render();		/* 페이지 시작 calendar 랜더링.... */
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


/* 체크박스(비공개) 체크 시 모달 생성 */
$(function() {
    var secret = $("#scret");
    var schdlOpenValue = "Y";

    // 체크박스 상태 변경 시 동작
    secret.on("change", function() {
        var schdlGroupValue = $("#schdlGroup1").val(); // schdlGroup의 값을 가져옴
        console.log("schdlGroupValue:", schdlGroupValue);
        
        if ($(this).is(":checked")) {
            if (schdlGroupValue === "my") {
                schdlOpenValue = "N";
                console.log("SCHDL_OPEN 값을 'N'으로 변경했습니다.");
            } else {
                $(this).prop("checked", false);
                schdlOpenValue = "Y"; // 기본값으로 되돌림
                console.log("체크박스를 체크할 수 없습니다. 'my'로 설정된 경우에만 가능합니다.");
                Swal.fire({
                	title: "비공개 설정 불가",
                    html: "비공개는 참석자 그룹을<br> '나의 일정'으로선택해야 설정 가능합니다.",
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        } else {
            schdlOpenValue = "Y";
            console.log("SCHDL_OPEN 값을 'Y'로 변경했습니다.");
        }
    });

    // schdlGroup 변경 시 동작
    $("#schdlGroup1").on("change", function() {
        var newGroupValue = $(this).val();
        console.log("새로운 그룹 선택됨:", newGroupValue);

        if (secret.is(":checked") && newGroupValue !== "my") {
            // 선택한 그룹이 'my'가 아닐 경우 체크박스를 해제
            secret.prop("checked", false);
            schdlOpenValue = "Y"; // 기본값으로 되돌림
            console.log("체크박스를 체크할 수 없습니다. 'my'로 설정된 경우에만 가능합니다.");
            Swal.fire({
                title: "비공개 설정 불가",
                html: "비공개는 참석자 그룹을<br> '나의 일정'으로선택해야 설정 가능합니다.",
                icon: "error",
                confirmButtonText: "확인"
            });
        } else if (newGroupValue === "my") {
            // 그룹이 'my'로 변경되었을 때 체크박스를 체크 상태로 유지
            secret.prop("checked", true);
            schdlOpenValue = "N"; // 비공개 설정
            console.log("SCHDL_OPEN 값을 'N'으로 변경했습니다.");
        }
    });
});

function addEventToCalendar(event) {
	calendar.addEvent(event);
	
}

$(document).ready(function() {
    var message = sessionStorage.getItem("successMessage");
    if (message) {
        $("#alertDiv").text(message);
        $("#alertBox").show();
        
        setTimeout(function() {
            $("#alertBox").fadeOut("slow"); // 서서히 사라짐
        }, 1500); 
        
        sessionStorage.removeItem("successMessage"); // 메시지를 사용 후 삭제
    }
});

// $(document).ready(function() {
//     // 세션 스토리지에서 성공 메시지 확인
//     const successMessage = sessionStorage.getItem("successMessage");

//     if (successMessage) {
//         // 메시지가 있을 경우, 알림 표시
//         requiredAlert(successMessage);
        
//         // 메시지를 한 번 표시한 후 세션 스토리지에서 제거
//         sessionStorage.removeItem("successMessage");
//     }
// });

// function requiredAlert(comment) {
//     let alertBox = $('#alertBox');
//     $("#alertDiv").html(comment);

//     if (!isAlertVisible) {
//         isAlertVisible = true;
//         alertBox.css('display', "block");

//         setTimeout(function() {
//             alertBox.css('display', "none");
//             isAlertVisible = false;
//         }, 2000);
//     }
// }


</script>
