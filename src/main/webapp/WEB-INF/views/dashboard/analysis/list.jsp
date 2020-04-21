<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
var webtoonList;
var currentPage = 1;
var totalPageCount = 1;

$(document).ready(function() {
	initPage(1);
});

function initPage(currentPage){
	getWebtoons(currentPage);
	$(webtoonList).each(function(idx, webtoon){
		getEpisodes(webtoon.webtoonId);
		getDonate(webtoon.webtoonId);
	})
	$(webtoonList).each(function(idx,webtoon){
		$(webtoon.episodeList).each(function(idx, episode){
			getDotples(episode.webtoonId, episode.no);
		})
		calcDotples(webtoon.webtoonId);
	})
	bindTemplate($("#myWebtoonListTemplate"), webtoonList);
	$(".chart").hide();	
	google.charts.load('current', { 'packages' : [ 'corechart' ] });
	$("#loadingSpinner").remove();
}

function getDonate(webtoonId){
	$.ajax({
		url : "<c:url value='/api/donates'/>", // core/webtoons
		type : "GET",
		async: false,
		data : {
			webtoonId : webtoonId
		},
		success : function(data) {
			var donatedNico = 0;
			$(data).each(function(idx, donate){
				donatedNico += donate.nico;
			})
			$(webtoonList).each(function(idx, webtoon){
				if(webtoon.webtoonId == webtoonId){
					webtoon.donatedNico = donatedNico;
				}
			})
		},
		error : function(err) {
			console.log(err);
		}
	})
}

function getWebtoons(currentPage) {
	$.ajax({
		url : "<c:url value='/api/webtoons'/>", // core/webtoons
		type : "GET",
		async: false,
		data : {
			authorId : "${sessionScope.loginUser.userId}",
			currentPage : currentPage,
			countPerPage : 10
		},
		success : function(data) {
			webtoonList = data.webtoonList;
			bindTemplate($("#naviTemplate"), data.navi);
			currentPage = (data.navi.currentPage == 0) ? 1 : data.navi.currentPage;
			totalPageCount = (data.navi.totalPageCount == 0) ? 1 : data.navi.totalPageCount;
		},
		error : function(err) {
			console.log(err);
		}
	})
}

function getEpisodes(webtoonId){
	$.ajax({
		url : "<c:url value='/api/webtoons/'/>"+webtoonId+"/episodes", // core/webtoons
		type : "GET",
		data : {
			countPerPage: 300
		},
		async: false,
		success : function(data) {
			$(webtoonList).each(function(idx, webtoon){
				if(webtoon.webtoonId == webtoonId){
					webtoon.episodeList = data.episodeList;
					var allHits = 0;
					$(data.episodeList).each(function(idx, episode){
						allHits += episode.hits;
						episode.dotpleCount = 0;
					})
					webtoon.allHits = allHits;
				}
			})
		},
		error : function(err) {
			console.log(err);
		}
	})
}

function getDotples(webtoonId, episodeNo){
	$.ajax({
		url : "<c:url value='/api/webtoons/'/>"+webtoonId+"/episodes/"+episodeNo+"/dotples", // core/webtoons
		type : "GET",
		async: false,
		success : function(data) {
			dotpleCount = data.length;
			$(webtoonList).each(function(idx, webtoon){
				if(webtoonId == webtoon.webtoonId){
					$(webtoon.episodeList).each(function(idx, episode){
						if(episode.no == episodeNo){
							episode.dotpleCount += dotpleCount;
						}
					})
				}
			})
		},
		error : function(err) {
			console.log(err);
		}
	})
}

function calcDotples(webtoonId){
	var allDotpleCount = 0;
	$(webtoonList).each(function(idx, webtoon){
		if(webtoon.webtoonId == webtoonId){
			$(webtoon.episodeList).each(function(idx, episode){
				allDotpleCount += episode.dotpleCount;
			})
		}
		webtoon.allDotpleCount = allDotpleCount;
	})
}

