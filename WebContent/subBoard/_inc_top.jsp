<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%@ page import="subBoard.model.dao.SubBoardDAO" %>
<%@ page import="subBoard.model.dto.SubBoardDTO" %>

<%@ page import="subBoard.model.dao.SubBoardChkDAO" %>
<%@ page import="subBoard.model.dto.SubBoardChkDTO" %>

<%@ include file = "../_include/inc_header.jsp" %>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<%
	String tbl = request.getParameter("tbl");
	if (tbl == null || tbl.trim().equals("")) {
		tbl = "freeboard";
	}
	String imsiBoardTitle = "";
	
	SubBoardChkDAO subBoardChkDao = new SubBoardChkDAO();
	SubBoardChkDTO returnTblDto = subBoardChkDao.getSelectOne(tbl);
	
	if(returnTblDto.getBoardChkNo() > 0) {
		imsiBoardTitle = returnTblDto.getTblName();
	} else {
		out.println("<script>");
		out.println("alert('비정상적인 접근입니다.');");
		out.println("location.href= 'main.jsp?menuGubun=dashBoard_list';");
		out.println("</script>");
	}
	if(tbl.equals("freeboard")) {
		imsiBoardTitle = "자유게시판";
	} else if(tbl.equals("onebyone")) {
		imsiBoardTitle = "1:1게시판";
	} else if(tbl.equals("qna")) {
		imsiBoardTitle = "Q & A";
	} else {
		out.println("<script>");
		out.println("alert('비정상적인 접근입니다.');");
		out.println("location.href= 'main.jsp?menuGubun=dashBoard_list';");
		out.println("</script>");
	}
	
	String pageNumber_ = request.getParameter("pageNumber");
	if (pageNumber_ == null || pageNumber_.trim().equals("")) {
		pageNumber_ = "1";
	}
	int pageNumber = Integer.parseInt(pageNumber_);


	String no_ = request.getParameter("no");
	if (no_ == null || no_.trim().equals("")) {
		no_ = "0";
	}
	int no = Integer.parseInt(no_);


	String searchGubun = request.getParameter("searchGubun");
	String searchData = request.getParameter("searchData");
	
	int imsiSearchCounter = 0;
	
	if (searchGubun == null || searchGubun.trim().equals("")) {
		searchGubun = "";
		imsiSearchCounter++;
	}
	
	if (searchData == null || searchData.trim().equals("")) {
		searchData = "";
		imsiSearchCounter++;
	}
	
	if (imsiSearchCounter > 0) { // 0보다 크면 검색 안하다는 의미..
		searchGubun = "";
		searchData = "";
	}
	String imsiQueryString = "tbl=" + tbl + "&searchGubun=" + searchGubun + "&searchData=" + searchData;
%>

<%-- 검색 : <%=tbl %> / <%=pageNumber %> / <%=searchGubun%> / <%=searchData%> / <%=imsiQueryString %>
<hr> --%>