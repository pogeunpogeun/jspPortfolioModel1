<%@ include file = "_inc_top.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
    
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
<h2>회원상세보기</h2>
<table border="1" align="center">
	<tr>
		<td>아이디</td>
		<td><%=dto.getId() %></td>
		<td rowspan="5">
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
            		  imsiImgPath += "/member/";
            		  imsiImgPath += imsiArray2[1];
            		  
                 		  
            		  out.println("<img src='" + imsiImgPath + "' width='100' height='100'<br>");
            	  }
               }
            %>
		</td>
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
		<td><%=dto.getJumin().substring(0,8) %>******</td>
	</tr>
	<tr>
		<td>주소</td>
		<td colspan="2"><%=dto.getJuso1() %>&nbsp;<%=dto.getJuso2() %>&nbsp;<%=dto.getJuso3() %>&nbsp;<%=dto.getJuso4() %></td>
	</tr>
	<tr>
		<td>회원등급</td>
		<td colspan="2"><%=dto.getGrade() %></td>
	</tr>
</table>
<div style="border: 0px solid red; padding-top:20px; width:80%;" align="right">
|
<a href="#" onClick="move('member_list','');">목록</a>
|
<a href="#" onClick="move('member_chuga','');">등록</a>
|
<a href="#" onClick="move('member_sujung','<%=no %>');">수정</a>
|
<a href="#" onClick="move('member_sujungAttach','<%=no %>');">수정(attach)</a>
|
<a href="#" onClick="move('member_sakje','<%=no %>');">삭제</a>
|
</div>
<script>
	function move(value1, value2) {
		location.href = 'main.jsp?menuGubun=' + value1 + '&no=' + value2;
	}
</script>