<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>addBoard</title>
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
$(document).ready(function() {
	$('#addButton').click(function() {
		
		//파일중 하나라도 첨부되지 않으면 ck = true
		let ck = false;
		let boardfile = $('.boardfile');	//배열
		
		//break; 키워드를 사용하기 위해 boardfile.each(index, item)을 사용하지 않는다.
		for(let item of boardfile){
			if($(item).val() == ''){	//첨부파일이 없을 경우
				ck = true;
				console.log('첨부되지 않은 파일이 있습니다!');
				break;	//break를 사용하지 않으면 없는 갯수만큼 콘솔에 출력된다.
			}
		}
		
		//ck가 true일 경우 우선순위로 둔다.
		if(ck){
			alert('첨부되지 않은 파일이 있습니다!');
		} else if ($('#boardTitle').val() == '') {
			alert('boardTitle을 입력하세요');
			$('#boardTitle').focus();
		} else if ($('#boardContent').val() == '') {
			alert('boardContent을 입력하세요');
			$('#boardContent').focus();
		} else if ($('#boardPw').val().length < 4) {
			alert('boardPw는 4자이상 이어야 합니다');
			$('#boardPw').focus();
		} else {
			$('#addForm').submit();
		}
	});
	
	//<div id="inputFile">에 input type="file" 추가
	$('#addFileBtn').click(function(){
		console.log('addFileBtn click!');
		$('#inputFile').append('<input class="boardfile btn btn-default" type="file" name="boardfile">');
	});
	
	//<div id="inputFile">에 input type="file" 삭제 -> children().last().remove(); 자식의 마지막을 삭제
	$('#delFileBtn').click(function(){
		console.log('delFileBtn click!');
		$('#inputFile').children().last().remove();
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
				<h3 class="page-title">게시판 > 추가</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="addForm" action="${pageContext.request.contextPath}/admin/addBoard" method="post"
								enctype="multipart/form-data">
							<div>
								<div>
									<button id="addFileBtn" class="btn btn-default" type="button">파일추가</button>
									<button id="delFileBtn" class="btn btn-default" type="button">파일삭제</button>
								</div>
								<div id="inputFile">
								</div>
							</div>
							<br>
							<div class="form-group">
								<label for="boardTitle">boardTitle</label>
								<input id="boardTitle" class="form-control" name="board.boardTitle" type="text">
							</div>
							<div class="form-group">
								<label for="boardContent">boardContent</label>
								<textarea id="boardContent" class="form-control" name="board.boardContent" rows="5" cols="50"></textarea>
							</div>
							<div class="form-group">
								<label for="staffId">name</label>
								<input id="name" class="form-control" name="board.username" type="text" value="${loginStaff.username}" readonly>
								<input class="form-control" name="board.staffId" type="hidden" value="${loginStaff.staffId}">
							</div>
							<div class="form-group">
								<label for="boardPw">boardPw</label>
								<input id="boardPw" class="form-control" name="board.boardPw" type="password">
							</div>
							<div>
								<input id="addButton" class="btn btn-default" type="button" value="추가">
								<input class="btn btn-default" type="reset" value="초기화">
								<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList">목록</a>
							</div>
						</form>
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