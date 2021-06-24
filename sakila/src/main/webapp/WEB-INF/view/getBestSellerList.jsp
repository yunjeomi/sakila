<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getBestSellerList</title>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$(document).ready(function(){
	let title = [];	//책이름
	let data1 = [];		//대여횟수
	let data2 = [];		//판매 금액
	$.ajax({
		url: '/getBestSellerList',
		type: 'get',
		success: function(jsonData){
			console.log('jsonData 얻어오기 성공');
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
			
			var myChart = new Chart(document.getElementById('myChart'), config);
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
				<h3 class="page-title">베스트셀러 판매량</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<div>
							<canvas id="myChart"></canvas>
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