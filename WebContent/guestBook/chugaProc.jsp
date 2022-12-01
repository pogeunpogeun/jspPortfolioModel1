<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="guestBook.model.dao.GuestBookDAO"%>
<%@page import="guestBook.model.dto.GuestBookDTO"%>
<%@ include file = "../_include/inc_sessionChk.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	Util util = new Util();

	String name = request.getParameter("name");
	name = util.getNullBlankCheck(name,"");
	name = util.getCheckString(name);
	
	String passwd = request.getParameter("passwd");
	passwd = util.getNullBlankCheck(passwd,"");
	passwd = util.getCheckString(passwd);
	
	String email = request.getParameter("email");
	email = util.getNullBlankCheck(email,"");
	email = util.getCheckString(email);
		
	String content = request.getParameter("content");
	content = util.getNullBlankCheck(content,"");
	content = util.getCheckString(content);
	
	
	
	GuestBookDTO arguDto = new GuestBookDTO();
	arguDto.setName(name);
	arguDto.setContent(content);
	arguDto.setPasswd(passwd);
	arguDto.setEmail(email);
	arguDto.setMemberNo(sessionNo);
	
	GuestBookDAO dao = new GuestBookDAO();
	int result = dao.setInsert(arguDto);
	
	if(result > 0) {
		out.println("<script>");
		out.println("location.href='main.jsp?menuGubun=guestBook_list';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록 중 오류가 발생했습니다.');");
		out.println("location.href='main.jsp?menuGubun=guestBook_chuga';");
		out.println("</script>");
	}
	

%>