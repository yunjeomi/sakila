<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getFilmList</title>
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
					<div class="panel-body">
						<!-- 제목&배우 검색창 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/admin/getFilmList" method="get">
							<select name="selectSearch" class="form-control" style="width:120px;">
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
							<input id="searchWord" type="text" name="searchWord" value="${searchWord}" class="form-control" style="width:200px;" placeholder="검색어를 입력하세요.">
							<button id="searchBtn" class="btn btn-default" type="button">검색</button>
							<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList"><i class="fa fa-refresh"></i></a>
						</form>
						<br>
						
						<!-- 상세검색 창 -->
						<form id="dropDownForm" action="${pageContext.request.contextPath}/admin/getFilmList" method="get">
							<input type="hidden" name="searchWord" value="${searchWord}">
							<input type="hidden" name="selectSearch" value="${selectSearch}">
							<div>
								<!-- category -->
								<select id="categoryName" name="categoryName" class="form-control" style="width:120px;">
									<option value="">category</option>
									<c:forEach var="n" items="${categoryList}">
										<c:if test="${n.name == categoryName}">
											<option value="${n.name}" selected>${n.name}</option>
										</c:if>
										<c:if test="${n.name != categoryName}">
											<option value="${n.name}">${n.name}</option>
										</c:if>
									</c:forEach>
								</select>
								
								<!-- price -->
								<select id="price" name="price" class="form-control" style="width:120px;">
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
								<select id="duration" name="duration" class="form-control" style="width:120px;">
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
								<select id="rating" name="rating" class="form-control" style="width:120px;">
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
							<button id="dropDownBtn" class="btn btn-default" type="button">검색</button>
							</div>
						</form>
						<br>
						
						<!-- 검색결과 -->
						<div>
							<span>&nbsp;</span>
							<c:if test="${selectSearch == null && (categoryName != null || price != null || duration != null || rating != null)}">
								검색결과 (${totalRow})
							</c:if>	
							<c:if test="${selectSearch == 'titleOrActors'}">
								[제목+배우] "${searchWord}" 검색결과 (${totalRow})
							</c:if>
							<c:if test="${selectSearch == 'title'}">
								[제목] "${searchWord}" 검색결과 (${totalRow})
							</c:if>
							<c:if test="${selectSearch == 'actors'}">
								[배우] "${searchWord}" 검색결과 (${totalRow})
							</c:if>
						</div>
						
						<table class="table table-striped">
							<thead>
								<tr>
									<th width="30%">title</th>
									<th width="20%">category</th>
									<th>price</th>
									<th>duration</th>
									<th>rating</th>
									<th>length</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="f" items="${filmList}">
									<tr>
										<td><a href="${pageContext.request.contextPath}/admin/getFilmOne?filmId=${f.filmId}">${f.title}</a></td>
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
					            <li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage-1}&searchWord=${searchWord}&selectSearch=${selectSearch}&categoryName=${categoryName}&price=${price}&duration=${duration}&rating=${rating}">이전</a></li>
					        </c:if>
					        <c:if test="${currentPage < lastPage}">
					            <li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getFilmList?currentPage=${currentPage+1}&searchWord=${searchWord}&selectSearch=${selectSearch}&categoryName=${categoryName}&price=${price}&duration=${duration}&rating=${rating}">다음</a></li>
					        </c:if>
					    </ul>
					    <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addFilm">추가</a>
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