<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	public List<ServiceOption> _options;

	public String _type;
	public String _weekWork;

	public void setUserDB(UserDB userdb)
	{
		_userdb = userdb;
		_options = _userdb.getServiceOptionList();
	}

	/////////////////////////////// for Service

	public ServiceOption getOption(int amountTypeIndex)
	{
		return getOption(_type, _weekWork, _amountTypes[amountTypeIndex]);
	}

	public ServiceOption getOption(String weekWork, String amountType)
	{
		return getOption(_type, weekWork, amountType);
	}

	public ServiceOption getOption(String type, String weekWork, String amountType)
	{
		String key = type + "_" + weekWork + "_" + amountType;
		//access via Iterator
		Iterator iterator = _options.iterator();
		while (iterator.hasNext())
		{
			ServiceOption option = (ServiceOption) iterator.next();
			if (option._type.equals(key))
			{
				return option;
			}
		}

		ServiceOption dummy = new ServiceOption();
		dummy._cost = 0;
		return dummy;
	}

	String[] _amountTypes = { "RESERVED", "BALANCE(5)", "BALANCE(6)", "TOTAL_5D", "TOTAL_6D" };

	public String getID(int index)
	{
		return "'" + _type + "_" + _weekWork + "_" + _amountTypes[index] + "'";
	}

	public String getIDs(int index)
	{
		return _type + "_" + _weekWork + "_" + _amountTypes[index];
	}

	public String getIDName(int index)
	{
		return "id='" + _type + "_" + _weekWork + "_" + _amountTypes[index] + "' " +
			"name='" + _type + "_" + _weekWork + "_" + _amountTypes[index] + "'";
	}

    public String dupIdName(String name)
    {
        return "id='" + name + "' " +
            "name='" + name + "'";
    }

	public String writeInitFill(String type, String weekWork)
	{
		String ret = "";

		_type = type;
		_weekWork = weekWork;

		ret += "\ndocument.getElementById(" + getID(0) + ").value = " + getOption(0)._cost + ";\n";
		ret += "document.getElementById(" + getID(1) + ").value = " + getOption(1)._cost + ";\n";
		ret += "document.getElementById(" + getID(2) + ").value = " + getOption(2)._cost + ";\n";
		ret += "document.getElementById(" + getID(3) + ").innerHTML = " + getOption(0)._cost + "+" + getOption(1)._cost + ";\n";
		ret += "document.getElementById(" + getID(4) + ").innerHTML = " + getOption(0)._cost + "+" + getOption(2)._cost + ";\n";

		return ret;
	}

	////////////////////////////////////////////////////////// end of service

	////////////////////////////////////////////////////////// for option

	public ServiceOption getOption(String type)
	{
		// TODO: access via Iterator
		// Hash algorithm will be more efficient than this list type.
		// but it will not an issue because number of item is small.
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
		return "document.getElementById('" + id + "').value = " + getOption(id)._cost + ";";
	}

	////////////////////////////////////////////////////////// end of option

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

	<title>마더앤베이비 관리자 - 서비스상품 / 옵션</title>

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
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	<script>
		function setEditFields() {
			<%= writeInitFill("BASIC", "1W") %>
			<%= writeInitFill("BASIC", "2W") %>
			<%= writeInitFill("BASIC", "3W") %>
			<%= writeInitFill("BASIC", "4W") %>

			<%= writeInitFill("PREMIUM(C)", "1W") %>
			<%= writeInitFill("PREMIUM(C)", "2W") %>
			<%= writeInitFill("PREMIUM(C)", "3W") %>
			<%= writeInitFill("PREMIUM(C)", "4W") %>

			<%= writeInitFill("PREMIUM(I)", "1W") %>
			<%= writeInitFill("PREMIUM(I)", "2W") %>
			<%= writeInitFill("PREMIUM(I)", "3W") %>
			<%= writeInitFill("PREMIUM(I)", "4W") %>

			<%= writeInitFill("VIP(C)", "1W") %>
			<%= writeInitFill("VIP(C)", "2W") %>
			<%= writeInitFill("VIP(C)", "3W") %>
			<%= writeInitFill("VIP(C)", "4W") %>

			<%= writeInitFill("VIP(I)", "1W") %>
			<%= writeInitFill("VIP(I)", "2W") %>
			<%= writeInitFill("VIP(I)", "3W") %>
			<%= writeInitFill("VIP(I)", "4W") %>

			<%= writeInitFill("PRIVATE(C)", "1W") %>
			<%= writeInitFill("PRIVATE(C)", "2W") %>
			<%= writeInitFill("PRIVATE(C)", "3W") %>
			<%= writeInitFill("PRIVATE(C)", "4W") %>

			<%= writeInitFill("PRIVATE(I)", "1W") %>
			<%= writeInitFill("PRIVATE(I)", "2W") %>
			<%= writeInitFill("PRIVATE(I)", "3W") %>
			<%= writeInitFill("PRIVATE(I)", "4W") %>

			<%= writeInitFill("TWINS", "C4") %>
			<%= writeInitFill("TWINS", "I2C2") %>
			<%= writeInitFill("TWINS", "I4") %>

			<%= writeInitFill("MULTIPLES", "C4") %>
			<%= writeInitFill("MULTIPLES", "I2C2") %>
			<%= writeInitFill("MULTIPLES", "I4") %>

			<%= writeInitFill("INTENSIVE(WORKINGMOM)", "I2C2") %>
			<%= writeInitFill("INTENSIVE(CAREHOME)", "I2C2") %>
			<%= writeInitFill("INTENSIVE(35)", "C4") %>
			<%= writeInitFill("INTENSIVE(HEAVY)", "C4") %>


			<%= scriptSetCost("EXTENDED_COMMUTE_NOSCHOOL") %>
			<%= scriptSetCost("EXTENDED_COMMUTE_SCHOOL") %>
			<%= scriptSetCost("EXTENDED_COMMUTE_FAMILY") %>
			<%= scriptSetCost("EXTENDED_COMMUTE_TWIN") %>
			<%= scriptSetCost("EXTENDED_INHOUSE_NOSCHOOL") %>
			<%= scriptSetCost("EXTENDED_INHOUSE_SCHOOL") %>
			<%= scriptSetCost("EXTENDED_INHOUSE_FAMILY") %>
			<%= scriptSetCost("EXTENDED_INHOUSE_TWIN") %>

			<%= scriptSetCost("OVERTIME_COMMUTE_BASIC") %>
			<%= scriptSetCost("OVERTIME_COMMUTE_PREMIUM") %>
			<%= scriptSetCost("OVERTIME_COMMUTE_VIP") %>
			<%= scriptSetCost("OVERTIME_COMMUTE_PRIVATE") %>
			<%= scriptSetCost("OVERTIME_COMMUTE_MULTIPLE") %>
			<%= scriptSetCost("OVERTIME_COMMUTE_INTENSIVE") %>

            /*
			<%= scriptSetCost("OVERTIME_INHOUSE_BASIC") %>
			<%= scriptSetCost("OVERTIME_INHOUSE_PREMIUM") %>
			<%= scriptSetCost("OVERTIME_INHOUSE_VIP") %>
			<%= scriptSetCost("OVERTIME_INHOUSE_PRIVATE") %>
			<%= scriptSetCost("OVERTIME_INHOUSE_MULTIPLE") %>
			<%= scriptSetCost("OVERTIME_INHOUSE_INTENSIVE") %>
            */

			<%= scriptSetCost("HOLIDAY_COMMUTE_BASIC") %>
			<%= scriptSetCost("HOLIDAY_COMMUTE_PREMIUM") %>
			<%= scriptSetCost("HOLIDAY_COMMUTE_VIP") %>
			<%= scriptSetCost("HOLIDAY_COMMUTE_PRIVATE") %>
			<%= scriptSetCost("HOLIDAY_COMMUTE_MULTIPLE") %>
			<%= scriptSetCost("HOLIDAY_COMMUTE_INTENSIVE") %>

			<%= scriptSetCost("HOLIDAY_INHOUSE_BASIC") %>
			<%= scriptSetCost("HOLIDAY_INHOUSE_PREMIUM") %>
			<%= scriptSetCost("HOLIDAY_INHOUSE_VIP") %>
			<%= scriptSetCost("HOLIDAY_INHOUSE_PRIVATE") %>
			<%= scriptSetCost("HOLIDAY_INHOUSE_MULTIPLE") %>
			<%= scriptSetCost("HOLIDAY_INHOUSE_INTENSIVE") %>
		}

        function saveOK() {
            alert("저장되었습니다.");
        }

		$(document).ready(function() {
			///////////////////////////////////
			// for Service
			$("#saveBasic").click(function() {
				$.post("_service_option_update.jsp", $("#Basic").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#savePremium").click(function() {
				$.post("_service_option_update.jsp", $("#Premium").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveVip").click(function() {
				$.post("_service_option_update.jsp", $("#Vip").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#savePrivate").click(function() {
				$.post("_service_option_update.jsp", $("#Private").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveTwins").click(function() {
				$.post("_service_option_update.jsp", $("#Twins").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveMultiples").click(function() {
				$.post("_service_option_update.jsp", $("#Multiples").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveIntensiveWorkingMom").click(function() {
				$.post("_service_option_update.jsp", $("#IntensiveWorkingMom").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveIntensiveCareHome").click(function() {
				$.post("_service_option_update.jsp", $("#IntensiveCareHome").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveIntensiveOver35").click(function() {
				$.post("_service_option_update.jsp", $("#IntensiveOver35").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveIntensiveHeavy").click(function() {
				$.post("_service_option_update.jsp", $("#IntensiveHeavy").serialize())
				.done(function(data) {
					saveOK();
				});
			});


			$("#saveExtended").click(function() {
				$.post("_service_option_update.jsp", $("#Extended").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveOvertimeCommute").click(function() {
				$.post("_service_option_update.jsp", $("#OvertimeCommute").serialize())
				.done(function(data) {
					saveOK();
				});
			});
            /*
			$("#saveOvertimeInhouse").click(function() {
				$.post("_service_option_update.jsp", $("#OvertimeInhouse").serialize())
				.done(function(data) {
					saveOK();
				});
			});
            */
			$("#saveHOLIdayCommute").click(function() {
				//alert($("#HOLIdayCommute").serialize());
				$.post("_service_option_update.jsp", $("#HOLIdayCommute").serialize())
				.done(function(data) {
					saveOK();
				});
			});
			$("#saveHOLIdayInhouse").click(function() {
				$.post("_service_option_update.jsp", $("#HOLIdayInhouse").serialize())
				.done(function(data) {
					saveOK();
				});
			});

			$("#moveService").click(function() {
				window.location.href = "content_service_edit.jsp";
			});
			$("#moveOption").click(function() {
				window.location.href = "content_option_edit.jsp";
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
			<div class="right_col policy_manage_gift" role="main">
				<div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">서비스 프로그램</a> &gt;
                        <a href="#!">서비스 상품/옵션</a>
                    </div>
					<!-- <div class="page-title">
						<div class="title_left">
							<h3>선물관리</h3>
						</div>
					</div> -->

					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										서비스 상품 / 옵션
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">

									<div class="" role="tabpanel" data-example-id="togglable-tabs">
										<ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
											<li role="presentation" class="active">
												<a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">서비스가격</a>
											</li>
											<li role="presentation" class="">
												<a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">옵션가격</a>
											</li>
										</ul>
										<div id="myTabContent" class="tab-content">
											<div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															베이직 서비스
															<% _type = "BASIC"; %>
														</h4>
														<!-- <hr> -->
														<form id="Basic">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																	<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	<% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveBasic">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															프리미엄 서비스
														</h4>
														<form id="Premium">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
																<% _type = "PREMIUM(C)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																	<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	<% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(입주)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
																<% _type = "PREMIUM(I)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																	<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	<% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="savePremium">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															VIP 서비스
														</h4>
														<form id="Vip">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															<% _type = "VIP(C)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	 <% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(입주)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
																<% _type = "VIP(I)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																	<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	<% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveVip">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															프라이빗 서비스
														</h4>
														<form id="Private">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
																<% _type = "PRIVATE(C)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																	<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	<% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(입주)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
																<% _type = "PRIVATE(I)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">1주</th>
																	<% _weekWork = "1W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">2주</th>
																	<% _weekWork = "2W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">3주</th>
																	<% _weekWork = "3W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">4주</th>
																	<% _weekWork = "4W"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="savePrivate">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															다둥이 프로그램
															<small>(쌍둥이 프로그램)</small>
															<% _type = "TWINS"; %>
														</h4>
														<form id="Twins">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">출퇴근 4주</th>
																	<% _weekWork = "C4"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">입주2주+출퇴근2주</th>
																	<% _weekWork = "I2C2"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">입주4주</th>
																	<% _weekWork = "I4"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveTwins">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															다둥이 프로그램
															<small>(다둥이 프로그램)</small>
															<% _type = "MULTIPLES"; %>
														</h4>
														<form id="Multiples">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">출퇴근 4주</th>
																	<% _weekWork = "C4"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">입주2주+출퇴근2주</th>
																	<% _weekWork = "I2C2"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
																<tr>
																	<th scope="row">입주4주</th>
																	<% _weekWork = "I4"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveMultiples">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															집중관리 프로그램
															<small>(워킹맘 케어 프로그램)</small>
													 	<% _type = "INTENSIVE(WORKINGMOM)"; %>
														</h4>
														<form id="IntensiveWorkingMom">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">입주2주+출퇴근2주</th>
																	<% _weekWork = "I2C2"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveIntensiveWorkingMom">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															집중관리 프로그램
															<small>(산후조리원 내집에 프로그램)</small>
															<% _type = "INTENSIVE(CAREHOME)"; %>
														</h4>
														<form id="IntensiveCareHome">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">입주2주+출퇴근2주</th>
																	<% _weekWork = "I2C2"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveIntensiveCareHome">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															집중관리 프로그램
															<small>(35세 이상 산모 집중케어)</small>
														</h4>
														<form id="IntensiveOver35">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
											 				   <% _type = "INTENSIVE(35)"; %>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">출퇴근4주</th>
											 						<% _weekWork = "C4"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveIntensiveOver35">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															집중관리 프로그램
															<small>(과체중 산모케어)</small>
											 				<% _type = "INTENSIVE(HEAVY)"; %>
														</h4>
														<form id="IntensiveHeavy">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>주(출퇴근)</th>
																	<th>예약금(공통)</th>
																	<th>잔금_주5일</th>
																	<th>주5일 합계금</th>
																	<th>잔금_주6일</th>
																	<th>주5일 합계금</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">출퇴근4주</th>
										  							<% _weekWork = "C4"; %>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(0) %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(1) %> >
																	</td>
																	<td <%= getIDName(3) %>>예약금+잔금=자동계산</td>
																	<td>
																		<input type="text" class="form-control" <%= getIDName(2) %> >
																	</td>
																	<td <%= getIDName(4) %>>예약금+잔금=자동계산</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveIntensiveHeavy">저장</a>
													</div>
												</div>
											</div>
											<div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															추가비용
															<small> - 가족케어 기준은 1일입니다.</small>
														</h4>
														<form id="Extended">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th>구분</th>
																	<th>미취학아동</th>
																	<th>취학아동</th>
																	<th>추가가족</th>
																	<th>쌍둥이케어</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<th scope="row">출퇴근</th>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_COMMUTE_NOSCHOOL") %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_COMMUTE_SCHOOL") %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_COMMUTE_FAMILY") %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_COMMUTE_TWIN") %> >
																	</td>
																</tr>
																<tr>
																	<th scope="row">입주</th>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_INHOUSE_NOSCHOOL") %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_INHOUSE_SCHOOL") %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_INHOUSE_FAMILY") %> >
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("EXTENDED_INHOUSE_TWIN") %> >
																	</td>
																</tr>
															</tbody>
														</table>
														</form>
														<a class="btn btn-primary btn-sm" id="saveExtended">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															시간초과(출퇴근)
															<small> - 시간초과 기준은 1시간입니다.</small>
														</h4>
                                                        <form id="OvertimeCommute">
														<table class="table table-striped">
															<tbody>
																<tr>
																	<td>
																		베이직
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("OVERTIME_COMMUTE_BASIC") %> >
																	</td>
																	<td>
																		프리미엄
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("OVERTIME_COMMUTE_PREMIUM") %> >
																	</td>
																</tr>
																<tr>
																	<td>
																		VIP
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("OVERTIME_COMMUTE_VIP") %> >
																	</td>
																	<td>
																		프라이빗
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("OVERTIME_COMMUTE_PRIVATE") %> >
																	</td>
																</tr>
																<tr>
																	<td>
																		다둥이
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("OVERTIME_COMMUTE_MULTIPLE") %> >
																	</td>
																	<td>
																		집중관리
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("OVERTIME_COMMUTE_INTENSIVE") %> >
																	</td>
																</tr>
															</tbody>
														</table>
                                                        </form>
														<a class="btn btn-primary btn-sm" id="saveOvertimeCommute">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															휴일근무(출퇴근)
															<small> - 시간초과 기준은 1시간입니다.</small>
														</h4>
                                                        <form id="HOLIdayCommute">
														<table class="table table-striped">
															<tbody>
																<tr>
																	<td>
																		베이직
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_COMMUTE_BASIC") %> >
																	</td>
																	<td>
																		프리미엄
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_COMMUTE_PREMIUM") %> >
																	</td>
																</tr>
																<tr>
																	<td>
																		VIP
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_COMMUTE_VIP") %> >
																	</td>
																	<td>
																		프라이빗
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_COMMUTE_PRIVATE") %> >
																	</td>
																</tr>
																<tr>
																	<td>
																		다둥이
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_COMMUTE_MULTIPLE") %> >
																	</td>
																	<td>
																		집중관리
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_COMMUTE_INTENSIVE") %> >
																	</td>
																</tr>
															</tbody>
														</table>
                                                        </form>
														<a class="btn btn-primary btn-sm" id="saveHOLIdayCommute">저장</a>
													</div>
												</div>
												<hr>
												<div class="row">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<h4>
															<i class="fa fa-slack"></i>
															휴일근무(입주)
															<small> - 시간초과 기준은 1시간입니다.</small>
														</h4>
                                                        <form id="HOLIdayInhouse">
														<table class="table table-striped">
															<tbody>
																<tr>
																	<td>
																		베이직
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_INHOUSE_BASIC") %> >
																	</td>
																	<td>
																		프리미엄
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_INHOUSE_PREMIUM") %> >
																	</td>
																</tr>
																<tr>
																	<td>
																		VIP
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_INHOUSE_VIP") %> >
																	</td>
																	<td>
																		프라이빗
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_INHOUSE_PRIVATE") %> >
																	</td>
																</tr>
																<tr>
																	<td>
																		다둥이
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_INHOUSE_MULTIPLE") %> >
																	</td>
																	<td>
																		집중관리
																	</td>
																	<td>
																		<input type="text" class="form-control" <%= dupIdName("HOLIDAY_INHOUSE_INTENSIVE") %> >
																	</td>
																</tr>
															</tbody>
														</table>
                                                        </form>
														<a class="btn btn-primary btn-sm" id="saveHOLIdayInhouse">저장</a>
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