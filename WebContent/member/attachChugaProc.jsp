<%@ include file = "_inc_top.jsp" %>
<%@page import="member.model.dto.DTO"%>
<%@page import="member.model.dao.DAO"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.Enumeration"%>
<%
request.setCharacterEncoding("UTF-8");

	String attachPath = "C:/HHJ/attach";
	String uploadPath = attachPath + request.getContextPath() + "/member";
	int maxUpload = 1024 * 1024 * 100;
	String encoding = "UTF-8";
	
	// MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
	MultipartRequest multi = new MultipartRequest(
	request,
	uploadPath, // 파일저장경로
	maxUpload, // 최대용량
	encoding, // 인코딩타입
	new DefaultFileRenamePolicy() // 중복파일처리(동일파일명 업로드시 뒤에 숫자 붙여서 중복회피)			
		);	
	
	String id = multi.getParameter("id");
	String passwd = multi.getParameter("passwd");
	String pwChk = multi.getParameter("pwChk");
	String name = multi.getParameter("name");
	String phone = multi.getParameter("phone");
	String email = multi.getParameter("email");
	String jumin1 = multi.getParameter("jumin1");
	String jumin2 = multi.getParameter("jumin2");
	String juso1 = multi.getParameter("juso1");
	String juso2 = multi.getParameter("juso2");
	String juso3 = multi.getParameter("juso3");
	String juso4 = multi.getParameter("juso4");
	String grade = multi.getParameter("grade");
	
	String jumin = jumin1 + " - " + jumin2;
	
	if(juso4 == null || juso4.trim().equals("")) {
		juso4 = "-";
	}

	String attachInfo = "";
	try {
		Enumeration<String> files = multi.getFileNames();
		while(files.hasMoreElements()) {
	String tagName = "";
	String fileOriginalName = "";
	String fileSavedName = "";
	String fileType = "";
	String fileSize = "";
	String fileExtName = ""; // 확장자
	String newFileName = "";
	
	// form 태그에서 <input type="file" name="여기에 지정한 이름"/>을 가져온다.
	tagName = (String)files.nextElement();
	//out.println("tagName : " + tagName + "<br>");			
	// input file name에 해당하는 실제 파일을 가져옴
	File fileObj = multi.getFile(tagName);
	// out.println("fileObj : " + fileObj + "<br>");
	
	int errorImgCounter = 0;
	String imsiResult = "";
	if(fileObj != null) { // 해당 tagName에 파일을 첨부했을경우
		fileOriginalName = multi.getOriginalFileName(tagName);
		fileSavedName = multi.getFilesystemName(tagName);
		fileType = multi.getContentType(tagName);
		fileSize = String.valueOf(fileObj.length());
		fileExtName = fileSavedName.substring(fileSavedName.lastIndexOf(".") + 1);
		
		if(fileExtName.toLowerCase().equals("png")) {
	
		} else if(fileExtName.toLowerCase().equals("jpg")) {
	
		} else if(fileExtName.toLowerCase().equals("jpeg")) {
	
		} else if(fileExtName.toLowerCase().equals("gif")) {
	
		} else {
	errorImgCounter++;
		}
		
		if(errorImgCounter > 0) {
	String deleteFilePath = uploadPath + "/" + fileSavedName;
	java.io.File f = new java.io.File(deleteFilePath);
	if(f.delete()) {
		// 파일 삭제 성공
	} else {
		// 파일 삭제 실패
	}
	// 경로 초기화
	fileOriginalName = "";
	fileSavedName = "";
	fileType = "";
	fileSize = "";
		}					
		newFileName = UUID.randomUUID().toString() + "." + fileExtName; // 새로 생성할 파일이름
		String oldFilePath = uploadPath + "/" + fileSavedName; // 기존에 저장된 파일
		String newFilePath = uploadPath + "/" + newFileName; // 기존에 저장된 파일을 여기 이름으로 변경 후 저장. (oldFile to newFile)
		File f1 = new File(oldFilePath);
		if(f1.exists()) {
	File newFile = new File(newFilePath);
	f1.renameTo(newFile);
	fileSavedName = newFileName;				
		}
		
		if(!attachInfo.trim().equals("")) {
	attachInfo += ",";
		}
		attachInfo += fileOriginalName + "|"; // 파일 원래 이름
		attachInfo += fileSavedName + "|"; // 파일이 서버에 올라가 있는 이름
		attachInfo += fileType + "|"; // 파일의 타입
		attachInfo += fileSize; // 파일 용량
	}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	DTO arguDto = new DTO();
	arguDto.setId(id);
	arguDto.setPasswd(passwd);
	arguDto.setName(name);
	arguDto.setPhone(phone);
	arguDto.setEmail(email);
	arguDto.setJumin(jumin);
	arguDto.setJuso1(juso1);
	arguDto.setJuso2(juso2);
	arguDto.setJuso3(juso3);
	arguDto.setJuso4(juso4);
	arguDto.setGrade(grade);
	arguDto.setAttachInfo(attachInfo);

	DAO dao = new DAO();
	int result = dao.setInsert(arguDto);
	
	if(result > 0) {
		out.println("<script>");
		//out.println();
		out.println("location.href='main.jsp?menuGubun=member_list';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록 중 오류가 발생했습니다.');");
		out.println("location.href='main.jsp?menuGubun=member_chuga';");
		out.println("</script>");
	}
%>