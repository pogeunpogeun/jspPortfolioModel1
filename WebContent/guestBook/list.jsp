<%@page import="config.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="guestBook.model.dao.GuestBookDAO"%>
<%@page import="guestBook.model.dto.GuestBookDTO"%>
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
	
	GuestBookDAO dao = new GuestBookDAO();
	ArrayList<GuestBookDTO> list = dao.getSelectAll(searchGubun, searchData);
%>    
<h2>방명록</h2>
<!-- <fieldset style="border:0px solid blue; margin:10px 0px 20px 0px; width:80%">
	<form name="chugaForm">
	<table border="0" align="left">
		<tr>
			<td></td>
			<td><input type="hidden" name="no" id="no"></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="hidden" name="procGubun" id="procGubun" value="guestBook_chugaProc"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="name" id="name"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd" id="passwd"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email" id="email"></td>
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
<div style="border: 0px solid red; padding: 0px 0px;  width: 80%;" align="left">
	<% if(searchGubun.equals("") || searchData.equals("")) { %>
	* 전체목록 (<%=list.size() %>건)
	<% } else { %>
	* 검색어 "<%=searchData %>"으/로 검색된 목록 (?건)
	<% } %>
</div>
<table border="1" width="80%">
	<tr>
		<th>순번</th>
		<th>이름</th>
		<th>이메일</th>
		<th>등록일</th>
		<th>실작성자</th>
		<!-- <th>비고</th> -->
	</tr>
	
	<%
		for(int i=0; i<list.size(); i++) {
			GuestBookDTO dto = list.get(i);		
	%>	
	<tr>
		<td><%=dto.getNo() %></td>
		<td><a href="#" onClick="move('guestBook_view','<%=dto.getNo() %>');"><%=dto.getName() %></a></td>
		<td><%=dto.getEmail() %></td>
		<td><%=dto.getRegiDate() %></td>
		<td><%=dto.getMemberNo() %></td>
		<%-- <td>
			<a href="#" onClick="suntaek('<%=dto.getNo() %>','guestBook_sujungProc','수정하기');">[수정]</a>
			/
			<a href="#" onClick="suntaek('<%=dto.getNo() %>','guestBook_sakjeProc','삭제하기');">[삭제]</a>
		</td> --%>
	<%
		}
	%>
		<tr>
			<td colspan="7" align="center" style="padding: 20px 0px;">
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
   <a href="main.jsp?menuGubun=guestBook_chuga">등록</a>
   |
   <a href="#" onClick="move('guestBook_attachChuga','');">등록(attach)</a>
   |
</div>
<script>
function suntaek(value1,value2,value3) {
	var jsNo = $("#no" + value1).val();
	var jsWriter = $("#name" + value1).val();
	var jsEmail = $("#email" + value1).val();
	var jsPasswd = $("#passwd" + value1).val();
	var jsContent = $("#content" + value1).val();
	
  	$("#no").val(jsNo);
	$("#name").val(jsWriter);
 	$("#content").val(jsContent);
 	$("#email").val(jsEmail);
 	$("#passwd").val(jsPasswd);
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
