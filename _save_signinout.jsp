<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*" %>
<%@ page import = "wellness.*" %>

<%@ page isErrorPage="false" %>

<%!
	String convServiceToJSON(CustomerService item)
	{
		String json = "{";

		return json + "}";
	}
%>

<%
	Enumeration params = request.getParameterNames();
	String sql = "";
	//String overtime = "";
	CustomerService item = new CustomerService();

	UserDB.PrintLog("_save_signout.jsp");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		UserDB.PrintLog("Param>" + name + ":" + val);

		if (name.equals("SIGNIN"))
		{
			sql = "update INFORMATIONS set INFORMATION='" + val + "' where NAME='SIGNIN'";
			DBPool.sendQuery(sql);
		}
		else if (name.equals("SIGNOUT"))
		{
			sql = "update INFORMATIONS set INFORMATION='" + val + "' where NAME='SIGNOUT'";
			DBPool.sendQuery(sql);
		}
		else
		{
			UserDB.PrintLog("Undefined handler for >[" + name + ":" + val + "]");
		}
	}

%>
