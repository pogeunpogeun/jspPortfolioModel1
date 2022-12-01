<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "../_include/inc_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<table border="1" width="80%" align="center">
	<tr>
		<td height="100px;" align="center">
			<jsp:include page="../_include/inc_menu.jsp" flush="true"></jsp:include>
		</td>
	</tr>
	<tr>
		<td align="center" style="padding: 30px 0px 30px 0px;">
 			<jsp:include page="<%=includePage %>" flush="true"></jsp:include>
		</td>
	</tr>
	<tr>
		<td height="100px;" align="center">
			<jsp:include page="../_include/inc_copyright.jsp" flush="true"></jsp:include>
		</td>
	</tr>
</table>

</body>
</html>