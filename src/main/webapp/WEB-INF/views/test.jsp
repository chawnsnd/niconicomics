<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./layout/global.jsp"%>
<script>
var hashTagArr = [];
var str ="";
$(document).ready(function(){
	$(".inputTag:last").focus();
	keyup();
	keydown();
	$(".container").on("click", function(){
		$(".inputTag:last").focus();
	});
})
function keyup(){
	$(".inputTag").on("keyup", function(e){
		if((e.keyCode == 32 || e.keyCode == 13) && $(this).val().indexOf("#")==0){
			$(this).before("<div class='hashTag'>"+$(this).val().trim()+"</div>");
			$(this).after("<input type='text' class='inputTag'>");
			$(this).remove();
			hashTagArr.push($(this).val().trim());
			console.log("저장된 해시태그: "+hashTagArr);
			keyup();
			keydown();
			$(".inputTag:last").focus();
		}
	})
}
function keydown(){
	$(".inputTag").on("keydown", function(e){
		if(e.keyCode == 8 && $(this).val().length == 0){
			if($(".hashTag").length == 0) return;
			$(this).remove();
			$(".hashTag:last").after("<input type='text' class='inputTag' value="+$(".hashTag:last").text()+">");
			hashTagArr.pop();
			console.log("저장된 해시태그: "+hashTagArr);
			keyup();
			keydown();
			$(".inputTag:last").focus();
			$('.inputTag:last')[0].setSelectionRange($(".inputTag:last").val().length, $(".inputTag:last").val().length);
			$(".hashTag:last").remove();
		}
	})
}
</script>
<style>
.hashTag{
	display: inline-block;
	color: blue;
	margin-right: 5px;
	font-weight: bold;
}
.inputTag{
	border: none;
	outline: none;
	font-weight: bold;
}
.container{
	border: 1px solid gray;
	height: 100px;
	padding: 5px 10px;
	cursor: text; 
}
</style>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<main>
<h1>해시태그</h1>
<div class="container">
<input type="text" class="inputTag" placeholder="크롬 콘솔창으로 확인할 수 있어요">
</div>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>