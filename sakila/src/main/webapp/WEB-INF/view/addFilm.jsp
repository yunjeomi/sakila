<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addFilm</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
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
<div class="container">
	<h1>addFilm</h1>
	
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
			<input class="btn btn-default" id="addFilmBtn" type="button" value="글입력">
			<input class="btn btn-default" type="reset" value="초기화">
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList">글목록</a>
	</form>	
	
</div>
</body>
</html>