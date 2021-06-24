<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainMenu</title>
</head>
<body>
	<a href="${pageContext.request.contextPath}/" class="active"><i class="lnr lnr-home"></i><span>HOME</span></a>
	<a href="${pageContext.request.contextPath}/admin/getCustomerList" class=""><i class="lnr lnr-users"></i><span>회원관리</span></a>
	<a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-store"></i><span>대여/반납</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
	<div id="subPages" class="collapse ">
		<ul class="nav">
			<li><a href="${pageContext.request.contextPath}/admin/addRental" class="">대여</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/addPayment" class="">반납</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/getRentalList" class="">리스트</a></li>
		</ul>
	</div>			
	<a href="${pageContext.request.contextPath}/admin/getFilmList" class=""><i class="lnr lnr-film-play"></i><span>영화정보</span></a>
	<a href="${pageContext.request.contextPath}/admin/getActorList" class=""><i class="lnr lnr-users"></i><span>배우정보</span></a>
	<a href="${pageContext.request.contextPath}/admin/getInventoryList" class=""><i class="lnr lnr-layers"></i><span>재고관리</span></a>
	<a href="#subPages2" data-toggle="collapse" class="collapsed"><i class="lnr lnr-chart-bars"></i><span>매출현황</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>
	<div id="subPages2" class="collapse ">
		<ul class="nav">
			<li><a href="${pageContext.request.contextPath}/admin/getSalesListByStore" class="">매장별</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/getSalesListByPeriod" class="">기간별</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/getSalesListByCategory" class="">카테고리별</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/getBestSellerList" class="">베스트셀러</a></li>
		</ul>
	</div>
	<a href="${pageContext.request.contextPath}/admin/getBoardList" class=""><i class="lnr lnr-bullhorn"></i><span>게시판</span></a>
	<a href="${pageContext.request.contextPath}/admin/getStaffList" class=""><i class="lnr lnr-user"></i><span>직원정보</span></a>
	<a href="${pageContext.request.contextPath}/admin/logout" class=""><i class="lnr lnr-exit"></i><span>로그아웃</span></a>
</body>
</html>