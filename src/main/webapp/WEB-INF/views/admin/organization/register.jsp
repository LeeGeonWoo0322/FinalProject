<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .tab-content {
        padding: 20px;
    }
	.table tr td{
		padding: 5px 10px;
	}
	.table tr th{
		padding: 5px 10px;
	}
	.nav-menu{
		display: flex;
		justify-content: space-around;
		align-items: center;
		height: 30px;
	}
	
	.nav-menu a{
		font-size: 16px;
		text-decoration: none;
		position: relative;
		cursor: pointer;
		color: #748194;
		font-weight: bold;
	}
	
	.nav-menu a::after{
		content: "";
		position: absolute;
		bottom: -4px;
		left: 50%;
		transform: translateX(-50%);
		width: 0;
		height: 2px;
		background: #2c7be5;
		transition: all .1s ease-out;
		color: #2c7be5;
	}
	
	.nav-menu a.active::after{
		width: 100%;
		color: #2c7be5;
	}
	.nav-menu a.active{
		color: #2c7be5;
	}
</style>

<div class="d-flex flex-column bg-100 w-100 p-3">
	<div>
		<span>조직관리</span>
		<h4>조직 일괄등록</h4>
	</div>
	<div class="card w-100" style="flex: 1 0 auto;">
		<div class="d-flex align-items-end ms-2" style="width: 25%;height: 60px">
			<nav class="nav-menu align-bottom d-gap gap-3">
		        <a href="#" class="active" data-target="position-system">직위체계</a>
		        <a href="#" data-target="department">부서</a>
		        <a href="#" data-target="member">직원</a>
			</nav>
		</div>
		<div class="tab-content" id="myTabContent">
			<!-- 직위체계 -->
		    <div class="optionContent d-none d-flex flex-column w-100" id="position-system" role="tabpanel" aria-labelledby="position-system-tab">
				<div class="d-flex flex-row mt-2 mb-4" style="width: 700px">
					<div class="d-flex flex-column w-50 justify-content-center">
						<button class="btn border border-800 rounded-2 p-2 mb-2" style="width: 300px;vertical-align: middle;">
							<img src="${pageContext.request.contextPath }/resources/icon/excel.png" style="width: 25px;height: 25px">
							<span style="font-size: 15px">샘플 양식 다운로드</span>
						</button>
						<span style="font-size: 14px">최초 등록 시, 샘플양식을 다운로드 후</span>
						<span style="font-size: 14px">형식에 맞게 내용을 수정하여 일괄등록할 수 있습니다.</span>
					</div>
					<div class="vr text-400 mx-4"></div>
					<div class="d-flex flex-column w-50 justify-content-center">
						<button class="btn border border-800 rounded-2 p-2 mb-2" style="width: 300px;vertical-align: middle;">
							<img src="${pageContext.request.contextPath }/resources/icon/excel.png" style="width: 25px;height: 25px">
							<span style="font-size: 15px">현재 설정 다운로드</span>
						</button>
						<span style="font-size: 14px">현재 설정되어 있는 직위체계 정보를 다운로드합니다.</span>
						<span style="font-size: 14px">다운로드 후 수정하여 일괄등록할 수 있습니다.</span>
					</div>
				</div>
				<div class="d-flex flex-column">
					<h5 class="fs-9">직위체계 일괄 등록</h5>
					<div class="d-felx flex-row">
						<button class="btn bg-200 my-2 me-2 py-1 px-2">파일 찾기</button>
						<button class="btn btn-info py-1 px-2">일괄등록</button>
					</div>
					<div>
						<span style="font-size: 14px">해당 엑셀 파일의 각 시트에 새로운 코드 추가 시 신규 정보를 생성하고,</span><br>
						<span style="font-size: 14px">이미 시스템에 등록된 코드의 내용을 추가/수정하면 기존 정보가 업데이트 됩니다.</span>
					</div>
				</div>
				<div class="d-flex flex-row justify-content-between mt-4 mb-2">
					<div>
						<h5 class="fs-9">일괄 등록 결과</h5>
						<span style="font-size: 14px">파일을 등록하면, 아래 화면에서 추가한 내용을 확인 및 정정할 수 있습니다.</span>				
					</div>
					<div class="d-flex align-items-end">
						<div class="search-box align-middle" action="#" method="get">
						    <div class="position-relative">
						        <input class="form-control search-input" type="text" value="" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/>
						        <span class="fas fa-search search-box-icon"></span>
						    </div>
						</div>
					</div>
				</div>
				<div>
					<table class="table table-bordered border-500 fs-9">
						<colgroup>
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
							<col width="11%">
						</colgroup>
						<thead>
							<tr>
								<th>상태</th>
								<th>엑셀시트명</th>
								<th><span style="color: red">*</span>코드</th>
								<th><span style="color: red">*</span>한글명</th>
								<th>영문명</th>
								<th>일문명</th>
								<th>중문 간체명</th>
								<th>중문 번체명</th>
								<th>베트남어명</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
		    </div>
			<!-- 부서 -->
		    <div class="optionContent d-flex flex-column w-100" id="department" role="tabpanel" aria-labelledby="department-tab">
				<div class="d-flex flex-row mt-2 mb-4" style="width: 700px">
					<div class="d-flex flex-column w-50 justify-content-center">
						<button class="btn border border-800 rounded-2 p-2 mb-2" style="width: 300px;vertical-align: middle;">
							<img src="${pageContext.request.contextPath }/resources/icon/excel.png" style="width: 25px;height: 25px">
							<span style="font-size: 15px">샘플 양식 다운로드</span>
						</button>
						<span style="font-size: 14px">최초 등록 시, 샘플양식을 다운로드 후</span>
						<span style="font-size: 14px">형식에 맞게 내용을 수정하여 일괄등록할 수 있습니다.</span>
					</div>
					<div class="vr text-400 mx-4"></div>
					<div class="d-flex flex-column w-50 justify-content-center">
						<button class="btn border border-800 rounded-2 p-2 mb-2" style="width: 300px;vertical-align: middle;">
							<img src="${pageContext.request.contextPath }/resources/icon/excel.png" style="width: 25px;height: 25px">
							<span style="font-size: 15px">현재 설정 다운로드</span>
						</button>
						<span style="font-size: 14px">현재 조직도에 설정되어 있는 부서 정보를 다운로드합니다.</span>
						<span style="font-size: 14px">다운로드 후 수정하여 일괄등록할 수 있습니다.</span>
					</div>
				</div>
				<div class="d-flex flex-column">
					<h5 class="fs-9">부서 일괄 등록</h5>
					<div class="d-felx flex-row">
						<button class="btn bg-200 my-2 me-2 py-1 px-2">파일 찾기</button>
						<button class="btn btn-info py-1 px-2">일괄등록</button>
					</div>
					<div>
						<span style="font-size: 14px">해당 엑셀 파일에 새로운 부서코드 추가 시 신규 부서 정보를 생성하고,</span><br>
						<span style="font-size: 14px">이미 시스템에 등록된 부서코드의 내용을 추가/수정하면 기존 부서 정보가 업데이트 됩니다.</span>
					</div>
				</div>
				<div class="d-flex flex-row justify-content-between mt-4 mb-2">
					<div>
						<h5 class="fs-9">일괄 등록 결과</h5>
						<span style="font-size: 14px">파일을 등록하면, 아래 화면에서 추가한 내용을 확인 및 정정할 수 있습니다.</span>				
					</div>
					<div class="d-flex align-items-end">
						<div class="search-box align-middle" action="#" method="get">
						    <div class="position-relative">
						        <input class="form-control search-input" type="text" value="" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/>
						        <span class="fas fa-search search-box-icon"></span>
						    </div>
						</div>
					</div>
				</div>
				<div>
					<table class="table table-bordered border-500 fs-9">
						<colgroup>
						
						</colgroup>
						<thead>
							<tr>

							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
		    </div>
			<!-- 멤버 -->
		    <div class="optionContent d-none d-flex flex-column w-100" id="member" role="tabpanel" aria-labelledby="member-tab">
				<div class="d-flex flex-row mt-2 mb-4" style="width: 700px">
					<div class="d-flex flex-column w-50 justify-content-center">
						<button class="btn border border-800 rounded-2 p-2 mb-2" style="width: 300px;vertical-align: middle;">
							<img src="${pageContext.request.contextPath }/resources/icon/excel.png" style="width: 25px;height: 25px">
							<span style="font-size: 15px">샘플 양식 다운로드</span>
						</button>
						<span style="font-size: 14px">최초 등록 시, 샘플양식을 다운로드 후</span>
						<span style="font-size: 14px">형식에 맞게 내용을 수정하여 일괄등록할 수 있습니다.</span>
					</div>
					<div class="vr text-400 mx-4"></div>
					<div class="d-flex flex-column w-50 justify-content-center">
						<button class="btn border border-800 rounded-2 p-2 mb-2" style="width: 300px;vertical-align: middle;">
							<img src="${pageContext.request.contextPath }/resources/icon/excel.png" style="width: 25px;height: 25px">
							<span style="font-size: 15px">현재 설정 다운로드</span>
						</button>
						<span style="font-size: 14px">현재 조직에 등록된 모든 멤버 정보를 다운로드 받습니다.</span>
						<span style="font-size: 14px">다운로드 후 수정하여 일괄등록할 수 있습니다.</span>
					</div>
				</div>
				<div class="d-flex flex-column">
					<h5 class="fs-9">직원 일괄 등록</h5>
					<div class="d-felx flex-row">
