<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeBoard</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$('#btn').click(function(){
		//form 유효성 검사 코드 추가
		$('#removeForm').submit();
	});
});
</script>
</head>
<body>
	<h1>removeBoard</h1>
	
	<form id="removeForm" action="${pageContext.request.contextPath}/removeBoard" method="post" >
		<input type="hidden" name="boardId" value="${boardId}">
		<div>
			<label>PW : </label> 
			<input type="password" id="boardPw" name="boardPw">
		</div>
		<button type="button" id="btn">삭제</button>
		<a href="${pageContext.request.contextPath}/getBoardOne?boardId=${boardId}">이전</a>
	</form>
</body>
</html>