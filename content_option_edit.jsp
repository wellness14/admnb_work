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
		return "document.getElementById('" + id + "').value = " + getOption(id)._cost + ";";
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
				<%= scriptSetCost("EXTENDED_COMMUTE_NOSCHOOL") %>
				<%= scriptSetCost("EXTENDED_COMMUTE_SCHOOL") %>
				<%= scriptSetCost("EXTENDED_COMMUTE_FAMILY") %>
				<%= scriptSetCost("EXTENDED_COMMUTE_TWIN") %>
				<%= scriptSetCost("EXTENDED_INHOUSE_NOSCHOOL") %>
				<%= scriptSetCost("EXTENDED_INHOUSE_SCHOOL") %>
				<%= scriptSetCost("EXTENDED_INHOUSE_FAMILY") %>
				<%= scriptSetCost("EXTENDED_INHOUSE_TWIN") %>

				<%= scriptSetCost("OVERTIME_COMMUTE_BASIC") %>
				<%= scriptSetCost("OVERTIME_COMMUTE_PREMIUM") %>
				<%= scriptSetCost("OVERTIME_COMMUTE_VIP") %>
				<%= scriptSetCost("OVERTIME_COMMUTE_PRIVATE") %>
				<%= scriptSetCost("OVERTIME_COMMUTE_MULTIPLE") %>
				<%= scriptSetCost("OVERTIME_COMMUTE_INTENSIVE") %>

				<%= scriptSetCost("OVERTIME_INHOUSE_BASIC") %>
				<%= scriptSetCost("OVERTIME_INHOUSE_PREMIUM") %>
				<%= scriptSetCost("OVERTIME_INHOUSE_VIP") %>
				<%= scriptSetCost("OVERTIME_INHOUSE_PRIVATE") %>
				<%= scriptSetCost("OVERTIME_INHOUSE_MULTIPLE") %>
				<%= scriptSetCost("OVERTIME_INHOUSE_INTENSIVE") %>

				<%= scriptSetCost("HOLYDAY_COMMUTE_BASIC") %>
				<%= scriptSetCost("HOLYDAY_COMMUTE_PREMIUM") %>
				<%= scriptSetCost("HOLYDAY_COMMUTE_VIP") %>
				<%= scriptSetCost("HOLYDAY_COMMUTE_PRIVATE") %>
				<%= scriptSetCost("HOLYDAY_COMMUTE_MULTIPLE") %>
				<%= scriptSetCost("HOLYDAY_COMMUTE_INTENSIVE") %>

				<%= scriptSetCost("HOLYDAY_INHOUSE_BASIC") %>
				<%= scriptSetCost("HOLYDAY_INHOUSE_PREMIUM") %>
				<%= scriptSetCost("HOLYDAY_INHOUSE_VIP") %>
				<%= scriptSetCost("HOLYDAY_INHOUSE_PRIVATE") %>
				<%= scriptSetCost("HOLYDAY_INHOUSE_MULTIPLE") %>
				<%= scriptSetCost("HOLYDAY_INHOUSE_INTENSIVE") %>
			}

			$(document).ready(function() {
				$("#saveExtended").click(function() {
					$.post("_service_option_update.jsp", $("#Extended").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveOvertimeCommute").click(function() {
					$.post("_service_option_update.jsp", $("#OvertimeCommute").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveOvertimeInhouse").click(function() {
					$.post("_service_option_update.jsp", $("#OvertimeInhouse").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveHolydayCommute").click(function() {
					//alert($("#HolydayCommute").serialize());
					$.post("_service_option_update.jsp", $("#HolydayCommute").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#saveHolydayInhouse").click(function() {
					$.post("_service_option_update.jsp", $("#HolydayInhouse").serialize())
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
			■ 추가 비용 <br/> 
			<form id="Extended">
			<table border=1>
				<tr>
					<td align=center>구분</td>
					<td align=center>미취학아동</td>
					<td align=center>취학아동</td>
					<td align=center>추가가족</td>
					<td align=center>쌍둥이케어</td>
				</tr>
				<tr>
					<td align=center>출퇴근</td>
					<td align=center><input type=text id="EXTENDED_COMMUTE_NOSCHOOL" name="EXTENDED_COMMUTE_NOSCHOOL"></td>
					<td align=center><input type=text id="EXTENDED_COMMUTE_SCHOOL" name="EXTENDED_COMMUTE_SCHOOL"></td>
					<td align=center><input type=text id="EXTENDED_COMMUTE_FAMILY" name="EXTENDED_COMMUTE_FAMILY"></td>
					<td align=center><input type=text id="EXTENDED_COMMUTE_TWIN" name="EXTENDED_COMMUTE_TWIN"></td>
				</tr>
				<tr>
					<td align=center>입주</td>
					<td align=center><input type=text id="EXTENDED_INHOUSE_NOSCHOOL" name="EXTENDED_INHOUSE_NOSCHOOL"></td>
					<td align=center><input type=text id="EXTENDED_INHOUSE_SCHOOL" name="EXTENDED_INHOUSE_SCHOOL"></td>
					<td align=center><input type=text id="EXTENDED_INHOUSE_FAMILY" name="EXTENDED_INHOUSE_FAMILY"></td>
					<td align=center><input type=text id="EXTENDED_INHOUSE_TWIN" name="EXTENDED_COMMUTE_TWIN"></td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="saveExtended">저장</button></td>
				</tr>
			</table>
			</form>
		</p>
		<p>
			■ 시간초과(출퇴근) <br/> 
			<form id="OvertimeCommute">
			<table border=1>
				<tr>
					<td align=center>베이직</td>
					<td align=center><input type=text id="OVERTIME_COMMUTE_BASIC" name="OVERTIME_COMMUTE_BASIC"> 원</td>
					<td align=center>프리미엄</td>
					<td align=center><input type=text id="OVERTIME_COMMUTE_PREMIUM" name="OVERTIME_COMMUTE_PREMIUM"> 원</td>
				</tr>
				<tr>
					<td align=center>VIP</td>
					<td align=center><input type=text id="OVERTIME_COMMUTE_VIP" name="OVERTIME_COMMUTE_VIP"> 원</td>
					<td align=center>프라이빗</td>
					<td align=center><input type=text id="OVERTIME_COMMUTE_PRIVATE" name="OVERTIME_COMMUTE_PRIVATE"> 원</td>
				</tr>
				<tr>
					<td align=center>다둥이</td>
					<td align=center><input type=text id="OVERTIME_COMMUTE_MULTIPLE" name="OVERTIME_COMMUTE_MULTIPLE"> 원</td>
					<td align=center>집중관리</td>
					<td align=center><input type=text id="OVERTIME_COMMUTE_INTENSIVE" name="OVERTIME_COMMUTE_INTENSIVE"> 원</td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="saveOvertimeCommute">저장</button></td>
				</tr>
			</table>
			</form>
		</p>
		<p>
			■ 시간초과(입주) <br/> 
			<form id="OvertimeInhouse">
			<table border=1>
				<tr>
					<td align=center>베이직</td>
					<td align=center><input type=text id="OVERTIME_INHOUSE_BASIC" name="OVERTIME_INHOUSE_BASIC"> 원</td>
					<td align=center>프리미엄</td>
					<td align=center><input type=text id="OVERTIME_INHOUSE_PREMIUM" name="OVERTIME_INHOUSE_PREMIUM"> 원</td>
				</tr>
				<tr>
					<td align=center>VIP</td>
					<td align=center><input type=text id="OVERTIME_INHOUSE_VIP" name="OVERTIME_INHOUSE_VIP"> 원</td>
					<td align=center>프라이빗</td>
					<td align=center><input type=text id="OVERTIME_INHOUSE_PRIVATE" name="OVERTIME_INHOUSE_PRIVATE"> 원</td>
				</tr>
				<tr>
					<td align=center>다둥이</td>
					<td align=center><input type=text id="OVERTIME_INHOUSE_MULTIPLE" name="OVERTIME_INHOUSE_MULTIPLE"> 원</td>
					<td align=center>집중관리</td>
					<td align=center><input type=text id="OVERTIME_INHOUSE_INTENSIVE" name="OVERTIME_INHOUSE_INTENSIVE"> 원</td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="saveOvertimeInhouse">저장</button></td>
				</tr>
			</table>
			</form>
		</p>


		<p>
			■ 휴일근무(출퇴근) <br/> 
			<form id="HolydayCommute">
			<table border=1>
				<tr>
					<td align=center>베이직</td>
					<td align=center><input type=text id="HOLYDAY_COMMUTE_BASIC" name="HOLYDAY_COMMUTE_BASIC"> 원</td>
					<td align=center>프리미엄</td>
					<td align=center><input type=text id="HOLYDAY_COMMUTE_PREMIUM" name="HOLYDAY_COMMUTE_PREMIUM"> 원</td>
				</tr>
				<tr>
					<td align=center>VIP</td>
					<td align=center><input type=text id="HOLYDAY_COMMUTE_VIP" name="HOLYDAY_COMMUTE_VIP"> 원</td>
					<td align=center>프라이빗</td>
					<td align=center><input type=text id="HOLYDAY_COMMUTE_PRIVATE" name="HOLYDAY_COMMUTE_PRIVATE"> 원</td>
				</tr>
				<tr>
					<td align=center>다둥이</td>
					<td align=center><input type=text id="HOLYDAY_COMMUTE_MULTIPLE" name="HOLYDAY_COMMUTE_MULTIPLE"> 원</td>
					<td align=center>집중관리</td>
					<td align=center><input type=text id="HOLYDAY_COMMUTE_INTENSIVE" name="HOLYDAY_COMMUTE_INTENSIVE"> 원</td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="saveHolydayCommute">저장</button></td>
				</tr>
			</table>
			</form>
		</p>
		<p>
			■ 휴일근무(입주) <br/> 
			<form id="HolydayInhouse">
			<table border=1>
				<tr>
					<td align=center>베이직</td>
					<td align=center><input type=text id="HOLYDAY_INHOUSE_BASIC" name="HOLYDAY_INHOUSE_BASIC"> 원</td>
					<td align=center>프리미엄</td>
					<td align=center><input type=text id="HOLYDAY_INHOUSE_PREMIUM" name="HOLYDAY_INHOUSE_PREMIUM"> 원</td>
				</tr>
				<tr>
					<td align=center>VIP</td>
					<td align=center><input type=text id="HOLYDAY_INHOUSE_VIP" name="HOLYDAY_INHOUSE_VIP"> 원</td>
					<td align=center>프라이빗</td>
					<td align=center><input type=text id="HOLYDAY_INHOUSE_PRIVATE" name="HOLYDAY_INHOUSE_PRIVATE"> 원</td>
				</tr>
				<tr>
					<td align=center>다둥이</td>
					<td align=center><input type=text id="HOLYDAY_INHOUSE_MULTIPLE" name="HOLYDAY_INHOUSE_MULTIPLE"> 원</td>
					<td align=center>집중관리</td>
					<td align=center><input type=text id="HOLYDAY_INHOUSE_INTENSIVE" name="HOLYDAY_INHOUSE_INTENSIVE"> 원</td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="saveHolydayInhouse">저장</button></td>
				</tr>
			</table>
			</form>
		</p>
	</body>
</html>
