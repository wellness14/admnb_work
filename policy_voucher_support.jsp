<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	public void setUserDB(UserDB userdb)
	{
		_userdb = userdb;
		_options = _userdb.getServiceOptionList();
	}
	public List<ServiceOption> _options;

	public String _prefix = "";
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
		id = _prefix + "_" + id;
		return "document.getElementById('" + id + "').value = " + getOption(id)._cost + ";";
	}

	public String tagInput(String id)
	{
		id = _prefix + "_" + id;
		return "<input type='text' size=10 id='" + id + "' name='" + id + "' class='form-control'>";
	}

	public String tagInput_Inline(String id)
	{
		id = _prefix + "_" + id;
		return "<input type='text' size=10 id='" + id + "' name='" + id + "' class='form-control input-inline'>";
	}
%>

<%
	setUserDB(_userdb);
	//_userdb.PrintLog("service.jsp");
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>마더앤베이비 관리자 - 정부지원금 정책</title>

	<!-- Bootstrap -->
	<link href="./vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Font Awesome -->
	<link href="./vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<!-- NProgress -->
	<link href="./vendors/nprogress/nprogress.css" rel="stylesheet">
	<!-- bootstrap-daterangepicker -->
	<link href="./vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
	<!-- Simple Calendar -->
	<link href="./vendors/simple-calendar-master/dist/simple-calendar.css" rel="stylesheet">
	<link href="./vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	<!-- Custom Theme Style -->
	<link href="./build/css/custom.css" rel="stylesheet">
	<link href="./build/css/mystyle.css" rel="stylesheet">
	<script
	src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	<!--<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>-->
	<script>
		function setEditFields() {
		<% _prefix = "SUP-A-GA"; %>
			<%= scriptSetCost("1ST_D05") %>
			<%= scriptSetCost("1ST_D10") %>
			<%= scriptSetCost("1ST_D15") %>
			<%= scriptSetCost("1ST_SHT_GOV") %>
			<%= scriptSetCost("1ST_SHT_SLF") %>
			<%= scriptSetCost("1ST_STD_GOV") %>
			<%= scriptSetCost("1ST_STD_SLF") %>
			<%= scriptSetCost("1ST_EXT_GOV") %>
			<%= scriptSetCost("1ST_EXT_SLF") %>

			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-A-NA"; %>
			<%= scriptSetCost("1ST_D05") %>
			<%= scriptSetCost("1ST_D10") %>
			<%= scriptSetCost("1ST_D15") %>
			<%= scriptSetCost("1ST_SHT_GOV") %>
			<%= scriptSetCost("1ST_SHT_SLF") %>
			<%= scriptSetCost("1ST_STD_GOV") %>
			<%= scriptSetCost("1ST_STD_SLF") %>
			<%= scriptSetCost("1ST_EXT_GOV") %>
			<%= scriptSetCost("1ST_EXT_SLF") %>

			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-A-DA"; %>
			<%= scriptSetCost("1ST_D05") %>
			<%= scriptSetCost("1ST_D10") %>
			<%= scriptSetCost("1ST_D15") %>
			<%= scriptSetCost("1ST_SHT_GOV") %>
			<%= scriptSetCost("1ST_SHT_SLF") %>
			<%= scriptSetCost("1ST_STD_GOV") %>
			<%= scriptSetCost("1ST_STD_SLF") %>
			<%= scriptSetCost("1ST_EXT_GOV") %>
			<%= scriptSetCost("1ST_EXT_SLF") %>

			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-A-RA"; %>
			<%= scriptSetCost("1ST_D05") %>
			<%= scriptSetCost("1ST_D10") %>
			<%= scriptSetCost("1ST_D15") %>
			<%= scriptSetCost("1ST_SHT_GOV") %>
			<%= scriptSetCost("1ST_SHT_SLF") %>
			<%= scriptSetCost("1ST_STD_GOV") %>
			<%= scriptSetCost("1ST_STD_SLF") %>
			<%= scriptSetCost("1ST_EXT_GOV") %>
			<%= scriptSetCost("1ST_EXT_SLF") %>

			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

			/*********************************************************
			*********************************************************/

		<% _prefix = "SUP-B-GA"; %>
			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-B-NA"; %>
			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-B-DA"; %>
			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-B-RA"; %>
			<%= scriptSetCost("2ND_D05") %>
			<%= scriptSetCost("2ND_D10") %>
			<%= scriptSetCost("2ND_D15") %>
			<%= scriptSetCost("2ND_SHT_GOV") %>
			<%= scriptSetCost("2ND_SHT_SLF") %>
			<%= scriptSetCost("2ND_STD_GOV") %>
			<%= scriptSetCost("2ND_STD_SLF") %>
			<%= scriptSetCost("2ND_EXT_GOV") %>
			<%= scriptSetCost("2ND_EXT_SLF") %>

			<%= scriptSetCost("3RD_D05") %>
			<%= scriptSetCost("3RD_D10") %>
			<%= scriptSetCost("3RD_D15") %>
			<%= scriptSetCost("3RD_SHT_GOV") %>
			<%= scriptSetCost("3RD_SHT_SLF") %>
			<%= scriptSetCost("3RD_STD_GOV") %>
			<%= scriptSetCost("3RD_STD_SLF") %>
			<%= scriptSetCost("3RD_EXT_GOV") %>
			<%= scriptSetCost("3RD_EXT_SLF") %>

		<% _prefix = "SUP-C"; %>
			<%= scriptSetCost("GA_D05") %>
			<%= scriptSetCost("GA_D10") %>
			<%= scriptSetCost("GA_D15") %>
			<%= scriptSetCost("GA_SHT_GOV") %>
			<%= scriptSetCost("GA_SHT_SLF") %>
			<%= scriptSetCost("GA_STD_GOV") %>
			<%= scriptSetCost("GA_STD_SLF") %>
			<%= scriptSetCost("GA_EXT_GOV") %>
			<%= scriptSetCost("GA_EXT_SLF") %>

			<%= scriptSetCost("NA_D05") %>
			<%= scriptSetCost("NA_D10") %>
			<%= scriptSetCost("NA_D15") %>
			<%= scriptSetCost("NA_SHT_GOV") %>
			<%= scriptSetCost("NA_SHT_SLF") %>
			<%= scriptSetCost("NA_STD_GOV") %>
			<%= scriptSetCost("NA_STD_SLF") %>
			<%= scriptSetCost("NA_EXT_GOV") %>
			<%= scriptSetCost("NA_EXT_SLF") %>

			<%= scriptSetCost("DA_D05") %>
			<%= scriptSetCost("DA_D10") %>
			<%= scriptSetCost("DA_D15") %>
			<%= scriptSetCost("DA_SHT_GOV") %>
			<%= scriptSetCost("DA_SHT_SLF") %>
			<%= scriptSetCost("DA_STD_GOV") %>
			<%= scriptSetCost("DA_STD_SLF") %>
			<%= scriptSetCost("DA_EXT_GOV") %>
			<%= scriptSetCost("DA_EXT_SLF") %>

			<%= scriptSetCost("RA_D05") %>
			<%= scriptSetCost("RA_D10") %>
			<%= scriptSetCost("RA_D15") %>
			<%= scriptSetCost("RA_SHT_GOV") %>
			<%= scriptSetCost("RA_SHT_SLF") %>
			<%= scriptSetCost("RA_STD_GOV") %>
			<%= scriptSetCost("RA_STD_SLF") %>
			<%= scriptSetCost("RA_EXT_GOV") %>
			<%= scriptSetCost("RA_EXT_SLF") %>
		}

		function saveDone() {
			alert('저장되었습니다.');
		}

		$(document).ready(function() {
			$("#saveA_Ga").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-A-GA").serialize())
				.done(function(data) {
					saveDone();
				});
			});
			$("#saveA_Na").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-A-NA").serialize())
				.done(function(data) {
					saveDone();
				});
			});
			$("#saveA_Da").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-A-DA").serialize())
				.done(function(data) {
					saveDone();
				});
			});
			$("#saveA_Ra").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-A-RA").serialize())
				.done(function(data) {
					saveDone();
				});
			});

			$("#saveB_Ga").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-B-GA").serialize())
				.done(function(data) {
					saveDone();
				});
			});
			$("#saveB_Na").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-B-NA").serialize())
				.done(function(data) {
					saveDone();
				});
			});
			$("#saveB_Da").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-B-DA").serialize())
				.done(function(data) {
					saveDone();
				});
			});
			$("#saveB_Ra").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-B-RA").serialize())
				.done(function(data) {
					saveDone();
				});
			});

			$("#saveC").click(function() {
				$.post("_service_option_update.jsp", $("#SUP-C").serialize())
				.done(function(data) {
					saveDone();
				});
			});
		});
		window.onload = setEditFields;
	</script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

			<!-- page content -->
			<div class="right_col policy_voucher_support" role="main">
				<div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">바우처</a> &gt;
                        <a href="#!">정부지원금정책</a>
                    </div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										정부지원금 정책
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">

									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>단태아_A-가 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 50%이하 소득유형 'A-가'군 입력</p>
											</blockquote>
											<div class="table-responsive">
                                            <% _prefix = "SUP-A-GA"; %>
                                            <form id='<%= _prefix %>'>
											<table class="table table-striped">
												<thead>
													<tr>
														<th colspan="2"></th>
														<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
														<th colspan="2" class="bg-purple">단축</th>
														<th colspan="2" class="bg-green">표준</th>
														<th colspan="2" class="bg-orange">연장</th>
													</tr>
													<tr>
														<th>출산순위</th>
														<th>소득유형</th>
														<th>단축</th>
														<th>표준</th>
														<th>연장</th>
														<th>정부지원금</th>
														<th>본인부담금</th>
														<th>정부지원금</th>
														<th>본인부담금</th>
														<th>정부지원금</th>
														<th>본인부담금</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>첫째아</td>
														<td>A-가-1</td>
														<td>
															<strong>&nbsp;&nbsp;5일</strong>
															<%= tagInput_Inline("1ST_D05") %>
														</td>
														<td>
															<strong>10일</strong>
															<%= tagInput_Inline("1ST_D10") %>
														</td>
														<td>
															<strong>15일</strong>
															<%= tagInput_Inline("1ST_D15") %>
														</td>
														<td>
															<%= tagInput("1ST_SHT_GOV") %>
														</td>
														<td>
															<%= tagInput("1ST_SHT_SLF") %>
														</td>
														<td>
															<%= tagInput("1ST_STD_GOV") %>
														</td>
														<td>
															<%= tagInput("1ST_STD_SLF") %>
														</td>
														<td>
															<%= tagInput("1ST_EXT_GOV") %>
														</td>
														<td>
															<%= tagInput("1ST_EXT_SLF") %>
														</td>
													</tr>
													<tr>
														<td>둘째아</td>
														<td>A-가-2</td>
														<td>
															<strong>10일</strong>
															<%= tagInput_Inline("2ND_D05") %>
														</td>
														<td>
															<strong>15일</strong>
															<%= tagInput_Inline("2ND_D10") %>
														</td>
														<td>
															<strong>20일</strong>
															<%= tagInput_Inline("2ND_D15") %>
														</td>
														<td>
															<%= tagInput("2ND_SHT_GOV") %>
														</td>
														<td>
															<%= tagInput("2ND_SHT_SLF") %>
														</td>
														<td>
															<%= tagInput("2ND_STD_GOV") %>
														</td>
														<td>
															<%= tagInput("2ND_STD_SLF") %>
														</td>
														<td>
															<%= tagInput("2ND_EXT_GOV") %>
														</td>
														<td>
															<%= tagInput("2ND_EXT_SLF") %>
														</td>
													</tr>
													<tr>
														<td>셋째아 이상</td>
														<td>A-가-3</td>
														<td>
															<strong>10일</strong>
															<%= tagInput_Inline("3RD_D05") %>
														</td>
														<td>
															<strong>15일</strong>
															<%= tagInput_Inline("3RD_D10") %>
														</td>
														<td>
															<strong>20일</strong>
															<%= tagInput_Inline("3RD_D15") %>
														</td>
														<td>
															<%= tagInput("3RD_SHT_GOV") %>
														</td>
														<td>
															<%= tagInput("3RD_SHT_SLF") %>
														</td>
														<td>
															<%= tagInput("3RD_STD_GOV") %>
														</td>
														<td>
															<%= tagInput("3RD_STD_SLF") %>
														</td>
														<td>
															<%= tagInput("3RD_EXT_GOV") %>
														</td>
														<td>
															<%= tagInput("3RD_EXT_SLF") %>
														</td>
													</tr>
												</tbody>
											</table>
                                            </form>
											<a class="btn btn-primary btn-sm" id="saveA_Ga">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>단태아_A-나 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 50%초과~60%이하 소득유형 'A-나'군 입력</p>
											</blockquote>
											<div class="table-responsive">
                                    			<% _prefix = "SUP-A-NA"; %>
                                    			<form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>첫째아</td>
															<td>A-나-1</td>
															<td>
																<strong>&nbsp;&nbsp;5일</strong>
																<%= tagInput_Inline("1ST_D05") %>
															</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("1ST_D10") %>
															</td>
															<td>
																<strong>15일</strong>
															<%= tagInput_Inline("1ST_D15") %>
															</td>
															<td>
															<%= tagInput("1ST_SHT_GOV") %>
															</td>
															<td>
															<%= tagInput("1ST_SHT_SLF") %>
															</td>
															<td>
															<%= tagInput("1ST_STD_GOV") %>
															</td>
															<td>
															<%= tagInput("1ST_STD_SLF") %>
															</td>
															<td>
															<%= tagInput("1ST_EXT_GOV") %>
															</td>
															<td>
															<%= tagInput("1ST_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>둘째아</td>
															<td>A-나-2</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>A-나-3</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
                                                </form>
												<a class="btn btn-primary btn-sm" id="saveA_Na">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>단태아_A-다 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 60%초과~80%이하 소득유형 'A-다'군 입력</p>
											</blockquote>
											<div class="table-responsive">
                                                <% _prefix = "SUP-A-DA"; %>
                                                <form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>첫째아</td>
															<td>A-다-1</td>
															<td>
																<strong>&nbsp;&nbsp;5일</strong>
																<%= tagInput_Inline("1ST_D05") %>
															</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("1ST_D10") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("1ST_D15") %>
															</td>
															<td>
																<%= tagInput("1ST_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("1ST_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("1ST_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("1ST_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("1ST_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("1ST_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>둘째아</td>
															<td>A-다-2</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>A-다-3</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
                                                </form>
												<a class="btn btn-primary btn-sm" id="saveA_Da">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>단태아_A-라 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 80%초과지원(예외지원) 소득유형 'A-라'군 입력</p>
											</blockquote>
											<div class="table-responsive">
                                                <% _prefix = "SUP-A-RA"; %>
                                                <form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>첫째아</td>
															<td>A-라-1</td>
															<td>
																<strong>&nbsp;&nbsp;5일</strong>
																<%= tagInput_Inline("1ST_D05") %>
															</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("1ST_D10") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("1ST_D15") %>
															</td>
															<td>
																<%= tagInput("1ST_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("1ST_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("1ST_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("1ST_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("1ST_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("1ST_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>둘째아</td>
															<td>A-라-2</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>A-라-3</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
                                                </form>
												<a class="btn btn-primary btn-sm" id="saveA_Ra">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>쌍태아_B-가 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 50%이하 소득유형 'B-가'군 입력</p>
											</blockquote>
											<div class="table-responsive">
												<% _prefix = "SUP-B-GA"; %>
												<form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>둘째아</td>
															<td>B-가-1</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>B-가-2</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
												</form>
												<a class="btn btn-primary btn-sm" id="saveB_Ga">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>쌍태아_B-나 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 50%초과~60%이하 소득유형 'B-나'군 입력</p>
											</blockquote>
											<div class="table-responsive">
                                                <% _prefix = "SUP-B-NA"; %>
                                                <form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>둘째아</td>
															<td>B-나-1</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>B-나-2</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
                                                </form>
												<a class="btn btn-primary btn-sm" id="saveB_Na">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>쌍태아_B-다 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 60%초과~80%이하 소득유형 'B-다'군 입력</p>
											</blockquote>
											<div class="table-responsive">
												<% _prefix = "SUP-B-DA"; %>
												<form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>둘째아</td>
															<td>B-다-1</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>B-다-2</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
                                                </form>
												<a class="btn btn-primary btn-sm" id="saveB_Da">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>쌍태아_B-라 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 80%초과지원(예외지원) 소득유형 'B-라'군 입력</p>
											</blockquote>
											<div class="table-responsive">
												<% _prefix = "SUP-B-RA"; %>
												<form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>둘째아</td>
															<td>B-라-1</td>
															<td>
																<strong>10일</strong>
																<%= tagInput_Inline("2ND_D05") %>
															</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("2ND_D10") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("2ND_D15") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("2ND_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															<td>셋째아 이상</td>
															<td>B-라-2</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("3RD_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("3RD_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("3RD_D15") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("3RD_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
												</form>
												<a class="btn btn-primary btn-sm" id="saveB_Ra">저장</a>
											</div>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<h4>
												<i class="fa fa-slack"></i>
												<strong>삼태아 이상 중증장애산모_C-가 &middot; 나 &middot; 다 &middot; 라 군 입력</strong>
												<small class="pull-right">최종수정일 2018.03.09</small>
												<div class="clearfix"></div>
											</h4>
											<blockquote>
												<p>* 소득구간 50%이하 소득유형 'C-가'군 입력</p>
												<p>* 소득구간 50%초과~60%이하 소득유형 'C-나'군 입력</p>
												<p>* 소득구간 60%초과~80%이하 소득유형 'C-다'군 입력</p>
												<p>* 소득구간 80%초과지원(예외지원) 소득유형 'C-라'군 입력</p>
											</blockquote>
											<div class="table-responsive">
												<% _prefix = "SUP-C"; %>
												<form id='<%= _prefix %>'>
												<table class="table table-striped">
													<thead>
														<tr>
															<th colspan="2"></th>
															<th colspan="3" class="bg-blue">서비스기간 및 서비스 상한가</th>
															<th colspan="2" class="bg-purple">단축</th>
															<th colspan="2" class="bg-green">표준</th>
															<th colspan="2" class="bg-orange">연장</th>
														</tr>
														<tr>
															<th>출산순위</th>
															<th>소득유형</th>
															<th>단축</th>
															<th>표준</th>
															<th>연장</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
															<th>정부지원금</th>
															<th>본인부담금</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td rowspan="4">삼태아이상<br/> 중증장애산모</td>
															<td>C-가</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("GA_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("GA_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("GA_D15") %>
															</td>
															<td>
																<%= tagInput("GA_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("GA_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("GA_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("GA_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("GA_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("GA_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															
															<td>C-나</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("NA_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("NA_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("NA_D15") %>
															</td>
															<td>
																<%= tagInput("NA_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("NA_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("NA_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("NA_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("NA_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("NA_EXT_SLF") %>
															</td>
														</tr>
														<tr>
															
															<td>C-다</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("DA_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("DA_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("DA_D15") %>
															</td>
															<td>
																<%= tagInput("DA_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("DA_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("DA_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("DA_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("DA_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("DA_EXT_SLF") %>
															</td>
														</tr>
														<tr>
																	
															<td>C-라</td>
															<td>
																<strong>15일</strong>
																<%= tagInput_Inline("RA_D05") %>
															</td>
															<td>
																<strong>20일</strong>
																<%= tagInput_Inline("RA_D10") %>
															</td>
															<td>
																<strong>25일</strong>
																<%= tagInput_Inline("RA_D15") %>
															</td>
															<td>
																<%= tagInput("RA_SHT_GOV") %>
															</td>
															<td>
																<%= tagInput("RA_SHT_SLF") %>
															</td>
															<td>
																<%= tagInput("RA_STD_GOV") %>
															</td>
															<td>
																<%= tagInput("RA_STD_SLF") %>
															</td>
															<td>
																<%= tagInput("RA_EXT_GOV") %>
															</td>
															<td>
																<%= tagInput("RA_EXT_SLF") %>
															</td>
														</tr>
													</tbody>
												</table>
												</form>
												<a href="#!" class="btn btn-primary btn-sm" id="saveC">저장</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>


			</div>


		</div>
		<!-- /page content -->

		<!-- footer content -->
		<footer>
			<div class="pull-right">
				Wellness Intelligence ADMIN PAGE Create by - Spacemonkey
			</div>
			<div class="clearfix"></div>
		</footer>
		<!-- /footer content -->
	</div>
	</div>

	<!-- jQuery -->
	<script src="./vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="./vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="./vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="./vendors/nprogress/nprogress.js"></script>
	<!-- Chart.js -->
	<!-- <script src="./vendors/Chart.js/dist/Chart.min.js"></script> -->
	<!-- jQuery Sparklines -->
	<script src="./vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
	<!-- Flot -->
	<!-- <script src="./vendors/Flot/jquery.flot.js"></script> -->
	<!-- <script src="./vendors/Flot/jquery.flot.pie.js"></script>
	<script src="./vendors/Flot/jquery.flot.time.js"></script>
	<script src="./vendors/Flot/jquery.flot.stack.js"></script>
	<script src="./vendors/Flot/jquery.flot.resize.js"></script> -->
	<!-- Flot plugins -->
	<!-- <script src="./vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
	<script src="./vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
	<script src="./vendors/flot.curvedlines/curvedLines.js"></script> -->
	<!-- DateJS -->
	<script src="./vendors/DateJS/build/date.js"></script>
	<!-- bootstrap-daterangepicker -->
	<script src="./vendors/moment/min/moment.min.js"></script>
	<script src="./vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- Simple Calendar -->
	<!-- <script src="./vendors/simple-calendar-master/dist/jquery.simple-calendar.js"></script> -->
	<script src="./vendors/jquery-ui-1.12.1.custom/datepicker-ko-KR.js"></script>
	<script src="./vendors/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>

	<!-- iCheck -->
	<script src="./vendors/iCheck/icheck.min.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="./build/js/custom.min.js"></script>
</body>

</html>