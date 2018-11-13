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

/*
	String getOrderCounts()
	{
		String json = "{";
		Calendar from = getCalendar(-_nDays, true);
		Calendar to = getCalendar(1, false);
		String where1;

		where1 = "(" + Utils.convTimeToSQL(from) + " < SERVICE_END AND " + Utils.convTimeToSQL(to) + " > SERVICE_END)";

		json += "\"DEPOSIT_STANDBY\":" + getRecordCount("CUSTOMER_SERVICE", where1) + ",";
		json += "\"DEPOSIT_DONE\":" + (_nDays + 2) + ",";
		json += "\"CONTRACT_CANCEL\":" + 0 + ",";
		json += "\"REFUND_DONE\":" + 0 + ",";
		json += "\"SERVICE_STANDBY\":" + (_nDays + 5) + ",";
		json += "\"IN_SERVICE\":" + (_nDays + 6) + ",";
		json += "\"SERVICE_EXTENDED\":" + (_nDays + 7) + ",";
		json += "\"SERVICE_DONE\":" + getRecordCount("CUSTOMER_SERVICE", where1) + "";
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
*/

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

	private Calendar _beginDate = null;
	private Calendar _endDate = null;


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


	int _memberIndex = -1;
	boolean _isDone = false;
	String _result = "";
	String _command = "NONE";
	HttpServletRequest _request = null;

	int _branchIndex = -1;
	//PaymentHistory _item = null;

	int _refundVal = 0;
	String _refundComplete = "";
	Timestamp _refundDate;
	int _customerIndex = -1;

	public int cancelContract()
	{
		String sql = "";
		ResultSet rs;
		boolean isUpdate = false;

		sql = "update CUSTOMER set VALID = 0, CANCELED = NOW() where CUSTOMER_INDEX = " + _customerIndex;

		DBPool.sendQuery(sql);

		sql = "select * from PAYMENT_HISTORY where SERVICE_TYPE = 'refund' and CUSTOMER_INDEX = " + _customerIndex;
		rs = DBPool.getResultSet(sql);
		if (UserDB.getNext(rs))
		{
			isUpdate = true;
		}

		DBPool.removeDBObject(rs);

		if (isUpdate)
		{
			sql = "update PAYMENT_HISTORY set PAYMENT_TYPE = '" + _refundComplete + "', PAYED_COST = " + _refundVal + ", MEMBER_INDEX = " + _memberIndex + ", CHECKED_TIME = " + Utils.convTimeToSQL(_refundDate) + " where SERVICE_TYPE = 'refund' and CUSTOMER_INDEX = " + _customerIndex;
		}
		else
		{
			sql = "insert into PAYMENT_HISTORY (CUSTOMER_INDEX, SERVICE_TYPE, PAYMENT_TYPE, PAYED_COST, MEMBER_INDEX, CHECKED_TIME) values (" + _customerIndex + ", 'refund', '" + _refundComplete + "', " + _refundVal + ", " + _memberIndex + ", " + Utils.convTimeToSQL(_refundDate) + ")";
		}

		DBPool.sendQuery(sql);

		return 123;
	}

	public int modifyRefund()
	{
		String sql = "";

		sql = "update PAYMENT_HISTORY set PAYMENT_TYPE = '" + _refundComplete + "', PAYED_COST = " + _refundVal + ", MEMBER_INDEX = " + _memberIndex + ", CHECKED_TIME = " + Utils.convTimeToSQL(_refundDate) + " where SERVICE_TYPE = 'refund' and CUSTOMER_INDEX = " + _customerIndex;

		DBPool.sendQuery(sql);

		return 123;
	}

	public boolean HandleRequest()
	{
		String ret;

		if (_request.getParameter("STATISTICS") != null)
		{
			_command = "STATISTICS";
			String stats = getDailyStats();
			_result = "{" +
					"\"SALES\":" + getSales() + "," +
					"\"CONTRACT\":" + getContractCount() + "," +
					"\"EXTENDED\":" + getExtendedCount() + "," +
					"\"RANKING\":" + getRanking() + "," +
					"\"DAILY\":" + stats + "," +
					"\"DUMMY\":" + 0 + "" +
				"}";
			_isDone = true;
		}
		else if (_request.getParameter("CANCEL_CONTRACT") != null)
		{
			_command = "CANCEL_CONTRACT";
			_result = "{" +
					"\"DUMMY\":" + cancelContract() + "" +
				"}";
			_isDone = true;
		}
		else if (_request.getParameter("MODIFY_REFUND") != null)
		{
			_command = "MODIFY_REFUND";
			_result = "{" +
					"\"DUMMY\":" + modifyRefund() + "" +
				"}";
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

	public String getSales()
	{
		String str;
		long hq = 0;
		long branch = 0;

		Iterator iter = _lstStats.iterator();
		while (iter.hasNext())
		{
			Stats obj = (Stats)iter.next();
			if (obj._branchIndex == -1)
			{
				hq += obj._sales;
			}
			else
			{
				branch += obj._sales;
			}
		}
		str = "{" +
					"\"HQ\":" + hq + "," +
					"\"BRANCH\":" + branch + "," +
					"\"TOTAL\":" + (hq + branch) +
				"}";

		return str;
	}

	public String getContractCount()
	{
		String str;
		long hq = 0;
		long branch = 0;

		Iterator iter = _lstStats.iterator();
		while (iter.hasNext())
		{
			Stats obj = (Stats)iter.next();
			if (obj._branchIndex == -1)
			{
				hq += obj._contract;
			}
			else
			{
				branch += obj._contract;
			}
		}
		str = "{" +
					"\"HQ\":" + hq + "," +
					"\"BRANCH\":" + branch + "," +
					"\"TOTAL\":" + (hq + branch) +
				"}";

		return str;
	}

	public String getExtendedCount()
	{
		String str;
		long hq = 0;
		long branch = 0;

		Iterator iter = _lstStats.iterator();
		while (iter.hasNext())
		{
			Stats obj = (Stats)iter.next();
			if (obj._branchIndex == -1)
			{
				hq += obj._extended;
			}
			else
			{
				branch += obj._extended;
			}
		}
		str = "{" +
					"\"HQ\":" + hq + "," +
					"\"BRANCH\":" + branch + "," +
					"\"TOTAL\":" + (hq + branch) +
				"}";

		return str;
	}

	class BranchInfo
	{
		public int _index = -1;
		public String _name = "";
		public long _sales = 0;

		public BranchInfo(int index, String name)
		{
			this._index = index;
			this._name = name;
			this._sales = 0;
		}

		public long getSales()
		{
			return this._sales;
		}

		public String toJSON()
		{
			return "{" +
					"\"INDEX\":" + this._index + "," +
					"\"NAME\":\"" + this._name + "\"," +
					"\"SALES\":" + this._sales + "" +
				"}";
		}
	}

	class SortBySales implements Comparator<BranchInfo> 
	{ 
		// Used for sorting in ascending order of 
		// roll number 
		public int compare(BranchInfo a, BranchInfo b)
		{
			return a._sales > b._sales ? -1 : (a._sales < b._sales ? 1 : 0); // descending order
		} 
	}

	List<BranchInfo> _infos;
	BranchInfo getBranchInfo(int index, String name)
	{
		Iterator iter = _infos.iterator();
		while (iter.hasNext())
		{
			BranchInfo obj = (BranchInfo)iter.next();
			if (obj._index == index)
			{
				return obj;
			}
		}

		BranchInfo obj = new BranchInfo(index, name);
		_infos.add(obj);
		return obj;
	}

	public String getRanking()
	{
		_infos = new ArrayList<BranchInfo>();
		/*
		infors = Arrays.asList(
			new BranchInfo(0, "Roma", 100),
			new BranchInfo(1, "Berlin", 200),
			new BranchInfo(2, "London", 150),
			new BranchInfo(3, "Paris", 70)
			);
		*/
		String str;

		Iterator iter;
		iter = _lstStats.iterator();
		while (iter.hasNext())
		{
			Stats obj = (Stats)iter.next();
			BranchInfo info = getBranchInfo(obj._branchIndex, obj._branchName);
			info._sales += obj._sales;
		}
		Collections.sort(_infos, new SortBySales());
		//infos.add(new BranchInfo(4, "Barcelona", 700));
		//_infos.sort(Comparator.comparing(BranchInfo::getSales).reversed());
		str = "";
		iter = _infos.iterator();
		while (iter.hasNext())
		{
			BranchInfo i = (BranchInfo)iter.next();
			str += i.toJSON() + ",";
		}
		if (str.length() > 0)
		{
			str = str.substring(0, str.length() - 1); // To remove last comma
		}

		return "[" + str + "]";
	}

	class Stats
	{
		public String _date;
		public int _branchIndex;
		public String _branchName;
		public String _name;
		public int _contract;
		public int _canceled;
		public int _extended;
		public int _consult;
		public int _inService;
		public int _completed;
		public int _sales;
		public int _voucher;
		public int _discount;
		public int _refund;

		public Stats(String date, int branchIndex, String branchName, String name)
		{
			this._date = date;
			this._branchIndex = branchIndex;
			this._branchName = branchName;
			this._name = name;
			this._contract = 0;
			this._canceled = 0;
			this._extended = 0;
			this._consult = 0;
			this._inService = 0;
			this._completed = 0;
			this._sales = 0;
			this._voucher = 0;
			this._discount = 0;
			this._refund = 0;
		}

		public String toJSON()
		{
			String ret = "";

			ret += "{";
			ret += "\"DATE\":\"" + this._date + "\"";
			ret += ",\"BRANCH\":\"" + this._branchName + "\"";
			ret += ",\"MEMBER\":\"" + this._name + "\"";
			ret += ",\"CONTRACT\":" + this._contract;
			ret += ",\"EXTENDED\":" + this._extended;
			ret += ",\"CANCELED\":" + this._canceled;
			ret += ",\"CONSULT\":" + this._consult;
			ret += ",\"IN_SERVICE\":" + this._inService;
			ret += ",\"COMPLETED\":" + this._completed;
			ret += ",\"SALES\":" + this._sales;
			ret += ",\"VOUCHER\":" + this._voucher;
			ret += ",\"DISCOUNT\":" + this._discount;
			ret += ",\"REFUND\":" + this._refund;
			ret += "}";
			return ret;
		}
	}

	private List<Stats> _lstStats;
	public Stats getStatsObject(String date, int branchIndex)
	{
		Iterator iter = _lstStats.iterator();
		while (iter.hasNext())
		{
			Stats obj = (Stats)iter.next();
			if (obj._date.equals(date) && (obj._branchIndex == branchIndex))
			{
				return obj;
			}
		}
		return null;
	}

	public Stats addNewObject(String date, int branchIndex, String branchName, String name)
	{
		Stats o = new Stats(date, branchIndex, branchName, name);
		_lstStats.add(o);

		return o;
	}

	private List<String> buildDateList()
	{
		List<String> lst = new ArrayList<String>();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar endDate = _endDate;

		if ((_beginDate == null) || (_endDate == null))
		{
			return lst;
		}
		endDate.add(Calendar.DAY_OF_MONTH, 1);
		for (Calendar day = _beginDate; day.before(_endDate); day.add(Calendar.DAY_OF_MONTH, 1))
		{
			lst.add(df.format(Utils.convCalendarToTimestamp(day)));
		}

		return lst;
	}

	public String getDailyStats()
	{
		String sql = "";
		int count = -1;
		ResultSet rs = null;
		long val = 0;
		String tval = null;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String ret = "";

		int branchIndex;
		long sales = 0;
		Stats obj = null;

		_lstStats = new ArrayList<Stats>();

		List<String> days = buildDateList();
		Iterator iter = days.iterator();
		while (iter.hasNext())
		{
			//ret += (String)iter.next() + "/";
			String day = (String)iter.next();

			//////////////////////////////////////
			// HQ

			sql = "select DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d') as _DATE" +
				", pay.PAYED_COST as _SALES" +
				//", r.NAME as _BRANCH_NAME" +
				//", m.BUSINESS as _MEMBER_NAME" +
				", cus.BRANCH_INDEX as _BRANCH_INDEX" +
				", pay.SERVICE_TYPE as _SERVICE_TYPE" +
				", pay.PAYMENT_TYPE as _PAYMENT_TYPE" +
				" from PAYMENT_HISTORY as pay inner join CUSTOMER as cus on pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX" +
				//" inner join BRANCH as b on cus.BRANCH_INDEX = b.BRANCH_INDEX" +
				//" inner join REGION as r on b.REGION_INDEX = r.REGION_INDEX" +
				//" inner join MEMBER as m on b.MEMBER_INDEX = m.MEMBER_INDEX" +
					" where cus.VALID = 1" +
					" and cus.BRANCH_INDEX = -1" +
					//" and pay.SERVICE_TYPE <> 'discount'" +
					" and '" + day + "' = DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d')";

			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				try {
					//date = rs.getString("_DATE") + "\"";
					branchIndex = rs.getInt("_BRANCH_INDEX");
					obj = getStatsObject(day, branchIndex);
					if (obj == null)
					{
						// add new object
						obj = addNewObject(day, branchIndex, "본사", "본사");
					}
					String serviceType = rs.getString("_SERVICE_TYPE");
					String paymentType = rs.getString("_PAYMENT_TYPE");
					if (serviceType.equals("discount"))
					{
						obj._discount += rs.getLong("_SALES");
						continue;
					}
					if (paymentType.equals("deposit"))
					{
						obj._contract ++;
						if (!serviceType.equals("basic"))
						{
							obj._extended ++;
						}
					}
					obj._sales += rs.getLong("_SALES");
				} catch (SQLException e) {
					UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
				}
			}

			DBPool.removeDBObject(rs);

			// Voucher
			sql = "select " +
				" cus.TOTAL_VOUCHER as _SALES" +
				" from CUSTOMER as cus" +
				" inner join CUSTOMER_SERVICE as svc on cus.CUSTOMER_INDEX = svc.CUSTOMER_INDEX" +
				//" inner join REGION as r on b.REGION_INDEX = r.REGION_INDEX" +
				//" inner join MEMBER as m on b.MEMBER_INDEX = m.MEMBER_INDEX" +
					" where cus.VALID = 1" +
					" and cus.BRANCH_INDEX = -1" +
					" and '" + day + "' = DATE_FORMAT(svc.SERVICE_START, '%Y-%m-%d')";

			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				try {
					//date = rs.getString("_DATE") + "\"";
					branchIndex = -1;//rs.getInt("_BRANCH_INDEX");
					obj = getStatsObject(day, branchIndex);
					if (obj == null)
					{
						// add new object
						obj = addNewObject(day, branchIndex, "본사", "본사");
					}
					obj._voucher += rs.getLong("_SALES");
				} catch (SQLException e) {
					UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
				}
			}

			DBPool.removeDBObject(rs);

			// Refund
			sql = "select " +
				" pay.PAYED_COST as _SALES" +
				" from PAYMENT_HISTORY as pay" +
				" inner join CUSTOMER as cus on cus.CUSTOMER_INDEX = pay.CUSTOMER_INDEX" +
				//" inner join REGION as r on b.REGION_INDEX = r.REGION_INDEX" +
				//" inner join MEMBER as m on b.MEMBER_INDEX = m.MEMBER_INDEX" +
					" where cus.VALID = 0" +
					" and pay.SERVICE_TYPE = 'refund'" +
					" and cus.BRANCH_INDEX = -1" +
					" and '" + day + "' = DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d')";

			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				try {
					//date = rs.getString("_DATE") + "\"";
					branchIndex = -1;//rs.getInt("_BRANCH_INDEX");
					obj = getStatsObject(day, branchIndex);
					if (obj == null)
					{
						// add new object
						obj = addNewObject(day, branchIndex, "본사", "본사");
					}
					obj._refund += rs.getLong("_SALES");
				} catch (SQLException e) {
					UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
				}
			}

			DBPool.removeDBObject(rs);

			//////////////////////////////////////
			// Branch

			sql = "select DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d') as _DATE" +
				", pay.PAYED_COST as _SALES" +
				", r.NAME as _BRANCH_NAME" +
				", m.BUSINESS as _MEMBER_NAME" +
				", b.BRANCH_INDEX as _BRANCH_INDEX" +
				", pay.SERVICE_TYPE as _SERVICE_TYPE" +
				", pay.PAYMENT_TYPE as _PAYMENT_TYPE" +
				" from PAYMENT_HISTORY as pay inner join CUSTOMER as cus on pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX" +
				" inner join BRANCH as b on cus.BRANCH_INDEX = b.BRANCH_INDEX" +
				" inner join REGION as r on b.REGION_INDEX = r.REGION_INDEX" +
				" inner join MEMBER as m on b.MEMBER_INDEX = m.MEMBER_INDEX" +
					" where cus.VALID = 1" +
					//" and pay.SERVICE_TYPE <> 'discount'" +
					" and '" + day + "' = DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d')";

			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				try {
					//date = rs.getString("_DATE") + "\"";
					branchIndex = rs.getInt("_BRANCH_INDEX");
					obj = getStatsObject(day, branchIndex);
					if (obj == null)
					{
						// add new object
						obj = addNewObject(day, branchIndex, rs.getString("_BRANCH_NAME"), rs.getString("_MEMBER_NAME"));
					}
					String serviceType = rs.getString("_SERVICE_TYPE");
					String paymentType = rs.getString("_PAYMENT_TYPE");
					if (serviceType.equals("discount"))
					{
						obj._discount += rs.getLong("_SALES");
						continue;
					}
					if (paymentType.equals("deposit"))
					{
						obj._contract ++;
						if (!serviceType.equals("basic"))
						{
							obj._extended ++;
						}
					}
					obj._sales += rs.getLong("_SALES");
				} catch (SQLException e) {
					UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
				}
			}

			DBPool.removeDBObject(rs);

			// Voucher
			sql = "select " +
				" cus.TOTAL_VOUCHER as _SALES" +
				", r.NAME as _BRANCH_NAME" +
				", m.BUSINESS as _MEMBER_NAME" +
				", b.BRANCH_INDEX as _BRANCH_INDEX" +
				" from CUSTOMER as cus" +
				" inner join CUSTOMER_SERVICE as svc on cus.CUSTOMER_INDEX = svc.CUSTOMER_INDEX" +
				" inner join BRANCH as b on cus.BRANCH_INDEX = b.BRANCH_INDEX" +
				" inner join REGION as r on b.REGION_INDEX = r.REGION_INDEX" +
				" inner join MEMBER as m on b.MEMBER_INDEX = m.MEMBER_INDEX" +
					" where cus.VALID = 1" +
					" and '" + day + "' = DATE_FORMAT(svc.SERVICE_START, '%Y-%m-%d')";

			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				try {
					//date = rs.getString("_DATE") + "\"";
					branchIndex = rs.getInt("_BRANCH_INDEX");
					obj = getStatsObject(day, branchIndex);
					if (obj == null)
					{
						// add new object
						obj = addNewObject(day, branchIndex, rs.getString("_BRANCH_NAME"), rs.getString("_MEMBER_NAME"));
					}
					obj._voucher += rs.getLong("_SALES");
				} catch (SQLException e) {
					UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
				}
			}

			DBPool.removeDBObject(rs);

			// Refund
			sql = "select " +
				" pay.PAYED_COST as _SALES" +
				", r.NAME as _BRANCH_NAME" +
				", m.BUSINESS as _MEMBER_NAME" +
				", b.BRANCH_INDEX as _BRANCH_INDEX" +
				" from PAYMENT_HISTORY as pay" +
				" inner join CUSTOMER as cus on cus.CUSTOMER_INDEX = pay.CUSTOMER_INDEX" +
				" inner join BRANCH as b on cus.BRANCH_INDEX = b.BRANCH_INDEX" +
				" inner join REGION as r on b.REGION_INDEX = r.REGION_INDEX" +
				" inner join MEMBER as m on b.MEMBER_INDEX = m.MEMBER_INDEX" +
					" where cus.VALID = 0" +
					" and pay.SERVICE_TYPE = 'refund'" +
					" and '" + day + "' = DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d')";

			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				try {
					//date = rs.getString("_DATE") + "\"";
					branchIndex = rs.getInt("_BRANCH_INDEX");
					obj = getStatsObject(day, branchIndex);
					if (obj == null)
					{
						// add new object
						obj = addNewObject(day, branchIndex, rs.getString("_BRANCH_NAME"), rs.getString("_MEMBER_NAME"));
					}
					obj._refund += rs.getLong("_SALES");
				} catch (SQLException e) {
					UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
				}
			}

			DBPool.removeDBObject(rs);
		}

		// TODO: make json string.
		iter = _lstStats.iterator();
		while (iter.hasNext())
		{
			obj = (Stats)iter.next();
			if ((_branchIndex != -2) && (_branchIndex != obj._branchIndex))
			{
				continue;
			}
			ret += obj.toJSON() + ",";
		}
		if (ret.length() > 0)
		{
			ret = ret.substring(0, ret.length() - 1); // To remove last comma
		}

		return "[" + ret + "]";
	}
