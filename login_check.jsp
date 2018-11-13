<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*" %>
<%@ page import = "wellness.*" %>
<!DOCTYPE html>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
<%
	//Class.forName("com.mysql.jdbc.Driver");

	boolean isLogin = false;

	//String sql = "select * from WEB_MANAGER where ID = '" + request.getParameter("ID") + "' and PASSWORD = '" + request.getParameter("PASSWORD") + "'";
	String sql = "select * from MEMBER where ID = '" + request.getParameter("ID") + "' and PASSWORD = '" + request.getParameter("PASSWORD") + "'";

	ResultSet rs = null;
	Member member;
	try
	{
		rs = DBPool.getResultSet(sql);

		if (rs.next())
		{
			isLogin = true;
			//UserInfo info = new UserInfo(rs.getInt("MANAGER_INDEX"), rs.getString("ID"), rs.getString("NAME"), rs.getString("PERMISSIONS"));
			UserDB db = new UserDB();
			member = new Member();
			member.fromResultSet(rs);
			db.setCurrentUser(member);
			session.setAttribute("db", db);
			session.setAttribute("user", member);
		}
	}
	catch (SQLException e)
	{
		e.printStackTrace();
	}
	DBPool.removeDBObject(rs);

	if (isLogin)
	{
		//response.sendRedirect("top.jsp");
		response.sendRedirect("home.jsp");
	}
	else
	{
		%>
		<script>
			alert('로그인 실패');
			window.history.go(-1);
		</script>
		<%
	}
	// out.getParameter("");
%>
	</body>
</html>
