package wellness;

import java.sql.*;

public class Terminal
{
	public int _index = -1;
	public int _customerIndex = -1;
	public int _no = -1;
	public boolean _available = false;
	public Timestamp _rentBegin = null;
	public Timestamp _rentEnd = null;

	public String getInsertSQL()
	{
		String avail = this._available ? "TRUE" : "FALSE";

		return "insert into TERMINALS (NO, CUSTOMER_INDEX, AVAILABLE, RENT_BEGIN, RENT_END) values (" +
			this._no + ", " + this._customerIndex + ", " + avail + ", " + Utils.convTimeToSQL(this._rentBegin) +
			", " + Utils.convTimeToSQL(this._rentEnd) + ")";
	}

	public String getUpdateSQL()
	{
		String avail = this._available ? "TRUE" : "FALSE";

		return "update TERMINALS set NO = " + this._no + ", CUSTOMER_INDEX = " +
			this._customerIndex + ", AVAILABLE = " + avail + ", RENT_BEGIN = " +
			Utils.convTimeToSQL(this._rentBegin) + ", RENT_END = " +
			Utils.convTimeToSQL(this._rentEnd) + " where TERMINAL_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from TERMINALS";
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from TERMINALS where TERMINAL_INDEX = " + index;
	}

	public static String getSelectSQL_No(int no)
	{
		return "select * from TERMINALS where NO = " + no;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from TERMINALS where TERMINAL_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("TERMINAL_INDEX");
			this._customerIndex = rs.getInt("CUSTOMER_INDEX");
			this._no = rs.getInt("NO");
			this._available = rs.getBoolean("AVAILABLE");
			this._rentBegin = rs.getTimestamp("RENT_BEGIN");
			this._rentBegin = rs.getTimestamp("RENT_END");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
