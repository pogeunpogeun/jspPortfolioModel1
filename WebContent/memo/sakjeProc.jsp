<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%> 
<%
	request.setCharacterEncoding("UTF-8");
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	MemoDTO arguDto = new MemoDTO();
	arguDto.setNo(no);
	
	MemoDAO dao = new MemoDAO();
	int result  = dao.setDelete(arguDto);	
	
	if(result > 0) {
		String imsiUrl = "main.jsp?menuGubun=memo_list";
		out.println("<script>");
		//out.println();
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} else {
		String imsiUrl = "main.jsp?menuGubun=memo_sakje&no=" + no;
		out.println("<script>");
		out.println("alert('삭제 중 오류가 발생했습니다.');");
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	}
%>