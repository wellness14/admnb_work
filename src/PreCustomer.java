package wellness;

import java.sql.*;

public class PreCustomer
{
	public int _index = -1;
	public String _name = "";
	public String _mobile = "";
	public String _phone = "";
	public String _post = "";
	public String _address1 = "";
	public String _address2 = "";

	public String _id = "";
	public String _pwd = "";
	public String _routes = "";
	public String _routeVal = "";
	public int _recommendIndex = -1;
	public Timestamp _smsSent;
	public Timestamp _created;

	public int _indexCustomer = -1;

	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into PRE_CUSTOMER (" +
			"NAME, " +

			"POST, " +
			"ADDRESS1, " +
			"ADDRESS2, " +
			"MOBILE, " +
			"PHONE, " +

			"ID, " +
			"PASSWORD, " +
			"ROUTES, " +
			"ROUTE_VAL, " +
			"RECOMMEND_INDEX, " +
			"SMS_SENT, " +
			"CREATED, " +
			"CUSTOMER_INDEX " +

			") values (" +

			"'" + this._name + "', " +

			"'" + this._post + "', " +
			"'" + this._address1 + "', " +
			"'" + this._address2 + "', " +
			"'" + this._mobile + "', " +
			"'" + this._phone + "', " +

			"'" + this._id + "', " +
			"'" + this._pwd + "', " +
			"'" + this._routes + "', " +
			"'" + this._routeVal + "', " +
			"" + this._recommendIndex + ", " +

			"" + Utils.convTimeToSQL(this._smsSent) + ", " +
			//"" + Utils.convTimeToSQL(this._created) + " " +
			"NOW(), " +
			"" + this._indexCustomer + " " +
			")";
	}

	public String getUpdateSQL()
	{
		return "update PRE_CUSTOMER set " +
			// WARN: once member is set, cannot be changed.

			"  NAME = '" + this._name + "'" +
			", POST = '" + this._post + "'" +
			", ADDRESS1 = '" + this._address1 + "'" +
			", ADDRESS2 = '" + this._address2 + "'" +
			", MOBILE = '" + this._mobile + "'" +
			", PHONE = '" + this._phone + "'" +

			", ID = '" + this._id + "'" +
			", PASSWORD = '" + this._pwd + "'" +
			", ROUTES = '" + this._routes + "'" +
			", ROUTE_VAL = '" + this._routeVal + "'" +
			", RECOMMEND = " + this._recommendIndex + "" +

			", SMS_SENT = " + Utils.convTimeToSQL(this._smsSent) + "" +
			", CREATED = " + Utils.convTimeToSQL(this._created) + "" +
			", CUSTOMER_INDEX = " + this._indexCustomer + "" +

			" where PRE_CUSTOMER_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from PRE_CUSTOMER";
	}

	/*
	public static String getSelectSQL_UpperRegion(int upper)
	{
		return "select * from BRANCH where REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + upper + ")";
	}
	*/

	public static String getSelectSQL_Index(int index)
	{
		return "select * from PRE_CUSTOMER where PRE_CUSTOMER_INDEX = " + index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from PRE_CUSTOMER where PRE_CUSTOMER_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("PRE_CUSTOMER_INDEX");
			this._name = rs.getString("NAME");
			this._post = rs.getString("POST");
			this._address1 = rs.getString("ADDRESS1");
			this._address2 = rs.getString("ADDRESS2");
			this._mobile = rs.getString("MOBILE");
			this._phone = rs.getString("PHONE");

			this._id = rs.getString("ID");
			this._pwd = rs.getString("PASSWORD");
			this._routes = rs.getString("ROUTES");
			this._routeVal = rs.getString("ROUTE_VAL");
			this._recommendIndex = rs.getInt("RECOMMEND_INDEX");

			this._smsSent = rs.getTimestamp("SMS_SENT");
			this._created = rs.getTimestamp("CREATED");
			this._indexCustomer = rs.getInt("CUSTOMER_INDEX");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

