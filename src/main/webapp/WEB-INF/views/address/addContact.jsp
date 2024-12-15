<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="p-3" style="width: 90%;">
	<div class="d-flex flex-row">
	    <h3 class="mb-3">외부연락처 추가</h3>
	    <div class="ms-1">
		    <a class="btn btn-outline-info" id="autoBtn">자동완성</a>
	    </div>
	</div>
    <div id="calendar-container" style="padding-bottom: 0;">
	<form action="/address/addExContact" method="post" id="form" enctype="multipart/form-data">
		<table class="table table-bordered border-300 w-50">
		    <colgroup>
		        <col width="20%">
		        <col width="20%">
		        <col width="60%">
		    </colgroup>
		    <tbody>
		        <tr>
		            <td rowspan="3" class="text-center align-middle p-0">
		                <div style="width: 103px; height: 132px; display: inline-block; vertical-align: middle;">
		                    <img id="profileImg" alt="" src="${pageContext.request.contextPath }/resources/icon/default_profile.png" style="width: 103px;height: 132px">
		                </div>
		                <input type="file" id="file" name="conProfileImg" class="d-none">
		            </td>
		            <th class="p-2 text-center align-middle">이름</th>
		            <td class="p-2"><input type="text" class="form-control form-control-sm" name="conName"></td>
		        </tr>
		        <tr>
		            <th class="p-2 text-center align-middle">이메일</th>
		            <td class="p-2"><input type="text" class="form-control form-control-sm" name="conEmail"></td>
		        </tr>
		        <tr>
		            <th class="p-2 text-center align-middle">전화번호</th>
		            <td class="p-2"><input type="text" class="form-control form-control-sm" name="conTel"></td>
		        </tr>
		        <tr>
		        	<td class="p-2 d-flex justify-content-center"><label class="m-0 p-0" for="file"><a class="btn p-0" style="box-shadow: none">사진 등록</a></label></td>
		            <th class="p-2 text-center align-middle">주소록 선택</th>    
		            <td class="p-2">
		                <select class="form-select form-select-sm" id="abNo" name="abNo">
		                    <c:choose>
		                        <c:when test="${not empty address }">
		                            <c:forEach items="${address }" var="addr">
		                                <option value="${addr.abNo }">${addr.abName }</option>
		                            </c:forEach>
		                        </c:when>
		                    </c:choose>
		                </select>
		            </td>
		        </tr>
		    </tbody>
		</table>

		<table class="table table-bordered border-300 w-50">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th class="text-center align-middle">회사</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conCom"></td>
					<th class="text-center align-middle">부서</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conDept"> </td>
				</tr>		
				<tr>
					<th class="text-center align-middle">직위</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conPos"></td>
					<th class="text-center align-middle">회사 전화번호</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conComTel"></td>
				</tr>		
				<tr>
					<th class="text-center align-middle">메모</th>
					<td class="p-2" colspan="3"><textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="conMemo" id="" cols="30" rows="5" wrap="hard"></textarea></td>
				</tr>
			</tbody>
		</table>
		
		<div class="d-flex flex-row justify-content-end w-50">
			<input type="button" class="btn btn-info me-2" id="addBtn" value="등록하기"/>
			<input type="button" class="btn btn-secondary" id="backBtn" value="이전"/>
		</div>
	</form>
	</div>
</div>

<!-- =================== 모달 창 등록 ======================= -->

<!-- <div class="modal fade" id="eventModal1" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true"> -->
<!--     <div class="modal-dialog"> -->
<!--         <div class="modal-content"> -->
<!--             <div class="modal-header"> -->
<!--                 <h5 class="modal-title" id="eventModalLabel">주소록 추가</h5> -->
<!--                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!--             </div> -->
<%--                	<input type="hidden" name="memNo" id="memModalNo1" value="${memNo }" /> --%>
<!--            		<div class="modal-body"> -->
<!--                     <div class="mb-3"> -->
<!-- 	                    <p>주소록 -->
<!-- 							<input type="text" id="abModalName1" name="abName"> -->
<!-- 						</p> -->
<!-- 						<select id="abModalGb1" name="abGb"> -->
<!-- 						    <option value="중요">중요연락처</option> -->
<!-- 						    <option value="외부">외부연락처</option> -->
<!-- 						</select> -->
<!--                     </div> -->
<!--                     <input type="hidden" id="eventStart"> -->
<!--                     <input type="hidden" id="eventEnd"> -->
<!-- 	            </div> -->
<!-- 	            <div class="modal-footer"> -->
<!-- 	                <button type="button" class="btn btn-success" id="saveEventBtn1">추가하기</button> -->
<!-- 	                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button> -->
<!-- 	            </div> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->

