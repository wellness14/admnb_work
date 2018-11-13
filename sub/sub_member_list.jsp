<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="../header.jspf" %>

<%
	List<Member> list = _userdb.getMemberList_Pattern(request.getParameter("SEARCH"));

	//access via Iterator
	Iterator iterator = list.iterator();
	while (iterator.hasNext())
	{
		Member item = (Member) iterator.next();
		if (item._isHqBranch.charAt(0) == 'H')
			continue;
		String s = "<tr>";
		//s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + item._contractor + "</td>";
		s += "<td align=center><button onclick=\"setMember(" + item._index + ", '" + item._contractor + "', '" + item._business + "', '" + item._id + "');\" type='button'>선택</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		s += "</tr>\n";

		out.write("<tr>");
		out.write("<th scope='row'>1</th>");
		out.write("<td>" + item._id + "</td>");
		out.write("<td>" + item._contractor + "</td>");
		out.write("<td>" + item._business + "</td>");
		out.write("<td><a onclick=\"setMember(" + item._index + ", '" + item._contractor + "', '" + item._business + "', '" + item._id + "');\" class='btn btn-xs btn-primary btn-mb-0'>선택</a></td>");
		out.write("</tr>");
	}
%>

