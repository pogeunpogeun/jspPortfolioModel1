<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "../_include/inc_header.jsp" %>
<%@ include file = "../_include/inc_sessionChk.jsp" %>

<button type="button" onClick="suntaek('examPiechart');">examPiechart</button>
&nbsp;&nbsp;
<button type="button" onClick="suntaek('examPiechart3d');">examPiechart3d</button>
&nbsp;&nbsp;
<button type="button" onClick="suntaek('examLinechart');">examLinechart</button>
&nbsp;&nbsp;
<button type="button" onClick="suntaek('examCombochart');">examCombochart</button>
&nbsp;&nbsp;
<button type="button" onClick="suntaek('dbChart');">dbChart</button>

<script>
function suntaek(value1) {
	location.href = 'main.jsp?menuGubun=chart_' + value1;
}
</script>

<hr style="width: 70%; margin: 20px 0px;">