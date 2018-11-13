package wellness;

import java.sql.*;

public class Message
{
	private int _index = -1;
	private String _sender = "";
	private String _receiver = "";
	private String _content = "";
	private Timestamp _timeSent;
	private Timestamp _timeRead;
	private boolean _isValid = false;

	public void setIndex(int index)
	{
		this._index = index;
	}

	public void setSender(String sender)
	{
		this._sender = sender;
	}

	public void setReceiver(String receiver)
	{
		this._receiver = receiver;
	}

	public void setContent(String content)
	{
		this._content = content;
	}

	public void setSent(Timestamp sent)
	{
		this._timeSent = sent;
	}

	public void setRead(Timestamp read)
	{
		this._timeRead = read;
	}

	public void setValid(boolean isValid)
	{
		this._isValid = isValid;
	}

	public int getIndex()
	{
		return this._index;
	}

	public String getSender()
	{
		return this._sender;
	}

	public String getReceiver()
	{
		return this._receiver;
	}

	public String getContent()
	{
		return this._content;
	}

	public Timestamp getSent()
	{
		return this._timeSent;
	}

	public Timestamp getRead()
	{
		return this._timeRead;
	}

	public boolean getValid()
	{
		return this._isValid;
	}

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

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("MESSAGE_INDEX");
			this._sender = rs.getString("SENDER");
			this._receiver = rs.getString("RECEIVER");
			this._content = rs.getString("CONTENT");
			this._timeSent = rs.getTimestamp("SENT_DATE");
			this._timeRead = rs.getTimestamp("READ_DATE");
			this._isValid = rs.getBoolean("VALID");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

