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

<h2><%=imsiBoardTitle %> 글삭제</h2>

<form name="DirForm">
<input type="hidden" name="tbl" value="<%=tbl %>">
<input type="hidden" name="pageNumber" value="<%=pageNumber %>">
<input type="hidden" name="no" value="<%=returnDto.getNo() %>">
<input type="hidden" name="searchGubun" value="<%=searchGubun %>">
<input type="hidden" name="searchData" value="<%=searchData %>">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><%=returnDto.getWriter() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%=returnDto.getEmail() %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><%=returnDto.getSubject() %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><%=returnDto.getContent().replace("\n", "<br>") %></td>
	</tr>
	<tr>
		<td>공지글</td>
		<td>
			<% if (returnDto.getNoticeNo() > 0) { %>		
				공지글
			<% } else { %>	
				공지글아님
			<% } %>	
		</td>
	</tr>
	<tr>
		<td>비밀글</td>
		<td>
			<% if (returnDto.getSecretGubun().equals("T")) { %>		
				비밀글
			<% } else { %>	
				비밀글아님
			<% } %>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="save();">삭제하기</button>
			<button type="button" onClick="move('subBoard_list', '');">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
function save() {
	if (confirm('삭제할까요?')) {
		document.DirForm.action = "mainProc.jsp?menuGubun=subBoard_sakjeProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>