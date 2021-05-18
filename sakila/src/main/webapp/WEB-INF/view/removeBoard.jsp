<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeBoard</title>

<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script>
$(document).ready(function(){
	$('#btn').click(function(){
		if ($('#boardPw').val() == '') {
			alert('boardPw을 입력하세요!');
			$('#boardPw').focus();
		} else if ($('#boardPw').val().length < 4){
			alert('boardPw을 4자이상 입력해주세요!');
			$('#boardPw').focus();
		} else{
			//console.log("btn click!!");
			//form 유효성 검사 코드 추가
			$('#removeForm').submit();
		}
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>removeBoard</h1>
	
	<form id="removeForm" action="${pageContext.request.contextPath}/admin/removeBoard" method="post" >
		<input type="hidden" name="boardId" value="${boardId}">
		<table class="table">
			<tr>
				<td><label>boardPw</label></td> 
				<td><input type="password" id="boardPw" name="boardPw"></td>
			</tr>
		</table>
		<button type="button" id="btn" class="btn btn-default">삭제</button>
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardOne?boardId=${boardId}">이전</a>
	</form>
</div>
</body>
</html>