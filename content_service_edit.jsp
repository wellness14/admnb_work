<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!
	public void setUserDB(UserDB userdb)
	{
		_userdb = userdb;
		_options = _userdb.getServiceOptionList();
	}
	public UserDB _userdb;
	public List<ServiceOption> _options;
	public String _type;
	public String _weekWork;

	public ServiceOption getOption(int amountTypeIndex)
	{
		return getOption(_type, _weekWork, _amountTypes[amountTypeIndex]);
	}

	public ServiceOption getOption(String weekWork, String amountType)
	{
		return getOption(_type, weekWork, amountType);
	}

	public ServiceOption getOption(String type, String weekWork, String amountType)
	{
		String key = type + "_" + weekWork + "_" + amountType;
		//access via Iterator
		Iterator iterator = _options.iterator();
		while (iterator.hasNext())
		{
			ServiceOption option = (ServiceOption) iterator.next();
			if (option._type.equals(key))
			{
				return option;
			}
		}

		ServiceOption dummy = new ServiceOption();
		dummy._cost = 0;
		return dummy;
	}

	String[] _amountTypes = { "RESERVED", "BALANCE(5)", "BALANCE(6)", "TOTAL_5D", "TOTAL_6D" };
	public String getID(int index)
	{
		return "'" + _type + "_" + _weekWork + "_" + _amountTypes[index] + "'";
	}
	public String getIDs(int index)
	{
		return _type + "_" + _weekWork + "_" + _amountTypes[index];
	}
%>

<%
	//List<ServiceOption> options = _userdb.getServiceOptionList();
	setUserDB(_userdb);
	//DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

	//access via Iterator
	//Iterator iterator = options.iterator();
	//while (iterator.hasNext())
	{
		/*
		ServiceOption option = (ServiceOption) iterator.next();
		String s = "<tr>";
		s += "<td>" + msg.getReceiver() + "</td>";
		s += "<td>" + msg.getContent() + "</td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		s += "<td>" + df.format(msg.getSent().getTime()) + "</td>";
		s += "<td>";
		if (msg.getRead() != null)
		{
			df.format(msg.getRead().getTime());
		}
		else
		{
			s+= "읽지않음";
		}
		s += "</td>";
		s += "</tr>\n";
		out.write(s);
		*/
	}
	//_userdb.PrintLog("service.jsp");
