<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getStaffOne</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	
	
});
</script>
</head>
<body>
<div class="container">
	<h1>getStaffOne</h1>
	
	<table class="table table-hover">
		<tr>
			<td>name</td>
			<td>
				${staffOne.name}
			</td>
		</tr>
		
		<tr>
			<td>phone</td>
			<td>
				${staffOne.phone}
			</td>
		</tr>
		
		<tr>
			<td>picture</td>
			<td>
				<img src="${pageContext.request.contextPath}/resource/staff/${staffOne.picture}">
			</td>
		</tr>
		<tr>
			<td>country</td>
			<td>
				${staffOne.country}
			</td>
		</tr>
		<tr>
			<td>city</td>
			<td>
				${staffOne.city}
			</td>
		</tr>
		<tr>
			<td>address</td>
			<td>
				${staffOne.address}
			</td>
		</tr>
	</table>
	
	<!-- 본인정보만 수정할 수 있도록 한다. -->
	<c:if test="${loginStaff.staffId == staffOne.staffId}">
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyStaff?staffId=${staffOne.staffId}">수정</a>
	</c:if>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getStaffList">직원목록</a>
</div>
</body>
</html>