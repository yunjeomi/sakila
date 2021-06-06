<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeInventory</title>
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
<!-- 검색어 자동완성을 위한  -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script>
$(document).ready(function(){
	let filmId, title, inStock;
	
	$('#textInput').autocomplete({
		source : function(request, response) {
			 $.ajax({
				type: 'get',
				url: '/filmTitleListByStoreId',
				data: {keyWord : $('#textInput').val(), 	//검색 키워드
						storeId : $('#storeId').val()},	//선택한 storeId
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
								inventoryId : item.inventoryId
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
			console.log('title-> '+title);
			console.log('filmId-> '+filmId);
			console.log('inStock->'+inStock);
			if($('#storeId').val() == 0){
				alert('store를 선택하세요!');
				$('#storeId').focus();
				$('#storeId').focus(function(){
					$('#textInput').val(null);
				});
			} else{
				$('#inStock').empty();
				$('#inStock').val(inStock);
			}
		},
		focus: function(evnet, ui){ //true설정 시 첫 번째 항목에 자동으로 초점이 맞춰짐; =autoFocus: false
			return false;
		},
		minLength: 2,	//최소 글자
		delay: 500
	})
	

	$('#removeBtn').click(function(){
		console.log('removeBtn click!');
		
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
			alert('등록되지 않은 영화입니다. 다시 선택하세요!');
		} else if($('#ea').val() == null || $('#ea').val()<1){
			alert('수량을 1이상 입력하세요!');
		} else if($('#ea').val() > $('#inStock').val()){
			alert('보유재고를 확인하세요!');
		} else{
			$('#removeForm').submit();
		}
	})
});
</script>
</head>
<body>
<div class="container">
	<h1>addInventory</h1>
	<form id="removeForm" action="${pageContext.request.contextPath}/admin/addInventory" method="post">
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
			<td>보유재고</td>
			<td>
				<input id="inStock" class="form-control" type="text" name="inStock" readonly>
			</td>
		</tr>
		
		<tr>
			<td>삭제수량</td>
			<td>
				<input id="ea" class="form-control" type="number" name="ea" min="1" max="5">
			</td>
		</tr>
		</table>
		<div>
			<button id="removeBtn" class="btn btn-default" type="button">재고삭제</button>
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getInventoryList">재고목록</a>
		</div>
	</form>
</div>
</body>
</html>