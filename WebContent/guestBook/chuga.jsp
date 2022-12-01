<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<h2>방명록 추가</h2>
<form name="chugaForm">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="name" value="<%=sessionName %>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="email" name="email"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width:500px; height:200px"></textarea></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;">
		<button type="button" onClick="chuga();">추가하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=guestBook_list';">목록으로</button>
	</tr>	
	
</table>
</form>
<script>
	function chuga() {
		if(confirm('추가하시겠습니까?')) {
			document.chugaForm.action="mainProc.jsp?menuGubun=guestBook_chugaProc";
			document.chugaForm.method="post";
			document.chugaForm.submit();
		}
	}
</script>