package wellness;

import java.sql.*;

public class NoticeHeader
{
	private int _index = -1;
	private String _name = "";
	private String _title = "";
	private Timestamp _composed;

	public void setIndex(int index)
	{
		this._index = index;
	}

	public void setName(String name)
	{
		this._name = name;
	}

	public int getIndex()
	{
		return this._index;
	}

	public String getName()
	{
		return this._name;
	}

	public void setTitle(String title)
	{
		this._title = title;
	}

	public String getTitle()
	{
		return this._title;
	}

	public void setComposed(Timestamp composed)
	{
		this._composed = composed;
	}

	public Timestamp getComposed()
	{
		return this._composed;
	}

	public static String getSelectSQL()
	{
		return "select NOTICE_INDEX, (select NAME from WEB_MANAGER where MANAGER_INDEX = NOTICE.MANAGER_INDEX) AS NAME, TITLE, COMPOSED_DATE from NOTICE where VALID = 1";
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("NOTICE_INDEX");
			this._name = rs.getString("NAME");
			this._title = rs.getString("TITLE");
			this._composed = rs.getTimestamp("COMPOSED_DATE");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

