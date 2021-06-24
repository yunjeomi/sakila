<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addRental</title>
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
<!-- 검색어 자동완성을 위한  -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script>
$(document).ready(function(){
	let customerId, staffId, filmId, title, inStock, inventoryId, rating, ea;
	let ckBtn = false;
	let arr = [];
	
	//핸드폰 번호 중복 체크
	$('#ckBtn').click(function(){
		console.log('phoneCkBtn 클릭');
		let phone = $('#phone_').val();
		//console.log('입력한 값?-> '+phone);
		$('#phoneCk').empty();
	
		if(!$.isNumeric(phone)) {
            alert('숫자만 입력가능합니다.');
            return;
        }

		$.ajax({
			type:'get',
			url:'/phoneNumListInRental',
			data: {phone : $('#phone_').val()},
			success: function(jsonData) {
				//console.log('얻은data->'+jsonData);
				console.log('얻은data.id->'+jsonData.customerId);
				console.log('얻은data.name->'+jsonData.name);
				if(jsonData != 0){
					$('#phoneCk').text(jsonData.name+'님 환영합니다.');
					customerId = jsonData.customerId;
					//console.log('customerId->'+customerId);
					ckBtn = true;
				} else{
					$('#phoneCk').text('고객 등록 먼저 해주세요.');
					$('#phoneCk').append('<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addCustomer">고객추가</a>');
				}
			}
		});
	});
	
	//영화제목 검색
	$('#textInput_').autocomplete({
		source : function(request, response) {
			 $.ajax({
				type: 'get',
				url: '/filmTitleListByStoreIdInRental',
				data: {keyWord : $('#textInput_').val(), 	//검색 키워드
						storeId : $('#storeId_').val()},	//선택한 storeId
				success: function(jsonData){
					console.log(jsonData)
					response(
						$.map(jsonData, function(item) {
							return{
								label : item.title,		//목록에 표시되는 값
								value : item.title,		//선택 시 input창에 표시되는 값
								title : item.title,
								filmId : item.filmId,	//filmId값 설정
								inStock : item.inStock,
								inventoryId : item.inventoryId,
								rating : item.rating
							}
						})
					) //response
				}
					
			});
		},	//source; 자동완성 대상
		select: function(event, ui){	//영화 선택하는 순간 보유수량이 바로 뜨도록 한다.
			console.log(ui.item);
			console.log('filmId값 넣기 전 value값-> '+ui.item.value);
			//변수에 값 넣어주기
			filmId = ui.item.filmId;
			title = ui.item.title;
			inStock = ui.item.inStock;
			inventoryId = ui.item.inventoryId;
			rating = ui.item.rating;
			console.log('title-> '+title);
			console.log('filmId-> '+filmId);
			console.log('inStock-> '+inStock);
			console.log('inventoryId-> '+inventoryId);
			console.log('rating-> '+rating);
			if($('#storeId_').val() == 0){
				alert('store를 선택하세요!');
				$('#storeId_').focus();
				$('#storeId_').focus(function(){
					$('#textInput_').val(null);
				});
			} else{
				$('#inStock_').empty();
				$('#inStock_').val(inStock);
			}
			
			if(rating == 'NC-17'){
				alert('청소년 관람불가 영화입니다.');
				console.log('청불영화 디버깅-> '+rating);
			}
		},
		focus: function(evnet, ui){ //true설정 시 첫 번째 항목에 자동으로 초점이 맞춰짐; =autoFocus: false
			return false;
		},
		minLength: 2,	//최소 글자
		delay: 500
	})
	
	
	//[+]버튼 클릭하면 위에 입력한 정보들을 대여리스트로 이동시킨다.
	$('#plusBtn').click(function(){
		console.log('plusBtn click!');

		if(ckBtn == false){
			alert('고객 등록을 먼저 해주세요!');
			return;
		}
		
		if(arr.includes(inventoryId)){
			alert('이미 대여리스트에 추가된 영화입니다.');
			return;
		}

		staffId = $('#storeId_').val();
		arr.push(inventoryId);
		
		let plusForm = '';
		plusForm += '<tr>';
		plusForm += '	<td>'+customerId+'</td>';
		plusForm += '	<td>'+title+'</td>';
		plusForm += '	<td>'+$('#storeId_').val()+'</td>';
		plusForm += '<input id="customerId" type="hidden" name="customerId" value="'+customerId+'">';
		plusForm += '<input id="staffId" type="hidden" name="staffId" value="'+staffId+'">';
		plusForm += '<input id="inventoryId" type="hidden" name="inventoryId" value="'+inventoryId+'">';
		plusForm += '</tr>';
		
		$("#addTr").append(plusForm);	//위의 내용들을 대여리스트 테이블에 추가한다.
		
		//filmId, title, inStock, ea 초기화 시킨다.
		$('#textInput_').val('');
		$('#inStock_').val('');
		
		//값 확인하기
		console.log('customerId->'+$('#customerId').val());
		console.log('staffId->'+$('#staffId').val());
		console.log('inventoryId->'+$('#inventoryId').val());
	});
	
	$('#addBtn').click(function(){
		console.log('addBtn click!');
		
		if($('#inventoryId').val() == null){
			alert('대여리스트 추가 후 대여 가능합니다.');
		} else{
			$('#addForm').submit();
			alert('대여 완료.');
		}
	})
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
				<h3 class="page-title">대여</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<table class="table table-hover">
							<tr>
								<td width="20%">customerPhone</td>
								<td>
									<div>
										<input id="phone_" class="form-control" type="text" name="customerId_" placeholder="phoneNumber 입력">
									</div>
									<div>
										<button id="ckBtn" class="btn btn-default" type="button">확인</button>
										<span id="phoneCk"></span>
									</div>
								</td>
							</tr>
							<tr>
								<td>storeId</td>
								<td>
									<select id="storeId_" class="form-control" name="storeId_">
										<option value="0">==store==</option>
										<option value="1">1</option>
										<option value="2">2</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td>title</td>
								<td>
									<div><input id="filmId_" class="form-control" type="hidden" name="filmId_" value="0"></div>
									<div><input id="textInput_" class="form-control" type="text" name="title_" placeholder="title을 입력해주세요"></div>
								</td>
							</tr>
							
							<tr>
								<td>보유재고</td>
								<td>
									<input id="inStock_" class="form-control" type="text" name="inStock_" readonly>
								</td>
							</tr>
						</table>
						<div>
							<button id="plusBtn" class="btn btn-default" type="button">+</button>
						</div>
					</div>
				</div>
					<hr>
				<h3 class="page-title">대여리스트</h3>
				<div class="panel panel-headline">	
					<div class="panel-body">
						<form id="addForm" action="${pageContext.request.contextPath}/admin/addRental" method="post">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>customerId</th>
										<th>title</th>
										<th>storeId</th>
									</tr>
								</thead>
								<tbody id="addTr">
								</tbody>
							</table>
							<div>
								<button id="addBtn" class="btn btn-default" type="button">대여</button>
								<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList">취소</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
</body>
</html>