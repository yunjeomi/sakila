<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyBoard</title>
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
	$('#btn').click(function(){
		if ($('#boardTitle').val() == '') {
			alert('boardTitle을 입력하세요!');
			$('#boardTitle').focus();
		} else if($('#boardContent').val() == ''){
			alert('boardContent을 입력하세요!');
			$('#boardContent').focus();
		} else if($('#boardPw').val() == ''){
			alert('boardPw을 입력하세요!');
			$('#boardPw').focus();
		} else if ($('#boardPw').val().length < 4){
			alert('boardPw을 4자이상 입력하세요!');
			$('#boardPw').focus();
		} else{
			//console.log("btn click!!");
			$('#modifyForm').submit();
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
						<h3 class="panel-title"></h3>
					</div>
					<div class="panel-body">
						<div class="container">
							<form id="modifyForm" action="${pageContext.request.contextPath}/admin/modifyBoard" method="post">
								<input type="hidden" name="boardId" value="${boardOne.boardId}">
						
								<div class="form-group">
									boardTitle
										<input type="text" id="boardTitle" class="form-control" name="boardTitle" value="${boardOne.boardTitle}">
								</div>
								<div class="form-group">
									boardContent
										<textarea id="boardContent" rows="5" cols="50" name="boardContent" class="form-control">${boardOne.boardContent}</textarea>
								</div>
								<div class="form-group">	
									userName
										<input type="text" class="form-control" value="${boardOne.username}" readonly>
								</div>
								<div class="form-group">	
									boardPw
										<input type="password" id="boardPw" class="form-control" name="boardPw">
								</div>
										
								<button type="button" id="btn" class="btn btn-default">수정</button>
								<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardOne?boardId=${boardOne.boardId}">이전</a>
							</form>
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