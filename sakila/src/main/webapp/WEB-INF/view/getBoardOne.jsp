<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardOne</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
 
</head>
<body>
<div class="container">
	<h1>boardOne</h1>
		<table class="table">
			<tbody>
				<tr>
					<td>board_id</td>
					<td>${boardOne.boardId}</td>
				</tr>
				<tr>
					<td>board_title</td>
					<td>${boardOne.boardTitle}</td>
				</tr>
				<tr>
					<td>board_content</td>
					<td>${boardOne.boardContent}</td>
				</tr>
				<tr>
					<td>username</td>
					<td>${boardOne.username}</td>
				</tr>
				<tr>
					<td>insert_date</td>
					<td>${boardOne.insertDate}</td>
				</tr>
			</tbody>
		</table>
	
	<a class="btn btn-default" href="${pageContext.request.contextPath}/modifyBoard?boardNo=${boardOne.boardId}">수정</a>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/removeBoard?boardNo=${boardOne.boardId}">삭제</a>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/getBoardList">글목록</a>
</div>
</body>
</html>