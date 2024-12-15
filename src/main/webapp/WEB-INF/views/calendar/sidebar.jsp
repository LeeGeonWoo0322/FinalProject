<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>




</style>

<div class="scrollbar navbar-vertical-content h-100 border-end border-end-1 position-relative" style="width: 250px; overflow-y: auto;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">일정 관리</h4>
		</div>
		<div style="text-align: center;">
			<a class="btn border-dark me-1 mb-1 px-6 py-2" href="/calendar/register?posNo=${member.posNo}" id="registerBtn">일정등록</a>
		</div>
	</div>
 <!-- 사이드 메뉴 (content 영역에만 포함되는 사이드바) -->
   <div class="p-3 position-relative" id="sidebar-content">
          <ul class="mb-0 treeview" id="treeviewExample">
	          	<li class="treeview-list-item">
					<p class="treeview-text">
					    <sec:authentication property="principal.member" var="user"/> 
					    <a data-bs-toggle="collapse" href="#treeviewExample-1-2" role="button" aria-expanded="false" id="myGroupSchedule">
					    	<span style="color: black; font-weight: 500; font-size: 15px">내 그룹 휴가자</span>
					    </a>
					    <ul class="collapse treeview-list ps-1" id="treeviewExample-1-2" data-show="true">
					 		<div id="memberList"/>	<!-- 동적쿼리 삽입 부분 (그룹에 속한 memberList) -->
					    </ul>
					</p>
				</li>
				<li class="treeview-list-item mb-2">
					<p class="treeview-text">
						<a data-bs-toggle="collapse" href="#treeviewExample-1-3" role="button" aria-expanded="false">
							<span style="color: black; font-weight: 500; font-size: 15px">나의 캘린더</span>
						</a>
					</p>
					<ul class="collapse treeview-list ps-1" id="treeviewExample-1-3" data-show="true">
						<li class="treeview-list-item">
							<p class="treeview-text">
								<a class="flex-1" href="#" onclick="toggleCheckbox(event)"> 
									<span class="me-2 text-warning"></span>내 일정 (${member.deptNo}팀)<input type="checkbox" name="mySchedule" value="${member.memNo }" style="margin-left: 5px;" checked/>
								</a>
							</p>
							<ul class="collapse treeview-list ps-1" id="treeviewExample-1-4" data-show="true">
								<li class="treeview-list-item">
										<p class="treeview-text" style="display: inline-flex; align-items: center;">
											<a class="flex-1" href="#treeviewExample-1-5" data-bs-toggle="collapse" role="button" aria-expanded="false"> 
												<span class="me-2 text-warning"></span>그룹별일정
											</a>
											<input type="checkbox" name="groupAll" value="그룹일정" style="margin-left: 5px;"/>
										</p>

									<ul class="collapse treeview-list ps-1" id="treeviewExample-1-5" data-show="true">
										<li class="treeview-list-item" id="groupAddress">
											<!-- 그룹 연락처 동적 쿼리 -->
										</li>
									</ul>
								</li>
							</ul>
						</li>
					</ul>
	       		</li>
	        </ul>
		</div>
	</div>
<script type="text/javascript">

