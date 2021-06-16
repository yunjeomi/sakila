<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getBestSellerList</title>
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
<div class="container">
	<h1>getBestSellerList</h1>
	
	<a href="${pageContext.request.contextPath}/admin/getSalesListByStore">매장별</a>&nbsp;
	<a href="${pageContext.request.contextPath}/admin/getSalesListByPeriod">기간별</a>&nbsp;
	<a href="${pageContext.request.contextPath}/admin/getSalesListByCategory">카테고리별</a>&nbsp;
	<a href="${pageContext.request.contextPath}/admin/getBestSellerList">베스트셀러</a>&nbsp;
	
	<div>
		<canvas id="myChart"></canvas>
	</div>
</div>
</body>
</html>