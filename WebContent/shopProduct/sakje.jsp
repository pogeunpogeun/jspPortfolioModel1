<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String productCode_ = request.getParameter("productCode");
	
	Util util = new Util();
	
	util.getNullBlankCheck(productCode_, "");
	util.getCheckString(productCode_);
	
	int productCode = Integer.parseInt(productCode_);
	
	ShopProductDTO arguDto = new ShopProductDTO();
	arguDto.setProductCode(productCode);
	
	ShopProductDAO sakjeDao = new ShopProductDAO();
	ShopProductDTO sakjeDto = sakjeDao.getSelectOne(arguDto); 
%>
<h2>상품삭제</h2>
<form name="DirForm">
<input type="hidden" name="productCode" value="<%=sakjeDto.getProductCode() %>">
<table border="1" width="80%">
	<tr>
		<td>상품코드</td>
		<td><%=sakjeDto.getProductCode() %></td>
	</tr>
	<tr>
		<td>상품이름</td>
		<td><%=sakjeDto.getProductName() %></td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td><%=sakjeDto.getProductPrice() %></td>
	</tr>
	<tr>
		<td>회사번호</td>
		<td><%=sakjeDto.getVendorCode() %></td>
	</tr>
	<tr>
		<td>첨부</td>
		<td>
		<% 
               if( sakjeDto.getAttachInfo() == null || sakjeDto.getAttachInfo().equals("-")) {
                  out.println("&nbsp;");
               } else {
                  String[] imsiArray = sakjeDto.getAttachInfo().split(",");
                  
                  for(int j=0; j<imsiArray.length; j++) {
                     if(!imsiArray[j].equals("-|-|0|-|-")) { //파일 있을때
                        String[] imsiArray2 = imsiArray[j].split("[|]");
                        
                        String imsiImgPath = "";
                        imsiImgPath += request.getContextPath();
                        imsiImgPath += "/attach";
                        imsiImgPath += request.getContextPath();
                        imsiImgPath += "/product/";
                        imsiImgPath += imsiArray2[1];
                        out.println("<img src='" + imsiImgPath + "' width='30' height='30'>");
                        
                     }
                  }
               }
            %>
		</td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><%=sakjeDto.getRegiDate() %></td>
	</tr>
	
	<tr>
		<td colspan="2">
		<button type="button" onClick="move();">삭제하기</button>
		</td>
	</tr>
</table>
</form>
<script>
	function move() {
		document.DirForm.action="mainProc.jsp?menuGubun=shopProduct_sakjeProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>