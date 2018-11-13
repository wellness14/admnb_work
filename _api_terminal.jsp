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
	String toJSON(Terminal item)
	{
		String json = "{";
		json += "\"INDEX\":" + item._index + ",";
		json += "\"NUMBER\":" + item._no + ",";
		json += "\"AVAILABLE\":" + (item._available ? "true" : "false") + "";
		return json + "}";
	}

	int _index = -1;
	boolean _isDone = false;
	String _result = "";
	String _command = "NONE";
	HttpServletRequest _request = null;

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
		List<Terminal> list;
		String str;
		Iterator iterator;
		Terminal item;

		list = UserDB.getTerminalList();
		iterator = list.iterator();
		str = "";

		if (iterator.hasNext())
		{
			item = (Terminal) iterator.next();
			str = toJSON(item);
		}

		while (iterator.hasNext())
		{
			item = (Terminal) iterator.next();
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
		_item = UserDB.getTerminal(_item._index);
		return toJSON(_item);
	}

	public String onSet()
	{
		UserDB.updateTerminal(_item);
		return "";
	}

	public String onDelete()
	{
		UserDB.deleteTerminal(_item);
		return "";
	}

	public boolean onParameter(String name, String val)
	{
		boolean bRet = true;

		if (name.equals("AVAILABLE"))
		{
			_item._available = (Integer.parseInt(val) == 1);
		}
		else if (name.equals("NUMBER"))
		{
			_item._no = Integer.parseInt(val);
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

	Terminal _item = null;
	public void getItem()
	{
		if ((String)_request.getParameter("INDEX") != null)
		{
			_index = Integer.parseInt((String)_request.getParameter("INDEX"));
			_item = UserDB.getTerminal(_index);
		}
		if (_item == null)
		{
			_item = new Terminal();
		}
	}
%>

<%
	Enumeration params = request.getParameterNames();
	_request = request;

	UserDB.PrintLog("API for terminal");
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
