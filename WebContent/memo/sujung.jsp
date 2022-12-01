<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%> 
    
<%
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	MemoDTO arguDto = new MemoDTO();
	arguDto.setNo(no);
	
	MemoDAO dao = new MemoDAO();
	MemoDTO dto = dao.getSelectOne(arguDto);	
%>
<h2>메모 수정</h2>
<form name="sujungForm">
<input type="hidden" name="no" value="<%=no %>">
<table border="1">
	<tr>
		<td>작성자</td>
		<td><%=dto.getWriter() %></td>
		<td rowspan="3">
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
            		  
                 		  
            		  out.println("<img src='" + imsiImgPath + "' width='100' height='100'<br>");
            	  }
               }
            %>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width:500px; height:200px"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;">
		<button type="button" onClick="sujung();">수정하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=memo_list';">목록으로</button>
		</td>
	</tr>
</table>
</form>
<script>
	function sujung() {
		if(confirm('수정하시겠습니까?')) {
			document.sujungForm.action="mainProc.jsp?menuGubun=memo_sujungProc";
			document.sujungForm.method="post";
			document.sujungForm.submit();
		}
	}
</script>