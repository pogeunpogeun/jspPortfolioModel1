<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String jsonFileName = "/Users/macbook01/Desktop/hj/attach/jspPortfolioModel1/json/jsonSample01.json";
	//String jsonFileName = "/jspPortfolioModel1/attach/jspPortfolioModel1/json/jsonSample01.json";
	//String jsonFileName = "../chart/jsonSample01.json";
	//String jsonFileName = "_jsonSample02.json";
	String chartSubject = "차트제목";
	String chartType = "PieChart"; //LineChart, ColumnChart, PieChart
%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawChart); //로딩이 끝나면 drawChart를 호출해라는 뜻..

	function drawChart() { //잘됨
		var data = new google.visualization.DataTable("<%=jsonFileName%>");

		var options = {
			title : 'aaaaa',
			//curveType : "function", //LineChart 에서 확인해봐라..
			width : 900,
			height : 500
			//is3D: true //PieChart 에서 붙이면 3D 챠크가 된다.
		};

		var chart = new google.visualization.LineChart(document.getElementById('chart_div')); //LineChart, ColumnChart, PieChart
		chart.draw(data, options);
	}

/*	
	function drawChart___() { //잘됨
		var url = $("#span_path").text() + "/attach/json/${chart_jsonData }";
		var jsonData = $.ajax({
			url : url,
			dataType : "json",
			async : false 
		}).responseText; //responseText; <- 서버에서 응답한 텍스트
		console.log(jsonData);
		//데이타 테이블 생성
		var data = new google.visualization.DataTable(jsonData);
		
		var options = {
			title : '${chart_subject }',
			curveType : "function", //LineChart 에서 확인해봐라..
			width : 900,
			height : 500
		};
		
		var chart = new google.visualization.${chart_type }(document.getElementById('chart_div')); //chart_jsonFile_sample01.json , chart_jsonFile_sample02.json
		chart.draw(data, options);
	}
*/	
</script>

<div id="chart_div"></div>
<!-- 차트 새로고침 버튼 -->
<button id="btn" type="button" onclick="drawChart();">refresh</button>
