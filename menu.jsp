<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<html>
	<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
</style>
		<title>Top</title>
	</head>

	<body>
		<%
			Member user = (Member)session.getAttribute("user");
			if (user == null)
			{
				response.sendRedirect("_logout.jsp");
			}
			if (user.isAdmin())
			{
		%>
		<p align=center>
			* 사용자 관리 *<br>
			<a href="content_user_add.jsp" target="content">사용자 추가</a><br>
			<a href="content_user_list.jsp" target="content">사용자 목록</a><br>
		</p>
		<p align=center>
			* 약관 관리 *<br>
			<a href="content_terms_add.jsp?type=terms" target="content">약관 관리</a><br>
			<a href="content_terms_add.jsp?type=privacy" target="content">개인정보방침 추가</a><br>
			<a href="content_terms_add.jsp?type=email" target="content">이메일수집거부 추가</a><br>
		</p>
		<p align=center>
			* SEO 태그 관리 *<br>
			<a href="content_seo_edit.jsp" target="content">SEO 태그 확인/수정</a><br>
		</p>
		<%
			}
		%>

		<p align=center>
			* 쪽지 관리 *<br>
			<a href="content_message_send.jsp" target="content">족지 작성</a><br>
			<a href="content_message_list.jsp" target="content">쪽지 목록</a><br>
		</p>
		<p align=center>
			* 공지사항 관리 *<br>
			<a href="content_notice_add.jsp" target="content">공지사항 작성</a><br>
			<a href="content_notice_list.jsp" target="content">공지사항 목록</a><br>
		</p>
		<p align=center>
			* 상담 / 문의 *<br>
			<a href="content_consult_new.jsp" target="content">신규 입력</a><br>
			<a href="content_consult_list.jsp" target="content">서비스 / 계약 정보</a><br>
		</p>
		<p align=center>
			* 지사/지역/산후도우미 *<br>
			<a href="content_branch_new.jsp" target="content">지사추가</a><br>
			<a href="content_branch_list.jsp" target="content">지사관리</a><br>
			<a href="content_helper_new.jsp" target="content">산후도우미추가</a><br>
			<a href="content_helper_list.jsp" target="content">산후도우미관리</a><br>
			<!--<a href="content_manage_region.jsp" target="content">지역설정</a><br>-->
		</p>
		<p align=center>
			* 선물/대여품/단말기 *<br>
			<a href="content_gift_list.jsp" target="content">선물/대여품/단말기 관리</a><br>
		</p>
		<p align=center>
			* 서비스 프로그램 *<br>
			<a href="content_service_edit.jsp" target="content">서비스 상품 / 옵션</a><br>
		</p>
		<p align=center>
			* 바우처 *<br>
			<a href="content_income_edit.jsp" target="content">기준중위소득관리</a><br>
			<a href="content_support_edit.jsp" target="content">정부지원금 정책</a><br>
		</p>
		<p align=center>
			<a href="_logout.jsp">* LOGOUT *</a><br>
		</p>
	</body>
</html>
