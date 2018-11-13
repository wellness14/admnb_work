<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!

%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	Terminal term = new Terminal();
	boolean isDelete = false;

	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog(">" + name + ":" + val);
		if (name.equals("AVAILABLE"))
		{
			term._available = val.equals("1") ? true : false;
		}
		else if (name.equals("NO"))
		{
			term._no = Integer.parseInt(val);
		}
		else if (name.equals("INDEX"))
		{
			term._index = Integer.parseInt(val);
		}
		else if (name.equals("DELETE"))
		{
			isDelete = true;
		}
	}
	if (isDelete)
	{
		_userdb.deleteTerminal(term);
	}
	else
	{
		_userdb.updateTerminal(term);
	}
%>
<html>
	<head>
		<title>테스트</title>
	</head>

	<body>
		<%= str %>
	</body>
</html>
