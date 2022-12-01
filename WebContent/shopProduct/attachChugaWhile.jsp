<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<h2>상품등록(While)</h2>
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
		<td>첨부</td>
		<td>
		<input type="file" name="file1" class="fileUp"><br>
		<input type="file" name="file2" class="fileUp"><br>
		<input type="file" name="file3" class="fileUp">
		<input type="hidden" name="attachCounter" value="0">
		</td>
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
		document.DirForm.attachCounter.value = document.getElementsByClassName("fileUp").length;
		document.DirForm.enctype = "multipart/form-data";
		document.DirForm.action="mainProc.jsp?menuGubun=shopProduct_attachChugaWhileProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>