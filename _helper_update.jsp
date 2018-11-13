<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!

%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	MomHelper item = new MomHelper();
	boolean isDelete = false;
	boolean isInhouse = false;
	boolean isCommute = false;

	_userdb.PrintLog("HelperUpdate");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		_userdb.PrintLog("Param>" + name + ":" + val);
		if (name.equals("DELETE"))
		{
			isDelete = true;
		}
		else if (name.equals("INDEX"))
		{
			item._index = Integer.parseInt(val);
		}
		/*
		else if (name.equals("EXPOSED"))
		{
			item._exposed = val.equals("1") ? true : false;
		}
		*/
		else if (name.equals("NAME"))
		{
			item._name = val;
		}
		else if (name.equals("SOCIAL_NUM"))
		{
			item._socialNum = val;
		}
		else if (name.equals("POST"))
		{
			item._post = val;
		}
		else if (name.equals("ADDRESS1"))
		{
			item._address1 = val;
		}
		else if (name.equals("ADDRESS2"))
		{
			item._address2 = val;
		}
		else if (name.equals("MOBILE"))
		{
			item._mobile = val;
		}
		else if (name.equals("PHONE"))
		{
			item._phone = val;
		}
		else if (name.equals("EDUCATION"))
		{
			item._education = val;
		}
		else if (name.equals("INSURANCE"))
		{
			item._insurance = val;
		}
		else if (name.equals("HEALTH_CARE"))
		{
			item._health = Utils.convStringToTimestamp(val);
			_userdb.PrintLog(Utils.convTimeToSQL(item._health));
		}
		else if (name.equals("BENEFIT_BEGIN"))
		{
			item._benefitBegin = Utils.convStringToTimestamp(val);
			_userdb.PrintLog(Utils.convTimeToSQL(item._benefitBegin));
		}
		else if (name.equals("BENEFIT_END"))
		{
			item._benefitEnd = Utils.convStringToTimestamp(val);
			_userdb.PrintLog(Utils.convTimeToSQL(item._benefitEnd));
		}
		else if (name.equals("RELIGION"))
		{
			item._religion = val;
		}
		else if (name.equals("WORK_TYPE_INHOUSE"))
		{
			if (isCommute)
			{
				item._workType = "BOTH";
			}
			else
			{
				item._workType = "INHOUSE";
			}
			isInhouse = true;
		}
		else if (name.equals("WORK_TYPE_COMMUTE"))
		{
			if (isInhouse)
			{
				item._workType = "BOTH";
			}
			else
			{
				item._workType = "COMMUTE";
			}
			isCommute = true;
		}
		else if (name.equals("MEMO"))
		{
			item._memo = val;
		}
		else if (name.equals("REGION_BELONG"))
		{
			item._belong = Integer.parseInt(val);;
		}
		else if (name.equals("REGION_WISH"))
		{
			item._wish = Integer.parseInt(val);;
		}
		/*
		else if (name.equals("NAME"))
		{
			item._name = val;
		}
		else if (name.equals("IMAGE"))
		{
			item._image = val;
		}
		else if (name.equals("PRICE"))
		{
			item._price = Integer.parseInt(val);
		}
		else if (name.equals("QUANTITY"))
		{
			item._quantity = Integer.parseInt(val);
		}
		else if (name.equals("DESCRIPTION"))
		{
			item._description = val;
		}
		*/
	}

	if (isDelete)
	{
		_userdb.deleteHelper(item);
	}
	else
	{
		_userdb.updateHelper(item);
	}
%>
<html>
	<head>
		<title>테스트</title>
	</head>

	<body>
		<%= str %>
	</body>
</html>
