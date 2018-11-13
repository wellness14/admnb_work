<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!

%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	Rental item = new Rental();
	boolean isDelete = false;

	_userdb.PrintLog("하하하");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog(">" + name + ":" + val);
		if (name.equals("EXPOSED"))
		{
			item._exposed = val.equals("1") ? true : false;
		}
		else if (name.equals("NO"))
		{
			item._no = Integer.parseInt(val);
		}
		else if (name.equals("INDEX"))
		{
			item._index = Integer.parseInt(val);
		}
		else if (name.equals("DELETE"))
		{
			isDelete = true;
		}
		else if (name.equals("NAME"))
		{
			item._name = val;
		}
		else if (name.equals("IMAGE"))
		{
			item._image = val;
		}
		else if (name.equals("PRICE"))
		{
			item._price = Integer.parseInt(val);
		}
		else if (name.equals("QUANTITY"))
		{
			item._quantity = Integer.parseInt(val);
		}
		else if (name.equals("DESCRIPTION"))
		{
			item._description = val;
		}
	}
	if (isDelete)
	{
		_userdb.deleteRental(item);
	}
	else
	{
		_userdb.updateRental(item);
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
