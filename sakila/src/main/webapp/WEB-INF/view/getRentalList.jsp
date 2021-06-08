<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getRentalList</title>
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
	
})
</script>
</head>
<body>
<div class="container">
	<h1>getRentalList</h1>
	
	<!-- 대여 프로세스
	rental; rentalId 추가 하는 것.
	payment; 렌탈비를 먼저 받아야 하니까 paymentId도 함께 추가한다. -> rental fee, 반납일 구하는 쿼리 필요 
	rental과 payment의 paymentdate, rentaldate가 같음. -> 즉 두개의 id는 같이 생성된다.
	근데, payment에서 rentalId null인건 대체 무슨 이유인지 모르겠음..
	
	경우의 수 1) 대여하면서 결제한 경우 -> 기본 대여료를 지급했음 -> payment의 amount는 대여료이며, if rental의 return_date가 rentalDuration을 초과한 경우 +1달러, *2일경우 replaceCost
	경우의 수 2) 대여하면서 미 결제한 경우 -> amount는 우선 0 -> 리턴이 찍히면 amount 뜨거나, 결제금액 창을 미리 만들어놓는다.
	-->
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addRental">대여</a>
	
	<!-- 반납 프로세스
	rental; return_date 오늘로 update 하기
	payment; lastUpdate 오늘로 update. 연체금액있으면 연체금액을 추가로 납입한다.
	-->
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addPayment">반납</a>
	<br><br>
	<form id="searchForm" action="${pageContext.request.contextPath}/admin/getRentalList" method="get">
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
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>name</th>
				<th>title</th>
				<th>rentalDate</th>
				<th>storeId</th>
				<th>overdueFee</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="r" items="${rentalList}">
				<tr>
					<td>${r.name}</td>
					<td>${r.title}</td>
					<td>${r.rentalDate}</td>
					<td>${r.storeId}</td>
					<td></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<ul class="pager">
        <c:if test="${currentPage > 1}">
            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getRentalList?currentPage=${currentPage-1}&searchWord=${searchWord}&storeId=${storeId}">이전</a></li>
        </c:if>
        <c:if test="${currentPage < lastPage}">
            <li class="next"><a href="${pageContext.request.contextPath}/admin/getRentalList?currentPage=${currentPage+1}&searchWord=${searchWord}&storeId=${storeId}">다음</a></li>
        </c:if>
    </ul>
</div>
</body>
</html>