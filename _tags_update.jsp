<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
<%
	Tags tags = new Tags();
	tags.setTitle(request.getParameter("TITLE"));
	tags.setAuthor(request.getParameter("AUTHOR"));
	tags.setDescription(request.getParameter("DESCRIPTION"));
	tags.setKeyword(request.getParameter("KEYWORD"));
	_userdb.setTags(tags);
%>

		<!--
		<form action="login_check.jsp" method=post>
			<table border=1>
				<tr>
					<td align=center>ID</td>
					<td>
						<input type=text />
					</td>
				</tr>
				<tr>
					<td>Password</td>
					<td>
						<input type=password />
					</td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<button type=submit />제출</button>
					</td>
				</tr>
			</table>
		</form>
	-->
	<%
		response.sendRedirect("content_seo_edit.jsp");
		// out.getParameter("");
	%>
	</body>
</html>
