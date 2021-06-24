<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addStaff</title>
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
				<h3 class="page-title">직원정보 > 직원추가</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="addStaffForm" action="${pageContext.request.contextPath}/admin/addStaff" method="post" enctype="multipart/form-data">
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
										<input id="picture" class="form-control" name="multipartFile" type="file">
										<div>최대 100MB까지 가능합니다.</div>
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