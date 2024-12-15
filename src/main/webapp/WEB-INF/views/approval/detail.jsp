<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/jspdf@latest/dist/jspdf.umd.min.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<style type="text/css">
.a4-paper {
/*     width: 210mm; */
    height: 297mm;
    background-color: white;
/*     margin: 0 auto; */
/*     padding: 0; */
    overflow: hidden;
    border: 1px solid #000;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

#approvalContent {
    width: 100%; /* 부모 요소(a4-paper) 너비에 맞춤 */
    height: 100%; /* 부모 요소(a4-paper) 높이에 맞춤 */
    padding: 0; /* 내용물의 여백을 설정 */
    box-sizing: border-box; /* 여백(padding) 포함하여 크기 설정 */
    transform: scale(0.9);
}
/* 반려 카드 스타일 */
.rejection-card {
  background-color: #f8d7da; /* 연한 빨간색 배경 */
  border: 1px solid #dc3545; /* 빨간색 테두리 */
  border-radius: 8px;
  padding: 1em;
  width: 200px;
  max-width: 100%;
  height: 300px; /* 고정 높이 */
  overflow-y: auto; /* 스크롤바 추가 */
}

/* 반려자 정보 스타일 */
.rejection-info .rejection-header h5 {
  color: #dc3545;
  font-weight: bold;
}
.rejection-info .badge {
  font-size: 0.8rem;
  padding: 0.25em 0.5em;
}
.rejection-info .text-muted {
  font-size: 0.9rem;
}

/* 반려 사유 텍스트 스타일 */
.rejection-info .rejection-reason {
  font-size: 1rem;
  line-height: 1.4;
  border-left: 3px solid #dc3545; /* 반려 사유 텍스트 왼쪽 강조선 */
  padding-left: 10px;
}
</style>
</head>
<body>
	
	
	<div class="scrollbar d-flex flex-column w-100 ms-3">
	  <div class="card p-3">
	    <div>
	      <h4 class="align-middel mb-2" id="categoryName">${approvalVO.apprStatus} 결재 문서</h4>
	    </div>
        <div class="mb-3">
          <c:if test="${approvalVO.myOrder == approvalVO.apprOrder + 1 && approvalVO.apprStatus eq '진행중'}">
            <button id="agreeBtn" class="btn btn-primary">승인</button>
            <button id="returnBtn" class="btn btn-danger">반려</button>
          </c:if>
          <c:if test="${approvalVO.apprStatus eq '완료' }">
            <a class="btn-pdf btn p-1 border" id="previewBtn" onclick="generatePDF()"> 
              <span><i class="far fa-file-pdf fs-7"></i></span> <span>PDF로 다운로드</span>
            </a>
          </c:if>
          <c:if test="${memberVO.memNo == approvalVO.memNo && approvalVO.apprStatus eq '진행중'}">
            <button id="cancelBtn" class="btn btn-danger">회수</button>
          </c:if>
          <c:if test="${approvalVO.apprStatus eq '임시' || approvalVO.apprStatus eq '반려' && memberVO.memNo == approvalVO.memNo}">
            <button id="retryBtn" class="btn btn-info">재상신</button>
          </c:if>
          <c:if test="${approvalVO.myOrder == approvalVO.apprOrder + 1 && approvalVO.secNo <= memberVO.posNo && approvalVO.apprStatus eq '진행중'}">
            <button id="allAgreeBtn" class="btn btn-info">전결</button>
          </c:if>
        </div>          
	    <div class="d-flex flex-row w-100 border rounded-3">
		    <div style="width: 910px" class="d-flex justify-content-center p-3 border-end">
	          <div id="approvalContainer" class="d-flex w-100 justify-content-center">
	            <!-- 결재 내용 -->
				<div>
				  <div class="a4-paper w-100">
				    <div id="approvalContent">
				      ${approvalVO.apprContent}
				    </div>
				  </div>
				</div>
	          </div>
		    </div>
		    <div class="d-flex flex-column" style="flex: 1 0 auto;">
		    	<div class="p-3">
		            <label class="form-label" for="approvalTitle">문서 제목</label>
	                <input class="form-control mb-3" id="approvalTitle" type="text" name="apprTitle" readonly="readonly" value="${approvalVO.apprTitle }"/>
			    	<div id="approvalFiles">
			        	<!-- 첨부파일 위치 -->
			        </div>
		    	</div>
		    	<div class="p-3">
			    	<!-- 반려 카드 - 반려 상태일 경우만 표시 -->
		            <c:if test="${approvalVO.apprStatus eq '반려' }">
		                <div class="rejection-info">
		                  <div class="rejection-header d-flex align-items-center mb-2">
		                    <h5 class="m-0">반려 정보</h5>
		                    <span class="badge bg-danger ms-2">반려</span>
		                  </div>
		                  <p class="text-muted">
		                    <b>반려자:</b> ${approvalLineMemberVO.memName} 
		                    <span class="text-secondary">(${approvalLineMemberVO.posName}, ${approvalLineMemberVO.deptName})</span>
		                  </p>
		                  <div class="rejection-reason text-dark">
		                    반려 사유: ${approvalLineMemberVO.apprRsn}
		                  </div>
		                </div>
		            </c:if>
		    	</div>
		    </div>
	    </div>
	  </div>  
	</div>

	<form id="agree" method="POST" action="/approval/doApproval">
		<input type="hidden" name="apprId" value="${approvalVO.apprId}">
		<input type="hidden" name="apprStatus" id="apprStatusHidden" value="">
		<input type="hidden" name="apprContent" id="approvalContentHidden">
		<input type="hidden" name="apprRsn" id="rejectReasonHidden">
	</form>
	
	<form action="/approval/retryRegister" method="post" id="retryRegisterForm">
		<input type="hidden" name="apprId" value="${approvalVO.apprId }">
	</form>

	</div>
	
	<div class="modal fade" id="rejectReasonModal" tabindex="-1" aria-labelledby="rejectReasonModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rejectReasonModalLabel">반려 사유 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <textarea class="form-control" id="rejectReasonInput" rows="3" placeholder="반려 사유를 입력하세요"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger" id="confirmRejectBtn">반려하기</button>
      </div>
    </div>
  </div>
