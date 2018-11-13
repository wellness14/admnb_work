<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%
/*
	Enumeration p = request.getParameterNames();

	while (p.hasMoreElements()) {
		out.println((String)p.nextElement());
	}
*/
	//Class.forName("com.mysql.jdbc.Driver");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	boolean isDuplicated = false;
	String sql;

	sql = "delete from WEB_MANAGER where ID = '" + request.getParameter("ID") + "'";
	DBPool.sendQuery(sql);
	sql = "delete from MEMBER where ID = '" + request.getParameter("ID") + "'";
	DBPool.sendQuery(sql);

	response.sendRedirect("content_user_list.jsp");
	// out.getParameter("");
%>
