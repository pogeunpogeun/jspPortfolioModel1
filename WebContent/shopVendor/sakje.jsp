<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String vendorCode_ = request.getParameter("vendorCode");
	int vendorCode = Integer.parseInt(vendorCode_);
	
	ShopVendorDTO arguDto = new ShopVendorDTO();
	arguDto.setVendorCode(vendorCode);
	
	ShopVendorDAO dao = new ShopVendorDAO();
	ShopVendorDTO sakjeDto = dao.getSelectOne(arguDto);

%>
<h2>제조사삭제</h2>
<form name="DirForm">
<input type="text" name="vendorCode" value="<%=sakjeDto.getVendorCode() %>">
<table border="1" width="80%">
	<tr>
		<td>제조사코드</td>
		<td><%=sakjeDto.getVendorCode() %></td>
	</tr>
	<tr>
		<td>제조사이름</td>
		<td><%=sakjeDto.getVendorName() %></td>
	</tr>
	<tr>
		<td colspan="2">
		<button type="button" onClick="move();">삭제</button>
		</td>
	</tr>
</table>
</form>
<script>
	function move() {
		document.DirForm.action="mainProc.jsp?menuGubun=shopVendor_sakjeProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>