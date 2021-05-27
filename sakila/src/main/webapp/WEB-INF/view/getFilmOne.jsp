<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getFilmOne</title>
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

</head>
<body>
<div class="container">
	<h1>getFilmOne</h1>
	<br>
	<table class="table table-striped">
		<tr>
			<td>title</td>
			<td>${getFilmOne.title}</td>
		</tr>
		<tr>
			<td>category</td>
			<td>${getFilmOne.category}</td>
		</tr>
		<tr>
			<td>description</td>
			<td>${getFilmOne.description}</td>
		</tr>
		<tr>
			<td>price</td>
			<td>${getFilmOne.price}</td>
		</tr>
		<tr>
			<td>rentalDuration</td>
			<td>${getFilmOne.duration}</td>
		</tr>
		<tr>
			<td>
				actors
			</td>
			<td>
				${getFilmOne.actors}
				<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyActorInFilmOne?filmId=${getFilmOne.filmId}">변경</a>
			</td>
		</tr>
		<tr>
			<td>specialFeatures</td>
			<td>${getFilmOne.specialFeatures}</td>
		</tr>
		<tr>
			<td>releaseYear</td>
			<td>${getFilmOne.releaseYear}</td>
		</tr>
		<tr>
			<td>length</td>
			<td>${getFilmOne.length}</td>
		</tr>
		<tr>
			<td>rating</td>
			<td>${getFilmOne.rating}</td>
		</tr>
		<tr>
			<td>store_1 in stock</td>
			<td>${store1.filmCount}개</td>
		</tr>
		<tr>
			<td>store_2 in stock</td>
			<td>${store2.filmCount}개</td>
		</tr>
	</table>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">영화목록</a>	
</div>
</body>
</html>