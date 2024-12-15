<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.treeview-list-item.active, .selected  {
    background-color: #f0f8ff;
}
#dateInput {
    cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}
</style>

<!-- ===============================================-->
<!--    sidebar 시작    -->
<!-- ===============================================-->
<div class="navbar-vertical-content h-100 border-end border-end-1 position-relative" style="width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2 text-center" onclick=gotohome() style="cursor:pointer">프로젝트</h4>
		</div>
		<div style="text-align: center;">
			<a class="btn border-dark me-1 mb-1 px-5 py-2" href="#" data-bs-toggle="modal" data-bs-target="#modal-newProject">프로젝트 생성</a>
		</div>
	</div>
	<div class="p-3 position-relative" id="sidebar-content"">
	
		<ul class="mb-0 treeview" id="treeviewExample">
		  <li class="treeview-list-item">
		    <a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false">
		      <p class="treeview-text">
		        즐겨찾기</p>
		    </a>
		    <ul class="collapse treeview-list" id="treeviewExample-1-1" data-show="true">
              <div id="favorDiv">
              </div>
		    </ul>
		  </li>
		  <li class="treeview-list-item">
		    <a data-bs-toggle="collapse" href="#treeviewExample-2-1" role="button" aria-expanded="false">
		      <p class="treeview-text">
		        그룹 프로젝트</p>
		    </a>
		    <ul class="collapse treeview-list" id="treeviewExample-2-1" data-show="true">
              <div id="siderProDiv">
              </div>
		    </ul>
		  </li>
		</ul>
	</div>
</div>
<!-- ===============================================-->
<!--    sidebar 끝    -->
<!-- ===============================================-->
  <!-- 신규 프로젝트 생성 모달  ====================================  -->
 <div class="modal fade" id="modal-newProject" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="emptySpamModalHead" aria-hidden="true">
  <div class="modal-dialog modal-md mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="emptySpamModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="emptySpamModalHead">신규 프로젝트 생성</h4>
        </div>
		<div class="d-flex flex-column pt-3 ps-3 pe-3">
			<table class="mb-2">
				<tr>
					<th style="width: 50px;">제목</th>
					<td><input id="newProjectTitle" type="text" class="form-control form-control-sm w-50"></td>
				</tr>
				<tr>
					<th style="width: 50px;">마감일</th>
					<td><input type="date" class="form-control form-control-sm w-50" id="SidbarDateInput"></td>
				</tr>
			</table>
			<div class="d-flex flex-row border">
				<div class="border-end col-6" style="height: 300px">
					<div class="d-block scrollbar" style="height: 300px">
						<div class="bg-200 text-center" style="height: 30px">조직도</div>
						<ul class="mb-1 treeview p-2" id="memberList">
					        <li class="treeview-list-item">
					            <p class="treeview-text fw-bold">
					                <a data-bs-toggle="collapse" href="#memberList1" role="button" aria-expanded="false"> 
					                    재무부
					                </a>
					            </p>
								<ul class="collapse treeview-list" id="memberList1" data-show="false">
					                <li class="treeview-list-item">
					                    <div class="treeview-item" id="memberAddress">
				                            <a class="flex-1" href="#!" data-member-name="한승우" data-position="사원" data-mem-no="57">
						                        <p class="treeview-text">
					                                <span class="me-2 text-success"></span> 한승우 사원
						                        </p>
				                            </a>
					                    </div>
					                </li>
					                <li class="treeview-list-item">
					                    <div class="treeview-item" id="memberAddress"> 
				                            <a class="flex-1" href="#!" data-member-name="김하연" data-position="사원" data-mem-no="66">
						                        <p class="treeview-text">
					                                <span class="me-2 text-success"></span> 김하연 사원
						                        </p>
				                            </a>
					                    </div>
					                </li>
					            </ul>
					        </li>
					        <li class="treeview-list-item">
					            <p class="treeview-text fw-bold">
					                <a data-bs-toggle="collapse" href="#memberList2" role="button" aria-expanded="false"> 
					                    <span>인사부</span>
					                </a>
					            </p>
								<ul class="collapse treeview-list" id="memberList2" data-show="false">
					                <li class="treeview-list-item">
					                    <div class="treeview-item" id="memberAddress">
				                            <a class="flex-1" href="#!" data-member-name="이순신" data-position="사원" data-mem-no="57">
						                        <p class="treeview-text">
					                                <span class="me-2 text-success"></span> <span>이순신 사원</span>
						                        </p>
				                            </a>
					                    </div>
					                </li>
					                <li class="treeview-list-item">
					                    <div class="treeview-item" id="memberAddress">
				                            <a class="flex-1" href="#!" data-member-name="이영준" data-position="사원" data-mem-no="66">
						                        <p class="treeview-text">
					                                <span class="me-2 text-success"></span> <span>이영준 사원</span>
						                        </p>
				                            </a>
					                    </div>
					                </li>
					            </ul>
					        </li>
						</ul>
					</div>
				</div>
				<div class="col-6" style="height: 300px">
					<div class="d-block scrollbar" id="newProjectMemDiv" style="height: 300px">
						<div id="participants" class="bg-200 text-center" style="height: 30px">참가 인원</div>
						<div id="newProjectAddMemDiv" class='text-truncate p-2' style="font-size:15px;white-space:nowrap">
							김필거 사원<span id="cancelAddMemberBtn" style="cursor: pointer;margin-left: 5px;width:17px;height:17px"><i class="bi bi-x"></i></span>
					    	<input type="hidden" id="neWProjectMemberNo" value="8">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2 pe-3" style="height: 50px;">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-2" id="emptySpamConfirm"><div style="height: 30px;line-height: 30px">확인</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="emptySpamCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>

    <div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
			
