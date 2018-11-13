package wellness;

import java.sql.*;
import java.util.*;
import java.text.*;
import org.apache.log4j.Logger;

public class Utils
{
	final static Logger logger = Logger.getLogger(UserDB.class);

	public Logger getLogger() { return logger; }

	public static String convTimeToSQL(Timestamp time)
	{
		// STR_TO_DATE('8/27/2016 12:07:00','%m/%d/%Y %H:%i:%s')
		if (time == null) return "NULL";
		Calendar cal = new GregorianCalendar();
		cal.setTime(time);

		return convTimeToSQL(cal);
	}

	public static String convTimeToSQL(Calendar time)
	{
		if (time == null) return "NULL";
		String ret = "STR_TO_DATE('" + (time.get(Calendar.MONTH) + 1)+ "/" + time.get(Calendar.DAY_OF_MONTH) + "/" + time.get(Calendar.YEAR) + "','%m/%d/%Y')";

		return ret;
	}

	public static Calendar convTimestampToCalendar(Timestamp tms)
	{
		Calendar cal = new GregorianCalendar();
		cal.setTime(tms);
		return cal;
	}

	public static Timestamp convCalendarToTimestamp(Calendar cal)
	{
		Timestamp tms = new Timestamp(cal.getTimeInMillis());
		return tms;
	}

	public static String toJSON(Timestamp time)
	{
		return toJSON(convTimestampToCalendar(time));
	}

	public static String toJSON(Calendar cal)
	{
		String json = "{";

		json += "\"YEAR\":" + cal.get(Calendar.YEAR) + "";
		json += ",\"MONTH\":" + (cal.get(Calendar.MONTH) + 1) + "";

		json += ",\"DAY\":" + cal.get(Calendar.DAY_OF_MONTH) + "";

		return json + "}";
	}

	public static Calendar convStringToCalendar(String str)
	{
		return convStringToCalendar(str, "yyyy.MM.dd HH:mm:ss");
	}

	public static Calendar convStringToCalendar(String str, String format)
	{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(format);

		try
		{
			cal.setTime(sdf.parse(str));
		}
		catch (ParseException e)
		{
			logger.debug("Error message: [" + str + "]:[" + format + "]");
			return null;
		}

		return cal;
	}

	public static Timestamp convStringToTimestamp(String str)
	{
		if ((str == null) || (str.length() == 0)) return null;
		if (str.charAt(4) == '-')
		{
			return convCalendarToTimestamp(convStringToCalendar(str, "yyyy-MM-dd"));
		}
		return convCalendarToTimestamp(convStringToCalendar(str, "yyyy.MM.dd HH:mm:ss"));
	}

	public static Timestamp convStringToTimestamp(String str, String format)
	{
		return convCalendarToTimestamp(convStringToCalendar(str, format));
	}

	public static String convBooleanToString(boolean val)
	{
		return (val == true) ? "TRUE" : "FALSE";
	}

	public static String getServiceURL()
	{
		return "http://work.eidware.com:8888/work";
	}
}