/* 비동기 - 동적방식 (사이드바 그룹 일정 리스트 - 내 그룹 휴가자) */
$(document).ready(function() {
	$("#myGroupSchedule").click(function(event) {
        event.preventDefault(); // 기본 링크 동작 방지
		
        var deptNo = ${member.deptNo};
        var depNoObject = { 
        			deptNo : deptNo 
        		};
        
        $.ajax({
            url: '/calendar/individualSched',
            type: 'POST',
            contentType : 'application/json',
            data : JSON.stringify(depNoObject),
            success: function(data) {
                // 서버에서 받은 데이터를 페이지에 동적으로 업데이트하는 코드
                console.log("## 비동기로 데이터 넘어옴!! ",data);
                
                $("#memberList").empty();
                
             	// '전체' 항목 추가
                var allItem = `
                    <li class="treeview-list-item">
                        <div class="treeview-item">
                            <p class="treeview-text">
                                <a class="flex-1" href="#!"> 
                                    <span style="height: 20px">전체</span> 
                                    <span style="height: 20px; padding-top: 5px">
                                        <input type="checkbox" style="margin-left: 10px;" id="allCk"/>
                                    </span>
                                </a>
                            </p>
                        </div>
                    </li>
                `;
                // '전체' 항목을 DOM에 추가
                $("#memberList").append(allItem);
                
            	// 받은 데이터(data)를 기반으로 새로운 리스트 생성 (for문 사용)
                for (var i = 0; i < data.length; i++) {
                    var dept = data[i];  // 각 객체를 변수에 할당
                    
                    var listItem = `
                        <li class="treeview-list-item">
                            <div class="treeview-item">
                                <p class="treeview-text">
                                    <a class="flex-1" href="#!"> 
                                        <span style="height: 20px">\${dept.memName}</span> 
                                        <span style="height: 20px; padding-top: 5px">
                                            <input type="checkbox" name="memName" value="\${dept.memName}" style="margin-left: 10px;"/>
                                        </span>
                                    </a>
                                </p>
                            </div>
                        </li>
                        `;
                    // 리스트 아이템을 DOM에 추가
                    $("#memberList").append(listItem);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청에 문제가 발생했습니다:', error);
            }
        });
    });
});

/* side checkbox 시작 */

/* ----------------- 그룹 멤버(휴가자) 리스트 checkbox 클릭 시 이벤트 --------------- */
$(document).ready(function() {
    let previousSelectedMemNames = []; // 이전 선택된 memName 배열 저장

    $(document).on('change', 'input[name="memName"]', function() {
        // 'memName' 이외의 다른 체크박스 해제
        $('input[type="checkbox"]').not('input[name="memName"]').prop('checked', false);

        // 현재 선택된 memName 값 배열 생성
        let selectedMemNames = $('input[name="memName"]:checked').map(function() {
            return $(this).val();
        }).get();

        // 모두 선택되었는지 여부 확인 후 allCk 갱신
        const allMemNamesChecked = $('input[name="memName"]').length === selectedMemNames.length;
        $('#allCk').prop('checked', allMemNamesChecked);

        // 현재 선택 상태와 이전 선택 상태 비교
        if (JSON.stringify(previousSelectedMemNames) !== JSON.stringify(selectedMemNames)) {
            previousSelectedMemNames = selectedMemNames; // 상태 갱신
            
            // 선택된 memName 값이 있을 경우 서버에 데이터 전송
            if (selectedMemNames.length > 0) {
                fetchEventsForMembers({ memNames: selectedMemNames });
            } else {
                // 선택된 체크박스가 없으면 캘린더의 모든 이벤트 삭제
                calendar.getEvents().forEach(event => event.remove());
            }
        }
    });
    
 	// id="allCk" 체크박스 변경 이벤트 (동적일때 - 문서 전체에서 #allCk 요소의 change 이벤트가 발생할 때 이 함수가 실행)
 	/* $(document).on(...) 구문을 사용하면 #allCk 체크박스가 동적으로 생성되어도 이벤트가 정상적으로 작동 */
    $(document).on('change', '#allCk', function() {
        const isChecked = $(this).is(':checked');

        // allCk가 체크되면 모든 memName 체크박스 체크, 아니면 모두 해제
        $('input[name="memName"]').prop('checked', isChecked);

        // 모든 memName 체크박스 변경 시 이벤트 트리거
        $('input[name="memName"]').trigger('change');
    });
});

/* -------------------- 그룹별 일정 (전체) --------------------- */

$('input[name="groupAll"]').change(function() {
	let isChecked = $(this).is(':checked');  // 'groupAll' 체크박스가 체크되었는지 여부 확인
    
	if (isChecked) {
		
		 // 모든 다른 체크박스 해제
        $('input[type="checkbox"]').not(this).prop('checked', false); 
        
     	// 모든 기존 이벤트 제거
        calendar.getEvents().forEach(function(event) {
            event.remove();  
        });
     	
        calendar.render();
        
    } else {
    	calendar.getEvents().forEach(function(event) {
            event.remove();  // 캘린더에서 이벤트 제거
        });
    }
});

/* ------------------ 체크박스 이벤트 List (휴가자 이벤트) ------------------ */
function fetchEventsForMembers(requestData) {
	console.log("##e7e :" ,requestData);
	
	let selectedMemNames = $('input[name="memName"]:checked').map(function() {
        return $(this).val();
    }).get();
	
    $.ajax({
        url: '/calendar/eventsForMembers', 
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(requestData), // 선택된 memName 배열을 JSON으로 변환하여 전송
        success: function(data) {
        	console.log("$$ 개인일정 :  ",data);
        	
        	const events = data.events || []; // 안전하게 배열을 설정
        	const vacationSchedules = data.vacationSchedules || []; // 안전하게 휴가 일정 배열을 설정
			        	
            // 기존 이벤트를 모두 제거하고 새로운 이벤트를 캘린더에 추가
            calendar.getEvents().forEach(event => event.remove());
            
            events.forEach(event => {
            	addCalendarEvent3(event);  // addCalendarEvent 함수 호출
            });
            
         	// 휴가 일정 추가
            vacationSchedules.forEach(schedule => {
                addVacationSchedule(schedule);  // addVacationSchedule 함수 호출
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

/* ------------------------------- 나의 일정 --------------------------------*/
// function fetchEventsForMe(requestData) {
// 	console.log("## 나의 스케줄 :" ,requestData);
//     $.ajax({
//         url: '/calendar/eventsForMe', 
//         method: 'POST',
//         contentType: 'application/json',
//         data: JSON.stringify(requestData), // 선택된 memNo 배열을 JSON으로 변환하여 전송
//         success: function(data) {
//         	console.log("$$ 나의 일정 ",data);
			        	
//             // 기존 이벤트를 모두 제거하고 새로운 이벤트를 캘린더에 추가
//             calendar.getEvents().forEach(event => event.remove());
            
//             data.forEach(event => {
//             	calendar.addEvent({
//                     id: event.schdlNo,
//                     title: event.schdlName,
//                     start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
//                     end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
//                     extendedProps: {
//                         schdlPlace: event.schdlPlace,
//                         schdlContent: event.schdlContent,
//                         memNo: event.memNo,
//                         schdlGroup: event.schdlGroup,
//                         attendNo: event.attendNo,
// 	                    description: `
// 	                    	① 일정 내용 :　　　　　　　　　　　　
// 	                    		\${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
//             				② 장소 : \${event.schdlPlace}`
//                     }
//                 });
//             });
//             calendar.render();
//         },
//         error: function(xhr, status, error) {
//             console.error("이벤트를 가져오는 데 실패했습니다.", {
//                 status: status,
//                 error: error,
//                 response: xhr.responseText
//             });
//         }
//     });
// }

// function fetchEventsForMe(requestData) {
//     console.log("## 나의 스케줄 :", requestData);
//     $.ajax({
//         url: '/calendar/eventsForMe', 
//         method: 'POST',
//         contentType: 'application/json',
//         data: JSON.stringify(requestData), // 선택된 memNo 배열을 JSON으로 변환하여 전송
//         success: function(data) {
//             console.log("$$ 나의 일정 ", data);
            
//             // 기존 이벤트를 모두 제거하고 새로운 이벤트를 캘린더에 추가
//             calendar.getEvents().forEach(event => event.remove());
            
//             // myEvents와 groupEvents를 각각 처리
//             const myEvents = data.myEvents; // 'myEvents' 배열 가져오기
//             const groupEvents = data.groupEvents; // 'groupEvents' 배열 가져오기
            
//             // myEvents 추가
//             myEvents.forEach(event => {
//                 calendar.addEvent({
//                     id: event.schdlNo,
//                     title: event.schdlName,
//                     start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
//                     end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
//                     extendedProps: {
//                         schdlPlace: event.schdlPlace,
//                         schdlContent: event.schdlContent,
//                         memNo: event.memNo,
//                         schdlGroup: event.schdlGroup,
//                         attendNo: event.attendNo,
//                         description: `
//                             ① 일정 내용 :　　　　　　　　　　　　
//                                 ${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
//                             ② 장소 : ${event.schdlPlace}`
//                     }
//                 });
//             });
            
            
//             if (myEventsY.length > 0) {
//                 const event = myEventsY[0]; // 첫 번째 이벤트 가져오기
//                 calendar.addEvent({
//                     id: event.schdlNo,
//                     title: `<span class="sparkle">${event.schdlName}</span>`, // sparkle 클래스 추가
//                     start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
//                     end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
//                     extendedProps: {
//                         schdlPlace: event.schdlPlace,
//                         schdlContent: event.schdlContent,
//                         memNo: event.memNo,
//                         schdlGroup: event.schdlGroup,
//                         attendNo: event.attendNo,
//                         description: `
//                             ① 일정 내용 :　　　　　　　　　　　　
//                                 ${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
//                             ② 장소 : ${event.schdlPlace}`
//                     }
//                 });
//             }

//             // groupEvents 추가 (필요에 따라 추가)
//             groupEvents.forEach(event => {
//             	addCalendarEvent(event);
//             });

//             calendar.render(); // 캘린더 리렌더링
//         },
//         error: function(xhr, status, error) {
//             console.error("이벤트를 가져오는 데 실패했습니다.", {
//                 status: status,
//                 error: error,
//                 response: xhr.responseText
//             });
//         }
//     });
// }



/* 캘린더 부서별 색상 이벤트 불러오기  */

function addCalendarEvent(event) {
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

    
    
    // 캘린더에 이벤트 추가
    calendar.addEvent({
        id: event.schdlNo,
        title: event.schdlName.startsWith(event.deptNo + "팀) ")
        ? event.schdlName
        : event.deptNo + "팀) " + event.schdlName,
        start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
        end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        textColor: textColor,
        extendedProps: {
            schdlPlace: event.schdlPlace,
            schdlContent: event.schdlContent,
            memNo: event.memNo,
            schdlGroup: event.schdlGroup,
            description: `
            	① 일정 내용 :　　　　　　　　　　　　
            		\${event.schdlContent} 　　　　　　　　　　　　　 　　　　　　　　　　　　　
				② 장소 : \${event.schdlPlace}`
        }
//         classNames: ['slide-in']
    });
}

/* 초기 화면에서 구릅 이벤트 */
function addCalendarEvent1(event) {
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

    // 캘린더에 이벤트 추가
    calendar.addEvent({
        id: event.schdlNo,
        title: event.schdlName.startsWith(event.deptNo + "팀) ")
        ? event.schdlName
        : event.deptNo + "팀) " + event.schdlName,
        start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
        end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        textColor: textColor,
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
//         classNames: ['bounce']
        
        
    });
}


/* 초기 화면에서 구릅 이벤트 33 */
function addCalendarEvent3(event) {
	
	let backgroundColor = '#4CAF50'; // 기본 색상 (연두색)
    let borderColor = '#388E3C'; // 기본 테두리색
    let textColor = "#000000"; // 기본 검정색
	
    // 캘린더에 이벤트 추가
    calendar.addEvent({
        id: event.schdlNo,
        title: event.schdlName,
        start: event.startDate + (event.startTime ? 'T' + event.startTime : ''),
        end: event.endDate + (event.endTime ? 'T' + event.endTime : ''),
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        textColor: textColor,
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
//         classNames: ['bounce'],
        backgroundColor: '#00ff00'
    });
}
/* -------------------- 휴가 승인 출력 event -------------------------- */

function addVacationSchedule(schedule) {
    // 기본 색상 및 스타일 설정
    let backgroundColor = '#FFA07A'; // 기본 색상 (연휴 색상)
    let borderColor = '#FF4500'; // 기본 테두리색
    let textColor = "#000000"; // 기본 검정색

    const endDate = new Date(schedule.endDate);
    endDate.setDate(endDate.getDate() + 1);		/* FullCalendar가 endDate를 UTC로 처리하면서, 로컬 시간과 UTC 시간 차이로 인해 원하는 날짜보다 짧게 이벤트가 표시 */
    endDate.setHours(23, 59, 59, 999); // 시간 설정 (23:59:59)
    
    console.log("원본 endDate:", schedule.endDate);
    console.log("수정된 endDate:", endDate.toISOString());
    
    // 캘린더에 휴가 일정 추가
    const event = calendar.addEvent({
        id: schedule.schdlNo || Date.now(), // 고유 ID 생성
        title: schedule.schdlName, // 기본 제목 설정
        start: schedule.startDate, // 시작 날짜
        end: endDate.toISOString(), // 종료 날짜
        allDay: true,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        textColor: textColor,
        extendedProps: {
            schdlContent: schedule.schdlContent,
            description: `
                연차 내용: \${schedule.schdlContent}
            `
        },
//         classNames: ['bounce']
    });
    
    console.log("추가된 이벤트:", event); // 추가된 이벤트 정보 확인
    
}


/* ------------------------------ 그룹 주소록 메뉴 항목 만듬 (dept별로) ------------------------------ */
$(function(){
	
	$.ajax({
		url : '/calendar/deptList',
		type : 'GET',
		success: function(data) {
            var groupAddress = $('#groupAddress');
            groupAddress.empty();  // 기존 내용을 비웁니다

            for (let i = 0; i < data.length; i++) {
                let dept = data[i];  // 각 부서 정보

                let liItem = `
                        <div class="treeview-item">
                            <p class="treeview-text">
                                <a class="deptList flex-1" href="#" id="\${dept.deptNo}" value="\${dept.deptNo}팀  \${dept.deptName}">
                                    <span style="height: 20px">
                                    	<input type="checkbox" class="deptCheckbox" />  \${dept.deptNo}팀  \${dept.deptName}
                                    </span>
                                </a>
                            </p>
                        </div>
                    `;
                // <ul>에 <li> 요소 추가
                groupAddress.append(liItem);
            }
        }
	});
});

/* ---------------------------- 그룹 별로 동적 쿼리로 출력 ------------------------------ */
const selectedDeptEvents = {};
let isInitialLoad = true;

$(function() {
	
	let groupAllChecked = false; // groupAll 상태 추적

    // <a> 태그 클릭 처리
    $("#groupAddress").on("click", ".deptList", function(e) {
        e.preventDefault(); // <a> 태그의 기본 동작을 막음

        // <a> 태그 내의 체크박스를 찾아 체크 상태를 토글
        let checkbox = $(this).find(".deptCheckbox");
        checkbox.prop("checked", !checkbox.prop("checked")); // 체크 상태 토글

        // 체크박스의 change 이벤트를 수동으로 트리거
        checkbox.trigger('change');
    });

    // 체크박스의 change 이벤트 처리
    $("#groupAddress").on("change", ".deptCheckbox", function() {
        let deptCheckbox = $(this);
        
     	// "내 일정"이 체크된 상태에서 deptList가 선택되면 해제
        if ($('input[name="mySchedule"]').is(":checked")) {
            $('input[name="mySchedule"]').prop("checked", false); // "내 일정" 체크 해제
            removeAllCalendarEvents(); // "내 일정"의 이벤트 제거
        }
        
        // 그룹 리스트 처리 함수 호출
        groupListFunction(deptCheckbox, "checkbox");
    });
    
    function groupListFunction(deptControl, type) {
        let deptCheckbox = null;
        let deptNo = null;
        if (type == "checkbox") {
            deptCheckbox = deptControl;
            deptNo = deptControl.closest(".deptList").attr("id");
        } else if (type == "deptList") {
            deptCheckbox = deptControl.find(".deptCheckbox");
            deptNo = deptControl.attr("id");
        }

        const depNoObject = { 
            deptNo: deptNo,
            schlGroup: "group"
        };

        // 부서 체크박스 상태에 따른 처리
        if (deptCheckbox.is(":checked")) {

            $.ajax({
                url: '/calendar/groupAddress',
                type: 'POST',
                data: JSON.stringify(depNoObject),
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    console.log("$$ 데이터 응답:", data);

                    if (isInitialLoad) {
                        removeAllCalendarEvents();
                        isInitialLoad = false;
                    }

                    selectedDeptEvents[deptNo] = data;
                    data.forEach(event => addCalendarEvent(event));
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
        } else {
            console.log("## 해제된 부서 번호:", deptNo);
            delete selectedDeptEvents[deptNo];
            removeAllCalendarEvents();

            // 남은 이벤트들만 다시 추가
            Object.values(selectedDeptEvents).forEach(events => {
                events.forEach(event => addCalendarEvent(event));
            });
            calendar.render();
        }

        // groupAll 체크 상태 업데이트
        const allChecked = $(".deptCheckbox").length === $(".deptCheckbox:checked").length;
        $('input[name="groupAll"]').prop("checked", allChecked);
    }

    let selectedDeptEvents = {}; // 변수 선언을 let으로 변경
    // groupAll 체크박스 변경 이벤트 =========================
    $('input[name="groupAll"]').change(function() {
        const isChecked = $(this).is(":checked");

        groupAllChecked = isChecked; // groupAll 체크 상태 추적

        if (isChecked) {
            // 모든 부서 체크
            $(".deptCheckbox").prop("checked", true);

            // 모든 부서의 이벤트를 로드
            $(".deptList").each(function() {
                const deptList = $(this);
                
                // 'bounce' 클래스가 없는 부서만 로드
                if (!deptList.hasClass('bounce')) {
                    groupListFunction(deptList, "deptList");
                }
            });

        } else {
            // 모든 부서 체크 해제
            $(".deptCheckbox").prop("checked", false);
            selectedDeptEvents = {};
            removeAllCalendarEvents(); // 전체 일정 제거
            calendar.render();
        }
    });
    
	/*------------------------- 내 일정 변경 이벤트 ---------------------------*/
    $('input[name="mySchedule"]').change(function() {
        let selectedMemNo = null;

        if ($(this).is(":checked")) {
        	 // 다른 체크박스들 체크 해제
        	 $('input[type="checkbox"]').not(this).prop('checked', false); 
             
          	 // 모든 기존 이벤트 제거
             calendar.getEvents().forEach(function(event) {
                 event.remove();  
             });
        	
            selectedMemNo = $(this).val();
            console.log("## 선택된 memNo2: " + selectedMemNo);

            // 선택된 memNo의 일정만 표시
            var requestData = { memNo: selectedMemNo };
//             fetchEventsForMe(requestData);
            mainList();

            
            $('input[name="mySchedule"]').not(this).prop("checked", false);
        } else {
            removeAllCalendarEvents(); // 체크 해제 시 모든 이벤트 제거
        }
        calendar.render();
    });
});

function toggleCheckbox(event) {
    // 클릭한 요소 내에 있는 체크박스를 찾아 체크 상태를 변경
    const checkbox = event.target.querySelector('input[type="checkbox"]');
    if (checkbox) {
        checkbox.checked = !checkbox.checked;  // 클릭 시 체크 상태 토글
        $(checkbox).change();  // 상태 변경 후 change 이벤트 트리거
    }
}

// 모든 캘린더 이벤트를 제거하는 함수
function removeAllCalendarEvents() {
    calendar.getEvents().forEach(event => event.remove());
}

/* side checkbox 종료 */
 </script>