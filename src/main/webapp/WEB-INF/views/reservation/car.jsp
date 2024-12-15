<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>


<script src="${pageContext.request.contextPath}/resources/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
<link rel="style/sheet" href="${pageContext.request.contextPath}/resources/datetimepicker-master/build/jquery.datetimepicker.full.min.css"/>
<style>
#sidebar-content {
	height: calc(100% - 240px);
}
#tableExample2{
	height: calc(100% - 120px);
}
.table > :not(caption) > * > * {
	padding: 5px;
}
</style>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->


<div>

<%
    // URL 파라미터로 날짜를 받아옵니다.
    String dateParam = request.getParameter("date");
    Calendar calendar = Calendar.getInstance();

    if (dateParam != null) {
        // 파라미터가 있으면 해당 날짜로 설정
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = sdf.parse(dateParam);
            calendar.setTime(date);
        } catch (Exception e) {
            // 파싱 실패 시 현재 날짜로 설정
        }
    }

    // 버튼 클릭에 따라 날짜를 변경
    String action = request.getParameter("action");
    if ("next".equals(action)) {
        calendar.add(Calendar.DATE, 1); // 다음 날
    } else if ("prev".equals(action)) {
        calendar.add(Calendar.DATE, -1); // 전 날
    }

    // 현재 날짜를 포맷
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(calendar.getTime());
%>

<h3 class="text-center">차량예약</h3>

<textarea rows="5" class="form-control mb-3" readonly>
차량예약 이용사항 안내
- 이용안내 설명!
</textarea>

<div class="text-center mb-3">
    <!-- 날짜 이동 버튼 및 포맷된 날짜 출력 -->
    <form method="get" style="display: inline;">
        <input type="hidden" name="date" value="<%= formattedDate %>">
        <button type="submit" name="action" value="prev" class="btn btn-secondary">&lt;</button>
    </form>

    <span class="mx-2">오늘 날짜: <%= formattedDate %></span>

    <form method="get" style="display: inline;">
        <input type="hidden" name="date" value="<%= formattedDate %>">
        <button type="submit" name="action" value="next" class="btn btn-secondary">&gt;</button>
    </form>
</div>


<table class="table table-bordered"> 
    <tr> 
        <td>#</td>
        <td>00</td>
        <td>01</td>
        <td>02</td>
        <td>03</td>
        <td>04</td>
        <td>05</td>
        <td>06</td>
        <td>07</td>
        <td>08</td>
        <td>09</td>
        <td>10</td>
        <td>11</td>
        <td>12</td>
        <td>13</td>
        <td>14</td>
        <td>15</td>
        <td>16</td>
        <td>17</td>
        <td>18</td>
        <td>19</td>
        <td>20</td>
        <td>21</td>
        <td>22</td>
        <td>23</td>
    </tr>
    <tr> 
        <td>레이01</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr> 
        <td>레이02</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr> 
        <td>레이03</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
   
</table>

<br>
<h3> 자산별 상세 정보 </h3>

<table class="table table-bordered table-striped text-center"> 
    <thead class="thead-light">
        <tr>
            <th style="width: 70px;">항목</th> 
            <th style="width: 200px;">예약</th> 
            <th style="width: 200px;">설정</th> 
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>레이01</td> 
            <td><button class="btn btn-primary">예약</button></td> 
            <td><button class="btn btn-warning">설정</button></td> 
        </tr>
        <tr>
            <td>레이02</td> 
            <td><button class="btn btn-primary">예약</button></td> 
            <td><button class="btn btn-warning">설정</button></td> 
        </tr>
        <tr>
            <td>레이03</td> 
            <td><button class="btn btn-primary">예약</button></td> 
            <td><button class="btn btn-warning">설정</button></td> 
        </tr>

    </tbody>
</table>
	
</div>



<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->




