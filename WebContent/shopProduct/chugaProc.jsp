<%@ include file = "_inc_top.jsp" %>
<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pName = request.getParameter("pName");
	String pPrice_ = request.getParameter("pPrice");
	String vendorCode_ = request.getParameter("vendorCode");

	
	Util util = new Util();
	
	util.getCheckString(pName);
	util.getNullBlankCheck(pName, "");
	
	util.getCheckString(pPrice_);
	util.getNullBlankCheck(pPrice_, "");
	
	util.getCheckString(vendorCode_);
	util.getNullBlankCheck(vendorCode_, "");

	int pPrice = Integer.parseInt(pPrice_);
	int vendorCode = Integer.parseInt(vendorCode_);
	
	String attachInfo = "-|-|0|-|-";
	
	ShopProductDTO arguDto = new ShopProductDTO();
	arguDto.setProductName(pName);
	arguDto.setProductPrice(pPrice);
	arguDto.setVendorCode(vendorCode);
	arguDto.setAttachInfo(attachInfo);

	ShopProductDAO chugaDao = new ShopProductDAO();
	int result = chugaDao.setInsert(arguDto);
	
	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "등록성공";
		addr = "main.jsp?menuGubun=shopProduct_list";
	} else {
		ment = "등록실패";
		addr = "main.jsp?menuGubun=shopProduct_chuga";
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>");
%>