<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String viewPasswd = request.getParameter("viewPasswd");
	if (viewPasswd == null || viewPasswd.trim().equals("")) {
		viewPasswd = "";
	}
	
	SubBoardDTO arguDto = new SubBoardDTO();
	arguDto.setNo(no);
	arguDto.setTbl(tbl);
	arguDto.setSearchGubun(searchGubun);
	arguDto.setSearchData(searchData);
	
	SubBoardDAO subBoardDao = new SubBoardDAO();
	SubBoardDTO returnDto = subBoardDao.getSelectOne(arguDto);
	
	if (returnDto.getNo() <= 0) {
		out.println("메롱..");
		return;
	}
	
	
	String imsiPage = "viewPage";
	if (returnDto.getSecretGubun().equals("T")) {
		if (!returnDto.getPasswd().equals(viewPasswd)) {
			imsiPage = "viewPasswdPage";
		}
	}
%>

<% if (imsiPage.equals("viewPasswdPage")) { //비밀글.. %>

		<form name="passwdForm">
		<input type="hidden" name="no" value="<%=no %>">
		<input type="hidden" name="searchGubun" value="<%=searchGubun %>">
		<input type="hidden" name="searchData" value="<%=searchData %>">
		<table border="0" align="center">
			<tr>
				<td colspan="2">
					<h2>글상세보기 (비밀글입니다.)</h2>
				</td>
			</tr>
			<tr>
			     <td>비밀번호 : </td>
			     <td>
			     	<input type="password" name="viewPasswd">
			     	<button type="button" onClick="passwdSubmit();">확인</button>
			     </td>
			</tr>
		</table>
		</form>
		
		<script>
			function passwdSubmit() {
				if (confirm('전송할까요?')) {
					document.passwdForm.action = "main.jsp?menuGubun=subBoard_view";
					document.passwdForm.method = "post";
					document.passwdForm.submit();
				}
			}
		</script>
		
<% } else { %>

		<h2><%=imsiBoardTitle %> 게시글 상세보기</h2>
		
		<table border="1" width="80%">
			<tr>
				<td width="150">No</td>
				<td><%=returnDto.getNo() %></td>
			</tr>
			<tr>
				<td>num</td>
				<td><%=returnDto.getNum() %></td>
			</tr>	
			<tr>
				<td>작성자</td>
				<td><%=returnDto.getWriter() %></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><%=returnDto.getSubject() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><%=returnDto.getContent().replace("\n", "<br>") %></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=returnDto.getEmail() %></td>
			</tr>
			<tr>
				<td>refNo</td>
				<td><%=returnDto.getRefNo() %></td>
			</tr>
			<tr>
				<td>stepNo</td>
				<td><%=returnDto.getStepNo() %></td>
			</tr>
			<tr>
				<td>levelNo</td>
				<td><%=returnDto.getLevelNo() %></td>
			</tr>
			<tr>
				<td>parentNo</td>
				<td><%=returnDto.getParentNo() %></td>
			</tr>	
			<tr>
				<td>hit</td>
				<td><%=returnDto.getHit() %></td>
			</tr>
			<tr>
				<td>ip</td>
				<td><%=returnDto.getIp() %></td>
			</tr>	
			<tr>
				<td>memberNo</td>
				<td><%=returnDto.getMemberNo() %></td>
			</tr>	
			<tr>
				<td>공지글</td>
				<td><%=returnDto.getNoticeNo() %></td>
			</tr>
			<tr>
				<td>비밀글</td>
				<td><%=returnDto.getSecretGubun() %></td>
			</tr>		
			<tr>
				<td>regiDate</td>
				<td><%=returnDto.getRegiDate() %></td>
			</tr>
			<tr>
				<td>첨부</td>
				<td><%=returnDto.getAttachInfo() %></td>
			</tr>				
		</table>
		
		<div style="border: 0px solid red; padding-top: 10px; width: 80%; " align="center">
			<table border="0" width="100%">
				<tr>
					<td width="150">이전글</td>
					<td>
						<% if (returnDto.getPreNo() > 0) { %>
							<a href="#" onClick="move('subBoard_view','<%=pageNumber %>', '<%=returnDto.getPreNo() %>');"><%=returnDto.getPreSubject() %></a>
						<% } else { %>
							이전글이 없습니다.
						<% } %>
					</td>
				</tr>
				<tr>
					<td>다음글</td>
					<td>
						<% if (returnDto.getNxtNo() > 0) { %>
							<a href="#" onClick="move('subBoard_view', '<%=pageNumber %>','<%=returnDto.getNxtNo() %>');"><%=returnDto.getNxtSubject() %></a>
						<% } else { %>
							다음글이 없습니다.
						<% } %>					
					</td>
				</tr>		
			</table>
		</div>
		
		<div style="border: 0px solid red; padding-top: 20px; width: 80%; " align="right">
			|
			<a href="main.jsp?menuGubun=subBoard_list&tbl=<%=tbl%>">전체목록</a>
			|
			<a href="#" onClick="move('subBoard_list', '1', '');">목록</a>
			|
			<a href="#" onClick="move('subBoard_chuga', '<%=pageNumber %>', '');">등록</a>
			|
			<a href="#" onClick="move('subBoard_chuga', '<%=pageNumber %>', '<%=returnDto.getNo() %>');">답변</a>	
			|
			<a href="#" onClick="move('subBoard_sujung', '<%=pageNumber %>', '<%=returnDto.getNo() %>');">수정</a>
			|
			<a href="#" onClick="move('subBoard_sakje', '<%=pageNumber %>', '<%=returnDto.getNo() %>');">삭제</a>
			|
		</div>
		
		<script>
		function move(value1, value2, value3) {
			var imsiQueryString = '<%=imsiQueryString%>';
			location.href = "main.jsp?menuGubun=" + value1 + "&pageNumber=" + value2 + "&no=" + value3 + "&" + imsiQueryString;
		}
		</script>
		
<% } %>


<% if (imsiPage.equals("viewPage")) { %>

	<a name="comment"></a>
	<div id="commentResult" style="border: 0px solid red; margin: 20px 0px 20px 0px; width: 80%; " align="center"></div>

	<script>
	$(document).ready(function(){
		commentList();
	});
	
	function commentList() {
		var param = {
				"no" : <%=no %>
		}
		var url = "../subBoard/commentList.jsp";
		$.ajax({
			type: "post",
			data: param,
			url: url,
			success: function(data) {
				$("#commentResult").html(data);
			}
		});
	}
	</script>

<% } %>