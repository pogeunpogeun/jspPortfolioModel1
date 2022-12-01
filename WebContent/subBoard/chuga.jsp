<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String imsiTitle = "글쓰기";
	String imsiSubject = "";
	String imsiContent = "";
	if (no > 0) {
		imsiTitle = "답변쓰기";
		
		SubBoardDTO arguDto = new SubBoardDTO();
		arguDto.setNo(no);
		arguDto.setTbl(tbl);
		
		SubBoardDAO subBoardDao = new SubBoardDAO();
		SubBoardDTO returnDto = subBoardDao.getSelectOne(arguDto);
		
		if (returnDto.getNo() <= 0) {
			out.println("메롱..");
			return;
		}
		
		imsiSubject = returnDto.getSubject();
		imsiContent = returnDto.getContent();
	}
%>

<h2><%=imsiBoardTitle %> <%=imsiTitle %></h2>

<form name="DirForm">
<input type="hidden" name="tbl" value="<%=tbl %>">
<input type="hidden" name="pageNumber" value="<%=pageNumber %>">
<input type="hidden" name="no" value="<%=no %>">
<input type="hidden" name="searchGubun" value="<%=searchGubun %>">
<input type="hidden" name="searchData" value="<%=searchData %>">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="writer"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject" value="<%=imsiSubject %>"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width: 300px; height: 100px;"><%=imsiContent %></textarea></td>
	</tr>
	<tr>
		<td>공지글</td>
		<td>
			<input type="radio" name="noticeGubun" value="T"> 공지글 &nbsp;
			<input type="radio" name="noticeGubun" value="F" checked> 공지글아님 &nbsp;
		</td>
	</tr>
	<tr>
		<td>비밀글</td>
		<td>
			<input type="radio" name="secretGubun" value="T"> 비밀글 &nbsp;
			<input type="radio" name="secretGubun" value="F" checked> 비밀글아님 &nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="save();">등록하기</button>
			<button type="button" onClick="location.href = 'main.jsp?menuGubun=subBoard_list';">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
function save() {
	if (confirm('등록할까요?')) {
		document.DirForm.action = "mainProc.jsp?menuGubun=subBoard_chugaProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>