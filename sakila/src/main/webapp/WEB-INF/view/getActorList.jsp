<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getActorList</title>
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
		if($('#searchWord').val() == ''){
			alert('검색어를 입력해주세요!');
			$('#searchWord').focus();
		} else{
			console.log('searchForm submit!');
			$('#searchForm').submit();
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
				<h3 class="page-title">배우정보</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<!-- 검색창 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/admin/getActorList" method="get">
							<select name="searchSelect" class="form-control" style="width:120px;">
								<c:if test="${searchSelect == 'actorAndFilm'}">
									<option value="actorAndFilm" selected>배우+영화
								</c:if>
								<c:if test="${searchSelect != 'actorAndFilm'}">
									<option value="actorAndFilm">배우+영화
								</c:if>
								<c:if test="${searchSelect == 'actor'}">
									<option value="actor" selected>배우
								</c:if>
								<c:if test="${searchSelect != 'actor'}">
									<option value="actor">배우
								</c:if>
								<c:if test="${searchSelect == 'film'}">
									<option value="film" selected>영화
								</c:if>
								<c:if test="${searchSelect != 'film'}">
									<option value="film">영화
								</c:if>
							</select>
							<input id="searchWord" type="text" class="form-control" style="width:200px;" name="searchWord" placeholder="검색어를 입력하세요.">
							<button id="searchBtn" class="btn btn-default" type="button">검색</button>
							<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList"><i class="fa fa-refresh"></i></a>
						</form>
						<br>
						
						<!-- 검색결과 간단하게 알려주는 창 -->
						<div>
							<span>&nbsp;</span>
							<c:if test="${searchWord != null && searchSelect == 'actorAndFilm'}">
								[배우+영화] "${searchWord}" 검색결과 (${totalRow})
							</c:if>
							<c:if test="${searchWord != null && searchSelect == 'actor'}">
								[배우] "${searchWord}" 검색결과 (${totalRow})
							</c:if>
							<c:if test="${searchWord != null && searchSelect == 'film'}">
								[영화] "${searchWord}" 검색결과 (${totalRow})
							</c:if>
						</div>
						
						<table class="table table-striped">
							<thead>
								<tr>
									<th width="10%">name</th>
									<th>filmInfo</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="g" items="${actorList}">
									<tr>
										<td>${g.name}</td>
										<td>${g.filmInfo}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<!-- 버튼 -->
						<ul class="pager">
							<c:if test="${currentPage>1}">
								<li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage-1}&searchWord=${searchWord}&searchSelect=${searchSelect}">이전</a></li>
							</c:if>
							<c:if test="${currentPage<lastPage}">
								<li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getActorList?currentPage=${currentPage+1}&searchWord=${searchWord}&searchSelect=${searchSelect}">다음</a></li>
							</c:if>
						</ul>
						
						<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addActor">추가</a>
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