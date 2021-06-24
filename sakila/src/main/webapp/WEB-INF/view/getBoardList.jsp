<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>getBoardList</title>
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
				<h3 class="page-title">게시판</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<!-- 검색어 입력창 -->
					    <form action="${pageContext.request.contextPath}/admin/getBoardList" method="get">
					        <input name="searchWord" type="text" class="form-control" style="width:200px;" placeholder="boardTitle을 입력하세요">
					        <button class="btn btn-default" type="submit">검색</button>
					        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList"><i class="fa fa-refresh"></i></a>
					    </form>
					    <br>
					    
					    <div>
						    <span>&nbsp;</span>
						    <c:if test="${searchWord != null}">
						    	"${searchWord}" 검색결과 (${totalRow})
						    </c:if>
					    </div>
					    
					    <table class="table table-striped">
					        <thead>
					            <tr>
					                <th width="15%">boardId</th>
					                <th width="">boardTitle</th>
					                <th width="20%">insertDate</th>
					            </tr>
					        </thead>
					        <tbody>
					            <c:forEach var="c" items="${boardList}">
					                <tr>
					                    <td>${c.boardId}</td>
					                    <td><a href="${pageContext.request.contextPath}/admin/getBoardOne?boardId=${c.boardId}">${c.boardTitle}</a></td>
					                    <td>${c.insertDate}</td>
					                </tr>
					            </c:forEach>
					        </tbody>
					    </table>
					    
					    <ul class="pager">
					        <c:if test="${currentPage > 1}">
					            <li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
					        </c:if>
					        <c:if test="${currentPage < lastPage}">
					            <li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
					        </c:if>
					    </ul>
					    <div>
					        <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addBoard">추가</a>
					    </div>
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