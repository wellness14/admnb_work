package wellness;

import java.sql.*;

public class ConsultInfo
{
	private int _index = -1;

	private Customer _customer = new Customer();

	private String _accessRoute = "";
	private String _recommendRoute = "";
	private int _staffIndex = -1;
	private String _memo = "";

	private String _hospital = "";
	private Timestamp _expected;
	private Timestamp _operation;
	private String _experience = ""; //
	private String _babyType = ""; // 태아 유형

	public void setIndex(int index)
	{
		this._index = index;
	}

	public int getIndex()
	{
		return _index;
	}

	public void setCustomer(Customer customer)
	{
		_customer = customer;
	}

	public Customer getCustomer()
	{
		return _customer;
	}

/*
	public static String getSelectSQL(String sender, String receiver)
	{
		String where = "";

		if (sender != null)
		{
			where += "SENDER_INDEX = (select MANAGER_INDEX from WEB_MANAGER where ID = '" + sender + "')";
			if (receiver != null)
			{
				where += " AND ";
			}
		}

		if (receiver != null)
		{
			where += "RECEIVER_INDEX = (select MANAGER_INDEX from WEB_MANAGER where ID = '" + receiver + "')";
		}

		return "select MESSAGE_INDEX, (select ID from WEB_MANAGER where MANAGER_INDEX = SENDER_INDEX) AS SENDER, " +
			"(select ID from WEB_MANAGER where MANAGER_INDEX = RECEIVER_INDEX) AS RECEIVER, CONTENT, " +
			"SENT_DATE, READ_DATE, VALID from MESSAGE where " + where + " and VALID = true";
	}

	public String getManagerIndexSQL_ID(String id)
	{
		String sql;

		sql = "select MANAGER_INDEX from WEB_MANAGER where ID = '" + id + "'";

		return sql;
	}

	public String getIDSQL_ManagerIndex(int index)
	{
		String sql;

		sql = "select ID from WEB_MANAGER where MANAGER_INDEX = " + index;

		return sql;
	}

	public String getInsertSQL()
	{
		return "insert into MESSAGE (SENDER_INDEX, RECEIVER_INDEX, CONTENT, SENT_DATE, VALID) values ((" +
			getManagerIndexSQL_ID(this._sender) + "), (" + getManagerIndexSQL_ID(this._receiver) + "), '" +
			this._content + "', NOW(), true)";
	}

	public String getSelectSQL()
	{
		return "select MESSAGE_INDEX, (select ID from WEB_MANAGER where MANAGER_INDEX = SENDER_INDEX) AS SENDER, " +
			"(select ID from WEB_MANAGER where MANAGER_INDEX = RECEIVER_INDEX) AS RECEIVER, CONTENT, " +
			"SENT_DATE, READ_DATE, VALID from MESSAGE where VALID = true";
	}

	public void fromResultSet(ResultSet rs) throws SQLException
	{
		this._index = rs.getInt("MESSAGE_INDEX");
		this._sender = rs.getString("SENDER");
		this._receiver = rs.getString("RECEIVER");
		this._content = rs.getString("CONTENT");
		this._timeSent = rs.getTimestamp("SENT_DATE");
		this._timeRead = rs.getTimestamp("READ_DATE");
		this._isValid = rs.getBoolean("VALID");
	}
	*/
}

