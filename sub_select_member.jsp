<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<title>지사계정 선택</title>
		<script type="text/javascript">
			function setMember(index, contractor, business, id) {
				//alert(name);
				window.opener.setMember(index, contractor, business, id);
				window.close();
			}
		</script>
	</head>

	<body>
		<table>
			<tr>
				<td align=center>
					이름
				</td>
				<td align=center>
					입력
				</td>
			</tr>
<%
	List<Member> list = _userdb.getMemberList(request.getParameter("SEARCH"));

	//access via Iterator
	Iterator iterator = list.iterator();
	while (iterator.hasNext())
	{
		Member item = (Member) iterator.next();
		String s = "<tr>";
		//s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + item._contractor + "</td>";
		s += "<td align=center><button onclick=\"setMember(" + item._index + ", '" + item._contractor + "', '" + item._business + "', '" + item._id + "');\" type='button'>선택</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		s += "</tr>\n";
		out.write(s);
	}
%>
		</table>
	</body>
</html>
