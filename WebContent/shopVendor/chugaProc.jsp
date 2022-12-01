<%@ include file = "_inc_top.jsp" %>
<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String vName = request.getParameter("vName");
	
	Util util = new Util();
	
	util.getNullBlankCheck(vName, "");
	util.getCheckString(vName);
	
	ShopVendorDTO arguDto = new ShopVendorDTO();
	arguDto.setVendorName(vName);
	
	ShopVendorDAO chugaDao = new ShopVendorDAO();
	int result = chugaDao.setInsert(arguDto);
	

	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "등록성공";
		addr = "main.jsp?menuGubun=shopVendor_list";
	} else {
		ment = "등록실패";
		addr = "main.jsp?menuGubun=shopVendor_chuga";
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>");
	
%>