<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%> 
<%
	request.setCharacterEncoding("UTF-8");	
	
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	String content = request.getParameter("content");
	
	MemoDTO arguDto = new MemoDTO();
	arguDto.setNo(no);
	arguDto.setContent(content);
	
	MemoDAO dao = new MemoDAO();
	int result = dao.setUpdate(arguDto);
	

	if(result > 0) {
		String imsiUrl = "main.jsp?menuGubun=memo_view&no=" + no;
		out.println("<script>");
		//out.println();
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} else {
		String imsiUrl = "main.jsp?menuGubun=memo_sujung&no=" + no;
		out.println("<script>");
		out.println("alert('수정 중 오류가 발생했습니다.');");
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	}
%>