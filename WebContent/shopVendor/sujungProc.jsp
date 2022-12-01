<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%@page import="config.Util"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String vName = request.getParameter("vName");
	String vendorCode_ = request.getParameter("vendorCode");
	
	Util util = new Util();
	
	util.getNullBlankCheck(vName, "");
	util.getCheckString(vName);
	
	util.getNullBlankCheck(vendorCode_, "");
	util.getCheckString(vendorCode_);
	
	int vendorCode = Integer.parseInt(vendorCode_);
	
	ShopVendorDTO arguDto = new ShopVendorDTO();
	arguDto.setVendorName(vName);
	arguDto.setVendorCode(vendorCode);
	
	ShopVendorDAO sujungDao = new ShopVendorDAO();
	int result = sujungDao.setUpdate(arguDto);
	

	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "수정성공";
		addr = "main.jsp?menuGubun=shopVendor_list";
	} else {
		ment = "수정실패";
		addr = "main.jsp?menuGubun=shopVendor_sujung&vendorCode=" + vendorCode;
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>");
%>