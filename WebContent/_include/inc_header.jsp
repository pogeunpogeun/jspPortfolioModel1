<%@page import="java.net.Inet4Address"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("UTF-8");
	
	String referer = request.getHeader("REFERER");
	String url = request.getRequestURL().toString();
	String uri = request.getRequestURI().toString();
	String path = request.getContextPath();
	String ip = Inet4Address.getLocalHost().getHostAddress();
	
	/* out.println("referer : " + referer + "<br>");
	out.println("url : " + url + "<br>");
	out.println("uri : " + uri + "<br>");
	out.println("ip : " + ip + "<br>");
	 */
	

	String menuGubun = request.getParameter("menuGubun");
		
	if(menuGubun == null || menuGubun.equals("")) {
		menuGubun = "member_list";
/* 		out.println("<script>");
		out.println("location.href='../error.jsp?errorCode=001';");
		out.println("</script>");
		return; */
	}
	
	String[] imsiMenuGubunArray = menuGubun.split("_");
	String folderName = imsiMenuGubunArray[0];
	String fileName = imsiMenuGubunArray[1];
	String includePage = "../" + folderName + "/" + fileName + ".jsp";	
	
	String imgDisplayPath = "";
	imgDisplayPath += request.getContextPath();
	imgDisplayPath += "/attach";
	imgDisplayPath += request.getContextPath();
	 
%>