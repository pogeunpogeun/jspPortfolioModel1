<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String writer = request.getParameter("writer");
	String email = request.getParameter("email");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String noticeGubun = request.getParameter("noticeGubun");
	String secretGubun = request.getParameter("secretGubun");
	
	Util util = new Util();
	
	int failCounter = 0;
	
	writer = util.getNullBlankCheck(writer, "");
	writer = util.getCheckString(writer);
	if (writer.length() <= 0) { failCounter++; }
	
	email = util.getNullBlankCheck(email, "");
	email = util.getCheckString(email);
	if (email.length() <= 0) { failCounter++; }
	
	passwd = util.getNullBlankCheck(passwd, "");
	passwd = util.getCheckString(passwd);
	if (passwd.length() <= 0) { failCounter++; }
	
	subject = util.getNullBlankCheck(subject, "");
	subject = util.getCheckString(subject);
	if (subject.length() <= 0) { failCounter++; }
	
	content = util.getNullBlankCheck(content, "");
	content = util.getCheckString(content);
	if (content.length() <= 0) { failCounter++; }
	
	noticeGubun = util.getNullBlankCheck(noticeGubun, "");
	if (!(noticeGubun.equals("T") || noticeGubun.equals("F"))) {
		failCounter++;
	}
	
	secretGubun = util.getNullBlankCheck(secretGubun, "");
	if (!(secretGubun.equals("T") || secretGubun.equals("F"))) {
		failCounter++;
	}
	
	if (noticeGubun.equals("T") && secretGubun.equals("T")) {
		failCounter++;
	}
	
	if (failCounter > 0) {
		out.println("<script>");
		out.println("alert('입력값이 정확하지않습니다.');");
		out.println("location.href = 'main.jsp?menuGubun=board_chuga';");
		out.println("</script>");
		return;
	}
	
	
	
	//BoardDAO dao = new BoardDAO();
	dao = new BoardDAO();
	
	int num = dao.getMaxNumRefNo("num") + 1;
	String tbl = "-";
	
	
	
	//새글..
	int refNo = dao.getMaxNumRefNo("refNo") + 1;
	int stepNo = 1;
	int levelNo = 1;
	int parentNo = 0;
	
	if (dto.getNo() > 0 ) { //답변글..
		dao.setUpdateRelevel(dto);
	
		refNo = dto.getRefNo();
		stepNo = dto.getStepNo() + 1;
		levelNo = dto.getLevelNo() + 1;
		parentNo = dto.getNo();
	}
	
	
	
	
	int hit = 0;
	//String ip = "";
	int memberNo = sessionNo;
	
	int noticeNo = 0;
	if (noticeGubun.equals("T")) { //공지글이면..
		noticeNo = dao.getMaxNumRefNo("noticeNo") + 1;
	}
	
	String attachInfo = "-";
	  
	BoardDTO arguDto = new BoardDTO();
	arguDto.setNum(num);
	arguDto.setTbl(tbl);
	arguDto.setWriter(writer);
	arguDto.setSubject(subject);
	arguDto.setContent(content);
	arguDto.setEmail(email);
	arguDto.setPasswd(passwd);
	arguDto.setRefNo(refNo);
	arguDto.setStepNo(stepNo);
	arguDto.setLevelNo(levelNo);
	arguDto.setParentNo(parentNo);
	arguDto.setHit(hit);
	arguDto.setIp(ip);
	arguDto.setMemberNo(memberNo);
	arguDto.setNoticeNo(noticeNo);
	arguDto.setSecretGubun(secretGubun);
	arguDto.setAttachInfo(attachInfo);
	
	int result = dao.setInsert(arguDto);
	
	String ment = "";
	String addr = "";
	if (result > 0) {
		ment = "";
		addr = "main.jsp?menuGubun=board_list";
	} else {
		ment = "등록 중 오류가 발생했습니다.";
		addr = "main.jsp?menuGubun=board_chuga";
	}
	
	out.println("<script>");
	if (result > 0) {
		
	} else {
		out.println("alert('" + ment + "');");
	}
	out.println("location.href = '" + addr + "';");
	out.println("</script>");	
%>