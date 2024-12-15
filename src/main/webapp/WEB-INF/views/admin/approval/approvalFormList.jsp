<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전자결재 양식함</title>
</head>
<style>
.table-responsive table {
        table-layout: fixed;
        width: 100%;
    }
</style>
<body>
    <div class="d-flex flex-column w-100 ms-3">
    <div id="alertBox" style="position: fixed; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1060;display: none;">
           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
   	</div>
	    <div class="p-2" id="allContactTable" style="height: 100%;" 
	         data-list='{"valueNames":["formNo","formTitle","formCategory", "regDate"],"page":10,"pagination":true}'>
	         
            <h4 class="m-0 py-2" id="categoryName">전자결재 양식함</h4>
	        <div class="d-flex justify-content-between align-items-center">
		          <div align="left">
		                <button type="button" id="newBtn2" class="btn btn-dark mb-2">등록</button>
		         </div>
	            <div class="search-box align-middle position-relative mb-1" data-bs-toggle="search" data-bs-display="static">
	                <input class="form-control search-input" type="search" placeholder="Search..." aria-label="Search" id="searchInput" name="searchWord"/>
	                <span class="fas fa-search search-box-icon"></span>
	            </div>
	        </div>
	        <div class="table-responsive scrollbar" style="height: 500px">
	            <table class="table table-bordered fs-10 mb-0">
	                <thead class="bg-200">
	                    <tr>
	                        <th class="text-900 sort" data-sort="formNo">양식 번호</th>
	                        <th class="text-900 sort" data-sort="formTitle">양식 제목</th>
	                        <th class="text-900 sort" data-sort="formCategory">양식 카테고리</th>
	                        <th class="text-900 sort" data-sort="regDate">등록일</th>
	                    </tr>
	                </thead>
	                <tbody class="list" id="table-contact-body">
	                    <c:choose>
	                        <c:when test="${empty approvalFormList}">
	                            <tr>
	                                <td colspan="4">양식이 존재하지 않습니다</td>
	                            </tr>
	                        </c:when>
	                        <c:otherwise>
	                            <c:forEach items="${approvalFormList}" var="form">
	                                <tr>
	                                    <td class="formNo">${form.formNo}</td>
	                                    <td class="formTitle">
	                                        <a href="/admin/approval/formDetail.do?formNo=${form.formNo}">
	                                            ${form.formTitle}
	                                        </a>
	                                    </td>
	                                    <td class="formCategory">${form.formCategory}</td>
	                                    <td class="regDate">${form.regDate}</td>
	                                </tr>
	                            </c:forEach>
	                        </c:otherwise>
	                    </c:choose>
	                </tbody>
	            </table>
	          
	        </div>
	
	        <!-- 페이지네이션 -->
	        <div class="d-flex justify-content-center mt-3">
	            <button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev">
	                <span class="fas fa-chevron-left"></span>
	            </button>
	            <ul class="pagination mb-0"></ul>
	            <button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next">
	                <span class="fas fa-chevron-right"></span>
	            </button>
	        </div>
	    </div>
	</div>


    
</body>
<script>
	$(document).ready(function() {
	    // 검색 기능
	    $('#searchInput').on('input', function() {
	        const searchTerm = $(this).val().toLowerCase();
	        contactList.search(searchTerm);
	    });
	
	    contactList.on('updated', function() {
	        updatePagination();
	        // 첫 페이지 데이터 표시
	        contactList.show(0, 10);
	    });
	
	    function updatePagination() {
	        let totalPages = Math.ceil(contactList.matchingItems.length / contactList.page);
	        console.log("전체페이지:" + totalPages);
	        let paginationUl = $(".pagination");
	        paginationUl.empty();
	
	        for (let i = 1; i <= totalPages; i++) {
	            let activeClass = (i === contactList.page) ? 'active' : '';
	            paginationUl.append(`<li class="page-item \${activeClass}"><button class="page-link" type="button" data-page="\${i}">\${i}</button></li>`);
	        }
	        
		    const options = {
			        valueNames: ['formNo', 'formCategory', 'formTitle', 'regDate'],
			        page: 10,
			        pagination: true
			    };
			    const contactList = new List('allContactTable', options);
	    }
	
	    // 페이지 번호 클릭 이벤트
	    $(".pagination").on('click', 'button.page-link', function(e) {
	        e.preventDefault();
	        let selectedPage = parseInt($(this).attr('data-page'));
	        contactList.show((selectedPage - 1) * 10, 10); // 선택된 페이지에 해당하는 항목 표시
	        updatePagination(); // 페이지 업데이트
	    });
	
	    $('#newBtn2').on('click', function() {
	    	console.log("click이벤트");
	        location.href = "/admin/approval/createForm";
	    });
	
	    // 알림 표시 여부
	    let alertYn = sessionStorage.getItem("updateForm");
	    if (alertYn) {
	        requiredAlert("수정이 완료되었습니다.", isAlertVisible);
	        sessionStorage.removeItem("updateForm");
	    }
	});
	
	function requiredAlert(comment, isAlertVisible) {
	    let alertBox = $('#alertBox');
	    $("#alertDiv").html(comment);
	    if (!isAlertVisible) {
	        isAlertVisible = true;
	        alertBox.css('display', "block");
	        setTimeout(function() {
	            alertBox.css('display', "none");
	            isAlertVisible = false;
	        }, 2000);
	    }
	    return false;
	}


</script>
</html>
