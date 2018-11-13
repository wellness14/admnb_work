<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
<%
	ResultSet rs = null;
	boolean isDuplicated = false;
	String sql;
	String dupTable = "";

	// check ID collision from HQ table
	sql = "select * from WEB_MANAGER where ID = '" + request.getParameter("ID") + "'";
	rs = DBPool.getResultSet(sql);

	if (rs.next())
	{
		isDuplicated = true;
		dupTable = "본사계정";
	}
	DBPool.removeDBObject(rs);

	// check ID collision from Branch table
	sql = "select * from MEMBER where ID = '" + request.getParameter("ID") + "'";
	rs = DBPool.getResultSet(sql);

	if (rs.next())
	{
		isDuplicated = true;
		dupTable = "지사계정";
	}
	DBPool.removeDBObject(rs);

	if (!isDuplicated)
	{
		if (request.getParameter("TYPE").equals("HQ"))
		{
			sql = "insert into WEB_MANAGER(ID, NAME, PASSWORD, PERMISSIONS) values (" +
				"'" + request.getParameter("ID") + "', " +
				"'" + request.getParameter("NAME") + "', " +
				"'" + request.getParameter("PASSWORD") + "', " +
				"'" + request.getParameter("PERMISSIONS") + "')";
		}
		else
		{
			sql = "insert into MEMBER(ID, CONTRACTOR, BUSINESS, PASSWORD, MOBILE) values (" +
				"'" + request.getParameter("ID") + "', " +
				"'" + request.getParameter("CONTRACTOR") + "', " +
				"'" + request.getParameter("BUSINESS") + "', " +
				"'" + request.getParameter("PASSWORD") + "', " +
				"'" + request.getParameter("MOBILE") + "')";
		}
		DBPool.sendQuery(sql);
	}

	if (!isDuplicated)
	{
		response.sendRedirect("content_user_list.jsp");
	}
	else
	{
		%>
		<script>
			alert('사용자 추가 실패 - <%= dupTable %>에 이미 존재하는 ID 입니다.');
			window.history.go(-1);
		</script>
		<%
	}
	// out.getParameter("");
%>
	</body>
</html>
