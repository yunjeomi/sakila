<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getSalesListByStore</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$(document).ready(function(){
	let storeId = [];
	let payment = [];
	$.ajax({
		url: '/getSalesListByStore',
		type: 'get',
		success: function(jsonData){
			console.log('jsonData 얻어오기');
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
});
</script>
</head>
<body>
<div class="container">
	<h1>getSalesListByStore</h1>
	
	<a href="${pageContext.request.contextPath}/admin/getSalesListByStore">매장별</a>&nbsp;
	<a href="${pageContext.request.contextPath}/admin/getSalesListByCategory">카테고리별</a>&nbsp;
	<a href="${pageContext.request.contextPath}/admin/getBestSellerList">베스트셀러</a>&nbsp;
	
	<div>
		<canvas id="myChart"></canvas>
	</div>
</div>
</body>
</html>