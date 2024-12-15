<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결재 리스트</title>
</head>
<style>
.table-responsive table {
        table-layout: fixed;
        width: 100%;
    }
</style>
<body>
    <div class="d-flex flex-column w-100 ms-3">
        <div class="card p-2" id="allContactTable"  style="height: 100%;
            data-list='{"valueNames":["regDate","importYn","apprTitle","senderName","file","apprStatus"],"page":10,"pagination":true}'>
	    	<div>
				<h4 class="p-3 m-0 align-middel" id="categoryName">열람함</h4>
			</div>
            <div class="card-body p-1">
                <div class="table-responsive scrollbar">
                    <div class="search-container p-3">
                        <input type="text" id="searchInput" placeholder="제목, 기안자 검색..." />
                    </div>
                    <table class="table table-bordered table-striped fs-10 mb-0">
                        <thead class="bg-200">
                            <tr>
                                <th class="text-900 sort" data-sort="regDate">기안일</th>
                                <th class="text-900 sort" data-sort="importYn">긴급</th>
                                <th class="text-900 sort" data-sort="apprTitle">제목</th>
                                <th class="text-900 sort" data-sort="senderName">기안자</th>
                                <th class="text-900 sort" data-sort="file">첨부</th>
                                <th class="text-900 sort" data-sort="apprStatus">상태</th>
                            </tr>
                        </thead>
                        <tbody class="list" id="table-contact-body">
                            <c:choose>
                                <c:when test="${empty refApprList}">
                                    <tr>
                                        <td colspan="6">열람 문서가 존재하지 않습니다</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${readApprList}" var="approval">
                                        <tr>
                                            <td class="regDate">${approval.regDate}</td>
                                            <td class="importYn">
                                                <c:if test="${approval.apprImport == 'Y'}">
                                                    <span class="badge rounded-pill bg-danger">긴급</span>
                                                </c:if>
                                            </td>
                                            <td class="apprTitle">
                                                <a href="/approval/detail.do?apprId=${approval.apprId}">${approval.apprTitle}</a>
                                            </td>
                                            <td class="senderName">${approval.senderName}</td>
                                            <td class="file">
                                                <c:if test="${approval.fileNo != 0}">
                                                    <span class="far fa-file-alt"></span>
                                                </c:if>
                                            </td>
                                            <td class="apprStatus">
                                                <small class="badge rounded badge-subtle-success">${approval.apprStatus}</small>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
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
    </div>

    <script>
        $(document).ready(function() {
            const options = {
                valueNames: ['regDate', 'importYn', 'apprTitle', 'senderName', 'file', 'apprStatus'],
                page: 10,
                pagination: true
            };
            const contactList = new List('allContactTable', options);

            // 검색 기능
            $('#searchInput').on('input', function() {
                const searchTerm = $(this).val().toLowerCase();
                contactList.filter(function(item) {
                    return item.values().apprTitle.toLowerCase().includes(searchTerm) || 
                           item.values().senderName.toLowerCase().includes(searchTerm);
                });
            });
         // 페이지네이션 번호 처리
            let paginationUl = $('.pagination'); // pagination 클래스의 ul 태그
            paginationUl.addClass('justify-content-center');

            // 페이지네이션 업데이트 함수
            function updatePagination(currentPage) {
                paginationUl.empty(); // 기존 페이지네이션 제거

                let totalPages = Math.ceil(contactList.matchingItems.length / 10); // 총 페이지 수
                let maxVisiblePages = 5; // 한번에 보일 페이지 번호 수

                let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
                let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

                // 페이지 번호 추가
                for (let i = startPage; i <= endPage; i++) {
                    let activeClass = (i === currentPage) ? 'active' : '';
                    paginationUl.append('<li class="page-item ' + activeClass + '"><a class="page" href="#" data-page="10" data-i="' + i + '">' + i + '</a></li>');
                }
            }

            // 첫 페이지 로드 시 초기화
            updatePagination(1);

            // 페이지 번호 클릭 이벤트 처리
            paginationUl.on('click', 'a.page', function(e) {
                e.preventDefault();
                let selectedPage = parseInt($(this).attr('data-i'));
                contactList.show(selectedPage, 10); // 페이지 당 10개 항목 표시
                updatePagination(selectedPage); // 페이지네이션 업데이트
            });
        });
    </script>
</body>
</html>
