<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<h2>게시글상세보기</h2>

<table border="1" width="80%">
	<tr>
		<td width="150">No</td>
		<td><%=dto.getNo() %></td>
	</tr>
	<tr>
		<td>num</td>
		<td><%=dto.getNum() %></td>
	</tr>	
	<tr>
		<td>작성자</td>
		<td><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><%=dto.getSubject() %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><%=dto.getContent().replace("\n", "<br>") %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%=dto.getEmail() %></td>
	</tr>
	<tr>
		<td>refNo</td>
		<td><%=dto.getRefNo() %></td>
	</tr>
	<tr>
		<td>stepNo</td>
		<td><%=dto.getStepNo() %></td>
	</tr>
	<tr>
		<td>levelNo</td>
		<td><%=dto.getLevelNo() %></td>
	</tr>
	<tr>
		<td>parentNo</td>
		<td><%=dto.getParentNo() %></td>
	</tr>	
	<tr>
		<td>hit</td>
		<td><%=dto.getHit() %></td>
	</tr>
	<tr>
		<td>ip</td>
		<td><%=dto.getIp() %></td>
	</tr>	
	<tr>
		<td>memberNo</td>
		<td><%=dto.getMemberNo() %></td>
	</tr>	
	<tr>
		<td>공지글</td>
		<td><%=dto.getNoticeNo() %></td>
	</tr>
	<tr>
		<td>비밀글</td>
		<td><%=dto.getSecretGubun() %></td>
	</tr>		
	<tr>
		<td>regiDate</td>
		<td><%=dto.getRegiDate() %></td>
	</tr>
	<tr>
		<td>첨부</td>
		<td><%=dto.getAttachInfo() %></td>
	</tr>	
</table>

<div style="border: 0px solid red; padding-top: 20px; width: 80%; " align="right">
	|
	<a href="#" onClick="move('board_list', '');">목록</a>
	|
	<a href="#" onClick="move('board_chuga', '');">등록</a>
	|
	<a href="#" onClick="move('board_chuga', '<%=dto.getNo() %>');">답변</a>	
	|
	<a href="#" onClick="move('board_sujung', '<%=dto.getNo() %>');">수정</a>
	|
	<a href="#" onClick="move('board_sakje', '<%=dto.getNo() %>');">삭제</a>
	|
</div>

<script>
function move(value1, value2) {
	var linkAddr = 'main.jsp?menuGubun=' + value1 + '&no=' + value2;
	location.href = linkAddr;
}
</script>