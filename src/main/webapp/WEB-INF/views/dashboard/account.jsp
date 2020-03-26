<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./layout/global.jsp"%>
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
			if(data == "") {
				var html = "등록된 계좌가 없습니다."
				html += "<button class='btn btn-primary' onclick='location.href=`enroll-account`'>계좌정보 등록</button>"
				$("#output").html(html);
			}else{
				var html = "";
				html += "<div class='box'>";
				html += "<div class='item'>";
				html += "<div class='title'>이름</div>";
				html += "<div class='value'>"+data.name+"</div>";
				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>전화번호</div>";
				html += "<div class='value'>"+data.phone+"</div>";
				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>주민번호</div>";
				html += "<div class='value'>"+data.registrationNumber+"</div>";
				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>은행</div>";
				html += "<div class='value'>"+data.bankName+"</div>";
				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>계좌주</div>";
				html += "<div class='value'>"+data.accountHolderName+"</div>";
				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>계좌번호</div>";
				html += "<div class='value'>"+data.accountNumber+"</div>";
				html += "</div>"
				html += "<div class='item'>";
// 				html += "<div class='title'>신분증</div>";
// 				html += "<div class='value'><img src='"+data.idCard+"'></div>";
// 				html += "</div>"
// 				html += "<div class='item'>";
// 				html += "<div class='title'>통장사본</div>";
// 				html += "<div class='value'><img src='"+data.copyOfBankbook+"'></div>";
// 				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>실명인증여부</div>";
				html += "<div class='value'>"+data.inquiryName+"</div>";
				html += "</div>"
				html += "<div class='item'>";
				html += "<div class='title'>최종승인여부</div>";
				html += "<div class='value'>"+data.approved+"</div>";
				html += "</div>"
				html += "</div>";
				html += "<button class='btn btn-warning' onclick='deleteAccount()'>계좌정보 삭제</button>"

				$("#output").html(html);
			}
			console.log(data);	
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
}
.title{
	font-weight: bold;
}
.item > div{
	display: inline-block;
}
</style>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<%@ include file="./layout/nav.jsp"%>
<main>
<div>
	<div id="output"></div>
</div>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>