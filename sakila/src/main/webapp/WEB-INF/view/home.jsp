<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
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
		console.log('btn click');
		$('#loginForm').submit();
	});
});

</script>
</head>
<body>
<div class="container">
	<h1>home</h1>
	
	<!-- 로그인 전; session 사용 시 == null, != null 로 반드시 바꿀 것 -->
	<c:if test="${loginStaff == null}">
		<form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" >
			<table class="table table-hover">
				<tr>
					<td>email</td>
					<td>
						<input id="email" class="form-control" name="email" type="text">
					</td>
				</tr>
				<tr>
					<td>password</td>
					<td>
						<input id="password" class="form-control" name="password" type="password">
					</td>
				</tr>
			</table>
			<button id="btn" class="btn btn-default" type="button">로그인</button>
		</form>
	</c:if>
	
	<!-- 로그인 후 --><!-- 개발 중엔 null값도 허용 가능하도록 -->
	<c:if test="${loginStaff == null}">
		<a href="${pageContext.request.contextPath}/admin/getCustomerList">회원관리</a>
		<a href="${pageContext.request.contextPath}/admin/getRentalList">대여/반납</a>
		<a href="${pageContext.request.contextPath}/admin/getFilmList">영화정보</a>
		<a href="${pageContext.request.contextPath}/admin/getActorList">배우정보</a>
		<a href="${pageContext.request.contextPath}/admin/getInventoryList">재고관리</a>
		<a href="${pageContext.request.contextPath}/admin/getSalesListByStore">매출현황</a>
		<a href="${pageContext.request.contextPath}/admin/getBoardList">게시판</a>
		<a href="${pageContext.request.contextPath}/admin/getStaffList">직원정보</a>
		<a href="${pageContext.request.contextPath}/admin/logout">로그아웃</a>
	</c:if>
</div>
</body>
</html>