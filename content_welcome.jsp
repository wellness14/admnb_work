<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
</style>
		<title>Top</title>
	</head>

	<body>
        <p>어서오세요.</p>
<%
	Member info = (Member)session.getAttribute("user");
	if (info != null)
	{
		out.write(info._contractor + " 님.");
	}
%>
	</body>
</html>
