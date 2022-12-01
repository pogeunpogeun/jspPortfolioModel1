<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	DTO arguDto = new DTO();
	arguDto.setId(id);
	arguDto.setPasswd(passwd);
	
	DAO dao = new DAO();
	DTO returnDto = dao.getLogin(arguDto);
	
/* 	out.println("no : " + returnDto.getNo() + "<br>");
	out.println("name : " + returnDto.getName() + "<br>"); */
	
	if(returnDto.getNo() > 0) {
		session.setAttribute("sessionNo", returnDto.getNo()); // 회원번호
		session.setAttribute("sessionId", id); // 회원아이디
		session.setAttribute("sessionName", returnDto.getName()); // 회원이름
		session.setAttribute("sessionGrade", returnDto.getGrade()); // 회원이름

		out.println("<script>");
		out.println("");
		out.println("location.href='main.jsp?menuGubun=dashBoard_list';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록된 정보가 없습니다.\\n 확인 후 다시 로그인해주세요.');");
		out.println("location.href='main.jsp?menuGubun=noLogin_login';");
		out.println("</script>");
	}
%>