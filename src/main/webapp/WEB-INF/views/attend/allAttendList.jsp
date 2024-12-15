<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
	<input type="hidden" value="${member.memNo}" id="userNo">
	<input type="hidden" value="${member.memName}" id="userName">
	<div class="d-flex flex-column w-75 scrollbar" >
	<h2>전사 근태 현황</h2>
	<span><h2 align="center">2024-10</h2></span>
	<div id="useVacation" data-list='{"page":20,"pagination":true}'>
		  <div class="table-responsive scrollbar">
		    <table class="table table-bordered table-striped fs-10 mb-0">
		      <thead class="bg-200">
		        <tr>
		          <th class="text-900 sort">이름</th>
		          <th class="text-900 sort">누적 근무시간</th>
		          <th class="text-900 sort">1주</th>
		          <th class="text-900 sort">2주</th>
		          <th class="text-900 sort">3주</th>
		          <th class="text-900 sort">4주</th>
		          <th class="text-900 sort">5주</th>
		        </tr>
		      </thead>
		      <tbody class="list">
		        <tr>
		          <td class="name">
		          	Anna<br>
					부장<br>
					A근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">
		          	Homer<br>
					차장<br>
					A근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">
		          	Oscar<br>
					사원<br>
					A근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">E
		          	mily<br>
					대리<br>
					A근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">
		          	Jara<br>
					부장<br>
					A근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">
		          	Clark<br>
					부장<br>
					A근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">
		          	Jennifer<br>
					대리<br>
					B근무
		          </td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">Tony</td>
		         <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">Tom</td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">Michael</td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">Antony</td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">Raymond</td>
		          <td class="monthAttend">13h27m27s</td>
		          <td class="1Date">4h10m20s</td>
		          <td class="2Date">5h20m30s</td>
		          <td class="3Date">2h15m45s</td>
		          <td class="4Date">3h13m17s</td>
		          <td class="5Date">0h0m0s</td>
		        </tr>
		        <tr>
		          <td class="name">Marie</td>
		          <td class="email">경영</td>
		          <td class="age">연차</td>
		          <td class="useDate">2024-10-19 ~ 2024-10-21</td>
		          <td class="useVaca">3</td>
		          <td class="cont">그냥</td>
		        </tr>
		        <tr>
		          <td class="name">Cohen</td>
		          <td class="email">경영</td>
		          <td class="age">연차</td>
		          <td class="useDate">2024-10-19 ~ 2024-10-21</td>
		          <td class="useVaca">3</td>
		          <td class="cont">그냥</td>
		        </tr>
		        <tr>
		          <td class="name">Rowen</td>
		          <td class="email">경영</td>
		          <td class="age">연차</td>
		          <td class="useDate">2024-10-19 ~ 2024-10-21</td>
		          <td class="useVaca">3</td>
		          <td class="cont">그냥</td>
		        </tr>
		      </tbody>
		    </table>
		  </div>
		  
		  <!-- 페이징 -->
		  <div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
		    <ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"> </span></button>
		  </div>
	</div>
	</div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
<script type="text/javascript">
$(function () {

})
</script>