<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String pageNumber_ = request.getParameter("pageNumber");
	if(pageNumber_ == null || pageNumber_.trim().equals("")) {
		pageNumber_ = "1";
	}
	int pageNumber = Integer.parseInt(pageNumber_);
	
	
	String searchValue = "O";
	String searchGubun = request.getParameter("searchGubun");
	String searchData = request.getParameter("searchData");
	
	if(searchGubun == null || searchGubun.trim().equals("")) {
		searchGubun = "";
	}
	if(searchData == null || searchData.trim().equals("")) {
		searchData = "";
	}
	if(searchGubun.equals("") || searchData.equals("")) {
		searchValue = "X";
		searchGubun = "";
		searchData = "";
	}
	
	ShopProductDAO listDao = new ShopProductDAO();
	
	int totalRecord = listDao.getTotalRecord(searchGubun, searchData);
	int pageSize = 10; // 한 페이지에 나타낼 레코드 갯수
	int blockSize = 10; // 하단 페이지 그리드 개수
	
	int block = (pageNumber -1) / pageSize;
	int jj = totalRecord - pageSize * (pageNumber -1); // 단순 화면에 보일 일련번호
	
	double totalPageDou = Math.ceil(totalRecord / (double)pageSize);
	int totalPage = (int)totalPageDou;
	
	int startRecord = pageSize * (pageNumber -1) + 1;
	int lastRecord = pageSize * pageNumber;
	
	ArrayList<ShopProductDTO> list = listDao.getSelectAllForSearch(searchGubun, searchData, startRecord, lastRecord);
	
%>
<h2>제품리스트</h2>
<div style="border:0px solid red; padding:5px 0px 5px 0px; width:55%;" align="left">
<% if(searchValue.equals("O")) { %>
	* 검색어 '<%=searchData %>'(으)로 검색된 목록 : <%=totalRecord %>건
<% } else { %>
	*  전체 목록 : <%=totalRecord %>건
<% } %>
(<%=pageNumber %> / <%=totalPage %>)
</div>
<table border="1" width="80%">
	<tr>
		<th>제품코드</th>
		<th>사진</th>
		<th>제품명</th>
		<th>가격</th>
		<th>제조사코드</th>
		<th>등록일</th>
	</tr>
<%
	for(int i=0; i<list.size(); i++) {
		ShopProductDTO listDto = list.get(i);
%>
	<tr>
		<td><%=listDto.getProductCode() %></td>
		<td>
			 <% 
               if( listDto.getAttachInfo() == null || listDto.getAttachInfo().equals("-")) {
                  out.println("&nbsp;");
               } else {
                  String[] imsiArray = listDto.getAttachInfo().split(",");
                  
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
                     if(j == 0) {
                        break;
                     }
                  }
               }
            %>
		</td>
		<td><a href="#" onClick="move('shopProduct_view','<%=listDto.getProductCode()%>');"><%=listDto.getProductName() %></a></td>
		<td><%=listDto.getProductPrice() %></td>
		<td><%=listDto.getVendorCode() %></td>
		<td><%=listDto.getRegiDate() %></td>
	</tr>
<%
	}
%>
</table>
<div style="border:0px solid red; padding-top:20px; width:50% " align = "center">
<form name="searchForm">
	<select name="searchGubun">
		<option value="">--선택--</option>
		<option value="productName"<% if (searchGubun.equals("productName")) { out.println("selected"); } %>>상품명</option>		
	</select>	
	<input type="text" name="searchData" value="<%=searchData%>">	
	<button type="button" onClick="search();">검색</button>
</form>
<script>
function search() {
	if(confirm('검색할까요?')) {
		document.searchForm.action="main.jsp?menuGubun=shopProduct_listSearch";
		document.searchForm.method="post";
		document.searchForm.submit();			
	}
}
</script>
</div>
<div style="border: 0px solid red; padding-top :20px; width:80%;" align="right">
|
<a href="#" onClick="move('shopProduct_list','','','');">전체목록</a>
|
<a href="#" onClick="move('shopProduct_list','','<%=searchGubun%>','<%=searchData%>');">목록</a>
|
<a href="#" onClick="move('shopProduct_chuga','','<%=searchGubun%>','<%=searchData%>');">추가</a>
|
<a href="#" onClick="move('shopProduct_attachChuga','','<%=searchGubun %>','<%=searchData %>');">추가(attach)</a>
|
<a href="#" onClick="move('shopProduct_attachChugaWhile','','<%=searchGubun %>','<%=searchData %>');">추가(While)</a>
|
</div>
<script>
	function move(value1, value2) {
		location.href = 'main.jsp?menuGubun=' + value1 + '&productCode=' + value2;
	}
	
</script>