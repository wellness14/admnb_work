<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsAll;
	List<Region> lstRegionsGroup;
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
	int _region = -1;

	int calcAge(String social)
	{
		if (social.length() < 14)
		{
			return -1;
		}

		int curYear = Calendar.getInstance().get(Calendar.YEAR);
		int year = Integer.parseInt(social.substring(0, 2));
		String[] socials = social.split("-");

		char temp = socials[1].charAt(0);
		boolean is2000s = ((temp == '3') || (temp == '4'));
		if (is2000s)
		{
			year += 2000;
		}
		else
		{
			year += 1900;
		}

		return curYear - year + 1;
	}
%>

<%
	int index = -1;
	Terms item = null;
	String temp = request.getParameter("REGION");

	lstRegionsGroup = _userdb.getRegionList(-1);
	lstRegionsAll = _userdb.getRegionList(0);
	if (temp != null)
	{
		_region = Integer.parseInt(temp);
	}
	else
	{
		_region = -1;
	}
	//list = _userdb.getTermsList(_type);
/*
	if (request.getParameter("index") != null)
	{
		index = Integer.parseInt((String)request.getParameter("index"));
		item = _userdb.getTerms(index);
		if (item == null)
		{
			index = -1;
		}
	}
*/
	//_userdb.PrintLog("service.jsp");
%>

<html>
	<head>
		<title>Wellness Login</title>
		<script
		src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
		<script>
			var type = '';

			class Region {
				constructor(index, name, upper) {
					this._index = index;
					this._name = name;
					this._upper = upper;
				}
			}
			var regions = [
			<%
				for (Iterator it = lstRegionsAll.iterator(); it.hasNext(); )
				{
					Region r = (Region)it.next();
					out.write("new Region(" + r._index + ", '" + r._name + "', " + r._upper + "),");
				}
			%>
			];

			function changedRegion() {
				var html = "";
				for (var i = 0; i < regions.length; i++) {
					if (regions[i]._upper == $("#region").val()) {
						html += "<input type='checkbox' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
					}
				}
				document.getElementById('sub').innerHTML = html;
			}

			function setEditFields() {
				//alert("init:" + <%=index%>);
				changedRegion();

				$.get("_helper_list.jsp")
				.fail(function(response) {
					//alert('Error: ' + response.responseText);
					document.getElementById('result').innerHTML = response.responseText;
					//$("#CONTENTS").val(response.responseText);
				})
				.done(function(data) {
					//alert(data);
					document.getElementById('result').innerHTML = data;
					//location.reload();
				});
			}

			function setRegion(index) {
				//alert(index);
				//var boxs = document.getElementsByName("REGION");
				var boxs = document.getElementsByName("REGION");
				for (var i = 0; i < boxs.length; i++) {
					if (boxs[i].value != index)
						boxs[i].checked = false;
					else
						boxs[i].checked = true;
				}
				//alert()
			}

			function viewHelper(index) {
				window.location.href = 'content_helper_view.jsp?HELPER=' + index;
			}

			function changeRegion(index) {
				window.location.href = 'content_branch_list.jsp?REGION=' + index;
			}

			$(document).ready(function() {
				$("#search").click(function() {
					//alert($("#term").serialize() + "&INDEX=" + <%= index %>);
					var val = $("#searchPattern").serialize();
					//alert('저장합니다[' + val + "]");
					//alert(val);
					//$.post("_terminal_update.jsp", $("#term").serialize() + "&INDEX=" + '<%= index %>')
					$.post("_helper_list.jsp", val)
					.fail(function(response) {
						document.getElementById('result').innerHTML = response.responseText;
						//alert('Error: ' + response.responseText);
						//$("#CONTENTS").val(response.responseText);
					})
					.done(function(data) {
						//alert(data);
						document.getElementById('result').innerHTML = data;
						//location.reload();
					});
				});

				//$("#moveGift").click(function() {
				//	window.location.href = "content_gift_list.jsp";
				//});
			});
			window.onload = setEditFields;
		</script>
	</head>

	<body>
		<p>
			<form id=searchPattern>
			<table>
				<tr>
					<td colspan="2">
						가맹지역 선택/변경<br/>
					</td>
				</tr>
				<tr>
					<td>
						<select onchange="changedRegion()" id=region>
						<%
						for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
						{
							Region r = (Region)it.next();
							out.write("<option value=" + r._index + ">" + r._name + "</option>");
						}
						%>
						</select>
					</td>
					<td>
						<div id=sub></div>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input type="radio" name="SEARCH_REGION" value="belong" />소속지점으로 검색
						<input type="radio" name="SEARCH_REGION" value="wish" />희망근무지점으로 검색
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input type="radio" name="SEARCH_STATE" value="all" />전체
						<input type="radio" name="SEARCH_STATE" value="avail" />근무가능
						<input type="radio" name="SEARCH_STATE" value="unavail" />근무불가
					</td>
				</tr>
				<tr>
					<td colspan=2>
						이름, 휴대번호로 검색: 
						<input type="text" name="PATTERN" />
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<button type="button" id="search">검색</button>
					</td>
				</tr>
			</table>
			</form>
		</p>
		<p>
			<div id=result>
			</div>
		</p>
	</body>
</html>
