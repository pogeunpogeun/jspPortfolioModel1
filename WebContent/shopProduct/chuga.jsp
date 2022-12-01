<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>상품등록</h2>
<form name="DirForm">
<table border="1" width="80%">
	<tr>
		<td>상품이름</td>
		<td><input type="text" name="pName"></td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td><input type="text" name="pPrice"></td>
	</tr>
	<tr>
		<td>회사번호</td>
		<td><input type="text" name="vendorCode"></td>
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
		document.DirForm.action="mainProc.jsp?menuGubun=shopProduct_chugaProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>