function drawHits(webtoonId) {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'episode');
	data.addColumn('number', 'hits');
	var dataRow = [];
	$(webtoonList).each(function(idx, webtoon){
		if(webtoon.webtoonId == webtoonId){
			$(webtoon.episodeList).each(function(idx, episode){
				dataRow = [ String(episode.no), episode.hits ];
				data.addRow(dataRow);
			})
		}
	})
	var options = {
			height : 300,
			width: '100%',
			title: "Hits Trend",
			pointSize : 3,
			legend: {
				position : 'none'
			},
			tooltip : {
				showColorCode : true,
				trigger : 'both'
			},
			hAxis : {
				title: 'EPISODE',
				format : 'string',
				direction: -1
			},
			vAxis : {
				title: 'HITS',
				format: 'decimal',
				minValue: 0
			}
	};
	var chart = new google.visualization.LineChart(document.getElementById('chart_'+webtoonId));
	chart.draw(data, options);

}

function drawDotples(webtoonId) {
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'episode');
	data.addColumn('number', 'dotples');
	var dataRow = [];
	$(webtoonList).each(function(idx, webtoon){
		if(webtoon.webtoonId == webtoonId){
			$(webtoon.episodeList).each(function(idx, episode){
				dataRow = [ String(episode.no), episode.dotpleCount ];
				data.addRow(dataRow);
			})
		}
	})
	var options = {
			height : 300,
			width: '100%',
			title: "Dotple Count Trend",
			pointSize : 3,
			series: { 0: {color: '#e83d3d'} },
			legend: {
				position : 'none'
			},
			tooltip : {
				showColorCode : true,
				trigger : 'both'
			},
			hAxis : {
				title: 'EPISODE',
				format : 'string',
				direction: -1
			},
			vAxis : {
				title: 'DOTPLES',
				format: 'decimal',
				minValue: 0
			}
	};
	var chart = new google.visualization.LineChart(document.getElementById('chart_'+webtoonId));
	chart.draw(data, options);

}
function toggleChart(webtoonId){
	console.log(webtoonId)
	$("tr[data-webtoonid="+webtoonId+"]").toggle();
	drawHits(webtoonId);
}
</script>
<style>
.image_container{
	width: 80px;
	height: 50px;
	background-size: cover;
	background-position: center;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Analysis</h2><hr>
<div class="card">
<div class="card-body">
<div id="loadingSpinner" class="d-flex justify-content-center">
	<div class="spinner-border" role="status">
	  <span class="sr-only">Loading...</span>
	</div>
</div>
<script id="naviTemplate" type="text/x-handlebars-template">
<div id="navi" class="float-right mb-3">
	<div class="input-group" style="width: 150px;">
		<div class="input-group-prepend" id="idx"><span class="input-group-text">{{currentPage}} / {{totalPageCount}}</span></div>
		<div class="input-group-append">
			<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}-1)">prev</button>
			<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}+1)">next</button>
		</div>
	</div>
</div>
</script>
<script id="myWebtoonListTemplate" type="text/x-handlebars-template">
<table class="table">
	<tr>
		<th>Thumbnail</th>
		<th width="20%">Title</th>
		<th>All Hits</th>
		<th>All Dotples</th>
		<th>Donated Nico</th>
		<th>Reg Date</th>
	</tr>
	{{#each .}}
	<tr onclick="toggleChart({{webtoonId}})">
		<td>
			<div class="image_container" style="background-image: url({{thumbnail}})"></div>
		</td>
		<td>{{title}}</td>
		<td>{{allHits}}</td>
		<td>{{allDotpleCount}}</td>
		<td>{{donatedNico}} Nico</td>
		<td>{{regDate}}</td>
	</tr>
	<tr class="chart" data-webtoonid={{webtoonId}}>
		<td colspan="6">
		<div style="margin: auto;">
			<div class="form-check form-check-inline">
			<label><input type="radio" class="form-check-input" name="chartCategory-{{webtoonId}}" value="hits" checked="checked" onclick="drawHits({{webtoonId}})">Hits</label>
			<label><input type="radio" class="form-check-input" name="chartCategory-{{webtoonId}}" value="dotples" onclick="drawDotples({{webtoonId}})">Dotples</label>
			</div>
			<div style="width: 100%;" id="chart_{{webtoonId}}"></div>
		</div>
		</td>
	</tr>
	{{/each}}
</table>
</script>
</div>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>