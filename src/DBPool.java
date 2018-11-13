package wellness;

import org.apache.log4j.Logger;
import java.sql.*;
import java.util.*;

public class DBPool
{
	final static Logger logger = Logger.getLogger(DBPool.class);
	private static List<DBObject> _objects = null;
	public static DBObject getDBObject()
	{
		DBObject newObj;

		if (_objects == null)
		{
			_objects = new ArrayList<DBObject>();
		}
		newObj = new DBObject();
		_objects.add(newObj);
		return newObj;
	}

	public static boolean removeDBObject(DBObject obj)
	{
		if (obj == null) { return false; }
		int size = _objects.size();
		obj.release();
		_objects.remove(obj);
		return ((size - 1) == _objects.size());
	}

	public static boolean removeDBObject(ResultSet rs)
	{
		if (rs == null) { return false; }
		int size = _objects.size();
		Iterator<DBObject> iterator = _objects.iterator();
		while(iterator.hasNext()) {
			DBObject next = iterator.next();
			if (next.getResultSet() == rs)
			{
				removeDBObject(next);
				break;
			}
		}
		return ((size - 1) == _objects.size());
	}

	public static void sendQuery(String sql)
	{
		DBObject obj = new DBObject();
		obj.sendQuery(sql);
		obj.release();
	}

	public static int sendQuery_GetLastIndex(String sql)
	{
		DBObject obj;
		ResultSet rs;
		int lastIndex = -1;

		obj = new DBObject();

		obj.sendQuery(sql);
		rs = obj.getResultSet("select LAST_INSERT_ID()");

		try
		{
			if (rs.next())
			{
				lastIndex = rs.getInt(1);
				UserDB.PrintLog("INDEX ==> " + lastIndex);
			}
		}
		catch (SQLException e)
		{
		}
		DBPool.removeDBObject(rs);

		obj.release();

		return lastIndex;
	}

	public static ResultSet getResultSet(String sql)
	{
		DBObject obj = getDBObject();
		return obj.getResultSet(sql);
	}
}
