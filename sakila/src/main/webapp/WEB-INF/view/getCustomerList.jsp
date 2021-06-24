<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCustomerList</title>
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
		console.log('searchBtn click!');
		$('#searchForm').submit();
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
				<h3 class="page-title">회원관리</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="searchForm" action="${pageContext.request.contextPath}/admin/getCustomerList" method="get">
							<select name="storeId" class="form-control" style="width:120px;">
								<option value="">==store==</option>
								<c:if test="${storeId == 1}">
									<option value="1" selected>1</option>
								</c:if>
								<c:if test="${storeId != 1}">
									<option value="1">1</option>
								</c:if>
								<c:if test="${storeId == 2}">
									<option value="2" selected>2</option>
								</c:if>
								<c:if test="${storeId != 2}">
									<option value="2">2</option>
								</c:if>
							</select>
							<input type="text" name="searchWord" class="form-control" style="width:200px;" placeholder="이름+번호 검색">
							<button id="searchBtn" class="btn btn-default" type="button">검색</button>
							<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList"><i class="fa fa-refresh"></i></a>
						</form>
						<br>
						
						<div>
							<span>&nbsp;</span>
							<c:if test="${storeId != null}">
								[store${storeId}]
							</c:if>
							<c:if test="${searchWord != null}">
								"${searchWord}"
							</c:if>
							<c:if test="${storeId != null || searchWord != null}">
								검색결과 (${totalRow})
							</c:if>
						</div>
						
						<table class="table table-striped">
							<thead>
								<tr>
									<th width="35%">customerName</th>
									<th width="35%">phone</th>
									<th width="15%">storeId</th>
									<th width="15%">BLACK&VIP</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="c" items="${customerList}">
									<tr>
										<td>
											<a href="${pageContext.request.contextPath}/admin/getCustomerOne?customerId=${c.customerId}">${c.name}</a>
											
										</td>
										<td>${c.phone}</td>
										<td>${c.storeId}</td>
										<td>${c.blackAndVip}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<!-- 페이징 -->
						<ul class="pager">
						<c:if test="${currentPage>1}">
							<li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
						</c:if>
						<c:if test="${currentPage<lastPage}">
							<li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
						</c:if>
						</ul>
						
						<br>
						<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addCustomer">추가</a>
					</div>
				</div>
				
				<hr>
				<div>vip : 대여횟수 30회 이상, 구매금액 150달러 이상, not black</div>
				<div>black : 연체횟수 15번 이상</div>
			</div>
		</div>
	</div>
		

	<div class="clearfix"></div>
	<footer>
		<div class="container-fluid">
			<p class="copyright">Copyright © yunjeong All Rights Reserved. Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
		</div>
	</footer>
</div>
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
</body>
</html>