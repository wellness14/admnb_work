package wellness;

import java.sql.*;

public class UserInfo
{
	public int index = -1;
	public String id = "";
	public String name = "";
	public String permissions = "";

	public void setIndex(int index)
	{
		this.index = index;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getId()
	{
		return this.id;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getIndex()
	{
		return this.index;
	}

	public String getName()
	{
		return this.name;
	}

	public void setPermissions(String permissions)
	{
		this.permissions = permissions;
	}

	public String getPermissions()
	{
		return this.permissions;
	}

	public boolean isAdmin()
	{
		return ((this.permissions != null) && (this.permissions.equals("admin")));
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this.index = rs.getInt("MANAGER_INDEX");
			this.id = rs.getString("ID");
			this.name = rs.getString("NAME");
			this.permissions = rs.getString("PERMISSIONS");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

