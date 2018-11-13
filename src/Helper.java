package wellness;

import java.sql.*;

public class Helper
{
	public int _index = -1;
	public String _name = "";
	public int _belong = -1;
	public int _hope = -1;
	public String _state = "";
	public int _birthYear = 1900;
	public String _contact = "";

	public static String getSelectSQL()
	{
		return "select * from HELPER";
	}

	public void fromResultSet(ResultSet rs) throws SQLException
	{
		this._index = rs.getInt("HELPER_INDEX");
		this._name = rs.getString("NAME");
		this._belong = rs.getInt("BELONG_REGION");
		this._hope = rs.getInt("HOPE_REGION");
		this._state = rs.getString("WORKING_STATE");
		this._birthYear = rs.getInt("BIRTH_YEAR");
		this._contact = rs.getString("CONTACT");
	}
}

