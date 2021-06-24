<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addInventory</title>
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
	let filmId, title;
	
	$('#textInput').autocomplete({
		source : function(request, response) {
			 $.ajax({
				type: 'get',
				url: '/filmTitleList',
				data: {keyWord : $('#textInput').val()},	//검색 키워드
				success: function(jsonData){
					//console.log(jsonData)
					response(
						$.map(jsonData, function(item) {
							return{
								label : item.title,		//목록에 표시되는 값
								value : item.title,		//선택 시 input창에 표시되는 값
								title : item.title,
								filmId : item.filmId	//filmId값 설정
							}
						})
					) //response
				}
					
			});
		},	//source; 자동완성 대상
		select: function(event, ui){	//포커스 시 이벤트
			console.log(ui.item);
			console.log('filmId값 넣기 전 value값-> '+ui.item.value);
			filmId = ui.item.filmId;
			title = ui.item.title;
			console.log('title-> '+title);
			console.log('filmId-> '+filmId);
		},
		focus: function(evnet, ui){ //true설정 시 첫 번째 항목에 자동으로 초점이 맞춰짐; =autoFocus: false
			return false;
		},
		minLength: 2,	//최소 글자
		delay: 500
	})

	$('#addBtn').click(function(){
		console.log('addBtn click!');
		
		//위에서 받아온 filmId값을 넣어준다.
		console.log('값 넣기 전 filmId은 ?-> '+$('#filmId').val());
		$('#filmId').attr('value', filmId);
		console.log('값 넣은 후 filmId은 ?-> '+$('#filmId').val());
		
		//등록되지 않은 영화 판별위한 디버깅
		console.log('선택한 title은 ?-> '+title);
		console.log('입력된 title은 ?-> '+$('#textInput').val());
		
		//유효성 검사
		if($('#storeId').val() == 0){
			alert('store를 선택하세요!');
		} else if(title != $('#textInput').val()){	//title 비교 혹은 filmId == 0일 때
			alert('등록되지 않은 영화입니다. 추가하세요!');
		} else if($('#ea').val() == null || $('#ea').val()<1){
			alert('수량을 1이상 입력하세요!');
		} else{
			$('#addForm').submit();
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
				<h3 class="page-title">재고관리 > 재고추가</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="addForm" action="${pageContext.request.contextPath}/admin/addInventory" method="post">
							<table class="table table-hover">
								<tr>
									<td>storeId</td>
									<td>
										<select id="storeId" class="form-control" name="storeId">
											<option value="0">==store==</option>
											<option value="1">1</option>
											<option value="2">2</option>
										</select>
									</td>
								</tr>
								
								<tr>
									<td>title</td>
									<td>
										<div><input id="filmId" class="form-control" type="hidden" name="filmId" value="0"></div>
										<div><input id="textInput" class="form-control" type="text" name="title" placeholder="title을 입력해주세요"></div>
									</td>
								</tr>
								
								<tr>
									<td>수량</td>
									<td>
										<input id="ea" class="form-control" type="number" name="ea" min="1" max="5">
									</td>
								</tr>
							</table>
							<div>
								<button id="addBtn" class="btn btn-default" type="button">추가</button>
								<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList">목록</a>
								<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addFilm">영화추가</a>
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