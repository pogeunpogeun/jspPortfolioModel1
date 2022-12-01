<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="subBoard.model.dao.SubBoardDAO" %>
<%@ page import="subBoard.model.dto.SubBoardCommentDTO" %>

<%@ include file = "../_include/inc_header.jsp" %>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<%
	String procGubun = request.getParameter("procGubun");

	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	String commentNo_ = request.getParameter("commentNo");
	if (commentNo_ == null || commentNo_.trim().equals("")) {
		commentNo_ = "0";
	}
	int commentNo = Integer.parseInt(commentNo_);
	
	String writer = request.getParameter("writer");
	String passwd = request.getParameter("passwd");
	String content = request.getParameter("content");
	
	int memberNo = sessionNo;
	//String ip = "";

	SubBoardCommentDTO subBoardCommentDto = new SubBoardCommentDTO();
	subBoardCommentDto.setCommentNo(commentNo);
	subBoardCommentDto.setBoardNo(no);
	subBoardCommentDto.setWriter(writer);
	subBoardCommentDto.setPasswd(passwd);
	subBoardCommentDto.setContent(content);
	subBoardCommentDto.setMemberNo(memberNo);
	subBoardCommentDto.setIp(ip);
	
	SubBoardDAO subBoardDao = new SubBoardDAO();
	int result = 0;
	if (procGubun.equals("chugaProc")) {
		result = subBoardDao.setCommentInsert(subBoardCommentDto);
	} else if (procGubun.equals("sujungProc")) {
		result = subBoardDao.setCommentUpdate(subBoardCommentDto);
	} else if (procGubun.equals("sakjeProc")) {
		result = subBoardDao.setCommentDelete(subBoardCommentDto);
	}
	
	out.println(result);
%>