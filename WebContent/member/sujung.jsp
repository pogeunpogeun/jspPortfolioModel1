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
<h2>회원수정</h2>
<form name="sujungForm">
<input type="hidden" name="no" value="<%=no %>">
<table border="1" align="center">
	<tr>
		<td>아이디</td>
		<td><%=dto.getId()%></td>
		<td rowspan="5">
		 <% 
               if(  dto.getAttachInfo() == null || dto.getAttachInfo().equals("-")) {
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
            		  
                 		  
            		  out.println("<img src='" + imsiImgPath + "' width='100' height='100'<br>");
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
		<td><%=dto.getName()%></td>
	</tr>
	<tr>
		<td>연락처</td>
		<td><input type="text" name="phone" value="<%=dto.getPhone()%>"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email" value="<%=dto.getEmail()%>"></td>
	</tr>
	<tr>
		<td>주민등록번호</td>
		<td colspan="2"><%=dto.getJumin()%></td>
	</tr>
	<tr>
		<td rowspan="3">주소</td>
		<td colspan="2">
			<input type="text" name="juso1" id="sample6_postcode" placeholder="우편번호" value="<%=dto.getJuso1()%>">
			<button type="button" onClick="sample6_execDaumPostcode();">우편번호 찾기</button>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="text" name="juso2" id="sample6_address" placeholder="주소" value="<%=dto.getJuso2()%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="text" name="juso3" id="sample6_detailAddress" placeholder="상세주소" value="<%=dto.getJuso3()%>">
			<input type="text" name="juso4" id="sample6_extraAddress" placeholder="참고항목" value="<%=dto.getJuso4()%>">
		</td>
	</tr>
	<tr>
		<td>회원등급</td>
		<td colspan="2">
			<% if(dto.getGrade().equals("최우수회원")) { %>
				<input type="radio" name="grade" value="최우수회원" checked>최우수회원&nbsp;
				<input type="radio" name="grade" value="우수회원">우수회원&nbsp;
				<input type="radio" name="grade" value="일반회원">일반회원&nbsp;
			<% } else if (dto.getGrade().equals("우수회원")) { %>
				<input type="radio" name="grade" value="최우수회원">최우수회원&nbsp;
				<input type="radio" name="grade" value="우수회원" checked>우수회원&nbsp;
				<input type="radio" name="grade" value="일반회원">일반회원&nbsp;
			<% } else if (dto.getGrade().equals("일반회원")) { %>
				<input type="radio" name="grade" value="최우수회원">최우수회원&nbsp;
				<input type="radio" name="grade" value="우수회원">우수회원&nbsp;
				<input type="radio" name="grade" value="일반회원" checked>일반회원&nbsp;
			<% } %>
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<button type="button" onClick="sujung();">수정하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=member_list';">목록으로</button>
	</tr>
	
</table>
</form>
<script>
	function sujung() {
		if(confirm('수정하시겠습니까?')) {
			document.sujungForm.action="mainProc.jsp?menuGubun=member_sujungProc";
			document.sujungForm.method="post";
			document.sujungForm.submit();
		}
	}
</script>
<%@ include file = "_inc_daumAPI.jsp" %>