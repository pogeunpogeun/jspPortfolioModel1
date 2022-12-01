<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int sessionNo = 0;
	String sessionId = "";
	String sessionName = "";
	String sessionGrade = "";
	
	if (session.getAttribute("sessionNo") != null) {
		sessionNo = (Integer) session.getAttribute("sessionNo");
		sessionId = (String) session.getAttribute("sessionId");
		sessionName = (String) session.getAttribute("sessionName");
		sessionGrade = (String) session.getAttribute("sessionGrade");
	}
%>