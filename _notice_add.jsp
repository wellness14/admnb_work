<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
<%
	boolean isSuccess = false;
	UserDB db = (UserDB)session.getAttribute("db");
	isSuccess = db.writeNotice(request.getParameter("TITLE"), request.getParameter("CONTENT"));
	
	if (isSuccess)
	{
		response.sendRedirect("content_notice_list.jsp");
	}
	else
	{
		%>
		<script>
			alert('공지사항 저장 실패');
			window.history.go(-1);
		</script>
		<%
	}
	// out.getParameter("");
%>
	</body>
</html>
