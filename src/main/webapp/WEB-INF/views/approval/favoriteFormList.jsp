<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자주쓰는 양식함</title>
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
            data-list='{"valueNames":["formNo","formCategory","formTitle"],"page":10,"pagination":true}'>
            <div>
				<h4 class="p-3 m-0 align-middel" id="categoryName">자주 쓰는 양식</h4>
			</div>
            <div class="card-body p-1">
                <div class="table-responsive scrollbar">
                    <!-- 검색창 -->
                    <div class="search-container p-3">
                        <input type="text" id="searchInput" placeholder="번호, 카테고리, 제목 검색..." />
                    </div>
                    <table class="table table-bordered table-striped fs-10 mb-0">
                        <thead class="bg-200">
                            <tr>
                                <th class="text-900 sort" data-sort="formNo">양식 번호</th>
                                <th class="text-900 sort" data-sort="formTitle">양식 제목</th>
                                <th class="text-900 sort" data-sort="formCategory">양식 카테고리</th>
                            </tr>
                        </thead>
                        <tbody class="list" id="table-contact-body">
                            <c:choose>
                                <c:when test="${empty favoriteFormList}">
                                    <tr>
                                        <td colspan="3">양식이 존재하지 않습니다</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${favoriteFormList}" var="form">
                                        <tr>
                                            <td class="formNo">${form.formNo}</td>
                                            <td class="formTitle">
                                                <a href="/approval/formDetail.do?formNo=${form.formNo}">
                                                    ${form.formTitle}
                                                </a>
                                            </td>
                                            <td class="formCategory">${form.formCategory}</td>
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
    </div>

    <script>
        $(document).ready(function() {
            const options = {
                valueNames: ['formNo', 'formCategory', 'formTitle'],
                page: 10,
                pagination: true
            };
            const contactList = new List('allContactTable', options);

            // 검색 기능
            $('#searchInput').on('input', function() {
                const searchTerm = $(this).val().toLowerCase();
                contactList.filter(function(item) {
                    return item.values().formNo.toLowerCase().includes(searchTerm) || 
                           item.values().formCategory.toLowerCase().includes(searchTerm) ||
                           item.values().formTitle.toLowerCase().includes(searchTerm);
                });
            });

            // 페이지네이션 번호 처리
            let paginationUl = $('.pagination');
            paginationUl.addClass('justify-content-center');

            // 페이지네이션 업데이트 함수
            function updatePagination(currentPage) {
                paginationUl.empty();
                let totalPages = Math.ceil(contactList.matchingItems.length / 10);
                let maxVisiblePages = 5;
                let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
                let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

                for (let i = startPage; i <= endPage; i++) {
                    let activeClass = (i === currentPage) ? 'active' : '';
                    paginationUl.append('<li class="page-item ' + activeClass + '"><a class="page" href="#" data-page="10" data-i="' + i + '">' + i + '</a></li>');
                }
            }

            updatePagination(1);

            paginationUl.on('click', 'a.page', function(e) {
                e.preventDefault();
                let selectedPage = parseInt($(this).attr('data-i'));
                contactList.show(selectedPage, 10);
                updatePagination(selectedPage);
            });
        });
    </script>
</body>
</html>
