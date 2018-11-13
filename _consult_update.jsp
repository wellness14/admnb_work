<%@ page contentType = "text/json; charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*" %>
<%@ page import = "wellness.*" %>

<%@ page isErrorPage="false" %>

<%@ include file="smsSend.jspf" %>


<%!
	String toJSON(Customer item)
	{
		String json = "{";
		json += "\"INDEX\":" + item._index + ",";
		//json += "\"QUANTITY\":" + item._quantity + ",";
		json += "\"URL\":\"" + Utils.getServiceURL() + "/signin.jsp?KEY=" + item._smsURL + "\",";
		json += "\"KEY\":\"" + item._smsURL + "\"";
		//json += "\"REGISTERED\":\"" + _df.format(item._registrationDate) + "\",";
		//json += "\"EXPOSED\":" + (item._exposed ? "true" : "false") + "";
		return json + "}";
	}

%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	Customer item = null;
	boolean isDelete = false;
	boolean isGet = false;
	boolean isSendSMS = false;
	String routes = "";
	int index = -1;

	long totalCost = -1;
	long totalPayed = -1;
	long totalDiscount = -1;
	long totalVoucher = -1;

	//this.request = request;
	Member user = (Member)session.getAttribute("user");
/*
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
*/

	if (request.getParameter("INDEX") != null)
	{
		index = Integer.parseInt((String)request.getParameter("INDEX"));
		item = UserDB.getCustomerItem(index);
	}
	if (item == null)
	{
		item = new Customer();
	}

	UserDB.PrintLog("CustomerUpdate");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		UserDB.PrintLog("Param>" + name + ":" + val);
		if (name.equals("DELETE"))
		{
			isDelete = true;
		}
		if (name.equals("GET"))
		{
			isGet = true;
		}
		if (name.equals("SEND_SMS"))
		{
			isSendSMS = true;
		}
		/*
		else if (name.equals("INDEX"))
		{
			item._index = Integer.parseInt(val);
		}
		*/
		else if (name.equals("NAME"))
		{
			item._name = val;
		}
		else if (name.equals("MEMBER"))
		{
			item._memberIndex = Integer.parseInt(val);
		}
		else if (name.equals("BRANCH"))
		{
			item._branchIndex = Integer.parseInt(val);
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
		else if (name.equals("ROUTE"))
		{
			item._routes = val;
			//routes += val + " ";
		}
		else if (name.equals("ROUTE_VALUE"))
		{
			item._routeVal = val;
			//routes += val + " ";
		}
		else if (name.equals("RECOMMEND_INDEX"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._recommendIndex = Integer.parseInt(val);
		}

		else if (name.equals("HOSPITAL"))
		{
			item._hospital = val;
		}
		else if (name.equals("EXPERIENCES"))
		{
			item._experiences = val;
		}
		else if (name.equals("DUEDATE_BIRTH"))
		{
			if (val.length() == 0) continue;
			item._expectedDate = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._expectedDate));
		}
		else if (name.equals("DUEDATE_OPERATION"))
		{
			if (val.length() == 0) continue;
			item._operationDate = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._expectedDate));
		}
		else if (name.equals("BABY_TYPE_EXPECTED"))
		{
			item._babyTypeExpected = val;
		}
		else if (name.equals("DISABLED"))
		{
			item._disabledType = val;
		}
		else if (name.equals("CARECENTER"))
		{
			item._careCenter = val;
		}
		else if (name.equals("CARECENTER_PERIOD"))
		{
			item._careCenterPeriod = val;
		}
		else if (name.equals("CARE_PLACE_EXPECTED"))
		{
			item._servicePlaceWish = val;
		}
		else if (name.equals("BABY_BIRTH"))
		{
			if (val.length() == 0) continue;
			item._babyBirth = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._babyBirth));
		}
		else if (name.equals("BABIES"))
		{
			item._babyTypes = val;
		}
		else if (name.equals("CHILDBIRTH_TYPE"))
		{
			item._childBirthType = val;
		}
		else if (name.equals("CARE_PLACE_REAL"))
		{
			item._servicePlaceReal = val;
		}
		else if (name.equals("MEMO"))
		{
			item._memo = val;
		}

		else if (name.equals("VOUCHER"))
		{
			item._voucherType = val;
		}
		else if (name.equals("VOUCHER_PERIOD"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._voucherDays = Integer.parseInt(val);
		}
		else if (name.equals("PETS"))
		{
			item._pets = val;
		}
		else if (name.equals("CASHBILL"))
		{
			item._cashReceipt = val;
		}


		else if (name.equals("RENTAL_INDEX"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._rentalIndex = Integer.parseInt(val);
		}
		else if (name.equals("RENTAL_START"))
		{
			item._rentalBegin = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._rentalBegin));
		}
		else if (name.equals("RENTAL_END"))
		{
			item._rentalEnd = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._rentalEnd));
		}
		else if (name.equals("RENTAL_DELIVERY_PAYED"))
		{
			item._rentalDeliveryPayed = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._rentalDeliveryPayed));
		}
		else if (name.equals("DELIVERY_COST"))
		{
			item._rentalDeliveryCost = Integer.parseInt(val);
		}
		else if (name.equals("RENTAL_PAYED"))
		{
			item._rentalPayed = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._rentalPayed));
		}
		else if (name.equals("RENTAL_COST"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._rentalCost = Integer.parseInt(val);
		}

		else if (name.equals("GIFT_INDEX1"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._giftIndex1 = Integer.parseInt(val);
		}
		else if (name.equals("GIFT_SENT_DATE1"))
		{
			item._giftSent1 = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._giftSent1));
		}
		else if (name.equals("GIFT_INDEX2"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._giftIndex2 = Integer.parseInt(val);
		}
		else if (name.equals("GIFT_SENT_DATE2"))
		{
			item._giftSent2 = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._giftSent2));
		}

		else if (name.equals("TERMINAL_INDEX"))
		{
			if ((val == null) || (val.length() == 0)) val = "0";
			item._terminalIndex = Integer.parseInt(val);
		}
		else if (name.equals("TERMINAL_START"))
		{
			item._terminalBegin = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._terminalBegin));
		}
		else if (name.equals("TERMINAL_END"))
		{
			item._terminalEnd = Utils.convStringToTimestamp(val);
			UserDB.PrintLog(Utils.convTimeToSQL(item._terminalEnd));
		}

		else if (name.equals("TOTAL_COST"))
		{
			totalCost = Integer.parseInt(val);
		}
		else if (name.equals("TOTAL_PAYED"))
		{
			totalPayed = Integer.parseInt(val);
		}
		else if (name.equals("TOTAL_DISCOUNT"))
		{
			totalDiscount = Integer.parseInt(val);
		}
		else if (name.equals("TOTAL_VOUCHER"))
		{
			totalVoucher = Integer.parseInt(val);
		}
	}

