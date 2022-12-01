<%@ include file = "_inc_top.jsp" %>
<%@page import="config.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String productCode_ = request.getParameter("productCode");
	
	Util util = new Util();

	util.getNullBlankCheck(productCode_, "");
	util.getCheckString(productCode_);
	
	int productCode = Integer.parseInt(productCode_);
	
	ShopProductDTO arguDto = new ShopProductDTO();
	arguDto.setProductCode(productCode);
	
	ShopProductDAO sakjeDao = new ShopProductDAO();

	ShopProductDTO returnDto = sakjeDao.getSelectOne(arguDto); 
	
	int result = sakjeDao.setDelete(arguDto);
		
	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "삭제성공";
		addr = "main.jsp?menuGubun=shopProduct_list";
		
		String[] imsiArray01 = returnDto.getAttachInfo().split(",");
		for (int i = 0; i<imsiArray01.length; i++) {
			String[] imsiArray02 = imsiArray01[i].split("[|]");
			String uploadFile = uploadPath + "/" + imsiArray02[1];
			java.io.File f = new java.io.File(uploadFile);
			if(f.delete()) {
				
			} else {
				
			}
		}
	} else {
		ment = "삭제실패";
		addr = "main.jsp?menuGubun=shopProduct_sakje&productCode=" + productCode;
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>");
	
%>