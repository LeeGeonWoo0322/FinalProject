<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>

    <style>
        .title {
            display: inline-block;
            margin-right: 20px; 
        }

        button {
            background-color: #00bcd4;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0097a7;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>기본 설정</h2>

    <div>
        <label>중지된 게시판 메뉴</label><br>
        <input type="radio" id="show" name="menu_visibility" value="show">
        <label for="show">보이기</label><br>
        <input type="radio" id="hide" name="menu_visibility" value="hide" checked>
        <label for="hide">숨기기</label>
    </div>

    <button>저장</button>
    <button>취소</button>
    <br>
    <br>

    <div style="margin-top: 20px;">

    </div>
    
    <input type="button" value="게시판 추가" onclick="location.href='/admin/board/create'">
    <input type="button" value="사용">
    <input type="button" value="중지">
    <input type="button" value="삭제">
    <table>
        <thead>
            <tr>
                <th>게시판 제목</th>
                <th>운영자</th>
                <th>상태</th>
                <th>설정</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input type="checkbox"> 사내공지</td>
                <td>홍길동</td>
                <td>사용중</td>
                <td><button id="btn">설정</button></td>
            </tr>
            <tr>
                <td><input type="checkbox"> 사내식단표</td>
                <td><br>홍길동</td>
                <td>사용중</td>
                <td><button onclick="location.href='/admin/board/modify'">설정</button></td>
            </tr>
            <tr>
                <td><input type="checkbox"> 실적게시판</td>
                <td><br>홍길동</td>
                <td>중지</td>
                <td><button onclick="location.href='/admin/board/modify'">설정</button></td>
            </tr>
            <tr>
                <td><input type="checkbox" > 공모전</td>
                <td><br>홍길동</td>
                <td>사용중</td>
                <td><button onclick="location.href='/admin/board/modify'">설정</button></td>
            </tr>
            <tr>
                <td><input type="checkbox" > 행사활동</td>
                <td><br>홍길동</td>
                <td>사용중</td>
                <td><button onclick="location.href='/admin/board/modify'">설정</button></td>
            </tr>
        </tbody>
    </table>
</div>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$("#btn").on('click', function() {
    console.log("버튼 클릭됨");
    location.href='/admin/board/modify';
});

</script>
</html>