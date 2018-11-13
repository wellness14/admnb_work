<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	public String getStateString(Terminal item)
	{
		String ret = "";

		if (item._available)
		{
			ret += "이용가능";
		}
		else
		{
			ret += "이용불가";
		}

		return ret;
	}
%>

<%
	List<Terminal> list = UserDB.getTerminalList();

	//access via Iterator
	Iterator iterator = list.iterator();
	while (iterator.hasNext())
	{
		Terminal item = (Terminal) iterator.next();
		//if (item._available == false) continue;
		String s = "<tr>";
		/*
		//s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + item._no + "</td>";
		s += "<td align=center><button onclick=\"setTerminal(" + item._index + ", '" + item._no + "');\" type='button'>선택</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		*/
		s += "<td>" + item._no + "</td>\n";
		s += "<td>" + getStateString(item) + "</td>\n";
		s += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setTerminal(" + item._index + ", '" + item._no + "번')\">선택</a></td>\n";
		s += "</tr>\n";
		out.write(s);
	}
%>
