package wellness;

import java.sql.*;


import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

//import javax.servlet.*;
//import javax.servlet.http.*;

@SuppressWarnings("serial")
public class Initializer extends HttpServlet
{
	public void init(ServletConfig config) throws ServletException
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch (Exception ex)
		{
			throw new ServletException(ex);
		}
	}
}
