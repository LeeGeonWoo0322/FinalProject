<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <style>

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
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
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
    </style>
</head>
<body>

<div class="container">
    <h3>총 게시판 수: 5개</h3>
    
    <input type="button" value="목록다운로드">
    <table>
        <thead>
            <tr>
                <th>제목</th>
                <th>소유부서</th>
                <th>전체유형</th>
                <th>상태</th>
                <th>게시물 개수</th>
                <th>생성일</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>사내공지</td>
                <td>-</td>
                <td>클래식</td>
                <td>정상</td>
                <td>37</td>
                <td>2024-09-23</td>
            </tr>
            <tr>
                <td>사내식단표</td>
                <td>-</td>
                <td>클래식</td>
                <td>정상</td>
                <td>34</td>
                <td>2024-09-23</td>
            </tr>
            <tr>
                <td>실적게시판</td>
                <td>-</td>
                <td>클래식</td>
                <td>중지</td>
                <td>1</td>
                <td>2024-09-23</td>
            </tr>
            <tr>
                <td>공모전</td>
                <td>-</td>
                <td>앨범형</td>
                <td>정상</td>
                <td>0</td>
                <td>2024-09-23</td>
            </tr>
            <tr>
                <td>행사활동</td>
                <td>-</td>
                <td>앨범형</td>
                <td>정상</td>
                <td>1</td>
                <td>2024-09-23</td>
            </tr>
        </tbody>
    </table>

    <div class="pagination">
        <button>이전</button>
        <span>1</span>
        <button>다음</button>
    </div>
</div>

</body>
</html>