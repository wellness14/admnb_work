<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%
	Enumeration params = request.getParameterNames();
	String str = "";

	while (params.hasMoreElements()) {
		//out.println((String)p.nextElement() + " : " + request.getParameter((String)p.nextElement()));
		Object element = params.nextElement();
		_userdb.updateServiceOption((String)element, request.getParameter((String)element));
		str += "{" + (String)element + "} => {" + request.getParameter((String)element) + "}<br/>";
	}

//	_userdb.PrintLog(str);
%>
<html>
	<head>
		<title>테스트</title>
	</head>

	<body>
		<%= str %>
	</body>
</html>
