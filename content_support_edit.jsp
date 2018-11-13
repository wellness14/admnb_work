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

	public String _prefix = "";
	public ServiceOption getOption(String type)
	{
		//access via Iterator
		Iterator iterator = _options.iterator();
		while (iterator.hasNext())
		{
			ServiceOption option = (ServiceOption) iterator.next();
			if (option._type.equals(type))
			{
				return option;
			}
		}

		ServiceOption dummy = new ServiceOption();
		dummy._cost = 0;
		return dummy;
	}

	public String scriptSetCost(String id)
	{
		id = _prefix + "_" + id;
		return "document.getElementById('" + id + "').value = " + getOption(id)._cost + ";";
	}

	public String tagInput(String id)
	{
		id = _prefix + "_" + id;
		return "<input type=text size=10 id='" + id + "' name='" + id + "'>";
	}
%>

<%
	setUserDB(_userdb);
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
			<% _prefix = "SUP-A-GA"; %>
				<%= scriptSetCost("1ST_D05") %>
				<%= scriptSetCost("1ST_D10") %>
				<%= scriptSetCost("1ST_D15") %>
				<%= scriptSetCost("1ST_SHT_GOV") %>
				<%= scriptSetCost("1ST_SHT_SLF") %>
				<%= scriptSetCost("1ST_STD_GOV") %>
				<%= scriptSetCost("1ST_STD_SLF") %>
				<%= scriptSetCost("1ST_EXT_GOV") %>
				<%= scriptSetCost("1ST_EXT_SLF") %>

				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-A-NA"; %>
				<%= scriptSetCost("1ST_D05") %>
				<%= scriptSetCost("1ST_D10") %>
				<%= scriptSetCost("1ST_D15") %>
				<%= scriptSetCost("1ST_SHT_GOV") %>
				<%= scriptSetCost("1ST_SHT_SLF") %>
				<%= scriptSetCost("1ST_STD_GOV") %>
				<%= scriptSetCost("1ST_STD_SLF") %>
				<%= scriptSetCost("1ST_EXT_GOV") %>
				<%= scriptSetCost("1ST_EXT_SLF") %>

				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-A-DA"; %>
				<%= scriptSetCost("1ST_D05") %>
				<%= scriptSetCost("1ST_D10") %>
				<%= scriptSetCost("1ST_D15") %>
				<%= scriptSetCost("1ST_SHT_GOV") %>
				<%= scriptSetCost("1ST_SHT_SLF") %>
				<%= scriptSetCost("1ST_STD_GOV") %>
				<%= scriptSetCost("1ST_STD_SLF") %>
				<%= scriptSetCost("1ST_EXT_GOV") %>
				<%= scriptSetCost("1ST_EXT_SLF") %>

				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-A-RA"; %>
				<%= scriptSetCost("1ST_D05") %>
				<%= scriptSetCost("1ST_D10") %>
				<%= scriptSetCost("1ST_D15") %>
				<%= scriptSetCost("1ST_SHT_GOV") %>
				<%= scriptSetCost("1ST_SHT_SLF") %>
				<%= scriptSetCost("1ST_STD_GOV") %>
				<%= scriptSetCost("1ST_STD_SLF") %>
				<%= scriptSetCost("1ST_EXT_GOV") %>
				<%= scriptSetCost("1ST_EXT_SLF") %>

				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

				/*********************************************************
				*********************************************************/

			<% _prefix = "SUP-B-GA"; %>
				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-B-NA"; %>
				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-B-DA"; %>
				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-B-RA"; %>
				<%= scriptSetCost("2ND_D05") %>
				<%= scriptSetCost("2ND_D10") %>
				<%= scriptSetCost("2ND_D15") %>
				<%= scriptSetCost("2ND_SHT_GOV") %>
				<%= scriptSetCost("2ND_SHT_SLF") %>
				<%= scriptSetCost("2ND_STD_GOV") %>
				<%= scriptSetCost("2ND_STD_SLF") %>
				<%= scriptSetCost("2ND_EXT_GOV") %>
				<%= scriptSetCost("2ND_EXT_SLF") %>

				<%= scriptSetCost("3RD_D05") %>
				<%= scriptSetCost("3RD_D10") %>
				<%= scriptSetCost("3RD_D15") %>
				<%= scriptSetCost("3RD_SHT_GOV") %>
				<%= scriptSetCost("3RD_SHT_SLF") %>
				<%= scriptSetCost("3RD_STD_GOV") %>
				<%= scriptSetCost("3RD_STD_SLF") %>
				<%= scriptSetCost("3RD_EXT_GOV") %>
				<%= scriptSetCost("3RD_EXT_SLF") %>

			<% _prefix = "SUP-C"; %>
				<%= scriptSetCost("GA_D05") %>
				<%= scriptSetCost("GA_D10") %>
				<%= scriptSetCost("GA_D15") %>
				<%= scriptSetCost("GA_SHT_GOV") %>
				<%= scriptSetCost("GA_SHT_SLF") %>
				<%= scriptSetCost("GA_STD_GOV") %>
				<%= scriptSetCost("GA_STD_SLF") %>
				<%= scriptSetCost("GA_EXT_GOV") %>
				<%= scriptSetCost("GA_EXT_SLF") %>

				<%= scriptSetCost("NA_D05") %>
				<%= scriptSetCost("NA_D10") %>
				<%= scriptSetCost("NA_D15") %>
				<%= scriptSetCost("NA_SHT_GOV") %>
				<%= scriptSetCost("NA_SHT_SLF") %>
				<%= scriptSetCost("NA_STD_GOV") %>
				<%= scriptSetCost("NA_STD_SLF") %>
				<%= scriptSetCost("NA_EXT_GOV") %>
				<%= scriptSetCost("NA_EXT_SLF") %>

				<%= scriptSetCost("DA_D05") %>
				<%= scriptSetCost("DA_D10") %>
				<%= scriptSetCost("DA_D15") %>
				<%= scriptSetCost("DA_SHT_GOV") %>
				<%= scriptSetCost("DA_SHT_SLF") %>
				<%= scriptSetCost("DA_STD_GOV") %>
				<%= scriptSetCost("DA_STD_SLF") %>
				<%= scriptSetCost("DA_EXT_GOV") %>
				<%= scriptSetCost("DA_EXT_SLF") %>

				<%= scriptSetCost("RA_D05") %>
				<%= scriptSetCost("RA_D10") %>
				<%= scriptSetCost("RA_D15") %>
				<%= scriptSetCost("RA_SHT_GOV") %>
				<%= scriptSetCost("RA_SHT_SLF") %>
				<%= scriptSetCost("RA_STD_GOV") %>
				<%= scriptSetCost("RA_STD_SLF") %>
				<%= scriptSetCost("RA_EXT_GOV") %>
				<%= scriptSetCost("RA_EXT_SLF") %>
			}

			$(document).ready(function() {
				$("#saveA_Ga").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-A-GA").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveA_Na").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-A-NA").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveA_Da").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-A-DA").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveA_Ra").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-A-RA").serialize())
					.done(function(data) {
						location.reload();
					});
				});

				$("#saveB_Ga").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-B-GA").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveB_Na").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-B-NA").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveB_Da").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-B-DA").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveB_Ra").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-B-RA").serialize())
					.done(function(data) {
						location.reload();
					});
				});

				$("#saveC").click(function() {
					$.post("_service_option_update.jsp", $("#SUP-C").serialize())
					.done(function(data) {
						location.reload();
					});
				});
			});
			window.onload = setEditFields;
		</script>
	</head>
	<body>
		<p>
			■ 단태아_A-가 군 입력 <br/> 
			<% _prefix = "SUP-A-GA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>첫째아</td>
					<td align=center>A-가-1</td>
					<td align=center><%= tagInput("1ST_D05") %></td>
					<td align=center><%= tagInput("1ST_D10") %></td>
					<td align=center><%= tagInput("1ST_D15") %></td>
					<td align=center><%= tagInput("1ST_SHT_GOV") %></td>
					<td align=center><%= tagInput("1ST_SHT_SLF") %></td>
					<td align=center><%= tagInput("1ST_STD_GOV") %></td>
					<td align=center><%= tagInput("1ST_STD_SLF") %></td>
					<td align=center><%= tagInput("1ST_EXT_GOV") %></td>
					<td align=center><%= tagInput("1ST_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>A-가-2</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>A-가-3</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveA_Ga">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 단태아_A-나 군 입력 <br/> 
			<% _prefix = "SUP-A-NA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>첫째아</td>
					<td align=center>A-나-1</td>
					<td align=center><%= tagInput("1ST_D05") %></td>
					<td align=center><%= tagInput("1ST_D10") %></td>
					<td align=center><%= tagInput("1ST_D15") %></td>
					<td align=center><%= tagInput("1ST_SHT_GOV") %></td>
					<td align=center><%= tagInput("1ST_SHT_SLF") %></td>
					<td align=center><%= tagInput("1ST_STD_GOV") %></td>
					<td align=center><%= tagInput("1ST_STD_SLF") %></td>
					<td align=center><%= tagInput("1ST_EXT_GOV") %></td>
					<td align=center><%= tagInput("1ST_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>A-나-2</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>A-나-3</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveA_Na">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 단태아_A-다 군 입력 <br/> 
			<% _prefix = "SUP-A-DA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>첫째아</td>
					<td align=center>A-다-1</td>
					<td align=center><%= tagInput("1ST_D05") %></td>
					<td align=center><%= tagInput("1ST_D10") %></td>
					<td align=center><%= tagInput("1ST_D15") %></td>
					<td align=center><%= tagInput("1ST_SHT_GOV") %></td>
					<td align=center><%= tagInput("1ST_SHT_SLF") %></td>
					<td align=center><%= tagInput("1ST_STD_GOV") %></td>
					<td align=center><%= tagInput("1ST_STD_SLF") %></td>
					<td align=center><%= tagInput("1ST_EXT_GOV") %></td>
					<td align=center><%= tagInput("1ST_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>A-다-2</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>A-다-3</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveA_Da">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 단태아_A-라 군 입력 <br/> 
			<% _prefix = "SUP-A-RA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>첫째아</td>
					<td align=center>A-라-1</td>
					<td align=center><%= tagInput("1ST_D05") %></td>
					<td align=center><%= tagInput("1ST_D10") %></td>
					<td align=center><%= tagInput("1ST_D15") %></td>
					<td align=center><%= tagInput("1ST_SHT_GOV") %></td>
					<td align=center><%= tagInput("1ST_SHT_SLF") %></td>
					<td align=center><%= tagInput("1ST_STD_GOV") %></td>
					<td align=center><%= tagInput("1ST_STD_SLF") %></td>
					<td align=center><%= tagInput("1ST_EXT_GOV") %></td>
					<td align=center><%= tagInput("1ST_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>A-라-2</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>A-라-3</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveA_Ra">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<!-------------------------------------------------------------------------------
		---------------------------------------------------------------------------------
		-------------------------------------------------------------------------------->

		<p>
			■ 쌍태아_B-가 군 입력 <br/> 
			<% _prefix = "SUP-B-GA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>B-가-1</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>B-가-2</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveB_Ga">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 쌍태아_B-나 군 입력 <br/> 
			<% _prefix = "SUP-B-NA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>B-나-1</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>B-나-2</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveB_Na">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 쌍태아_B-다 군 입력 <br/> 
			<% _prefix = "SUP-B-DA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>B-다-1</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>B-다-2</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveB_Da">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 단태아_B-라 군 입력 <br/> 
			<% _prefix = "SUP-B-RA"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>둘째아</td>
					<td align=center>B-라-1</td>
					<td align=center><%= tagInput("2ND_D05") %></td>
					<td align=center><%= tagInput("2ND_D10") %></td>
					<td align=center><%= tagInput("2ND_D15") %></td>
					<td align=center><%= tagInput("2ND_SHT_GOV") %></td>
					<td align=center><%= tagInput("2ND_SHT_SLF") %></td>
					<td align=center><%= tagInput("2ND_STD_GOV") %></td>
					<td align=center><%= tagInput("2ND_STD_SLF") %></td>
					<td align=center><%= tagInput("2ND_EXT_GOV") %></td>
					<td align=center><%= tagInput("2ND_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>셋째아 이상</td>
					<td align=center>B-라-2</td>
					<td align=center><%= tagInput("3RD_D05") %></td>
					<td align=center><%= tagInput("3RD_D10") %></td>
					<td align=center><%= tagInput("3RD_D15") %></td>
					<td align=center><%= tagInput("3RD_SHT_GOV") %></td>
					<td align=center><%= tagInput("3RD_SHT_SLF") %></td>
					<td align=center><%= tagInput("3RD_STD_GOV") %></td>
					<td align=center><%= tagInput("3RD_STD_SLF") %></td>
					<td align=center><%= tagInput("3RD_EXT_GOV") %></td>
					<td align=center><%= tagInput("3RD_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveB_Ra">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<!-------------------------------------------------------------------------------
		---------------------------------------------------------------------------------
		-------------------------------------------------------------------------------->

		<p>
			■ 삼태아_C-가/나/다/라 군 입력 <br/> 
			<% _prefix = "SUP-C"; %>
			<form id='<%= _prefix %>'>
			<table border=1>
				<tr>
					<td colspan=2></td>
					<td align=center colspan=3>서비스기간 및 서비스 상한가</td>
					<td align=center colspan=2>단축</td>
					<td align=center colspan=2>표준</td>
					<td align=center colspan=2>연장</td>
				</tr>
				<tr>
					<td align=center>출산순위</td>
					<td align=center>소득유형</td>
					<td align=center>단축</td>
					<td align=center>표준</td>
					<td align=center>연장</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
					<td align=center>정부지원금</td>
					<td align=center>본인부담금</td>
				</tr>
				<tr>
					<td align=center>삼태아이상<br/>중증장애산모</td>
					<td align=center>C-가</td>
					<td align=center><%= tagInput("GA_D05") %></td>
					<td align=center><%= tagInput("GA_D10") %></td>
					<td align=center><%= tagInput("GA_D15") %></td>
					<td align=center><%= tagInput("GA_SHT_GOV") %></td>
					<td align=center><%= tagInput("GA_SHT_SLF") %></td>
					<td align=center><%= tagInput("GA_STD_GOV") %></td>
					<td align=center><%= tagInput("GA_STD_SLF") %></td>
					<td align=center><%= tagInput("GA_EXT_GOV") %></td>
					<td align=center><%= tagInput("GA_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>삼태아이상<br/>중증장애산모</td>
					<td align=center>C-나</td>
					<td align=center><%= tagInput("NA_D05") %></td>
					<td align=center><%= tagInput("NA_D10") %></td>
					<td align=center><%= tagInput("NA_D15") %></td>
					<td align=center><%= tagInput("NA_SHT_GOV") %></td>
					<td align=center><%= tagInput("NA_SHT_SLF") %></td>
					<td align=center><%= tagInput("NA_STD_GOV") %></td>
					<td align=center><%= tagInput("NA_STD_SLF") %></td>
					<td align=center><%= tagInput("NA_EXT_GOV") %></td>
					<td align=center><%= tagInput("NA_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>삼태아이상<br/>중증장애산모</td>
					<td align=center>C-다</td>
					<td align=center><%= tagInput("DA_D05") %></td>
					<td align=center><%= tagInput("DA_D10") %></td>
					<td align=center><%= tagInput("DA_D15") %></td>
					<td align=center><%= tagInput("DA_SHT_GOV") %></td>
					<td align=center><%= tagInput("DA_SHT_SLF") %></td>
					<td align=center><%= tagInput("DA_STD_GOV") %></td>
					<td align=center><%= tagInput("DA_STD_SLF") %></td>
					<td align=center><%= tagInput("DA_EXT_GOV") %></td>
					<td align=center><%= tagInput("DA_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center>삼태아이상<br/>중증장애산모</td>
					<td align=center>C-라</td>
					<td align=center><%= tagInput("RA_D05") %></td>
					<td align=center><%= tagInput("RA_D10") %></td>
					<td align=center><%= tagInput("RA_D15") %></td>
					<td align=center><%= tagInput("RA_SHT_GOV") %></td>
					<td align=center><%= tagInput("RA_SHT_SLF") %></td>
					<td align=center><%= tagInput("RA_STD_GOV") %></td>
					<td align=center><%= tagInput("RA_STD_SLF") %></td>
					<td align=center><%= tagInput("RA_EXT_GOV") %></td>
					<td align=center><%= tagInput("RA_EXT_SLF") %></td>
				</tr>
				<tr>
					<td align=center colspan=11><button type=button id="saveC">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

	</body>
</html>
