<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
//	public UserDB _db;
	List<Terms> list; //= _userdb.getGiftList();
	DateFormat dfApply = new SimpleDateFormat("yyyy-MM-dd");
	String _type;
%>

<%
//	_db = _userdb;
	int index = -1;
	Terms item = null;

	_type = request.getParameter("type");
	list = _userdb.getTermsList(_type);

	if (request.getParameter("index") != null)
	{
		index = Integer.parseInt((String)request.getParameter("index"));
		item = _userdb.getTerms(index);
		if (item == null)
		{
			index = -1;
		}
	}
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
			var type = '<%= _type %>';

			function setEditFields() {
					//alert("init:" + <%=index%>);
				<%
					if (index != -1)
					{
						/*
						String checked;
						String not;
						if (item._exposed)
						{
							checked = "#exposed";
							not ="#unexposed";
						}
						else
						{
							not = "#exposed";
							checked ="#unexposed";
						}
						*/
				%>

						$("#APPLY_DATE").val('<%=dfApply.format(item._applyDate)%>');
				<%
					}
				%>
			}

			var count = 0;
			function viewTerms(index) {
				//$('adv' + index).prop("checked", true);
				count++;
				//document.getElementById('adv' + index).innerHTML = '노출중' + index;
				//alert(document.getElementById("APPLY_DATE").value);
				//document.getElementById('adv' + index).innerHTML = $("#APPLY_DATE").val();
				window.location.href = 'content_terms_add.jsp?type=' + type + '&index=' + index;
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
		<%
			String type = request.getParameter("type");
			String title = "";
			if (type.equals("terms"))
			{
				title = "서비스 이용약관";
			}
			else if (type.equals("privacy"))
			{
				title = "개인정보 취급방침";
			}
			else if (type.equals("email"))
			{
				title = "이메일 무단수집거부";
			}
			else
			{
				title = "ERROR";
			}
		%>
		<p>
			<h2><%= title %></h2><br/>
		</p>
		<form id=formData>
		<p>
			■ 내용 입력<br/>
			<textarea id="CONTENTS" name="CONTENTS" rows="20" cols="100"><%= (item != null) ? item._contents : "" %></textarea><br/>
		</p>
		<p>
			■ 적용일<br/>
			<input id="APPLY_DATE" type=date name="APPLY_DATE">
		</p>
		<p align=center>
			<button type=button id="save" >저장</button>
		</p>
		</form>
		<p>
			<table border=1>
				<tr>
					<td align=center>INDEX</td>
					<td align=center>적용일</td>
					<td align=center>상태</td>
				</tr>
<%
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");

	//access via Iterator
	Iterator iterator;
	int count;
	Timestamp curTime = new Timestamp(System.currentTimeMillis());
	int exposed = -1;

	count = list.size();

	iterator = list.iterator();
	index = 0;
	Timestamp last = new Timestamp(0);
	while (iterator.hasNext())
	{
		item = (Terms) iterator.next();
		if (curTime.after(item._applyDate))
		{
			//out.write("exposed:" + item._applyDate);
			if (last.before(item._applyDate))
			{
				last = item._applyDate;
				exposed = index;
			}
		}
		index++;
	}
	//out.write("exposed:" + exposed);


	iterator = list.iterator();
	index = 0;
	while (iterator.hasNext())
	{
		item = (Terms) iterator.next();
		String s = "<tr>";
		s += "<td>" + count + "</td>";
		s += "<td>" + df.format(item._applyDate) + "</td>";
		//s += "<td><button id=view"<a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
		s += "<td><button type=button onclick='viewTerms(" + item._index + ")'>" + "약관보기" + "</button>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		//s += "<td>/" + ((curTime.before(item._applyDate)) ? "아직임" : "지남") + "</td>";
		s += "/" + ((index == exposed) ? "노출중" : "게시") + "</td>";
		s += "</tr>\n";
		out.write(s);
		count--;
		index++;
	}
%>
			</table>
		</p>
	</body>
</html>
