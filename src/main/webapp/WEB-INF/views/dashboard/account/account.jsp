<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
var account = null;
$(function(){
	getAccount();
})
function deleteAccount(){
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}",
		type: "delete",
		success: function(){
			alert("계좌가 삭제되었습니다.")
			history.go(0);
		},
		error: function(err){
			console.log(err);
		}
	})
}
function getAccount(){
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}",
		type: "get",
		success: function(data){
			console.log(data);	
			if(data == "") {
				bindTemplate($("#noAccountTemplate"), data);
			}else{
				bindTemplate($("#accountTemplate"), data);
			}
			account = data;
		},
		error: function(err){
			console.log(err)
		}
	})
}
</script>
<style>
.box{
	border: 1px solid #a3a3a3;
	display: inline-block;
	box-shadow: 3px 3px 5px 0px #6c757d;
	padding: 10px;
	width: 800px;
	position: relative;
}
.title{
	width: 200px;
	font-weight: bold;
}
.item > div{
	display: inline-block;
}
.info{
	margin-top: 10px;
}
.btn-group{
	position: absolute;
	top: 10px;
	right: 10px;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Account</h2><hr>
<div>
	<div id="noAccountTemplate" class="template">
		<div>등록된 계좌가 없습니다.</div>
		<button class='btn btn-outline-secondary btn-sm' onclick='location.href=`enroll-account`'>등록</button>
	</div>
	<div id="accountTemplate" class="template">
		<div class="box">
			<div class="item">
				<div class="title">Name</div>			
				<div class="value">{{name}}</div>
			</div>
			<div class="item">		
				<div class="title">Phone</div>			
				<div class="value">{{phone}}</div>
			</div>
			<div class="item">		
				<div class="title">Registration Number</div>			
				<div class="value">{{registrationNumber}}</div>
			</div>
			<div class="item">		
				<div class="title">Bank Name</div>			
				<div class="value">{{bankName}}</div>
			</div>
			<div class="item">		
				<div class="title">Account Holder Name</div>			
				<div class="value">{{accountHolderName}}</div>
			</div>
			<div class="item">		
				<div class="title">Account Number</div>			
				<div class="value">{{accountNumber}}</div>
			</div>
			<div class="item">		
				<div class="title">Id Card</div>			
				<div class="value"><a href="{{idCard}}">check</a></div>
			</div>
			<div class="item">		
				<div class="title">Copy Of Bankbook</div>			
				<div class="value"><a href="{{copyOfBankbook}}">check</a></div>
			</div>
			<div class="item">		
				<div class="title">Inquiry Name ?</div>			
				<div class="value">{{inquiryName}}</div>
			</div>
			<div class="item">		
				<div class="title">Approved ?</div>			
				<div class="value">{{approved}}</div>
			</div>
			<div class="info">
				If the real name is not verified, the account information needs to be revised to be approved.<br>
				Payment can be made through an approved account.
			</div>
			<div class="btn-group">
				<button class="btn btn-outline-secondary btn-sm" onclick="location.href='modify-account'"><i class="far fa-edit"></i></button>
				<button class="btn btn-outline-danger btn-sm" onclick="deleteAccount()"><i class="far fa-trash-alt"></i></button>
			</div>
		</div>
	</div>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>