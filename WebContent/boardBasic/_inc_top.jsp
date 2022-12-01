<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "../_include/inc_header.jsp" %>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<%	
	String imsiSessionChk = "0";

	if (fileName.equals("list")) {
		imsiSessionChk = "X";
	}
		if(imsiSessionChk.equals("0") && sessionNo <= 0) {
			out.println("<script>");
			out.println("alert('로그인 후 이용하세요');");
			out.println("location.href = '" + request.getContextPath() + "';");
			out.println("</script>");
			return;
		}
		
	
	
%>