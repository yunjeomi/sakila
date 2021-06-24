\<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/linearicons/style.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
<script>
$(document).ready(function(){
	$('#addCommentBtn').click(function(){
		if ($('#commentContent').val() == '') {
			alert('commentContent을 입력하세요');
			$('#commentContent').focus();
		} else if ($('#username').val() == '') {
			alert('userName을 입력하세요');
			$('#username').focus();
		} else {
			$('#addCommentForm').submit();
		}
	});
});

</script>
</head>
<body>

<div id="wrapper">
	<!-- NAVBAR -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="brand">
			<a href="${pageContext.request.contextPath}/index"><img src="${pageContext.request.contextPath}/assets/img/sakila.png" class="img-responsive logo"></a>
		</div>
		<div class="container-fluid">
			<div class="navbar-btn">
				<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
			</div>
			
			<div class="navbar-btn navbar-btn-right">
				<i class="fa fa-rocket"></i> <span>${loginStaff.email}</span>
			</div>
		</div>
	</nav>
	
	<!-- LEFT SIDEBAR -->
	<div id="sidebar-nav" class="sidebar">
		<div class="sidebar-scroll">
			<nav>
				<ul class="nav">
					<li><jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include></li>
				</ul>
			</nav>
		</div>
	</div>
	
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<!-- OVERVIEW -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="container">
							<h3 class="panel-title">${boardOne.boardTitle}</h3>
						</div>
					</div>
					<div class="panel-body">
						<div class="container">
							<table class="table">
								<tbody>
									<tr>
										<td>boardContent</td>
										<td>${boardOne.boardContent}</td>
									</tr>
									<tr>
										<td>userName</td>
										<td>${boardOne.username}</td>
									</tr>
									<tr>
										<td>insertDate</td>
										<td>${boardOne.insertDate}</td>
									</tr>
									<tr>
										<td>boardfile</td>
										<td>
											<!-- 보드파일을 출력하는 반복문 코드 구현 -->
											<c:forEach var="f" items="${boardfileList}">
												<div>
													<a href="${pageContext.request.contextPath}/resource/${f.boardfileName}">${f.boardfileName}</a>
													
													<!-- 로그인 당사자가 글쓴이일 경우에만 파일삭제 할 수 있음 -->
													<c:if test="${loginStaff.staffId == boardOne.staffId}">
														<a href="${pageContext.request.contextPath}/admin/removeBoardfile?boardfileId=${f.boardfileId}&boardId=${f.boardId}&boardfileName=${f.boardfileName}"><button class="btn btn-default" type="button">삭제</button></a>
													</c:if>
												</div>
											</c:forEach>
											
											<!-- 로그인 당사자가 글쓴이일 경우에만 파일추가 할 수 있음 -->
											<c:if test="${loginStaff.staffId == boardOne.staffId}">
												<div><a href="${pageContext.request.contextPath}/admin/addBoardfile?boardId=${boardOne.boardId}"><button class="btn btn-default" type="button">추가</button></a></div>
											</c:if>
										</td>
									</tr>
								</tbody>
							</table>
							
						<!-- 로그인 당사자가 글쓴이일 경우에만 수정/삭제 버튼 볼 수 있음 -->
						<c:if test="${loginStaff.staffId == boardOne.staffId}">
							<a href="${pageContext.request.contextPath}/admin/modifyBoard?boardId=${boardOne.boardId}"><button class="btn btn-default" type="button">수정</button></a>
							<a href="${pageContext.request.contextPath}/admin/removeBoard?boardId=${boardOne.boardId}"><button class="btn btn-default" type="button">삭제</button></a>
						</c:if>
						<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList">목록</a>	
						
						<hr>
						
						<!-- 댓글 리스트 추가 -->
						<div>comment 추가</div>
						<form id="addCommentForm" action="${pageContext.request.contextPath}/admin/addComment" method="post">
							<input type="hidden" name="boardId" value="${boardOne.boardId}">
							<div class="form-group">
								<textarea id="commentContent" rows="5" cols="50" name="commentContent" class="form-control"></textarea>
							</div>
							<div class="form-group">
								userName
								<input type="text" id="username" name="username" value="${loginStaff.username}" readonly>
								<button type="button" id="addCommentBtn" class="btn btn-default" style="float: right;">등록</button>
							</div>
						</form>
						
						<hr>
						
						<div>
							등록된 comment ${commentList.size()}개
						</div>
						<br>
						<c:forEach var="i" items="${commentList}">
							<table class="table table-bordered">
								<tr>
									<td width="8%">${i.username}</td>
									<td >${i.commentContent}</td>
									<td width="18%">
										${i.insertDate}
									
										<!-- 삭제 버튼은 로그인 당사자 자신의 것만 볼 수 있다. -->
										<!-- comment table내 staffId를 참조하지 않고 userName만 적도록 되어있어서. 동명이인은 고려하지 않고 이름이 같으면 삭제하도록 한다(...) -->
										<c:if test="${loginStaff.username == i.username}">
											<a href="${pageContext.request.contextPath}/admin/removeComment?commentId=${i.commentId}&boardId=${boardOne.boardId}">X</a>
										</c:if>
									</td>
								</tr>
							</table>
						</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
</body>
</html>