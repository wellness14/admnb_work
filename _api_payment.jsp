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

<%!
	DateFormat _df = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

	String toJSON(PaymentHistory item)
	{
		String json = "{";
		json += "\"INDEX\":" + item._index + ",";
		json += "\"CUSTOMER\":" + item._customerIndex + ",";
		json += "\"SERVICE_TYPE\":\"" + item._serviceType + "\",";
		json += "\"PAYMENT_TYPE\":\"" + item._paymentType + "\",";
		json += "\"PAYED_COST\":" + item._payedCost + ",";
		json += "\"MEMBER_INDEX\":" + item._memberIndex + ",";
		json += "\"CHECKED_TIME\":\"" + _df.format(item._checkedTime) + "\"";
		return json + "}";
	}

	int _index = -1;
	boolean _isDone = false;
	String _result = "";
	String _command = "NONE";
	HttpServletRequest _request = null;

	PaymentHistory _item = null;

	public boolean HandleRequest()
	{
		String ret;

		if (_request.getParameter("LIST") != null)
		{
			_command = "LIST";
			_result = onList();
			_isDone = true;
		}
		else if (_request.getParameter("ADD") != null)
		{
			_command = "ADD";
			_result = onAdd();
			_isDone = true;
		}
		/*
		else if (_request.getParameter("GET") != null)
		{
			_command = "GET";
			_result = onGet();
			_isDone = true;
		}
		else if (_request.getParameter("SET") != null)
		{
			_command = "SET";
			_result = onSet();
			_isDone = true;
		}
		*/
		else if (_request.getParameter("DELETE") != null)
		{
			_command = "DELETE";
			_result = onDelete();
			_isDone = true;
		}
		else
		{
			_command = "UNKNOWN";
			UserDB.PrintLog("Missing request.............");
		}

		if (_result.length() == 0)
		{
			_result = "\"\"";
		}
		_result = "{" +
			"\"DONE\":" + (_isDone ? 1 : 0) + "," +
			"\"COMMAND\":\"" + _command + "\"," +
			"\"RESULT\":" + _result + "" +
			"}";

		return _isDone;
	}

	public String onList()
	{
		List<PaymentHistory> list;
		String str;
		Iterator iterator;
		PaymentHistory item;

		list = UserDB.getPaymentHistoryList_Customer(_item._customerIndex);
		iterator = list.iterator();
		str = "";

		if (iterator.hasNext())
		{
			item = (PaymentHistory) iterator.next();
			str = toJSON(item);
		}

		while (iterator.hasNext())
		{
			item = (PaymentHistory) iterator.next();
			str += ", " + toJSON(item);
		}

		str = "[\n" +
					str +
				"]\n";

		return str;
	}

	public String onAdd()
	{
		UserDB.updatePaymentHistory(_item);
		return "";
	}

	/*
	public String onGet()
	{
		_item = UserDB.getGift(_item._index);
		return toJSON(_item);
	}

	public String onSet()
	{
		UserDB.updateGift(_item);
		return "";
	}
	*/
	public String onDelete()
	{
		UserDB.deletePaymentHistory(_item);
		return "";
	}

	public boolean onParameter(String name, String val)
	{
		boolean bRet = true;

		if (name.equals("CUSTOMER_INDEX"))
		{
			_item._customerIndex = Integer.parseInt(val);
		}
		else if (name.equals("SERVICE_TYPE"))
		{
			_item._serviceType = val;
		}
		else if (name.equals("PAYMENT_TYPE"))
		{
			_item._paymentType = val;
		}
		else if (name.equals("PAYED_COST"))
		{
			_item._payedCost = Long.parseLong(val);
		}
		else if (name.equals("MEMBER_INDEX"))
		{
			_item._memberIndex = Integer.parseInt(val);
		}
		/*
		else if (name.equals("SERVICE_NAME"))
		{
			item._serviceName = val;
		}
		else if (name.equals("SERVICE_PERIOD"))
		{
			item._servicePeriod = val;
		}

		else if (name.equals("START_DATE"))
		{
			item._serviceStart = Utils.convStringToTimestamp(val);
		}
		else if (name.equals("END_DATE"))
		{
			item._serviceEnd = Utils.convStringToTimestamp(val);
		}
		else if (name.equals("SERVICE_TYPE"))
		{
			item._serviceType = val;
		}
		else if (name.equals("HELPER"))
		{
			item._helper = Integer.parseInt(val);
		}
		else if (name.equals("CARE_CHANGE"))
		{
			item._careChange = Utils.convStringToTimestamp(val);
		}
		else if (name.equals("ADDITIONAL_CARE"))
		{
			item._additionalCare = val;
		}
		else if (name.equals("EXTENDED"))
		{
			item._extended = val;
		}

		else if (name.equals("REFERENCE_INDEX"))
		{
			reference = Integer.parseInt(val);
		}

		else
		{
			UserDB.PrintLog("Undefined handler for >[" + name + ":" + val + "]");
			bRet = false;
		}
		*/

		return bRet;
	}

	public void getItem()
	{
		if ((String)_request.getParameter("INDEX") != null)
		{
			_index = Integer.parseInt((String)_request.getParameter("INDEX"));
			_item = UserDB.getPaymentHistory(_index);
		}
		if (_item == null)
		{
			_item = new PaymentHistory();
		}
	}
%>

<%
	Enumeration params = request.getParameterNames();
	_request = request;

	UserDB.PrintLog("API for gift");
	getItem();

	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		UserDB.PrintLog("Param>" + name + ":" + val);
		if (val == null) val = "";

		onParameter(name, val);
	}

	HandleRequest();

	UserDB.PrintLog(_result);
	out.write(_result);
%>
