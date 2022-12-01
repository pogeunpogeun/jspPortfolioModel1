<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	String passwd = request.getParameter("passwd");

	SubBoardDTO arguDto = new SubBoardDTO();
	arguDto.setNo(no);
	arguDto.setTbl(tbl);
	arguDto.setPasswd(passwd);

	SubBoardDAO subBoardDao = new SubBoardDAO();

	SubBoardDTO returnDto = subBoardDao.getSelectOne(arguDto);
	if (!returnDto.getPasswd().equals(passwd)) {
		String imsiUrl = "";
		imsiUrl += "main.jsp?menuGubun=subBoard_sakje";
		imsiUrl += "&pageNumber=" + pageNumber;
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

	int result = subBoardDao.setDelete(arguDto);
	
	if (result > 0) {
		out.println("<script>");
		out.println("alert('삭제 성공..');");
		out.println("location.href = 'main.jsp?menuGubun=subBoard_list&tbl=" + tbl + "&searchGubun=" + searchGubun + "&searchData=" + searchData + "';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('삭제 실패..');");
		out.println("location.href = 'main.jsp?menuGubun=subBoard_sakje&no=" + no + "&tbl=" + tbl + "&searchGubun=" + searchGubun + "&searchData=" + searchData + "';");
		out.println("</script>");
	}
%>
