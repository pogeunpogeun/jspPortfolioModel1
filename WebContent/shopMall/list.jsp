<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%   
   
   ShopProductDAO shopProductDao = new ShopProductDAO();
   ArrayList<ShopProductDTO>list = shopProductDao.getSelectAll();
   
   int productCounter = list.size();
   int cellCounter = 3; //가로로 배열할 상품의 갯수
   int imsiMok = productCounter / cellCounter;
   int imsiNa = productCounter % cellCounter;
      
   int rowCounter = 0;
   if(imsiNa > 0) {
      rowCounter = imsiMok + 1;
   } else {
      rowCounter = imsiMok;
   }

%>
<h2>쇼핑몰 목록</h2>
<table border="0">
<%
   int idx = 0;
   for (int i=0; i < rowCounter; i++) {
%> 
      <tr>
         <%
            for(int j = 0; j < cellCounter; j++) {
               String idxExist = "X"; //상품이 없을 경우
               if(idx < productCounter) {
                  idxExist = "O"; //상품이 있을 경우
               }
               
               int imsiCode = 0;
               String imsiName = "";
               int imsiPrice = 0;
               String imsiImg = "";
               
               if(idxExist.equals("O")) {
                  ShopProductDTO dto = list.get(idx);
                  
                  imsiCode = dto.getProductCode();
                  imsiName = dto.getProductName();
                  imsiPrice = dto.getProductPrice();

                  //첨부파일유무
                  String[] imsiArray01 = dto.getAttachInfo().split(",");
                  String[] imsiArray02 = imsiArray01[0].split("[|]");
                  imsiImg = imsiArray02[1];
                  if (imsiImg.equals("-")) {
                     imsiImg = "이미지 없음";
                  } else {
                     String imsiImgPath = "";
                     imsiImgPath += request.getContextPath();
                     imsiImgPath += "/attach";
                     imsiImgPath += request.getContextPath();
                     imsiImgPath += "/product/";
                     imsiImgPath += imsiImg;
                     
                     imsiImg = "<img src='" + imsiImgPath + "' width='100%' height='100%'>";
                  }
               }
         %>
               <td style="padding: 20px">
               <%=idx %><hr>
                  <% if(idxExist.equals("O")) { %>
                     <table border="0" style="width: 200px; align="left">
                        <tr>
                           <td height="120">
                              <a href="#" onClick="move('shopMall_view','<%=imsiCode%>')"><%=imsiImg %></a>
                           </td>
                        </tr>
                        <tr>
                           <td><%=imsiName %> (<%=imsiCode %>)</td>
                        </tr>
                        <tr>
                           <td><%=imsiPrice %></td>
                        </tr>
                     </table>
                  <% } else { %>
                     &nbsp;
                  <% } %>
               </td>
         <%   
               idx++;
            }
         %>
      </tr>
<%
   }
%>

</table> 
<script>
function move(value1, value2) {
   location.href = 'main.jsp?menuGubun=' + value1 +  '&productCode=' + value2
}
</script>