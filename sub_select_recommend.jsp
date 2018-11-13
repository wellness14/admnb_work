<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%
	List<Customer> list;

	String pattern = (String)request.getParameter("PATTERN");
	list = _userdb.getCustomerList_Pattern(pattern);

	//access via Iterator
	Iterator iterator = list.iterator();
	while (iterator.hasNext())
	{
		Customer item = (Customer) iterator.next();
		String s = "<tr>";
		/*
		//s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + item._name + "</td>";
		s += "<td align=center><button onclick=\"setRecommend(" + item._index + ", '" + item._name + "');\" type='button'>선택</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		*/
		s += "<th scope='row'>" + ((item._id.length() > 0) ? item._id : "미입력") + "</th>\n";
		s += "<td>" + item._name + "</td>\n";
		s += "<td>" + item._mobile + "</td>\n";
		s += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setRecommend(" + item._index + ", '" + item._name + "')\">확인</a></td>\n";
		s += "</tr>\n";

		out.write(s);
	}
%>