<script type="text/javascript">
$(function(){
	let file = null;
	$("#file").on("change", function (event) {

		var files = event.target.files;
		file = files[0];
		
		if (!file) return;
		
		if (isImageFile(file)) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$("#profileImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(file);
		} else {
			$("#profileImg").attr("src", "");
		}
		
	});
	
	var backBtn = $("#backBtn");
	var addBtn = $("#addBtn");
	var form = $("#form");
	
	backBtn.on("click" , function(){
		window.history.back();
	});
	
	addBtn.on("click" , function(){
		// 선택된 주소록 번호를 가져옵니다.
        var selectedAbNo = $("#abNo").val();

        // 값이 없으면 경고를 표시합니다.
        if (!selectedAbNo) {
        	Swal.fire({
            	title: "주소록을 선택해 주세요",
                html: "주소록이 선택되지 않았습니다.<br> 등록된 외부주소록을 선택해 주세요.",
                icon: "warning",
                confirmButtonText: "확인"
            });
            return; // 경고 후 함수 종료
        }
		form.submit();
	});
});

$(function(){
	var addModalBtn1 = $("#addModalBtn1");
	
	addModalBtn1.on("click" , function(e){
		e.preventDefault();
		
		var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
        myModal.show();
	});
});

$(function(){
	let saveEventBtn1 = $("#saveEventBtn1");
	
	saveEventBtn1.on("click",function(){
		let memModalNo1 = $("#memModalNo1").val();
		let abModalName1 = $("#abModalName1").val();
		let abModalGb1 = $("#abModalGb1").val();
		
		console.log("memModalNo:", memModalNo1);
        console.log("abModalName:", abModalName1);
        console.log("abModalGb:", abModalGb1);
		
		let addressObject = {
				memNo : memModalNo1,
				abName : abModalName1,
				abGb : abModalGb1
		}
		$.ajax({
			url : "/address/addModalAddress",
			type : "POST",
			data : JSON.stringify(addressObject),
			contentType : "application/json; charset=utf-8",
			success: function(data) {
				console.log("## Modal 데이터가 넘어왔니??" , data);

				Swal.fire({
					  position: "center",
					  icon: "success",
					  title: "정상적으로 등록 되었습니다.",
					  showConfirmButton: false,
					  timer: 1500,
				}).then(() => {
			        window.location.href = "/address/main";  // 타이머 후 리다이렉트
			    });
			}
		});
	});
});

$(document).ready(function() {
    // '개인 연락처'에 마우스를 올리면 오른쪽으로 확장되는 dropend가 열리도록 설정
    $('.dropend').on('mouseenter', function() {
        $(this).find('.dropdown-menu').css({
            display: 'block',  // 드롭다운 메뉴를 표시
            position: 'absolute',
            top: 0,
            left: '100%',  // 오른쪽으로 드롭다운 확장
            marginTop: '-1px',
        });
    }).on('mouseleave', function() {
        $(this).find('.dropdown-menu').css('display', 'none');  // 마우스가 벗어나면 서브메뉴를 숨김
    });
});

$(document).ready(function() {
    // .addr-item 클래스를 가진 <a> 태그 클릭 시 이벤트 처리
    $(".addr-item").on("click", function(e) {
        e.preventDefault(); // 기본 동작 중단 (href 동작 중단)
        
        // 클릭한 <a> 태그의 data-ab-name 값을 가져옴
        var selectedName = $(this).data("ab-name");
        var selectedAbNo = $(this).data("ab-no");

        // 선택된 이름을 특정 input 태그에 설정
        $("#selectedAddressName").text(selectedName);
        $("#selectedAddressNo").val(selectedAbNo);
        
        if (selectedName) {
            $("#addressIcon").show();
        } else {
            $("#addressIcon").hide();
        }
        console.log("선택된 주소록 이름: " + selectedName);
    });
});

function isImageFile(file) {
	var ext = file.name.split(".").pop().toLowerCase();
	return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
}

$("#autoBtn").on('click', function () {
	$("input[name='conName']").val('김민수');
	$("input[name='conEmail']").val('rlaalstn@gmail.com');
	$("input[name='conTel']").val('010-4367-1479');
	$("input[name='conCom']").val('(주)이에스티소프트');
	$("input[name='conDept']").val('개발부');
	$("input[name='conPos']").val('대리');
	$("input[name='conComTel']").val('02-368-3295');
	$("textarea[name='conMemo']").val('주요 고객 관리 담당');
});
</script>
