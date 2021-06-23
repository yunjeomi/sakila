<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/linearicons/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/chartist/css/chartist-custom.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
<script>
$(document).ready(function(){
	$('#btn').click(function(){
		console.log('btn click');
		$('#loginForm').submit();
	});
});

</script>
</head>
<body>
<div>
<!-- 로그인 전; session 사용 시 == null, != null 로 반드시 바꿀 것 -->
<c:if test="${loginStaff == null}">
	
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<div class="header">
								<div class="logo text-center"><h2>Sakila</h2></div>
								<p class="lead">Login to your account</p>
							</div>
							<form id="loginForm" class="form-auth-small" action="${pageContext.request.contextPath}/login" method="post">
								<div class="form-group">
									<label for="email" class="control-label sr-only">Email</label>
									<input id="email" class="form-control" name="email" type="email" value="Mike.Hillyer@sakilastaff.com" placeholder="Email">
								</div>
								<div class="form-group">
									<label for="password" class="control-label sr-only">Password</label>
									<input id="password" class="form-control" name="password" type="password" value="1234" placeholder="Password">
								</div>
								<button id="btn" class="btn btn-primary btn-lg btn-block" type="button">LOGIN</button>
							</form>
						</div>
					</div>
					<div class="right">
						<div class="overlay"></div>
						<div class="content text">
							<h1 class="heading">Free Bootstrap dashboard template</h1>
							<p>by The Develovers</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
	
<c:if test="${loginStaff != null}"> 
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
</c:if> 
	
</div>
</body>
</html>