<!-- 신규 프로젝트 생성 모달 끝 ====================================  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
function detailPaging(e){
	var workNoVal = $('#favorWork'+e).val();
	var projectNo = $('#favorWorkPro'+e).val();
	console.log("workNoVal"+workNoVal);
	
	 
	if(sessionStorage.getItem('workId')){
		let workId = sessionStorage.getItem('workId');
		let projectId = sessionStorage.getItem('projectId');
		sessionStorage.removeItem('workId')
		sessionStorage.removeItem('projectId')
	}
	sessionStorage.setItem('workId',workNoVal);
	sessionStorage.setItem('projectId',projectNo);
	
	location.href = "/project/projectDetail/"+projectNo
	
}


var txt = '';
var newProjectAddMemDiv = $('#newProjectAddMemDiv');

document.getElementById('SidbarDateInput').addEventListener('click', function() {
    this.showPicker(); // 입력 필드에 포커스가 가면 날짜 선택기를 표시
});
// 프로젝트 추가 ========================================
	
	var emptySpamConfirm = $('#emptySpamConfirm');
	var newProjectTitle = $('#newProjectTitle');
	
	

	$(document).on('click','#emptySpamConfirm',function(){
		
		if(newProjectTitle.val().trim() === '' && newProjectTitle == null){
			
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
		} else {
			
			var projectTitleVal = $('#newProjectTitle').val();
			var endDateVal = $('#SidbarDateInput').val();
			var paListVal = [];
			
			for (var i = 0; i < $('input[id^=neWProjectMemberNo]').length; i++) {
				paListVal.push($('input[id^=neWProjectMemberNo]').eq(i).val());					
			}
			
			var proDate = {
					
					projectTitle : projectTitleVal,
					endDate : endDateVal,
					proAList : paListVal
			};
			
			console.log(proDate);
			
			$.ajax({
				
				type : "post",
				url : "/project/insertProject",
				data : JSON.stringify(proDate),
				contentType: "application/json; charset=utf-8",
				success : function(response){
										
					window.location.href = `/project/projectDetail/\${response.proVO.projectNo}`
				}
				
			});
		}
	});
		
	
	 
	
// 프로젝트 추가  종료  ====================================



// 맴버 추가 ===========================================
	$("div[id^=memberAddress]").on('dblclick',function(e){
		var memNo = $(e.target).closest("a").data("mem-no");
		var memName = $(e.target).closest("a").data("member-name");
		var position = $(e.target).closest("a").data("position");
		var newProjectMemDiv = $('#newProjectMemDiv');
		var newProjectAddMemDiv = $('#newProjectAddMemDiv');
		
		// 중복 확인
		
		var duplication =  newProjectMemDiv.find('input[value='+ memNo +']').closest('#newProjectAddMemDiv')
		
		if(duplication.length > 0){
			duplication.remove();
		} else {
			txt = '';
			txt += `
						<div id="newProjectAddMemDiv" class='text-truncate p-2' style="font-size:15px;white-space:nowrap" >
							\${memName} \${position}<span id="cancelAddMemberBtn" style="cursor: pointer;margin-left: 5px;width:17px;height:17px"><i class="bi bi-x"></i></span>
					    	<input type="hidden" id="neWProjectMemberNo" value="\${memNo}">
						</div>
				`;
				
			$('#participants').after(txt);
		}
		
		
		
		
	});
	
	
