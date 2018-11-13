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
	String convServiceToJSON(CustomerService item)
	{
		String json = "{";

		return json + "}";
	}
%>

<%
	Enumeration params = request.getParameterNames();
	String str = "";
	boolean isDelete = false;
	boolean isAdd = false;
	boolean isGet = false;
	boolean isSet = false;
	int serviceIndex = -1;
	int customerIndex = -1;
	//String overtime = "";
	CustomerService item = null;
	int reference = -1;

	if ((String)request.getParameter("SERVICE_INDEX") != null)
	{
		serviceIndex = Integer.parseInt((String)request.getParameter("SERVICE_INDEX"));
		item = UserDB.getCustomerServiceItem(serviceIndex);
	}
	if (item == null)
	{
		item = new CustomerService();
	}
	UserDB.PrintLog("API for customer service");
	while (params.hasMoreElements()) {
		String name = (String)params.nextElement();
		String val = (String)request.getParameter(name);
		UserDB.PrintLog("Param>" + name + ":" + val);
		if (val == null) val = "";

		if (name.equals("DELETE"))
		{
			isDelete = true;
		}
		else if (name.equals("ADD"))
		{
			isAdd = true;
		}
		else if (name.equals("GET"))
		{
			isGet = true;
		}
		else if (name.equals("SET"))
		{
			isSet = true;
		}

		else if (name.equals("SERVICE_INDEX"))
		{
			//serviceIndex = Integer.parseInt(val);
		}
		else if (name.equals("CUSTOMER_INDEX"))
		{
			customerIndex = Integer.parseInt(val);
			item._customer = Integer.parseInt(val);
		}
		else if (name.equals("OVERTIME"))
		{
			//overtime = val;
			item._additionalOvertime = val;
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
		}
	}

	if (isDelete)
	{
		out.write(
			"{" +
				"\"INDEX\":" + UserDB.deleteCustomerService(serviceIndex) + "" +
			"}"
		);
	}
	else if (isAdd)
	{
		out.write(
			"{" +
				"\"INDEX\":" + UserDB.insertCustomerService(customerIndex) + "" +
				//",\"TEST\":[" + "1, 2, 6, 8" + "]" +
			"}"
		);
		//UserDB.PrintLog("Holy shit!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	}
	else if (isGet)
	{
		List<CustomerService> list = UserDB.getCustomerServiceList(customerIndex);
		Iterator iterator = list.iterator();

		str = "";
		if (iterator.hasNext())
		{
			item = (CustomerService) iterator.next();
			str = item.toJSON();
		}

		while (iterator.hasNext())
		{
			item = (CustomerService) iterator.next();
			str += ", " + item.toJSON();
		}

		str =	"{\n" +
					"\"LIST\":[" + str + "]\n" +
				"}\n";
		UserDB.PrintLog(str);
		out.write(str);
	}
	else if (isSet)
	{
		//CustomerService ;
		//item = UserDB.getCustomerServiceItem(serviceIndex);

		//item._index = serviceIndex;
		//item._additionalOvertime = overtime;
		int ret = UserDB.updateCustomerService(item);

		out.write(
			"{" +
				"\"RESULT\":" + ret + "," +
				"\"REFERENCE\":" + reference + "" +
			"}\n"
		);
	}
	else
	{
		UserDB.PrintLog("No operation is specified to _api_customer_service.jsp");
	}

%>
