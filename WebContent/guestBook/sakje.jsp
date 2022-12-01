<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="guestBook.model.dao.GuestBookDAO"%>
<%@page import="guestBook.model.dto.GuestBookDTO"%>
<%
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	GuestBookDTO arguDto = new GuestBookDTO();
	arguDto.setNo(no);
	
	GuestBookDAO dao = new GuestBookDAO();
	GuestBookDTO dto = dao.getSelectOne(arguDto);
	
	if(dto.getNo() <= 0) {
		out.println("<script>");
		out.println("alert('존재하지 않는 내용입니다.')");
		out.println("location.href='main.jsp?menuGubun=guestBook_list';");
		out.println("</script>");
		return;
	}
%>
<h2>방명록 삭제</h2>
<form name="sakjeForm">
<input type="hidden" name="no" value="<%=no %>">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><%=dto.getName() %></td>
		<td rowspan="4">
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
            		  imsiImgPath += "/guestBook/";
            		  imsiImgPath += imsiArray2[1];
            		  
                 		  
            		  out.println("<img src='" + imsiImgPath + "' width='100' height='100'<br>");
            	  }
               }
            %>
		</td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%=dto.getEmail() %></td>
	</tr>	
	<tr>
		<td>내용</td>
		<td><%=dto.getContent() %></td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><%=dto.getRegiDate() %></td>
	</tr>
	<tr>
		<td colspan="3" style="text-align:center;">
		<button type="button" onClick="sakje();">삭제하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=guestBook_list';">목록으로</button>
	</tr>
</table>
</form>
<script>
	function sakje() {
		if(confirm('삭제하시겠습니까?')) {
			document.sakjeForm.action="mainProc.jsp?menuGubun=guestBook_sakjeProc";
			document.sakjeForm.method="post";
			document.sakjeForm.submit();
		}
	}
</script>