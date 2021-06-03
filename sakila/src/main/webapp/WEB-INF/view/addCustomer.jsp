<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCustomer</title>

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
	$('#phone').blur(function(){
		console.log('phone번호 입력 클릭');
		let phone = $('#phone').val();
		console.log('입력한 phone ?'+phone);
		$.ajax({
			type:'get',
			url:'/admin/addCustomer/phone',
			success: function(data) {
				$('#phoneCk').empty();
				$(data).each(function(index, item){
					if(item.phone == phone){
						$('#phoneCk').text('이미 등록된 번호입니다.');
						return;
					}	
				});
			}
		});
	});
	
	$('#country').change(function(){
		$.ajax({
			type: 'get',
			url: '/admin/addCustomer/city',
			data: {countryId : $('#country').val()},
			success: function(cityData){
				$('#city').empty();
				
				$(cityData).each(function(index, item) {
					$('#city').append(
						'<option value="'+item.cityId+'">'+item.city+'</option>'
					);
				});
				
				$('#city').append(
						'<option value="0">직접입력</option>'
				);
			}
			
			
		});
	});
	
	//유효성 검사 진행. -> 공백 없이 넘어가도록
	$('#addBtn').click(function(){
		console.log('addBtn click!');
		$('#addForm').submit();
	});
});

</script>
</head>
<body>
<div class="container">
	<h1>addCustomer</h1>
	<form id="addForm" action="${pageContext.request.contextPath}/admin/addCustomer" method="post">
		<table class="table table-hover">
		<tr>
			<td>storeId</td>
			<td>
				<select id="storeId" class="form-control" name="customer.storeId">
					<option value="">==store==</option>
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
		<!-- email은 firstName.lastName@sakilacustomer.org 입력되도록 한다 -->
		
		<!-- 중복 확인 용도 -->
		<tr>
			<td>phone</td>
			<td>
				<input id="phone" class="form-control" name="address.phone" type="text">
				<div id="phoneCk"></div>
			</td>
		</tr>
		
		<!-- country 범위가 더 넓으므로 먼저 선택하도록 한다. -->
		<!-- select option으로 선택 -->
		<tr>
			<td>country</td>
			<td>
				<select id="country" class="form-control" name="country.countryId">
					<option value="">==country==</option>
					<c:forEach var="c" items="${countryList}"> 
						<option value="${c.countryId}">${c.country}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
		<!-- 없을 경우 추가 -->
		<td>city</td>
		<td>
			<div>
				<select id="city" class="form-control" name="city.cityId">
					<option value="">==city==</option>
				</select>
			</div>
			<div><input class="form-control" name="addCity" type="text" placeholder="직접입력"></div>
			
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
		<div>
			<button id="addBtn" class="btn btn-default" type="button">추가</button>
			<input class="btn btn-default" type="reset" value="초기화">
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList">고객목록</a>
		</div>
	</form>
</div>
	
</body>
</html>