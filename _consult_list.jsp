<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsAll;
	List<Region> lstRegionsGroup;
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
	int _region = -1;

	int calcAge(String social)
	{
		if (social.length() < 14)
		{
			return -1;
		}

		int curYear = Calendar.getInstance().get(Calendar.YEAR);
		int year = Integer.parseInt(social.substring(0, 2));
		String[] socials = social.split("-");

		char temp = socials[1].charAt(0);
		boolean is2000s = ((temp == '3') || (temp == '4'));
		if (is2000s)
		{
			year += 2000;
		}
		else
		{
			year += 1900;
		}

		return curYear - year + 1;
	}
%>

<%
	int index = -1;
	String where = "";

	lstRegionsGroup = _userdb.getRegionList(-1);
	lstRegionsAll = _userdb.getRegionList(0);

	Enumeration params = request.getParameterNames();
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog("Param>" + name + ":" + val);
	}

/*
	if ((request.getParameter("SEARCH_REGION") != null) &&
		(request.getParameter("REGION") != null))
	{
		index = Integer.parseInt((String)request.getParameter("REGION"));
		if (request.getParameter("SEARCH_REGION").equals("belong"))
		{
			where += " h.BELONG_REGION = " + index;
		}
		else
		{
			where += " h.WISH_REGION = " + index;
		}
	}

	if (request.getParameter("PATTERN") != null)
	{
		String temp = request.getParameter("PATTERN");
		if (where.length() > 0)
		{
			where += " and ";
		}
		where += "(h.NAME like '%" + temp + "%' or h.MOBILE like '%" + temp + "%')";
	}
*/
%>
		<table border=1>
			<tr>
				<td>보기</td>
				<td>상담</td>
				<td>이름</td>
				<td>분류</td>
				<td>상담</td>
				<td>출산예정일</td>
				<td>진행상태</td>
				<td>지점</td>
				<td>희망서비스</td>
			</tr>
<%
		ResultSet rs = null;
		String sql;

		//sql = "select *, (select NAME from REGION where h.BELONG_REGION = REGION_INDEX) as BELONG_NAME, (select NAME from REGION where h.WISH_REGION = REGION_INDEX) as WISH_NAME from HELPER as h";
		sql = "select * from CUSTOMER as h";
		if (where.length() > 0)
		{
			sql = sql + " where " + where;
		}
		/*
		if (_region != -1)
		{
			sql += " and b.REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + _region + ")";
		}
		*/
		_userdb.PrintLog(sql);
		rs = DBPool.getResultSet(sql);
		while (UserDB.getNext(rs))
		{
			%><tr><%

			out.write("<td><button type=button onclick='viewConsult(" + rs.getInt("CUSTOMER_INDEX") + ")' >보기</button></td>");
			out.write("<td>" + "대기" + "</td>");
			out.write("<td>" + rs.getString("NAME") + "</td>");

			%></tr><%
		}
		DBPool.removeDBObject(rs);
%>
		</table>
