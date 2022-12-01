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
	
	
	SubBoardDAO subBoardDao = new SubBoardDAO();
	
	int num = subBoardDao.getMaxNumRefNoNoticeNo("num") + 1; //num 필드의 최대값 + 1
	//String tbl = "-";
	
	//새글일때..
	int refNo = subBoardDao.getMaxNumRefNoNoticeNo("refNo") + 1; //refNo 필드의 최대값 + 1
	int stepNo = 1; //1 대입..
	int levelNo = 1; //1 대입..
	int parentNo = 0; //0 대입..
	if (no > 0) { //답변글..
		SubBoardDTO imsiArguDto = new SubBoardDTO();
		imsiArguDto.setNo(no);
		imsiArguDto.setTbl(tbl);
		
		SubBoardDAO imsiSubBoardDao = new SubBoardDAO();
		SubBoardDTO imsiReturnDto = imsiSubBoardDao.getSelectOne(imsiArguDto);
		
		imsiSubBoardDao.setUpdateRelevel(imsiReturnDto);
		
		//부모글의 refNo와 같은 것 중에서..
		//부모글의 levelNo보다 큰 값들은 +1 해라..
		refNo = imsiReturnDto.getRefNo(); //부모글의 refNo
		stepNo = imsiReturnDto.getStepNo() + 1; //부모글의 stepNo + 1
		levelNo = imsiReturnDto.getLevelNo() + 1; //부모글의 levelNo + 1
		parentNo = no;
	}
	
	int hit = 0;
	//String ip = "";
	
	int memberNo = sessionNo;

	int noticeNo = 0;
	if (noticeGubun.equals("T")) {
		noticeNo = subBoardDao.getMaxNumRefNoNoticeNo("noticeNo") + 1; //noticeNo 필드의 최대값 + 1
	}
	
	String attachInfo = "-";
	
	
	
/* 	out.println("writer : " + writer + "<br>");
	out.println("email : " + email + "<br>");
	out.println("passwd : " + passwd + "<br>");
	out.println("subject : " + subject + "<br>");
	out.println("content : " + content + "<br>");
	out.println("noticeGubun : " + noticeGubun + "<br>");
	out.println("secretGubun : " + secretGubun + "<br>");
	out.println("num : " + num + "<br>");
	out.println("tbl : " + tbl + "<br>");
	out.println("refNo : " + refNo + "<br>");
	out.println("stepNo : " + stepNo + "<br>");
	out.println("levelNo : " + levelNo + "<br>");
	out.println("parentNo : " + parentNo + "<br>");
	out.println("hit : " + hit + "<br>");
	out.println("ip : " + ip + "<br>");
	out.println("memberNo : " + memberNo + "<br>");
	out.println("noticeNo : " + noticeNo + "<br>");
	out.println("attachInfo : " + attachInfo + "<br>"); */
	
	SubBoardDTO arguDto = new SubBoardDTO();
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
	
	int result = subBoardDao.setInsert(arguDto);
	
	if (result > 0) {
		out.println("<script>");
		out.println("alert('등록 성공..');");
		//out.println("location.href = 'main.jsp?menuGubun=subBoard_list&searchGubun=" + searchGubun + "&searchData=" + searchData + "';");
		
		if (no > 0) {
			out.println("location.href = 'main.jsp?menuGubun=subBoard_list&pageNumber=" + pageNumber + "&tbl=" + tbl + "';");
		} else {
			out.println("location.href = 'main.jsp?menuGubun=subBoard_list&tbl=" + tbl + "';");
		}

		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록 실패..');");
		out.println("location.href = 'main.jsp?menuGubun=subBoard_chuga&no=" + no + "&tbl=" + tbl + "';");
		out.println("</script>");
	}
%>
