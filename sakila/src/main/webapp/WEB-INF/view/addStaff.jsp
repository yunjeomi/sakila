<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addStaff</title>
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
<!-- 검색어 자동완성을 위한  -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script>
$(document).ready(function(){
	let pwCK = false;
	
	$('#passwordCK').keyup(function(){
		if($('#password').val() != $('#passwordCK').val()){
			$('#pwCK').text('패스워드가 일치하지 않습니다.');
		} else{
			pwCK = true;
			$('#pwCK').text('패스워드가 일치합니다.');
		}
	});
	
	//도시list가져오기
	$('#country').change(function(){
		$.ajax({
			url: '/cityList',
			type: '/get',
			data: {countryId = $('#countryId').val()},
			success: function(jsonData){
				$(jsonData).each(index, item){
					$('#cityId').append('<option value=""></option>');
				}
			}
		});
	});
	
});
</script>
</head>
<body>
<div class="container">
	<h1>addStaff</h1>
	
	<form id="addStaffForm" action="${pageContext.request.contextPath}/admin/addStaff" method="post">
		<table class="table table-hover">
			<tr>
				<td>storeId</td>
				<td>
					<select id="storeId" class="form-control" name="customer.storeId">
						<option value="0">==store==</option>
						<option value="1">1</option>
						<option value="2">2</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>firstName</td>
				<td>
					<input id="firstName" class="form-control" name="customer.firstName" type="text">
				</td>
			</tr>
			
			<tr>
				<td>lastName</td>
				<td>
					<input id="lastName" class="form-control" name="customer.lastName" type="text">
				</td>
			</tr>
			
			<tr>
				<td>password</td>
				<td>
					<input id="password" class="form-control" name="customer.lastName" type="password">
				</td>
			</tr>
			
			<tr>
				<td>passwordCK</td>
				<td>
					<div>
						<input id="passwordCK" class="form-control" name="customer.lastName" type="password">
					</div>
					<div>
						<span id="pwCK"></span>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>picture</td>
				<td>
					<input id="picture" class="form-control" name="picture" type="file">
				</td>
			</tr>
			
			<tr>
				<td>country</td>
				<td>
					<select id="country" class="form-control" name="country.countryId">
						<option value="0">==country==</option>
						<c:forEach var="c" items="${countryList}"> 
							<option value="${c.countryId}">${c.country}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>city</td>
				<td>
					<select id="city" class="form-control" name="country.countryId">
						<option value="0">==city==</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>district</td>
				<td>
					<input id="district" class="form-control" name="address.district" type="text">
				</td>
			</tr>
			
			<tr>
				<td>address</td>
				<td>
					<input id="address" class="form-control" name="address.address" type="text">
				</td>
			</tr>
			
			<tr>
				<td>address2</td>
				<td>
					<input id="address2" class="form-control" name="address.address2" type="text">
				</td>
			</tr>
			
			<tr>
				<td>postalCode</td>
				<td>
					<input id="postalCode" class="form-control" name="address.postalCode" type="text">
				</td>
			</tr>
			
		</table>
		<button id="addActorBtn" class="btn btn-default" type="button">추가</button>
		<input class="btn btn-default" type="reset" value="초기화">
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getStaffList">취소</a>
	</form>
</div>
</body>
</html>