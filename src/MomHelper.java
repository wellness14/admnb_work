package wellness;

import java.sql.*;

public class MomHelper
{
	public int _index = -1;
	public String _name = "";
	public String _socialNum = "";
	public String _post = "";
	public String _address1 = "";
	public String _address2 = "";
	public String _mobile = "";
	public String _phone = "";

	public String _education = "";
	public String _insurance = "";
	public Timestamp _health;
	public Timestamp _benefitBegin;
	public Timestamp _benefitEnd;

	public String _religion = "";
	public String _workType = "";
	public String _memo = "";

	public int _belong = -1;
	public int _wish = -1;

	public String _state = "";

	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into HELPER (" +
			"NAME, " +

			"SOCIAL_NUM, " +
			"POST, " +
			"ADDRESS1, " +
			"ADDRESS2, " +
			"MOBILE, " +
			"PHONE, " +

			"EDUCATION, " +
			"INSURANCE, " +
			"HEALTH_CARE, " +

			"BENEFIT_BEGIN, " +
			"BENEFIT_END, " +

			"RELIGION, " +
			"WORK_TYPE, " +

			"BELONG_REGION, " +
			"WISH_REGION, " +

			"WORKING_STATE, " +
			"MEMO" +

			") values (" +

			"'" + this._name + "', " +
			"'" + this._socialNum + "', " +

			"'" + this._post + "', " +
			"'" + this._address1 + "', " +
			"'" + this._address2 + "', " +
			"'" + this._mobile + "', " +
			"'" + this._phone + "', " +

			"'" + this._education + "', " +
			"'" + this._insurance + "', " +
			"" + Utils.convTimeToSQL(this._health) + ", " +

			"" + Utils.convTimeToSQL(this._benefitBegin) + ", " +
			"" + Utils.convTimeToSQL(this._benefitEnd) + ", " +

			"'" + this._religion + "', " +
			"'" + this._workType + "', " +
			"" + this._belong + ", " +
			"" + this._wish + ", " +

			"'" + this._state + "', " +
			"'" + this._memo + "' " +
			")";
	}

	public String getUpdateSQL()
	{
		return "update HELPER set " +
			// WARN: once member is set, cannot be changed.

			"  NAME = '" + this._name + "'" +
			", SOCIAL_NUM = '" + this._socialNum + "'" +
			", POST = '" + this._post + "'" +
			", ADDRESS1 = '" + this._address1 + "'" +
			", ADDRESS2 = '" + this._address2 + "'" +
			", MOBILE = '" + this._mobile + "'" +
			", PHONE = '" + this._phone + "'" +

			", EDUCATION = '" + this._education + "'" +
			", INSURANCE = '" + this._insurance + "'" +
			", HEALTH_CARE = " + Utils.convTimeToSQL(this._health) + "" +

			", BENEFIT_BEGIN = " + Utils.convTimeToSQL(this._benefitBegin) + "" +
			", BENEFIT_END = " + Utils.convTimeToSQL(this._benefitEnd) + "" +

			", RELIGION = '" + this._religion + "'" +
			", WORK_TYPE = '" + this._workType + "'" +

			", BELONG_REGION = " + this._belong + "" +
			", WISH_REGION = " + this._wish + "" +

			", WORKING_STATE = '" + this._state + "'" +
			", MEMO = '" + this._memo + "'" +
			" where HELPER_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from HELPER";
	}

	/*
	public static String getSelectSQL_UpperRegion(int upper)
	{
		return "select * from BRANCH where REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + upper + ")";
	}
	*/

	public static String getSelectSQL_Index(int index)
	{
		return "select * from HELPER where HELPER_INDEX = " + index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from HELPER where HELPER_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("HELPER_INDEX");
			this._name = rs.getString("NAME");
			this._socialNum = rs.getString("SOCIAL_NUM");
			this._post = rs.getString("POST");
			this._address1 = rs.getString("ADDRESS1");
			this._address2 = rs.getString("ADDRESS2");
			this._mobile = rs.getString("MOBILE");
			this._phone = rs.getString("PHONE");

			this._education = rs.getString("EDUCATION");
			this._insurance = rs.getString("INSURANCE");
			this._health = rs.getTimestamp("HEALTH_CARE");

			this._benefitBegin = rs.getTimestamp("BENEFIT_BEGIN");
			this._benefitEnd = rs.getTimestamp("BENEFIT_END");

			this._religion = rs.getString("RELIGION");
			this._workType = rs.getString("WORK_TYPE");

			this._belong = rs.getInt("BELONG_REGION");
			this._wish = rs.getInt("WISH_REGION");

			this._state = rs.getString("WORKING_STATE");
			this._memo = rs.getString("MEMO");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

