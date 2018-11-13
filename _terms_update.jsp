<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!

%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	Terms item = new Terms();
	boolean isDelete = false;

	_userdb.PrintLog("TERMS update");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog(">" + name + ":" + val);
		if (name.equals("index"))
		{
			item._index = Integer.parseInt(val);
		}
		else if (name.equals("DELETE"))
		{
			isDelete = true;
		}
		else if (name.equals("type"))
		{
			item._type = val;
		}
		else if (name.equals("CONTENTS"))
		{
			item._contents = val;
		}
		else if (name.equals("APPLY_DATE"))
		{
			item._applyDate = Utils.convStringToTimestamp(val, "yyyy-MM-dd");
		}
	}
	if (isDelete)
	{
		_userdb.deleteTerms(item);
	}
	else
	{
		_userdb.updateTerms(item);
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
