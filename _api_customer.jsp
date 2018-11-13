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

	String arrServices[][] =
	{
		{ "BASIC", "베이직 서비스" },
		{ "PREMIUM", "프리미엄 서비스" },
		{ "VIP", "vip 서비스" },
		{ "PRIVATE", "프라이빗 서비스" },
		{ "TWINS", "다둥이 프로그램(쌍둥이 프로그램)" },
		{ "MULTIPLES", "다둥이 프로그램(다둥이 프로그램)" },
		{ "INTENSIVE(WORKINGMOM)", "집중관리 프로그램(워킹맘 케어 프로그램)" },
		{ "INTENSIVE(CAREHOME)", "집중관리 프로그램(산후조리원 내집에 프로그램)" },
		{ "INTENSIVE(35)", "집중관리 프로그램(35세 이상 산모 집중케어)" },
		{ "INTENSIVE(HEAVY)", "집중관리 프로그램(과체중 산모케어)" }
	};

	String getStatus(Customer item)
	{
		return "대기";
	}

	String getServices(Customer item)
	{
		String ret = "";
		List<CustomerService> list = UserDB.getCustomerServiceList(item._index);
		Iterator iterator = list.iterator();
		CustomerService svc;
		String temp = "";

		if (iterator.hasNext())
		{
			while (iterator.hasNext())
			{
				svc = (CustomerService) iterator.next();
				if (svc._serviceName.equals("none"))
					continue;
				temp = "";
				for (int idx = 0; idx < arrServices.length; idx++)
				{
					if (svc._serviceName.equals(arrServices[idx][0]))
						temp = arrServices[idx][1];
				}
				if (temp.equals(""))
					temp = svc._serviceName;
				ret += temp + "<br>";
				//ret += svc._serviceName + "<br>";
			}
		}
		else
		{
			ret = "입력되지 않음";
		}

		return ret;
	}

	String getMember(Customer item)
	{
		String ret = "지정되지 않음";

		if (item._memberIndex != -1)
		{
			Member member = UserDB.getMember(item._memberIndex);
			ret = member._business;
		}

		return ret;
	}

	String getBranch(Customer item)
	{
		return UserDB.getBranch(item);
		/*
		String ret = "지정되지 않음";

		if (item._memberIndex != -1)
		{
			Member member = UserDB.getMember(item._memberIndex);
			if (member.isHQ())
			{
				ret = "본사";
			}
		}
		if (item._branchIndex != -1)
		{
			Branch branch = UserDB.getBranch(item._branchIndex);
			if (branch != null)
			{
				Region region = UserDB.getRegion(branch._region);
				if (region != null)
				{
					ret = region._name;
				}
			}
		}

		return ret;
		*/
	}

	String getRoutes(Customer item)
	{
		String ret = "";
		String[] vals = item._routes.split(" ");

		if (vals.length == 0)
			ret = "접근경로없음";
		for (int i = 0; i < vals.length; i++)
		{
			if (vals[i].equals("phone"))
				ret += "전화";
			if (vals[i].equals("web"))
				ret += "홈페이지";
			if (vals[i].equals("exhibition"))
				ret += "전시회";
			if (vals[i].equals("voucher"))
				ret += "바우처";
			if (vals[i].equals("center"))
				ret += "조리원";
			if (vals[i].equals("recommend"))
				ret += "추천";
			if (vals[i].equals("search"))
				ret += "검색";
			if (vals[i].equals("blog"))
				ret += "블로그";
			ret += " ";
		}
		return ret;
	}

	String getProgress(Customer item)
	{
		String ret = "";

		if (item._smsSent != null)
		{
			ret += "[" +  _df.format(item._smsSent) + "] 문자발송 ";
			if (item._smsURL.length() != 0)
			{
				ret += "고객확인 대기중";
			}
			else
			{
				ret += "고객확인 완료";
			}
		}
		else
		{
			ret += "문자 미발송";
		}


		return ret;
	}

	String toJSON(Customer item)
	{
		String json = "{";
		json += "\"INDEX\":" + item._index + ",";
		json += "\"NAME\":\"" + item._name + "\",";
		json += "\"ROUTES\":\"" + getRoutes(item) + "\",";
		//json += "\"QUANTITY\":" + item._quantity + ",";
		json += "\"EXPECTED_DATE\":\"" + ((item._expectedDate != null) ? _df.format(item._expectedDate) : "미입력") + "\",";
		json += "\"STATUS\":\"" + getStatus(item) + "\",";
		json += "\"SERVICES\":\"" + getServices(item) + "\",";
		json += "\"MEMBER\":\"" + getMember(item) + "\",";
		json += "\"BRANCH\":\"" + getBranch(item) + "\",";
		json += "\"PROGRESS\":\"" + getProgress(item) + "\"";
		//json += "\"EXPOSED\":" + (item._exposed ? "true" : "false") + "";
		return json + "}";
	}

	int _index = -1;
	boolean _isDone = false;
	String _result = "";
	String _command = "NONE";
	HttpServletRequest _request = null;

	Customer _item = null;

	public boolean HandleRequest()
	{
		String ret;

		if (_request.getParameter("LIST") != null)
		{
			_command = "LIST";
			_result = onList();
			_isDone = true;
		}
		else if (_request.getParameter("ADDLOG") != null)
		{
			_command = "ADDLOG";
			_result = onAddLog();
			_isDone = true;
		}
		else if (_request.getParameter("GETCOST") != null)
		{
			_command = "GETCOST";
			_result = onGetCost();
			_isDone = true;
		}
		/*
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
		List<Customer> list;
		String str;
		Iterator iterator;
		Customer item;

		list = UserDB.getCustomerList();
		iterator = list.iterator();
		str = "";

		while (iterator.hasNext())
		{
			item = (Customer) iterator.next();
			if (item._valid == 1)
				str += toJSON(item) + ",";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
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

	public String onAddLog()
	{
		ConsultLog log = new ConsultLog();
		log._customer = _item._index;
		log._type = this._type;
		log._time = new Timestamp(System.currentTimeMillis());
		log._log = this._log;
		UserDB.writeLog(log);
		return "1";
	}

	public String onGetCost()
	{
		String voucher = "SUP-";
		String temp = _item._voucherType;

		//UserDB.PrintLog("=================> VOUCHER TYPE1:[" + temp + "]");
		//temp = temp.replace("가", "GA");
		//temp = temp.replace("나", "NA");
		//temp = temp.replace("다", "DA");
		//temp = temp.replace("라", "RA");
		//temp = temp.replace("1", "1ST");
		//temp = temp.replace("2", "2ND");
		//temp = temp.replace("3", "3RD");
		//UserDB.PrintLog("=================> VOUCHER TYPE2:[" + temp + "]");
		return "{" +
			"\"GOV\":" + 12000 + "," +
			"\"SELF\":" + 15000 + "" +
			"}";
	}

	public String onGet()
	{
		//_item = UserDB.getCustomer(_item._index);
		//return toJSON(_item);
		return "";
	}

	public String onSet()
	{
		//UserDB.updateCustomer(_item);
		return "";
	}

	public String onDelete()
	{
		UserDB.deleteCustomer(_item);
		return "1";
	}

	public String _type = "";
	public String _log = "";
	public boolean onParameter(String name, String val)
	{
		boolean bRet = true;

		if (name.equals("TYPE"))
		{
			_type = val;
		}
		else if (name.equals("LOG"))
		{
			_log = val;
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
		else if (name.equals("NAME"))
		{
			_item._name = val;
		}
		else if (name.equals("TARGETS"))
		{
			_item._target = val;
		}
*/
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
			_item = UserDB.getCustomerItem(_index);
		}
		if (_item == null)
		{
			_item = new Customer();
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
