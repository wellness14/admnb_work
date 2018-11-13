<%@ page contentType = "text/json; charset=ascii" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*" %>
<%@ page import = "wellness.*" %>

<%!

%>

<%
	UserInfo _user = (UserInfo)session.getAttribute("user");
	UserDB _userdb = (UserDB)session.getAttribute("db");
	if (_user == null)
	{
		response.sendRedirect("_logout.jsp");
	}


	Enumeration params = request.getParameterNames();
	String str = "";
	PreCustomer item = new PreCustomer();
	boolean isDelete = false;

	_userdb.PrintLog("Pre-customer");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog("Param>" + name + ":" + val);
		if (name.equals("DELETE"))
		{
			isDelete = true;
		}
		else if (name.equals("INDEX"))
		{
			item._index = Integer.parseInt(val);
		}
		else if (name.equals("NAME"))
		{
			item._name = val;
		}
		else if (name.equals("POST"))
		{
			item._post = val;
		}
		else if (name.equals("ADDRESS1"))
		{
			item._address1 = val;
		}
		else if (name.equals("ADDRESS2"))
		{
			item._address2 = val;
		}
		else if (name.equals("MOBILE"))
		{
			item._mobile = val;
		}
		else if (name.equals("PHONE"))
		{
			item._phone = val;
		}
		else if (name.equals("ROUTE[]"))
		{
			item._routes += val + " ";
		}
		else if (name.equals("ROUTE_VALUE"))
		{
			item._routeVal = val;
		}
		else if (name.equals("RECOMMEND"))
		{
			item._recommend = val;
		}
	}

	if (isDelete)
	{
		_userdb.deletePreCustomer(item);
	}
	else
	{
		out.write("{\"INDEX\":" + _userdb.updatePreCustomer(item) + "}");
	}

%>
