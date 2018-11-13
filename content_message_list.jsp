<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
		<title>Wellness Login</title>
	</head>

	<body>
		<p>보낸 쪽지함</p>
		<table border=1>
			<tr>
				<td>수신인</td><td>내용</td><td>보낸시간</td><td>읽은시간</td>
			</tr>
<%
			List<Message> msgs = _userdb.getValidMessage_SentList();
			DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

			//access via Iterator
			Iterator iterator = msgs.iterator();
			while (iterator.hasNext())
			{
				Message msg = (Message) iterator.next();
				String s = "<tr>";
				s += "<td>" + msg.getReceiver() + "</td>";
				s += "<td>" + msg.getContent() + "</td>";
				//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
				s += "<td>" + df.format(msg.getSent().getTime()) + "</td>";
				s += "<td>";
				if (msg.getRead() != null)
				{
					df.format(msg.getRead().getTime());
				}
				else
				{
					s+= "읽지않음";
				}
				s += "</td>";
				s += "</tr>\n";
				out.write(s);
			}
%>
		</table>

		<p>받은 쪽지함</p>
		<table border=1>
			<tr>
				<td>발신인</td><td>내용</td><td>보낸시간</td>
			</tr>
<%
			msgs = _userdb.getValidMessage_ReceivedList();

			//access via Iterator
			iterator = msgs.iterator();
			while (iterator.hasNext())
			{
				Message msg = (Message) iterator.next();
				String s = "<tr>";
				s += "<td>" + msg.getSender() + "</td>";
				s += "<td>" + msg.getContent() + "</td>";
				//s += "<td><a href=\"content_notice_view.jsp?index=" + header.getIndex() + "\">" + header.getTitle() + "</a></td>";
				s += "<td>" + df.format(msg.getSent().getTime()) + "</td>";
				/*
				s += "<td>";
				if (msg.getRead() != null)
				{
					df.format(msg.getRead().getTime());
				}
				else
				{
					s+= "읽지않음";
				}
				s += "</td>";
				*/
				s += "</tr>\n";
				out.write(s);
			}
%>
		</table>
	</body>
</html>
