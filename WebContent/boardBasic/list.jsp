<%@include file = "_inc_top.jsp" %>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardBasicDAO dao = new BoardBasicDAO();
	ArrayList<BoardBasicDTO> list = dao.getSelectAll();
%>    
    
<h2>게시판</h2>
<table border="1" width="80%">
	<tr>
		<th>순번</th>
		<th>작성자</th>
		<th>제목</th>
		<th>등록일</th>
		<th>조회수</th>
		<th>refNo</th>
		<th>stepNo</th>
		<th>levelNo</th>
		<th>memberNo</th>
		<th>ip</th>
		<th>parentNo</th>
	</tr>
	<%
		for(int i=0; i<list.size(); i++) {
			BoardBasicDTO dto = list.get(i);			
	%>
		<tr>
			<td><%=dto.getNo() %></td>
			<td><%=dto.getWriter() %></td>
			<td>
				<%
					String subject = dto.getSubject();
					if(subject.length() > 5) {
						subject = subject.substring(0,5) + "..";
					}
					
						for (int k=2; k <=dto.getStepNo(); k++) {
							out.println("&nbsp;&nbsp;&nbsp;");
						}
						if (dto.getStepNo() > 1) {
							subject = "[Re]:" + subject;
						}
					%>
				<% if(imsiSessionChk.equals("X") && sessionNo > 0) { %>
					<a href="#" onClick="move('boardBasic_view','<%=dto.getNo() %>');"><%=subject %></a>
				<% } else { %>
					<%=subject %>
				<% } %>
			</td>
			<td><%=dto.getRegiDate() %></td>
			<td><%=dto.getHit() %></td>
			<td><%=dto.getRefNo() %></td>
			<td><%=dto.getStepNo() %></td>
			<td><%=dto.getLevelNo() %></td>
			<td>
				<%=dto.getMemberNo() %>
				<%
					if (dto.getMemberNo() > 0) {
						out.println("(회원)");
					} else {
						out.println("(비회원)");
					}
				%>
			</td>
			<td><%=dto.getIp() %></td>
			<td><%=dto.getParentNo() %></td>
		</tr>
	<%
		}
	%>
</table>
<div style="border: 0px solid red; padding-top: 20px; width: 80%;" align="right">
   |
   <a href="#" onClick="move('boardBasic_list','');">목록</a>
   |
   <a href="#" onClick="move('boardBasic_chuga','');">등록</a>
   |
</div>

<script>
function move(value1, value2) {
   location.href = 'main.jsp?menuGubun=' + value1  + '&no=' + value2;
}

</script>