<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<h2>글삭제</h2>

<form name="DirForm">
<input type="hidden" name="no" id="no" value="<%=dto.getNo() %>">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%=dto.getEmail() %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type=password name="passwd" id="passwd" value=""></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><%=dto.getSubject() %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><%=dto.getContent().replace("\n", "<br>") %></td>
	</tr>
	<tr>
		<td>공지글</td>
		<td>
			<% if (dto.getNoticeNo() > 0) { %>		
				O
			<% } else { %>	
				X
			<% } %>		
		</td>
	</tr>
	<tr>
		<td>비밀글</td>
		<td>
			<% if (dto.getSecretGubun().equals("T")) { %>		
				O
			<% } else { %>	
				X
			<% } %>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="save();">삭제하기</button>
			<button type="button" onClick="location.href='main.jsp?menuGubun=board_list';">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
function save() {
	if (confirm('삭제할까요?')) {
		document.DirForm.action = "mainProc.jsp?menuGubun=board_sakjeProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>