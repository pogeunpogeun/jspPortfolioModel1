<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
<%@ include file = "_inc_top.jsp" %>
    
<%
    String no_ = request.getParameter("no");
        	int no = Integer.parseInt(no_);
        	
        	DTO arguDto = new DTO();
        	arguDto.setNo(no);
        	
        	DAO dao = new DAO();
        	DTO dto = dao.getSelectOne(arguDto);
        	
        	if(dto.getNo() <= 0) {
        		out.println("<script>alert('존재하지 않는 회원입니다.'); location.href='main.jsp?menuGubun=member_list';</script>");
        		return;
        	}
    %>
   
<h2>회원삭제</h2>
<form name="sakjeForm">
<input type="hidden" name="no" value="<%=no %>">
<table border="1" align="center">
	<tr>
		<td>아이디</td>
		<td><%=dto.getId() %></td>
		<td rowspan="5">
		<input type="hidden" name="attachInfo" value="<%=dto.getAttachInfo()%>">
		 <% 
               if(dto.getAttachInfo() == null || dto.getAttachInfo().equals("") || dto.getAttachInfo().equals("-")) {
                  out.println("&nbsp;");
               } else {
            	  String[] imsiArray = dto.getAttachInfo().split(",");
            	  for(int j=0; j<imsiArray.length; j++) {
            		  String[] imsiArray2 = imsiArray[j].split("[|]");
            		  
            		  String imsiImgPath = "";
            		  imsiImgPath += request.getContextPath();
            		  imsiImgPath += "/attach";
            		  imsiImgPath += request.getContextPath();
            		  imsiImgPath += "/member/";
            		  imsiImgPath += imsiArray2[1];
            		  
                 		  
            		  out.println("<img src='" + imsiImgPath + "' width='100' height='100'<br>" + imsiArray2[0] + " (" + imsiArray2[3] + ")<br>");
            		  out.println("<input type='hidden' name='attachInfo' value='" + imsiArray2[1] + "'>");
            	  }
               }
            %>
		</td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<td>연락처</td>
		<td><%=dto.getPhone() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%=dto.getEmail() %></td>
	</tr>
	<tr>
		<td>주민등록번호</td>
		<td colspan="2"><%=dto.getJumin().substring(0,8) %>******</td>
	</tr>
	<tr>
		<td>주소</td>
		<td colspan="2"><%=dto.getJuso1() %>&nbsp;<%=dto.getJuso2() %>&nbsp;<%=dto.getJuso3() %>&nbsp;<%=dto.getJuso4() %></td>
	</tr>
	<tr>
		<td>회원등급</td>
		<td colspan="2"><%=dto.getGrade() %></td>
	</tr>
	<tr>
		<td colspan="3">
		<button type="button" onClick="sakje();">삭제하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=member_list';">목록으로</button>
	</tr>
</table>
</form>
<script>
	function sakje() {
		if(confirm('삭제하시겠습니까?')) {
			document.sakjeForm.action="mainProc.jsp?menuGubun=member_sakjeProc";
			document.sakjeForm.method="post";
			document.sakjeForm.submit();
		}
	}
</script>