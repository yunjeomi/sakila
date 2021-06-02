<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCustomerOne</title>
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
	<h1>getCustomerOne</h1>
	<br>
	<table class="table table-striped">
		<tr>
			<td>name</td>
			<td>${customerOne.name}</td>
		</tr>
		<tr>
			<td>phone</td>
			<td>${customerOne.phone}</td>
		</tr>
		<tr>
			<td>amount</td>
			<td>${payment}</td>
		</tr>
		<tr>
			<td>storeId</td>
			<td>${customerOne.storeId}</td>
		</tr>
		<tr>
			<td>address</td>
			<td>(${customerOne.zipCode}) ${customerOne.address}</td>
		</tr>
		<tr>
			<td>country-city</td>
			<td>
				${customerOne.country}-${customerOne.city}
			</td>
		</tr>
		<tr>
			<td>active</td>
			<td>${customerOne.active}</td>
		</tr>
		<tr>
			<td>create_date</td>
			<td>${customerOne.createDate}</td>
		</tr>
		<tr>
			<td>nonReturn</td>
			<td>
				<c:forEach var="r" items="${rentalListOfNull}">
					<a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${r.filmId}">${r.title}</a>. 
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td>rentalCompleted</td>
			<td>
				<c:forEach var="r" items="${rentalListOfNotNull}">
					<a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${r.filmId}">${r.title}</a>. 
				</c:forEach>
			</td>
		</tr>
	</table>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList">고객목록</a> 
</div>
</body>
</html>