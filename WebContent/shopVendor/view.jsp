<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String vendorCode_ = request.getParameter("vendorCode");
	int vendorCode = Integer.parseInt(vendorCode_);
	
	ShopVendorDTO arguDto = new ShopVendorDTO();
	arguDto.setVendorCode(vendorCode);
	
	ShopVendorDAO dao = new ShopVendorDAO();
	ShopVendorDTO viewDto = dao.getSelectOne(arguDto);

%>
<h2>제조사상세보기</h2>
<table border="1" width="80%">
	<tr>
		<td>제조사번호</td>
		<td><%=viewDto.getVendorCode() %></td>
	</tr>
	<tr>
		<td>제조사이름</td>
		<td><%=viewDto.getVendorName() %></td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><%=viewDto.getRegiDate() %></td>
	</tr>
</table>
</form>
<div style="border: 0px solid red; padding-top: 20px; width: 80%;" align="right">
   |
   <a href="#" onClick="move('shopVendor_list','');">목록</a>
   |
   <a href="#" onClick="move('shopVendor_chuga','');">등록</a>
   |
   <a href="#" onClick="move('shopVendor_chuga','<%=viewDto.getVendorCode() %>');">답변</a>
   |
   <a href="#" onClick="move('shopVendor_sujung',<%=viewDto.getVendorCode() %>);">수정</a>
   |
   <a href="#" onClick="move('shopVendor_sakje','<%=viewDto.getVendorCode() %>');">삭제</a>
   |
</div>
<script>
	function move(value1, value2) {
		location.href = 'main.jsp?menuGubun=' + value1 + '&vendorCode=' + value2;
	}
</script>
