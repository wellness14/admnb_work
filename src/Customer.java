package wellness;

import java.sql.*;
import java.util.*;

public class Customer
{
	public int _index = -1;
	public String _name = "";
	public String _mobile = "";
	public String _phone = "";
	public String _post = "";
	public String _address1 = "";
	public String _address2 = "";

	public String _smsURL = "";
	public Timestamp _smsSent;
	public String _id = "";
	public String _pwd = "";
	public String _routes = "";
	public String _routeVal = "";
	public int _recommendIndex = -1;

	public int _memberIndex = -1;
	public int _branchIndex = -1;
	public String _memo = "";

	public String _hospital = "";
	public Timestamp _expectedDate; // 예정일
	public Timestamp _operationDate; // 수술일
	public String _experiences = "";
	public String _babyTypeExpected = "";
	public String _disabledType = "";
	public String _careCenter = "";
	public String _careCenterPeriod = "";
	public String _servicePlaceWish = "";

	public Timestamp _babyBirth; // 출산일
	public String _babyTypes = "";
	public String _childBirthType = "";
	public String _servicePlaceReal = "";

	public Timestamp _verified; // 입금확인시간

	public String _voucherType = "";
	public int _voucherDays = -1;

	public String _pets = "";
	public String _cashReceipt = "no";

	public int _rentalIndex = -1;
	public Timestamp _rentalBegin; // 대여시작
	public Timestamp _rentalEnd; // 대여종료(반납)
	public Timestamp _rentalDeliveryPayed; // 택배비입금
	public int _rentalDeliveryCost; // 택배비
	public Timestamp _rentalPayed; // 대여료입금
	public int _rentalCost; // 대여료

	public int _giftIndex1 = -1;
	public Timestamp _giftSent1; // 선물발송
	public int _giftIndex2 = -1;
	public Timestamp _giftSent2; // 선물발송

	public int _terminalIndex = -1;
	public Timestamp _terminalBegin; // 단말기 대여 시작
	public Timestamp _terminalEnd; // 단말기 대여 종료


	public Timestamp _created;

	public String getKey(long milli)
	{
		String ret = "";
		String key = this._mobile + "abcdABCDEFGHefghijkqrstzIJK012345LMNOPQRSTUVWXYuvwxyZ67890987lmnop6543210";
		int pos = 0;

		while (milli > 0)
		{
			pos += milli % key.length();

			pos %= key.length();
			ret += key.charAt(pos);

			milli /= key.length() / 10;
		}

		return ret;
	}

	public String generateSmsUrl()
	{
		this._smsURL = getKey(new Timestamp(System.currentTimeMillis()).getTime());
		return this._smsURL;
	}

	public void updateSMSSendTime()
	{
		Timestamp cur = new Timestamp(System.currentTimeMillis());
		this._smsSent = cur;
	}

