<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String chartTitle = "장바구니 상품별 가격 합계";
	String chartType = "PieChart"; //PieChart, LineChart, ColumnChart, ComboChart
	String chartCurveType = ""; //function
%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart); //로딩이 끝나면 drawChart()를 호출해라..

  function drawChart() {
  	var url = "mainProc.jsp?menuGubun=chart_dbChartProc";
	var jsonData = $.ajax({
		url : url,
		dataType : "json",
		async : false 
	}).responseText; //responseText; <- 서버에서 응답한 텍스트
    console.log(jsonData);
  //데이타 테이블 생성
    var data = new google.visualization.DataTable(jsonData);
    
    var options = {
      title : '<%=chartTitle %>',
      curveType : "<%=chartCurveType %>",
      width : 900,
      height : 500
    };

    var chart = new google.visualization.<%=chartType %>(document.getElementById('chart_div'));

    chart.draw(data, options);
  }
</script>

<div id="chart_div" style="border: 1px solid red; width: 900px; height: 500px;"></div>