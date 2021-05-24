<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getFilmList</title>
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
	<h1>getFilmList</h1>
	
	<br>
	<c:if test="${selectSearch.equals('titleOrActors')}">
		<h4>[제목+배우] "${searchWord}"로 검색한 결과입니다.</h4>
	</c:if>
	<c:if test="${selectSearch.equals('title')}">
		<h4>[제목] "${searchWord}"로 검색한 결과입니다.</h4>
	</c:if>
	<c:if test="${selectSearch.equals('actors')}">
		<h4>[배우] "${searchWord}"로 검색한 결과입니다.</h4>
	</c:if>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<td>title</td>
				<td>category</td>
				<td>length</td>
				<td>rating</td>
				<td>price</td>
				<td>actors</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="f" items="${filmList}">
				<tr>
					<td><a href="${pageContext.request.contextPath}/admin/getFilmOne?title=${f.title}">${f.title}</a></td>
					<td>${f.category}</td>
					<td>${f.length}</td>
					<td>${f.rating}</td>
					<td>${f.price}</td>
					<td>${(f.actors).substring(0, 15)}....</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<ul class="pager">
        <c:if test="${currentPage > 1}">
            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage-1}&searchWord=${searchWord}&selectSearch=${selectSearch}">이전</a></li>
        </c:if>
        <c:if test="${currentPage < lastPage}">
            <li class="next"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage+1}&searchWord=${searchWord}&selectSearch=${selectSearch}">다음</a></li>
        </c:if>
    </ul>
    
	<form action="${pageContext.request.contextPath}/admin/getFilmList" method="get">
		<select name="selectSearch">
			<option value="titleOrActors">제목+배우</option>
			<option value="title">제목</option>
			<option value="actors">배우</option>
		</select>
		
		<input name="searchWord" type="text">
		
		<button type="submit">검색</button>
	</form>
    
</div>
</body>
</html>