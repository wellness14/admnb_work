<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
		<p>
			본사 계정 목록<br>
		<table border=1>
			<tr>
				<td>ID</td><td>이름</td><td>권한</td><td>삭제</td>
			</tr>
<%
	//Class.forName("com.mysql.jdbc.Driver");

	ResultSet rs = null;
	String sql;

	sql = "select * from WEB_MANAGER";

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
		out.println(e.getMessage());
		e.printStackTrace();
	}
	DBPool.removeDBObject(rs);
%>
		</table>
		</p>
		<p>
			지사 계정 목록<br>
		<table border=1>
			<tr>
				<td>ID</td><td>계약자명</td><td>사업자명</td><td>전화번호</td><td>삭제</td>
			</tr>
<%
	sql = "select * from MEMBER";

	rs = DBPool.getResultSet(sql);
	try
	{
		while (rs.next())
		{
			out.print("<tr><td align=center>" + rs.getString("ID") +
				"</td><td align=center>" + rs.getString("CONTRACTOR") +
				"</td><td align=center>" + rs.getString("BUSINESS") +
				"</td><td align=center>" + rs.getString("MOBILE") +
				"</td><td align=center><a href=\"_user_del.jsp?ID=" +
					rs.getString("ID") + "\">삭제</a></td></tr>");
		}
	}
	catch (SQLException e)
	{
		out.println(e.getMessage());
		e.printStackTrace();
	}
	DBPool.removeDBObject(rs);
%>
		</table>
		</p>
	</body>
</html>
