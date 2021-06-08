<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addActorInFilmOne</title>
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
	$('#addActorBtn').click(function(){
		//체크박스 이벤트를 설정하고 싶었으나,, attr는 all or nothing이라 실패..
		console.log('추가완료!');
		$('#addActorForm').submit();
	});
});
</script>

</head>
<body>
<div class="container">
	<h1>modifyActorInFilmOne</h1>
	<br>
	<form id="addActorForm" action="${pageContext.request.contextPath}/admin/modifyActorInFilmOne" method="post">
		<input type="hidden" name="filmId" value="${filmId}">
		<table class="table table-striped">
			<tr>
				<th style="width:15%">filmId [${filmId}]</th>
				<th>
					name
				</th>
			</tr>
			<tr>
				<th>actorInFilm</th>
				<td>
					<c:forEach var="i" items="${actorListInFilm}">
						<input id="actorListInFilm" type="checkbox" name="actorCk" value="${i.actorId}" checked> ${i.name}&nbsp;
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>actorNotInFilm</th>
				<td>
					<c:forEach var="n" items="${actorListNotInFilm}">
						<input id="actorListNotInFilm" type="checkbox" name="actorCk" value="${n.actorId}"> ${n.name}&nbsp;
					</c:forEach>
				</td>
			</tr>
			
		</table>
		<button id="addActorBtn" class="btn btn-default" type="button">수정</button>
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${filmId}">목록으로</a>
	</form>
</div>
</body>
</html>