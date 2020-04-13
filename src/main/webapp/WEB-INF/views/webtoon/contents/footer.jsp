<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<script>
Handlebars.registerHelper('isFirst', function (maxNo) {
  	return ${episodeNo} === 1;
});
Handlebars.registerHelper('isLast', function (maxNo) {
  	return maxNo === ${episodeNo};
});
$(function(){
	bindTemplate($("#footerTemplate"), webtoon)
})
</script>
<style>
footer{
	position: absolute;
	height: 50px;
	line-height: 50px;
	bottom: 0;
	width: 100%;
	z-index: 9;
	border: 1px solid #a3a3a3;
	display: flex;
	background-color: white;
}
footer .item{
	cursor: pointer;
	text-align: center;
	flex: 1;
	font-weight: bold;
	font-size: 25px;
}
.able:hover{
	color: white;
	background-color: #fbc714;
}
.disabled:hover{
	cursor: not-allowed;
	background-color: #a3a3a3;
}
</style>
<footer>
	<script id="footerTemplate" type="text/x-handlebars-template">
	{{#if (isFirst maxNo)}}
	<div class="item disabled" id="prev""><i class="fas fa-arrow-circle-left"></i></div>
	{{/if}}
	{{#unless (isFirst maxNo)}}
	<div class="item able" id="prev" onclick="location.href='./${episodeNo - 1}'"><i class="fas fa-arrow-circle-left"></i></div>
	{{/unless}}
	{{#if (isLast maxNo)}}
	<div class="item disabled" id="next""><i class="fas fa-arrow-circle-right"></i></div>
	{{/if}}
	{{#unless (isLast maxNo)}}
	<div class="item able" id="next" onclick="location.href='./${episodeNo + 1}'"><i class="fas fa-arrow-circle-right"></i></div>
	{{/unless}}
 	</script>
</footer>