/*
	public String onNoticeList()
	{
		List<NoticeHeader> headers = UserDB.getNoticeHeaderList();
		NoticeHeader item;
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
*/
	private String _title = "";
	private String _contents = "";
	//private int _member = -1;
	private String _schedReceiver = "";
	private Timestamp _schedDate = null;
	private int _sharedType = -2; // -2 : SCHEDULE_RECEIVER_INIT (Not shared), -1 : SCHEDULE_RECEIVER_ALL (Shared to all), ... (shared to xxx)

	public boolean onParameter(String name, String val)
	{
		DateFormat df = new SimpleDateFormat("MM-dd-yyyy");
		boolean bRet = true;

		if (name.equals("PERIOD_BEGIN"))
		{
			_beginDate = Utils.convStringToCalendar(val, "yyyy-MM-dd");
			//_beginDate = new GregorianCalendar();
			//_beginDate.setTime(df.parse(val));
			//_item._customerIndex = Integer.parseInt(val);
		}

		else if (name.equals("PERIOD_END"))
		{
			_endDate = Utils.convStringToCalendar(val, "yyyy-MM-dd");
			//_endDate = new GregorianCalendar();
			//_endDate.setTime(df.parse(val));
			//_item._serviceType = val;
		}
		else if (name.equals("BRANCH"))
		{
			_branchIndex = Integer.parseInt(val);
			//_item._serviceType = val;
		}

/////////////////
		else if (name.equals("REFUND_DATE"))
		{
			_refundDate = Utils.convStringToTimestamp(val);
		}
		else if (name.equals("MEMBER"))
		{
			_memberIndex = Integer.parseInt(val);
			//_item._payedCost = Long.parseLong(val);
		}
		else if (name.equals("CUSTOMER"))
		{
			_customerIndex = Integer.parseInt(val);
		}

		else if (name.equals("REFUND_VALUE"))
		{
			//_item._memberIndex = Integer.parseInt(val);
			_refundVal = Integer.parseInt(val);
		}
		else if (name.equals("REFUND_COMPLETE"))
		{
			_refundComplete = val;
		}

		return bRet;
	}

%>

<%
	Enumeration params = request.getParameterNames();
	_request = request;

	UserDB.PrintLog("API for gift");
	//getItem();

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
