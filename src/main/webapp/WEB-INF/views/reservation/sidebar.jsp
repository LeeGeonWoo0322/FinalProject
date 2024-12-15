<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    
<!-- ===============================================-->
<!--    sidebar 시작    -->
<!-- ===============================================-->


<div class="navbar-vertical-content h-100 scrollbar border-end border-end-1" style="width: 250px;">
	<div class="flex-column" style="height: 120px">
		<div class="d-flex flex-row justify-content-between p-3">
			<h4 class="mb-0 p-1 ms-2">예약</h4>
		</div>
		<div style="text-align: center;">
			<a class="btn btn-outline-dark me-1 mb-1 px-6 py-2"  href="#" onclick="openReservationBtn()">예약하기</a>
		</div>
	</div>
	<div class="p-3" id="sidebar-content"">
		<ul class="mb-0 treeview" id="treeviewExample">
			<li class="treeview-list-item"><div class="treeview-row"></div>
				<p class="treeview-text">
					<a href="/reservation/main"><span style="color: #232e3c; font-weight: 500; font-size: 15px;">자산 예약 현황</span></a>
				</p>
			</li>
			<c:forEach items="${assetCategoryList}" var="assetCategory" varStatus="status">
			    <li class="treeview-list-item">
			        <p class="treeview-text">
			            <a data-bs-toggle="collapse" href="#treeviewExample-1-${assetCategory.acNo}" role="button" aria-expanded="false"> 
		                    <span style="color: #232e3c; font-weight: 500; font-size: 15px;">${assetCategory.acName}</span>
			            </a>
			        </p>    
			        <ul class="collapse treeview-list ps-1" id="treeviewExample-1-${assetCategory.acNo}" data-show="true">
			            <c:if test="${not empty assetListArray[status.index]}">
			                <c:forEach items="${assetListArray[status.index]}" var="asset">
			                    <li class="treeview-list-item">
			                        <div class="treeview-item">
			                            <p class="treeview-text">
			                                <a class="flex-1" href="/reservation/gridWeek?astNo=${asset.astNo}"> 
			                                    <span style="height: 20px">${asset.astName}</span> 
			                                </a>
			                            </p>
			                        </div>
			                    </li>
			                </c:forEach>
			            </c:if>
			        </ul>
			    </li>            
			</c:forEach>
		</ul>
	</div>
</div>

<script type="text/javascript">
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
</script>

<!-- ===============================================-->
<!--    sidebar 끝    -->
<!-- ===============================================-->