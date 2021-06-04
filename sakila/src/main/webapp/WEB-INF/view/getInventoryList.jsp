<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getInventoryList</title>
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
	})
});
</script>
</head>
<body>
<div class="container">
	<h1>getInventoryList</h1>
	<br>
	<a href="${pageContext.request.contextPath}/admin/getInventoryList">전체재고</a>&nbsp;
	<a href="${pageContext.request.contextPath}/admin/getInventoryList?notInStock=0">대여리스트</a>&nbsp;
	<br><br>
	<form id="searchForm" action="${pageContext.request.contextPath}/admin/getInventoryList" method="get">
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
		<input type="hidden" name="notInStock" value="${notInStock}">
		<input type="text" name="searchWord" placeholder="title 검색">
		<button id="searchBtn" class="btn btn-default" type="button">검색</button>
	</form>
	<br>
	<div>
		<c:if test="${storeId != null}">
			[store${storeId}]
		</c:if>
		<c:if test="${notInStock == 0}">
			대여리스트
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
				<td>title</td>
				<c:if test="${notInStock != 0}">
					<c:if test="${storeId != 1 && storeId != 2}">
						<td>store1 재고</td>
						<td>store2 재고</td>
					</c:if>
					<td>보유 재고</td>
				</c:if>
				<td>대여중</td>
				<c:if test="${notInStock != 0}">
					<td>전체</td>
				</c:if>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" items="${inventoryList}">
				<tr>
					<td>${i.title}</td>
					<c:if test="${notInStock != 0}">
						<c:if test="${storeId != 1 && storeId != 2}">
							<td>${i.store1}</td>
							<td>${i.store2}</td>
						</c:if>
						<td>${i.totalInStock}</td>
					</c:if>
					<td>${i.notInStock}</td>
					<c:if test="${notInStock != 0}">
						<td>${i.total}</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<ul class="pager">
	<c:if test="${currentPage > 1}">
		<li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=${currentPage-1}&searchWord=${searchWord}&storeId=${storeId}&notInStock=${notInStock}">이전</a></li>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList?currentPage=${currentPage+1}&searchWord=${searchWord}&storeId=${storeId}&notInStock=${notInStock}">다음</a></li>
	</c:if>
	</ul>
	
	<div>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addInventory">재고 추가</a>
	</div>
</div>
</body>
</html>