/*
	_userdb.PrintLog(business[0] + "-" + business[1] + "-" + business[2]);
	item._business = business[0] + "-" + business[1] + "-" + business[2];
	_userdb.PrintLog(regs[0] + "-" + regs[1] + "-" + regs[2] + "-" + regs[3] + "-" + regs[4]);
	item._registration = regs[0] + "-" + regs[1] + "-" + regs[2] + "-" + regs[3] + "-" + regs[4];
*/

	if (isDelete)
	{
		UserDB.deleteCustomer(item);
		out.write(
			"{" +
				"\"COMMAND\":\"" + "Delete" + "\"," +
				"\"RESULT\":" + 1 + "" +
			"}\n"
		);
	}
	else if (isGet)
	{
		String s = "";
		s += "{" +
				"\"COMMAND\":\"" + "Get" + "\"," +
				"\"RESULT\":" + toJSON(item) + "" +
			"}\n";
		UserDB.PrintLog(s);
		out.write(s);
	}
	else if (isSendSMS)
	{
		String s = "";

		// TODO: Send SMS
		///....................
		String res;
		if (item._mobile.length() > 0)
		{
			res = sendSMS(item._mobile, "마더앤베이비(산후도우미) 회원가입을 부탁드립니다.회원가입을 완료하셔야 산후도우미 서비스를 이용할 수 있습니다.회원가입 이동 : " + Utils.getServiceURL() + "/signin.jsp?KEY=" + item._smsURL);
		}
		else
		{
			res = "NoNumber";
		}

		s += "{" +
				"\"COMMAND\":\"" + "SendSMS" + "\"," +
				"\"RESULT\":\"" + res + "\"" +
			"}\n";

		UserDB.PrintLog(s);

		item.updateSMSSendTime();
		UserDB.updateCustomer(item);

		out.write(s);
	}
	else
	{
		int ret = UserDB.updateCustomer(item);
		String cmd;

		if (item._index == -1)
		{
			cmd = "Insert";
		}
		else
		{
			cmd = "Update";
			ret = item._index;
		}

		if (ret != -1)
		{
			if (totalCost != -1)
				DBPool.sendQuery("update CUSTOMER set TOTAL_COST = " + totalCost + " where CUSTOMER_INDEX = " + ret);
			if (totalPayed != -1)
				DBPool.sendQuery("update CUSTOMER set TOTAL_PAYED = " + totalPayed + " where CUSTOMER_INDEX = " + ret);
			if (totalDiscount != -1)
				DBPool.sendQuery("update CUSTOMER set TOTAL_DISCOUNT = " + totalDiscount + " where CUSTOMER_INDEX = " + ret);
			if (totalVoucher != -1)
				DBPool.sendQuery("update CUSTOMER set TOTAL_VOUCHER = " + totalVoucher + " where CUSTOMER_INDEX = " + ret);
		}
		out.write(
			"{" +
				"\"COMMAND\":\"" + cmd + "\"," +
				"\"RESULT\":" + ret + "" +
			"}\n"
		);
	}
%>
