package wellness;

import java.sql.*;
import org.apache.log4j.Logger;

public class PaymentHistory
{
	final static Logger logger = Logger.getLogger(Terms.class);

	public int _index = -1;
	public int _customerIndex = -1;
	public String _serviceType = "";
	public String _paymentType = "";
	public String _memberName = "";
	public long _payedCost = -1;
	public int _memberIndex = -1;
	//public boolean _exposed = false;
	public Timestamp _checkedTime = null;


	public String getInsertSQL()
	{
		return "insert into PAYMENT_HISTORY (" +
			"CUSTOMER_INDEX, " +
			"SERVICE_TYPE, " +
			"PAYMENT_TYPE, " +
			"PAYED_COST, " +
			"MEMBER_INDEX, " +
			"CHECKED_TIME " +
			") values (" +
			"" + this._customerIndex + ", " +
			"'" + this._serviceType + "', " +
			"'" + this._paymentType + "', " +
			"" + this._payedCost + ", " +
			"" + this._memberIndex + ", " +
			//"" + Utils.convTimeToSQL(this._checkedTime) + " " +
			"NOW() " +
			")";
	}

	public String getUpdateSQL()
	{
		return "update PAYMENT_HISTORY set " +
			"  CUSTOMER_INDEX = " + this._customerIndex + "" +
			", SERVICE_TYPE = '" + this._serviceType + "'" +
			", PAYMENT_TYPE = '" + this._paymentType + "'" +
			", PAYED_COST = " + this._payedCost + "" +
			", MEMBER_INDEX = " + this._memberIndex + "" +
			" where PAYED_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select *, M.BUSINESS as MEMBER_NAME from PAYMENT_HISTORY, MEMBER as M where M.MEMBER_INDEX = PAYMENT_HISTORY.MEMBER_INDEX";
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select *, M.BUSINESS as MEMBER_NAME from PAYMENT_HISTORY, MEMBER as M where M.MEMBER_INDEX = PAYMENT_HISTORY.MEMBER_INDEX and PAYED_INDEX = " + index;
	}

	public static String getSelectSQL_Customer(int index)
	{
		return "select *, M.BUSINESS as MEMBER_NAME from PAYMENT_HISTORY, MEMBER as M where M.MEMBER_INDEX = PAYMENT_HISTORY.MEMBER_INDEX and CUSTOMER_INDEX = " + index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from PAYMENT_HISTORY where PAYED_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("PAYED_INDEX");
			this._customerIndex = rs.getInt("CUSTOMER_INDEX");
			this._serviceType = rs.getString("SERVICE_TYPE");
			this._paymentType = rs.getString("PAYMENT_TYPE");
			this._memberName = rs.getString("MEMBER_NAME");
			this._payedCost = rs.getLong("PAYED_COST");
			this._memberIndex = rs.getInt("MEMBER_INDEX");
			//this._exposed = rs.getBoolean("EXPOSED");
			this._checkedTime = rs.getTimestamp("CHECKED_TIME");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
}
