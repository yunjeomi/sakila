<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getActorList</title>
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
	$('#searchBtn').click(function(){
		if($('#searchWord').val() == ''){
			alert('검색어를 입력해주세요!');
			$('#searchWord').focus();
		} else{
			console.log('searchForm submit!');
			$('#searchForm').submit();
		}
	});
	
});

</script>
</head>
<body>
<div class="container">
	<h1>getActorList</h1>
	
	<a href="${pageContext.request.contextPath}/">home</a>
	
	
	<!-- 검색창 -->
	<form id="searchForm" action="${pageContext.request.contextPath}/admin/getActorList" method="get">
		<select name="searchSelect">
			<c:if test="${searchSelect == 'actorAndFilm'}">
				<option value="actorAndFilm" selected>배우+영화
			</c:if>
			<c:if test="${searchSelect != 'actorAndFilm'}">
				<option value="actorAndFilm">배우+영화
			</c:if>
			<c:if test="${searchSelect == 'actor'}">
				<option value="actor" selected>배우
			</c:if>
			<c:if test="${searchSelect != 'actor'}">
				<option value="actor">배우
			</c:if>
			<c:if test="${searchSelect == 'film'}">
				<option value="film" selected>영화
			</c:if>
			<c:if test="${searchSelect != 'film'}">
				<option value="film">영화
			</c:if>
		</select>
		<input id="searchWord" type="text" name="searchWord">
		<button id="searchBtn" type="button">검색</button>
	</form>
	
	<!-- 검색결과 간단하게 알려주는 창 -->
	<c:if test="${searchWord != null && searchSelect == 'actorAndFilm'}">
		<div>[배우+영화] "${searchWord}" 검색 결과 (${totalPage}개)</div>
	</c:if>
	<c:if test="${searchWord != null && searchSelect == 'actor'}">
		<div>[배우] "${searchWord}" 검색 결과 (${totalPage}개)</div>
	</c:if>
	<c:if test="${searchWord != null && searchSelect == 'film'}">
		<div>[영화] "${searchWord}" 검색 결과 (${totalPage}개)</div>
	</c:if>
	<br>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>name</th>
				<th>filmInfo</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="g" items="${actorList}">
				<tr>
					<td>${g.name}</td>
					<td>${g.filmInfo}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 버튼 -->
	<ul class="pager">
		<c:if test="${currentPage>1}">
			<li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage-1}&searchWord=${searchWord}&searchSelect=${searchSelect}">이전</a></li>
		</c:if>
		<c:if test="${currentPage<lastPage}">
			<li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage+1}&searchWord=${searchWord}&searchSelect=${searchSelect}">다음</a></li>
		</c:if>
	</ul>
	
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addActor">배우 추가</a>
	
</div>
</body>
</html>