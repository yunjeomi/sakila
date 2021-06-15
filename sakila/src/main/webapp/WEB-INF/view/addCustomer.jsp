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
	let ckBtn = false;
	
	$('#ckBtn').click(function(){
		console.log('phoneCkBtn 클릭');
		let phone = $('#phone').val();
		console.log('입력한 값?-> '+phone);
		$('#phoneCk').empty();
		
		if(!$.isNumeric(phone)) {
            alert('숫자만 입력가능합니다.');
            return;
        }

		$.ajax({
			type:'get',
			url:'/phoneNumList',
			data: {phone : $('#phone').val()},
			success: function(JsonData) {
				console.log('얻은data->'+JsonData);
				if(JsonData != 0){
					$('#phoneCk').text('이미 등록된 번호입니다.');
					$('#phone').focus();
					console.log('ckBtn : t or f?->'+ckBtn);
				} else{
					$('#phoneCk').text('사용 가능합니다.');
					ckBtn = true;
					console.log('ckBtn : t or f?->'+ckBtn);
				}
			}
		});
	});
	
	$('#country').change(function(){
		$.ajax({
			type: 'get',
			url: '/cityList',
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
	
	$('#city').change(function(){
		$('#addCity').empty();
		if($('#city').val() == 0){
			
			$('#addCity').append(
					'<input class="form-control" name="city.city" type="text">'
			);
		}
		
	});
	
	//유효성 검사 진행. -> 공백 없이 넘어가도록
	$('#addBtn').click(function(){
		console.log('addBtn click!');
		if($('#storeId').val() == 0){				//storeId 선택
			alert('store를 선택하세요.');
		} else if($('#firstName').val() == ''){		//firstName 입력
			alert('firstName을 입력하세요.');
		} else if($('#lastName').val() == ''){		//lastName 입력
			alert('lastName을 입력하세요.');
		} else if($('#phone').val() == ''){			//phone 입력
			alert('phone 번호를 입력하세요.');
		} else if(ckBtn == false){					//phone 중복체크
			alert('phone 번호를 확인하세요.');
		} else if($('#country').val() == ''){		//country 선택
			alert('country를 선택하세요.');
		} else if($('#city').val() == ''){			//city선택 -> 1이상 : 선택, 0 & addCity : 직접입력, "" : 선택 안 된 것
			alert('city를 선택하세요.');
		} else if($('#district').val() == ''){
			alert('district을 입력하세요.');
		} else if($('#address').val() == ''){
			alert('address을 입력하세요.');
		} else if($('#address2').val() == ''){
			alert('address2을 입력하세요.');
		} else if($('#postalCode').val() == ''){
			alert('postalCode을 입력하세요.');
		} else{
			$('#addForm').submit();
		}
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
			<!-- email은 firstName.lastName@sakilacustomer.org 입력되도록 한다 -->
			
			<!-- 중복 확인 용도 -->
			<tr>
				<td>phone</td>
				<td>
					<div><input id="phone" class="form-control" name="address.phone" type="text"></div>
					<div>
						<button id="ckBtn" class="btn btn-default" type="button">check</button>
						<span id="phoneCk"></span>
					</div>
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
					<div id="addCity"></div>
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
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList">회원목록</a>
		</div>
	</form>
</div>
	
</body>
</html>