<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%@ page import="board.model.dao.BoardDAO" %>
<%@ page import="board.model.dto.BoardDTO" %>
<%@ page import="config.Util" %>

<%@ include file = "../_include/inc_header.jsp" %>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<%
	BoardDAO dao = null;
	BoardDTO dto = null;

	String pageTitle = "";
	String pageSubject = "";
	String pageContent = "";
	
	if (fileName.equals("chuga") || fileName.equals("chugaProc") || fileName.equals("view") || fileName.equals("sujung") || fileName.equals("sujungProc") || fileName.equals("sakje") || fileName.equals("sakjeProc")) {
		String no_ = request.getParameter("no");
		if (no_ == null || no_.trim().equals("")) {
			no_ = "0";
		}
		int no = Integer.parseInt(no_);
		
		BoardDTO arguDto = new BoardDTO();
		arguDto.setNo(no);
		
		dao = new BoardDAO();
		
		if (fileName.equals("view")) {
			dao.setUpdateHit(arguDto);
		}
		
		dto = dao.getSelectOne(arguDto);
		
		if (fileName.equals("chuga")) {
			pageTitle = "답변쓰기";
			pageSubject = dto.getSubject();
			pageContent = dto.getContent();
			if (dto.getNo() == 0) {
				pageTitle = "글쓰기";
				pageSubject = "";
				pageContent = "";
			}
		}
	}
%>