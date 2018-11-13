<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
		<form action="_message_send.jsp" method=post>
			<table border=1>
				<tr>
					<td align=center>수신 ID</td>
					<td>
						<input type=text name="RECEIVER"/>
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
						<input type=submit value="쪽지 전송"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
