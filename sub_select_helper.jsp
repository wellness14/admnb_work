<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsAll = null; //= _userdb.getGiftList();

	public String getRegionName(int index)
	{
		String ret = "지역표시불가";

		if (lstRegionsAll == null)
		{
			// load once
			lstRegionsAll = UserDB.getRegionList(0);
		}

		for (Iterator i = lstRegionsAll.iterator(); i.hasNext(); )
		{
			Region r = (Region)i.next();
			if (r._index == index)
			{
				ret = r._name;
				break;
			}
		}

		return ret;
	}

	public String getWorkType(String type)
	{
		String ret = "지정되지 않음";

		if (type.equals("INHOUSE"))
		{
			ret = "입주 선호";
		}
		else if (type.equals("BOTH"))
		{
			ret = "입주/출퇴근 선호";
		}
		else if (type.equals("COMMUTE"))
		{
			ret = "출퇴근 선호";
		}

		return ret;
	}
%>

<%
	int serviceIndex = Integer.parseInt((String)request.getParameter("SERVICE_INDEX"));

	List<MomHelper> helperList = _userdb.getHelperList();

	//access via Iterator
	Iterator iterator = helperList.iterator();
	while (iterator.hasNext())
	{
		MomHelper item = (MomHelper) iterator.next();
		String s = "<tr>";
		/*
		//s += "<td>" + header.getIndex() + "</td>";
		s += "<td>" + helper._name + "</td>";
		s += "<td align=center><button onclick=\"setHelper(" + helper._index + ", '" + helper._name + "');\" type='button'>선택</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		*/
		s += "<td>" + item._name + "</td>\n";
		s += "<td>" + item._state + "</td>\n";
		s += "<td>" + getRegionName(item._belong) + "</td>\n";
		s += "<td>" + getWorkType(item._workType) + "</td>\n";
		s += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setHelper(" + serviceIndex + ", " + item._index + ", '" + item._name + "')\">선택</a></td>\n";

		s += "</tr>\n";
		out.write(s);
	}
%>
