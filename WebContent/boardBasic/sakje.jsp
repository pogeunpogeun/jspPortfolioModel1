<%@include file = "_inc_top.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	BoardBasicDTO arguDto = new BoardBasicDTO();
	arguDto.setNo(no);
	
	BoardBasicDAO dao = new BoardBasicDAO();
	BoardBasicDTO dto = dao.getSelectOne(arguDto);
	
	if(dto.getNo() <= 0) {
		out.println("<script>");
		out.println("alert('존재하지 않는 내용입니다.')");
		out.println("location.href='main.jsp?menuGubun=boardBasic_list';");
		out.println("</script>");
		return;
	}
%>
<h2>게시글 삭제</h2>
<form name="sakjeForm">
<input type="hidden" name="no" value="<%=no %>">
<table border="1" width="80%">
	<tr>
		<td>순번</td>
		<td><%=dto.getNo() %></td>
	</tr>
	<tr>
		<td>Num</td>
		<td><%=dto.getNum() %></td>
	</tr>
	
	<tr>
		<td>작성자</td>
		<td><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%=dto.getEmail() %></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><%=dto.getSubject() %></td>
	</tr>	
	<tr>
		<td>내용</td>
		<td><%=dto.getContent() %></td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><%=dto.getRegiDate() %></td>
	</tr>	
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td colspan="3" style="text-align:center;">
		<button type="button" onClick="sakje();">삭제하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=boardBasic_list';">목록으로</button>
	</tr>
</table>
</form>
<script>
	function sakje() {
		if(confirm('삭제하시겠습니까?')) {
			document.sakjeForm.action="mainProc.jsp?menuGubun=boardBasic_sakjeProc";
			document.sakjeForm.method="post";
			document.sakjeForm.submit();
		}
	}
</script>
