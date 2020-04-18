<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<title>Insert title here</title>

<!-- google charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>

	$(document).ready(function() {
		google.charts.load('current', {
			'packages' : [ 'line', 'controls' ]
		});
		chartDrowFun.chartDrow(); //chartDrow() 실행
	});

	function getWebtoons(curPage) {
		$.ajax({
			url : "<c:url value='/api/webtoons'/>", // core/webtoons
			type : "GET",
			data : {
				authorId : "${sessionScope.loginUser.userId}"
			},
			success : function(data) {
				console.log(data);
				var template = $('#myWebtoonListTemplate');
				bindTemplate(template, data.webtoonList);
			},
			error : function(err) {
				console.log(err);
			}
		})
	}

	var chartDrowFun = {

		chartDrow : function() {
			var chartData = '';

			var chartDateformat = 'yyyy.MM.dd';
			//라인차트의 라인 수
			var chartLineCount = 10;
			//컨트롤러 바 차트의 라인 수
			var controlLineCount = 10;

			function drawDashboard() {

				var data = new google.visualization.DataTable();
				//그래프에 표시할 컬럼
				data.addColumn('datetime', 'date');
				data.addColumn('number', 'hit1');
				data.addColumn('number', 'hit2');
				data.addColumn('number', 'hit3');

				//그래프에 표시할 데이터
				var dataRow = [];

				for (var i = 0; i <= 29; i++) { //랜덤 데이터 생성

					//hit1,hit2,hit3에 에피소드 hit수가 들어가야함. 랜덤값 테스트
					var hit1 = Math.floor(Math.random() * 300) + 1;
					var hit2 = Math.floor(Math.random() * 200) + 1;
					var hit3 = Math.floor(Math.random() * 100) + 1;

					dataRow = [ new Date('2020', '04', i, '10'), hit1, hit2, hit3 ];
					data.addRow(dataRow);
				}

				var chart = new google.visualization.ChartWrapper({
					chartType : 'LineChart',
					containerId : 'lineChartArea', //라인 차트 생성할 영역
					options : {
						isStacked : 'percent',
						focusTarget : 'category',
						height : 500,
						width : '100%',
						legend : {
							position : "top",
							textStyle : {
								fontSize : 13
							}
						},
						pointSize : 5,
						tooltip : {
							textStyle : {
								fontSize : 12
							},
							showColorCode : true,
							trigger : 'both'
						},
						hAxis : {
							format : chartDateformat,
							gridlines : {
								count : chartLineCount,
								units : {
									years : {
										format : [ 'yyyy' ]
									},
									months : {
										format : [ 'MM' ]
									},
									days : {
										format : [ 'dd' ]
									},
									hours : {
										format : [ 'HH' ]
									}
								}
							},
							textStyle : {
								fontSize : 12
							}
						},
						vAxis : {
							minValue : 100,
							viewWindow : {
								min : 0
							},
							gridlines : {
								count : -1
							},
							textStyle : {
								fontSize : 12
							}
						},
						animation : {
							startup : true,
							duration : 1000,
							easing : 'in'
						},
						annotations : {
							pattern : chartDateformat,
							textStyle : {
								fontSize : 15,
								bold : true,
								italic : true,
								color : '#871b47',
								auraColor : '#d799ae',
								opacity : 0.8,
								pattern : chartDateformat
							}
						}
					}
				});

				var control = new google.visualization.ControlWrapper({
					controlType : 'ChartRangeFilter',
					containerId : 'controlsArea', //control bar를 생성할 영역
					options : {
						ui : {
							chartType : 'LineChart',
							chartOptions : {
								chartArea : {
									'width' : '60%',
									'height' : 80
								},
								hAxis : {
									'baselineColor' : 'none',
									format : chartDateformat,
									textStyle : {
										fontSize : 12
									},
									gridlines : {
										count : controlLineCount,
										units : {
											years : {
												format : [ 'yyyy' ]
											},
											months : {
												format : [ 'MM' ]
											},
											days : {
												format : [ 'dd' ]
											},
											hours : {
												format : [ 'HH' ]
											}
										}
									}
								}
							}
						},
						filterColumnIndex : 0
					}
				});

				var date_formatter = new google.visualization.DateFormat({
					pattern : chartDateformat
				});
				date_formatter.format(data, 0);

				var dashboard = new google.visualization.Dashboard(document
						.getElementById('Line_Controls_Chart'));
				window.addEventListener('resize', function() {
					dashboard.draw(data);
				}, false); //화면 크기에 따라 그래프 크기 변경
				dashboard.bind([ control ], [ chart ]);
				dashboard.draw(data);

			}
			google.charts.setOnLoadCallback(drawDashboard);

		}
	}
</script>

</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Analysis</h2><hr>

<h4>overview hits</h4>
	<div id="Line_Controls_Chart">
      <!-- 라인 차트 생성할 영역 -->
		<div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
      <!-- 컨트롤바를 생성할 영역 -->
		<div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
	</div>
 



<h4>all hits</h4>
<table>
	<tr>
		<th>
			Webtoon
		</th>
		
		<th>
			Hits
		</th>
	</tr>
	<script id="myWebtoonListTemplate" type="text/x-handlebars-template">
	{{#each .}}
	<tr>
		<td onclick = "location.href = '../dashboard/analysis/{{webtoonId}}'">
			<img src = "{{thumbnail}}" width = "100px">
		</td>
		<td onclick = "location.href = '../dashboard/analysis/{{webtoonId}}'">
			{{title}}
		</td>
		<td onclick = "location.href = '../dashboard/analysis/{{webtoonId}}'">
			{{hits}}
		</td>

	</tr>
	{{/each}}
	</script>
</table>

<h4>all dotples</h4>
<table>
	<tr>
		<th>
			Episode
		</th>
		<th>
			count_dotple
		</th>
	</tr>
	<script id="myEpisodeListTemplate" type="text/x-handlebars-template">
	{{#each .}}
	<tr>
		<td onclick = "location.href = '../dashboard/analysis/{{episodeId}}'">
			<img src = "{{thumbnail}}" width = "100px">
		</td>
		<td onclick = "location.href = '../dashboard/analysis/{{episodeId}}'">
			{{title}}
		</td>
		<td onclick = "location.href = '../dashboard/analysis/{{episodeId}}'">
			count_dotple  
		</td>

	</tr>
	{{/each}}
	</script>
</table>
	
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>