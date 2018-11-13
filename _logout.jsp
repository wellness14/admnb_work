<%@ page contentType = "text/html; charset=utf-8" %>

<%
	session.invalidate();
//	response.sendRedirect("login.jsp");
%>

<html>
	<head>
		<title>Wellness Login</title>
		<base target="_top">
		<meta http-equiv="refresh" content="0; url=login.jsp">
		<script type="text/javascript">
    		window.top.location = 'login.jsp';
		</script>
	</head>

	<body>
	</body>
</html>
