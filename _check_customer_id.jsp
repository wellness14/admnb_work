<%@ page contentType = "text/json; charset=ascii" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*" %>
<%@ page import = "wellness.*" %>

<%
	String val = (String)request.getParameter("ID");
	out.write("{\"AVAILABLE\":" + (UserDB.isAvailableCustomerID(val) ? 1 : 0) + "}");
%>
