<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%@include file = "_inc_top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");	

	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	String passwd = request.getParameter("passwd");
		
	BoardBasicDTO arguDto = new BoardBasicDTO();
	arguDto.setNo(no);
	arguDto.setPasswd(passwd);
	
	BoardBasicDAO dao = new BoardBasicDAO();
	int result = dao.setDelete(arguDto);
	

	if(result > 0) {
		String imsiUrl = "main.jsp?menuGubun=boardBasic_list";
		out.println("<script>");
		//out.println();
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} else {
		String imsiUrl = "main.jsp?menuGubun=boardBasic_sakje&no=" + no;
		out.println("<script>");
		out.println("alert('삭제 중 오류가 발생했습니다.');");
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	}
%>