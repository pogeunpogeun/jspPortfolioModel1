<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_sessionChk.jsp" %>
<div style="border: 0px solid blue; width: 60%;">
	<font style="font-size: 80px; color: #6699CC; font-weight: bold;">Here We Go
	</font>
	
	<% if(sessionNo == 0) { %>
	<div style="padding: 20px 0px">
		<form name="loginForm">
			아이디 <input type="text" name="id" style="width: 80px;"> &nbsp;
			비밀번호 <input type="password" name="passwd" style="width: 80px;">
			&nbsp;
			<button type="button" onClick="login();">로그인</button>
		</form>
	</div>

	<script>
		function login() {
			if (confirm('로그인할까요?')) {
				document.loginForm.action = 'mainProc.jsp?menuGubun=noLogin_loginProc';
				document.loginForm.method = 'post';
				document.loginForm.submit();
			}
		}
	</script>
	<% } %>
</div>