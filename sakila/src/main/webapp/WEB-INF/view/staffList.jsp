<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>staffList</title>

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
	<h1>staffList</h1>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<td>ID</td>
				<td>name</td>
				<td>address</td>
				<td>zip code</td>
				<td>phone</td>
				<td>city</td>
				<td>country</td>
				<td>SID</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="s" items="${staffList}">
				<tr>
					<td>${s.id}</td>
					<td>${s.name}</td>
					<td>${s.address}</td>
					<td>${s.zipCode}</td>
					<td>${s.phone}</td>
					<td>${s.city}</td>
					<td>${s.country}</td>
					<td>${s.sid}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addStaff">직원추가</a>
</div>
</body>
</html>