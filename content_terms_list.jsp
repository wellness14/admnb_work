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
					<td>ID</td><td>이름</td><td>권한</td><td>삭제</td>
				</tr>
<%
	//Class.forName("com.mysql.jdbc.Driver");

	ResultSet rs = null;

	String sql = "select * from WEB_MANAGER";

	rs = DBPool.getResultSet(sql);

	try
	{
		while (rs.next())
		{
			out.print("<tr><td align=center>" + rs.getString("ID") +
				"</td><td align=center>" + rs.getString("NAME") +
				"</td><td align=center>" + rs.getString("PERMISSIONS") +
				"</td><td align=center><a href=\"_user_del.jsp?ID=" +
					rs.getString("ID") + "\">삭제</a></td></tr>");
		}
	}
	catch (SQLException e)
	{
		e.printStackTrace();
	}
	DBPool.removeDBObject(rs);
%>
			</table>
		</form>
	</body>
</html>
