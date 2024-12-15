<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="p-3" style="width: 90%;">
    <h3 class="mb-3">외부연락처 수정</h3>
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
		                	<c:if test="${not empty contactVO.conProfile }">
			                    <img id="profileImg" alt="" src="/upload${contactVO.conProfile }" style="width: 103px;height: 132px">
		                	</c:if>
		                	<c:if test="${empty contactVO.conProfile }">
			                    <img id="profileImg" alt="" src="${pageContext.request.contextPath }/resources/icon/default_profile.png" style="width: 103px;height: 132px">
		                	</c:if>
		                </div>
		                <input type="file" id="file" name="conProfileImg" class="d-none">
		            </td>
		            <th class="p-2 text-center align-middle">이름</th>
		            <td class="p-2"><input type="text" class="form-control form-control-sm" name="conName" value="${contactVO.conName }"></td>
		        </tr>
		        <tr>
		            <th class="p-2 text-center align-middle">이메일</th>
		            <td class="p-2"><input type="text" class="form-control form-control-sm" name="conEmail" value="${contactVO.conEmail }"></td>
		        </tr>
		        <tr>
		            <th class="p-2 text-center align-middle">전화번호</th>
		            <td class="p-2"><input type="text" class="form-control form-control-sm" name="conTel" value="${contactVO.conTel }"></td>
		        </tr>
		        <tr>
		        	<td class="p-2 d-flex justify-content-center"><label class="m-0 p-0" for="file"><a class="btn p-0" style="box-shadow: none">사진 수정</a></label></td>
		            <th class="p-2 text-center align-middle">주소록 선택</th>    
		            <td class="p-2">
		                <select class="form-select form-select-sm" id="abNo" name="abNo">
		                    <c:choose>
		                        <c:when test="${not empty address }">
		                            <c:forEach items="${address }" var="addr">
		                                <option value="${addr.abNo }" <c:if test="${addr.abNo eq contactVO.abNo }">selected</c:if>>${addr.abName }</option>
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
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conCom" value="${contactVO.conCom }"></td>
					<th class="text-center align-middle">부서</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conDept" value="${contactVO.conDept }"></td>
				</tr>		
				<tr>
					<th class="text-center align-middle">직위</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conPos" value="${contactVO.conPos }"></td>
					<th class="text-center align-middle">회사 전화번호</th>
					<td class="p-2"><input type="text" class="form-control form-control-sm" name="conComTel" value="${contactVO.conComTel }"></td>
				</tr>		
				<tr>
					<th class="text-center align-middle">메모</th>
					<td class="p-2" colspan="3">
						<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="conMemo" id="" cols="30" rows="5" wrap="hard">${contactVO.conMemo }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="d-flex flex-row justify-content-end w-50">
			<input type="button" class="btn btn-info me-2" id="addBtn" value="수정하기"/>
			<input type="button" class="btn btn-secondary" id="backBtn" value="이전"/>
		</div>
	</form>
	</div>
</div>