<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
		<form action="_user_add.jsp" method=post>
			<table border=1>
				<tr>
					<td>번호</td><td>작성자</td><td>제목</td><td>작성일</td>
				</tr>
<%
	List<NoticeHeader> headers = _userdb.getNoticeHeaderList();
	DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

	//access via Iterator
	Iterator iterator = headers.iterator();
	while (iterator.hasNext())
	{
		NoticeHeader header = (NoticeHeader) iterator.next();
		String s = "<tr>";
		s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + header.getName() + "</td>";
		s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		s += "</tr>\n";
		out.write(s);
	}
%>
			</table>
		</form>
	</body>
</html>
