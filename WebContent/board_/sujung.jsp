<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<h2>글수정</h2>

<form name="DirForm">
<input type="hidden" name="no" id="no" value="<%=dto.getNo() %>">
<table border="1">
	<tr>
		<td>작성자</td>
		<td><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email" id="email" value="<%=dto.getEmail() %>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type=password name="passwd" id="passwd" value=""></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject" id="subject" value="<%=dto.getSubject() %>"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" id="content" style="width:300px; height:100px;"><%=dto.getContent() %></textarea></td>
	</tr>
	<tr>
		<td>공지글</td>
		<td>
<% if (dto.getNoticeNo() > 0) { %>		
			<input type="radio" name="noticeGubun" id="noticeGubun1" value="T" checked> 공지글 &nbsp;
			<input type="radio" name="noticeGubun" id="noticeGubun2" value="F"> 공지글아님 &nbsp;
<% } else { %>	
			<input type="radio" name="noticeGubun" id="noticeGubun1" value="T"> 공지글 &nbsp;
			<input type="radio" name="noticeGubun" id="noticeGubun2" value="F" checked> 공지글아님 &nbsp;
<% } %>		
		</td>
	</tr>
	<tr>
		<td>비밀글</td>
		<td>
			<input type="radio" name="secretGubun" id="secretGubun1" value="T" <% if (dto.getSecretGubun().equals("T")) { out.println("checked"); } %>> 비밀글 &nbsp;
			<input type="radio" name="secretGubun" id="secretGubun2" value="F" <% if (dto.getSecretGubun().equals("F")) { out.println("checked"); } %>> 비밀글아님 &nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="save();">수정하기</button>
			<button type="button" onClick="location.href='main.jsp?menuGubun=board_list';">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
function save() {
	if (confirm('수정할까요?')) {
		document.DirForm.action = "mainProc.jsp?menuGubun=board_sujungProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>