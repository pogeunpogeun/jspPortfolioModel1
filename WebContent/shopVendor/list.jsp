<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	ShopVendorDAO dao = new ShopVendorDAO();
	ArrayList<ShopVendorDTO> list = dao.getSelectAll();

%>
<h2>제조사 목록</h2>
<table border="1" width="80%">
	<tr>
		<th>제조사번호</th>
		<th>제조사이름</th>
		<th>등록일</th>
	</tr>
	
	<% for(int i=0; i<list.size(); i++) {
		ShopVendorDTO listDto = list.get(i);
	%>
	<tr>
		<td><%=listDto.getVendorCode()%></td>
		<td><a href="#" onClick="move('shopVendor_view','<%=listDto.getVendorCode()%>','','');"><%=listDto.getVendorName()%></a></td>
		<td><%=listDto.getRegiDate()%></td>
	</tr>
	<%
	 	}
	%>
</table>
<div style="border: 0px solid red; padding-top :20px; width:80%;" align="right">
|
<a href="#" onClick="move('shopVendor_list','','','');">전체목록</a>
|
<a href="#" onClick="move('shopVendor_list','','','');">목록</a>
|
<a href="#" onClick="move('shopVendor_chuga','','','');">추가</a>
|
</div>
<script>
	function move(value1, value2) {
		location.href = 'main.jsp?menuGubun=' + value1 + '&vendorCode=' + value2;
	}
</script>