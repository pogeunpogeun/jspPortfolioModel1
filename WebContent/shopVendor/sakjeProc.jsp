<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%@page import="config.Util"%>
<%
	request.setCharacterEncoding("UTF-8");

	String vendorCode_ = request.getParameter("vendorCode");
	System.out.println("1 : ->" + vendorCode_);
	
	Util util = new Util();
	
	util.getNullBlankCheck(vendorCode_, "");
	util.getCheckString(vendorCode_);
	
	System.out.println("2 : ->" + vendorCode_);
	
	int vendorCode = Integer.parseInt(vendorCode_);
	System.out.println("3 : ->" + vendorCode_);
	ShopVendorDTO arguDto = new ShopVendorDTO();
	arguDto.setVendorCode(vendorCode);
	
	ShopVendorDAO sakjeDao = new ShopVendorDAO();
	int result = sakjeDao.setDelete(arguDto);
	

	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "삭제성공";
		addr = "main.jsp?menuGubun=shopVendor_list";
	} else {
		ment = "삭제실패";
		addr = "main.jsp?menuGubun=shopVendor_sakje";
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>");
%>