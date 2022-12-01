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
	
	ShopProductDAO viewDao = new ShopProductDAO();
	ShopProductDTO viewDto = viewDao.getSelectOne(arguDto); 
%>
<h2>상품상세보기</h2>
<table border="1" width="80%">
	<tr>
		<td>상품코드</td>
		<td><%=viewDto.getProductCode() %></td>
	</tr>	
	<tr>
		<td>상품이름</td>
		<td><%=viewDto.getProductName() %></td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td><%=viewDto.getProductPrice() %></td>
	</tr>
	<tr>
		<td>회사번호</td>
		<td><%=viewDto.getVendorCode() %></td>
	</tr>
	<tr>
		<td>사진</td>
		<td>
			 <% 
               if( viewDto.getAttachInfo() == null || viewDto.getAttachInfo().equals("-")) {
                  out.println("&nbsp;");
               } else {
                  String[] imsiArray = viewDto.getAttachInfo().split(",");
                  
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
		<td><%=viewDto.getRegiDate() %></td>
	</tr>
</table>
<div style="border: 0px solid red; padding-top: 20px; width: 80%;" align="right">
   |
   <a href="#" onClick="move('shopProduct_list','');">목록</a>
   |
   <a href="#" onClick="move('shopProduct_chuga','');">등록</a>
   |
   <a href="#" onClick="move('shopProduct_chuga','<%=viewDto.getProductCode() %>');">답변</a>
   |
   <a href="#" onClick="move('shopProduct_sujung',<%=viewDto.getProductCode() %>);">수정</a>
   |
   <a href="#" onClick="move('shopProduct_sakje','<%=viewDto.getProductCode() %>');">삭제</a>
   |
</div>
<script>
	function move(value1, value2) {
		location.href = 'main.jsp?menuGubun=' + value1 + '&productCode=' + value2;
	}
</script>
