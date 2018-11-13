<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsAll;
	List<Region> lstRegionsGroup;
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
	int _region = -1;

	int calcAge(String social)
	{
        UserDB.PrintLog("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaAGE:" + social + "[" + social.length() + "]");
		if (social.length() < 8)
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

	lstRegionsGroup = UserDB.getRegionList(-1);
	lstRegionsAll = UserDB.getRegionList(0);

	Enumeration params = request.getParameterNames();
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog("Param>" + name + ":" + val);
	}

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

	ResultSet rs = null;
	String sql;
	int count = 0;

	sql = "select *, (select NAME from REGION where h.BELONG_REGION = REGION_INDEX) as BELONG_NAME, (select NAME from REGION where h.WISH_REGION = REGION_INDEX) as WISH_NAME from HELPER as h";
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
        if (count % 2 == 0)
        {
            out.write("<tr class='even pointer'>\n");
        }
        else
        {
            out.write("<tr class='odd pointer'>\n");
        }

        count++;
        //out.write("<td><button type=button onclick='viewHelper(" + rs.getInt("HELPER_INDEX") + ")' >보기</button></td>");
        out.write("<td><a class='btn btn-xs btn-primary btn-mb-0' onclick='viewHelper(" + rs.getInt("HELPER_INDEX") + ")' >보기</a></td>\n");
        out.write("<td>" + rs.getString("NAME") + "</td>\n");
        out.write("<td>" + rs.getString("BELONG_NAME") + "</td>\n");
        out.write("<td>" + rs.getString("WISH_NAME") + "</td>\n");
        out.write("<td><span class='label label-warning'>" + rs.getString("WORKING_STATE") + "</span></td>\n");
        out.write("<td>" + calcAge(rs.getString("SOCIAL_NUM")) + "</td>\n");
        out.write("<td>" + rs.getString("MOBILE") + "</td>\n");
        out.write("</tr>\n");
	}
	DBPool.removeDBObject(rs);
%>
