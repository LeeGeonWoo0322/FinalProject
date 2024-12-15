<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
input[type="date"] {position : relative};
input[type="date"]::-webkit=clear-button,
input[type="date"]::-webkit-inner-spin-button {display:none;}
input[type="date"]::-webkit-calendar-picker-indicator {
      position : absolute;
      left : 0;
      top : 0;
      width : 100%;
      height : 100%;
      background : transparent;
      color : transparent;
      cursor : pointer;
}
#calMonth {
   border-width : 0;
   width : 130px;
   font-size: 20px;
   text-align: center;
}
</style>
    
<div class="d-flex flex-column p-3" style="flex: 1 0 auto;">
	<div>
		<h4>3층 회의실</h4>
	</div>
	
	<div class="d-flex flex-column">
		<h5>
			3층 회의실 이용 안내
		</h5>
		<div class="mt-3">
			대덕인재개발원 3층에 위치한 회의실입니다.<br>
			예약 후 이용바랍니다
		</div>
	</div>
	
	<div class="w-100" id="calendar"></div>
	
	<div>
		<h5>자산별 상세 정보</h5>
		<div>
			<table class="table table-bordered">
			
			</table>
		</div>
	</div>
</div>
<script src='${pageContext.request.contextPath }/resources/dist/index.global.js'></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	initialView: 'resourceTimeline',
    	height: 300,
		resourceAreaColumns: [
			{
			  field: 'fname',
			  headerContent: 'First Name',
			}
		],
		resources: [
			{
			  id: 'a',
			  fname: 'John',
			  width:'10%'
			},
			{
			  id: 'b',
			  fname: 'Jerry',
			  width:'10%'
			}
		 ]
    	
    });
    calendar.render();
	$(".fc-license-message").addClass("d-none")
});
</script>