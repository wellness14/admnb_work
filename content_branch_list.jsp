<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsGroup; //= _userdb.getGiftList();
	//List<Branch> lstBranch; //= _userdb.getGiftList();
	//List<Terms> list; //= _userdb.getGiftList();
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
	int _region = -1;
%>

<%
//	_db = _userdb;
	int index = -1;
	Terms item = null;

	lstRegionsGroup = _userdb.getRegionList(-1);
	String temp = request.getParameter("REGION");
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

			function setEditFields() {
					//alert("init:" + <%=index%>);
			}

			function viewBranch(index) {
				window.location.href = 'content_branch_view.jsp?BRANCH=' + index;
			}
			function changeRegion(index) {
				//$('adv' + index).prop("checked", true);
				//document.getElementById('adv' + index).innerHTML = '노출중' + index;
				//alert(document.getElementById("APPLY_DATE").value);
				//document.getElementById('adv' + index).innerHTML = $("#APPLY_DATE").val();
				window.location.href = 'content_branch_list.jsp?REGION=' + index;
			}
			$(document).ready(function() {
				$("#save").click(function() {
					//alert($("#term").serialize() + "&INDEX=" + <%= index %>);
					var val = 'index=' + '<%= index %>&type=' + type + '&' + $("#formData").serialize();
					//alert('저장합니다[' + val + "]");
					if ($("#CONTENTS").val().length == 0) {
						alert('내용이 입력되지 않았습니다.');
						return;
					}
					if ($("#APPLY_DATE").val().length == 0) {
						alert('적용일이 입력되지 않았습니다.');
						return;
					}
					//alert(val);
					//$.post("_terminal_update.jsp", $("#term").serialize() + "&INDEX=" + '<%= index %>')
					$.post("_terms_update.jsp", val)
					.fail(function(response) {
						//alert('Error: ' + response.responseText);
						$("#CONTENTS").val(response.responseText);
					})
					.done(function(data) {
						//alert(data);
						location.reload();
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
			가맹지역 선택(시/도)<br/>
<%
			for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
			{
				Region r = (Region)it.next();
				out.write("<button type=button onclick='changeRegion(" + r._index + ")' >" + r._name + "</button> ");
			}
%>
		</p>
		<p>
		<table border=1>
			<tr>
				<td>보기</td>
				<td>계약자</td>
				<td>가맹지역</td>
				<td>사업자명</td>
				<td>운영자명</td>
				<td>사업자 주소</td>
				<td>전화</td>
				<td>계약기간</td>
			</tr>
<%
		ResultSet rs = null;
		String sql;

		sql = "select *, r.NAME as REGION_NAME, m.BUSINESS as BUSINESS_NAME from BRANCH as b, MEMBER as m, REGION as r where m.MEMBER_INDEX = b.MEMBER_INDEX and r.REGION_INDEX = b.REGION_INDEX";
		if (_region != -1)
		{
			sql += " and b.REGION_INDEX in (select REGION_INDEX from REGION where UPPER_REGION = " + _region + ")";
		}
		//_userdb.PrintLog(sql);
		rs = DBPool.getResultSet(sql);
		while (UserDB.getNext(rs))
		{
			%><tr><%

			out.write("<td><button type=button onclick='viewBranch(" + rs.getInt("BRANCH_INDEX") + ")' >보기</button></td>");
			out.write("<td>" + rs.getString("CONTRACTOR") + "</td>");
			out.write("<td>" + rs.getString("REGION_NAME") + "</td>");
			out.write("<td>" + rs.getString("BUSINESS_NAME") + "</td>");
			out.write("<td>" + rs.getString("OPERATOR") + "</td>");
			out.write("<td>" + rs.getString("ADDRESS1") + " "  + rs.getString("ADDRESS2") + "</td>");
			out.write("<td>" + rs.getString("MOBILE") + "</td>");
			out.write("<td>" + df.format(rs.getTimestamp("CONTRACT_BEGIN")) + " ~ "  + df.format(rs.getTimestamp("CONTRACT_END")) + "</td>");

			%></tr><%
		}
		DBPool.removeDBObject(rs);
%>
		</table>
		</p>
	</body>
</html>
