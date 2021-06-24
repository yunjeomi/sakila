<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getFilmOne</title>
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
				<h3 class="page-title">영화정보</h3>
				<div class="panel panel-headline">
					<div class="panel-heading">
						<h3 class="panel-title">${getFilmOne.title}</h3>
					</div>
					<div class="panel-body">
						<table class="table">
							<tr>
								<td>category</td>
								<td>${getFilmOne.category}</td>
							</tr>
							<tr>
								<td>description</td>
								<td>${getFilmOne.description}</td>
							</tr>
							<tr>
								<td>price</td>
								<td>${getFilmOne.price}</td>
							</tr>
							<tr>
								<td>rentalDuration</td>
								<td>${getFilmOne.duration}</td>
							</tr>
							<tr>
								<td>
									actors
								</td>
								<td>
									${getFilmOne.actors}
									<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/modifyActorInFilmOne?filmId=${getFilmOne.filmId}&title=${getFilmOne.title}">변경</a>
								</td>
							</tr>
							<tr>
								<td>specialFeatures</td>
								<td>${getFilmOne.specialFeatures}</td>
							</tr>
							<tr>
								<td>releaseYear</td>
								<td>${getFilmOne.releaseYear}</td>
							</tr>
							<tr>
								<td>length</td>
								<td>${getFilmOne.length}</td>
							</tr>
							<tr>
								<td>rating</td>
								<td>${getFilmOne.rating}</td>
							</tr>
							<tr>
								<td>store_1 in stock</td>
								<td>${store1.filmCount}개</td>
							</tr>
							<tr>
								<td>store_2 in stock</td>
								<td>${store2.filmCount}개</td>
							</tr>
						</table>
						<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">목록</a>	
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