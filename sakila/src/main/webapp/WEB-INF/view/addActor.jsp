<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addActor</title>
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
	$('#addActorBtn').click(function(){
		if($('#firstName').val() == ''){
			alert('firstName을 입력하세요');
			$('#firstName').focus()
		} else if($('#lastName').val() == ''){
			alert('lastName을 입력하세요');
			$('#lastName').focus()
		} else{
			console.log('addActor submit 완료!');
			$('#addActorForm').submit();
		}
	});
});
</script>


</head>
<body>
<div class="container">
	<h1>addActor</h1>
	
	<form id="addActorForm" action="${pageContext.request.contextPath}/admin/addActor" method="post">
		<div class="form-group">
			firstName
			<input id="firstName" class="form-control" type="text" name="firstName">
		</div>
		<div class="form-group">
			lastName
			<input id="lastName" class="form-control" type="text" name="lastName">
		</div>
		<button id="addActorBtn" class="btn btn-default" type="button">추가</button>
		<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList">취소</a>
	</form>
</div>
</body>
</html>