package wellness;

import java.sql.*;
import org.apache.log4j.Logger;

public class Terms
{
	final static Logger logger = Logger.getLogger(Terms.class);

	public int _index = -1;
	public String _type = "";
	public String _contents = "";
	//public boolean _exposed = false;
	public Timestamp _applyDate = null;
	public Timestamp _composedDate = null;
	public Timestamp _modifiedDate = null;


	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into TERMS (TERMS_TYPE, CONTENTS, APPLY_DATE, COMPOSED_DATE, MODIFIED_DATE) values ('" +
			this._type + "', '" + this._contents + "', " + Utils.convTimeToSQL(this._applyDate) + ", NOW(), NOW())";
	}

	public String getUpdateSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		return "update TERMS set " +
			"  TERMS_TYPE = '" + this._type + "'" +
			", CONTENTS = '" + this._contents + "'" +
			//", EXPOSED = " + exposed + "" +
			", APPLY_DATE = " + Utils.convTimeToSQL(this._applyDate) + "" +
			", MODIFIED_DATE = NOW()" +
			" where TERMS_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from TERMS";
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from TERMS where TERMS_INDEX = " + index;
	}

	public static String getSelectSQL_Type(String type)
	{
		return "select * from TERMS where TERMS_TYPE = '" + type + "'";
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from TERMS where TERMS_INDEX = " + index;
	}

	/*
	public static String getHideSQL(String type)
	{
		return "update TERMS set EXPOSED = FALSE where TERMS_TYPE = '" + type + "'";
	}
	*/

	public String getUpdateApplyDateSQL()
	{
		return "update TERMS set APPLY_DATE = " + Utils.convTimeToSQL(this._applyDate) + " where TERMS_INDEX = " + this._index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("TERMS_INDEX");
			this._type = rs.getString("TERMS_TYPE");
			//this._exposed = rs.getBoolean("EXPOSED");
			this._contents = rs.getString("CONTENTS");
			this._composedDate = rs.getTimestamp("COMPOSED_DATE");
			this._modifiedDate = rs.getTimestamp("MODIFIED_DATE");
			Timestamp apply = rs.getTimestamp("APPLY_DATE");
			if (apply == null)
			{
				logger.debug("DEBUG:" + "APPLY_DATE is null.");
				return;
			}
			this._applyDate = apply;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
}
