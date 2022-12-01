<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 넘어온 no, noticeNo 값 받는 부분
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	
	String dbNoticeNo_ = request.getParameter("dbNoticeNo");
	int dbNoticeNo = Integer.parseInt(dbNoticeNo_);
	
	// 입력받아 넘어온 값을 받는 부분
	String subject = request.getParameter("subject");
	String email = request.getParameter("email");
	String passwd = request.getParameter("passwd");
	String content = request.getParameter("content");
	String noticeGubun = request.getParameter("noticeGubun");
	String secretGubun = request.getParameter("secretGubun");

	int memberNo = sessionNo;
	String attachInfo = "-";
	
	BoardDAO dao = new BoardDAO();
	
	int noticeNo = 0;
	if(noticeGubun.equals("T")) {
		if(dbNoticeNo > 0) { // 기존 글이 공지글
			noticeNo = dbNoticeNo;
		} else { // 기존 글이 일반글
			noticeNo = dao.getMaxNumRefNo("noticeNo") + 1;
		}
	} 	
	BoardDTO arguDto = new BoardDTO();
	arguDto.setNo(no);
	arguDto.setSubject(subject);
	arguDto.setContent(content);
	arguDto.setEmail(email);
	arguDto.setPasswd(passwd);
	arguDto.setMemberNo(memberNo);
	arguDto.setNoticeNo(noticeNo);
	arguDto.setSecretGubun(secretGubun);
	arguDto.setAttachInfo(attachInfo);
	
	BoardDTO returnDto = dao.getSelectOne(arguDto);
	
	if(!returnDto.getPasswd().equals(passwd)) {
		out.println("<script>");
		out.println("alert('입력한 비밀번호가 다릅니다.\\n확인 후 다시 이용하세요.');");
		out.println("location.href='main.jsp?menuGubun=board_sujung&no=" + no + "';");
		out.println("</script>");
		return;
	}

	int result = dao.setUpdate(arguDto);
	
	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "수정성공";
		addr = "main.jsp?menuGubun=board_view&no=" + no;
	} else {
		ment = "수정실패";
		addr = "main.jsp?menuGubun=board_sujung&no=" + no;
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>"); 
%>