<!-- 						<form action="/admin/organization/upload" id="uploadForm" method="post" enctype="multipart/form-data"> -->
							<input class="btn bg-200 my-2 me-2 py-1 px-2" type="file" id="file" name="file" accept=".xlsx, .xls"/>
							<input class="btn btn-info py-1 px-2" id="addBtn" value="일괄등록" type="button">
<!-- 						</form> -->
					</div>
					<div>
						<span style="font-size: 14px">해당 엑셀 파일의 각 시트에 새로운 코드 추가 시 신규 정보를 생성하고,</span><br>
						<span style="font-size: 14px">이미 시스템에 등록된 코드의 내용을 추가/수정하면 기존 정보가 업데이트 됩니다.</span>
					</div>
				</div>
				
<!-- 				<div class="d-flex flex-row justify-content-between mt-4 mb-2"> -->
<!-- 					<div> -->
<!-- 						<h5 class="fs-9">일괄 등록 결과</h5> -->
<!-- 						<span style="font-size: 14px">파일을 등록하면, 아래 화면에서 추가한 내용을 확인 및 정정할 수 있습니다.</span>				 -->
<!-- 					</div> -->
<!-- 					<div class="d-flex align-items-end"> -->
<!-- 						<div class="search-box align-middle" action="#" method="get"> -->
<!-- 						    <div class="position-relative"> -->
<!-- 						        <input class="form-control search-input" type="text" value="" placeholder="Search..." name="searchWord" spellcheck="false" autocomplete="off"/> -->
<!-- 						        <span class="fas fa-search search-box-icon"></span> -->
<!-- 						    </div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div>
					<table class="table table-bordered border-500 fs-9">
						<colgroup>

						</colgroup>
						<thead>
							<tr>

							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
		    </div>
		</div>	
	</div>
	<div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
