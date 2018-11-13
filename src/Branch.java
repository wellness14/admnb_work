package wellness;

import java.sql.*;

public class Branch
{
	public int _index = -1;
	public int _member = -1;
	public int _region = -1;

	public String _operator = "";
	public String _business = "";
	public String _registration = "";
	public String _post = "";
	public String _address1 = "";
	public String _address2 = "";

	public String _bankName = "";
	public String _bankAccount = "";
	public String _bankOwner = "";

	public String _voucherName = "";
	public String _voucherAccount = "";
	public String _voucherOwner = "";

	public String _email = "";
	public String _mobile = "";
	public String _office = "";
	public String _fax = "";

	public Timestamp _contractMade = null;
	public Timestamp _contractBegin = null;
	public Timestamp _contractEnd = null;

	public String _profile = "";
	public String _special = "";

	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into BRANCH (" +
			"MEMBER_INDEX, " +
			"REGION_INDEX, " +

			"OPERATOR, " +
			"BUSINESS, " +
			"REGISTRATION, " +
			"POST, " +
			"ADDRESS1, " +
			"ADDRESS2, " +

			"BANK_NAME, " +
			"BANK_ACCOUNT, " +
			"BANK_OWNER, " +

			"VOUCHER_NAME, " +
			"VOUCHER_ACCOUNT, " +
			"VOUCHER_OWNER, " +

			"EMAIL, " +
			"MOBILE, " +
			"OFFICE, " +
			"FAX, " +

			"CONTRACT_MADE, " +
			"CONTRACT_BEGIN, " +
			"CONTRACT_END, " +

			"PROFILE, " +
			"SPECIAL " +

			") values (" +

			"" + this._member + ", " +
			"" + this._region + ", " +

			"'" + this._operator + "', " +
			"'" + this._business + "', " +
			"'" + this._registration + "', " +
			"'" + this._post + "', " +
			"'" + this._address1 + "', " +
			"'" + this._address2 + "', " +

			"'" + this._bankName + "', " +
			"'" + this._bankAccount + "', " +
			"'" + this._bankOwner + "', " +

			"'" + this._voucherName + "', " +
			"'" + this._voucherAccount + "', " +
			"'" + this._voucherOwner + "', " +

			"'" + this._email + "', " +
			"'" + this._mobile + "', " +
			"'" + this._office + "', " +
			"'" + this._fax + "', " +

			"" + Utils.convTimeToSQL(this._contractMade) + ", " +
			"" + Utils.convTimeToSQL(this._contractBegin) + ", " +
			"" + Utils.convTimeToSQL(this._contractEnd) + ", " +

			"'" + this._profile + "', " +
			"'" + this._special + "' " +
			")";
	}

	public String getUpdateSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "update BRANCH set " +
			// WARN: once member is set, cannot be changed.
			//"  MEMBER_INDEX = " + this._member + "" +

			"  REGION_INDEX = " + this._region + "" +

			", OPERATOR = '" + this._operator + "'" +
			", BUSINESS = '" + this._business + "'" +
			", REGISTRATION = '" + this._registration + "'" +
			", POST = '" + this._post + "'" +
			", ADDRESS1 = '" + this._address1 + "'" +
			", ADDRESS2 = '" + this._address2 + "'" +

			", BANK_NAME = '" + this._bankName + "'" +
			", BANK_ACCOUNT = '" + this._bankAccount + "'" +
			", BANK_OWNER = '" + this._bankOwner + "'" +

			", VOUCHER_NAME = '" + this._voucherName + "'" +
			", VOUCHER_ACCOUNT = '" + this._voucherAccount + "'" +
			", VOUCHER_OWNER = '" + this._voucherOwner + "'" +

			", EMAIL = '" + this._operator + "'" +
			", MOBILE = '" + this._mobile + "'" +
			", OFFICE = '" + this._office + "'" +
			", FAX = '" + this._fax + "'" +

			", CONTRACT_MADE = " + Utils.convTimeToSQL(this._contractMade) + "" +
			", CONTRACT_BEGIN = " + Utils.convTimeToSQL(this._contractBegin) + "" +
			", CONTRACT_END = " + Utils.convTimeToSQL(this._contractEnd) + "" +

			", PROFILE = '" + this._profile + "'" +
			", SPECIAL = '" + this._special + "'" +
			" where BRANCH_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from BRANCH";
	}

	public static String getSelectSQL_UpperRegion(int upper)
	{
		return "select * from BRANCH where REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + upper + ")";
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from BRANCH where BRANCH_INDEX = " + index;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from BRANCH where BRANCH_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("BRANCH_INDEX");
			this._member = rs.getInt("MEMBER_INDEX");
			this._region = rs.getInt("REGION_INDEX");

			this._operator = rs.getString("OPERATOR");
			this._business = rs.getString("BUSINESS");
			this._registration = rs.getString("REGISTRATION");
			this._post = rs.getString("POST");
			this._address1 = rs.getString("ADDRESS1");
			this._address2 = rs.getString("ADDRESS2");

			this._bankName = rs.getString("BANK_NAME");
			this._bankAccount = rs.getString("BANK_ACCOUNT");
			this._bankOwner = rs.getString("BANK_OWNER");

			this._voucherName = rs.getString("VOUCHER_NAME");
			this._voucherAccount = rs.getString("VOUCHER_ACCOUNT");
			this._voucherOwner = rs.getString("VOUCHER_OWNER");

			this._email = rs.getString("EMAIL");
			this._mobile = rs.getString("MOBILE");
			this._office = rs.getString("OFFICE");
			this._fax = rs.getString("FAX");

			this._contractMade = rs.getTimestamp("CONTRACT_MADE");
			this._contractBegin = rs.getTimestamp("CONTRACT_BEGIN");
			this._contractEnd = rs.getTimestamp("CONTRACT_END");

			this._profile = rs.getString("PROFILE");
			this._special = rs.getString("SPECIAL");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
