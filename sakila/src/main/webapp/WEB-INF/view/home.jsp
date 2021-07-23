<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<title>Home</title>
<meta charset="utf-8">
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
	$('#btn').click(function(){
		console.log('btn click');
		$('#loginForm').submit();
	});
	
	//매장별 판매현황
	let storeId = [];
	let payment = [];
	$.ajax({
		url: '${pageContext.request.contextPath}/getSalesListByStore',
		type: 'get',
		success: function(jsonData){
			console.log('매장별 판매현황 jsonData 얻어오기');
			$(jsonData).each(function(index, item){
				storeId.push(item.storeId);
				payment.push(item.totalSales);
			});
			console.log('storeId-> '+storeId);
			console.log('payment-> '+payment);
			
			let data = {
			  labels: storeId,
			  datasets: [{
			    label: 'Sales by store',
			    data: payment,
			    backgroundColor: [
			      'rgba(255, 99, 132, 0.2)',
			      'rgba(255, 159, 64, 0.2)',
			      'rgba(255, 205, 86, 0.2)',
			      'rgba(75, 192, 192, 0.2)',
			      'rgba(54, 162, 235, 0.2)',
			      'rgba(153, 102, 255, 0.2)',
			      'rgba(201, 203, 207, 0.2)'
			    ],
			    borderColor: [
			      'rgb(255, 99, 132)',
			      'rgb(255, 159, 64)',
			      'rgb(255, 205, 86)',
			      'rgb(75, 192, 192)',
			      'rgb(54, 162, 235)',
			      'rgb(153, 102, 255)',
			      'rgb(201, 203, 207)'
			    ],
			    borderWidth: 1
			  }]
			};
			
			let config = {
					  type: 'bar',
					  data: data,
					  options: {
					    scales: {
					      y: {
					        beginAtZero: true
					      }
					    }
					  },
			};
			
			var myChart = new Chart(document.getElementById('myChart'), config);
		}
	});
	
	//카테고리별 판매현황
	let labels = [];
	let datas = [];
	$.ajax({
		url: '${pageContext.request.contextPath}/getSalesListByCategory',
		type: 'get',
		success: function(jsonData){
			console.log('카테고리 판매현황 json가져오기');
			$(jsonData).each(function(index, item){
				labels.push(item.category);
				datas.push(item.totalSales);
			});
			//잘 담겼나 확인
			console.log('labels-> '+labels);
			console.log('datas-> '+datas);
			
			//const labels = Utils.months({count: 7});
			let data = {
						  labels: labels,
						  datasets: [{
								    axis: 'y',
								    //label: 'sales by category',
								    data: datas,
								    fill: false,
								    backgroundColor: [
								      'rgba(255, 99, 132, 0.2)',
								      'rgba(255, 159, 64, 0.2)',
								      'rgba(255, 205, 86, 0.2)',
								      'rgba(75, 192, 192, 0.2)',
								      'rgba(54, 162, 235, 0.2)',
								      'rgba(153, 102, 255, 0.2)',
								      'rgba(201, 203, 207, 0.2)',
								      'rgba(255, 99, 132, 0.2)',
								      'rgba(255, 159, 64, 0.2)',
								      'rgba(255, 205, 86, 0.2)',
								      'rgba(75, 192, 192, 0.2)',
								      'rgba(54, 162, 235, 0.2)',
								      'rgba(153, 102, 255, 0.2)',
								      'rgba(201, 203, 207, 0.2)',
								      'rgba(255, 159, 64, 0.2)'
								    ],
								    borderColor: [
								      'rgb(255, 99, 132)',
								      'rgb(255, 159, 64)',
								      'rgb(255, 205, 86)',
								      'rgb(75, 192, 192)',
								      'rgb(54, 162, 235)',
								      'rgb(153, 102, 255)',
								      'rgb(201, 203, 207)',
								      'rgb(255, 99, 132)',
								      'rgb(255, 159, 64)',
								      'rgb(255, 205, 86)',
								      'rgb(75, 192, 192)',
								      'rgb(54, 162, 235)',
								      'rgb(153, 102, 255)',
								      'rgb(201, 203, 207)',
								      'rgb(255, 159, 64)'
								    ],
								    borderWidth: 1
						  }]
			};
			
			const config = {
						  type: 'bar',
						  data: data,
						  options: {
								    indexAxis: 'y',
								    // Elements options apply to all of the options unless overridden in a dataset
								    // In this case, we are setting the border of each horizontal bar to be 2px wide
								    elements: {
										      bar: {
										        	borderWidth: 2,
										      }
								    },
								    responsive: true,
								    plugins: {
										      legend: {
										        position: 'right',
										      },
										      title: {
										        display: true,
										        text: 'sales by category'
										      }
								    }
						  },
			};
			
			var myChart1 = new Chart(document.getElementById('myChart1'), config);
		}
	});
	
	//베스트셀러 판매현황	
	let title = [];	//책이름
	let data1 = [];		//대여횟수
	let data2 = [];		//판매 금액
	$.ajax({
		url: '${pageContext.request.contextPath}/getBestSellerList',
		type: 'get',
		success: function(jsonData){
			console.log('베스트셀러 jsonData 얻어오기');
			$(jsonData).each(function(index, item){
				title.push(item.title);
				data1.push(item.rentalTotal);
				data2.push(item.paymentTotal);
			});
			console.log('title-> '+title);
			console.log('data1-> '+data1);
			console.log('data2-> '+data2);
			
			//const DATA_COUNT = 7;
			//const NUMBER_CFG = {count: DATA_COUNT, min: -100, max: 100};
		
			let data = {
			  labels: title,
			  datasets: [
			    {
			      label: 'paymentTotal',
			      data: data2,
			      borderColor: 'rgb(255, 99, 132)',
			      backgroundColor: 'rgba(255, 99, 132, 0.2)',
			      order: 1
			    },
			    {
			      label: 'rentalTotal',
			      data: data1,
			      borderColor: 'rgb(54, 162, 235)',
			      backgroundColor: 'rgba(54, 162, 235, 0.2)',
			      type: 'line',
			      order: 0
			    }
			  ]
			};
			
			let config = {
			  type: 'bar',
			  data: data,
			  options: {
			    responsive: true,
			    plugins: {
			      legend: {
			        position: 'top',
			      },
			      title: {
			        display: true,
			        text: 'Best Seller Chart'
			      }
			    }
			  },
			};
			
			var myChart2 = new Chart(document.getElementById('myChart2'), config);
		}
	});
	
	
});
</script>
</head>
<body>
<!-- 로그인 전 -->
<c:if test="${loginStaff == null}">
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<div class="header">
								<div class="logo text-center"><h2>Sakila</h2></div>
								<p class="lead">Login to your account</p>
							</div>
							<form id="loginForm" class="form-auth-small" action="${pageContext.request.contextPath}/login" method="post">
								<div class="form-group">
									<label for="email" class="control-label sr-only">Email</label>
									<input id="email" class="form-control" name="email" type="email" value="Mike.Hillyer@sakilastaff.com" placeholder="Email">
								</div>
								<div class="form-group">
									<label for="password" class="control-label sr-only">Password</label>
									<input id="password" class="form-control" name="password" type="password" value="1234" placeholder="Password">
								</div>
								<button id="btn" class="btn btn-primary btn-lg btn-block" type="button">LOGIN</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>

