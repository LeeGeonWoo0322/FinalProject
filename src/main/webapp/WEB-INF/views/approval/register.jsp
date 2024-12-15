<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card p-3 scrollbar" style="flex: 1 0 auto;">
	    <div id="alertBox" style="position: fixed; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1050; display: none;">
	        <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
	    </div>
	    <h4 class="mb-2">전자결재 등록</h4>
	
	    <div class="d-flex justify-content-end mb-3">
	        <button type="button" id="updateApprovalLine" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#approvalModal2">
	            <i class="bi bi-person-lines-fill"></i> 결재정보
	        </button>
            <button type="button" id="addBtn" class="btn btn-info me-2">등록</button>
            <button type="button" id="cancelBtn" class="btn btn-secondary">취소</button>
	    </div>
	
	    <form id="apprForm" class="dropzone dropzone-multiple p-0 d-flex border" action="/approval/registerApproval" method="post" enctype="multipart/form-data">
            <!-- 왼쪽 열: 텍스트 영역 -->
            <div class="w-75 p-3 border-end d-flex justify-content-center">
                <textarea rows="15" class="form-control" name="apprContent" id="apprContent">${approvalVO.apprContent }</textarea>
            </div>

            <!-- 오른쪽 열: 제목, 긴급 체크박스, 파일 선택 -->
            <div class="p-3" style="flex: 1 0 auto;">
                <label class="form-label" for="approvalTitle">문서 제목</label>
                <input class="form-control mb-3" id="approvalTitle" type="text" name="apprTitle" placeholder="문서 제목을 입력하세요" />

                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="apprImport" name="apprImport" />
                    <label class="form-check-label" for="apprImport">긴급</label>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="formFileMultiple">첨부파일</label>
                    <input class="form-control" id="formFileMultiple" name="fileList" type="file" multiple="multiple" />
                </div>
            </div>
	
	        <!-- 숨겨진 필드 -->
	        <input type="hidden" name="fileNo" id="fileNo" value="0">
	        <input type="hidden" name="apprId" value="${approvalVO.apprId}">
	        <input type="hidden" name="memNo" value="${approvalVO.memNo}">
	    </form>
	    <!-- 하단 버튼들 정렬 -->
	        
	</div>

	</div>

	<!-- 모달 -->
	<div class="modal fade" id="approvalModal2" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-md">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
				    <h5 class="modal-title" id="rejectReasonModalLabel">결재정보 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 모달 본문 -->
				<div class="modal-body">
					<div class="d-flex flex-row justify-content-center w-100">

						<!-- 직원 주소록 -->
						<div class="col-6 scrollbar" style="height: 311.95px">
							<h6>주소록</h6>
							<ul class="mb-1 treeview" id="memberList2">
							</ul>
						</div>

						<!-- 결재 라인, 참조, 열람 설정 -->
						<div class="col-6" id="approvalSettings2">
							<h6 class="mb-0 text-start" style="padding-left: 55px">결재라인</h6>
							<div class="d-flex mb-2">
								<div class="d-flex flex-column align-items-center">
									<button class="btn btn-outline-secondary mb-2 add-to-line content-btn"
										data-list="updateApprovalLineList" data-btn="memberList2">→</button>
									<button class="btn btn-outline-secondary remove-from-line content-btn"
										data-list="updateApprovalLineList" data-btn="memberList2">←</button>
								</div>
								<ul id="updateApprovalLineList" class="ms-2 overflow-x-auto border bg-200 w-100"></ul>
							</div>

							<h6 class="mb-0 text-start" style="padding-left: 55px">참조</h6>
							<div class="d-flex mb-2">
								<div class="d-flex flex-column align-items-center">
									<button class="btn btn-outline-secondary mb-2 add-to-line content-btn"
										data-list="updateReferenceList" data-btn="memberList2">→</button>
									<button class="btn btn-outline-secondary remove-from-line content-btn"
										data-list="updateReferenceList" data-btn="memberList2">←</button>
								</div>
								<ul id="updateReferenceList" class="ms-2 overflow-x-auto border bg-200 w-100"></ul>
							</div>

							<h6 class="mb-0 text-start" style="padding-left: 55px">열람</h6>
							<div class="d-flex mb-2">
								<div class="d-flex flex-column align-items-center">
									<button class="btn btn-outline-secondary mb-2 add-to-line content-btn"
										data-list="updateReadList" data-btn="memberList2">→</button>
									<button class="btn btn-outline-secondary remove-from-line content-btn"
										data-list="updateReadList" data-btn="memberList2">←</button>
								</div>
								<ul id="updateReadList" class="ms-2 overflow-x-auto border bg-200 w-100"></ul>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary"
						id="saveApprovalChanges">등록</button>
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
	    CKEDITOR.replace("apprContent", {
	        height: 891,
	        width: 840,
	        allowedContent: {
	            $1: { // 모든 태그를 허용
	                elements: CKEDITOR.dtd,
	                attributes: true, // 모든 속성을 허용
	                styles: true // 모든 스타일을 허용
	            }
	        }
	    });
	    let isAlertVisible = false;
	    let fileInput = $("#fileInput");
	    var apprId = $('input[name="apprId"]').val();
	    let tempDiv;
	    loadApprovalDetails();
	    let apprContent = $('#apprContent').val();
	    loadDeptAndMemData('memberList2');

	    
	    apprContent = apprContent
        .replace(/deptName/g, "${memberVO.deptName}")
        .replace(/regDate/g, "${approvalVO.regDate}")
        .replace(/apprId/g, "${approvalVO.apprId}")
        .replace(/memName/g, "${memberVO.memName}");
	    $('#apprContent').val(apprContent);


	
	 // 결재라인 정보 가져오기
	    let originalApprovalLine = [];
		let originalReferenceList = [];
		let originalReadList = [];
		
		$('#approvalModal2').on('shown.bs.modal', function() {
		    var apprId = $('input[name="apprId"]').val();

		    $.ajax({
		        url: '/approval/getApprovalLine',
		        type: 'GET',
		        data: { apprId: apprId },
		        success: function(response) {
		            console.log("getApprovalLine결과:", response);

		            originalApprovalLine = response;

		            var approvalList = $('#updateApprovalLineList');
		            approvalList.empty();  // 기존 리스트 비우기
		            response.forEach(function(member) {
		                approvalList.append(`
		                    <li class="treeview-list-item">
		                        <p class="flex-1 employee-item mb-1 text-start fs-10" href="#!" 
		                           data-member-name="\${member.memName}" 
		                           data-position="\${member.posName}" 
		                           data-agency-no="\${member.agencyNo}" 
		                           data-mem-no="\${member.memNo}">
		                            <span class="me-2 text-success"></span> \${member.memName} \${member.posName}
		                        </p>
		                    </li>
		                `);
		            });

		            $.ajax({
		                url: '/approval/getReferenceMemberList',
		                type: 'GET',
		                data: { apprId: apprId },
		                success: function(referenceResponse) {
		                    console.log("Reference Response:", referenceResponse);

		                    originalReferenceList = referenceResponse;

		                    var referenceList = $('#updateReferenceList');
		                    referenceList.empty();  // 기존 리스트 비우기
		                    referenceResponse.forEach(function(reference) {
		                        referenceList.append(`
		                            <li class="treeview-list-item">
		                                <p class="flex-1 employee-item mb-1 text-start fs-10" href="#!" 
		                                   data-member-name="\${reference.memName}"
		                                   data-position="\${reference.posName}" 
		                                   data-mem-no="\${reference.memNo}">
		                                    <span class="me-2 text-success"></span> \${reference.memName} \${reference.posName}
		                                </p>
		                            </li>
		                        `);
		                    });

		                    $.ajax({
		                        url: '/approval/getReadMemberList',
		                        type: 'GET',
		                        data: { apprId: apprId },
		                        success: function(readResponse) {
		                            console.log("Read Response:", readResponse);

		                            originalReadList = readResponse;

		                            var readList = $('#updateReadList');
		                            readList.empty();  // 기존 리스트 비우기
		                            readResponse.forEach(function(reader) {
		                                readList.append(`
		                                    <li class="treeview-list-item">
		                                        <p class="flex-1 employee-item mb-1 text-start fs-10" href="#!" 
		                                           data-member-name="\${reader.memName}" 
		                                           data-position="\${reader.posName}" 
		                                           data-mem-no="\${reader.memNo}">
		                                            <span class="me-2 text-success"></span> \${reader.memName} \${reader.posName}
		                                        </p>
		                                    </li>
		                                `);
		                            });
		                        },
		                        error: function(xhr, status, error) {
		                            console.error('Failed to fetch read members:', error);
		                        }
		                    });
		                },
		                error: function(xhr, status, error) {
		                    console.error('Failed to fetch reference members:', error);
		                }
		            });
		        },
		        error: function(xhr, status, error) {
		            console.error('Failed to fetch approval line:', error);
		        }
		    });

		    // 기존 이벤트 핸들러 제거 후 다시 바인딩
		    $('#saveApprovalChanges').off('click').on('click', function() {
		        var apprId = $('input[name="apprId"]').val();

		        // 결재라인 memNo 배열 생성
		        var approvalLine = '';
		        $('#updateApprovalLineList .employee-item').each(function() {
		            approvalLine += $(this).data('mem-no') + ','; // 쉼표로 구분된 memNo 추가
		        });
		        
		        approvalLine = approvalLine.slice(0, -1); // 마지막 쉼표 제거
		        console.log(approvalLine);

		        // 참조 리스트 memNo 배열 생성
		        var referenceList = '';
		        $('#updateReferenceList .employee-item').each(function() {
		            referenceList += $(this).data('mem-no') + ','; // 쉼표로 구분된 memNo 추가
		        });
		        
		        referenceList = referenceList.slice(0, -1); // 마지막 쉼표 제거
		        console.log(referenceList);

		        // 열람 리스트 memNo 배열 생성
		        var readList = '';
		        $('#updateReadList .employee-item').each(function() {
		            readList += $(this).data('mem-no') + ','; // 쉼표로 구분된 memNo 추가
		        });
		        
		        readList = readList.slice(0, -1); // 마지막 쉼표 제거
		        console.log(readList);

		        // 업데이트된 결재 정보를 서버에 전송
		        $.ajax({
		            url: '/approval/updateApprovalInfo',
		            type: 'POST',
		            data: {
		                apprId: apprId,
		                approvalLine: approvalLine,
		                referenceList: referenceList,
		                readList: readList
		            },
		            success: function(response) {
		                console.log("성공:", response);
		                loadApprovalDetails();
		                requiredAlert("결재라인 수정 성공",isAlertVisible);
		                $('#approvalModal2').modal('hide');
		            },
		            error: function(xhr, status, error) {
		                console.error('실패', error);
		            }
		        });
		    });
		});



	    // 등록 버튼 클릭 시 폼 제출
		$("#addBtn").on("click", function(event) {
		    event.preventDefault();
			
		    let approvalTitle = $('#approvalTitle').val();
		    if(!approvalTitle){
		    	requiredAlert("전자결재 제목을 입력해주세요",isAlertVisible);
		    	$('#approvalTitle').focus();
                return;
		    }
		    
		    var apprId = $('input[name="apprId"]').val();
		    var approvalLine = [];
		    const files = $('#formFileMultiple')[0].files;
		    if (files.length > 0) {
		        // FormData 객체 생성
		        const formData = new FormData();
		
		        // 파일 추가 (여러 개의 파일을 전송)
		        for (let i = 0; i < files.length; i++) {
		            formData.append('fileList', files[i]);
		        }
		
		        formData.append('fileCategory', '전자결재');
		        formData.append('memNo', ${memberVO.memNo});
		
		        // 파일 전송 AJAX 요청
		        $.ajax({
		            url: '/uploadAjax',
		            type: 'POST',
		            data: formData,
		            processData: false,
		            contentType: false,
		            dataType: 'text',
		            success: function(fileNo) {
		                console.log("파일 전송 성공, fileNo:", fileNo);
		                $('#fileNo').val(fileNo); // fileNo 값 설정
		
		                fetchApprovalLine(apprId, approvalLine);
		            },
		            error: function(error) {
		                console.error('파일 전송 중 오류 발생:', error);
		            }
		        });
		    } else {
		        // 파일이 없을 경우에도 승인 라인 호출
		        fetchApprovalLine(apprId, approvalLine);
		    }
		});
		
		// 승인 라인 호출을 위한 함수
		function fetchApprovalLine(apprId, approvalLine) {
		    $.ajax({
		        url: '/approval/getApprovalLine',
		        type: 'GET',
		        data: { apprId: apprId },
		        success: function(response) {
		            console.log("결재라인:", response);
		            originalApprovalLine = response;
		
		            var approvalList = $('#updateApprovalLineList');
		            approvalList.empty();  // 기존 리스트 비우기
		            response.forEach(function(member) {
		                approvalList.append(`
		                    <li class="treeview-list-item">
		                        <p class="flex-1 employee-item mb-1 text-start fs-10" href="#!" 
		                           data-member-name="\${member.memName}" 
		                           data-position="\${member.posName}" 
		                           data-agency-no="\${member.agencyNo}" 
		                           data-mem-no="\${member.memNo}">
		                            <span class="me-2 text-success"></span> \${member.memName} \${member.posName}
		                        </p>
		                    </li>
		                `);
		            });
		
		            $('#updateApprovalLineList .employee-item').each(function() {
		                let memNo = $(this).data('mem-no');
		                let agencyNo = $(this).data('agency-no');
		                console.log("memNo:", memNo, "agencyNo:", agencyNo);
		
		                if (agencyNo) {
		                    approvalLine.push(agencyNo);
		                } else {
		                    approvalLine.push(memNo);
		                }
		            });
		
		            let approvalLineString = approvalLine.join(',');
		            console.log("수정결재라인:", approvalLineString);
		
		            updateAgencyLine(apprId, approvalLineString);
		        },
		        error: function(xhr, status, error) {
		            console.error('Failed to fetch approval line:', error);
		        }
		    });
		}
		
		// 최종 승인 라인 업데이트를 위한 함수
		function updateAgencyLine(apprId, approvalLineString) {
		    $.ajax({
		        url: '/approval/updateAgencyLine',
		        type: 'POST',
		        data: {
		            apprId: apprId,
		            approvalLine: approvalLineString
		        },
		        success: function(response) {
		            console.log("성공:", response);
		            $("#apprForm").submit();
		        },
		        error: function(xhr, status, error) {
		            console.error('실패', error);
		        }
		    });
		}

		
		// 버튼 클릭 이벤트 연결
		$('.add-to-line').click(function () {
		    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
		    const btnId = $(this).data('btn');
		    
		    if ($(this).hasClass('content-btn')) {
		        addToLine(listId, btnId);
		    }
		    
		});
		
		$('.remove-from-line').click(function () {
		    const listId = $(this).data('list'); // 버튼에 지정된 리스트 ID 가져오기
		    
		    if ($(this).hasClass('content-btn')) {
		        removeFromLine(listId); // 직원 삭제
		    }
		});
	    
		function loadApprovalDetails() {
		    $.ajax({
		        url: '/approval/getApprovalLine',
		        type: 'GET',
		        data: { apprId: apprId },
		        success: function(response) {
		            console.log("결재라인 응답:", response);

		            if (response.length === 0) {
		            	requiredAlert("결재라인은 최소 한명 이상 등록해야합니다.",isAlertVisible);
		                return;
		            }
		            
		            let formContent = CKEDITOR.instances.apprContent.getData();
		            tempDiv = $('<div>').html(formContent);
		            let memberLine = tempDiv.find("#memberLine");
		            console.log("맴버라인:",memberLine);
		            if (memberLine.length > 0) {
		            	memberLine.html('');
		                // 결재 테이블 생성
		                var tableHtml = `
						    <table style="border-collapse: collapse; width: 300px;">
						        <tr>
						            <td rowspan="2" style="border: 1px solid black; text-align: center; width: 20px; font-size:16px">결재라인</td>
						            \${response.map(member => `
						                <td style="border: 1px solid black; text-align: center; height: 20px; font-size:16px">
						                	\${member.agencyNo > 0 ? '(代)'+member.agencyName : member.memName}
						                </td>
						            `).join('')}
						        </tr>
						        <tr>
						            \${response.map(() => `
						                <td style="border: 1px solid black; text-align: center; height: 60px; width: 60px; font-size:16px">직인</td>
						            `).join('')}
						        </tr>
						    </table>`;
						    
						    console.log("테이블html:"+tableHtml);
		                
		                memberLine.html(tableHtml);

		                // 참조자와 열람자 정보를 가져오기
		                loadReferenceAndReadList(tempDiv);
		            } else {
		                console.error('#memberLine 테이블을 찾을 수 없습니다.');
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error('결재라인 정보를 가져오는데 실패했습니다:', error);
		        }
		    });
		}

		// 참조자와 열람자 정보를 한번에 가져오는 함수
		function loadReferenceAndReadList(tempDiv) {
		    // 참조자 정보 가져오기
		    $.ajax({
		        url: '/approval/getReferenceMemberList',
		        type: 'GET',
		        data: { apprId: apprId },
		        success: function(referenceResponse) {
		            // 열람자 정보 가져오기
		            $.ajax({
		                url: '/approval/getReadMemberList',
		                type: 'GET',
		                data: { apprId: apprId },
		                success: function(readResponse) {
		                	let refRead = tempDiv.find("#refRead");
		                    // 참조자 텍스트 생성
		                    let referenceText = '참조: ' + 
		                        (referenceResponse.length > 0 
		                            ? referenceResponse.map(ref => ref.memName).join(', ')
		                            : '없음');

		                    // 열람자 텍스트 생성
		                    let readText = '열람: ' + 
		                        (readResponse.length > 0
		                            ? readResponse.map(reader => reader.memName).join(', ')
		                            : '없음');
		                    

		                    // 참조자와 열람자 정보를 div로 추가
		                    refRead.html(`
                                \${referenceText}<br>
                                \${readText}
		                    `);
		                    // CKEditor 내용 업데이트
		                    setTimeout(function() {
		                        CKEDITOR.instances.apprContent.setData(tempDiv.html());
		                        console.log("CKEditor 내용 업데이트 완료");
		                    }, 500);
		                },
		                error: function(xhr, status, error) {
		                    console.error('열람자 정보를 가져오는데 실패했습니다:', error);
		                }
		            });
		        },
		        error: function(xhr, status, error) {
		            console.error('참조자 정보를 가져오는데 실패했습니다:', error);
		        }
		    });
		}
	});
	function requiredAlert(comment, isAlertVisible) {
	    let alertBox = $('#alertBox');
	    $("#alertDiv").html(comment);
	    if (!isAlertVisible) { // 알림이 보이지 않을 때만 실행
	        isAlertVisible = true; // 알림을 표시 중임을 설정
	        alertBox.css('display', "block");
	        console.log("asdasd");
	        setTimeout(function() {
	            alertBox.css('display', "none");
	            isAlertVisible = false; // 알림이 사라진 후 플래그를 초기화
	        }, 2000);
	    }
	    return false;
	}
	
</script>

</html>
