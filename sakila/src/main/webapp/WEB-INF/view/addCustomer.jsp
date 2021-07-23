<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCustomer</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/linearicons/style.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
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
			url:'${pageContext.request.contextPath}/phoneNumList',
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
			url: '${pageContext.request.contextPath}/cityList',
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
<div id="wrapper">
	<!-- NAVBAR -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="brand">
			<a href="${pageContext.request.contextPath}/index"><img src="${pageContext.request.contextPath}/assets/img/sakila.png" class="img-responsive logo"></a>
		</div>
		<div class="container-fluid">
			<div class="navbar-btn">
				<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
			</div>
			
			<div class="navbar-btn navbar-btn-right">
				<i class="fa fa-rocket"></i> <span>${loginStaff.email}</span>
			</div>
		</div>
	</nav>
	
	<!-- LEFT SIDEBAR -->
	<div id="sidebar-nav" class="sidebar">
		<div class="sidebar-scroll">
			<nav>
				<ul class="nav">
					<li><jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include></li>
				</ul>
			</nav>
		</div>
	</div>
	
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<!-- OVERVIEW -->
				<h3 class="page-title">회원관리 > 회원추가</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
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
								<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList">목록</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
</body>
</html>