<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
		header.masthead {
			padding-top: 10rem;
			padding-bottom: calc(10rem - 8.5rem);
			background: linear-gradient(to bottom, rgba(192, 155, 155, 0.8) 0%,
				rgba(179, 118, 72, 0.8) 100%), url("./assets/img/bg-masthead.jpg");
			background-position: center;
			background-repeat: no-repeat;
			background-attachment: scroll;
			background-size: cover;
		}
		
		header.masthead h1 {
			font-size: 2.25rem;
		}
		
		@media ( min-width : 1200px) {
			header.masthead h1 {
				font-size: 3.5rem;
			}
		}
		
		.searchbar {
			margin-bottom: auto;
			margin-top: auto;
			height: 60px;
			background-color: #353b48;
			border-radius: 30px;
			padding: 10px;
		}
		
		.search_input {
			color: white;
			border: 0;
			outline: 0;
			background: none;
			width: 0;
			caret-color: transparent;
			line-height: 40px;
			transition: width 0.4s linear;
		}
		
		.searchbar:hover>.search_input {
			padding: 0 10px;
			width: 450px;
			caret-color: red;
			transition: width 0.4s linear;
		}
		
		.searchbar:hover>.search_icon {
			background: white;
			color: #e74c3c;
		}
		
		.search_icon {
			height: 40px;
			width: 40px;
			float: right;
			display: flex;
			justify-content: center;
			align-items: center;
			border-radius: 50%;
			color: white;
			text-decoration: none;
		}
		
		select {
			background-color: #353b48;
			color: white;
		}
		
		.nav-up {
			top: -50px;
		}
		
        #list-table td{
        cursor : pointer;
        }
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">

		<div class="row">

			<div class="col-lg-3">
				<h1 class="my-4 card-header">방 정보</h1>
				<div class="list-group">
					<p>카테고리 : ${roomDetail.roomTypeName}</p>
					<p>방장 : ${roomDetail.memberId}</p>
					<p>회원 수 : 10명</p>
					<p class="list-group-item fas fa-angle-down" id="moreInfo"
						style="cursor: pointer; color: blue;">&nbsp;더 보기</p>
					<div id="infoList"></div>
					<!-- 방장 회원 전용 메뉴-->
					<a href="#" class="list-group-item" id="roomMemberInfo">방 회원
						조회</a> <a href="#" class="list-group-item">공지사항 작성</a> <a href="#"
						class="list-group-item">방 정보 수정</a>

				</div>
				<div>
					<button id="prevAtag" class="btn-secondary" style="margin-top: 10px;" onclick="location.href='../roomList'">방 나가기</button>
				</div>
			</div>
			<!-- /.col-lg-3 -->

			<div class="col-lg-9">

				<div class="card mt-4">
					<div class="card-body">
						<h3 class="card-title">${roomDetail.roomTitle}</h3>
					</div>
				</div>
				<!-- /.card -->

				<div class="card card-outline-secondary my-4">
					<div class="card-body">
						<table class="table" id="list-table">
							<tr>
								<th>글 번호</th>
								<th>말머리</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
								<th>좋아요</th>
							</tr>
						</table>
						<a class="btn btn-primary float-right" href="#">글쓰기</a>
						<form action="#" method="get">
							<select name="searchKey" class="form-control"
								style="width: 100px; display: inline-block;">
								<option value="title">글제목</option>
								<option value="boardGroup">말머리</option>
								<option value="writer">작성자</option>
							</select> <input type="text" name="searchValue" class="form-control"
								style="width: 25%; display: inline-block;">
							<button class="form-control btn btn-primary"
								style="width: 100px; display: inline-block;">검색</button>
						</form>
					</div>
				</div>
				<!-- /.card -->

			</div>
			<!-- /.col-lg-9 -->

		</div>

	</div>

	<jsp:include page="../common/footer.jsp" />
	
	        <script>
            var enterChk = false;
            $("#moreInfo").on("click", function() {
                if(!enterChk) {
                    var $p1 = $("<p>").html("<br><h6>방 생성날짜 : ${roomDetail.roomCreateDate}</h6><br> 현재 방 내에서 채택된 답변 수 : 10 <br> 작성한 글 수  : 1<br> 작성한 글 수 : 3<br>");
                    var $button = $("<button>", {type : "button" , id : "outRoom", class : "btn-primary"}).text("방 탈퇴");
                    $("#infoList").append($p1, $button);
                    $("#moreInfo").hide();
                    enterChk = true;
                }
            });
            
         	// 게시글 상세보기 기능 구현
            $(function(){
          	  $("#list-table td").on("click", function(){
          		  var roomBoardNo = $(this).parent().children().eq(0).text();
      				
          		  // 게시글 상세조회 요청 주소
          		  var roomBoardUrl =
          			  "${contextPath}/room/${pInfo.boardType}/"+ roomBoardNo + "?cp=${pInfo.currentPage}";	
          			  
          			  // @PathValue 방식 : 구분되어야 하는 리소스를 호출하는 url로 사용
          			  // spring/board/1/500?cp=3
          					  
          			  // 파라미터(쿼리스트링) : 정렬, 필터링
          			  // spring/board?type=1&boardNo=500&cp=3
          					  
          		// 게시글 상세조회 요청
          		location.href = roomBoardUrl;
          	  });
          	  
	  			var url = "${contextPath}/roomBoard/boardList/${roomDetail.roomNo}";
				$.ajax({
					url : url,
					type : "POST",
					dataType:"json",
					success : function(rbList){
						console.log(rbList);
						
						
						$.each(rbList, function(i){
							$table = $("#list-table");
							$tr = $("<tr>");
							$td1 = $("<td>").text(rbList[i].roomBoardNo);
							$td2 = $("<td>").text(rbList[i].roomBoardType);
							$td3 = $("<td>").text(rbList[i].roomBoardTitle);
							$td4 = $("<td>").text(rbList[i].roomBoardWriter);
							$td5 = $("<td>").text(rbList[i].roomBoardCreateDate);
							$td6 = $("<td>").text(rbList[i].roomBoardReadCount);
							$td7 = $("<td>").text('0');
							
							$tr.append($td1,$td2,$td3,$td4,$td5,$td6,$td7);
							$table.append($tr);
						});
						
					},error : function(){
						console.log("통신 실패");
					}
				});
            });
         	

        </script>
</body>
</html>