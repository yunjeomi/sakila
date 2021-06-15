<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addPayment</title>
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
$(document).ready(function(){
	let customerId, title, rentalId, rentalDate, rentalDuration, paymentFee;
	let ckBtn = false;
	let ckList = false;
	let paymentTotal = 0;
	let arr = [];
	
	//기존에 입력된 값 있을 경우 초기화 해준다.
	$('#phone').click(function(){
		console.log('phone번호 창 클릭');
		$('#phone').val('');
		$('#phoneCk').empty();
		$('#title').empty();
		$('#rentalDate').val('');
		$('#rentalDuration').val('');
		$('#paymentFee').val('');	
		$("#addTr").empty();	//테이블 내용 초기화
		$('#paymentTotal').empty();	//총 결제금액 칸 초기화
	});
	
	//phone 중복확인 시
	$('#ckBtn').click(function(){
		console.log('ckBtn click!');
		
		$.ajax({
			url: '/paymentListInPayment',
			type: 'get',
			data: { phone : $('#phone').val()},
			dataType: 'json',
			contentType: 'application/json',
			success: function(jsonData){
				$('#title').empty();
				console.log('phone ajax 성공');
				if(jsonData == null){
					$('#phoneCk').text('등록된 고객이 아닙니다.');
					return;
				}
				
				ckBtn = true;	//고객 확인 되었을 경우 ckBtn을 true로 활성화하여 유효성 검사한다.
				
				$(jsonData).each(function(index, item){
					name = item.name;
					console.log('name->'+name);
					$('#phoneCk').text(''+item.name+'님 반갑습니다.');
					return false;	//하나의 값만 얻고 바로 종료하도록,,!
				});
			}
		});
		
	});
	
	$('#storeId').change(function(){
		console.log('storeId change!');
		$.ajax({
			type: 'get',
			url: '/paymentListByStoreIdInPayment',
			data: {phone : $('#phone').val(),
				   storeId : $('#storeId').val()},
			success: function(jsonData){
				console.log('title 가져오기 ajax 성공');
				//console.log('jsonData->'+jsonData);
				
				$('#title').empty();
				
				//대여내역 없을 때
				if(jsonData == ''){
					$('#title').append(
							'<option value="0">대여리스트가 없습니다.</option>'		
					)
					return;
				}
				
				//대여내역 있을 때
				ckList = true;
				$('#title').append(
						'<option value="0">==선택==</option>'		
				)
				$(jsonData).each(function(index, item){
					$('#title').append(
						'<option value="'+item.title+'">'+item.title+'</option>'		
					)
				});
			}
		});
	});
	
	//store 먼저 클릭했을 때 -> phone 검색 하도록
	$('#storeId').click(function(){
		if(ckBtn == false){
			alert('회원 검색을 먼저 해주세요.');
			return;
		}
	});
	
	//title 먼저 클릭했을 때 -> phone 검색 -> storeId 선택 하도록
	$('#title').click(function(){
		if(ckBtn == false){
			alert('회원 검색을 먼저 해주세요.');
			$('#phone').focus();
			return;
		}
		
		if($('#storeId').val() == 0){
			alert('storeId를 선택하세요');
			$('#storeId').focus();
			return;
		} 
	});
	
	//title select-option으로 선택했을 시
	$('#title').change(function(){
		console.log('title change!');
		$.ajax({
			url: '/paymentListByTitleInPayment',
			type: 'get',
			data: {phone : $('#phone').val(),
					storeId : $('#storeId').val(),
					title : $('#title').val()},
			dataType: 'json',
			contentType: 'application/json',
			success: function(jsonData){
				console.log('paymentInfo ajax 성공');
				//console.log('jsonData->'+jsonData);
				$('#rentalDate').empty();
				$('#rentalDuration').empty();
				$('#paymentFee').empty();
				$(jsonData).each(function(index, item){
					customerId = item.customerId;
					title = item.title;
					rentalId = item.rentalId;
					//rentalDate = item.rentalDate; 날짜 변환 포맷을 대신 사용한다
					rentalDate = moment(item.rentalDate).format("YYYY-MM-DD HH:mm:ss");
					//console.log('rentalDate->'+rentalDate);
					rentalDuration = item.rentalDuration;
					paymentFee = item.paymentFee;
					$('#rentalDate').val(rentalDate);
					$('#rentalDuration').val(rentalDuration);
					$('#paymentFee').val(paymentFee);
				});
			}
		});
	});
	
	//[+]버튼 클릭했을 때
	$('#plusBtn').click(function(){
		console.log('plusBtn click!');
		if(ckBtn == false){
			alert('정보 입력 후 사용 가능합니다.');
			return;
		}
		
		if(ckList == false){
			alert('대여리스트가 없습니다.');
			return;
		}
		
		if(arr.includes(rentalId)){
			alert('이미 리스트에 추가된 항목입니다.');
			return;
		}
		
		arr.push(rentalId);
		console.log('arr->'+arr);
		
		let plusForm = '';
		plusForm += '<tr>';
		plusForm += '	<td>'+customerId+'</td>';
		plusForm += '	<td>'+title+'</td>';
		plusForm += '	<td>'+rentalDate+'</td>';
		plusForm += '	<td>'+rentalDuration+'</td>';
		plusForm += '	<td>'+paymentFee+'</td>';
		plusForm += '<input id="rentalId" type="hidden" name="rentalId" value="'+rentalId+'">';
		plusForm += '<input id="amount" type="hidden" name="amount" value="'+paymentFee+'">';
		plusForm += '</tr>';
		
		paymentTotal += paymentFee;	//총 결제금액
		console.log('총결제금액-> '+paymentTotal);
		$('#paymentTotal').text('총 결제금액 : '+paymentTotal);
		$("#addTr").append(plusForm);	//위의 내용들을 대여리스트 테이블에 추가한다.
		//console.log('rentalId->'+$('#rentalId').val());
		//console.log('amount->'+$('#amount').val());
		
	});
		
	//결제/반납 버튼 클릭 시
	$('#paymentBtn').click(function(){
		if($('#rentalId').val() == null){
			alert('결제리스트 추가 후 결제&반납 가능합니다.');
		} else{
			$('#paymentForm').submit();
		}
	});
})
</script>
</head>
<body>
<div class="container">
	<h1>addPayment</h1>
	<table class="table table-hover">
		<tr>
			<td>customerPhone</td>
			<td>
				<div>
					<input id="phone" class="form-control" type="text" name="customerId" placeholder="phoneNumber 입력">
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
				<div>
					<select id="title" class="form-control" name="title">
						<option value="0">==선택==</option>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<td>대여일</td>
			<td>
				<input id="rentalDate" class="form-control" type="text" name="rentalDate" readonly>
			</td>
		</tr>
		<tr>
			<td>대여기간</td>
			<td>
				<input id="rentalDuration" class="form-control" type="text" name="rentalDuration" readonly>
			</td>
		</tr>
		<tr>
			<td>결제금액</td>
			<td>
				<input id="paymentFee" class="form-control" type="text" name="paymentFee" readonly>
			</td>
		</tr>
	</table>
	<div>
		<button id="plusBtn" class="btn btn-default" type="button">+</button>
	</div>
	
	<hr>
	<h3>결제리스트</h3>
	<form id="paymentForm" action="${pageContext.request.contextPath}/admin/addPayment" method="post">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>customerId</th>
					<th>title</th>
					<th>rentalDate</th>	<!-- realRentalDuration -->
					<th>realRentalDuration</th>
					<th>paymentFee</th>
				</tr>
			</thead>
			<tbody id="addTr">
			</tbody>
		</table>
		<div><span id="paymentTotal"></span></div>
		<br>
		<div>
			<button id="paymentBtn" class="btn btn-default" type="button">결제&반납</button>
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList">취소</a>
		</div>
	</form>
</div>
</body>
</html>