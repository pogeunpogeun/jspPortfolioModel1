<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>메모추가</h2>
<form name="chugaForm">
<table border="1" width="80%">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="writer"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="width:500px; height:200px"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;">
		<button type="button" onClick="chuga();">추가하기</button>
		<button type="button" onClick="location.href='main.jsp?menuGubun=memo_list';">목록으로</button>
	</tr>
</table>
</form>
<script>
	function chuga() {
		if(confirm('추가하시겠습니까?')) {
			document.chugaForm.action="mainProc.jsp?menuGubun=memo_chugaProc";
			document.chugaForm.method="post";
			document.chugaForm.submit();
		}
	}
</script>

<!-- &alt;script&gt;
alert(&apos;hahaha&apos;);
location.href=&apos;https://naver.com&apos;;
&lt;/script&gt;

html entity
	&nbsp;
<	&lt;
>	&gt;
&	&amp;
"	&quot;
'	&apos;

Util util = new Util();

String writer = request.getParameter("writer");
writer = util.getCheckString(writer);
writer = writer.getNullBlankCheck(writer,"");

String content = request.getParameter("content");
content = util.getCheckString(content); -->