<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainMenu</title>
</head>
<body>
	<ul>
		<li><a href="${pageContext.request.contextPath}/admin/getCustomerList">회원관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getRentalList">대여/반납</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getFilmList">영화정보</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getActorList">배우정보</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getInventoryList">재고관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getSalesListByStore">매출현황</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getBoardList">게시판</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/getStaffList">직원정보</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/logout">로그아웃</a></li>
	</ul>
</body>
</html>