<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addPayment</title>
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
	<h1>addPayment</h1>
	<table class="table table-hover">
		<tr>
			<td>storeId</td>
			<td>
				<select id="storeId" class="form-control" name="storeId">
					<option value="0">==store==</option>
					<option value="1">1</option>
					<option value="2">2</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>customerPhone</td>
			<td>
				<div>
					<input id="phone" class="form-control" type="text" name="customerId" placeholder="phoneNumber 입력">
				</div>
			</td>
		</tr>
		<tr>
			<td>title</td>
			<td>
				<div>
					<select id="title" class="form-control" name="title">
						<option value="0">==선택==</option>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<td>대여일</td>
			<td>
				<input id="rentalDate" class="form-control" type="text" name="rentalDate" readonly>
			</td>
		</tr>
		<tr>
			<td>대여기간</td>
			<td>
				<input id="rentalDuration" class="form-control" type="text" name="rentalDuration" readonly>
			</td>
		</tr>
		<tr>
			<td>결제금액</td>
			<td>
				<input id="payAmount" class="form-control" type="text" name="payAmount" readonly>
			</td>
		</tr>
	</table>
	<div>
		<button id="plusBtn" class="btn btn-default" type="button">+</button>
	</div>
	<hr>
	<h3>결제리스트</h3>
	<form id="addForm" action="${pageContext.request.contextPath}/admin/addRental" method="post">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>customerId</th>
					<th>title</th>
					<th>rentalDate</th>	<!-- realRentalDuration -->
					<th>storeId</th>
					<th>paymentFee</th>
				</tr>
			</thead>
			<tbody id="addTr">
			</tbody>
		</table>
		<div>
			<button id="addBtn" class="btn btn-default" type="button">결제&반납</button>
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList">취소</a>
		</div>
	</form>
</div>
</body>
</html>