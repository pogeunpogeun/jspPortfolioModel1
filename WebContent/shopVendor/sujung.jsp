<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String vendorCode_ = request.getParameter("vendorCode");
	int vendorCode = Integer.parseInt(vendorCode_);
	
	ShopVendorDTO arguDto = new ShopVendorDTO();
	arguDto.setVendorCode(vendorCode);
	
	ShopVendorDAO dao = new ShopVendorDAO();
	ShopVendorDTO sujungDto = dao.getSelectOne(arguDto);

%>
<h2>제조사수정</h2>
<form name="DirForm">
<input type="hidden" name="vendorCode" value="<%=sujungDto.getVendorCode() %>">
<table border="1" width="80%">
	<tr>
		<td>제조사코드</td>
		<td><%=sujungDto.getVendorCode() %></td>
	</tr>
	<tr>
		<td>제조사이름</td>
		<td><input type="text" name="vName" value="<%=sujungDto.getVendorName() %>"></td>
	</tr>
	<tr>
		<td colspan="2">
		<button type="button" onClick="move();">수정</button>
		</td>
	</tr>
</table>
</form>
<script>
	function move() {
		document.DirForm.action="mainProc.jsp?menuGubun=shopVendor_sujungProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>