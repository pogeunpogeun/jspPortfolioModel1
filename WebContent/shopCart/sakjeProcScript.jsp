<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String suntaekNo = request.getParameter("suntaekNo");

	if(suntaekNo == null || suntaekNo.trim().equals("")) {
		out.println("<script>");
		out.println("alert('선택한 항목이 없습니다.');");
		out.println("location.href = 'main.jsp?menuGubun=shopCart_list';");
		out.println("</script>");
		return;
	}
	/* String[] imsiArray = suntaekNo.split(",");
	for (int i=0; i<imsiArray.length; i++) {
		int cartNo = Integer.parseInt(imsiArray[i]);
		
		CartDTO arguDto = new CartDTO();
		arguDto.setCartNo(cartNo);
		
		CartDAO dao = new CartDAO();
		int result = dao.setDelete(arguDto);
	} */
	String[] imsiArray = suntaekNo.split(",");
	CartDAO dao = new CartDAO();
	int result = dao.setDeleteBatch(imsiArray); 
	
	out.println("<script>");
	out.println("alert('" + result + "')");
	out.println("location.href = 'main.jsp?menuGubun=shopCart_list';");
	out.println("</script>");
%>