</div>


</body>
<script type="text/javascript">

$(document).ready(function() {
	let formNo= "${approvalVO.formNo}";
	let status = "${approvalVO.apprStatus}";
    if(formNo==22&&status=='완료'){
    	let senderMemNo="${approvalVO.memNo}";
    	let leaveType = $('select').eq(1).val();
		console.log("입장함");

        // 시작 기간과 종료 기간 가져오기
        let startPeriod = $('td:contains("시작 기간:")').next().text().trim(); // 시작 기간
        let endPeriod = $('td:contains("종료 기간:")').next().text().trim(); // 종료 기간
        let vacContent = $('td:contains("휴가 사유")').next().html().trim();
        // 결과 확인
        $.ajax({
	        url: '/approval/registerVct',
	        type: 'POST',
	        contentType: 'application/json',
	        dataType: 'text',
	        data: JSON.stringify({
	            vctTypeNo: leaveType,
	            memNo: senderMemNo,
	            vctCont: vacContent,
	            vctStart: startPeriod,
	            vctEnd: endPeriod,
	        }),
	        success: function(response) {
	        	console.log(response);
	        },
	        error: function(xhr, status, error) {
	            console.error('실패', error);
	        }
	    });
    }
    
});
	const fileNo = "${approvalVO.fileNo}";
	if(fileNo!=0){
		fileDetails(fileNo);
	}
	
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
	
	$("#agreeBtn").on('click', function() {
		
		Swal.fire({
			  title: "승인하시겠습니까?",
			  icon: "info",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네, 승인하겠습니다!",
			  cancelButtonText: "이전으로"
			}).then((result) => {
			  if (result.isConfirmed) {
				  var contextPath = '${pageContext.request.contextPath}';
				  $.ajax({
			            url: "/approval/getSeal",
			            type: "GET",
			            success: function(seal) {
			                console.log(seal);

			                let sealImagePath = (seal.selImg === '/resources/design/public/assets/img/seal/default.png') 
			                    ? contextPath + '/resources/design/public/assets/img/seal/default.png' 
			                    : contextPath + '/resources/upload' + seal.selImg;

			                $('td').filter(function() {
			                    return $(this).text().trim() === '직인';
			                }).first().html('<img src="' + sealImagePath + '" alt="직인" style="width: 50px; height: auto;">');
			                
			                let contentWithSeal = $('#approvalContent').html();
			                console.log(contentWithSeal);
			                $('#approvalContentHidden').val(contentWithSeal);

			                $('#agree').submit();
			            },
			            error: function(xhr, status, error) {
			                console.error("직인을 불러오는 중 오류 발생:", error);
			            }
			        });
			  }
			});
	});
    
    $("#returnBtn").on('click', function() {
        $('#rejectReasonModal').modal('show'); // 모달 열기
    });

    // 모달에서 '반려하기' 버튼 클릭 시 처리
    $("#confirmRejectBtn").on('click', function() {
        let rejectReason = $('#rejectReasonInput').val().trim(); // 입력한 반려 사유

        if (rejectReason === "") {
            requiredAlert("반려 사유를 입력해주세요.",isAlertVisible);
            return;
        }

        var contextPath = '${pageContext.request.contextPath}';

        // 직인 이미지 변경
        var sealCells = $('td').filter(function() {
	        return $(this).text().trim() === '직인';
	    });
	
	    sealCells.each(function(index) {
	        if (index === 0) {
	            $(this).html('<img src="' + contextPath + '/resources/design/public/assets/img/seal/return.png" alt="직인" style="width: 50px; height: auto;">');
	        } else {
	            $(this).text('반려').addClass('slash');
	        }
	    });
        var contentWithSeal = $('#approvalContent').html();
        $('#approvalContentHidden').val(contentWithSeal);
        $('#apprStatusHidden').val('반려');
        
        $('#rejectReasonHidden').val(rejectReason);

        // 폼 제출
        $('#agree').submit();

        // 모달 닫기
        $('#rejectReasonModal').modal('hide');
    });
    
    $("#cancelBtn").on('click', function() {
    	
    	Swal.fire({
			  title: "결재를 회수 하시겠습니까?",
			  icon: "info",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네, 회수하겠습니다!",
			  cancelButtonText: "이전으로"
			}).then((result) => {
			  if (result.isConfirmed) {
				  $("#memberLine").html("");
		    		$("#refRead").html("");
		    		console.log("${approvalVO.apprId}");
		    		console.log($('#approvalContent').html());
		    		let data = {
		    				apprId : "${approvalVO.apprId}",
		    				apprContent : $('#approvalContent').html(),
		    				apprStatus : '임시'
		    			}
		    		$.ajax({
		                url: "/approval/cancelAppr",
		                type: "post",
		                contentType: 'application/json; charset=utf-8',
		                data : JSON.stringify(data),
		                success: function(res) {
		                	requiredAlert("회수가 완료되었습니다. 해당 결재는 임시보관함으로 들어갑니다",isAlertVisible)
		                    location.href="/approval/detail.do?apprId=${approvalVO.apprId}";
		                },
		                error: function(xhr, status, error) {
		                    console.error("회수 중 오류 발생:", error);
		                }
		            });
			  }
			});
    });
    
    $('#retryBtn').on('click',function(){
    	$('#retryRegisterForm').submit();
    });
    
	$('#allAgreeBtn').on('click',function(){
		
		Swal.fire({
			  title: "전결처리를 하시겠습니까?",
			  icon: "info",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "네, 전결하겠습니다!",
			  cancelButtonText: "이전으로"
			}).then((result) => {
			  if (result.isConfirmed) {
		            let memberName = "${memberVO.memName}";
		            var contextPath = '${pageContext.request.contextPath}';

		            $('#memberLine tr:first td').each(function(index) {
		                if ($(this).text().trim() == memberName) {
		                	console.log($('#memberLine tr:last td').eq(index - 1).html());
		                    $('#memberLine tr:last td').eq(index - 1).html('<img src="' + contextPath +'/resources/design/public/assets/img/seal/allAgree.png" alt="직인" style="width: 50px; height: auto;">');
		                    return false;
		                }
		            });
		                 
		           	var sealCells = $('td').filter(function() {
		   	        	return $(this).text().trim() === '직인';
		   	    	});
		   	
		   	    	sealCells.each(function(index) {
		   	        	$(this).text('전결').addClass('slash');
		   	    	});
				
					var contentWithSeal = $('#approvalContent').html();
					console.log(contentWithSeal);
		            $('#approvalContentHidden').val(contentWithSeal);
		            $('#apprStatusHidden').val('완료');
		            $('#agree').submit();
			  }
			});
	});
	
	function fileDetails(fileNo) {
	    return axios.post('/chat/getFileDetails/' + fileNo) // 파일 세부정보를 가져오는 엔드포인트
	        .then(function(response) {
	            const fileDetails = response.data; // 파일 세부정보
	            console.log("파일 세부: "+fileDetails);
	            const fileDetailsHTML = "첨부파일 목록: "+
			            fileDetails.map(file => 
			                `<a href="/downloadFile.do?fileDetailNo=\${file.fileDetailNo}" download>\${file.fileOriginalname}</a>`
			            ).join(', ');
	            $('#approvalFiles').html(fileDetailsHTML);
	        })
	        .catch(function(error) {
	            console.error('파일 세부정보를 가져오는 중 오류 발생:', error);
	        });
	}
    
    async function generatePDF() {
    	const pdfName="${approvalVO.apprTitle}";
    	 const { jsPDF } = window.jspdf;
    	 const content = document.getElementById("approvalContent");
    	 const canvas = await html2canvas(content);
    	 const imgData = canvas.toDataURL('image/png');

    	 const pdf = new jsPDF();
    	 const imgWidth = 210;
    	 const pageHeight = pdf.internal.pageSize.height;
    	 const imgHeight = (canvas.height * imgWidth) / canvas.width;
    	 let heightLeft = imgHeight;
    	 let position = 0;
    	 pdf.addImage(imgData, 'PNG', 10, position, imgWidth, imgHeight);
    	 heightLeft -= pageHeight;
    	 while (heightLeft >= 0) { 
    	 	position = heightLeft - imgHeight; 
    	 	pdf.addPage(); 
    	 	pdf.addImage(imgData, 'PNG', 10, position, imgWidth, imgHeight); 
    	 	heightLeft -= pageHeight; 
    	 }
    	 pdf.save(pdfName+'.pdf'); 
    }
</script>
</html>