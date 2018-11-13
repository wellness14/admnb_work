<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
		<p>
		본사계정 추가<br>
		<form action="_user_add.jsp?TYPE=HQ" method=post>
			<table border=1>
				<tr>
					<td align=center>ID</td>
					<td>
						<input type=text name="ID"/>
					</td>
				</tr>
				<tr>
					<td align=center>이름</td>
					<td>
						<input type=text name="NAME"/>
					</td>
				</tr>
				<tr>
					<td>Password</td>
					<td>
						<input type=password name="PASSWORD"/>
					</td>
				</tr>
				<tr>
					<td align=center>권한</td>
					<td>
						<input type=text name="PEMISSIONS"/>
					</td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<input type=submit value="본사계정 추가"/>
					</td>
				</tr>
			</table>
		</form>
		</p>

		<p>
		지사계정 추가<br>
		<form action="_user_add.jsp?TYPE=BRANCH" method=post>
			<table border=1>
				<tr>
					<td align=center>ID</td>
					<td>
						<input type=text name="ID"/>
					</td>
				</tr>
				<tr>
					<td align=center>계약자</td>
					<td>
						<input type=text name="CONTRACTOR"/>
					</td>
				</tr>
				<tr>
					<td>사업자명</td>
					<td>
						<input type=text name="BUSINESS"/>
					</td>
				</tr>
				<tr>
					<td>Password</td>
					<td>
						<input type=password name="PASSWORD"/>
					</td>
				</tr>
				<tr>
					<td align=center>전화번호</td>
					<td>
						<input type=text name="MOBILE"/>
					</td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<input type=submit value="지사계정 추가"/>
					</td>
				</tr>
			</table>
		</form>
		</p>
	</body>
</html>
