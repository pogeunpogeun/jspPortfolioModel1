<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp"%>
<%
	String productCode_ = request.getParameter("productCode");
	int productCode = Integer.parseInt(productCode_);
	
	ShopProductDTO arguDto = new ShopProductDTO();
	arguDto.setProductCode(productCode);
	
	ShopProductDAO viewDao = new ShopProductDAO();
	ShopProductDTO viewDto = viewDao.getSelectOne(arguDto);
	
%>
<h2>쇼핑몰 상세보기</h2>
<table border="1" width="80%">
	<tr>
		<td width="200">상품번호</td>
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
		<td>제조사</td>
		<td><%=viewDto.getVendorCode() %></td>
	</tr>
		<tr>
		<td>등록일</td>
		<td><%=viewDto.getRegiDate() %></td>
	</tr>
		<tr>
		<td>상품이미지</td>
		<td>
			<%
				String[] imsiArray01 = viewDto.getAttachInfo().split(",");
				for(int i = 0; i<imsiArray01.length; i++) {
					String[] imsiArray02 = imsiArray01[i].split("[|]");
					if(imsiArray02[1].equals("-")) {
						out.println("이미지없음");
					} else {
						String imsiImgPath = "";
                        imsiImgPath += request.getContextPath();
                        imsiImgPath += "/attach";
                        imsiImgPath += request.getContextPath();
                        imsiImgPath += "/product/";
                        imsiImgPath += imsiArray02[1];
						out.println("<img src='" + imsiImgPath + "' width='100' height='150'>");
					}
					out.println("<hr>");
				}
			%>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="padding: 20px">
			<select name="jumunSu" id="jumunSu">
			<option value="0">-- 선택 -- </option>
			<% for(int i = 1; i<=20; i++) { %>
			<option value="<%=i%>"><%=i%></option>
			<% } %>
			</select>
			&nbsp;
			<button type="button" onClick="btnProc('saveCart');">장바구니 담기</button>
			<button type="button" onClick="btnProc('gumae');">바로구매</button>
			<button type="button" onClick="btnProc('shopping');">계속쇼핑</button>
			<button type="button" onClick="btnProc('viewCart');">장바구니 보기</button>
		</td>
</table>
<form name="imsiForm">
<%-- <input type="text" name="productCode" value="<%=productCode%>">
<input type="text" name="amount"> --%>
<input type="hidden" name="imsi">
</form>
<script>
	function btnProc(value1) {
		if(value1 == 'saveCart') {
			if(confirm('장바구니에 담을까요?')) {
				//document.imsiForm.amount.value = document.getElementById("jumunSu").value;
				document.imsiForm.imsi.value = <%=productCode %> + "|" + document.getElementById("jumunSu").value;
				document.imsiForm.action = "mainProc.jsp?menuGubun=shopMall_cartChugaProc";	
				document.imsiForm.method = "post";
				document.imsiForm.submit();
			}
		} else if(value1 == 'gumae') {
			alert('여기까지');
		} else if(value1 == 'shopping') {
			location.href = 'main.jsp?menuGubun=shopMall_list';
		} else if(value1 == 'viewCart') {
			location.href = 'main.jsp?menuGubun=shopCart_list';
		}
	}
</script>