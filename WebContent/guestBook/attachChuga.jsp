<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>방명록 추가</h2>
<form name="chugaForm">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="name"></td>
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
		<td>첨부</td>
		<td>
			<input type="file" name="file1"><br>
			<input type="file" name="file2"><br>
			<input type="file" name="file3"><br>
		</td>
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
			document.chugaForm.enctype = "multipart/form-data";
			document.chugaForm.action="mainProc.jsp?menuGubun=guestBook_attachChugaProc";
			document.chugaForm.method="post";
			document.chugaForm.submit();
		}
	}
</script>