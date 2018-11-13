package wellness;

import java.sql.*;

public class CustomerService
{
	public int _index = -1;
	public int _customer = -1;

	public String _serviceName = "";
	public String _servicePeriod = "";

	public Timestamp _serviceStart = null;
	public Timestamp _serviceEnd = null;

	public String _serviceType = "";
	public int _helper = -1;
	public Timestamp _careChange = null;

	public String _additionalCare = "";
	public String _additionalOvertime = "";
	public String _extended = "";

	public String getHelperName()
	{
		MomHelper item = null;
		String name = "입력되지 않음";

		if (_helper != -1)
		{
			item = UserDB.getHelperItem(_helper);
			if (item != null)
			{
				name = item._name;
			}
		}

		return name;
	}

	public String toJSON()
	{
		String json = "{";

		json += "\"SERVICE_INDEX\":" + _index + "";
		json += ",\"CUSTOMER_INDEX\":" + _customer + "";

		json += ",\"SERVICE_NAME\":\"" + _serviceName + "\"";
		json += ",\"SERVICE_PERIOD\":\"" + _servicePeriod + "\"";

		if (_serviceStart != null)
		{
			json += ",\"SERVICE_START\":" + Utils.toJSON(_serviceStart) + "";
		}
		if (_serviceEnd != null)
		{
			json += ",\"SERVICE_END\":" + Utils.toJSON(_serviceEnd) + "";
		}
		json += ",\"SERVICE_TYPE\":\"" + _serviceType + "\"";
		json += ",\"HELPER\":" + _helper + "";
		json += ",\"HELPER_NAME\":\"" + getHelperName() + "\"";
		if (_careChange != null)
		{
			json += ",\"CARE_CHANGE\":" + Utils.toJSON(_careChange) + "";
		}
		json += ",\"ADDITIONAL_CARE\":\"" + _additionalCare + "\"";
		json += ",\"ADDITIONAL_OVERTIME\":\"" + _additionalOvertime + "\"";
		json += ",\"EXTENDED\":\"" + _extended + "\"";

		return json + "}\n";
	}

	public static String getInsertSQL_ForDummy(int customer)
	{
		return "insert into CUSTOMER_SERVICE (" +
			"CUSTOMER_INDEX " +
			") values (" +
			"" + customer + " " +
			")";
	}

	public static String getSelectSQL_DescOrder(int customer)
	{
		return "select * from CUSTOMER_SERVICE where CUSTOMER_INDEX = " + customer +
			" order by SERVICE_INDEX DESC";
	}

	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into CUSTOMER_SERVICE (" +
			"CUSTOMER_INDEX, " +

			"SERVICE_NAME, " +
			"SERVICE_PERIOD, " +

			"SERVICE_START, " +
			"SERVICE_END, " +

			"SERVICE_TYPE, " +

			"HELPER_INDEX, " +
			"CARE_CHANGE, " +

			"ADDITIONAL_CARE, " +
			"ADDITIONAL_OVERTIME, " +

			"EXTENDED " +

			") values (" +

			"" + this._customer + ", " +

			"'" + this._serviceName + "', " +
			"'" + this._servicePeriod + "', " +

			"" + Utils.convTimeToSQL(this._serviceStart) + ", " +
			"" + Utils.convTimeToSQL(this._serviceEnd) + ", " +

			"'" + this._serviceType + "', " +
			"" + this._helper + ", " +
			"" + Utils.convTimeToSQL(this._careChange) + ", " +

			"'" + this._additionalCare + "', " +
			"'" + this._additionalOvertime + "', " +
			"'" + this._extended + "' " +
			")";
	}

	public String getUpdateSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "update CUSTOMER_SERVICE set " +
			// WARN: once member is set, cannot be changed.
			//"  MEMBER_INDEX = " + this._member + "" +

			"  CUSTOMER_INDEX = " + this._customer + "" +

			", SERVICE_NAME = '" + this._serviceName + "'" +
			", SERVICE_PERIOD = '" + this._servicePeriod + "'" +
			", SERVICE_START = " + Utils.convTimeToSQL(this._serviceStart) + "" +
			", SERVICE_END = " + Utils.convTimeToSQL(this._serviceEnd) + "" +

			", SERVICE_TYPE = '" + this._serviceType + "'" +
			", HELPER_INDEX = " + this._helper + "" +
			", CARE_CHANGE = " + Utils.convTimeToSQL(this._careChange) + "" +

			", ADDITIONAL_CARE = '" + this._additionalCare + "'" +
			", ADDITIONAL_OVERTIME = '" + this._additionalOvertime + "'" +
			", EXTENDED = '" + this._extended + "'" +
			" where SERVICE_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from CUSTOMER_SERVICE";
	}

	public static String getSelectSQL_ByCustomer(int customer)
	{
		return "select * from CUSTOMER_SERVICE where CUSTOMER_INDEX = " + customer;
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from CUSTOMER_SERVICE where SERVICE_INDEX = " + index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from CUSTOMER_SERVICE where SERVICE_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("SERVICE_INDEX");
			this._customer = rs.getInt("CUSTOMER_INDEX");

			this._serviceName = rs.getString("SERVICE_NAME");
			this._servicePeriod = rs.getString("SERVICE_PERIOD");
			this._serviceStart = rs.getTimestamp("SERVICE_START");
			this._serviceEnd = rs.getTimestamp("SERVICE_END");

			this._serviceType = rs.getString("SERVICE_TYPE");
			this._helper = rs.getInt("HELPER_INDEX");
			this._careChange = rs.getTimestamp("CARE_CHANGE");

			this._additionalCare = rs.getString("ADDITIONAL_CARE");
			this._additionalOvertime = rs.getString("ADDITIONAL_OVERTIME");
			this._extended = rs.getString("EXTENDED");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
