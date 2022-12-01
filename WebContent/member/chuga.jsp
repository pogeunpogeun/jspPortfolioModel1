<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>

<h2>회원등록</h2>
<form name="chugaForm">
<table border="1" align="center">
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>비밀번호확인</td>
		<td><input type="password" name="pwChk"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>연락처</td>
		<td><input type="text" name="phone"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>주민등록번호</td>
		<td><input type="text" name="jumin1"> - <input type="password" name="jumin2"></td>
	</tr>
	<tr>
		<td rowspan="3">주소</td>
		<td>
			<input type="text" name="juso1" id="sample6_postcode" placeholder="우편번호">
			<button type="button" onClick="sample6_execDaumPostcode();">우편번호 찾기</button>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="juso2" id="sample6_address" placeholder="주소">
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="juso3" id="sample6_detailAddress" placeholder="상세주소">
			<input type="text" name="juso4" id="sample6_extraAddress" placeholder="참고항목">
		</td>
	</tr>
	<tr>
		<td>회원등급</td>
		<td>
			<input type="radio" name="grade" value="최우수회원">최우수회원&nbsp;
			<input type="radio" name="grade" value="우수회원">우수회원&nbsp;
			<input type="radio" name="grade" value="일반회원">일반회원&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<button type="button" onClick="join();">가입하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=member_list';">목록으로</button>
	</tr>
	
</table>
</form>
<script>
	function join() {
		if(confirm('등록하시겠습니까?')) {
			document.chugaForm.action="mainProc.jsp?menuGubun=member_chugaProc";
			document.chugaForm.method="post";
			document.chugaForm.submit();
		}
	}
</script>
<%@ include file = "_inc_daumAPI.jsp" %>