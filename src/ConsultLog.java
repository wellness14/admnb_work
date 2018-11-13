package wellness;

import java.sql.*;

public class ConsultLog
{
	public int _index = -1;
	public int _customer = -1;
	public String _type = "";
	public Timestamp _time;
	public String _log = "";

	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into CONSULT_LOG (" +
			"CUSTOMER_INDEX, " +

			"LOG_TYPE, " +
			"LOG_TIME, " +
			"PROCESS_LOG " +

			") values (" +

			"" + this._customer + ", " +
			"'" + this._type + "', " +

			"" + Utils.convTimeToSQL(this._time) + ", " +
			"'" + this._log + "' " +
			")";
	}

	public String getUpdateSQL()
	{
		return "update CONSULT_LOG set " +
			// WARN: once member is set, cannot be changed.

			"  CUSTOMER_INDEX = " + this._customer + "" +
			", LOG_TYPE = '" + this._type + "'" +
			", LOG_TIME = " + Utils.convTimeToSQL(this._time) + "" +
			", PROGRESS_LOG = '" + this._log + "'" +
			" where LOG_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from CONSULT_LOG";
	}

	/*
	public static String getSelectSQL_UpperRegion(int upper)
	{
		return "select * from BRANCH where REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + upper + ")";
	}
	*/

	public static String getSelectSQL_Index(int index)
	{
		return "select * from CONSULT_LOG where LOG_INDEX = " + index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from CONSULT_LOG where LOG_INDEX = " + index;
	}

	public static String getSelectSQL_CustomerIndex(int index)
	{
		return "select * from CONSULT_LOG where CUSTOMER_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("LOG_INDEX");
			this._customer = rs.getInt("CUSTOMER_INDEX");
			this._type = rs.getString("LOG_TYPE");
			this._time = rs.getTimestamp("LOG_TIME");
			this._log = rs.getString("PROCESS_LOG");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
