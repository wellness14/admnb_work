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
	Enumeration params = request.getParameterNames();
	String str = "";
	PreCustomer item = new PreCustomer();
	boolean isDelete = false;
	UserDB db = new UserDB();
	int index = -1;

	if (request.getParameter("PRECUSTOMER_INDEX") != null)
	{
		index = Integer.parseInt((String)request.getParameter("PRECUSTOMER_INDEX"));
		item = db.getPreCustomerItem(index);
		out.write("{\"CUSTOMER\":" + item._indexCustomer + "}");
		/*
		if ((index == -1) || (item == null))
		{
			out.write("{\"SIGNIN\":" + 0 + "}");
		}
		*/
	}
	else
	{
		out.write("{\"CUSTOMER\":" + -1 + "}");
	}


%>
