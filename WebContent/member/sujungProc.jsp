<%@ include file = "_inc_top.jsp" %>
<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
	

	
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	String passwd = request.getParameter("passwd");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String juso1 = request.getParameter("juso1");
	String juso2 = request.getParameter("juso2");
	String juso3 = request.getParameter("juso3");
	String juso4 = request.getParameter("juso4");
	String grade = request.getParameter("grade");

	
	if(juso4 == null || juso4.trim().equals("")) {
		juso4 = "-";
	}
	
	DTO arguDto = new DTO();
	arguDto.setNo(no);
	arguDto.setPasswd(passwd);
	arguDto.setPhone(phone);
	arguDto.setEmail(email);
	arguDto.setJuso1(juso1);
	arguDto.setJuso2(juso2);
	arguDto.setJuso3(juso3);
	arguDto.setJuso4(juso4);
	arguDto.setGrade(grade);
	
	DAO dao = new DAO();
	int result = dao.setUpdate(arguDto);
	
	if(result > 0) {
		String imsiUrl = "main.jsp?menuGubun=member_view&no=" + no;
		out.println("<script>");
		//out.println();
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} else {
		String imsiUrl = "main.jsp?menuGubun=member_sujung&no=" + no;
		out.println("<script>");
		out.println("alert('수정 중 오류가 발생했습니다.');");
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	}
%>