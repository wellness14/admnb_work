package wellness;

import java.sql.*;

public class Gift
{
	public int _index = -1;
	public int _no = -1;
	public String _image = "";
	public String _name = "";
	public int _price = 0;
	public int _quantity = 0;
	public boolean _exposed = false;
	public Timestamp _registrationDate = null;
	public String _target = "";


	public String getInsertSQL()
	{
		String exposed = this._exposed ? "TRUE" : "FALSE";

		return "insert into GIFTS (NO, IMAGE, NAME, PRICE, QUANTITY, EXPOSED, REGISTRATION_DATE, TARGET) values (" +
			this._no + ", '" + this._image + "', '" + this._name + "', " + this._price + ", " +
//			this._quantity + ", " + exposed + ", " + Utils.convTimeToSQL(this._registrationDate) +
			this._quantity + ", " + exposed + ", NOW(), '" + this._target + "')";
	}

	public String getUpdateSQL()
	{
		String exposed = this._exposed ? "TRUE" : "FALSE";

		return "update GIFTS set " +
			"  NO = " + this._no + "" +
			", IMAGE = '" + this._image + "'" +
			", NAME = '" + this._name + "'" +
			", PRICE = " + this._price + "" +
			", QUANTITY = " + this._quantity + "" +
			", EXPOSED = " + exposed + "" +
//			", REGISTRATION_DATE = " + Utils.convTimeToSQL(this._registrationDate) + "" +
			", TARGET = '" + this._target + "'" +
			" where GIFT_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from GIFTS";
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from GIFTS where GIFT_INDEX = " + index;
	}

	public static String getSelectSQL_No(int no)
	{
		return "select * from GIFTS where NO = " + no;
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from GIFTS where GIFT_INDEX = " + index;
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("GIFT_INDEX");
			this._no = rs.getInt("NO");
			this._image = rs.getString("IMAGE");
			this._name = rs.getString("NAME");
			this._price = rs.getInt("PRICE");
			this._quantity = rs.getInt("QUANTITY");
			this._exposed = rs.getBoolean("EXPOSED");
			this._registrationDate = rs.getTimestamp("REGISTRATION_DATE");
			this._target = rs.getString("TARGET");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
