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
	
	int productPrice = Integer.parseInt(pPrice);
	int vendorCode = Integer.parseInt(vendorCode_);
	
	String attachInfo = "";
	
	String orgName1 = multi.getOriginalFileName("file1");
	String saveName1 = multi.getFilesystemName("file1");
	String fileType1 = multi.getContentType("file1");
	
	if(orgName1 == null || saveName1 == null || fileType1 == null) {
		orgName1 = "-";
		saveName1 = "-";
		fileType1 = "-";
	}
	
	attachInfo += ',' + orgName1 + "|" + saveName1 + "|" + fileType1;
	
	String orgName2 = multi.getOriginalFileName("file2");
	String saveName2 = multi.getFilesystemName("file2");
	String fileType2 = multi.getContentType("file2");
	
	if(orgName2 == null || saveName2 == null || fileType2 == null) {
		orgName2 = "-";
		saveName2 = "-";
		fileType2 = "-";
	}
	
	attachInfo += ',' + orgName2 + "|" + saveName2 + "|" + fileType2;
	
	String orgName3 = multi.getOriginalFileName("file3");
	String saveName3 = multi.getFilesystemName("file3");
	String fileType3 = multi.getContentType("file3");
	
	if(orgName3 == null || saveName3 == null || fileType3 == null) {
		orgName3 = "-";
		saveName3 = "-";
		fileType3 = "-";
	}
	
	attachInfo += ',' + orgName3 + "|" + saveName3 + "|" + fileType3;
	
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