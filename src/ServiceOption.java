package wellness;

import java.sql.*;

public class ServiceOption
{
	public int _index = -1;
	public String _type = "";
//	public String _weekWork = "";
//	public String _amountType = "";
	public int _cost = -1;

	public String getInsertSQL()
	{
		return "insert into SERVICE_OPTION (TYPE, COST) values ('" + this._type + "', " + this._cost + ")";
	}

	public String getUpdateSQL()
	{
		return "update SERVICE_OPTION set COST = " + this._cost + " where TYPE = '" + this._type + "'";
	}

	public static String getSelectSQL()
	{
		return "select * from SERVICE_OPTION";
	}

	public static String getSelectSQL(String type)
	{
		return "select * from SERVICE_OPTION where TYPE like '%" + type + "%'";
	}

	public String checkExistenceSQL()
	{
		return "select * from SERVICE_OPTION where TYPE = '" + this._type + "'";
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("SERVICE_OPTION_INDEX");
			this._type = rs.getString("TYPE");
			//this._weekWork = rs.getString("WEEK_WORK");
			//this._amountType = rs.getString("AMOUNT_TYPE");
			this._cost = rs.getInt("COST");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
