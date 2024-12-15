<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex flex-column p-3" style="flex: 1 0 auto;">
    <h4>${assetVO.astName }</h4>
    <div class="w-100" id="calendar"></div>
</div>

<script src="${pageContext.request.contextPath}/resources/design/public/vendors/fullcalendar/index.global.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');
	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    locale: 'ko',
	    timeZone: 'local',
	    initialView: 'timeGridWeek',
	    themeSystem: 'bootstrap5',
	    height: '770px',
	    weekends: false,
	    editable: true,
	    selectable: true,
	    slotEventOverlap: false,
	    titleRangeSeparator: ' ~ ',
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: ''
	    },
	    datesSet: function(dateInfo) {
	      const startDate = dateInfo.start;
	      const endDate = new Date(dateInfo.end);
	      endDate.setDate(endDate.getDate() - 1); // 종료일을 토요일이 아닌 금요일로 설정

	      // 시작 날짜와 종료 날짜의 포맷을 'YYYY-MM-DD (요일)' 형식으로 변환
	      const formattedStartDate = `\${startDate.getFullYear()}-\${String(startDate.getMonth() + 1).padStart(2, '0')}-\${String(startDate.getDate()).padStart(2, '0')} (\${startDate.toLocaleDateString('ko-KR', { weekday: 'short' })})`;
	      const formattedEndDate = `\${endDate.getFullYear()}-\${String(endDate.getMonth() + 1).padStart(2, '0')}-\${String(endDate.getDate()).padStart(2, '0')} (\${endDate.toLocaleDateString('ko-KR', { weekday: 'short' })})`;

	      // title을 커스터마이징된 날짜 범위로 설정
	      document.querySelector('.fc-toolbar-title').textContent = `\${formattedStartDate} ~ \${formattedEndDate}`;
	    },
	    views: {
	        timeGridWeek: {
	          titleFormat: {
	            year: 'numeric',
	            month: '2-digit',
	            day: '2-digit'
	          },
	          dayHeaderFormat: { // 상단의 날짜 포맷을 'MM-DD (요일)'로 설정
	            month: '2-digit',
	            day: '2-digit',
	            weekday: 'short'
	          },
	          slotLabelFormat: {
	            hour: '2-digit',
	            minute: '2-digit',
	            hour12: false
	          }
	        }
	      },
	    slotMinTime: '${assetCategoryVO.acUseStart}',
	    slotMaxTime: '${assetCategoryVO.acUseEnd}',
	    allDaySlot: true,
	    nowIndicator: true,
	    now: new Date(),
	    events: "/reservation/getAssetReservationList.do?astNo="+${assetVO.astNo},
	  });
	  calendar.render();
	});

</script>