<!-- 로그인 후 -->
<c:if test="${loginStaff != null}"> 
	<!-- WRAPPER -->
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
					<!-- 1행 -->
					<div class="row">
						<!-- 1-1 -->
						<div class="col-md-6">
							<div class="panel ch-option">
								<div class="panel-heading">
									<h3 class="panel-title">최근 대여 정보</h3>
									<div class="right">
										<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
									</div>
								</div>
								<div class="panel-body">
									<div>
										<table class="table table-striped">
											<tr>
												<th>name</th>
												<th>title</th>
												<th>rental_date</th>
											</tr>
											<c:forEach var="r" items="${rentalList}">
												<tr>
													<td>${r.name}</td>
													<td>${r.title}</td>
													<td>${r.rentalDate}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 1-2 -->
						<div class="col-md-6">
							<div class="panel ch-option">
								<div class="panel-heading">
									<h3 class="panel-title">매장별 판매현황</h3>
									<div class="right">
										<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
									</div>
								</div>
								<div class="panel-body">
									<div>
										<canvas id="myChart"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 2행 -->
					<div class="row">
						<!-- 2-1 -->
						<div class="col-md-6">
							<div class="panel">
								<div class="panel-heading">
									<h3 class="panel-title">카테고리별 판매현황</h3>
									<div class="right">
										<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
									</div>
								</div>
								<div class="panel-body">
									<div>
										<canvas id="myChart1"></canvas>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 2-2 -->
						<div class="col-md-6">
							<div class="panel">
								<div class="panel-heading">
									<h3 class="panel-title">베스트셀러 판매현황</h3>
									<div class="right">
										<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
									</div>
								</div>
								<div class="panel-body">
									<div>
										<canvas id="myChart2"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
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
</c:if>

<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>
