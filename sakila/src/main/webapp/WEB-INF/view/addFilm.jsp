<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addFilm</title>
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
	$('#addFilmBtn').click(function(){
		if($('#title').val() == '' || $('#title').val().lengh < 4){
			alert('title을 4자 이상 입력하세요.');
			$('#title').focus();
		} else if($('#description').val() == ''){
			alert('description을 입력하세요.');
			$('#description').focus();
		} else if($('#category').val() == ''){
			alert('category을 선택하세요.');
			$('#category').focus();
		} else if($('#releaseYear').val() == ''){
			alert('releaseYear을 입력하세요.');
			$('#releaseYear').focus();
		} else if($('#language').val() == ''){
			alert('language을 선택하세요.');
			$('#language').focus();
		} else if($('#originalLanguage').val() == ''){
			alert('originalLanguage을 선택하세요.');
			$('#originalLanguage').focus();
		} else if($('#rentalDuration').val() == ''){
			alert('rentalDuration을 입력하세요.');
			$('#rentalDuration').focus();
		} else if($('#rentalRate').val() == ''){
			alert('rentalRate을 입력하세요.');
			$('#rentalRate').focus();
		} else if($('#length').val() == ''){
			alert('length을 입력하세요.');
			$('#length').focus();
		} else if($('#replacementCost').val() == ''){
			alert('replacementCost을 입력하세요.');
			$('#replacementCost').focus();
		} else if($('#rating').val() == ''){
			alert('rating을 선택하세요.');
			$('#rating').focus();
		} else if($('#specialFeatures').val() == ''){
			alert('specialFeatures을 최소 한 개를 선택하세요.');
			$('#specialFeatures').focus();
		} else {
			console.log('addFilmForm submit!');
			$('#addFilmForm').submit();
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
				<h3 class="page-title">영화정보 > 영화추가</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="addFilmForm" action="${pageContext.request.contextPath}/admin/addFilm" method="post">
							<table class="table table-hover">
								<tr>
									<td>title</td>
									<td>
										<input id="title" class="form-control" type="text" name="film.title">
									</td>
								</tr>
								<tr>
									<td>description</td>
									<td>
										<textarea id="description" class="form-control" rows="5" cols="100" name="film.description"></textarea>
									</td>
								</tr>
								<tr>
									<td>category</td>
									<td>
										<select id="category" class="form-control" name="category.categoryId">
											<option value="">선택</option>
											<c:forEach var="c" items="${categoryList}">
												<option value="${c.categoryId}">${c.name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td>releaseYear</td>
									<td>
										<input id="releaseYear" class="form-control" type="text" name="film.releaseYear" placeholder="ex)2021년 -> 2021" numberOnly>
									</td>
								</tr>
								<tr>
									<td>language</td>
									<td>
										<select id="language" class="form-control" name="film.languageId">
											<option value="">선택</option>
											<c:forEach var="lang" items="${languageList}">
												<option value="${lang.languageId}">${lang.languageId}.${lang.name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td>originalLanguage</td>
									<td>
										<select id="originalLanguage" class="form-control" name="film.originalLanguageId">
											<option value="">선택</option>
											<c:forEach var="lang" items="${languageList}">
												<option value="${lang.languageId}">${lang.languageId}.${lang.name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td>rentalDuration</td>
									<td>
										<input id="rentalDuration" class="form-control" type="text" name="film.rentalDuration">
									</td>
								</tr>
								<tr>
									<td>rentalRate</td>
									<td>
										<input id="rentalRate" class="form-control" type="text" name="film.rentalRate">
									</td>
								</tr>
								<tr>
									<td>length</td>
									<td>
										<input id="length" class="form-control" type="text" name="film.length">
									</td>
								</tr>
								<tr>
									<td>replacementCost</td>
									<td>
										<input id="replacementCost" class="form-control" type="text" name="film.replacementCost">
									</td>
								</tr>
								<tr>
									<td>rating</td>
									<td>
										<select id="rating" class="form-control" name="film.rating">
											<option value="">선택</option>
											<c:forEach var="r" items="${ratingList}">
												<option value="${r}">${r}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td>specialFeatures</td>
									<td>
										<c:forEach var="s" items="${specialFeaturesList}">
											<input id="specialFeatures" type="checkbox" name="specialFeatures" value="${s}">${s}
										</c:forEach>
									</td>
								</tr>
							</table>
							<input class="btn btn-default" id="addFilmBtn" type="button" value="추가">
							<input class="btn btn-default" type="reset" value="초기화">
							<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">목록</a>
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