	public String getInsertSQL()
	{
		//String exposed = this._exposed ? "TRUE" : "FALSE";

		String url = generateSmsUrl();
		UserDB.PrintLog("Generated SMS Key: [" + url + "]");

		return "insert into CUSTOMER (" +
			"NAME, " +

			"POST, " +
			"ADDRESS1, " +
			"ADDRESS2, " +
			"MOBILE, " +
			"PHONE, " +

			"ID, " +
			"PASSWORD, " +
			"ROUTES, " +
			"ROUTE_VAL, " +
			"RECOMMEND_INDEX, " +

			"MEMBER_INDEX, " +
			"BRANCH_INDEX, " +
			"MEMO, " +
			"SMS_URL, " +
			"SMS_SENT, " +

			"HOSPITAL, " +
			"EXPECTED_DATE, " +
			"OPERATION_DATE, " +
			"EXPERIENCES, " +
			"BABY_TYPE_EXPECTED, " +
			"DISABLED_TYPE, " +
			"CARE_CENTER, " +
			"CARE_CENTER_PERIOD, " +
			"SERVICE_PLACE_WISH, " +

			"BABY_BIRTH, " +
			"BABY_TYPES, " +
			"CHILDBIRTH_TYPE, " +
			"SERVICE_PLACE_REAL, " +

			//"VERIFIED, " +

			"VOUCHER_TYPE, " +
			"VOUCHER_DAYS, " +

			"PETS, " +
			"CASH_RECEIPT, " +

			"RENTAL_INDEX, " +
			"RENTAL_BEGIN, " +
			"RENTAL_END, " +
			"RENTAL_DELIVERY_PAYED, " +
			"RENTAL_DELIVERY_COST, " +
			"RENTAL_PAYED, " +
			"RENTAL_COST, " +

			"GIFT_INDEX1, " +
			"GIFT_SENT1, " +
			"GIFT_INDEX2, " +
			"GIFT_SENT2, " +

			"TERMINAL_INDEX, " +
			"TERMINAL_BEGIN, " +
			"TERMINAL_END, " +

			"CREATED " +

			") values (" +

			"'" + this._name + "', " +

			"'" + this._post + "', " +
			"'" + this._address1 + "', " +
			"'" + this._address2 + "', " +
			"'" + this._mobile + "', " +
			"'" + this._phone + "', " +

			"'" + this._id + "', " +
			"'" + this._pwd + "', " +
			"'" + this._routes + "', " +
			"'" + this._routeVal + "', " +
			"" + this._recommendIndex + ", " +

			"" + this._memberIndex + ", " +
			"" + this._branchIndex + ", " +
			"'" + this._memo + "', " +
			"'" + this._smsURL + "', " +
			"" + Utils.convTimeToSQL(this._smsSent) + ", " +

			"'" + this._hospital + "', " +
			"" + Utils.convTimeToSQL(this._expectedDate) + ", " +
			"" + Utils.convTimeToSQL(this._operationDate) + ", " +
			"'" + this._experiences + "', " +
			"'" + this._babyTypeExpected + "', " +
			"'" + this._disabledType + "', " +
			"'" + this._careCenter + "', " +
			"'" + this._careCenterPeriod + "', " +
			"'" + this._servicePlaceWish + "', " +

			"" + Utils.convTimeToSQL(this._babyBirth) + ", " +
			"'" + this._babyTypes + "', " +
			"'" + this._childBirthType + "', " +
			"'" + this._servicePlaceReal + "', " +

			//"" + Utils.convTimeToSQL(this._verified) + ", " +

			"'" + this._voucherType + "', " +
			"" + this._voucherDays + ", " +

			"'" + this._pets + "', " +
			"'" + this._cashReceipt + "', " +

			"" + this._rentalIndex + ", " +
			"" + Utils.convTimeToSQL(this._rentalBegin) + ", " +
			"" + Utils.convTimeToSQL(this._rentalEnd) + ", " +
			"" + Utils.convTimeToSQL(this._rentalDeliveryPayed) + ", " +
			"" + this._rentalDeliveryCost + ", " +
			"" + Utils.convTimeToSQL(this._rentalPayed) + ", " +
			"" + this._rentalCost + ", " +

			"" + this._giftIndex1 + ", " +
			"" + Utils.convTimeToSQL(this._giftSent1) + ", " +
			"" + this._giftIndex2 + ", " +
			"" + Utils.convTimeToSQL(this._giftSent2) + ", " +

			"" + this._terminalIndex + ", " +
			"" + Utils.convTimeToSQL(this._terminalBegin) + ", " +
			"" + Utils.convTimeToSQL(this._terminalEnd) + ", " +

			//"" + Utils.convTimeToSQL(this._created) + " " +
			"NOW() " +
			")";
	}

	public static String getInsertSQL_ForDummy(int memberIndex)
	{
		return "insert into CUSTOMER (" +
			"MEMBER_INDEX, " +
			"CREATED " +
			") values (" +
			"" + memberIndex + ", " +
			"NOW() " +
			")";
	}

	public static String getSelectSQL_DescOrder(int memberIndex)
	{
		return "select * from CUSTOMER where MEMBER_INDEX = " + memberIndex + " order by CUSTOMER_INDEX desc";
	}

