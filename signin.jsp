<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.*" %>
<%@ page import = "wellness.*" %>
<!DOCTYPE html>
<html lang="en">

<%!
	public Customer getCustomer(String key)
	{
		if (key.length() == 0) return null; // already signed in.
		Customer item = UserDB.getCustomerItem_UrlKey(key);
		return item;
	}
%>

<%
	Customer item = getCustomer((String)request.getParameter("KEY"));

	if (item == null)
	{
		response.sendRedirect("wrongSignin.jsp");
	}

//	UserDB db = new UserDB();
	if (item == null)
	{
		item = new Customer();
	}
%>

<html>
	<head>
		<title>신규 상담</title>
		<script
		src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
		<script>
			var isAvail = false;
			var index = <%= item._index %>;
			var isClosing = false;

			function writeLog(type, log) {
			    var val = '';
			    val += 'ADDLOG' + '&';
			    val += 'INDEX=' + index + '&';
			    val += 'TYPE=' + type + '&';
			    val += 'LOG=' + log + '&';
			    $.post("_api_customer.jsp", val)
			    .fail(function(response) {
			        alert('Error: ' + response.responseText);
			        //document.getElementById("org").innerHTML = response.responseText;
			    })
			    .done(function(data) {
			    	console.log(data);
			    	if (isClosing)
			    	{
						alert('가입처리 되었습니다.');
						window.close();
			    	}
			    	//location.reload();
			    });
			}

			$(document).ready(function() {
				$("#check").click(function() {
					if ($("#ID").val().length == 0) {
						alert('ID를 입력해 주세요.');
						return;
					}
					val = "ID=" + $("#ID").val();
					$.post("_check_customer_id.jsp", val)
					.fail(function(response) {
						alert('Error: ' + response.responseText);
					})
					.done(function(data) {
						if (data.AVAILABLE == 1) {
							isAvail = true;
							alert('[사용가능]');
						} else {
							isAvail = false;
							alert('[사용불가능]');
						}
					});
				});

				$("#signin").click(function() {
					if ($("#ID").val().length == 0) {
						alert('ID를 입력해 주세요.');
						return;
					}
					if (isAvail == false) {
						alert('ID 중복체크를 해주세요.');
						return;
					}
					if ($("#PWD").val().length == 0) {
						alert('비밀번호를 입력해 주세요.');
						return;
					}
					var pwd = $("#PWD").val();
					var ver = $("#PWD_VERIFY").val();
					if (pwd.localeCompare(ver) != 0) {
						alert('비밀번호가 서로 다릅니다.');
						return;
					}

					//val = "ID=" + $("#ID").val();
					var val = 'INDEX=' + index + '&' + $("#formData").serialize();
					$.post("_customer_signin.jsp", val)
					.fail(function(response) {
						alert('Error: ' + response.responseText);
					})
					.done(function(data) {
						if (data.SIGNIN > 0) {
							isClosing = true;
							writeLog("SMS", "가입처리 되었습니다.");
						} else {
							alert('가입처리 실패했습니다.');
						}
					});
				});
			});
		</script>
	</head>

	<body>
		<!--<form action="_counsel_add.jsp" method=post>-->
		<form id=formData>
			<table border=1>
				<tr><td colspan="2">■기본정보</td></tr>
				<tr>
					<td align=center>성함</td>
					<td>
						<input type=text name="NAME" size="30" value='<%= item._name %>' />
					</td>
				</tr>
				<tr>
					<td align=center>휴대전화</td>
					<td>
						<input type=text name="MOBILE" id="mobile" value='<%= item._mobile %>' />
					</td>
				</tr>
				<tr>
					<td align=center>일반전화</td>
					<td>
						<input type=text name="PHONE" value='<%= item._phone %>' />
					</td>
				</tr>
				<tr>
					<td align=center>주소</td>
					<td>
						<input type=text name="POST" placeholder="우편번호" value='<%= item._post %>' /><br/>
						<input type=text name="ADDRESS1" placeholder="주소" value='<%= item._address1 %>' /><br/>
						<input type=text name="ADDRESS2" placeholder="상세주소" value='<%= item._address2 %>' /><br/>
					</td>
				</tr>
				<tr>
					<td align=center>아이디</td>
					<td>
						<input type=text name="ID" id=ID value='<%= item._id %>' />
						<button type=button id=check>중복체크</button>
					</td>
				</tr>
				<tr>
					<td align=center>비밀번호</td>
					<td>
						<input type=password name="PWD" id="PWD" value='<%= item._pwd %>' />
					</td>
				</tr>
				<tr>
					<td align=center>비밀번호확인</td>
					<td>
						<input type=password name="PWD_VERIFY" id="PWD_VERIFY" value='<%= item._pwd %>' />
					</td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<button type=button id=signin>가입</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
