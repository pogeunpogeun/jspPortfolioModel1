<%@include file = "_inc_top.jsp" %>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Util util = new Util();
	String no_ = request.getParameter("no");
	no_ = util.getNullBlankCheck(no_, "0");
	int no = Integer.parseInt(no_);
	
	String imsiTitle = "";
	String subject = "";
	String content = "";
	if (no > 0) { // 답변글
		BoardBasicDTO arguDto = new BoardBasicDTO();
		arguDto.setNo(no);
		
		BoardBasicDAO dao = new BoardBasicDAO();
		BoardBasicDTO returnDto = dao.getSelectOne(arguDto);
		imsiTitle = "답변글등록";
		subject = returnDto.getSubject();
		content = returnDto.getContent();
	} else { // 새글
		imsiTitle = "게시글등록";
	}
	
%>
<h2><%=imsiTitle %></h2>
<form name="chugaForm">
<input type="hidden" name="no" value="<%=no %>">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="writer"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject" value="<%=subject %>"></td>
	</tr>	
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width:500px; height:200px"><%=content %></textarea></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;">
		<button type="button" onClick="chuga();">추가하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=boardBasic_list';">목록으로</button>
	</tr>	
	
</table>
</form>
<script>
	function chuga() {
		if(confirm('추가하시겠습니까?')) {
			document.chugaForm.action="mainProc.jsp?menuGubun=boardBasic_chugaProc";
			document.chugaForm.method="post";
			document.chugaForm.submit();
		}
	}
</script>