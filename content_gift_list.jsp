<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!
//	public UserDB _db;
%>

<%
//	_db = _userdb;
	List<Gift> headers; //= _userdb.getGiftList();
	headers = _userdb.getGiftList();

	int index = -1;
	Gift item = null;
	if (request.getParameter("index") != null)
	{
		index = Integer.parseInt((String)request.getParameter("index"));
		item = _userdb.getGift(index);
		if (item == null)
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
				%>

						$('<%=checked%>').prop("checked", true);
						$('<%=not%>').prop("checked", false);
						$("#NO").val(<%=item._no%>);
						$("#NAME").val('<%=item._name%>');
						$("#IMAGE").val('<%=item._image%>');
						$("#PRICE").val('<%=item._price%>');
						$("#QUANTITY").val('<%=item._quantity%>');
						$("#TARGET").val('<%=item._target%>');
				<%
					}
				%>
			}

			function setGift(index) {
				//alert("set: " + index);
				window.location.href = "content_gift_list.jsp?index="+index;
			}

			function delGift(index) {
				//alert("del: " + index);
				//var val = $("#term").serialize() + '&INDEX=' + '<%= index %>&DELETE=1';
				var val = 'INDEX=' + index + '&DELETE=1';
				$.post("_gift_update.jsp", val)
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
					var val = $("#gift").serialize() + '&INDEX=' + '<%= index %>';
					//alert(val);
					//$.post("_terminal_update.jsp", $("#term").serialize() + "&INDEX=" + '<%= index %>')
					$.post("_gift_update.jsp", val)
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
			<form id=gift>
				■ 선물 등록/수정 <br/>
				노출상태
				<input type="radio" id="exposed" name="EXPOSED" value="1" checked /> 노출
				<input type="radio" id="unexposed" name="EXPOSED" value="0" /> 노출안함 
				선물 번호<input type=text placeholder="내용을 입력해 주세요" id="NO" name="NO"><br/>
				상품명<input type=text placeholder="내용을 입력해 주세요" id="NAME" name="NAME"><br/>
				상품이미지<input type=text placeholder="내용을 입력해 주세요" id="IMAGE" name="IMAGE"><br/>
				매입가<input type=text placeholder="내용을 입력해 주세요" id="PRICE" name="PRICE"><br/>
				수량<input type=text placeholder="내용을 입력해 주세요" id="QUANTITY" name="QUANTITY"><br/>
				지급대상<textarea placeholder="내용을 입력해 주세요" id="TARGET" name="TARGET"></textarea><br/>
				<button type=button id="save">저장</button><br/>
			</form>
		</p>
		<p>
			상품명검색 <input type=text placeholder="내용을 입력해 주세요">
			<button type=button id="search">검색</button><br/>
			<button type=button id="delGift">삭제</button>
			<button type=button id="moveGiftRegister">용품등록</button>
		</p>
		<p>
			■ 선물 리스트 <br/>
			<table border=1>
				<tr>
					<td align=center>선물번호</td>
					<td align=center>노출상태</td>
					<td align=center>이미지</td>
					<td align=center>상품명</td>
					<td align=center>매입가</td>
					<td align=center>재고</td>
					<td align=center>등록일</td>
					<td align=center>지급대상</td>
					<td align=center>수정</td>
					<td align=center>삭제</td>
				</tr>
<%

	//access via Iterator
	Iterator iterator = headers.iterator();
	while (iterator.hasNext())
	{
		item = (Gift) iterator.next();
		String s = "<tr>";
		s += "<td>" + item._no + "</td>";
		s += "<td>" + (item._exposed ? "노출중" : "노출안함") + "</td>";
		s += "<td>" + item._image + "</td>";
		s += "<td>" + item._name + "</td>";
		s += "<td>" + item._price + "</td>";
		s += "<td>" + item._quantity + "</td>";
		s += "<td>" + item._registrationDate + "</td>";
		s += "<td>" + item._target + "</td>";
		s += "<td><button type=button onclick='setGift(" + item._index + ")'>" + "수정" + "</button></td>";
		s += "<td><button type=button onclick='delGift(" + item._index + ")'>" + "삭제" + "</button></td>";
		//s += "<td><a href=\"content_notice_view.jsp?index=" + header._index + "\">" + header.getTitle() + "</a></td>";
		s += "</tr>\n";
		out.write(s);
	}
%>
			</table>
		</p>
	</body>
</html>
