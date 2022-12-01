<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//response.sendRedirect("./main/main.jsp?menuGubun=member_list");
%>
	<script>
	function move() {
		location.href = './main/main.jsp?menuGubun=dashBoard_list';
	}
	move();
	</script>