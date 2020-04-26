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
	$("#accountForm").on("submit", function(e){
		e.preventDefault();
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
				$("#submit").on("click", function(){
					modifyAccount();
				})
				$("#accountForm").on("submit", function(e){
					e.preventDefault();
				})
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
    $("#submit").html('<div class="spinner-border" role="status">'+
  		  '<span class="sr-only">Loading...</span>'+
  			'</div>');
	$("#submit").attr("disabled", "disabled");
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}/put",
		type: "post",
		data: formData,
		dataType: 'json',
        contentType : false,
        processData : false,
		success: function(result){
			if(result){
				alert("Registration was successful.");
				location.href = "<c:url value='/dashboard/account'/>";	
			}else{
				alert("Registration failed.");
				$("#submit").html('Submit');
				$("#submit").removeAttr("disabled", "disabled");
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
<form id="accountForm">
<script id="formTemplate" type="text/x-handlebars-template">
<div class="box">
	<div class="item">
		<div class="title">Name</div>
		<div class="value"><input type="text" id="name" name="name" value="{{name}}"></div>
	</div>
	<div class="item">
		<div class="title">Phone</div>
		<div class="value"><input type="tel" id="phone" name="phone" value="{{phone}}"></div>
	</div>
	<div class="item">
		<div class="title">Registration Number</div>
		<div class="value"><input type="text" id="registrationNumber" name="registrationNumber" value="{{registrationNumber}}"></div>
	</div>
	<div class="item">
		<div class="title">Bank Name</div>
		<div class="value">
			<select name="bankName">
				<option>KDB 산업은행</option>
				<option>IBK 기업은행</option>
				<option>KB 국민은행</option>
				<option>수협은행</option>
				<option>NH 농협은행</option>
				<option>우리은행</option>
				<option>SC 제일은행</option>
				<option>한국씨티은행</option>
				<option>대구은행</option>
				<option>부산은행</option>
				<option>광주은행</option>
				<option>제주은행</option>
				<option>전북은행</option>
				<option>경남은행</option>
				<option>KEB 하나은행</option>
				<option>신한은행</option>
				<option>케이뱅크</option>
				<option>카카오뱅크</option>
				<option>오픈뱅크</option>
			</select>
		</div>
	</div>
	<div class="item">
		<div class="title">Account Holder Name</div>
		<div class="value"><input type="text" id="accountHolderName" name="accountHolderName" value="{{accountHolderName}}"></div>
	</div>
	<div class="item">
		<div class="title">Account Number</div>
		<div class="value"><input type="text" id="accountNumber" name="accountNumber" value="{{accountNumber}}"></div>
	</div>
	<div class="item">
		<div class="title">Id Card</div>
		<div class="value"><input type="file" id="idCardImg" name="idCardImg"></div>
	</div>
	<div class="item">
		<div class="title">Copy Of Bankbook</div>
		<div class="value"><input type="file" id="copyOfBankbookImg" name="copyOfBankbookImg"></div>
	</div>
	<button class="btn btn-primary btn-block" id="submit">Submit</button>
</div>
</script>
</form>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>