<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
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
	BoardDTO arguDto = new BoardDTO();
	arguDto.setNo(no);
	
	BoardDAO dao = new BoardDAO();
	BoardDTO viewDto = dao.getSelectOne(arguDto);
%>
<h2>게시글 상세보기</h2>
<table border="1" width="50%">
	<tr>
		<td>no</td>
		<td><%=viewDto.getNo() %></td>
	</tr>	
	<tr>
		<td>num</td>
		<td><%=viewDto.getNum() %></td>
	</tr>
	<tr>
		<td>tbl</td>
		<td><%=viewDto.getTbl() %></td>
	</tr>
	<tr>
		<td>writer</td>
		<td><%=viewDto.getWriter() %></td>
	</tr>
	<tr>
		<td>subject</td>
		<td><%=viewDto.getSubject() %></td>
	</tr>
	<tr>
		<td>content</td>
		<td><%=viewDto.getContent().replace("\n","<br>") %></td>
	</tr>
	<tr>
		<td>email</td>
		<td><%=viewDto.getEmail() %></td>
	</tr>
	<tr>
		<td>passwd</td>
		<td><%=viewDto.getPasswd() %></td>
	</tr>
	<tr>
		<td>refNo</td>
		<td><%=viewDto.getRefNo() %></td>
	</tr>
	<tr>
		<td>stepNo</td>
		<td><%=viewDto.getStepNo() %></td>
	</tr>
	<tr>
		<td>levelNo</td>
		<td><%=viewDto.getLevelNo() %></td>
	</tr>
	<tr>
		<td>parentNo</td>
		<td><%=viewDto.getParentNo() %></td>
	</tr>
	<tr>
		<td>hit</td>
		<td><%=viewDto.getHit() %></td>
	</tr>
	<tr>
		<td>IP</td>
		<td><%=viewDto.getIp() %></td>
	</tr>
	<tr>
		<td>memberNo</td>
		<td><%=viewDto.getMemberNo() %></td>
	</tr>
	<tr>
		<td>noticeNo</td>
		<td><%=viewDto.getNoticeNo() %></td>
	</tr>
	<tr>
		<td>secretGubun</td>
		<td><%=viewDto.getSecretGubun() %></td>
	</tr>
	<tr>
		<td>regiDate</td>
		<td><%=viewDto.getRegiDate() %></td>
	</tr>
	<tr>
		<td>attachInfo</td>
		<td><%=viewDto.getAttachInfo() %></td>
	</tr>
</table>
<div style="border: 0px solid red; padding-top :20px; width:80%;" align="right">
|
<a href="#" onClick="move('board_chuga','<%=viewDto.getNo()%>','<%=searchGubun %>','<%=searchData %>');">답변</a>
|
<a href="#" onClick="move('board_list','','<%=searchGubun %>','<%=searchData %>');">목록</a>
|
<a href="#" onClick="move('board_chuga','','<%=searchGubun %>','<%=searchData %>');">추가</a>
|
<a href="#" onClick="move('board_sujung','<%=viewDto.getNo()%>','<%=searchGubun %>','<%=searchData %>');">수정</a>
|
<a href="#" onClick="move('board_sakje','<%=viewDto.getNo()%>','<%=searchGubun %>','<%=searchData %>');">삭제</a>
|
</div>
<%@ include file = "_inc_script.jsp" %>