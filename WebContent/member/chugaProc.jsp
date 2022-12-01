<%@ include file = "_inc_top.jsp" %>
<%@ include file = "../_include/inc_header.jsp" %>
<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String pwChk = request.getParameter("pwChk");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String jumin1 = request.getParameter("jumin1");
	String jumin2 = request.getParameter("jumin2");
	String juso1 = request.getParameter("juso1");
	String juso2 = request.getParameter("juso2");
	String juso3 = request.getParameter("juso3");
	String juso4 = request.getParameter("juso4");
	String grade = request.getParameter("grade");

	
	String jumin = jumin1 + " - " + jumin2;
		
	if(juso4 == null || juso4.trim().equals("")) {
		juso4 = "-";
	}
	String attachInfo = "-";
	
	DTO arguDto = new DTO();
	arguDto.setId(id);
	arguDto.setPasswd(passwd);
	arguDto.setName(name);
	arguDto.setPhone(phone);
	arguDto.setEmail(email);
	arguDto.setJumin(jumin);
	arguDto.setJuso1(juso1);
	arguDto.setJuso2(juso2);
	arguDto.setJuso3(juso3);
	arguDto.setJuso4(juso4);
	arguDto.setGrade(grade);
	arguDto.setAttachInfo(attachInfo);
	
	DAO dao = new DAO();
	int result = dao.setInsert(arguDto);
	
	if(result > 0) {
		out.println("<script>");
		//out.println();
		//out.println("location.href='main.jsp?menuGubun=member_list';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록 중 오류가 발생했습니다.');");
		//out.println("location.href='main.jsp?menuGubun=member_chuga';");
		out.println("</script>");
	}
%>