	public String getUpdateSQL()
	{
		return "update CUSTOMER set " +
			// WARN: once member is set, cannot be changed.

			"  NAME = '" + this._name + "'" +
			", POST = '" + this._post + "'" +
			", ADDRESS1 = '" + this._address1 + "'" +
			", ADDRESS2 = '" + this._address2 + "'" +
			", MOBILE = '" + this._mobile + "'" +
			", PHONE = '" + this._phone + "'" +

			", ID = '" + this._id + "'" +
			", PASSWORD = '" + this._pwd + "'" +
			", ROUTES = '" + this._routes + "'" +
			", ROUTE_VAL = '" + this._routeVal + "'" +
			", RECOMMEND_INDEX = " + this._recommendIndex + "" +

			", MEMBER_INDEX = " + this._memberIndex + "" +
			", BRANCH_INDEX = " + this._branchIndex + "" +
			", MEMO = '" + this._memo + "'" +
			", SMS_URL = '" + this._smsURL + "'" +
			", SMS_SENT = " + Utils.convTimeToSQL(this._smsSent) + "" +

			", HOSPITAL = '" + this._hospital + "'" +
			", EXPECTED_DATE = " + Utils.convTimeToSQL(this._expectedDate) + "" +
			", OPERATION_DATE = " + Utils.convTimeToSQL(this._operationDate) + "" +
			", EXPERIENCES = '" + this._experiences + "'" +
			", BABY_TYPE_EXPECTED = '" + this._babyTypeExpected + "'" +
			", DISABLED_TYPE = '" + this._disabledType + "'" +
			", CARE_CENTER = '" + this._careCenter + "'" +
			", CARE_CENTER_PERIOD = '" + this._careCenterPeriod + "'" +
			", SERVICE_PLACE_WISH = '" + this._servicePlaceWish + "'" +

			", BABY_BIRTH = " + Utils.convTimeToSQL(this._babyBirth) + "" +
			", BABY_TYPES = '" + this._babyTypes + "'" +
			", CHILDBIRTH_TYPE = '" + this._childBirthType + "'" +
			", SERVICE_PLACE_REAL = '" + this._servicePlaceReal + "'" +

			", VOUCHER_TYPE = '" + this._voucherType + "'" +
			", VOUCHER_DAYS = " + this._voucherDays + "" +

			", PETS = '" + this._pets + "'" +
			", CASH_RECEIPT = '" + this._cashReceipt + "'" +

			", RENTAL_INDEX = " + this._rentalIndex + "" +
			", RENTAL_BEGIN = " + Utils.convTimeToSQL(this._rentalBegin) + "" +
			", RENTAL_END = " + Utils.convTimeToSQL(this._rentalEnd) + "" +
			", RENTAL_DELIVERY_PAYED = " + Utils.convTimeToSQL(this._rentalDeliveryPayed) + "" +
			", RENTAL_DELIVERY_COST = " + this._rentalDeliveryCost + "" +
			", RENTAL_PAYED = " + Utils.convTimeToSQL(this._rentalPayed) + "" +
			", RENTAL_COST = " + this._rentalCost + "" +

			", GIFT_INDEX1 = " + this._giftIndex1 + "" +
			", GIFT_SENT1 = " + Utils.convTimeToSQL(this._giftSent1) + "" +
			", GIFT_INDEX2 = " + this._giftIndex2 + "" +
			", GIFT_SENT2 = " + Utils.convTimeToSQL(this._giftSent2) + "" +

			", TERMINAL_INDEX = " + this._terminalIndex + "" +
			", TERMINAL_BEGIN = " + Utils.convTimeToSQL(this._terminalBegin) + "" +
			", TERMINAL_END = " + Utils.convTimeToSQL(this._terminalEnd) + "" +

//			", CREATED = " + Utils.convTimeToSQL(this._created) + "" +

			" where CUSTOMER_INDEX = " + this._index;
	}

	public static String getSelectSQL()
	{
		return "select * from CUSTOMER";
	}

	public static String getSelectSQL(String pattern)
	{
		return "select * from CUSTOMER where (NAME like '%" + pattern + "%') or (MOBILE like '%" + pattern + "%') or (ID like '%" + pattern + "%')";
	}

	/*
	public static String getSelectSQL_UpperRegion(int upper)
	{
		return "select * from BRANCH where REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + upper + ")";
	}
	*/

	public static String getSelectSQL_Index(int index)
	{
		return "select * from CUSTOMER where CUSTOMER_INDEX = " + index;
	}

