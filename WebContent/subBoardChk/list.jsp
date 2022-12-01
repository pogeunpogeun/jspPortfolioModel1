<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%
	SubBoardChkDAO dao = new SubBoardChkDAO();
	ArrayList<SubBoardChkDTO> list = dao.getSelectAll();
%>
<h2>게시판관리 목록</h2>
<fieldset style="border: 0px solid blue; margin : 10px 0px 20px 0px; width:80%;">
<form name="chugaForm">
<table border="0" align="left">
	<tr>
		<td>
			<input type="hidden" name = "procGubun" id="procGubun" value="chugaProc"><br>
			<input type="hidden" name = "boardChkNo" id="boardChkNo"><br>

			tbl : <input type="text" name="tbl" id="tbl"><br>
			tblName : <input type="text" name="tblName" id="tblName">

			<button type="button" onClick="save();" id="btnSave">확인</button>
			<button type="button" onClick="reset();" id="btnReset">초기화</button>
		</td>
	</tr>
</table>
</form>
<script>
	function save() {
		if(confirm('처리할까요?')) {
			document.chugaForm.action = "mainProc.jsp?menuGubun=subBoardChk_listProc";
			document.chugaForm.method = "post";
			document.chugaForm.submit();
		}
	}
	function reset() {
		document.chugaForm.procGubun.value = 'chugaProc';
		document.chugaForm.boardChkNo.value = '';
		document.chugaForm.tbl.value = '';
		document.chugaForm.tblName.value = '';
		document.getElementById('btnSave').innerText = '등록하기';	
	}
</script>
</fieldset>
<table border="1" width="80%">
	<tr>
		<td>No</td>
		<td>tbl</td>
		<td>tblName</td>
		<td>regiDate</td>
		<td>&nbsp;</td>
	</tr>
	<%
		for (int i = 0; i < list.size(); i++) {
			SubBoardChkDTO dto = list.get(i);
	%>
		<tr>
			<td><%=dto.getBoardChkNo() %></td>
			<td>
				<%=dto.getTbl() %>
				<input type = "hidden" name = "boardChkNo" value = "<%=dto.getBoardChkNo() %>">
				<input type = "hidden" name = "tbl" value = "<%=dto.getTbl() %>">
				<input type = "hidden" name = "tblName" value = "<%=dto.getTblName() %>">
			</td>
			<td><%=dto.getTblName() %></td>
			<td><%=dto.getRegiDate() %></td>
			<td>
			<a href="#" onClick="suntaek('sujungProc','<%=dto.getBoardChkNo() %>','<%=dto.getTbl() %>','<%=dto.getTblName() %>');">수정</a>
			/
			<a href="#" onClick="suntaek('sakjeProc','<%=dto.getBoardChkNo() %>','<%=dto.getTbl() %>','<%=dto.getTblName() %>');">삭제</a>
			</td>
		</tr>
	<%
		}
	%>
</table>
<script>
	function suntaek(value1, value2, value3, value4) {
		document.chugaForm.procGubun.value = value1;
		document.chugaForm.boardChkNo.value = value2;
		document.chugaForm.tbl.value = value3;
		document.chugaForm.tblName.value = value4;

		if(value1 == 'sujungProc') {
			var imsiValue = "수정하기";
		} else if (value1 == 'sakjeProc') {
			var imsiValue = "삭제하기";
		} else {
			var imsiValue = "등록하기";
		}	
		document.getElementById('btnSave').innerText = imsiValue;
	}
</script>