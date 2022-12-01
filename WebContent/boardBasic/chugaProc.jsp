<%@include file = "_inc_top.jsp" %>
<%@page import="config.Util"%>
<%@page import="boardBasic.model.dao.BoardBasicDAO"%>
<%@page import="boardBasic.model.dto.BoardBasicDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

		request.setCharacterEncoding("utf-8");
		
		Util util = new Util();
		
		String no_ = request.getParameter("no");
		no_ = util.getNullBlankCheck(no_, "0");
		int no = Integer.parseInt(no_);
		
		String writer = request.getParameter("writer");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String email = request.getParameter("email");
		String passwd = request.getParameter("passwd");
		

		BoardBasicDAO dao = new BoardBasicDAO();
	
		int num = dao.getMaxNum() + 1 ; 
		
	
		int refNo = dao.getMaxRefNo() + 1;
		int stepNo = 1;
		int levelNo = 1;
		int parentNo = 0;

		if (no > 0) { // 답변글
			BoardBasicDTO imsiArguDto = new BoardBasicDTO();
			imsiArguDto.setNo(no);
			
			BoardBasicDAO imsiDao = new BoardBasicDAO();
			BoardBasicDTO imsiReturnDto = imsiDao.getSelectOne(imsiArguDto);
			
			imsiDao.setUpdateRelevel(imsiReturnDto);
			
			refNo = imsiReturnDto.getRefNo();
			stepNo = imsiReturnDto.getStepNo() + 1;
			levelNo = imsiReturnDto.getLevelNo() + 1;
			parentNo = no;
		}
		
		
		int hit = 0;
		int memberNo = sessionNo;
		//String ip = "";

		BoardBasicDTO arguDto = new BoardBasicDTO();
		arguDto.setWriter(writer);
		arguDto.setSubject(subject);
		arguDto.setContent(content);
		arguDto.setEmail(email);
		arguDto.setPasswd(passwd);
		arguDto.setNum(num);
		arguDto.setRefNo(refNo);
		arguDto.setStepNo(stepNo);
		arguDto.setLevelNo(levelNo);
		arguDto.setHit(hit);
		arguDto.setMemberNo(memberNo);
		arguDto.setIp(ip);
		arguDto.setParentNo(parentNo);
		//BoardBasicDAO dao = new BoardBasicDAO();
		int result = dao.setInsert(arguDto);
		 
		
		
		if (result > 0) {
			out.println("<script>location.href='main.jsp?menuGubun=boardBasic_list';</script>");
		} else {
			out.println("<script>alert('등록 중 오류가 발생했습니다.'); location.href='main.jsp?menuGubun=boardBasic_chuga';</script>");
		}
%>