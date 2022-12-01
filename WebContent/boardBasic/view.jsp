<%@include file = "_inc_top.jsp" %>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	BoardBasicDTO arguDto = new BoardBasicDTO();
	arguDto.setNo(no);
	
	BoardBasicDAO dao = new BoardBasicDAO();
	
	
	dao.hitCounter(arguDto);
	BoardBasicDTO dto = dao.getSelectOne(arguDto);
	
	if(dto.getNo() <= 0) {
		out.println("<script>");
		out.println("alert('존재하지 않는 내용입니다.')");
		out.println("location.href='main.jsp?menuGubun=boardBasic_list';");
		out.println("</script>");
		return;
	}
%>
<h2>게시글 상세보기</h2>
<table border="1" width="80%">
	<tr>
		<td>순번</td>
		<td colspan="3"><%=dto.getNo() %></td>
		<td>Num</td>
		<td><%=dto.getNum() %></td>
	</tr>	
	<tr>
		<td>비밀번호</td>
		<td><%=dto.getPasswd() %></td>
		<td>이메일</td>
		<td colspan="3"><%=dto.getEmail() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td colspan="5"><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>제목</td>
		<td colspan="5"><%=dto.getSubject() %></td>
	</tr>	
	<tr>
		<td>내용</td>
		<td colspan="5"><%=dto.getContent().replace("\n", "<br>") %></td>
	</tr>
	<tr>
		<td>refNo</td>
		<td><%=dto.getRefNo() %></td>
		<td>stepNo</td>
		<td colspan="3"><%=dto.getStepNo() %></td>
	</tr>
	<tr>
		<td>levelNo</td>
		<td><%=dto.getLevelNo() %></td>
		<td>조회수</td>
		<td colspan="3"><%=dto.getHit() %></td>
	</tr>
	<tr>
		<td>등록일</td>
		<td colspan="5"><%=dto.getRegiDate() %></td>
	</tr>	
</table>
<div style="border: 0px solid red; padding-top:20px; width:80%;" align="right">
|
<a href="#" onClick="move('boardBasic_chuga','<%=no%>');">답변</a>
|
<a href="#" onClick="move('boardBasic_list','');">목록</a>
|
<a href="#" onClick="move('boardBasic_chuga','');">등록</a>
|
<a href="#" onClick="move('boardBasic_sujung','<%=no %>');">수정</a>
|
<a href="#" onClick="move('boardBasic_sakje','<%=no %>');">삭제</a>
|
</div>	
<script>
	function move(value1,value2) {
		location.href="main.jsp?menuGubun=" + value1 + "&no=" + value2;
	}
</script>
