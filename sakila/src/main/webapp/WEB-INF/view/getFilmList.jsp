<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getFilmList</title>
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
	$('#searchBtn').click(function(){
		//검색어 입력해야만 버튼이 눌리도록 한다.
		if ($('#searchWord').val() == '') {
			alert('검색어를 입력해주세요!');
			$('#searchWord').focus();
		} else {
			$('#searchForm').submit();
		}
	});
	
	$('#dropDownBtn').click(function(){
		//상세검색 3개중 최소 하나라도 선택하도록 한다. 셋 다 선택하지 않고 검색 눌렀을 경우 알람창 뜨도록 함
		if ($('#categoryName').val() == '' && $('#price').val() == '' && $('#duration').val() == '' && $('#rating').val() == '') {
			alert('상세검색을 선택하세요!');
			$('#categoryName').focus();
		} else {
			$('#dropDownForm').submit();
		}
	});
	
});

</script>
</head>
<body>
<div class="container">
	<h1>getFilmList</h1>
	
	<!-- 목록보기 위해 임시로 추가 -->
	<a href="${pageContext.request.contextPath}/admin/getFilmList">영화정보</a>
	<br><br>
	<form id="searchForm" action="${pageContext.request.contextPath}/admin/getFilmList" method="get">
		<select name="selectSearch">
			<c:if test="${selectSearch == 'titleOrActors'}">
				<option value="titleOrActors" selected>제목+배우</option>
			</c:if>
			<c:if test="${selectSearch != 'titleOrActors'}">
				<option value="titleOrActors">제목+배우</option>
			</c:if>
			<c:if test="${selectSearch == 'title'}">
				<option value="title" selected>제목</option>
			</c:if>
			<c:if test="${selectSearch != 'title'}">
				<option value="title">제목</option>
			</c:if>
			<c:if test="${selectSearch == 'actors'}">
				<option value="actors" selected>배우</option>
			</c:if>
			<c:if test="${selectSearch != 'actors'}">
				<option value="actors">배우</option>
			</c:if>
			
		</select>
		
		<input id="searchWord" type="text" name="searchWord" value="${searchWord}">
		<button id="searchBtn" type="button">검색</button>
	</form>
	
	<br>
	
	<form id="dropDownForm" action="${pageContext.request.contextPath}/admin/getFilmList" method="get">
		<input type="hidden" name="searchWord" value="${searchWord}">
		<input type="hidden" name="selectSearch" value="${selectSearch}">
		<div>
			상세검색 
			
			<!-- category -->
			<select id="categoryName" name="categoryName">
				<option value="">category</option>
				<c:forEach var="n" items="${categoryNameList}">
					<c:if test="${n == categoryName}">
						<option value="${n}" selected>${n}</option>
					</c:if>
					<c:if test="${n != categoryName}">
						<option value="${n}">${n}</option>
					</c:if>
				</c:forEach>
			</select>
			
			<!-- price -->
			<select id="price" name="price">
				<option value="">price</option>
					<c:if test="${price == 0.99}">
						<option value="0.99" selected>0.99</option>
					</c:if>
					<c:if test="${price != 0.99}">
						<option value="0.99">0.99</option>
					</c:if>
					<c:if test="${price == 2.99}">
						<option value="2.99" selected>2.99</option>
					</c:if>
					<c:if test="${price != 2.99}">
						<option value="2.99">2.99</option>
					</c:if>
					<c:if test="${price == 4.99}">
						<option value="4.99" selected>4.99</option>
					</c:if>
					<c:if test="${price != 4.99}">
						<option value="4.99">4.99</option>
					</c:if>
			</select>
			
			<!-- duration -->
			<select id="duration" name="duration">
				<option value="">duration</option>
				<c:forEach var="d" begin="3" end="7" step="1">
					<c:if test="${d == duration}">
						<option value="${d}" selected>${d}</option>
					</c:if>
					<c:if test="${d != duration}">
						<option value="${d}">${d}</option>
					</c:if>
				</c:forEach>
			</select>
			
			<!-- rating; 등급 -->
			<select id="rating" name="rating">
				<option value="">rating</option>
				<c:forEach var="r" items="${ratingList}">
					<c:if test="${r == rating}">
						<option value="${r}" selected>${r}</option>
					</c:if>
					<c:if test="${r != rating}">
						<option value="${r}">${r}</option>
					</c:if>
				</c:forEach>
			</select>
		<button id="dropDownBtn" type="button">검색</button>
		</div>
	</form>
	
	<br>
	<c:if test="${searchWord == null}">
		<div>검색결과 ${totalPage}개</div>
	</c:if>	
	<c:if test="${selectSearch.equals('titleOrActors')}">
		<div>[제목+배우] "${searchWord}" (검색결과 ${totalPage}개)</div>
	</c:if>
	<c:if test="${selectSearch.equals('title')}">
		<div>[제목] "${searchWord}" (검색결과 ${totalPage}개)</div>
	</c:if>
	<c:if test="${selectSearch.equals('actors')}">
		<div>[배우] "${searchWord}" (검색결과 ${totalPage}개)</div>
	</c:if>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>title</th>
				<th>category</th>
				<th>price</th>
				<th>duration</th>
				<th>rating</th>
				<th>length</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="f" items="${filmList}">
				<tr>
					<td><a href="${pageContext.request.contextPath}/admin/getFilmOne?title=${f.title}">${f.title}</a></td>
					<td>${f.category}</td>
					<td>${f.price}</td>
					<td>${f.duration}</td>
					<td>${f.rating}</td>
					<td>${f.length}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<ul class="pager">
        <c:if test="${currentPage > 1}">
            <li class="previous"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage-1}&searchWord=${searchWord}&selectSearch=${selectSearch}&categoryName=${categoryName}&price=${price}&duration=${duration}&rating=${rating}">이전</a></li>
        </c:if>
        <c:if test="${currentPage < lastPage}">
            <li class="next"><a href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage+1}&searchWord=${searchWord}&selectSearch=${selectSearch}&categoryName=${categoryName}&price=${price}&duration=${duration}&rating=${rating}">다음</a></li>
        </c:if>
    </ul>
</div>
</body>
</html>