<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getRentalList</title>
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
})
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
				<h3 class="page-title">대여리스트</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="searchForm" action="${pageContext.request.contextPath}/admin/getRentalList" method="get">
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
							<input type="text" name="searchWord"  class="form-control" style="width:200px;" placeholder="title 검색">
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
									<th width="22%">name</th>
									<th width="38%">title</th>
									<th width="20%">rentalDate</th>
									<th width="10%">storeId</th>
									<th width="10%">paymentFee</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="r" items="${rentalList}">
									<tr>
										<td>${r.name}</td>
										<td>${r.title}</td>
										<td>${r.rentalDate}</td>
										<td>${r.storeId}</td>
										<td>${r.paymentFee}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					
						<ul class="pager">
					        <c:if test="${currentPage > 1}">
					            <li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList?currentPage=${currentPage-1}&searchWord=${searchWord}&storeId=${storeId}">이전</a></li>
					        </c:if>
					        <c:if test="${currentPage < lastPage}">
					            <li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList?currentPage=${currentPage+1}&searchWord=${searchWord}&storeId=${storeId}">다음</a></li>
					        </c:if>
					    </ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 대여 프로세스
	rental; rentalId 추가 하는 것.
	payment; 렌탈비를 먼저 받아야 하니까 paymentId도 함께 추가한다. -> rental fee, 반납일 구하는 쿼리 필요 
	rental과 payment의 paymentdate, rentaldate가 같음. -> 즉 두개의 id는 같이 생성된다.
	근데, payment에서 rentalId null인건 대체 무슨 이유인지 모르겠음..
	
	경우의 수 1) 대여하면서 결제한 경우 -> 기본 대여료를 지급했음 -> payment의 amount는 대여료이며, if rental의 return_date가 rentalDuration을 초과한 경우 +1달러, *2일경우 replaceCost
	경우의 수 2) 대여하면서 미 결제한 경우 -> amount는 우선 0 -> 리턴이 찍히면 amount 뜨거나, 결제금액 창을 미리 만들어놓는다.
	-->
	
	<!-- 반납 프로세스
	rental; return_date 오늘로 update 하기
	payment; lastUpdate 오늘로 update. 연체금액있으면 연체금액을 추가로 납입한다.
	-->
</div>
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
</body>
</html>