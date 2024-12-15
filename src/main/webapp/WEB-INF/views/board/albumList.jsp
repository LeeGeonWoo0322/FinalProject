<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<style>

#sidebar-content{
	
}

.album-container {
	width: 100%;	
	display: flex;
	flex-direction: column;
	box-sizing: border-box;
}

#albumList{
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px;
	max-height: 100%;
}

.album-item{

 	width: 30%; 
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 5px;
	overflow: hidden;
	text-align: center;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
	margin-bottom: 15px;
}

.album-item img {
	max-width: 100%;
	height: auto;
}

.album-item:hover {
	box-shadow: 0 8px 16px 0 rgba(0,0,0,0.3);
}

.album-title {
	font-weight: bold;
	margin-top: 10px;
}

.album-info {
	color: #777;
}

</style>


<!-- ===============================================-->
<!--    content 시작    -->
<!-- ===============================================-->


<div class="album-container">

	<h4 class="p-3">${postType}</h4>

	<div class="p-3 search-box align-middle">
		    	<div class="position-relative" data-bs-toggle="search" data-bs-display="static">
		    		<input class="form-control search-input fuzzy-search" type="search" placeholder="Search..." aria-label="Search" id="searchInput" name="searchWord"/>
		    		<span class="fas fa-search search-box-icon"></span>
		    	</div>
		    <div class="btn-close-falcon-container position-absolute end-0 top-50 translate-middle shadow-none" data-bs-dismiss="search">
		    	<button class="btn btn-link btn-close-falcon p-0" aria-label="Close"></button>
		        </div>
	</div>	

	<div id="albumList" class="d-bolck scrollbar">
	
	</div>
	<input type="hidden" id="postType" value="${postType}"/>
	
</div>



<!-- ===============================================-->
<!--    content 끝    -->
<!-- ===============================================-->


<script type="text/javascript">
$(document).ready(function () {
	let postType = $("#postType").val();
	let currentPage = 1;
	let isLoading = false;
	let searchInput = $("#searchInput");
	let searchWord = '';
	let loadedBoardNos = new Set(); // 중복 체크를 위한 Set

	loadAlbumPosts(currentPage, 6);

	// Enter key로 검색어 입력 시 앨범 불러오기
	searchInput.on("keydown", function(event) {
		if (event.keyCode == 13) {
			searchWord = searchInput.val();
			currentPage = 1;
			loadedBoardNos.clear(); // 새 검색 시 중복 체크를 위한 Set 초기화
			$("#albumList").html("");
			loadAlbumPosts(currentPage, 6);
		}
	});

	// 스크롤 이벤트를 통해 앨범 추가 로드
	$("#albumList").on("scroll", function() {
		if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight - 100 && !isLoading) {
			currentPage++;
			loadAlbumPosts(currentPage, 3);
		}
	});

	// 앨범 게시글 로드 함수
	function loadAlbumPosts(page, pageSize) {
		console.log("page: " + page);
		console.log("searchWord: " + searchWord);
		isLoading = true;

		$.ajax({
			url: "/board/albumPaging.do",
			method: "post",
			data: JSON.stringify({
				currentPage: page,
				screenSize: pageSize,
				postType: postType,
				searchWord: searchWord
			}),
			contentType: "application/json; charset=utf-8",
			success: function(response) {
				if (response.dataList && response.dataList.length > 0) {
					response.dataList.forEach(function(board) {
						if (!loadedBoardNos.has(board.boardNo)) { // 중복 체크
							loadedBoardNos.add(board.boardNo); // 추가
							let albumItemHTML = `
								<div class="album-item">
									<a href='/board/albumDetail/\${board.boardNo}'>
										<img src="/board/thumbnail/\${board.thumbnailFileNo}" alt="썸네일">
										<div class="album-title">\${board.boardTitle}</div>
										<div class="album-info">
											\${board.memName} | \${board.boardCreate} | \${board.boardHit}
										</div>
									</a>
								</div>
							`;
							$("#albumList").append(albumItemHTML);
						}
					});
				}
				isLoading = false;
			},
			error: function() {
				console.error("failed to load album board");
				isLoading = false;
			}
		});
	}
});
</script>



</script>

