<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%
	Enumeration params = request.getParameterNames();
	String str = "";

	while (params.hasMoreElements()) {
		//out.println((String)p.nextElement() + " : " + request.getParameter((String)p.nextElement()));
		Object element = params.nextElement();
		if (element.equals("ROUTE[]"))
		{
			String s[] = request.getParameterValues((String)element);
			int i;
			for (i = 0; i < s.length; i++)
			{
				str += "{" + (String)element + "} ===> {" + s[i] + "}<br/>\n";
			}
		}
		else str += "{" + (String)element + "} => {" + request.getParameter((String)element) + "}<br/>\n";
	}

	UserDB.PrintLog(str);
%>
<html>
	<head>
		<title>테스트</title>
	</head>

	<body>
		<%= str %>
	</body>
</html>
