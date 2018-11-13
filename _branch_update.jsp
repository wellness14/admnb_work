<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!

%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	Branch item = new Branch();
	boolean isDelete = false;

	String[] business = new String[3];
	String[] regs = new String[5];

	for (int i = 0; i < business.length; i++)
	{
		business[i] = "";
	}
	for (int i = 0; i < regs.length; i++)
	{
		regs[i] = "";
	}
	_userdb.PrintLog("BranchUpdate");
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
		else if (name.equals("MEMBER"))
		{
			item._member = Integer.parseInt(val);
		}
		else if (name.equals("REGION"))
		{
			item._region = Integer.parseInt(val);
		}
		else if (name.equals("OPERATOR"))
		{
			item._operator = val;
		}

		else if (name.equals("BUSINESS1"))
		{
			business[0] = val;
		}
		else if (name.equals("BUSINESS2"))
		{
			business[1] = val;
		}
		else if (name.equals("BUSINESS3"))
		{
			business[2] = val;
		}

		else if (name.equals("REGISTRATION1"))
		{
			regs[0] = val;
		}
		else if (name.equals("REGISTRATION2"))
		{
			regs[1] = val;
		}
		else if (name.equals("REGISTRATION3"))
		{
			regs[2] = val;
		}
		else if (name.equals("REGISTRATION4"))
		{
			regs[3] = val;
		}
		else if (name.equals("REGISTRATION5"))
		{
			regs[4] = val;
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

		else if (name.equals("BANK_NAME"))
		{
			item._bankName = val;
		}
		else if (name.equals("BANK_ACCOUNT"))
		{
			item._bankAccount = val;
		}
		else if (name.equals("BANK_OWNER"))
		{
			item._bankOwner = val;
		}

		else if (name.equals("VOUCHER_NAME"))
		{
			item._voucherName = val;
		}
		else if (name.equals("VOUCHER_ACCOUNT"))
		{
			item._voucherAccount = val;
		}
		else if (name.equals("VOUCHER_OWNER"))
		{
			item._voucherOwner = val;
		}

		else if (name.equals("EMAIL"))
		{
			item._email = val;
		}
		else if (name.equals("MOBILE"))
		{
			item._mobile = val;
		}
		else if (name.equals("OFFICE"))
		{
			item._office = val;
		}
		else if (name.equals("FAX"))
		{
			item._fax = val;
		}

		else if (name.equals("CONTRACT_MADE"))
		{
			item._contractMade = Utils.convStringToTimestamp(val);
			_userdb.PrintLog(Utils.convTimeToSQL(item._contractMade));
		}
		else if (name.equals("CONTRACT_BEGIN"))
		{
			item._contractBegin = Utils.convStringToTimestamp(val);
			_userdb.PrintLog(Utils.convTimeToSQL(item._contractBegin));
		}
		else if (name.equals("CONTRACT_END"))
		{
			item._contractEnd = Utils.convStringToTimestamp(val);
			_userdb.PrintLog(Utils.convTimeToSQL(item._contractEnd));
		}

		else if (name.equals("PROFILE"))
		{
			item._profile = val;
		}
		else if (name.equals("SPECIAL"))
		{
			item._special = val;
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

	_userdb.PrintLog(business[0] + "-" + business[1] + "-" + business[2]);
	item._business = business[0] + "-" + business[1] + "-" + business[2];
	_userdb.PrintLog(regs[0] + "-" + regs[1] + "-" + regs[2] + "-" + regs[3] + "-" + regs[4]);
	item._registration = regs[0] + "-" + regs[1] + "-" + regs[2] + "-" + regs[3] + "-" + regs[4];

	if (isDelete)
	{
		_userdb.deleteBranch(item);
	}
	else
	{
		_userdb.updateBranch(item);
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
