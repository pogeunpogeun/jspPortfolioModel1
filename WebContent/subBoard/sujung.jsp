<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	SubBoardDTO arguDto = new SubBoardDTO();
	arguDto.setNo(no);
	arguDto.setTbl(tbl);
	arguDto.setSearchGubun(searchGubun);
	arguDto.setSearchData(searchData);
	
	SubBoardDAO subBoardDao = new SubBoardDAO();
	SubBoardDTO returnDto = subBoardDao.getSelectOne(arguDto);
	
	if (returnDto.getNo() <= 0) {
		out.println("메롱..");
		return;
	}
%>

<h2><%=imsiBoardTitle %> 글수정</h2>

<form name="DirForm">
<input type="hidden" name="tbl" value="<%=tbl %>">
<input type="hidden" name="pageNumber" value="<%=pageNumber %>">
<input type="hidden" name="no" value="<%=returnDto.getNo() %>">
<input type="hidden" name="dbNoticeNo" value="<%=returnDto.getNoticeNo() %>">
<input type="hidden" name="searchGubun" value="<%=searchGubun %>">
<input type="hidden" name="searchData" value="<%=searchData %>">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><%=returnDto.getWriter() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email" value="<%=returnDto.getEmail() %>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject" value="<%=returnDto.getSubject() %>"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width: 300px; height: 100px;"><%=returnDto.getContent() %></textarea></td>
	</tr>
	<tr>
		<td>공지글</td>
		<td>
			<% if (returnDto.getNoticeNo() > 0) { %>		
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
			<% if (returnDto.getSecretGubun().equals("T")) { %>		
				<input type="radio" name="secretGubun" value="T" checked> 비밀글 &nbsp;
				<input type="radio" name="secretGubun" value="F"> 비밀글아님 &nbsp;
			<% } else { %>	
				<input type="radio" name="secretGubun" value="T"> 비밀글 &nbsp;
				<input type="radio" name="secretGubun" value="F" checked> 비밀글아님 &nbsp;
			<% } %>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="save();">수정하기</button>
			<button type="button" onClick="move('subBoard_list', '');">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
function save() {
	if (confirm('수정할까요?')) {
		document.DirForm.action = "mainProc.jsp?menuGubun=subBoard_sujungProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>