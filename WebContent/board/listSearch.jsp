<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	String searchGubun = request.getParameter("searchGubun");
	String searchData = request.getParameter("searchData");
	
	if(searchGubun == null || searchGubun.trim().equals("")) { searchGubun = ""; }
	if(searchData == null || searchData.trim().equals("")) { searchData = ""; }
	if(searchGubun.equals("") || searchData.trim().equals("")) { searchGubun = ""; searchData = ""; }
%>
<script>
	function linkMove(value1, value2) {
		location.href = 'main.jsp?menuGubun=board_list&searchGubun=' + value1 + '&searchData=' + value2;
	}
	linkMove('<%=searchGubun %>','<%=searchData %>');
</script>