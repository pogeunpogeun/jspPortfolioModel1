<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
    
<%@page import="java.util.ArrayList"%>
<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>

<%
Util util = new Util();
   
   String searchGubun = request.getParameter("searchGubun");
   String searchData = request.getParameter("searchData");
   
   searchGubun = util.getNullBlankCheck(searchGubun, "");
   searchData = util.getNullBlankCheck(searchData, "");
   
   if(searchGubun.equals("") || searchData.equals("")) {
	   searchGubun="";
	   searchData="";
   }
   DAO dao = new DAO();
   ArrayList<DTO> list = dao.getSelectAll(searchGubun,searchData);
%>
<h2>회원등록</h2>
<div style="border: 0px solid red; padding: 0px 0px;  width: 80%;" align="left">
	<%
	if(searchGubun.equals("") || searchData.equals("")) {
	%>
	* 전체목록 (<%=list.size()%>건)
	<%
	} else {
	%>
	* 검색어 "<%=searchData%>"으/로 검색된 목록 (?건)
	<%
	}
	%>
</div>
<table border="1" width="80%">
   <tr>
      <th>순번</th>
      <th>사진</th>
      <th>아이디</th>
      <th>이름</th>
      <th>연락처</th>
      <th>주민번호</th>
      <th>등급</th>
      <th>등록일</th>
   </tr>
   
   <%
      for(int i=0; i<list.size(); i++) {
               DTO dto = list.get(i);
      %>
      <tr>
         <td><%=dto.getNo() %></td>
         <td>
            <%--<%=dto.getAttachInfo() --%>
            <% 
               if(  dto.getAttachInfo() == null || dto.getAttachInfo().equals("") || dto.getAttachInfo().equals("-")) {
                  out.println("&nbsp;");
               } else {
            	  String[] imsiArray = dto.getAttachInfo().split(",");
            	  for(int j=0; j<imsiArray.length; j++) {
            		  String[] imsiArray2 = imsiArray[j].split("[|]");
            		  
            		  String imsiImgPath = "";
            		  imsiImgPath += request.getContextPath();
            		  imsiImgPath += "/attach";
            		  imsiImgPath += request.getContextPath();
            		  imsiImgPath += "/member/";
            		  imsiImgPath += imsiArray2[1];
            		  
                 		  
            		  out.println("<img src='" + imsiImgPath + "' width='50' height='50'<br>");
            	  }
               }
            %>
         </td>
         <td><a href="#" onClick="move('member_view','<%=dto.getNo() %>');"><%=dto.getId() %></a></td>
         <td><%=dto.getName() %></td>
         <td><%=dto.getPhone() %></td>
         <td><%=dto.getJumin() %></td>
         <td><%=dto.getGrade() %></td>
         <td><%=dto.getRegiDate() %></td>
      </tr>
   <%
      }
   %>
      <tr>
      	<td colspan="8" align="center">
      		<form name="searchForm">
      			<select name="searchGubun">
      			<option value="" <%if(searchGubun.equals("")) {out.println("selected");} %>>-- 선택 --</option>
      			<option value="id" <%if(searchGubun.equals("id")) {out.println("selected");} %>>아이디</option>
      			<option value="name" <%if(searchGubun.equals("name")) {out.println("selected");} %>>이름</option>
      			<option value="phone" <%if(searchGubun.equals("phone")) {out.println("selected");} %>>연락처</option>
      			<option value="jumin" <%if(searchGubun.equals("jumin")) {out.println("selected");} %>>주민번호</option>
      			<option value="all_info" <%if(searchGubun.equals("all_info")) {out.println("selected");} %>>아이디+이름+연락처+주민번호</option>
      			</select>
      			&nbsp;
      			<input type="text" name="searchData" value="<%=searchData %>">
      			&nbsp;
      			<button type="button" onClick="search();">검색하기</button>
      		</form>
      	</td>
      </tr>
</table>

<div style="border: 0px solid red; padding-top: 20px; width: 80%;" align="right">
   |
   <a href="#" onClick="move('member_list','');">목록</a>
   |
   <a href="#" onClick="move('member_chuga','');">등록</a>
   |
   <a href="#" onClick="move('member_attachChuga','');">등록(attach)</a>
   |
</div>

<script>
function move(value1, value2) {
   location.href = 'main.jsp?menuGubun=' + value1  + '&no=' + value2;
}
function search() {
	document.searchForm.action='mainProc.jsp?menuGubun=member_listSearch';
	document.searchForm.method="post";
	document.searchForm.submit();
}

</script>