</div>
<script type="text/javascript">
$(function () {
    const links = $('.nav-menu a');
    const contents =$('.optionContent');
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

    links.on("click", function (event) {
        event.preventDefault(); // 기본 링크 동작 방지

        // 현재 활성화된 링크에서 active 클래스 제거
        links.removeClass("active");

        // 클릭한 링크에 active 클래스 추가
        $(this).addClass("active");

        const targetId = $(this).data('target');

        // 모든 content div 숨김
        contents.addClass("d-none");

        // 클릭한 링크와 관련된 div 표시
        const targetContent = $("#" + targetId);
        if (targetContent.length) {
            targetContent.removeClass("d-none");
        }
    });
    
    $("#file").on("change", function(){
    	console.log($("#file"));
	});
    
    $("#addBtn").on("click", function(){
    	var file = $("#file");
    	var files = $("#file")[0].files;
    	
    	if($("#file").val() == null || $("#file").val() == ""){
			alert("파일을 선택해주세요");
			return false;
		}
    	
    	 Swal.fire({
             title: "직원을 등록하시겠습니까",
             icon: "question",
             showCancelButton: true,
             confirmButtonColor: "#3085d6",
             cancelButtonColor: "#d33",
             confirmButtonText: "네, 등록하겠습니다",
             cancelButtonText: "이전으로"
         }).then((result) => {
    		let formData = new FormData();
    		formData.append("file", files[0]);
    		$.ajax({
    			url : "/admin/organization/insert",
    			type : "post",
    			data : formData,
    			dataType : "text",
    			processData : false,
    			contentType : false,
    			success : function(data){
    				console.log(data);
    				console.log("완료");
    				requiredAlert("직원 일괄등록 완료",isAlertVisible);
    			},
    			error:function(request, status, error){

    				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

    			}
    		});
    	});
    });
});
</script>
