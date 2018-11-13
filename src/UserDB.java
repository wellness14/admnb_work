package wellness;

import org.apache.log4j.Logger;
import java.sql.*;
import java.util.*;

public class UserDB
{
	/*
	private static final String _databaseServerAddr = "localhost";
	private static final String _databaseServerDB = "wellness";
	private static final int _databaseServerPort = 3306;

	private static String getDatabaseDriver()
	{
		return "jdbc:mysql://" + _databaseServerAddr + ":" + _databaseServerPort +
			"/" + _databaseServerDB + "?" +
			"useUnicode=true&characterEncoding=utf8";
	}

	public static Connection getConnection()
	{
		String jdbcDrv = getDatabaseDriver();
		String user = "wellness";
		String pwd = "wellnesspwd";

		Connection connection = DriverManager.getConnection(jdbcDrv, user, pwd);

		return connection;
	}
	*/

	final static Logger logger = Logger.getLogger(UserDB.class);

	//private List<UserInfo> _infos;
	private Member _curUser;

/*
	public static ResultSet getSelectRS(String sql)
	{
		Connection connection = getConnection();
		Statement statement = connection.createStatement();

		return statement.executeQuery(sql);
	}

	public static void releaseSelectRS()
	{
	}
*/
	public void setCurrentUser(Member user)
	{
		this._curUser = user;
	}

	public Member getCurrentUser()
	{
		return this._curUser;
	}

	/*
	public List<Member> getUserInfoList()
	{
		return this._infos;
	}
	*/

	//private Connection _connection = null;
	//private Statement _statement = null;

/*
	public Statement getStatement() throws SQLException
	{
		String jdbcDrv = "jdbc:mysql://localhost:3306/wellness?" +
			"useUnicode=true&characterEncoding=utf8";
		String user = "wellness";
		String pwd = "wellnesspwd";

		releaseStatement();
		this._connection = DriverManager.getConnection(jdbcDrv, user, pwd);
		this._statement = this._connection.createStatement();

		return this._statement;
	}

	public void releaseStatement()
	{
		if (this._statement != null)
		{
			try
			{
				this._statement.close();
			}
			catch (SQLException e) { }
			finally { this._statement = null; }
		}
		if (this._connection != null)
		{
			try
			{
				this._connection.close();
			}
			catch (SQLException e) { }
			finally { this._connection = null; }
		}
	}
*/

	public static boolean getNext(ResultSet rs)
	{
		boolean ret = false;
		try
		{
			ret = rs.next();
		}
		catch (SQLException e)
		{
			ret = false;
		}

		return ret;
	}

	/*
	public boolean LoadUserInfos()
	{
		ResultSet rs = null;
		UserInfo user;

		String sql = "select * from WEB_MANAGER";

		rs = DBPool.getResultSet(sql);

		this._infos = new ArrayList<UserInfo>();
		while (getNext(rs))
		{
			user = new UserInfo();
			user.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return true;
	}
	*/

	public boolean writeNotice(String title, String content)
	{
		UserInfo user;

		logger.debug("This is debug : " + title + ":" + content);
		if (this._curUser == null)
		{
			logger.debug("_user is null.");
			return false;
		}
		String sql = "insert into NOTICE (MANAGER_INDEX, TITLE, COMPOSED_DATE, CONTENT, VALID) values ("
				+ this._curUser._index + ", '" + title + "', NOW(), '" + content + "', 1)";
		logger.debug("SQL: " + sql);

		DBPool.sendQuery(sql);
		/*
		try
		{
			this.getStatement().executeUpdate(sql);
		}
		catch (SQLException e)
		{
			//out.println(e.getMessage());
			e.printStackTrace();
			return false;
		}
		finally
		{
			releaseStatement();
		}
		*/
		return true;
	}

	public List<NoticeHeader> getNoticeHeaderList()
	{
		List<NoticeHeader> lst = new ArrayList<NoticeHeader>();
		ResultSet rs = null;
		NoticeHeader header;

		String sql = NoticeHeader.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			header = new NoticeHeader();
			header.fromResultSet(rs);
			lst.add(header);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public Notice getNotice(int index)
	{
		ResultSet rs = null;
		Notice notice = null;

		String sql = "select NOTICE_INDEX, (select NAME from WEB_MANAGER where MANAGER_INDEX = NOTICE.MANAGER_INDEX) AS NAME, TITLE, CONTENT, COMPOSED_DATE from NOTICE where VALID = true and NOTICE_INDEX = " + index;
		//String sql = NoticeHeader.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			notice = new Notice();
			notice.fromResultSet(rs);
			break;
		}
		DBPool.removeDBObject(rs);

		return notice;
	}

