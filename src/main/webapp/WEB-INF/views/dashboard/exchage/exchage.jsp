<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
Handlebars.registerHelper('calcFees', function (nico, amount){
    return (((nico-amount)/nico)*100).toFixed(2)+" %";
});

var me;
$(function(){
	getMe();
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			me = data;
			getTransfers(data.userId);
			$("#exchage").remove();
			bindTemplate($("#exchangeTemplate"), data);
		},
		error: function(err){
			console.log(err);
		}
	})
}
function getTransfers(authorId){
	$.ajax({
		url: "<c:url value='/api/transfers'/>",
		method: "get",
		data:{
			authorId: authorId
		},
		success: function(data){
			console.log(data);
			$("#exchageHistory").remove();
			bindTemplate($("#exchageHistoryTemplate"), data);
		},
		error: function(err){
			console.log(err);
		}
	})
}
function exchage(){
	if($("#exchageNico").val()=="") return;
	var result = confirm("Are you sure you want to exchange "+$("#exchageNico").val()+" Nico?");
	if(result){
		$.ajax({
			url: "<c:url value='/api/nico/exchage'/>",
			method: "post",
			data: {
				userId : ${sessionScope.loginUser.userId},
				nico : $("#exchageNico").val()
			},
			success: function(data){
				alert("The exchange is complete. Please check your account.");
				getMe();
			},
			error: function(err){
				console.log(err);
			}
		})
	}
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Exchage</h2><hr>
<script id="exchangeTemplate" type="text/x-handlebars-template">
<div id="exchage">
	<div class="box">
		<div class="item">
			<div class="title">Charged Nico</div>
			<div class="value">{{nico}} Nico</div>
		</div>
		<div class="item">
			<div class="title">Exchage</div>
			<div class="value"><input type="number" id="exchageNico"></div>
		</div>
		<div class="item">
			<button class="btn btn-primary btn-block" onclick="exchage()">exchange</button>		
		</div>
	</div>
</div>
</script>
<script id="exchageHistoryTemplate" type="text/x-handlebars-template">
<div id="exchageHistory" class="card mt-3">
	<table class="table">
		<tr>
			<th>Exchange nico</th>
			<th>Actual transfer amount</th>
			<th>Fees</th>
			<th>Transfer date</th>
		</tr>
		{{#each .}}
		<tr>
			<td>{{nico}} Nico</td>
			<td>₩ {{amount}}</td>
			<td>{{calcFees nico amount}}</td>
			<td>{{transferDate}}</td>
		</tr>
		{{/each}}
	</table>
</div>
</script>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>