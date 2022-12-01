<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>메모추가(attach)</h2>
<form name="chugaForm">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="writer"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><input type="text" name="content"></td>
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
		<button type="button" onClick="location.href='main.jsp?menuGubun=memo_list';">목록으로</button>
	</tr>

</table>
</form>
<script>
	function chuga() {
		if(confirm('추가하시겠습니까?')) {
			document.chugaForm.enctype = "multipart/form-data";
			document.chugaForm.action="mainProc.jsp?menuGubun=memo_attachChugaProc";
			document.chugaForm.method="post";
			document.chugaForm.submit();
		}
	}
</script>