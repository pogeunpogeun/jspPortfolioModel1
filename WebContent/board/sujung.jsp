<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	BoardDTO arguDto = new BoardDTO();
	arguDto.setNo(no);
	
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = dao.getSelectOne(arguDto);
%>
<h2>게시물 수정</h2>
<form name="DirForm">
<input type="hidden" name="no" value="<%=dto.getNo() %>">
<input type="text" name="dbNoticeNo" value="<%=dto.getNoticeNo()%>">
<table border="1" width="50%">
	<tr>
		<td>작성자</td>
		<td><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email" value ="<%=dto.getEmail()%>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject" value ="<%=dto.getSubject()%>"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width:300px; height:100px;"><%=dto.getContent() %></textarea></td>
	</tr>
	<tr>
		<td>공지글</td>
		<td>
		<% if(dto.getNoticeNo() > 0) { %>
			<input type="radio" name="noticeGubun" value="T" checked>공지글&nbsp;
			<input type="radio" name="noticeGubun" value="F">일반글&nbsp;
		<% } else { %>
			<input type="radio" name="noticeGubun" value="T">공지글&nbsp;
			<input type="radio" name="noticeGubun" value="F" checked>일반글&nbsp;
		<% } %>
		</td>
	</tr>
	<tr>
		<td>비밀글</td>
		<td>
		<% if(dto.getSecretGubun().equals("T")) { %>
			<input type="radio" name="secretGubun" value="T" checked>비밀글&nbsp;
			<input type="radio" name="secretGubun" value="F" >일반글&nbsp;
		<% } else { %>
			<input type="radio" name="secretGubun" value="T" >비밀글&nbsp;
			<input type="radio" name="secretGubun" value="F" checked>일반글&nbsp;
		<% } %>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="save();">수정하기</button>
			<button type="button" onClick="move('board_list','');">목록보기</button>
		</td>	
	</tr>
</table>
</form>
<script>
	function save() {
		if(confirm('수정하시겠습니까?')) {
			document.DirForm.action="mainProc.jsp?menuGubun=board_sujungProc";
			document.DirForm.method="post";
			document.DirForm.submit();
		}
	}
</script>
<%@ include file = "_inc_script.jsp" %>