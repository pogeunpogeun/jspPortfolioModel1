<%@include file = "_inc_top.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%@page import="config.Util"%>
<%
	request.setCharacterEncoding("UTF-8");	

	Util util = new Util();
	
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	String email = request.getParameter("email");
	email = util.getNullBlankCheck(email,"");
	email = util.getCheckString(email);
		
	String content = request.getParameter("content");
	content = util.getNullBlankCheck(content,"");
	content = util.getCheckString(content);
	
	String passwd = request.getParameter("passwd");
	passwd = util.getNullBlankCheck(passwd,"");
	passwd = util.getCheckString(passwd);
	
	String subject = request.getParameter("subject");
	subject = util.getNullBlankCheck(subject,"");
	subject = util.getCheckString(subject);
	
	
	BoardBasicDTO arguDto = new BoardBasicDTO();
	arguDto.setNo(no);
	arguDto.setEmail(email);
	arguDto.setContent(content);
	arguDto.setPasswd(passwd);
	arguDto.setSubject(subject);
	
	BoardBasicDAO dao = new BoardBasicDAO();
	int result = dao.setUpdate(arguDto);
	

	if(result > 0) {
		String imsiUrl = "main.jsp?menuGubun=boardBasic_view&no=" + no;
		out.println("<script>");
		//out.println();
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} else {
		String imsiUrl = "main.jsp?menuGubun=boardBasic_sujung&no=" + no;
		out.println("<script>");
		out.println("alert('수정 중 오류가 발생했습니다.');");
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	}
%>