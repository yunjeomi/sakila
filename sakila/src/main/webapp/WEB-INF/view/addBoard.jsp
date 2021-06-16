<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>addBoard</title>

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

<script>
$(document).ready(function() {
	$('#addButton').click(function() {
		
		//파일중 하나라도 첨부되지 않으면 ck = true
		let ck = false;
		let boardfile = $('.boardfile');	//배열
		
		//break; 키워드를 사용하기 위해 boardfile.each(index, item)을 사용하지 않는다.
		for(let item of boardfile){
			if($(item).val() == ''){	//첨부파일이 없을 경우
				ck = true;
				console.log('첨부되지 않은 파일이 있습니다!');
				break;	//break를 사용하지 않으면 없는 갯수만큼 콘솔에 출력된다.
			}
		}
		
		//ck가 true일 경우 우선순위로 둔다.
		if(ck){
			alert('첨부되지 않은 파일이 있습니다!');
		} else if ($('#boardTitle').val() == '') {
			alert('boardTitle을 입력하세요');
			$('#boardTitle').focus();
		} else if ($('#boardContent').val() == '') {
			alert('boardContent을 입력하세요');
			$('#boardContent').focus();
		} else if ($('#boardPw').val().length < 4) {
			alert('boardPw는 4자이상 이어야 합니다');
			$('#boardPw').focus();
		} else {
			$('#addForm').submit();
		}
	});
	
	//<div id="inputFile">에 input type="file" 추가
	$('#addFileBtn').click(function(){
		console.log('addFileBtn click!');
		$('#inputFile').append('<input class="boardfile btn btn-default" type="file" name="boardfile">');
	});
	
	//<div id="inputFile">에 input type="file" 삭제 -> children().last().remove(); 자식의 마지막을 삭제
	$('#delFileBtn').click(function(){
		console.log('delFileBtn click!');
		$('#inputFile').children().last().remove();
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>addBoard</h1>
	<form id="addForm" action="${pageContext.request.contextPath}/admin/addBoard" method="post"
			enctype="multipart/form-data">
		<div>
			<div>
				<button id="addFileBtn" class="btn btn-default" type="button">파일추가</button>
				<button id="delFileBtn" class="btn btn-default" type="button">파일삭제</button>
			</div>
			<div id="inputFile">
			</div>
		</div>
		<br>
		<div class="form-group">
			<label for="boardTitle">boardTitle</label>
			<input id="boardTitle" class="form-control" name="board.boardTitle" type="text">
		</div>
		<div class="form-group">
			<label for="boardContent">boardContent</label>
			<textarea id="boardContent" class="form-control" name="board.boardContent" rows="5" cols="50"></textarea>
		</div>
		<div class="form-group">
			<label for="staffId">name</label>
			<input id="name" class="form-control" name="board.username" type="text" value="${loginStaff.username}" readonly>
			<input class="form-control" name="board.staffId" type="hidden" value="${loginStaff.staffId}">
		</div>
		<div class="form-group">
			<label for="boardPw">boardPw</label>
			<input id="boardPw" class="form-control" name="board.boardPw" type="password">
		</div>
		<div>
			<input id="addButton" class="btn btn-default" type="button" value="글입력">
			<input class="btn btn-default" type="reset" value="초기화">
			<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList">글목록</a>
		</div>
	</form>
</div>
</body>
</html>