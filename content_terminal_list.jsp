<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!
//	public UserDB _db;
	List<Terminal> headers; //= _userdb.getTerminalList();
%>

<%
//	_db = _userdb;
	headers = _userdb.getTerminalList();

	int index = -1;
	Terminal term = null;
	if (request.getParameter("index") != null)
	{
		index = Integer.parseInt((String)request.getParameter("index"));
		term = _userdb.getTerminal(index);
		if (term == null)
		{
			index = -1;
		}
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
					//alert("init:" + <%=index%>);
				<%
					if (index != -1)
					{
						String checked;
						String not;
						if (term._available)
						{
							checked = "#availble";
							not ="#unavailble";
						}
						else
						{
							not = "#availble";
							checked ="#unavailble";
						}
				%>

						$('<%=checked%>').prop("checked", true);
						$('<%=not%>').prop("checked", false);
						$("#NO").val(<%=term._no%>);
				<%
					}
				%>
			}

			function setTerm(index) {
				//alert("set: " + index);
				window.location.href = "content_terminal_list.jsp?index="+index;
			}

			function delTerm(index) {
				//alert("del: " + index);
				//var val = $("#term").serialize() + '&INDEX=' + '<%= index %>&DELETE=1';
				var val = 'INDEX=' + index + '&DELETE=1';
				$.post("_terminal_update.jsp", val)
					.fail(function(response) {
						alert('Error: ' + response.responseText);
					})
				.done(function(data) {
					location.reload();
				});
			}

			$(document).ready(function() {
				$("#save").click(function() {
					//alert($("#term").serialize() + "&INDEX=" + <%= index %>);
					var val = $("#term").serialize() + '&INDEX=' + '<%= index %>';
					//alert(val);
					//$.post("_terminal_update.jsp", $("#term").serialize() + "&INDEX=" + '<%= index %>')
					$.post("_terminal_update.jsp", val)
					.fail(function(response) {
						//alert('Error: ' + response.responseText);
					})
					.done(function(data) {
						//alert(data);
						location.reload();
					});
				});

				$("#moveGift").click(function() {
					window.location.href = "content_gift_list.jsp";
				});
				$("#moveRental").click(function() {
					window.location.href = "content_rental_list.jsp";
				});
				$("#moveTerminal").click(function() {
					window.location.href = "content_terminal_list.jsp";
				});

				$("#search").click(function() {
					alert('Not implemented yet.');
					//window.location.href = "content_gift_list.jsp";
				});
				$("#delGift").click(function() {
					alert('Not implemented yet.');
					//window.location.href = "content_gift_list.jsp";
				});
				$("#moveGiftRegister").click(function() {
					alert('Not implemented yet.');
					//window.location.href = "content_gift_list.jsp";
				});
			});
			window.onload = setEditFields;
		</script>
	</head>
	<body>
		<p>
			<button type=button id="moveGift">선물</button>
			<button type=button id="moveRental">대여품</button>
			<button type=button id="moveTerminal">단말기</button>
		</p>
		<hr/>
		<p>
			<form id=term>
				■ 단말기 등록 <br/>
				사용
				<input type="radio" id="availble" name="AVAILABLE" value="1" checked /> 사용
				<input type="radio" id="unavailble" name="AVAILABLE" value="0" /> 사용안함 
				단말기 번호<input type=text placeholder="내용을 입력해 주세요" id="NO" name="NO"><br/>
				<button type=button id="save">저장</button><br/>
			</form>
		</p>
		<p>
			■ 단말기 리스트 <br/>
			<table border=0>
<%

	//access via Iterator
	Iterator iterator = headers.iterator();
	while (iterator.hasNext())
	{
		Terminal item = (Terminal) iterator.next();
		String s = "<table border=1><col width=130><col width=330><tr>";
		s += "<td>단말기 번호: " + item._no + "</td>";
		s += "<td>사용: " + (item._available ? "사용" : "사용안함") + "</td>";
		s += "<td><button type=button onclick='setTerm(" + item._index + ")'>" + "수정" + "</button></td>";
		s += "<td><button type=button onclick='delTerm(" + item._index + ")'>" + "삭제" + "</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header._index + "\">" + header.getTitle() + "</a></td>";
		s += "</tr></table>\n";
		out.write(s);
	}
%>
			</table>
		</p>
	</body>
</html>
