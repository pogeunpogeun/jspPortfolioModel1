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
	
	ShopProductDAO sujungDao = new ShopProductDAO();
	ShopProductDTO sujungDto = sujungDao.getSelectOne(arguDto); 
%>
<h2>상품수정</h2>
<form name="DirForm">
<input type="hidden" name="productCode" value="<%=sujungDto.getProductCode() %>">
<table border="1" width="80%">
	<tr>
		<td>상품이름</td>
		<td><input type="text" name="productName" value="<%=sujungDto.getProductName() %>"></td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td><input type="text" name="productPrice" value="<%=sujungDto.getProductPrice() %>"></td>
	</tr>
	<tr>
		<td>회사번호</td>
		<td><%=sujungDto.getVendorCode() %></td>
	</tr>
	<tr>
		<td>첨부</td>
		<td>
		<input type="file" name="file1" class="fileUp"><br>
		<input type="file" name="file2" class="fileUp"><br>
		<input type="file" name="file3" class="fileUp">
		<input type="text" name="attachCounter" value="0">
		</td>
	</tr>
	<tr>
		<td>첨부</td>
		<td>
			<% 
               if( sujungDto.getAttachInfo() == null || sujungDto.getAttachInfo().equals("-")) {
                  out.println("&nbsp;");
               } else {
                  String[] imsiArray = sujungDto.getAttachInfo().split(",");
                  
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
		<td colspan="2">
		<button type="button" onClick="move();">수정하기</button>
		</td>
	</tr>
</table>
</form>
<script>
	function move() {		
		document.DirForm.attachCounter.value = document.getElementsByClassName("fileUp").length;
		document.DirForm.enctype = "multipart/form-data";
		document.DirForm.action="mainProc.jsp?menuGubun=shopProduct_sujungProc";
		document.DirForm.method="post";
		document.DirForm.submit();
	}
</script>