<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "_inc_top.jsp" %>
<%@ include file = "_inc_script.jsp" %>
<%
	String pageNumber_ = request.getParameter("pageNumber");
	if(pageNumber_ == null || pageNumber_.trim().equals("")) {
		pageNumber_ = "1";
	}
	int pageNumber = Integer.parseInt(pageNumber_);

	
	String searchValue = "O";
	String searchGubun = request.getParameter("searchGubun");
	String searchData = request.getParameter("searchData");
	
	if(searchGubun == null || searchGubun.trim().equals("")) {
		searchGubun = "";
	}
	if(searchData == null || searchData.trim().equals("")) {
		searchData = "";
	}
	if(searchGubun.equals("") || searchData.equals("")) {
		searchValue = "X";
		searchGubun = "";
		searchData = "";
	} 

	BoardDAO dao = new BoardDAO();
	
	// 페이징을 위한 변수
	int totalRecord = dao.getTotalRecord(searchGubun, searchData);
	int pageSize = 10; // 한 페이지에 나타낼 레코드 갯수
	int blockSize = 10; // 하단 페이지 그리드 개수
	
	int block = (pageNumber -1) / pageSize;
	int jj = totalRecord - pageSize * (pageNumber -1); // 단순 화면에 보일 일련번호
	
	double totalPageDou = Math.ceil(totalRecord / (double)pageSize);
	int totalPage = (int)totalPageDou;
	
	int startRecord = pageSize * (pageNumber -1) + 1;
	int lastRecord = pageSize * pageNumber;
	
	ArrayList<BoardDTO> list = dao.getSelectAll(searchGubun, searchData, startRecord, lastRecord);
%>
<h2>게시글 목록</h2>
<div style="border:0px solid red; padding:5px 0px 5px 0px; width:55%;" align="left">
<% if(searchValue.equals("O")) { %>
	* 검색어 '<%=searchData %>'(으)로 검색된 목록 : <%=totalRecord %>건
<% } else { %>
	*  전체 목록 : <%=totalRecord %>건
<% } %>
(<%=pageNumber %> / <%=totalPage %>)
</div>
<table border="1" width="50%">
	<tr>
		<th>no</th>
		<th>writer</th>
		<th>subject</th>
		<th>refNo</th>
		<th>stepNo</th>
		<th>levelNo</th>
		<th>parentNo</th>
		<th>hit</th>
		<th>IP</th>
		<th>memberNo</th>
		<th>noticeNo</th>
		<th>secretGubun</th>
		<th>regiDate</th>
	</tr>
	<%
		for(int i=0; i<list.size(); i++) {
			BoardDTO listDto = list.get(i);
	%>
	<tr>
		<td>
		<% if(listDto.getNoticeNo() > 0) { 
			out.print("공지");
			} else {
				out.println(jj);
			}
		%>
		</td>
		<td><%=listDto.getWriter() %></td>
		<td>
			<% 
				String blankValue = "";
				for(int k=2; k<=listDto.getStepNo(); k++) {
					blankValue += "&nbsp;&nbsp;";
				}
				String tempSubject = listDto.getSubject();
				if(tempSubject.length() > 10) {
					tempSubject = tempSubject.substring(0,10) + "...";
				}
				if(listDto.getStepNo() > 1) {
					tempSubject = "[Re]:" + tempSubject;
				}			
				tempSubject = blankValue +  tempSubject;
				/* String msg = "";
				msg += "<a href=\"#\" onClick=\"move('board_view','" + listDto.getNo() + "');\">" + tempSubject + "</a>";
				out.println(msg); */
			%>
			
			<%=blankValue %><a href="#" onClick="move('board_view','<%=listDto.getNo()%>','<%=searchGubun%>','<%=searchData%>');"><%=tempSubject %></a>
		</td>
		<td><%=listDto.getRefNo() %></td>
		<td><%=listDto.getStepNo() %></td>
		<td><%=listDto.getLevelNo() %></td>
		<td><%=listDto.getParentNo() %></td>
		<td><%=listDto.getHit() %></td>
		<td><%=listDto.getIp() %></td>
		<td><%=listDto.getMemberNo() %></td>
		<td><%=listDto.getNoticeNo() %></td>
		<td><%=listDto.getSecretGubun() %></td>
		<td><%=listDto.getRegiDate() %></td>
	</tr>
	<% 
			jj--;
		}
	%>
