<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getSalesListByPeriod</title>
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
	let month = [];
	let totalAmount = [];
	let myChart = null;
	
	//db상 모든 year를 가져온다.
	$.ajax({
		url:'${pageContext.request.contextPath}/getYear',
		type:'get',
		success:function(jsonData){
			//console.log('jsonData 가져오기 성공');
			$('#year').empty();
			$('#year').append(
				'<option value="">==년도선택==</option>'	
			);
			
			$(jsonData).each(function(index, item){
				//console.log('index->'+index);
				//console.log('item->'+item);
				
				$('#year').append(
					'<option value="'+item+'">'+item+'</option>'
				);
			});
			
		}
	});
	
	//조회버튼 클릭 시
	$('#salesBtn').click(function(){
		console.log('salesBtn click!');
		if($('#storeId').val() == ''){
			alert('매장을 선택하세요.');
			return;
		}
		
		if($('#year').val() == ''){
			alert('년도를 선택하세요.');
			return;
		}
		
		$.ajax({
			url:'${pageContext.request.contextPath}/getSalesListByPeriod',
			type:'get',
			data:{ storeId : $('#storeId').val(),
					year : $('#year').val()},
			success:function(jsonData){
				console.log('period jsondata 가져오기');
				
				//이전 데이터가 있을 경우 초기화한다.
				month = [];
				totalAmount = [];
				if(myChart != null){
					myChart.destroy();
				}
				
				$(jsonData).each(function(index, item){
					month.push(item.month);
					totalAmount.push(item.totalAmount);
				});
				
				//값이 제대로 들어갔는지?
				//console.log('month->'+month);
				//console.log('totalAmount->'+totalAmount);
				
				let data = {
				  labels: month,
				  datasets: [{
				    label: 'Sales by Period',
				    data: totalAmount,
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
				
				myChart = new Chart(document.getElementById('myChart'), config);
			}
		});
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
				<h3 class="page-title">기간별 판매량</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="searchBtn" action="${pageContext.request.contextPath}/admin/getSalesListByPeriod" method="get">
							<select id="storeId" class="form-control" style="width:150px;">
								<option value="">==매장선택==</option>
								<option value="0">전체</option>
								<option value="1">store1</option>
								<option value="2">store2</option>
							</select>
							
							<select id="year" class="form-control" style="width:150px;">
							</select>
							
							<button id="salesBtn" class="btn btn-default" type="button">조회</button>
							<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getSalesListByPeriod"><i class="fa fa-refresh"></i></a>
						</form>
						
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