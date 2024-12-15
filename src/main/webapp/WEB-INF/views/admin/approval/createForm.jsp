<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재 양식</title>
<style>
    .container {
        display: flex;
        gap: 20px;
    }
    .sidebar {
        width: 200px;
        border: 1px solid #ccc;
        padding: 10px;
        overflow-y: auto;
        height: 600px;
    }
    .editor-container {
        display: flex;
        flex-grow: 1;
        flex-direction: row;
        gap: 20px;
    }
    .editor-controls {
        flex-direction: column;
        gap: 10px;
    }
    .sample-item {
        cursor: pointer;
        margin-bottom: 10px;
        padding: 5px;
        border: 1px solid #ddd;
    }
    .sample-item:hover {
        background-color: #f0f0f0;
    }
</style>
</head>
<body>
<c:set value="등록" var="name"/>
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="name"/>
</c:if>
<div class="container scrollbar">
    <div class="sidebar scrollbar h-100">
        <h3 align="center">양식</h3>
        <div class="sample-item" id="approvalInfo" data-content="approvalInfo">기안자 정보</div>
        <div class="sample-item" id="approvalLine" data-content="approvalLine">결재선</div>
    </div>
    
    <form action="/admin/approval/createForm" method="post" id="approvalForm">
    	<c:if test="${status eq 'u' }">
			<input type="hidden" name="formNo" value="${approvalFormVO.formNo }"/>
		</c:if>
        <div class="editor-container">
            <div class="editor-area p-3">
            	<label class="form-label" for="formContent">양식 내용</label>
                <textarea rows="15" cols="30" class="form-control" name="formContent" id="formContent">${approvalFormVO.formContent }</textarea>
            </div>

            <div class="editor-controls py-4 ps-5">
                <label class="form-label" for="formCategory">양식 대분류</label>
                <select class="form-select" id="formCategory" name="formCategory" aria-label="Default select example">
				    <option value="">양식 대분류를 선택해주세요</option>
				    <option value="교육" <c:if test="${approvalFormVO.formCategory == '교육'}">selected</c:if>>교육</option>
				    <option value="보고/시행문" <c:if test="${approvalFormVO.formCategory == '보고/시행문'}">selected</c:if>>보고/시행문</option>
				    <option value="인사" <c:if test="${approvalFormVO.formCategory == '인사'}">selected</c:if>>인사</option>
				    <option value="일반기안" <c:if test="${approvalFormVO.formCategory == '일반기안'}">selected</c:if>>일반기안</option>
				    <option value="지출결의서" <c:if test="${approvalFormVO.formCategory == '지출결의서'}">selected</c:if>>지출결의서</option>
				    <option value="출장" <c:if test="${approvalFormVO.formCategory == '출장'}">selected</c:if>>출장</option>
				    <option value="회계/총무" <c:if test="${approvalFormVO.formCategory == '회계/총무'}">selected</c:if>>회계/총무</option>
				    <option value="휴가" <c:if test="${approvalFormVO.formCategory == '휴가'}">selected</c:if>>휴가</option>
				    <option value="기타" <c:if test="${approvalFormVO.formCategory == '기타'}">selected</c:if>>기타</option>
				</select>
                
                <div class="mb-3">
                    <label class="form-label" for="formTitle">양식 이름</label>
                    <input class="form-control" id="formTitle" name="formTitle" type="text" value="${approvalFormVO.formTitle }" placeholder="양식이름을 작성해주세요" />
                </div>
                <button id="saveButton" class="btn btn-primary" type="button">${name }</button>
                <button id="listButton" class="btn btn-secondary" type="button">목록</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
$(document).ready(function() {
    // CKEditor 초기화
    CKEDITOR.replace("formContent", {
        height: 600,
        width: 840,
    });

    // 결재선 HTML 테이블 코드
    let approvalLineTable = `
        <table cellspacing="0" id="memberLine" style="border-collapse:collapse; float:right">
            <tbody>
                <tr>
                    <td rowspan="2" style="border-color:black; border-style:solid; border-width:1px; text-align:center; width:20px">결재라인</td>
                    <td style="border-color:black; border-style:solid; border-width:1px; height:20px; text-align:center">결재자</td>
                </tr>
                <tr>
                    <td style="border-color:black; border-style:solid; border-width:1px; height:60px; text-align:center; width:60px">직인</td>
                </tr>
            </tbody>
        </table>
    `;
    
    let approvalInfoTable = `
        <table class="__se_tbl" style="background: white; margin: 0px; border: 1px solid black; color: black; font-family: malgun gothic,dotum,arial,tahoma; font-size: 12px; border-collapse: collapse !important;">
            <tbody>
                <tr>
                    <td style="width: 100px; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: rgb(221, 221, 221); padding: 3px !important;">
                        기안자
                    </td>
                    <td style="width: 200px; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left; padding: 3px !important;">
                        memName
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
                        기안부서
                    </td>
                    <td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
                        deptName
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
                        기안일
                    </td>
                    <td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
                        regDate
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
                        문서번호
                    </td>
                    <td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
                        apprId
                    </td>
                </tr>
            </tbody>
        </table>
    `;

    // 결재선 더블 클릭 시 CKEditor에 HTML 테이블 삽입
    $('#approvalLine').on('dblclick', function() {
        var editor = CKEDITOR.instances.formContent;
        if (editor) {
            editor.insertHtml(approvalLineTable);
        }
    });
    
    $('#approvalInfo').on('dblclick', function() {
        var editor = CKEDITOR.instances.formContent;
        if (editor) {
            editor.insertHtml(approvalInfoTable);
        }
    });

    $('#saveButton').on('click', function() {
        var editorContent = CKEDITOR.instances.formContent.getData();
        $('#formContent').val(editorContent);
        if("${status}" == "u"){
			$('#approvalForm').attr("action", "/admin/approval/update.do");
			sessionStorage.setItem("updateForm", "updateForm");
		}
        $('#approvalForm').submit();
    });
    
    $('#listButton').on('click', function() {
    	location.href="/admin/approval/approvalFormList";
    });
});
</script>

</body>
</html>
