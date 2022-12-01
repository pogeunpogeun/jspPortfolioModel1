<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	session.invalidate(); // 세션제거
	
	out.println("<script>");
	out.println("alert('로그아웃되었습니다.');");
	out.println("location.href = '" + request.getContextPath() + "';");
	out.println("</script>");

	
%>