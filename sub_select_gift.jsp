<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	public int getGifted(int index) // count how many items are rented.
	{
		return 0;
	}
%>

<%
	List<Gift> list = _userdb.getGiftList();

	//access via Iterator
	Iterator iterator = list.iterator();
	while (iterator.hasNext())
	{
		Gift item = (Gift) iterator.next();
		if (item._exposed == false) continue;
		String s = "<tr>";
		/*
		//s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + item._name + "</td>";
		s += "<td align=center><button onclick=\"setGift(" + item._index + ", '" + item._name + "');\" type='button'>선택</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		*/
		s += "<td>" + item._no + "</td>\n";
		s += "<td>" + item._name + "</td>\n";
		s += "<td>" + (item._quantity - getGifted(item._index)) + "</td>\n";
		s += "<td>" + item._target + "</td>\n";
		s += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setGift(" + item._index + ", '" + item._name + "')\">선택</a></td>\n";
		s += "</tr>\n";
		out.write(s);
	}
%>
