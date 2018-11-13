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

	public String tagInput(String id)
	{
		return "<input type=text id='" + id + "' name='" + id + "'>";
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
				<%= scriptSetCost("50_1") %>
				<%= scriptSetCost("50_1_COM") %>
				<%= scriptSetCost("50_1_REG") %>

				<%= scriptSetCost("50_2") %>
				<%= scriptSetCost("50_2_COM") %>
				<%= scriptSetCost("50_2_REG") %>

				<%= scriptSetCost("50_3") %>
				<%= scriptSetCost("50_3_COM") %>
				<%= scriptSetCost("50_3_REG") %>


				<%= scriptSetCost("60_1") %>
				<%= scriptSetCost("60_1_COM") %>
				<%= scriptSetCost("60_1_REG") %>

				<%= scriptSetCost("60_2") %>
				<%= scriptSetCost("60_2_COM") %>
				<%= scriptSetCost("60_2_REG") %>

				<%= scriptSetCost("60_3") %>
				<%= scriptSetCost("60_3_COM") %>
				<%= scriptSetCost("60_3_REG") %>


				<%= scriptSetCost("80_1") %>
				<%= scriptSetCost("80_1_COM") %>
				<%= scriptSetCost("80_1_REG") %>

				<%= scriptSetCost("80_2") %>
				<%= scriptSetCost("80_2_COM") %>
				<%= scriptSetCost("80_2_REG") %>

				<%= scriptSetCost("80_3") %>
				<%= scriptSetCost("80_3_COM") %>
				<%= scriptSetCost("80_3_REG") %>
			}

			$(document).ready(function() {
				$("#save50").click(function() {
					$.post("_service_option_update.jsp", $("#50").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#save60").click(function() {
					$.post("_service_option_update.jsp", $("#60").serialize())
					.done(function(data) {
						location.reload();
					});
				});
				$("#save80").click(function() {
					$.post("_service_option_update.jsp", $("#80").serialize())
					.done(function(data) {
						location.reload();
					});
				});

/*
				$("#moveService").click(function() {
					window.location.href = "content_service_edit.jsp";
				});
				$("#moveOption").click(function() {
					window.location.href = "content_option_edit.jsp";
				});
*/
			});
			window.onload = setEditFields;
		</script>
	</head>
	<body>
		<p>
			■ 50% 판정 기준 <br/> 
			<form id="50">
			<table border=1>
				<tr>
					<td align=center>가구원수</td>
					<td align=center>건강보험료 본인부담금 직장가입자(원)</td>
					<td align=center>건강보험료 본인부담금 지역가입자(원)</td>
					<td align=center>건강보험료 본인부담금 직장+지역(원)</td>
				</tr>
				<tr>
					<td align=center><%= tagInput("50_1") %></td>
					<td align=center><%= tagInput("50_1_COM") %></td>
					<td align=center><%= tagInput("50_1_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center><%= tagInput("50_2") %></td>
					<td align=center><%= tagInput("50_2_COM") %></td>
					<td align=center><%= tagInput("50_2_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center><%= tagInput("50_3") %></td>
					<td align=center><%= tagInput("50_3_COM") %></td>
					<td align=center><%= tagInput("50_3_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="save50">저장</button></td>
				</tr>
			</table>
			</form>
		</p>

		<p>
			■ 60% 판정 기준 <br/> 
			<form id="60">
			<table border=1>
				<tr>
					<td align=center>가구원수</td>
					<td align=center>건강보험료 본인부담금 직장가입자(원)</td>
					<td align=center>건강보험료 본인부담금 지역가입자(원)</td>
					<td align=center>건강보험료 본인부담금 직장+지역(원)</td>
				</tr>
				<tr>
					<td align=center><%= tagInput("60_1") %></td>
					<td align=center><%= tagInput("60_1_COM") %></td>
					<td align=center><%= tagInput("60_1_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center><%= tagInput("60_2") %></td>
					<td align=center><%= tagInput("60_2_COM") %></td>
					<td align=center><%= tagInput("60_2_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center><%= tagInput("60_3") %></td>
					<td align=center><%= tagInput("60_3_COM") %></td>
					<td align=center><%= tagInput("60_3_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="save60">저장</button></td>
				</tr>
			</table>
			</form>
		</p>


		<p>
			■ 80% 판정 기준 <br/> 
			<form id="80">
			<table border=1>
				<tr>
					<td align=center>가구원수</td>
					<td align=center>건강보험료 본인부담금 직장가입자(원)</td>
					<td align=center>건강보험료 본인부담금 지역가입자(원)</td>
					<td align=center>건강보험료 본인부담금 직장+지역(원)</td>
				</tr>
				<tr>
					<td align=center><%= tagInput("80_1") %></td>
					<td align=center><%= tagInput("80_1_COM") %></td>
					<td align=center><%= tagInput("80_1_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center><%= tagInput("80_2") %></td>
					<td align=center><%= tagInput("80_2_COM") %></td>
					<td align=center><%= tagInput("80_2_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center><%= tagInput("80_3") %></td>
					<td align=center><%= tagInput("80_3_COM") %></td>
					<td align=center><%= tagInput("80_3_REG") %></td>
					<td align=center><input type=text></td>
				</tr>
				<tr>
					<td align=center colspan=6><button type=button id="save80">저장</button></td>
				</tr>
			</table>
			</form>
		</p>
	</body>
</html>
