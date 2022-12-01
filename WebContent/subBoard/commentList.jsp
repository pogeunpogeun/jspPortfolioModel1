<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%@ page import="subBoard.model.dao.SubBoardDAO" %>
<%@ page import="subBoard.model.dto.SubBoardCommentDTO" %>

<%@ include file = "../_include/inc_header.jsp" %>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<%
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	SubBoardCommentDTO arguDto = new SubBoardCommentDTO();
	arguDto.setBoardNo(no);
	
	SubBoardDAO subBoardDao = new SubBoardDAO();
	ArrayList<SubBoardCommentDTO> list = subBoardDao.getCommentSelectAll(arguDto);
%>

<table border="0" align="center" width="100%">
	<tr>
		<td style="padding: 0 0 20 0;">
			procGubun : <span id="procGubun" style="display: ;">chugaProc</span><br>
			no : <span id="no" style="display: ;"><%=no %></span><br>
			commentNo : <span id="commentNo" style="display: ;"></span><br>
			이름 : <input type="text" name="commentWriter" id="commentWriter" size="10" value="">
			비밀번호 : <input type="password" name="commentPasswd" id="commentPasswd" size="10" value=""><br>
			댓글 : <input type="text" name="commentContent" id="commentContent" value="" size="40">
				   <button type="button" id="btnCommentSave">등록하기</button>
				   <button type="button" id="btnCommentReset">초기화</button>
		</td>
	</tr>
</table>

<div style="height: 20px;"></div>

<table border="0" align="center" width="100%">
	<%
		for (int i=0; i<list.size(); i++) {
			SubBoardCommentDTO dto = list.get(i);
	%>
			<tr>
				<td style="padding: 0 0 10 0;">
					<table border="0" align="center" width="100%">
						<tr>
							<td><%=dto.getWriter() %>(<%=dto.getCommentNo() %>) &nbsp; <%=dto.getRegiDate() %></td>
							<td align="right">
								<a href="#comment" onClick="suntaek('sujungProc', '<%=dto.getCommentNo() %>', '<%=dto.getWriter() %>', '<%=dto.getContent() %>', '수정하기');">수정</a>
								/
								<a href="#comment" onClick="suntaek('sakjeProc', '<%=dto.getCommentNo() %>', '<%=dto.getWriter() %>', '<%=dto.getContent() %>', '삭제하기');">삭제</a>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<%=dto.getContent().replace("\n", "<br>") %>
							</td>
						</tr>				
					</table>
					<hr>
				</td>
			</tr>
	<%
		}
	%>
</table>

<input type="hidden" id="result">

<script>
$(document).ready(function(){
	$("#btnCommentSave").click(function(){
		commentSave();
	});
	$("#btnCommentReset").click(function(){
		commentReset();
	});
});

function commentSave() {
  	var param = {
  		"procGubun" : $("#procGubun").text(),
		"no" : $("#no").text(),
		"commentNo" : $("#commentNo").text(),
		"writer" : $("#commentWriter").val(),
		"passwd" : $("#commentPasswd").val(),
		"content" : $("#commentContent").val()
	}
	var url = "../subBoard/commentChugaProc.jsp";
	$.ajax({
		type: "post",
		data: param,
		url: url,
		success: function(data) {
			$("#result").val(data);
			if ($("#result").val() == 1) {
				alert("성공");
			} else {
				alert("실패");
			}
			commentList(); 
		}
	});
}

function suntaek(value1, value2, value3, value4, value5) {
	$("#procGubun").text(value1);
	$("#commentNo").text(value2);
	$("#commentWriter").val(value3);
	$("#commentContent").val(value4);
	$("#btnCommentSave").text(value5);
}

function commentReset() {
	$("#procGubun").text('chuga');
	$("#commentNo").text('');
	$("#commentWriter").val('');
	$("#commentContent").val('');
	$("#btnCommentSave").text('등록하기');
}
</script>