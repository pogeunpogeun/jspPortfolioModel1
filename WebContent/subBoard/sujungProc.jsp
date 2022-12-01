<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String dbNoticeNo_ = request.getParameter("dbNoticeNo");
	int dbNoticeNo = Integer.parseInt(dbNoticeNo_);
	
	String email = request.getParameter("email");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String noticeGubun = request.getParameter("noticeGubun");
	String secretGubun = request.getParameter("secretGubun");
	
	int memberNo = sessionNo;
	String attachInfo = "-";
	
	
	SubBoardDAO subBoardDao = new SubBoardDAO();

	int noticeNo = 0;
	if (noticeGubun.equals("T")) {
		if (dbNoticeNo > 0) { //기존 글이 공지글이냐..
			noticeNo = dbNoticeNo;
		} else { //기존 글이 공지글 아니냐..
			noticeNo = subBoardDao.getMaxNumRefNoNoticeNo("noticeNo") + 1;
		}
	}

	SubBoardDTO arguDto = new SubBoardDTO();
	arguDto.setNo(no);
	arguDto.setTbl(tbl);
	arguDto.setSubject(subject);
	arguDto.setContent(content);
	arguDto.setEmail(email);
	arguDto.setPasswd(passwd);
	arguDto.setMemberNo(memberNo);
	arguDto.setNoticeNo(noticeNo);
	arguDto.setSecretGubun(secretGubun);
	arguDto.setAttachInfo(attachInfo);

	SubBoardDTO returnDto = subBoardDao.getSelectOne(arguDto);
	if (!returnDto.getPasswd().equals(passwd)) {
		String imsiUrl = "";
		imsiUrl += "main.jsp?menuGubun=subBoard_sujung";
		imsiUrl += "&no=" + no;
		imsiUrl += "&tbl=" + tbl;
		imsiUrl += "&searchGubun=" + searchGubun;
		imsiUrl += "&searchData=" + searchData;

		out.println("<script>");
		out.println("alert('입력한 비밀번호가 다릅니다.\\n확인 후 다시 이용하세요.');");
		out.println("location.href = '" + imsiUrl + "';");
		out.println("</script>");
		return;
	}

	int result = subBoardDao.setUpdate(arguDto);
	
	if (result > 0) {
		out.println("<script>");
		out.println("alert('수정 성공..');");
		out.println("location.href = 'main.jsp?menuGubun=subBoard_view&pageNumber=" + pageNumber + "&no=" + no + "&tbl=" + tbl + "&searchGubun=" + searchGubun + "&searchData=" + searchData + "';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('수정 실패..');");
		out.println("location.href = 'main.jsp?menuGubun=subBoard_sujung&pageNumber=" + pageNumber + "&no=" + no + "&tbl=" + tbl + "&searchGubun=" + searchGubun + "&searchData=" + searchData + "';");
		out.println("</script>");
	}
%>
