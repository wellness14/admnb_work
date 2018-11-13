package wellness;

import java.sql.*;

public class Notice
{
	private NoticeHeader _header;
	private String _content;

	public void setHeader(NoticeHeader header)
	{
		this._header = header;
	}

	public NoticeHeader getHeader()
	{
		return this._header;
	}

	public String getContent()
	{
		return this._content;
	}

	public String getSelectSQL()
	{
		return "select * from NOTICE";
	}

	public void selectContent(Statement statement)
	{
		try
		{
			ResultSet rs = statement.executeQuery("select CONTENT from NOTICE where NOTICE_INDEX = " + this._header.getIndex());
			this._content = rs.getString("CONTENT");
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
		}
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._header = new NoticeHeader();
			this._header.fromResultSet(rs);
			this._content = rs.getString("CONTENT");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}