	public static String getSelectSQL_UrlKey(String urlKey)
	{
		return "select * from CUSTOMER where SMS_URL = '" + urlKey + "'";
	}

	public static String getDeleteSQL(int index)
	{
		return "delete from CUSTOMER where CUSTOMER_INDEX = " + index;
	}

	/*
	public void fromPreCustomer(PreCustomer src)
	{
		this._index = src._index;
		this._name = src._name;
		this._post = src._post;
		this._address1 = src._address1;
		this._address2 = src._address2;
		this._mobile = src._mobile;
		this._phone = src._phone;

		this._id = src._id;
		this._pwd = src._pwd;
		this._routes = src._routes;
		this._routeVal = src._routeVal;
		this._recommendIndex = src._recommendIndex;

		this._created = src._created;
	}
	*/

	public void fromResultSet(ResultSet rs)
	{
		try
		{
			this._index = rs.getInt("CUSTOMER_INDEX");
			this._name = rs.getString("NAME");
			this._post = rs.getString("POST");
			this._address1 = rs.getString("ADDRESS1");
			this._address2 = rs.getString("ADDRESS2");
			this._mobile = rs.getString("MOBILE");
			this._phone = rs.getString("PHONE");

			this._id = rs.getString("ID");
			this._pwd = rs.getString("PASSWORD");
			this._routes = rs.getString("ROUTES");
			this._routeVal = rs.getString("ROUTE_VAL");
			this._recommendIndex = rs.getInt("RECOMMEND_INDEX");

			this._memberIndex = rs.getInt("MEMBER_INDEX");
			this._branchIndex = rs.getInt("BRANCH_INDEX");
			this._memo = rs.getString("MEMO");
			this._smsURL = rs.getString("SMS_URL");
			this._smsSent = rs.getTimestamp("SMS_SENT");

			this._hospital = rs.getString("HOSPITAL");
			this._expectedDate = rs.getTimestamp("EXPECTED_DATE");
			this._operationDate = rs.getTimestamp("OPERATION_DATE");
			this._experiences = rs.getString("EXPERIENCES");
			this._babyTypeExpected = rs.getString("BABY_TYPE_EXPECTED");
			this._disabledType = rs.getString("DISABLED_TYPE");
			this._careCenter = rs.getString("CARE_CENTER");
			this._careCenterPeriod = rs.getString("CARE_CENTER_PERIOD");
			this._servicePlaceWish = rs.getString("SERVICE_PLACE_WISH");

			this._babyBirth = rs.getTimestamp("BABY_BIRTH");
			this._babyTypes = rs.getString("BABY_TYPES");
			this._childBirthType = rs.getString("CHILDBIRTH_TYPE");
			this._servicePlaceReal = rs.getString("SERVICE_PLACE_REAL");

			this._voucherType = rs.getString("VOUCHER_TYPE");
			this._voucherDays = rs.getInt("VOUCHER_DAYS");

			this._pets = rs.getString("PETS");
			this._cashReceipt = rs.getString("CASH_RECEIPT");

			this._rentalIndex = rs.getInt("RENTAL_INDEX");
			this._rentalBegin = rs.getTimestamp("RENTAL_BEGIN");
			this._rentalEnd = rs.getTimestamp("RENTAL_END");
			this._rentalDeliveryPayed = rs.getTimestamp("RENTAL_DELIVERY_PAYED");
			this._rentalDeliveryCost = rs.getInt("RENTAL_DELIVERY_COST");
			this._rentalPayed = rs.getTimestamp("RENTAL_PAYED");
			this._rentalCost = rs.getInt("RENTAL_COST");

			this._giftIndex1 = rs.getInt("GIFT_INDEX1");
			this._giftSent1 = rs.getTimestamp("GIFT_SENT1");
			this._giftIndex2 = rs.getInt("GIFT_INDEX2");
			this._giftSent2 = rs.getTimestamp("GIFT_SENT2");

			this._terminalIndex = rs.getInt("TERMINAL_INDEX");
			this._terminalBegin = rs.getTimestamp("TERMINAL_BEGIN");
			this._terminalEnd = rs.getTimestamp("TERMINAL_END");

			this._created = rs.getTimestamp("CREATED");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

