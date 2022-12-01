<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	dao = new BoardDAO();
	ArrayList<BoardDTO> list = dao.getSelectAll();
%>

<h2>게시글 목록</h2>

<table border="1" width="80%">
	<tr>
		<th>순번</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
		
		<th>refNo</th>
		<th>stepNo</th>
		<th>levelNo</th>
		<th>parentNo</th>
		
		<th>memberNo</th>
		<th>ip</th>
		<th>공지글</th>
		<th>비밀글</th>
	</tr>
	
	<%
		for (int i=0; i<list.size(); i++) {
			BoardDTO listDto = list.get(i);
	%>
			<tr>
				<td><%=listDto.getNo() %></td>
				<td>
					<%
						String blankValue = "";
						for (int j=2; j<=listDto.getStepNo(); j++) {
							blankValue += "&nbsp;&nbsp;";
						}
					
						String imsiSubject = "";
						if (listDto.getStepNo() >= 2) {
							imsiSubject += "[Re]:";
						}
						imsiSubject += listDto.getSubject();
						
						if (imsiSubject.length() > 15) {
							imsiSubject = imsiSubject.substring(0, 15) + "..";
						}
					%>
					<%=blankValue %><a href="#" onClick="move('board_view', '<%=listDto.getNo() %>');"><%=imsiSubject %></a>
				</td>
				<td><%=listDto.getWriter() %></td>
				<td><%=listDto.getRegiDate() %></td>
				<td><%=listDto.getHit() %></td>
				
				<td><%=listDto.getRefNo() %></td>
				<td><%=listDto.getStepNo() %></td>
				<td><%=listDto.getLevelNo() %></td>
				<td><%=listDto.getParentNo() %></td>
				
				<td><%=listDto.getMemberNo() %></td>
				<td><%=listDto.getIp() %></td>
				<td><%=listDto.getNoticeNo() %></td>
				<td><%=listDto.getSecretGubun() %></td>
			</tr>
	<%
		}
	%>
</table>

<div style="border: 0px solid red; padding-top: 20px; width: 80%; " align="right">
	|
	<a href="#" onClick="move('board_list', '');">목록</a>
	|	
	<a href="#" onClick="move('board_chuga', '');">등록</a>
	|
</div>

<script>
function move(value1, value2) {
	var linkAddr = 'main.jsp?menuGubun=' + value1 + '&no=' + value2;
	location.href = linkAddr;
}
</script>