<%@page import="config.Util"%>
<%@page import="memo.model.dto.MemoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="memo.model.dao.MemoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%
	String searchGubun = request.getParameter("searchGubun");
	String searchData = request.getParameter("searchData");
	
	Util util = new Util();
	
	searchGubun = util.getNullBlankCheck(searchGubun,"");
	searchData = util.getNullBlankCheck(searchData,"");
	
	if(searchGubun.equals("") || searchData.equals("")) {
		searchGubun = "";
		searchData = "";
	}
	MemoDAO dao = new MemoDAO();
	ArrayList<MemoDTO> list = dao.getSelectAll(searchGubun, searchData);
	
	
%>
<h2>메모목록</h2>
<div style="border: 0px solid red; padding: 0px 0px;  width: 80%;" align="left">
	<% if(searchGubun.equals("") || searchData.equals("")) { %>
	* 전체목록 (<%=list.size() %>건)
	<% } else { %>
	* 검색어 "<%=searchData %>"으/로 검색된 목록 (?건)
	<% } %>
</div>
<!-- <fieldset style="border:0px solid blue; margin:10px 0px 20px 0px; width:80%">
	<form name="chugaForm">
	<table border="0" align="left">
		<tr>
			<td>no</td>
			<td><input type="text" name="no" id="no"></td>
		</tr>
		<tr>
			<td>procGubun</td>
			<td><input type="text" name="procGubun" id="procGubun" value="memo_chugaProc"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="writer" id="writer"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="content" id="content"></textarea></td>
		</tr>
		<tr>
			<td><button type="button" onClick="save();" id="btnSave">등록하기</button></td>
		</tr>
	</table>
	</form>
	<script>
		function save() {
			if(confirm('처리할까요?')) {
				var procGubun = document.chugaForm.procGubun.value;
				document.chugaForm.action = "mainProc.jsp?menuGubun=" + procGubun;
				document.chugaForm.method="post";
				document.chugaForm.submit();
			}
		}
	</script>
</fieldset> -->
<table border="1" width="80%">
<tr>
	<th>순번</th>
	<th>사진</th>
	<th>작성자</th>
	<th>내용</th>
	<th>등록일</th>
	<!-- <th>비고</th> -->
</tr>

<%
	for(int i=0; i<list.size(); i++) {
		MemoDTO dto = list.get(i);
	
%>
	<tr>
		<td><%=dto.getNo() %></td>
		<td>
		 <% 
               if(dto.getAttachInfo() == null || dto.getAttachInfo().equals("") || dto.getAttachInfo().equals("-")) {
                  out.println("사진없음");
               } else {
            	  String[] imsiArray = dto.getAttachInfo().split(",");
            	  for(int j=0; j<imsiArray.length; j++) {
            		  String[] imsiArray2 = imsiArray[j].split("[|]");
            		  
            		  String imsiImgPath = "";
            		  imsiImgPath += request.getContextPath();
            		  imsiImgPath += "/attach";
            		  imsiImgPath += request.getContextPath();
            		  imsiImgPath += "/memo/";
            		  imsiImgPath += imsiArray2[1];
            		  
            		  out.println("<img src='" + imsiImgPath + "' width='50' height='50'<br>");
            	  }
               }
            %>
        </td>
		<td><a href="#" onClick="move('memo_view','<%=dto.getNo() %>');"><%=dto.getWriter() %></a></td>
		<td><%=dto.getContent() %>
			<input type="hidden" id="no<%=dto.getNo() %>" value="<%=dto.getNo() %>"><br>
			<input type="hidden" id="writer<%=dto.getNo() %>" value="<%=dto.getWriter() %>"><br>
			<input type="hidden" id="content<%=dto.getNo() %>" value="<%=dto.getContent() %>">
			
		</td>
		<td><%=dto.getRegiDate() %></td>
		<%-- <td>
			<a href="#" onClick="suntaek('<%=dto.getNo() %>','memo_sujungProc','수정하기');">[수정]</a>
			/
			<a href="#" onClick="suntaek('<%=dto.getNo() %>','memo_sakjeProc','삭제하기');">[삭제]</a>
		</td> --%>
	</tr>
<%
	}
%>		
<tr>
			<td colspan="5" align="center" style="padding: 20px 0px;">
			<form name="searchForm">
			<select name="searchGubun">
			<option value="" <% if(searchGubun.equals("")) {out.println("selected");} %>>-- 선택 --</option>
			<option value="name" <% if(searchGubun.equals("name")) {out.println("selected");} %>>이름</option>
			<option value="content" <% if(searchGubun.equals("content")) {out.println("selected");} %>>내용</option>
			<option value="name_content" <% if(searchGubun.equals("name_content")) {out.println("selected");} %>>이름+내용</option>
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
   <a href="main.jsp?menuGubun=memo_chuga">등록</a>
   |
   <a href="#" onClick="move('memo_attachChuga','');">등록(attach)</a>
   |
  
</div>

<script>
function suntaek(value1,value2,value3) {
	var jsNo = $("#no" + value1).val();
	var jsWriter = $("#writer" + value1).val();
	var jsContent = $("#content" + value1).val();
	
  	$("#no").val(jsNo);
	$("#writer").val(jsWriter);
 	$("#content").val(jsContent);
 	$("#procGubun").val(value2);
 	$("#btnSave").text(value3);
}
function move(value1, value2) {
   location.href = 'main.jsp?menuGubun=' + value1  + '&no=' + value2;
}
function search() {
	document.searchForm.action="mainProc.jsp?menuGubun=guestBook_listSearch";
	document.searchForm.method="post";
	document.searchForm.submit();
}
</script>