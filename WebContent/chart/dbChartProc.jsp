<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "chart.service.ChartService" %>

<%
	ChartService service = new ChartService(); 
	JSONObject json = service.getChartData();
	
	out.println(json);
%>