</table>
<div style="border:0px solid red; padding-top:20px; width:50% " align = "center">
<form name="searchForm">
	<select name="searchGubun">
		<option value="">--선택--</option>
		<option value="writer"<% if (searchGubun.equals("writer")) { out.println("selected"); } %>>작성자</option>
		<option value="subject"<% if (searchGubun.equals("subject")) { out.println("selected"); } %>>제목</option>
		<option value="content"<% if (searchGubun.equals("content")) { out.println("selected"); } %>>내용</option>
		<option value="writer_subject_content"<% if (searchGubun.equals("writer_subject_content")) { out.println("selected"); } %>>작성자+제목+내용</option>
	</select>	
	<input type="text" name="searchData" value="<%=searchData%>">	
	<button type="button" onClick="search();">검색</button>
</form>
<script>
function search() {
	if(confirm('검색할까요?')) {
		document.searchForm.action="main.jsp?menuGubun=board_listSearch";
		document.searchForm.method="post";
		document.searchForm.submit();			
	}
}
</script>
</div>
<div style="border: 0px solid red; padding-top :20px; width:80%;" align="right">
|
<a href="#" onClick="move('board_list','','','');">전체목록</a>
|
<a href="#" onClick="move('board_list','','<%=searchGubun %>','<%=searchData %>');">목록</a>
|
<a href="#" onClick="move('board_chuga','','<%=searchGubun %>','<%=searchData %>');">추가</a>
|

</div>
<div style="border: 0px solid red; padding: 20px; width: 80%;" align="center">
<%
	int totalBlock = totalPage / blockSize;
	double value1 = (double)totalBlock;
	double value2 = totalPage / blockSize;
	if(value1 - value2 == 0) {
		totalBlock = totalBlock -1;
	}
%>
<a href="#" onClick="goPage('<%=menuGubun%>','<%=searchGubun%>','<%=searchData%>');">[첫페이지]</a>
&nbsp;
<%
	if(block >0) {
		int imsiPage = (block-1) * blockSize + 10;
%>
	<a href="#" onClick="goPage('<%=menuGubun%>','<%=imsiPage %>','<%=searchGubun%>','<%=searchData%>');">[이전10개]</a>
<% 	} else { %>
		[이전10개]
<% } %>
&nbsp;
<%
	for(int goPage = 1; goPage <= blockSize; goPage++) {
		int imsiValue = block * blockSize + goPage;
		if(totalPage - imsiValue >= 0) {
			if(imsiValue == pageNumber) {
%>
				<b>[<%=imsiValue%>]</b>
<%
			} else {
%>
			<a href="#" onClick="goPage('<%=menuGubun %>','<%=imsiValue %>','<%=searchGubun %>','<%=searchData %>');"><%=imsiValue %></a>
<%
		}
		out.println("&nbsp;");
	}
}
%>
<%
	if(block - totalBlock <= 0) {
		int yyy = (block +1) * blockSize +1;
		int zzz = block + 1;
%>
		<a href="#" onClick="goPage('<%=menuGubun %>','<%=yyy %>','<%=searchGubun %>','<%=searchData %>');">[다음10개]</a>
<%
	} else {
%>
	[다음10개]
<%
	}
%>
&nbsp;

<a href="#" onClick="goPage('<%=menuGubun%>','<%=totalPage %>','<%=searchGubun%>','<%=searchData%>');">[끝페이지]</a>
</div>
<script>
	function goPage(value1, value2, value3, value4) {
		location.href = 'main.jsp?menuGubun=' + value1 + '&pageNumber=' + value2 + '&searchGubun=' + value3 + "&searchData=" + value4; 
	}
</script>