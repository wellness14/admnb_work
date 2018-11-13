package wellness;

import org.apache.log4j.Logger;
import java.sql.*;
import java.util.*;

public class DBObject
{
	//private stati boolean _is
	final static Logger logger = Logger.getLogger(DBObject.class);

	// development server
	//private static final String _databaseServerAddr = "localhost";
	//private static final String _databaseServerDB = "wellness";
	//private static final String _user = "wellness";
	//private static final String _pwd = "wellnesspwd";

	// wellness database
	private static final String _databaseServerAddr = "114.207.246.192";
	private static final String _databaseServerDB = "mothernbaby";
	private static final String _user = "mothernbaby";
	private static final String _pwd = "mothernbaby!2#$";

	private static final int _databaseServerPort = 3306;

	private Connection _connection = null;
	private Statement _statement = null;
	private ResultSet _result = null;

	private static String getDatabaseDriver()
	{
		return "jdbc:mysql://" + _databaseServerAddr + ":" + _databaseServerPort +
			"/" + _databaseServerDB + "?" +
			"useUnicode=true&characterEncoding=utf8";
	}

	public Connection getConnection()
	{
		String jdbcDrv = getDatabaseDriver();

		//logger.debug("getConnection>>");
		if (this._connection == null)
		{
			try
			{
				//logger.debug("JDBC:" + jdbcDrv);
				_connection = DriverManager.getConnection(jdbcDrv, _user, _pwd);
			}
			catch (SQLException e)
			{
				e.printStackTrace();
				logger.error(e.getMessage());
				return null;
			}
		}

		return _connection;
	}

	public Statement getStatement()
	{
//		logger.debug("getStatement>>");
		if (this._connection == null)
		{
			getConnection();
		}
//		logger.debug("getStatement1>>");
		if ((this._connection != null) && (this._statement == null))
		{
			try
			{
//				logger.debug("getStatement2>>");
				this._statement = this._connection.createStatement();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
				logger.error(e.getMessage());
				return null;
			}
		}

		return this._statement;
	}

	public boolean sendQuery(String sql)
	{
		if (this._statement == null)
		{
			getStatement();
		}

		try
		{
			if ((this._connection != null) && (this._statement != null))
			{
				logger.debug("SQL:" + sql);
				this._statement.executeUpdate(sql);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			logger.error(e.getMessage());
			return false;
		}

		return (this._statement != null);//this._result;
	}

	public ResultSet getResultSet(String sql)
	{
		getStatement();

		try
		{
			if ((this._connection != null) && (this._statement != null))
			{
				logger.debug("SQL:" + sql);
				this._result = this._statement.executeQuery(sql);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			logger.error(e.getMessage());
			return null;
		}

		return this._result;
	}

	public ResultSet getResultSet()
	{
		return this._result;
	}

	public void release()
	{
		if (this._result != null)
		{
			try
			{
				this._result.close();
			}
			catch (SQLException e) { }
			finally { this._result = null; }
		}
		if (this._statement != null)
		{
			try
			{
				this._statement.close();
			}
			catch (SQLException e) { }
			finally { this._statement = null; }
		}
		if (this._connection != null)
		{
			try
			{
				this._connection.close();
			}
			catch (SQLException e) { }
			finally { this._connection = null; }
		}
	}
}
