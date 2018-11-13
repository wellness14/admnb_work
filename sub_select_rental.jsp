<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	public int getRented(int index) // count how many items are rented.
	{
		return 0;
	}
%>

<%
	List<Rental> list = UserDB.getRentalList();

	//access via Iterator
	Iterator iterator = list.iterator();
	while (iterator.hasNext())
	{
		Rental item = (Rental) iterator.next();
		if (item._exposed == false) continue;
		String s = "<tr>";
		s += "<td>" + item._no + "</td>\n";
		s += "<td>" + item._name + "</td>\n";
		s += "<td>" + (item._quantity - getRented(item._index)) + "</td>\n";
		s += "<td>" + item._description + "</td>\n";
		s += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setRental(" + item._index + ", '" + item._name + "')\">선택</a></td>\n";

		s += "</tr>\n";
		out.write(s);
	}
%>
