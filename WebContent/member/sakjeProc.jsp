<%@ include file = "_inc_top.jsp" %>
<%@page import="member.model.dao.DAO"%>
<%@page import="member.model.dto.DTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
	
	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);
	String passwd = request.getParameter("passwd");
	//String attachInfo = request.getParameter("attachInfo");
	

	DTO arguDto = new DTO();
	arguDto.setNo(no);
	arguDto.setPasswd(passwd);

	DAO dao = new DAO();
	
	DTO imsiDto = new DTO();
	imsiDto.setNo(no);
	DTO resultDto = dao.getSelectOne(imsiDto);
	String attachInfo = resultDto.getAttachInfo();
	
	int result = dao.setDelete(arguDto);
	
	String imsiMsg = "삭제 중 오류가 발생했습니다.";
	String imsiUrl = "main.jsp?menuGubun-member_sakje&no=" + no;
	if (result > 0) {
		imsiMsg = "삭제 성공";
		imsiUrl = "main.jsp?menuGubun=member_list";
		
		// 파일삭제처리	
		String attachPath = "C:/HHJ/attach";
		String uploadPath = attachPath + request.getContextPath() + "/member";
		
		String[] imsiArray01 = attachInfo.split(",");
		for(int i=0; i<imsiArray01.length; i++) {			
	String[] imsiArray02 = imsiArray01[i].split("[|]");
	String savedName = imsiArray02[1];
	String uploadFile = uploadPath + "/" + savedName;
	java.io.File f = new java.io.File(uploadFile);
	if(f.delete()) {
		// 파일 삭제 성공
	} else {
		// 파일 삭제 실패
	}
		}		
	} 
	out.println("<script>");
	
	if (result <= 0) {
		out.println("alert('" + imsiMsg + "');");
	}
	out.println("location.href='" + imsiUrl + "';");
	out.println("</script>");
/* 	
	
	
	
	if(result > 0) {
		String imsiUrl = "main.jsp?menuGubun=member_list";
		out.println("<script>");
		//out.println();
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} else {
		String imsiUrl = "main.jsp?menuGubun=member_sakje&no=" + no;
		out.println("<script>");
		out.println("alert('삭제 중 오류가 발생했습니다.');");
		out.println("location.href='" + imsiUrl + "';");
		out.println("</script>");
	} */
%>