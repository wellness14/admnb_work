package wellness;

import java.sql.*;

public class Tags
{
	private String _title = "";
	private String _author = "";
	private String _description = "";
	private String _keyword = "";

	public void setTitle(String title)
	{
		this._title = title;
	}

	public void setAuthor(String author)
	{
		this._author = author;
	}

	public void setDescription(String desc)
	{
		this._description = desc;
	}

	public void setKeyword(String keyword)
	{
		this._keyword = keyword;
	}

	public String getTitle()
	{
		return this._title;
	}

	public String getAuthor()
	{
		return this._author;
	}

	public String getDescription()
	{
		return this._description;
	}

	public String getKeyword()
	{
		return this._keyword;
	}

	public static String getSelectSQL()
	{
		return "select * from TAGS";
	}

	public String getUpdateSQL()
	{
		return "update TAGS set TITLE = '" + this._title + "', AUTHOR = '" +
			this._author + "', DESCRIPTION = '" + this._description + "', KEYWORD = '" +
			this._keyword + "'";
	}
	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._title = rs.getString("TITLE");
			this._author = rs.getString("AUTHOR");
			this._description = rs.getString("DESCRIPTION");
			this._keyword = rs.getString("KEYWORD");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