%>
<html>
	<head>
		<title>Service Cost</title>
		<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
		<!--<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>-->
		<script>
			function setEditFields() {
				var basic = 0;
				var d5;
				var d6;
				<%
					_type = "BASIC";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "PREMIUM(C)";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "PREMIUM(I)";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<%
					_type = "VIP(C)";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "VIP(I)";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "PRIVATE(C)";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "PRIVATE(I)";
					_weekWork = "1W";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "2W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "3W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "4W"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "TWINS";
					_weekWork = "C4";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "I2C2"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "I4"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "MULTIPLES";
					_weekWork = "C4";
				%>

				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "I2C2"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;

				<% _weekWork = "I4"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "INTENSIVE(WORKINGMOM)";
				%>

				<% _weekWork = "I2C2"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "INTENSIVE(CAREHOME)";
				%>

				<% _weekWork = "I2C2"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "INTENSIVE(35)";
				%>

				<% _weekWork = "C4"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;


				<%
					_type = "INTENSIVE(HEAVY)";
				%>

				<% _weekWork = "C4"; %>
				basic = <%= getOption(0)._cost %>;
				d5 = <%= getOption(1)._cost %>;
				d6 = <%= getOption(2)._cost %>;
				document.getElementById(<%=getID(0)%>).value = basic;
				document.getElementById(<%=getID(1)%>).value = d5;
				document.getElementById(<%=getID(2)%>).value = d6;
				document.getElementById(<%=getID(3)%>).innerHTML = basic + d5;
				document.getElementById(<%=getID(4)%>).innerHTML = basic + d6;
			}

			$(document).ready(function() {
				$("#saveBasic").click(function() {
					$.post("_service_option_update.jsp", $("#Basic").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#savePremium").click(function() {
					$.post("_service_option_update.jsp", $("#Premium").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveVip").click(function() {
					$.post("_service_option_update.jsp", $("#Vip").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#savePrivate").click(function() {
					$.post("_service_option_update.jsp", $("#Private").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveTwins").click(function() {
					$.post("_service_option_update.jsp", $("#Twins").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveMultiples").click(function() {
					$.post("_service_option_update.jsp", $("#Multiples").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveIntensiveWorkingMom").click(function() {
					$.post("_service_option_update.jsp", $("#IntensiveWorkingMom").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveIntensiveCareHome").click(function() {
					$.post("_service_option_update.jsp", $("#IntensiveCareHome").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveIntensiveOver35").click(function() {
					$.post("_service_option_update.jsp", $("#IntensiveOver35").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveIntensiveHeavy").click(function() {
					$.post("_service_option_update.jsp", $("#IntensiveHeavy").serialize())
					.done(function(data) {
						location.reload();
					});
				});

				$("#moveService").click(function() {
					window.location.href = "content_service_edit.jsp";
				});
				$("#moveOption").click(function() {
					window.location.href = "content_option_edit.jsp";
				});
			});
			window.onload = setEditFields;
		</script>
	</head>
	<body>
		<p>
			<button type=button id="moveService">서비스</button>
			<button type=button id="moveOption">옵션</button>
		</p>
	<p>
		■ 베이직 서비스 <br/> 
		<% _type = "BASIC"; %>
		<form id="Basic">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveBasic">저장</button></td>
			</tr>
		</table>
		</form>
	</p>
	<p>
		■ 프리미엄 서비스 <br/> 
		<form id="Premium">
		<table border=1>
			<tr>
				<td align=center>주(출퇴근)</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _type = "PREMIUM(C)"; %>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center>주(입주)</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _type = "PREMIUM(I)"; %>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="savePremium">저장</button></td>
			</tr>
		</table>
		</form>
	</p>


	<p>
		■ vip 서비스 <br/> 
		<form id="Vip">
		<table border=1>
			<tr>
				<td align=center>주(출퇴근)</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _type = "VIP(C)"; %>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center>주(입주)</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _type = "VIP(I)"; %>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveVip">저장</button></td>
			</tr>
		</table>
		</form>
	</p>


	<p>
		■ 프라이빗 서비스 <br/> 
		<form id="Private">
		<table border=1>
			<tr>
				<td align=center>주(출퇴근)</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _type = "PRIVATE(C)"; %>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center>주(입주)</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _type = "PRIVATE(I)"; %>
				<% _weekWork = "1W"; %>
				<td align=center>1</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "2W"; %>
				<td align=center>2</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "3W"; %>
				<td align=center>3</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "4W"; %>
				<td align=center>4</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="savePrivate">저장</button></td>
			</tr>
		</table>
		</form>
	</p>

	<p>
		■ 다둥이 프로그램(쌍둥이 프로그램) <br/> 
		<% _type = "TWINS"; %>
		<form id="Twins">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "C4"; %>
				<td align=center>출퇴근4주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "I2C2"; %>
				<td align=center>입주2주+출퇴근2주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "I4"; %>
				<td align=center>입주4주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveTwins">저장</button></td>
			</tr>
		</table>
		</form>
	</p>

	<p>
		■ 다둥이 프로그램(다둥이 프로그램) <br/> 
		<% _type = "MULTIPLES"; %>
		<form id="Multiples">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "C4"; %>
				<td align=center>출퇴근4주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "I2C2"; %>
				<td align=center>입주2주+출퇴근2주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<% _weekWork = "I4"; %>
				<td align=center>입주4주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveMultiples">저장</button></td>
			</tr>
		</table>
		</form>
	</p>

	<p>
		■ 집중관리 프로그램(워킹맘 케어 프로그램) <br/> 
		<% _type = "INTENSIVE(WORKINGMOM)"; %>
		<form id="IntensiveWorkingMom">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "I2C2"; %>
				<td align=center>입주2주+출퇴근2주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveIntensiveWorkingMom">저장</button></td>
			</tr>
		</table>
		</form>
	</p>

	<p>
		■ 집중관리 프로그램(산후조리원 내집에 프로그램) <br/> 
		<% _type = "INTENSIVE(CAREHOME)"; %>
		<form id="IntensiveCareHome">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "I2C2"; %>
				<td align=center>입주2주+출퇴근2주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveIntensiveCareHome">저장</button></td>
			</tr>
		</table>
		</form>
	</p>

	<p>
		■ 집중관리 프로그램(35세 이상 산모 집중케어) <br/> 
		<% _type = "INTENSIVE(35)"; %>
		<form id="IntensiveOver35">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "C4"; %>
				<td align=center>출퇴근4주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveIntensiveOver35">저장</button></td>
			</tr>
		</table>
		</form>
	</p>

	<p>
		■ 집중관리 프로그램(과체중 산모케어) <br/> 
		<% _type = "INTENSIVE(HEAVY)"; %>
		<form id="IntensiveHeavy">
		<table border=1>
			<tr>
				<td align=center>주</td>
				<td align=center>예약금</td>
				<td align=center>잔금_주5일</td>
				<td align=center>주5일 합계금</td>
				<td align=center>잔금_주6일</td>
				<td align=center>주6일 합계금</td>
			</tr>
			<tr>
				<% _weekWork = "C4"; %>
				<td align=center>출퇴근4주</td>
				<td align=center><input type=text id=<%=getID(0)%> name=<%=getID(0)%>></td>
				<td align=center><input type=text id=<%=getID(1)%> name=<%=getID(1)%>></td>
				<td align=center><div id=<%=getID(3)%>></div></td>
				<td align=center><input type=text id=<%=getID(2)%> name=<%=getID(2)%>></td>
				<td align=center><div id=<%=getID(4)%>></div></td>
			</tr>
			<tr>
				<td align=center colspan=6><button type=button id="saveIntensiveHeavy">저장</button></td>
			</tr>
		</table>
		</form>
	</p>
	</body>
</html>
