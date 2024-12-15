<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 생성</title>
</head>
<body>
<div class="container mt-5">
    <h2>게시판 생성</h2>
    <form>
        <div class="form-group">
            <label for="title">* 게시판 제목</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>

        <div class="form-group">
            <label for="description">게시판 설명</label>
            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
        </div>

        <fieldset class="form-group">
            <legend>게시판 유형</legend>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="type" id="classic" value="클래식">
                <label class="form-check-label" for="classic">클래식 타입</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="type" id="album" value="앨범형">
                <label class="form-check-label" for="album">피드 타입</label>
            </div>
        </fieldset>

        <fieldset class="form-group">
            <legend>댓글 작성</legend>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="comments" id="allow" value="허용">
                <label class="form-check-label" for="allow">허용</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="comments" id="disallow" value="허용하지않음">
                <label class="form-check-label" for="disallow">허용하지 않음</label>
            </div>
        </fieldset>

        <div class="form-group">
            <label for="operators">운영자 추가</label>
            <input type="text" class="form-control" id="operators" name="operators">
        </div>

        <fieldset class="form-group">
            <legend>알림 기능</legend>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="notification" id="notification" checked>
                <label class="form-check-label" for="notification">새글이 등록되면 알림 받음</label>
            </div>
        </fieldset>

        <button type="submit" class="btn btn-primary">제출</button>
    </form>
</div>


</body>
</html>
