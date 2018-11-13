package wellness;

import java.sql.*;

public class Region
{
	public int _index = -1;
	public String _type = "";
	public int _upper = -1;
	public String _name = "";
	public boolean _activated = false;
//	public int _branchIndex = -1;

	/*
	public void setIndex(int index)
	{
		this._index = index;
	}

	public int getIndex()
	{
		return this._index;
	}

	public void setType(String type)
	{
		this._type = type;
	}

	public String getType()
	{
		return this._type;
	}

	public int getUpper()
	{
		return this._upper;
	}

	public boolean getActivated()
	{
		return this._activated;
	}

	public void setActivated(boolean act)
	{
		this._activated = act;
	}

	public void setName(String name)
	{
		this._name = name;
	}

	public String getName()
	{
		return this._name;
	}
	*/

	public static String getSelectSQL(int upper)
	{
		return "select * from REGION where UPPER_REGION = " + upper;
	}

	public static String getSelectSQL_Index(int index)
	{
		return "select * from REGION where REGION_INDEX = " + index;
	}

	public static String getSelectSQL()
	{
		return "select * from REGION ";
	}

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("REGION_INDEX");
			this._type = rs.getString("REGION_TYPE");
			this._upper = rs.getInt("UPPER_REGION");
			this._name = rs.getString("NAME");
			this._activated = rs.getBoolean("ACTIVATED");
//			this._branchIndex = rs.getInt("BRANCH_INDEX");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

