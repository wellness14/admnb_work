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
	public static final long DAY_IN_MS = 1000 * 60 * 60 * 24;
	DateFormat _df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	java.util.Date getDate(int days)
	{
		java.util.Date ret = new java.util.Date(System.currentTimeMillis() + (days * DAY_IN_MS));

		return ret;
	}

	Calendar getCalendar(int days, boolean isMidnight)
	{
		java.util.Date date = new java.util.Date(System.currentTimeMillis() + (days * DAY_IN_MS));
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		if (isMidnight)
		{
			cal.set(Calendar.HOUR, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
		}

		return cal;
	}

	int getRecordCount(String table, String condition)
	{
		String sql;
		int count = -1;
		ResultSet rs = null;

		sql = "select count(*) as _COUNT from " + table + " where " + condition;
		rs = DBPool.getResultSet(sql);
		if (UserDB.getNext(rs))
		{
			try
			{
				count = rs.getInt("_COUNT");
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}

		DBPool.removeDBObject(rs);

		return count;
	}

	String toJSON(Schedule item)
	{
		String json = "{";
		String temp = item._sharedMembers;

		if (temp.length() > 0 && (temp.charAt(0) == '('))
		{
			temp = temp.substring(1, temp.indexOf(')'));
		}
		json += "\"MEMBER\":" + item._member + ",";
		json += "\"CONTENTS\":\"" + item._contents.replace('\n', ' ') + "\",";
		json += "\"IS_PRIVATE\":" + ((item._sharedMembers.equals("(-2)")) ? "true" : "false") + ",";
		json += "\"SHARED_MEMBERS\":" + temp + "";

		return json + "}";
	}

	String toJSON(NoticeHeader item)
	{
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String json = "{";

		json += "\"INDEX\":" + item._index + ",";
		json += "\"TITLE\":\"" + item._title + "\",";
		json += "\"MEMBER_NAME\":\"" + item._name + "\",";
		json += "\"COMPOSED\":\"" + df.format(item._composed) + "\"";

		return json + "}";
	}

	String toJSON(Notice item)
	{
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String json = "{";

		json += "\"INDEX\":" + item.getHeader()._index + ",";
		json += "\"TITLE\":\"" + item.getHeader()._title + "\",";
		json += "\"MEMBER_NAME\":\"" + item.getHeader()._name + "\",";
		json += "\"CONTENTS\":\"" + item.getContent() + "\",";
		json += "\"COMPOSED\":\"" + df.format(item.getHeader()._composed) + "\"";

		return json + "}";
	}

	String toJSON(Gift item)
	{
		String json = "{";

		json += "\"NUMBER\":" + item._no + ",";
		json += "\"NAME\":\"" + item._name + "\",";
		json += "\"PRESENTED\":" + _nDays + "";

		return json + "}";
	}

	String toJSON(Rental item)//Rental
	{
		String json = "{";

		json += "\"NAME\":\"" + item._name + "\",";
		json += "\"TOTAL\":" + item._quantity + ",";
		json += "\"RETURN_SOON\":" + _nDays + ","; // 반납 예정 - 현재일 대여 종료일 이후인 경우.
		json += "\"RENTED\":" + _nDays + ","; // 대여중 - 현재일이 대여 시작일과 대여 종료일 사이인 경우.
		json += "\"RESERVED\":" + _nDays + ""; // 대여 예정 - 대여일보다 현재일이 이전인 경우

		return json + "}";
	}

	String getOrderCounts()
	{
		String json = "{";
		Calendar from = getCalendar(-_nDays, true);
		Calendar to = getCalendar(1, false);
		Calendar today = getCalendar(0, false);
		int stanby = 0;
		//String where1;

		List<Customer> list = UserDB.getCustomerList();
		Iterator iter = list.iterator();
		while (iter.hasNext())
		{
			Customer c = (Customer)iter.next();
			if (c._valid == 0) continue;
			List<CustomerService> l = UserDB.getCustomerServiceList(c._index);
			String sql = "select COUNT(*) as _COUNT from PAYMENT_HISTORY where PAYMENT_TYPE = 'balance' and CUSTOMER_INDEX = " + c._index;
			ResultSet rs = null;
			rs = DBPool.getResultSet(sql);
			if (UserDB.getNext(rs))
			{
				try
				{
					int count = rs.getInt("_COUNT");
					if (count < l.size())
					{
						stanby++;
					}
				} catch (SQLException e) {}
			}
			DBPool.removeDBObject(rs);
		}
		//where1 = "(" + Utils.convTimeToSQL(from) + " < SERVICE_END AND " + Utils.convTimeToSQL(to) + " > SERVICE_END)";

		json += "\"DEPOSIT_STANDBY\":" + stanby + ",";
		json += "\"DEPOSIT_DONE\":" + getRecordCount("PAYMENT_HISTORY",
			"(" + Utils.convTimeToSQL(from) + " < CHECKED_TIME AND " + Utils.convTimeToSQL(to) + " > CHECKED_TIME) and PAYMENT_TYPE = 'balance'") + ",";
		json += "\"CONTRACT_CANCEL\":" + getRecordCount("CUSTOMER",
			"(" + Utils.convTimeToSQL(from) + " < CANCELED AND " + Utils.convTimeToSQL(to) + " > CANCELED)") + ",";
		json += "\"REFUND_DONE\":" + getRecordCount("PAYMENT_HISTORY",
			"(" + Utils.convTimeToSQL(from) + " < CHECKED_TIME AND " + Utils.convTimeToSQL(to) + " > CHECKED_TIME) and SERVICE_TYPE = 'refund' and PAYMENT_TYPE = 'completed'") + ",";
		json += "\"SERVICE_STANDBY\":" + getRecordCount("CUSTOMER_SERVICE",
			"(" + Utils.convTimeToSQL(today) + " < SERVICE_START)") + ",";
		json += "\"IN_SERVICE\":" + getRecordCount("CUSTOMER_SERVICE",
			"(" + Utils.convTimeToSQL(today) + " > SERVICE_START AND " + Utils.convTimeToSQL(today) + " < SERVICE_END)") + ",";
		json += "\"SERVICE_EXTENDED\":" + getRecordCount("PAYMENT_HISTORY",
			"(" + Utils.convTimeToSQL(from) + " < CHECKED_TIME AND " + Utils.convTimeToSQL(to) + " > CHECKED_TIME) and SERVICE_TYPE like 'ext%' and PAYMENT_TYPE like 'balance'") + ",";
		json += "\"SERVICE_DONE\":" + getRecordCount("CUSTOMER_SERVICE",
			"(" + Utils.convTimeToSQL(from) + " < SERVICE_END AND " + Utils.convTimeToSQL(to) + " > SERVICE_END)") + "";
		//json += "\"CHECKED_TIME\":\"" + _df.format(item._checkedTime) + "\"";
		return json + "}";
	}

	String getConsultStats()
	{
		String json = "{";
		Calendar from = getCalendar(-_nDays, true);
		Calendar to = getCalendar(1, false);
		String between = " AND (" + Utils.convTimeToSQL(from) + " < CREATED AND " + Utils.convTimeToSQL(to) + " > CREATED)";
		json += "\"PHONE\":" + getRecordCount("CUSTOMER", "ROUTES like '%phone%'" + between) + ",";
		json += "\"CARECENTER\":" + getRecordCount("CUSTOMER", "ROUTES like '%center%'" + between) + ",";
		json += "\"WEB\":" + getRecordCount("CUSTOMER", "ROUTES like '%web%'" + between) + ",";
		json += "\"BLOG\":" + getRecordCount("CUSTOMER", "ROUTES like '%blog%'" + between) + ",";
		json += "\"EXHIBITION\":" + getRecordCount("CUSTOMER", "ROUTES like '%exhibition%'" + between) + ",";
		json += "\"SEARCH\":" + getRecordCount("CUSTOMER", "ROUTES like '%search%'" + between) + ",";
		json += "\"VOUCHER\":" + getRecordCount("CUSTOMER", "ROUTES like '%voucher%'" + between) + ",";
		json += "\"RECOMMEND\":" + getRecordCount("CUSTOMER", "ROUTES like '%recommend%'" + between) + "";
		//json += "\"CHECKED_TIME\":\"" + _df.format(item._checkedTime) + "\"";
		return json + "}";
	}

	List<Customer> getCustomerList(int branchIndex, int startFromToday, int endFromToday)
	{
		List<Customer> list = new ArrayList<Customer>();
		String sql;
		int count = -1;
		ResultSet rs = null;
		Calendar from = getCalendar(startFromToday, true);
		Calendar to = getCalendar(endFromToday + 1, false);
		Customer item;

		sql = "select * from CUSTOMER where (" + Utils.convTimeToSQL(from) + " < CREATED and " + Utils.convTimeToSQL(to) + " > CREATED)";
		if (branchIndex != -1)
		{
			sql += " and BRANCH_INDEX = " + branchIndex;
		}
		rs = DBPool.getResultSet(sql);
		while (UserDB.getNext(rs))
		{
			item = new Customer();
			item.fromResultSet(rs);
			list.add(item);
		}

		DBPool.removeDBObject(rs);

		return list;
	}

	int getContractCount(int branchIndex, int dateFromToday)
	{
		String sql;
		int count = -1;
		ResultSet rs = null;
		Calendar from = getCalendar(dateFromToday, true);
		int val = 0;

		//sql = "select sum(PAYED_COST) as VALUE, cus.BRANCH_INDEX from PAYMENT_HISTORY as pay inner join CUSTOMER as cus where pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX and cus.VALID = 1 and pay.SERVICE_TYPE <> 'discount' and (" + Utils.convTimeToSQL(from) + " <= CHECKED_TIME and " + Utils.convTimeToSQL(to) + " >= CHECKED_TIME)";
		sql = "select count(*) as VALUE from CUSTOMER_SERVICE as svc inner join CUSTOMER as cus where svc.CUSTOMER_INDEX = cus.CUSTOMER_INDEX and cus.VALID = 1 and " + Utils.convTimeToSQL(from) + " <= SERVICE_START";
		/*
		if (branchIndex != -2)
		{
			sql += " and BRANCH_INDEX = " + branchIndex;
		}
		*/

		rs = DBPool.getResultSet(sql);
		while (UserDB.getNext(rs))
		{
			try {
				//UserDB.PrintLog("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + Utils.convTimeToSQL(from) + "-" + Utils.convTimeToSQL(to) + ":" + rs.getInt("PAYED_INDEX") + ":" + rs.getInt("VALUE"));
				val = rs.getInt("VALUE");
			} catch (SQLException e) {
				UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
			}
		}

		DBPool.removeDBObject(rs);

		return val;
	}

	int getNewCustomerCount(int branchIndex, int dateFromToday)
	{
		String sql;
		int count = -1;
		ResultSet rs = null;
		Calendar from = getCalendar(dateFromToday, true);
		int val = 0;

		//sql = "select sum(PAYED_COST) as VALUE, cus.BRANCH_INDEX from PAYMENT_HISTORY as pay inner join CUSTOMER as cus where pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX and cus.VALID = 1 and pay.SERVICE_TYPE <> 'discount' and (" + Utils.convTimeToSQL(from) + " <= CHECKED_TIME and " + Utils.convTimeToSQL(to) + " >= CHECKED_TIME)";
		sql = "select count(*) as VALUE from CUSTOMER as cus where cus.VALID = 1 and " + Utils.convTimeToSQL(from) + " <= CREATED";
		/*
		if (branchIndex != -2)
		{
			sql += " and BRANCH_INDEX = " + branchIndex;
		}
		*/

		rs = DBPool.getResultSet(sql);
		while (UserDB.getNext(rs))
		{
			try {
				//UserDB.PrintLog("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + Utils.convTimeToSQL(from) + "-" + Utils.convTimeToSQL(to) + ":" + rs.getInt("PAYED_INDEX") + ":" + rs.getInt("VALUE"));
				val = rs.getInt("VALUE");
			} catch (SQLException e) {
				UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
			}
		}

		DBPool.removeDBObject(rs);

		return val;
	}

	void getDailyValidIncome(int branchIndex, int dateFromToday)
	{
		String sql;
		int count = -1;
		ResultSet rs = null;
		Calendar from = getCalendar(dateFromToday, true);
		Calendar to = getCalendar(dateFromToday + 1, true);
		long val = 0;

		//sql = "select sum(PAYED_COST) as VALUE, cus.BRANCH_INDEX from PAYMENT_HISTORY as pay inner join CUSTOMER as cus where pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX and cus.VALID = 1 and pay.SERVICE_TYPE <> 'discount' and (" + Utils.convTimeToSQL(from) + " <= CHECKED_TIME and " + Utils.convTimeToSQL(to) + " >= CHECKED_TIME)";
		sql = "select sum(PAYED_COST) as VALUE from PAYMENT_HISTORY as pay inner join CUSTOMER as cus where pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX and cus.VALID = 1 and pay.SERVICE_TYPE <> 'discount' and (" + Utils.convTimeToSQL(from) + " <= CHECKED_TIME and " + Utils.convTimeToSQL(to) + " >= CHECKED_TIME)";
		/*
		if (branchIndex != -2)
		{
			sql += " and BRANCH_INDEX = " + branchIndex;
		}
		*/

		rs = DBPool.getResultSet(sql);
		_sales = 0;
		_branchSales = 0;
		while (UserDB.getNext(rs))
		{
			try {
				//UserDB.PrintLog("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + Utils.convTimeToSQL(from) + "-" + Utils.convTimeToSQL(to) + ":" + rs.getInt("PAYED_INDEX") + ":" + rs.getInt("VALUE"));
				val = rs.getInt("VALUE");
				_sales += val;
				if ((branchIndex == -2) || (branchIndex == rs.getInt("BRANCH_INDEX")))
					_branchSales += val;
			} catch (SQLException e) {
				UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
			}
		}

		DBPool.removeDBObject(rs);

		//return ret;
	}

	private long _sales = 0;
	private long _branchSales = 0;

	private long _totalSales = 0;
	private long _totalBranchSales = 0;
	private int _contractCount = 0;
	private int _newCustomerCount = 0;

	String getDailyStats()
	{
		java.util.Date date; // = new java.util.Date(System.currentTimeMillis());
		DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
		String str = "";

		//List<Customer> list;
		_totalSales = 0;
		_totalBranchSales = 0;
		_contractCount = getContractCount(-2, -_nDays);
		_newCustomerCount = getNewCustomerCount(-2, -_nDays);
		for (int day = _nDays - 1; day >= 0; day--)
		{
			date = new java.util.Date(System.currentTimeMillis() - (day * DAY_IN_MS));
			//list = getCustomerList(-1, day, day);
			//long sales = 0;
			getDailyValidIncome(-2, -day);
			_totalSales += _sales;
			_totalBranchSales += _branchSales;
			/*
			Iterator iter = list.iterator();
			while (iter.hasNext())
			{
				Customer customer = (Customer)iter.next();
				UserDB.PrintLog("+++++++++++" + customer._totalCost);
				sales += customer._totalCost;
			}
			*/
			str += "{" +
					"\"DATE\":\"" + df.format(date) + "\"," + 
					"\"DAILY_SALES\":" + _sales + "," + 
					"\"DAILY_BRANCH_SALES\":" + _branchSales + "," + 
					"\"REFUND\":" + 0 + "" + 
				"},";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}

		return str;
	}

	String getStatus()
	{
		String json = "{";
		json += "\"DAILY_STATS\":[" + getDailyStats() + "],";
		json += "\"TOTAL_SALES\":" + _totalSales + ",";
		json += "\"BRANCH_SALES\":" + _totalBranchSales + ",";
		json += "\"CONTRACT_COUNT\":" + _contractCount + ",";
		json += "\"NEW_CUSTOMER\":" + _newCustomerCount + ",";
		json += "\"DORMANT_CUSTOMER\":" + (_nDays + 25) + "";
		//json += "\"CHECKED_TIME\":\"" + _df.format(item._checkedTime) + "\"";
		return json + "}";
	}

	String getGiftList()
	{
		java.util.Date fromDate = new java.util.Date(System.currentTimeMillis());
		java.util.Date toDate = new java.util.Date(System.currentTimeMillis() - (_nDays * DAY_IN_MS));
		String str = "";

		List<Gift> list;
		Iterator iterator;
		Gift item;

		list = UserDB.getGiftList();
		iterator = list.iterator();

		while (iterator.hasNext())
		{
			item = (Gift) iterator.next();
			str += toJSON(item) + ",";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}

		return str;
	}

	String getRentalList()
	{
		java.util.Date fromDate = new java.util.Date(System.currentTimeMillis());
		java.util.Date toDate = new java.util.Date(System.currentTimeMillis() - (_nDays * DAY_IN_MS));
		String str = "";

		List<Rental> list;
		Iterator iterator;
		Rental item;

		list = UserDB.getRentalList();
		iterator = list.iterator();

		while (iterator.hasNext())
		{
			item = (Rental) iterator.next();
			str += toJSON(item) + ",";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}

		return str;
	}

	String getEventJson(java.util.Date date, String eventName, java.util.Date fromDate, java.util.Date toDate)
	{
		String str = "";
		DateFormat df = new SimpleDateFormat("yyyy.MM.dd");

		if (date == null)
		{
			return "";
		}
		/*
		UserDB.PrintLog("@@@@@@@@@@@@@@@@@@@@@@@@@@@ date:" + df.format(date));
		UserDB.PrintLog("from:" + df.format(fromDate));
		UserDB.PrintLog("to:" + df.format(toDate));
		UserDB.PrintLog("date.compareTo(fromDate):" + date.compareTo(fromDate));
		UserDB.PrintLog("date.compareTo(toDate):" + date.compareTo(toDate));
		*/
		if ((date.compareTo(fromDate) >= 0) && (date.compareTo(toDate) <= 0))
		{
			str = "{\"DATE\":\"" + df.format(date) + "\",\"EVENT\":\"" + eventName + "\"},";
		}

		return str;
	}

	String getCustomerEvents(Customer item, java.util.Date fromDate, java.util.Date toDate)
	{
		String str = "";

		str += getEventJson(item._expectedDate, "출산예정일", fromDate, toDate);
		str += getEventJson(item._operationDate, "수술일", fromDate, toDate);
		str += getEventJson(item._babyBirth, "출산일", fromDate, toDate);
		str += getEventJson(item._rentalBegin, "대여시작", fromDate, toDate);
		str += getEventJson(item._rentalEnd, "대여종료", fromDate, toDate);
		str += getEventJson(item._rentalDeliveryPayed, "택배비입금", fromDate, toDate);
		str += getEventJson(item._rentalPayed, "대여료입금", fromDate, toDate);
		str += getEventJson(item._giftSent1, "선물1발송", fromDate, toDate);
		str += getEventJson(item._giftSent2, "선물2발송", fromDate, toDate);
		str += getEventJson(item._terminalBegin, "단말기대여시작", fromDate, toDate);
		str += getEventJson(item._terminalEnd, "단말기대여종료", fromDate, toDate);
		str += getEventJson(item._created, "계정생성일", fromDate, toDate);

		List<CustomerService> list = UserDB.getCustomerServiceList(item._index);
		Iterator iterator = list.iterator();

		while (iterator.hasNext())
		{
			CustomerService svc = (CustomerService)iterator.next();
			str += getEventJson(svc._serviceStart, "서비스시작", fromDate, toDate);
			str += getEventJson(svc._serviceEnd, "서비스종료", fromDate, toDate);
			str += getEventJson(svc._careChange, "관리시작/변경", fromDate, toDate);
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}

		return str;
	}

	String getCustomersMilestone(java.util.Date fromDate, java.util.Date toDate)
	{
		List<Customer> list = UserDB.getCustomerList();
		Iterator iterator = list.iterator();
		String str = "";

		while (iterator.hasNext())
		{
			Customer item = (Customer)iterator.next();
			if (item._valid == 0)
			{
				continue;
			}
			//UserDB.PrintLog("PARAM:" + _branchIndex);
			if (_branchIndex != -2)
			{
				if (_branchIndex != item._branchIndex)
				{
					continue;
				}
			}
			str += "{";
			str += "\"BRANCH\":\"" + UserDB.getBranch(item) + "\",";
			str += "\"NAME\":\"" + item._name + "\",";
			str += "\"EVENTS\":[" + getCustomerEvents(item, fromDate, toDate) + "]";
			str += "},";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}

		return str;
	}

	String onMilestone()
	{
		java.util.Date today = new java.util.Date(System.currentTimeMillis());
		java.util.Date fromDate = new java.util.Date(System.currentTimeMillis() - (6 * DAY_IN_MS));
		java.util.Date toDate = new java.util.Date(System.currentTimeMillis() + (8 * DAY_IN_MS));
		java.util.Date date;
		DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
		String str = "";

		str += "{" +
					"\"DATES\":[";
		for (int day = -5; day < 7; day++)
		{
			date = new java.util.Date(System.currentTimeMillis() + (day * DAY_IN_MS));
			str += "{" +
					"\"IS_TODAY\":" + ((day == 0) ? "true" : "false") + "," + 
					"\"DATE\":\"" + df.format(date) + "\"" + 
				"},";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}
		str += "]," +
			"\"CUSTOMERS\":[" + getCustomersMilestone(fromDate, toDate) + "]" + 
		"}";

		return str;
	}

	int _memberIndex = -1;
	boolean _isDone = false;
	String _result = "";
	String _command = "NONE";
	HttpServletRequest _request = null;

	int _branchIndex = -1;
	int _noticeIndex = -1;
	int _nDays = -1;
	//PaymentHistory _item = null;

	public boolean HandleRequest()
	{
		String ret;

		if (_request.getParameter("DASH") != null)
		{
			_command = "DASH";
			_result = "{\"DASH\":" + onDash() + "}";
			_isDone = true;
		}
		else if (_request.getParameter("ADD") != null)
		{
			_command = "ADD";
			_result = onAdd();
			_isDone = true;
		}
		else if (_request.getParameter("NOTICE_LIST") != null)
		{
			_command = "NOTICE_LIST";
			_result = onNoticeList();
			_isDone = true;
		}
		else if (_request.getParameter("ADD_NOTICE") != null)
		{
			_command = "ADD_NOTICE";
			_result = onAddNotice();
			_isDone = true;
		}
		else if (_request.getParameter("GET_NOTICE") != null)
		{
			_command = "GET_NOTICE";
			_result = onGetNotice();
			_isDone = true;
		}

		else if (_request.getParameter("MILESTONE") != null)
		{
			_command = "MILESTONE";
			_result = onMilestone();
			_isDone = true;
		}
		else if (_request.getParameter("ADD_SCHEDULE") != null)
		{
			_command = "ADD_SCHEDULE";
			_result = onAddSchedule();
			_isDone = true;
		}
		else if (_request.getParameter("GET_SCHEDULE") != null)
		{
			_command = "GET_SCHEDULE";
			_result = onGetSchedule();
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
		else if (_request.getParameter("DELETE") != null)
		{
			_command = "DELETE";
			_result = onDelete();
			_isDone = true;
		}
		*/
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

	public String onDash()
	{
		String str;

		str = "{" +
					"\"ORDER_COUNTS\":" + getOrderCounts() + "," +
					"\"CONSULT_STATS\":" + getConsultStats() + "," +
					"\"GIFT_LIST\":[" + getGiftList() + "]," +
					"\"RENTAL_LIST\":[" + getRentalList() + "]," +
					"\"STATUS\":" + getStatus() +
				"}";

		return str;
	}

	public String onGetNotice()
	{
		String str;

		str = "{" +
					"\"NOTICE\":" + toJSON(UserDB.getNotice(_noticeIndex)) +
				"}";

		return str;
	}

	public String onNoticeList()
	{
		List<NoticeHeader> headers = UserDB.getNoticeHeaderList();
		NoticeHeader item;
		//DateFormat df = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
		String str;

		//access via Iterator
		str = "";
		Iterator iterator = headers.iterator();
		if (iterator.hasNext())
		{
			item = (NoticeHeader) iterator.next();
			str = toJSON(item);
		}

		while (iterator.hasNext())
		{
			item = (NoticeHeader) iterator.next();
			str += ", " + toJSON(item);
		}

		str = "[\n" +
					str +
				"]\n";

		return str;
		/*
		while (iterator.hasNext())
		{
			NoticeHeader header = (NoticeHeader) iterator.next();
			String s = "{";
			s += "<td>" + header.getIndex() + "</td>";
			s += "<td>" + header.getName() + "</td>";
			s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
			s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
			s += "</tr>\n";
			out.write(s);
		}
		/*
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
		*/
		//return "";
	}

	public String onAddNotice()
	{
		UserDB.writeNotice(_memberIndex, _title, _contents);
		return "\"OK\"";
	}

	public String onAdd()
	{
		//UserDB.updatePaymentHistory(_item);
		return "";
	}

	public String onAddSchedule()
	{
		//UserDB.updatePaymentHistory(_item);
		Schedule sched = new Schedule();
		sched._member = _memberIndex;
		sched._contents = _contents;
		sched._sharedMembers = _schedReceiver;
		sched._scheduledTime = _schedDate;
		UserDB.updateSchedule(sched);

		return "\"OK\"";
	}

	public String onGetSchedule()
	{
		List<Schedule> list;
		String str;
		String temp = "";
		Iterator iterator;
		Schedule item;

		str = "{\"SCHEDULE_LIST\":[";
		list = UserDB.getScheduleList_Member(_memberIndex, true, _schedDate);
		iterator = list.iterator();
		while (iterator.hasNext())
		{
			Schedule sched = (Schedule)iterator.next();

			temp += toJSON(sched) + ",";
		}

		list = UserDB.getScheduleList_Member(_memberIndex, false, _schedDate);
		iterator = list.iterator();
		while (iterator.hasNext())
		{
			Schedule sched = (Schedule)iterator.next();

			temp += toJSON(sched) + ",";
		}

		if (temp.length() > 0)
		{
			temp = temp.substring(0, temp.length() - 1); // To remove last comma
		}

		str += temp + "]}";
		//UserDB.PrintLog("***************************************" + str);

		return str;
	}

	private String _title = "";
	private String _contents = "";
	//private int _member = -1;
	private String _schedReceiver = "";
	private Timestamp _schedDate = null;
	private int _sharedType = -2; // -2 : SCHEDULE_RECEIVER_INIT (Not shared), -1 : SCHEDULE_RECEIVER_ALL (Shared to all), ... (shared to xxx)

	public boolean onParameter(String name, String val)
	{
		boolean bRet = true;

		if (name.equals("DAYS"))
		{
			_nDays = Integer.parseInt(val);
			//_item._customerIndex = Integer.parseInt(val);
		}

		else if (name.equals("SCHEDULE_RECEIVER"))
		{
			_schedReceiver = "(" + val + ")";
			//_item._serviceType = val;
		}
		else if (name.equals("SHARED_TYPE"))
		{
			_sharedType = Integer.parseInt(val);
			//_item._serviceType = val;
		}
		else if (name.equals("SCHEDULED_TIME"))
		{
			_schedDate = Utils.convStringToTimestamp(val);
			//_item._paymentType = val;
		}
		else if (name.equals("MEMBER"))
		{
			_memberIndex = Integer.parseInt(val);
			//_item._payedCost = Long.parseLong(val);
		}
		else if (name.equals("SCHEDULE_CONTENTS"))
		{
			//_item._paymentType = val;
			//_contents = Integer.parseInt(val);
			_contents = val;
		}

		else if (name.equals("BRANCH_INDEX"))
		{
			//_item._memberIndex = Integer.parseInt(val);
			//UserDB.PrintLog("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + val);
			_branchIndex = Integer.parseInt(val);
		}
		else if (name.equals("NOTICE_INDEX"))
		{
			//_item._memberIndex = Integer.parseInt(val);
			_noticeIndex = Integer.parseInt(val);
		}

		else if (name.equals("TITLE"))
		{
			//_item._paymentType = val;
			//_contents = Integer.parseInt(val);
			_title = val;
		}
		else if (name.equals("CONTENTS"))
		{
			//_item._paymentType = val;
			//_contents = Integer.parseInt(val);
			_contents = val;
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
		/*
		if ((String)_request.getParameter("INDEX") != null)
		{
			_index = Integer.parseInt((String)_request.getParameter("INDEX"));
			_item = UserDB.getPaymentHistory(_index);
		}
		if (_item == null)
		{
			_item = new PaymentHistory();
		}
		*/
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
		//UserDB.PrintLog(">>>>>>>>>>>>>>>>>>> Param>" + name + ":" + val);
		if (val == null) val = "";

		onParameter(name, val);
	}

	HandleRequest();

	UserDB.PrintLog(_result);
	out.write(_result);
%>
