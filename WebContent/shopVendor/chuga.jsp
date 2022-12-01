<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>제조사등록</h2>
<form name="DirForm">
<table border="1" width="80%">
	<tr>
		<td>제조사이름</td>
		<td><input type="text" name="vName"></td>
	</tr>
	<tr>
		<td colspan="2">
		<button type="button" onClick="move();">등록하기</button>
		</td>
	</tr>
</table>
</form>
<script>
	function move() {
		document.DirForm.action="mainProc.jsp?menuGubun=shopVendor_chugaProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>