// 맴버 추가  종료========================================

// 맴버 추가 취소 ========================================
	$(document).on('dblclick','#newProjectAddMemDiv',function(){
		$(this).remove();
	});
	
	$(document).on('click','#cancelAddMemberBtn',function(e){
		e.stopPropagation();
		$(this).closest('#newProjectAddMemDiv').remove();
	});
	
	var cancelAddMemberBtn = $('#cancelAddMemberBtn') 
	cancelAddMemberBtn.on('click',function(){
		$(this).closest(newProjectAddMemDiv).remove();
	});
	
	var newProjectAddMemDiv = $("#newProjectAddMemDiv");
	
	newProjectAddMemDiv.on('dblclick',function(){
		$(this).remove()
		
	});
	
// 맴버 추가 취소 종료 ========================================
	
	function gotohome(){
		location.href = "/project/projectHome"
	}
	
	
// 사이드바 값 넣기 ===========================================
	
$(document).ready(function(){
		var loginMem = $('#loginMem').val();
		var memberVO = {
				memNo : loginMem
		}
		console.log(memberVO)
		var favorDiv = $('#favorDiv');
		var siderProDiv = $('#siderProDiv');
		$.ajax({
	   	 	type : "post"
			, url : "/project/sider"
			,data : JSON.stringify(memberVO)
			,contentType :  "application/json; charset=utf-8"
		 	, success : function(re){
				 console.log(re)
				 var checkFavor = [];
				 if(re.sider && re.sider.length > 0) {
					 for (var i = 0; i < re.sider.length; i++) {
						if(re.sider[i].favorY === "Y" && re.sider[i].favorMem == re.loginMemNo){
							var favorTitle = re.sider[i].workTitle;
							if(checkFavor.indexOf(favorTitle) === -1 ) {
								checkFavor.push(favorTitle)
								txt = ''
								txt += `
									
								  <li class="treeview-list-item">
					                <div class="treeview-item">
					                  <a class="flex-1" onclick=detailPaging(\${re.sider[i].workNo}) >
					                    <p class="treeview-text">
					                    <span class="text-truncate" style="max-width: 200px;">\${favorTitle}</span> 
					                      	<input type="hidden" id="favorWork\${re.sider[i].workNo }" value="\${re.sider[i].workNo }">
					                      	<input type="hidden" id="favorWorkPro\${re.sider[i].workNo }" value="\${re.sider[i].projectNo }">
					                    </p>
					                  </a>
					                </div>
					              </li>
								
								`;
								 favorDiv.append(txt);
							}
						}
						
					}
				 } else {
					 txt = ``;
					 txt += `
						 <li class="treeview-list-item">
			                <div class="treeview-item">
			                  <a class="flex-1" href="#!">
			                    <p class="treeview-text">
			                      	즐겨찾기 항목이 없습니다.
			                    </p>
			                  </a>
			                </div>
			              </li>
					 `;
				 }
				

				 if(re.sider && re.sider.length > 0){
					 var uniqueProjects = re.sider.filter((item, index, self) =>
			       	 index === self.findIndex((t) => t.projectTitle === item.projectTitle)
			       	 );
					 for (var i = 0; i < uniqueProjects.length; i++) {
						txt +=``;
						txt += `
							<a class="flex-1" href="/project/projectDetail/\${uniqueProjects[i].projectNo}">
			              		<p class="treeview-text">
			              		<span class="text-truncate" style="max-width: 200px;"><h8>\${uniqueProjects[i].projectTitle}</h8></span>
									<input type="hidden" id="proNo" value="\${uniqueProjects[i].projectNo }">
			              		</p>
		              		</a>						
						`;
						 siderProDiv.html(txt)
					}
				 } else {
					txt = ``;
					txt +=`
	              		<p class="treeview-text">
	              			<h8>프로젝트가 없습니다.</h8>
	              		</p>
					`;
					 siderProDiv.html(txt)
				 }
				
			}
			
		});
		
	});
	
	
	
	
	
</script>
