<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyBoard</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$('#btn').click(function(){
		$('#modifyForm').submit();
	});
});

</script>
</head>
<body>
	<h1>modifyBoard</h1>
	
	<form id="modifyForm" action="${pageContext.request.contextPath}/modifyBoard" method="post">
		<input type="hidden" name="boardId" value="${boardOne.boardId}">
		<input type="hidden" name="staffId" value="${boardOne.staffId}">
		<table border="1">
			<tr>
				<td>board_title</td>
				<td>
					<input type="text" id="" name="boardTitle" value="${boardOne.boardTitle}">
				</td>
			</tr>
			<tr>
				<td>board_content</td>
				<td>
					<textarea id="" rows="5" cols="50" name="boardContent">${boardOne.boardContent}</textarea>
				</td>
			</tr>
			<tr>
				<td>username</td>
				<td>
					<input type="text" value="${boardOne.username}" readonly>
				</td>
			</tr>
			<tr>
				<td>board_pw</td>
				<td>
					<input type="password" id="" name="boardPw">
				</td>
			</tr>
		</table>
		<button type="button" id="btn">수정</button>
		<a href="${pageContext.request.contextPath}/getBoardOne?boardId=${boardOne.boardId}">이전</a>
	</form>
</body>
</html>