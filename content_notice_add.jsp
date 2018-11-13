<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
		<form action="_notice_add.jsp" method=post>
			<table border=1>
				<tr>
					<td align=center>제목</td>
					<td>
						<input type=text name="TITLE" size="50"/>
					</td>
				</tr>
				<tr>
					<td align=center>내용</td>
					<td>
						<textarea name="CONTENT" rows="4" cols="50"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<input type=submit value="공지사항 저장"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