	//private boolean _isTagsInserted = false;

	public Tags getTags()
	{
		ResultSet rs = null;
		Tags tags = null;

		String sql = Tags.getSelectSQL();
		tags = new Tags();
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			tags.fromResultSet(rs);
			//break;
		}
		else
		{
		}
		DBPool.removeDBObject(rs);

		return tags;
	}

	public void setTags(Tags tags)
	{
		DBPool.sendQuery(tags.getUpdateSQL());
	}

	public void sendMessage(String receiver, String message)
	{
		Message msg = new Message();

		msg.setSender(_curUser._id);
		msg.setReceiver(receiver);
		msg.setContent(message);

		DBPool.sendQuery(msg.getInsertSQL());
		/*
		try
		{
			this.getStatement().executeUpdate(msg.getInsertSQL());
		}
		catch (SQLException e)
		{
			//out.println(e.getMessage());
			e.printStackTrace();
			isSent = false;
		}
		finally
		{
			releaseStatement();
		}
		*/
	}

	public List<Message> getValidMessage_SentList()
	{
		List<Message> lst = new ArrayList<Message>();
		ResultSet rs = null;
		Message msg;

		String sql = Message.getSelectSQL(_curUser._id, null);
		logger.debug("UserDB::getValidMessage_SentList: " + sql);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			msg = new Message();
			msg.fromResultSet(rs);
			lst.add(msg);
		}
		DBPool.removeDBObject(rs);
		/*
		try
		{
			rs = this.getStatement().executeQuery(sql);
			while (rs.next())
			{
				msg = new Message();
				msg.fromResultSet(rs);
				lst.add(msg);
			}
		}
		catch (SQLException e)
		{
			//out.println(e.getMessage());
			e.printStackTrace();
		}
		finally
		{
			if (rs != null)
			{
				try
				{
					rs.close();
				}
				catch (SQLException e) { }
			}
			releaseStatement();
		}
		*/

		return lst;
	}

	public List<Message> getValidMessage_ReceivedList()
	{
		List<Message> lst = new ArrayList<Message>();
		ResultSet rs = null;
		Message msg;

		String sql = Message.getSelectSQL(null, _curUser._id);
		//rs = this.getStatement().executeQuery(sql);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			msg = new Message();
			msg.fromResultSet(rs);
			lst.add(msg);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public List<MomHelper> getHelperList()
	{
		List<MomHelper> lst = new ArrayList<MomHelper>();
		ResultSet rs = null;
		MomHelper header;

		String sql = MomHelper.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			header = new MomHelper();
			header.fromResultSet(rs);
			lst.add(header);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public List<ServiceOption> getServiceOptionList()
	{
		List<ServiceOption> lst = new ArrayList<ServiceOption>();
		ResultSet rs = null;
		ServiceOption option;

		String sql = ServiceOption.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			option = new ServiceOption();
			option.fromResultSet(rs);
			lst.add(option);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public void updateServiceOption(String name, String val)
	{
		/*
		String names[] = name.split("_");

		if (names.length != 3)
		{
			logger.debug("This is ERROR: " + name);
			return;
		}

		ResultSet rs = null;
		ServiceOption option = new ServiceOption();
		option._type = names[0];
		option._weekWork = names[1];
		option._amountType = names[2];
		option._amount = Integer.parseInt(val);
		*/
		ResultSet rs = null;
		ServiceOption option = new ServiceOption();
		option._type = name;
		option._cost = Integer.parseInt(val);

		String sql = option.checkExistenceSQL();
		//PrintLog(sql);
		//rs = this.getStatement().executeQuery(sql);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			// run update SQL.
			sql = option.getUpdateSQL();
		}
		else
		{
			sql = option.getInsertSQL();
		}
		DBPool.removeDBObject(rs);

		DBPool.sendQuery(sql);
	}

	public static List<Gift> getGiftList()
	{
		List<Gift> lst = new ArrayList<Gift>();
		ResultSet rs = null;
		Gift item;

		String sql = Gift.getSelectSQL();
		//rs = this.getStatement().executeQuery(sql);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Gift();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static Gift getGift(int index)
	{
		ResultSet rs = null;
		Gift item = null;

		String sql = Gift.getSelectSQL_Index(index);
		//rs = this.getStatement().executeQuery(sql);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Gift();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static void updateGift(Gift term)
	{
		ResultSet rs = null;
		Gift item = null;
		String sql;

		if (term._index == -1)
		{
			sql = term.getInsertSQL();
		}
		else
		{
			sql = term.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static void deleteGift(Gift term)
	{
		ResultSet rs = null;
		Gift item = null;
		String sql;

		if (term._index == -1)
		{
			return;
		}
		sql = Gift.getDeleteSQL(term._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}



	public static List<Rental> getRentalList()
	{
		List<Rental> lst = new ArrayList<Rental>();
		ResultSet rs = null;
		Rental item;

		String sql = Rental.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Rental();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static Rental getRental(int index)
	{
		ResultSet rs = null;
		Rental item = null;

		String sql = Rental.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Rental();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static void updateRental(Rental term)
	{
		ResultSet rs = null;
		Rental item = null;
		String sql;

		if (term._index == -1)
		{
			sql = term.getInsertSQL();
		}
		else
		{
			sql = term.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static void deleteRental(Rental term)
	{
		ResultSet rs = null;
		Rental item = null;
		String sql;

		if (term._index == -1)
		{
			return;
		}
		sql = Rental.getDeleteSQL(term._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}



	public static List<Terminal> getTerminalList()
	{
		List<Terminal> lst = new ArrayList<Terminal>();
		ResultSet rs = null;
		Terminal item;

		String sql = Terminal.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Terminal();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static Terminal getTerminal(int index)
	{
		ResultSet rs = null;
		Terminal item = null;

		String sql = Terminal.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Terminal();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static void updateTerminal(Terminal term)
	{
		ResultSet rs = null;
		Terminal item = null;
		String sql;

		if (term._index == -1)
		{
			sql = term.getInsertSQL();
		}
		else
		{
			sql = term.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static void deleteTerminal(Terminal term)
	{
		ResultSet rs = null;
		Terminal item = null;
		String sql;

		if (term._index == -1)
		{
			return;
		}
		sql = Terminal.getDeleteSQL(term._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static List<Terms> getTermsList(String type)
	{
		List<Terms> lst = new ArrayList<Terms>();
		ResultSet rs = null;
		Terms item;

		String sql = Terms.getSelectSQL_Type(type);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Terms();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public Terms getTerms(int index)
	{
		ResultSet rs = null;
		Terms item = null;

		String sql = Terms.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Terms();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public void updateTerms(Terms term)
	{
		ResultSet rs = null;
		Terms item = null;
		String sql;

		if (term._index == -1)
		{
			sql = term.getInsertSQL();
		}
		else
		{
			sql = term.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public void deleteTerms(Terms term)
	{
		ResultSet rs = null;
		Terms item = null;
		String sql;

		if (term._index == -1)
		{
			return;
		}
		sql = Terms.getDeleteSQL(term._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}


	public static Region getRegion(int index)
	{
		ResultSet rs = null;
		Region item = null;

		String sql = Region.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Region();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static List<Region> getRegionList(int upper)
	{
		List<Region> lst = new ArrayList<Region>();
		ResultSet rs = null;
		Region item;
		String sql;

		if (upper == 0)
		{
			sql = Region.getSelectSQL();
		}
		else
		{
			sql = Region.getSelectSQL(upper);
		}
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Region();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static List<Member> getMemberList()
	{
		List<Member> lst = new ArrayList<Member>();
		ResultSet rs = null;
		Member item;

		String sql = Member.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Member();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}


	public static List<Member> getMemberList_Pattern(String pattern)
	{
		List<Member> lst = new ArrayList<Member>();
		ResultSet rs = null;
		Member item;

		String sql = Member.getSelectSQL(pattern);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Member();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static Member getMember(int index)
	{
		ResultSet rs = null;
		Member item = null;

		String sql = Member.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Member();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static void deleteMember(Member item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			return;
		}
		sql = Member.getDeleteSQL(item._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static void updateMember(Member item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
		}
		else
		{
			sql = item.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public List<Branch> getBranchList()
	{
		List<Branch> lst = new ArrayList<Branch>();
		ResultSet rs = null;
		Branch item;
		String sql;

		sql = Branch.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Branch();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static Branch getBranch(int index)
	{
		String sql;
		Branch item = null;
		ResultSet rs = null;

		sql = Branch.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Branch();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public List<Branch> getBranchList(int upperRegion)
	{
		List<Branch> lst = new ArrayList<Branch>();
		ResultSet rs = null;
		Branch item;
		String sql;

		sql = Branch.getSelectSQL_UpperRegion(upperRegion);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Branch();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public void updateBranch(Branch item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
		}
		else
		{
			sql = item.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public void deleteBranch(Branch item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			return;
		}
		sql = Branch.getDeleteSQL(item._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}


	public static MomHelper getHelperItem(int index)
	{
		String sql;
		MomHelper item = null;
		ResultSet rs = null;

		sql = MomHelper.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new MomHelper();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public void updateHelper(MomHelper item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
		}
		else
		{
			sql = item.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}


	public void deleteHelper(MomHelper item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			return;
		}
		sql = MomHelper.getDeleteSQL(item._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}


/*
	public PreCustomer getPreCustomerItem(int index)
	{
		String sql;
		PreCustomer item = null;
		ResultSet rs = null;

		sql = PreCustomer.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new PreCustomer();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public int updatePreCustomer(PreCustomer item)
	{
		ResultSet rs = null;
		String sql;
		int index = -1;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
			DBPool.sendQuery(sql);

			// get max index number(assumed as lastly added index for current record)
			rs = DBPool.getResultSet("select max(PRE_CUSTOMER_INDEX) as IDX from PRE_CUSTOMER");
			if (getNext(rs))
			{
				try {
					index = rs.getInt("IDX");
				} catch (SQLException e) {}
			}
			DBPool.removeDBObject(rs);
		}
		else
		{
			sql = item.getUpdateSQL();
			DBPool.sendQuery(sql);
			index = item._index;
		}

		return index;
	}

	public void deletePreCustomer(PreCustomer item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			return;
		}
		sql = PreCustomer.getDeleteSQL(item._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}
	*/

	public static boolean isAvailableCustomerID(String id)
	{
		ResultSet rs = null;
		String sql;
		boolean isAvail = true;

		// get max index number(assumed as lastly added index for current record)
		rs = DBPool.getResultSet("select * from CUSTOMER where ID = '" + id + "'");
		if (getNext(rs))
		{
			isAvail = false;
		}
		DBPool.removeDBObject(rs);

		return isAvail;
	}

	/*
	public int signinPreCustomer(PreCustomer item)
	{
		ResultSet rs = null;
		String sql;
		int index = -1;
		Customer customer = new Customer();

		// make sure it can be a customer 
		if (item._index == -1)
		{
			return -1;
		}

		if (isAvailableCustomerID(item._id) == false)
		{
			return -2; // already registered.
		}

		customer.fromPreCustomer(item);
		sql = customer.getInsertSQL();
		DBPool.sendQuery(sql);
		//sql = item.getInsertSQL();
		//DBPool.sendQuery(sql);

		// get max index number(assumed as lastly added index for current record)
		rs = DBPool.getResultSet("select CUSTOMER_INDEX from CUSTOMER where ID='" + item._id + "'");
		if (getNext(rs))
		{
			try {
				index = rs.getInt("CUSTOMER_INDEX");
				item._indexCustomer = index;
				UserDB.PrintLog("CUSTOMER_INDEX:" + index);
			} catch (SQLException e) {}
		}
		DBPool.removeDBObject(rs);

		sql = item.getUpdateSQL();
		DBPool.sendQuery(sql);
		//sql = PreCustomer.getDeleteSQL(item._index);
		//DBPool.sendQuery(sql);

		return index;
	}
*/

	public static int makeNewCustomer(int memberIndex)
	{
		ResultSet rs = null;
		String sql;
		int index = -1;

		sql = Customer.getInsertSQL_ForDummy(memberIndex);
		DBPool.sendQuery(sql);

		sql = Customer.getSelectSQL_DescOrder(memberIndex);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			try
			{
				index = rs.getInt("CUSTOMER_INDEX");
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		DBPool.removeDBObject(rs);

		return index;
	}

	public static List<Customer> getCustomerList_Pattern(String pattern)
	{
		List<Customer> lst = new ArrayList<Customer>();
		ResultSet rs = null;
		Customer item;
		String sql;

		sql = Customer.getSelectSQL(pattern);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Customer();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static List<Customer> getCustomerList()
	{
		List<Customer> lst = new ArrayList<Customer>();
		ResultSet rs = null;
		Customer item;
		String sql;

		sql = Customer.getSelectSQL();
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new Customer();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static Customer getCustomerItem(int index)
	{
		String sql;
		Customer item = null;
		ResultSet rs = null;

		sql = Customer.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Customer();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static Customer getCustomerItem_UrlKey(String urlKey)
	{
		String sql;
		Customer item = null;
		ResultSet rs = null;

		sql = Customer.getSelectSQL_UrlKey(urlKey);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new Customer();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static int updateCustomer(Customer item)
	{
		String sql;
		int lastIndex = -1;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
			lastIndex = DBPool.sendQuery_GetLastIndex(sql);
			/*
			DBObject obj = DBPool.getDBObject();
			obj.sendQuery_GetLastIndex(sql);
			ResultSet rs = obj.getResultSet("select LAST_INSERT_ID() from CUSTOMER");
			try
			{
				if (rs.next())
				{
					lastIndex = rs.getInt(1);
					PrintLog("INDEX ==> " + lastIndex);
				}
			}
			catch (SQLException e)
			{
			}
			DBPool.removeDBObject(rs);
			*/
		}
		else
		{
			sql = item.getUpdateSQL();
			DBPool.sendQuery(sql);
		}

		//PrintLog(sql);

		return lastIndex;
	}

	public static void deleteCustomer(Customer item)
	{
		String sql;

		if (item._index == -1)
		{
			return;
		}
		sql = Customer.getDeleteSQL(item._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}


	public static CustomerService getCustomerServiceItem(int serviceIndex)
	{
		ResultSet rs = null;
		CustomerService item = null;
		String sql;

		sql = CustomerService.getSelectSQL_Index(serviceIndex);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new CustomerService();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static List<CustomerService> getCustomerServiceList(int customer)
	{
		List<CustomerService> lst = new ArrayList<CustomerService>();
		ResultSet rs = null;
		CustomerService item;
		String sql;

		sql = CustomerService.getSelectSQL_ByCustomer(customer);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new CustomerService();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static int insertCustomerService(int customerIndex)
	{
		ResultSet rs = null;
		String sql;
		int index = -1;

		DBPool.sendQuery(CustomerService.getInsertSQL_ForDummy(customerIndex));

		sql = CustomerService.getSelectSQL_DescOrder(customerIndex);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			try
			{
				index = rs.getInt("SERVICE_INDEX");
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		DBPool.removeDBObject(rs);

		return index;
	}

	public static int updateCustomerService(CustomerService item)
	{
		String sql;
		int lastIndex = -1;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
			lastIndex = DBPool.sendQuery_GetLastIndex(sql);
		}
		else
		{
			sql = item.getUpdateSQL();
			DBPool.sendQuery(sql);
		}

		//PrintLog(sql);

		return lastIndex;
	}

	public static int deleteCustomerService(int serviceIndex)
	{
		return -1;
	}



	public static PaymentHistory getPaymentHistory(int index)
	{
		String sql;
		PaymentHistory item = null;
		ResultSet rs = null;

		sql = PaymentHistory.getSelectSQL_Index(index);
		rs = DBPool.getResultSet(sql);
		if (getNext(rs))
		{
			item = new PaymentHistory();
			item.fromResultSet(rs);
		}
		DBPool.removeDBObject(rs);

		return item;
	}

	public static List<PaymentHistory> getPaymentHistoryList_Customer(int customer)
	{
		List<PaymentHistory> lst = new ArrayList<PaymentHistory>();
		ResultSet rs = null;
		PaymentHistory item;
		String sql;

		sql = PaymentHistory.getSelectSQL_Customer(customer);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new PaymentHistory();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static void updatePaymentHistory(PaymentHistory item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			sql = item.getInsertSQL();
		}
		else
		{
			sql = item.getUpdateSQL();
		}

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static void deletePaymentHistory(PaymentHistory item)
	{
		ResultSet rs = null;
		String sql;

		if (item._index == -1)
		{
			return;
		}
		sql = PaymentHistory.getDeleteSQL(item._index);

		//PrintLog(sql);
		DBPool.sendQuery(sql);
	}

	public static void writeLog(ConsultLog log)
	{
		String sql;

		sql = log.getInsertSQL();
		DBPool.sendQuery_GetLastIndex(sql);
	}

	public static List<ConsultLog> getLogs(int customer)
	{
		ResultSet rs = null;
		String sql;
		ConsultLog item = null;
		List<ConsultLog> lst = new ArrayList<ConsultLog>();
		int index = -1;

		sql = ConsultLog.getSelectSQL_CustomerIndex(customer);
		rs = DBPool.getResultSet(sql);
		while (getNext(rs))
		{
			item = new ConsultLog();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public static void PrintLog(String log)
	{
		StackTraceElement[] elements = Thread.currentThread().getStackTrace();
		StackTraceElement s = elements[2];
		//logger.debug(log);
		System.out.println(log + " at " + s.getClassName() + "." + s.getMethodName() + "(" + s.getFileName() + ":" + s.getLineNumber() + ")");
		/*
		StackTraceElement[] elements = Thread.currentThread().getStackTrace();
		for (int i = 1; i < elements.length; i++) {
			StackTraceElement s = elements[i];
			System.out.println("\tat " + s.getClassName() + "." + s.getMethodName() + "(" + s.getFileName() + ":" + s.getLineNumber() + ")");
		}
		*/
	}
}

