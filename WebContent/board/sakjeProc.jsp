<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 넘어온 no, noticeNo 값 받는 부분
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);

	String passwd = request.getParameter("passwd");
	
	BoardDTO arguDto = new BoardDTO();
	arguDto.setNo(no);
	arguDto.setPasswd(passwd);

	BoardDAO dao = new BoardDAO();
	
	BoardDTO returnDto = dao.getSelectOne(arguDto);
	if(!returnDto.getPasswd().equals(passwd)) {
		out.println("<script>");
		out.println("alert('입력한 비밀번호가 다릅니다.\\n확인 후 다시 이용하세요.');");
		out.println("location.href='main.jsp?menuGubun=board_sakje&no=" + no + "';");
		out.println("</script>");
		return;
	}

	int result = dao.setDelete(arguDto);
	
	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "삭제성공";
		addr = "main.jsp?menuGubun=board_list";
	} else {
		ment = "삭제실패";
		addr = "main.jsp?menuGubun=board_sakje&no=" + no;
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>"); 
%>