<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(function(){
	getAccount();
	$("#submit").on("click", function(){
		modifyAccount();
	})
})
function getAccount(){
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}",
		type: "get",
		success: function(data){
			console.log(data);	
			if(data == "") {
				alert("등록된 계좌가 없습니다.");
				history(-1);
			}else{
				bindTemplate($("#formTemplate"), data);
			}
		},
		error: function(err){
			console.log(err)
		}
	})
}
function modifyAccount(){
	var form = $('#accountForm')[0];
    var formData = new FormData(form);
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}",
		type: "patch",
		data: formData,
		dataType: 'json',
        contentType : false,
        processData : false,
		success: function(result){
			if(result){
				alert("등록이 성공되었습니다.");
				location.href = "<c:url value='/dashboard/account'/>";	
			}else{
				alert("등록이 실패되었습니다.");
			}
		},
		error: function(err){
			console.log(err);
		}
	});
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<div class="tempalte" id="formTemplate">
	<form id="accountForm">
		이름: <input type="text" id="name" name="name" value="{{name}}"><br>
		전화번호: <input type="text" id="phone" name="phone" value="{{phone}}"><br>
		주민번호: <input type="text" id="registrationNumber" name="registrationNumber" value="{{registrationNumber}}"><br>
		은행: <input type="text" id="bankName" name="bankName" value="{{bankName}}"><br>
		계좌주: <input type="text" id="accountHolderName" name="accountHolderName" value="{{accountHolderName}}"><br>
		계좌번호: <input type="text" id="accountNumber" name="accountNumber" value="{{accountNumber}}"><br>
		신분증: <input type="file" id="idCardImg" name="idCardImg"><br>
		통장사본: <input type="file" id="copyOfBankbookImg" name="copyOfBankbookImg"><br>
	</form>
</div>
<button id="submit">등록</button>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>