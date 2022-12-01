<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	java.io.File isDir = new java.io.File(uploadPath);
	if(!isDir.exists()) {
		try {
			isDir.mkdirs();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	MultipartRequest multi = new MultipartRequest(
			request,
			uploadPath,
			maxUpload,
			encoding,
			new DefaultFileRenamePolicy()
			);
	
	String productName = multi.getParameter("pName");
	String pPrice = multi.getParameter("pPrice");
	String vendorCode_ = multi.getParameter("vendorCode");
	String attachCounter_ = multi.getParameter("attachCounter");
	
	int productPrice = Integer.parseInt(pPrice);
	int vendorCode = Integer.parseInt(vendorCode_);
	int attachCounter = Integer.parseInt(attachCounter_);
	
	String attachInfo = "";
	
	for(int i=1; i<=attachCounter; i++) {
		String orgName = multi.getOriginalFileName("file" + i);
		String saveName = multi.getFilesystemName("file" + i);
		String fileType = multi.getContentType("file" + i);

		if(orgName == null || saveName == null || fileType == null) {
			orgName = "-";
			saveName = "-";
			fileType = "-";
		}
		attachInfo += ',' + orgName + "|" + saveName + "|" + fileType;
	}
	attachInfo = attachInfo.substring(1);

	ShopProductDTO dto = new ShopProductDTO();
	dto.setProductName(productName);
	dto.setProductPrice(productPrice);
	dto.setVendorCode(vendorCode);
	dto.setAttachInfo(attachInfo);
	
	ShopProductDAO dao = new ShopProductDAO();
	int result = dao.setInsert(dto);
	
	String ment = "";
	String addr = "";
	if(result > 0) {
		ment = "등록성공";
		addr = "main.jsp?menuGubun=shopProduct_list";
	} else {
		ment = "등록실패";
		addr = "main.jsp?menuGubun=shopProduct_attachChuga";
	}
	out.println("<script>");
	out.println("alert('" + ment + "');");
	out.println("location.href='" + addr + "';");
	out.println("</script>");
%>