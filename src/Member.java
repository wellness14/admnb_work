package wellness;

import java.sql.*;

public class Member
{
	public int _index = -1;
	public String _contractor = "";
	public String _business = "";
	public String _id = "";
	public String _password = "";
	public String _mobile = "";
	//public int _region = -1;
	public String _isHqBranch = "B"; // H: for Headquater, B: for Branch(default)

	public boolean isHQ()
	{
		return this._isHqBranch.charAt(0) == 'H';
	}

	public String getInsertSQL()
	{
		return "insert into MEMBER (" +
			"CONTRACTOR, " +
			"BUSINESS, " +
			"ID, " +
			"PASSWORD, " +
			"MOBILE, " +
			"HQ_BRANCH " +
			") values (" +
			"'" + this._contractor + "', " +
			"'" + this._business + "', " +
			"'" + this._id + "', " +
			"'" + this._password + "', " +
			"'" + this._mobile + "', " +
			"'" + this._isHqBranch + "' " +
			")";
	}

	public boolean isAdmin()
	{
		boolean ret;

		UserDB.PrintLog("[" + this._isHqBranch + "]");
		ret = this._isHqBranch.equals("H");
		UserDB.PrintLog(ret ? "TRUE" : "FALSE");

		return ret;
	}

	public String getUpdateSQL()
	{
		return "update MEMBER set " +
			"  CONTRACTOR = '" + this._contractor + "'" +
			", BUSINESS = '" + this._business + "'" +
			", ID = '" + this._id + "'" +
			", PASSWORD = '" + this._password + "'" +
			", MOBILE = '" + this._mobile + "'" +
			", HQ_BRANCH = '" + this._isHqBranch + "'" +
			" where BRANCH_INDEX = " + this._index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from MEMBER where MEMBER_INDEX = " + index;
	}

	public static String getSelectSQL(String pattern)
	{
		return "select * from MEMBER where " +
			"CONTRACTOR like '%" + pattern + "%' or " +
			"ID like '%" + pattern + "%' or " + 
			"MOBILE like '%" + pattern + "%'";
	}

	public static String getSelectSQL()
	{
		return "select * from MEMBER";
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from MEMBER where MEMBER_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("MEMBER_INDEX");
			this._contractor = rs.getString("CONTRACTOR");
			this._business = rs.getString("BUSINESS");
			this._id = rs.getString("ID");
			this._password = rs.getString("PASSWORD");
			this._mobile = rs.getString("MOBILE");
			this._isHqBranch = rs.getString("HQ_BRANCH");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
