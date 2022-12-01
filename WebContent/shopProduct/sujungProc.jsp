<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "_inc_top.jsp" %>

<%
	java.io.File isDir = new java.io.File(uploadPath);
	if (!isDir.exists()) {
		try {
			isDir.mkdirs();
			//System.out.println("디렉토리가 존재하지 않습니다. 디렉토리를 생성합니다.");
		} catch(Exception e) {
			//e.printStackTrace();
		}
	}
	
	// MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
	MultipartRequest multi = new MultipartRequest(
		request,
		uploadPath, //파일저장경로
		maxUpload,  //용량
		encoding,   //인코딩타입
		new DefaultFileRenamePolicy() //중복파일처리(동일파일명 업로드시 뒤에 숫자 붙여서 중복회피..)
	);
	
	String productCode_ = multi.getParameter("productCode");
	String productName = multi.getParameter("productName");
	String productPrice_ = multi.getParameter("productPrice");
	String attachCounter_ = multi.getParameter("attachCounter");
	
	int productCode = Integer.parseInt(productCode_);
	int productPrice = Integer.parseInt(productPrice_);
	int attachCounter = Integer.parseInt(attachCounter_);
	
	
	ShopProductDTO arguDto = new ShopProductDTO();
	arguDto.setProductCode(productCode);
	
	ShopProductDAO shopProductDao = new ShopProductDAO();
	ShopProductDTO returnDto = shopProductDao.getSelectOne(arguDto);
	String[] dbArray01 = returnDto.getAttachInfo().split(",");
	
	
	String[] array = new String[attachCounter];
	
	Enumeration files = multi.getFileNames(); //첨부파일의 집합
	while (files.hasMoreElements()) { //다음 요소가 있으면..
		String originalName = "-";
		String saveName = "-";
		long fileSize = 0;
		String fileType = "-";
		String mimeType = "-"; //Tika
		
		String tagName = (String) files.nextElement();
		java.io.File f1 = multi.getFile(tagName);
		
		String imsiTagName = tagName.replace("file", "");
		int intTagName = Integer.parseInt(imsiTagName);
		
		String[] dbArray02 = dbArray01[intTagName - 1].split("[|]");
		
		if (f1 == null) {		
			originalName = dbArray02[0];
			saveName = dbArray02[1];
			fileSize = Integer.parseInt(dbArray02[2]);
			fileType = dbArray02[3];
			mimeType = dbArray02[4];
		} else {
			originalName = multi.getOriginalFileName(tagName);
			saveName = multi.getFilesystemName(tagName);
			fileSize = f1.length();
			fileType = multi.getContentType(tagName);
			Tika tika = new Tika();
			mimeType = tika.detect(f1);
			
			if (fileType.equals(mimeType)) { //첨부파일 정상..
				//String[] imsiArray = saveName.split(".");
			    //String ext = imsiArray[imsiArray.length - 1];
				
				String ext = saveName.substring(saveName.lastIndexOf(".") + 1);
				String newFileName = UUID.randomUUID().toString() + "." + ext; //saveName -> newFileName
				
				java.io.File newFile = new java.io.File(uploadPath + "/" + newFileName);
				f1.renameTo(newFile);
				
				saveName = newFileName;
				
				java.io.File f2 = new java.io.File(uploadPath + "/" + dbArray02[1]);
				if (f2.exists()) {
					f2.delete();
				}
			} else { //첨부파일 비정상..
				java.io.File f2 = new java.io.File(uploadPath + "/" + saveName);
				if (f2.exists()) {
					f2.delete();
				}
				
				originalName = "-";
				saveName = "-";
				fileSize = 0;
				fileType = "-";
				mimeType = "-";
			}
		}
		
		String imsiOneFileInfo = "";
		imsiOneFileInfo += originalName + "|";
		imsiOneFileInfo += saveName + "|";
		imsiOneFileInfo += fileSize + "|";
		imsiOneFileInfo += fileType + "|";
		imsiOneFileInfo += mimeType;
		
		//String imsiTagName = tagName.replace("file", "");
		//int intTagName = Integer.parseInt(imsiTagName);
		array[intTagName - 1] = imsiOneFileInfo;
	}
	
	
	String attachInfo = "";
	for (int i=0; i<array.length; i++) {
		if (!attachInfo.equals("")) {
			attachInfo += ",";
		}
		attachInfo += array[i];
	}
	
	
	ShopProductDTO dto = new ShopProductDTO();
	dto.setProductCode(productCode);
	dto.setProductName(productName);
	dto.setProductPrice(productPrice);
	dto.setAttachInfo(attachInfo);
	
	ShopProductDAO dao = new ShopProductDAO();
	int result = dao.setUpdate(dto);
	
	if (result > 0) {
		out.println("<script>");
		//out.println("alert('수정 성공..');");
		out.println("location.href = 'main.jsp?menuGubun=shopProduct_view&productCode=" + productCode + "';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('수정 중 오류가 발생했습니다.');");
		out.println("location.href = 'main.jsp?menuGubun=shopProduct_sujung&productCode=" + productCode + "';");
		out.println("</script>");
	}
%>