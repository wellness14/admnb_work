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
	DateFormat _df = new SimpleDateFormat("yyyy-MM-dd");

	String toJSON(Member item)
	{
		return "";
		/*
		String json = "{";
		json += "\"INDEX\":" + item._index + ",";
		json += "\"NAME\":\"" + item._name + "\",";
		json += "\"ROUTES\":\"" + item._routes + "\",";
		//json += "\"QUANTITY\":" + item._quantity + ",";
		json += "\"EXPECTED_DATE\":\"" + ((item._expectedDate != null) ? _df.format(item._expectedDate) : "미입력") + "\",";
		json += "\"STATUS\":\"" + getStatus(item) + "\",";
		json += "\"SERVICES\":\"" + getServices(item) + "\",";
		json += "\"MEMBER\":\"" + getMember(item) + "\",";
		json += "\"BRANCH\":\"" + getBranch(item) + "\",";
		json += "\"PROGRESS\":\"" + getProgress(item) + "\"";
		//json += "\"EXPOSED\":" + (item._exposed ? "true" : "false") + "";
		return json + "}";
		*/
	}

	int _index = -1;
	boolean _isDone = false;
	String _result = "";
	String _command = "NONE";
	HttpServletRequest _request = null;

	Member _item = null;

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
		else if (_request.getParameter("CHECK") != null)
		{
			_command = "GET";
			_result = onCheck();
			_isDone = true;
		}
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
		List<Member> list;
		String str;
		Iterator iterator;
		Member item;

		list = UserDB.getMemberList();
		iterator = list.iterator();
		str = "";

		if (iterator.hasNext())
		{
			item = (Member) iterator.next();
			str = toJSON(item);
		}

		while (iterator.hasNext())
		{
			item = (Member) iterator.next();
			str += ", " + toJSON(item);
		}

		str = "[\n" +
					str +
				"]\n";

		return str;
	}

	public String onAdd()
	{
		return "";
	}

	public String onGet()
	{
		//_item = UserDB.getMember(_item._index);
		//return toJSON(_item);
		return "";
	}

	public String onSet()
	{
		UserDB.updateMember(_item);
		return "";
	}

	String _id = "";

	public String onCheck()
	{
		boolean isFound = false;
		List<Member> list;
		Iterator iterator;
		Member item;

		list = UserDB.getMemberList();
		iterator = list.iterator();

		while (iterator.hasNext())
		{
			item = (Member) iterator.next();
			if (item._id.equals(_id))
			{
				isFound = true;
			}
		}

		return isFound ? "0" : "1";
	}

	public String onDelete()
	{
		UserDB.deleteMember(_item);
		return "";
	}

	public boolean onParameter(String name, String val)
	{
		boolean bRet = true;

		if (name.equals("ID"))
		{
			_id = val;
			_item._id = val;
		}
		else if (name.equals("CONTRACT"))
		{
			_item._contractor = val;
		}
		else if (name.equals("BUSINESS"))
		{
			_item._business = val;
		}
		else if (name.equals("PASSWORD"))
		{
			_item._password = val;
		}
		/*
		else if (name.equals("PRICE"))
		{
			_item._price = Integer.parseInt(val);
		}
		else if (name.equals("QUANTITY"))
		{
			_item._quantity = Integer.parseInt(val);
		}
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
			_item = UserDB.getMember(_index);
		}
		if (_item == null)
		{
			_item = new Member();
		}
	}
%>

<%
	Enumeration params = request.getParameterNames();
	_request = request;

	UserDB.PrintLog("API for customer");
	getItem();

	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		if (val == null) val = "";
		UserDB.PrintLog("Param>" + name + ":" + val);

		onParameter(name, val);
	}

	HandleRequest();

	UserDB.PrintLog(_result);
	out.write(_result);
%>
