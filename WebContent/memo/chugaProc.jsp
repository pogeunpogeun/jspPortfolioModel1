<%@page import="config.Util"%>
<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	Util util = new Util();

	String writer = request.getParameter("writer");
	writer = util.getNullBlankCheck(writer,"");
	writer = util.getCheckString(writer);
	
	String content = request.getParameter("content");
	content = util.getNullBlankCheck(content,"");
	content = util.getCheckString(content);
	
	MemoDTO arguDto = new MemoDTO();
	arguDto.setWriter(writer);
	arguDto.setContent(content);
	
	MemoDAO dao = new MemoDAO();
	int result = dao.setInsert(arguDto);
	
	if(result > 0) {
		out.println("<script>");
		out.println("location.href='main.jsp?menuGubun=memo_list';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록 중 오류가 발생했습니다.');");
		out.println("location.href='main.jsp?menuGubun=memo_chuga';");
		out.println("</script>");
	}
	

%>