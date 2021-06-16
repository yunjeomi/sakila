<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCustomerList</title>
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
		console.log('searchBtn click!');
		$('#searchForm').submit();
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>getCustomerList</h1>
	
	<br>
	<form id="searchForm" action="${pageContext.request.contextPath}/admin/getCustomerList" method="get">
		<select name="storeId">
			<option value="">==store==</option>
			<c:if test="${storeId == 1}">
				<option value="1" selected>1</option>
			</c:if>
			<c:if test="${storeId != 1}">
				<option value="1">1</option>
			</c:if>
			<c:if test="${storeId == 2}">
				<option value="2" selected>2</option>
			</c:if>
			<c:if test="${storeId != 2}">
				<option value="2">2</option>
			</c:if>
		</select>
		<input type="text" name="searchWord" placeholder="이름+번호 검색">
		<button id="searchBtn" class="btn btn-default" type="button">검색</button>
	</form>
	<br>
	<div>
		<c:if test="${storeId != null}">
			[store${storeId}]
		</c:if>
		<c:if test="${searchWord != null}">
			"${searchWord}"
		</c:if>
		<c:if test="${storeId != null || searchWord != null}">
			검색결과 (${totalRow})
		</c:if>
	</div>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>customerName</th>
				<th>phone</th>
				<th>storeId</th>
				<th>black&vip</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="c" items="${customerList}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/admin/getCustomerOne?customerId=${c.customerId}">${c.name}</a>
						
					</td>
					<td>${c.phone}</td>
					<td>${c.storeId}</td>
					<td>${c.blackAndVip}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<ul class="pager">
	<c:if test="${currentPage>1}">
		<li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
	</c:if>
	<c:if test="${currentPage<lastPage}">
		<li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
	</c:if>
	</ul>
	
	<br>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addCustomer">회원추가</a>
	<hr>
	<div>vip : 대여횟수 30회 이상, 구매금액 150달러 이상, not black</div>
	<div>black : 연체횟수 15번 이상</div>
</div>
</body>
</html>