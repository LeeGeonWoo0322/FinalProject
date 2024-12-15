<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<div>
		<h3>연차 데이터 초기화</h3>
		<span>데이터 초기화</span>
		<button class="btn btn-danger me-1 mb-1" type="button">연차 현황 데이터 삭제</button><br class='d-none d-xl-block d-xxl-none' />
		<p>* 반드시 확인해주시기 바랍니다<br>
		1. 데이터 초기화시 어쩌구 저쩌구<br>
		2. 어쩌구 저쩌구
		</p>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
$(function () {

})
</script>