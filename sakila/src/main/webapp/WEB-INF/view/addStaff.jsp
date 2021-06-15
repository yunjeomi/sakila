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
			url: '/cityListInStaff',
			type: 'get',
			data: {countryId : $('#country').val()},
			success: function(cityData){
				console.log('city 불러오기 성공');
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
					'<input class="form-control" name="city" type="text">'
			);
		}
	});
	
	$('#phone').keyup(function(){
		let phone = $('#phone').val();
		if(!$.isNumeric(phone)) {
            alert('숫자만 입력가능합니다.');
            $('#phone').val('');
            //$('#phone').focus();
            return;
        }
	});
	
	$('#addStaffBtn').click(function(){
		console.log('addStaffBtn click!');
		if($('#storeId').val() == 0){				//storeId 선택
			alert('store를 선택하세요.');
		} else if($('#firstName').val() == ''){		//firstName 입력
			alert('firstName을 입력하세요.');
		} else if($('#lastName').val() == ''){		//lastName 입력
			alert('lastName을 입력하세요.');
		} else if($('#password').val() == ''){			//phone 입력
			alert('password를 입력하세요.');
		} else if(pwCK == false){					//phone 중복체크
			alert('password가 일치하지 않습니다.');
		} else if($('#phone').val() == ''){			//phone 입력
			alert('phone 번호를 입력하세요.');
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
			$('#addStaffForm').submit();
		}
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
					<select id="storeId" class="form-control" name="storeId">
						<option value="0">==store==</option>
						<option value="1">1</option>
						<option value="2">2</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>firstName</td>
				<td>
					<input id="firstName" class="form-control" name="firstName" type="text">
				</td>
			</tr>
			
			<tr>
				<td>lastName</td>
				<td>
					<input id="lastName" class="form-control" name="lastName" type="text">
				</td>
			</tr>
			
			<tr>
				<td>password</td>
				<td>
					<input id="password" class="form-control" name="password" type="password">
				</td>
			</tr>
			
			<tr>
				<td>passwordCK</td>
				<td>
					<div>
						<input id="passwordCK" class="form-control" name="passwordCK" type="password">
					</div>
					<div>
						<div id="pwCK"></div>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>phone</td>
				<td>
					<input id="phone" class="form-control" name="phone" type="text">
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
					<select id="country" class="form-control" name="countryId">
						<option value="">==country==</option>
						<c:forEach var="c" items="${countryList}"> 
							<option value="${c.countryId}">${c.country}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>city</td>
				<td>
					<select id="city" class="form-control" name="cityId">
						<option value="">==city==</option>
					</select>
					<div id="addCity"></div>
				</td>
			</tr>
			
			<tr>
				<td>district</td>
				<td>
					<input id="district" class="form-control" name="district" type="text">
				</td>
			</tr>
			
			<tr>
				<td>address</td>
				<td>
					<input id="address" class="form-control" name="address" type="text">
				</td>
			</tr>
			
			<tr>
				<td>address2</td>
				<td>
					<input id="address2" class="form-control" name="address2" type="text">
				</td>
			</tr>
			
			<tr>
				<td>postalCode</td>
				<td>
					<input id="postalCode" class="form-control" name="postalCode" type="text">
				</td>
			</tr>
			
		</table>
		<button id="addStaffBtn" class="btn btn-default" type="button">추가</button>
		<input class="btn btn-default" type="reset" value="초기화">
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getStaffList">취소</a>
	</form>
</div>
</body>
</html>