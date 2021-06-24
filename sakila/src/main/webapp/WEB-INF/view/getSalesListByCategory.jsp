<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getSalesList</title>
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
	let labels = [];
	let datas = [];
	$.ajax({
		url: '/getSalesListByCategory',
		type: 'get',
		success: function(jsonData){
			console.log('json가져오기 성공');
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
				<h3 class="page-title">카테고리별 판매량</h3>
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