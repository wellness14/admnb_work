<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<% Tags tags = _userdb.getTags(); %>
	<body>
		<form action="_tags_update.jsp" method=post>
			<table border=1>
				<tr>
					<td>타이틀</td><td><input type=text name="TITLE" value="<%= tags.getTitle() %>" /></td>
				</tr>
				<tr>
					<td>메타태그 작성자</td><td><input type=text name="AUTHOR" value="<%= tags.getAuthor() %>" /></td>
				</tr>
				<tr>
					<td>메타태그 설명</td><td><input type=text name="DESCRIPTION" value="<%= tags.getDescription() %>" /></td>
				</tr>
				<tr>
					<td>메타태그 키워드</td><td><input type=text name="KEYWORD" value="<%= tags.getKeyword() %>" /></td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<input type=submit value="저장"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
