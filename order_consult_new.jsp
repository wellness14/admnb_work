<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	String arrVoucher[][] =
	{
		{ "A-가-1", "SUP-A-GA_1ST", "5 10 15" },
		{ "A-가-2", "SUP-A-GA_2ND", "10 15 20" },
		{ "A-가-3", "SUP-A-GA_3RD", "10 15 20" },

		{ "A-나-1", "SUP-A-NA_1ST", "5 10 15" },
		{ "A-나-2", "SUP-A-NA_2ND", "10 15 20" },
		{ "A-나-3", "SUP-A-NA_3RD", "10 15 20" },

		{ "A-다-1", "SUP-A-DA_1ST", "5 10 15" },
		{ "A-다-2", "SUP-A-DA_2ND", "10 15 20" },
		{ "A-다-3", "SUP-A-DA_3RD", "10 15 20" },

		{ "A-라-1", "SUP-A-RA_1ST", "5 10 15" },
		{ "A-라-2", "SUP-A-RA_2ND", "10 15 20" },
		{ "A-라-3", "SUP-A-RA_3RD", "10 15 20" },

		{ "B-가-1", "SUP-B-GA_2ND", "10 15 20" },
		{ "B-가-2", "SUP-B-GA_3RD", "15 20 25" },
		{ "B-나-1", "SUP-B-NA_2ND", "10 15 20" },
		{ "B-나-2", "SUP-B-NA_3RD", "15 20 25" },
		{ "B-다-1", "SUP-B-DA_2ND", "10 15 20" },
		{ "B-다-2", "SUP-B-DA_3RD", "15 20 25" },
		{ "B-라-1", "SUP-B-RA_2ND", "10 15 20" },
		{ "B-라-2", "SUP-B-RA_3RD", "15 20 25" },
		{ "C-가", "SUP-C-GA", "15 20 25" },
		{ "C-나", "SUP-C-NA", "15 20 25" },
		{ "C-다", "SUP-C-NA", "15 20 25" },
		{ "C-라", "SUP-C-NA", "15 20 25" }
	};

	String arrServices[][] =
	{
		{ "BASIC", "베이직 서비스", "", "1W 2W 3W 4W" },
		{ "PREMIUM", "프리미엄 서비스", "IC", "1W 2W 3W 4W" },
		{ "VIP", "vip 서비스", "IC", "1W 2W 3W 4W" },
		{ "PRIVATE", "프라이빗 서비스", "IC", "1W 2W 3W 4W" },
		{ "TWINS", "다둥이 프로그램(쌍둥이 프로그램)", "", "C4 I2C2 I4" },
		{ "MULTIPLES", "다둥이 프로그램(다둥이 프로그램)", "", "C4 I2C2 I4" },
		{ "INTENSIVE(WORKINGMOM)", "집중관리 프로그램(워킹맘 케어 프로그램)", "", "I2C2" },
		{ "INTENSIVE(CAREHOME)", "집중관리 프로그램(산후조리원 내집에 프로그램)", "", "I2C2" },
		{ "INTENSIVE(35)", "집중관리 프로그램(35세 이상 산모 집중케어)", "", "C4" },
		{ "INTENSIVE(HEAVY)", "집중관리 프로그램(과체중 산모케어)", "", "C4" }
	};

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	public String fillValue(String name, String val)
	{
		return "$('#"+name+"').val('"+val+"');\n";
	}

	public String fillValue(String name, int val)
	{
		return "$('#"+name+"').val('"+val+"');\n";
	}

	public String getBasicServiceOptions()
	{
		String ret = "<option value='0' selected='selected'>선택</option>\n";

		for (int val = 1; val <= 15; val++)
		{
			ret += "<option value='" + val + "'>" + val + "</option>\n";
		}

		return ret;
	}

	public List<Region> _lstAll;

	public List<Branch> getBelongedBranchList(int index)
	{
		List<Branch> lst = new ArrayList<Branch>();
		ResultSet rs = null;
		Branch item;
		String sql;

		sql = "select * from BRANCH where MEMBER_INDEX=" + index;
		rs = DBPool.getResultSet(sql);
		while (UserDB.getNext(rs))
		{
			item = new Branch();
			item.fromResultSet(rs);
			lst.add(item);
		}
		DBPool.removeDBObject(rs);

		return lst;
	}

	public String getRegionName(int regionIndex)
	{
		Iterator iter;
		String ret = "미지정";

		if (_lstAll == null)
			_lstAll = _userdb.getRegionList(0);
		iter = _lstAll.iterator();

		while (iter.hasNext())
		{
			Region r = (Region)iter.next();
			if (r._index == regionIndex)
			{
				ret = r._name;
				break;
			}
		}

		return ret;
	}

%>

<%
	Customer item = null;
	String customerIndex;
	String fill = "";
	int index = -1;
	int idx;

	customerIndex = request.getParameter("CUSTOMER");
	if (customerIndex != null)
	{
		index = Integer.parseInt(customerIndex);
		item = _userdb.getCustomerItem(index);
	}
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>마더앤베이비 관리자 - <%= ((index == -1) ? "신규상담등록" : "상담정보수정") %></title>

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
	<style>
		.red {
			color: red;
		}
	</style>
	<script
	src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	<script src="js/content_consult_new.js" ></script>
	<script src="js/base64.js" ></script>
	<script src="js/myutils.js" ></script>
	<script>
		function onCheckPayment() {
			var serviceType = $("input[name='PAYMENT_SERVICE_TYPE']:checked").val();
			var paymentType = $("input[name='PAYMENT_PAY_TYPE']:checked").val();
			var cost = $("#PAYMENT_COST").val();
			addCheckedPayment(serviceType, paymentType, cost);
			$("input[name='PAYMENT_SERVICE_TYPE'][value='basic']").prop('checked', true);
			$("input[name='PAYMENT_PAY_TYPE'][value='deposit']").prop('checked', true);
			$("#PAYMENT_COST").val('0');
		}

		function onCancelCheckPayment() {
			// set to default
			$("input[name='PAYMENT_SERVICE_TYPE'][value='basic']").prop('checked', true);
			$("input[name='PAYMENT_PAY_TYPE'][value='deposit']").prop('checked', true);
			$("#PAYMENT_COST").val('0');
		}

		function onDiscount() {
			var cost = $("#DISCOUNT_COST").val();
			var reason = $("#DISCOUNT_REASON").val();
			addCheckedPayment('discount', reason, cost);
			$("#DISCOUNT_COST").val('0');
			$("#DISCOUNT_REASON").val('');
		}

		function onCancelDiscount() {
			$("#DISCOUNT_COST").val('0');
			$("#DISCOUNT_REASON").val('');
		}

		function onServiceType(index, type) {
			_services[index]._type = type;
		}

		function onChangeService(index) {
			var name = $("#SERVICE_NAME_" + index).val();
			var html = "<option value='0' selected>서비스기간</option>";

			for (var idx in serviceNames) {
				if (serviceNames[idx][0] == name) {
					var vals = serviceNames[idx][3].split(" ");
					for (var i in vals) {
						html += "<option value='" + vals[i] + "'>" + getServicePeriodDisp(vals[i]) + "</option>\n";
					}
					//console.log(vals);
					//getServicePeriodOptions(idx);
					var tmp;
					var val;
					tmp = document.getElementById('I' + index); val = 'none';
					if (serviceNames[idx][2].search("I") >= 0) {
						val = '';
					}
					tmp.style.display = val;
					tmp = document.getElementById('C' + index); val = 'none';
					if (serviceNames[idx][2].search("C") >= 0) {
						val = '';
					}
					tmp.style.display = val;
					tmp = document.getElementById('M' + index); val = 'none';
					if (serviceNames[idx][2].search("M") >= 0) {
						val = '';
					}
					tmp.style.display = val;
					break;
				}
			}

			$("#SERVICE_PERIOD_" + index).html(html);
		}

		function setCheck(name, val) {
			//document.getElementsById(name).checked = true;
			temp = document.getElementsByName(name);
			//console.log(temp);
			for (i = 0; i < temp.length; i++) {
				if (temp[i].value == val) {
					temp[i].checked = true;
				}
			}
		}

		function writePeriodList(name) {
			document.write("<select name='" + name + "' id='" + name + "' >\n");
			document.write("<option value='0' selected>기간선택</option>\n");
			for (var i = 1; i <= 31; i++) {
					document.write("<option value='" + i + "'>" + i + "일</option>\n");
				}
			document.write("</select>");
		}

		var serviceNames = [
		<%
		for (int i = 0; i < arrServices.length; i++)
		{
			out.write("['" + arrServices[i][0] + "', '" + arrServices[i][1] + "', '" + arrServices[i][2] + "', '" + arrServices[i][3] + "'],\n");
		}
		%>
		];

		function getServiceName(val) {
			var ret = '미지정';

			for (i in serviceNames) {
				if (serviceNames[i][0] == val) {
					ret = serviceNames[i][1];
					break;
				}
			}

			return ret;
		}

		var costTable = [
		<%
			//String sql = "select * from SERVICE_OPTION where TYPE like 'EXTENDED%' or TYPE like 'OVERTIME%' or TYPE like 'HOLIDAY%'";
			String sql = "select * from SERVICE_OPTION";
			ResultSet rs = null;
			ServiceOption opt;

			opt = new ServiceOption();
			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				opt.fromResultSet(rs);
				out.write("['" + opt._type + "', " + opt._cost + "],\n");
			}
			DBPool.removeDBObject(rs);
		%>
		];

		function getServiceCost(service, period, tag) {
			var key = service.toUpperCase() + '_' + period.toUpperCase() + '_' + tag.toUpperCase();
			var ret = 0;

			for (i in costTable) {
				if (costTable[i][0] == key) {
					ret = costTable[i][1];
					break;
				}
			}

			//console.log("KEY:" + key + ", val:" + ret);
			return ret;
		}

		function getExtendedCost(type, option) {
			var key = 'EXTENDED_' + type.toUpperCase() + '_' + option.toUpperCase();
			var ret = 0;

			for (i in costTable) {
				if (costTable[i][0] == key) {
					ret = costTable[i][1];
					break;
				}
			}

			//console.log("KEY:" + key + ", val:" + ret);
			return ret;
		}

		function getOvertimeCost(service, type, hours) {
			if (service.search("INTENS") >= 0)
				service = "INTENSIVE";
			var temp = "OVERTIME";
			if (hours[0] == 'H')
			{
				temp = "HOLIDAY";
				hours = hours.substring(1);
			}
			hours = parseInt(hours);
			var key = temp + '_' + type.toUpperCase() + '_' + service.toUpperCase();
			var ret = 0;

			for (i in costTable) {
				if (costTable[i][0] == key) {
					ret = costTable[i][1];
					break;
				}
			}

			console.log("OVERTIME KEY:" + key + ", val:" + ret + ", HOURS:" + hours);
			return ret * hours;
		}

		var costVoucher = [
		<%
			sql = "select * from SERVICE_OPTION where TYPE like 'SUP%'";

			opt = new ServiceOption();
			rs = DBPool.getResultSet(sql);
			while (UserDB.getNext(rs))
			{
				opt.fromResultSet(rs);
				out.write("['" + opt._type + "', '" + opt._cost + "'],\n");
			}
			DBPool.removeDBObject(rs);
		%>
		];

		var voucherDays = [
		<%
		for (int i = 0; i < arrVoucher.length; i++)
		{
			String temps[] = arrVoucher[i][2].split(" ");
			out.write("['" + arrVoucher[i][1] + "', [" + temps[0] + ", " + temps[1] + ", " + temps[2] + "]],\n");
		}
		%>
		];

		function getVoucherCost(type) {
			for (i in costVoucher) {
				if (costVoucher[i][0] == type) {
					return costVoucher[i][1];
				}
			}

			console.log("NOT found:[" + type + "]");
			return 0;
		}

		var _voucherSupport = 0;
		var _voucherCost = 0;

		function calculateCost() {
			var type = $("#VOUCHER").val();
			var days = $("input[name='VOUCHER_PERIOD']:checked").val();
			var babyType = '삼태아이상 중증장애산모';
			var post1 = '';
			var post2 = '';

			if (type.search("A-") >= 0) {
				babyType = "단태아";
				/*
				if (type.search("1ST") >= 0) {
					babyType = "첫째아";
				}
				if (type.search("2ND") >= 0) {
					babyType = "둘째아";
				}
				if (type.search("3RD") >= 0) {
					babyType = "셋째아 이상";
				}
				*/
			} else if (type.search("B-") >= 0) {
				babyType = "쌍태아";
				/*
				if (type.search("1ST") >= 0) {
					babyType = "둘째아";
				}
				if (type.search("2ND") >= 0) {
					babyType = "셋째아 이상";
				}
				*/
			}
			console.log("DAYS:" + days);
			//console.log("Index:" + (days / 5 - 1));
			$("#BabyType").html(babyType + " [자동산정]");

			for (i in voucherDays) {
				if (voucherDays[i][0].search(type) >= 0) {
					if (voucherDays[i][1][0] == days) {
						post1 = "_D05";
						post2 = "_SHT";
					}
					if (voucherDays[i][1][1] == days) {
						post1 = "_D10";
						post2 = "_STD";
					}
					if (voucherDays[i][1][2] == days) {
						post1 = "_D15";
						post2 = "_EXT";
					}
					break;
				}
			}
			var key = type + post2 + "_GOV";
			console.log("========================> KEY-G: " + key);
			_voucherSupport = getVoucherCost(key);
			key = type + post2 + "_SLF";
			console.log("========================> KEY-S: " + key);
			_voucherCost = getVoucherCost(key);

			$("#VoucherSupport").html(_voucherSupport + "원 [자동산정]");
			$("#VoucherCost").html(_voucherCost + "원 [자동산정]");

			calculateTotal();
		}

		var _totalCost = 0;
		function calculateTotal() {
			$("#CostVoucher").html(_voucherSupport + "원");
			var html = "";
			//var cost = 0;
			_totalCost = 0;
			for (t in _services) {
				//console.log(">>>>-" + t);
				html += _services[t].fillCost();
				console.log(">>>>+" + t + ":" + _services[t]._cost);
				_totalCost += _services[t]._cost;
			}
			$("#ServiceCosts").html(html);

			$("#CostTotal").html('' + _totalCost + '원');
			getCheckedPaymentList();
		}

		$(function() {
			if (_service == '') {
				init();
				_service = document.getElementById("org").innerHTML;
				document.getElementById("org").innerHTML = '';
			}

			_memberIndex = <%= _user._index %>;
			loadRentalList();
<%

		customerIndex = request.getParameter("CUSTOMER");
		if (index != -1)
		{
			fill += fillValue("NAME", item._name);
			fill += fillValue("MOBILE", item._mobile);
			fill += fillValue("PHONE", item._phone);
			fill += fillValue("POST", item._post);
			fill += fillValue("ADDRESS1", item._address1);
			fill += fillValue("ADDRESS2", item._address2);
			fill += fillValue("ROUTE_VALUE", item._routeVal);

			fill += fillValue("HOSPITAL", item._hospital);
			fill += fillValue("CARECENTER_PERIOD", item._careCenterPeriod);

			if (item._expectedDate != null)
				fill += fillValue("DUEDATE_BIRTH", df.format(item._expectedDate));
			if (item._operationDate != null)
				fill += fillValue("DUEDATE_OPERATION", df.format(item._operationDate));
			if (item._babyBirth != null)
				fill += fillValue("BABY_BIRTH", df.format(item._babyBirth));

			String s[] = item._routes.split(" ");
			for (idx = 0; idx < s.length; idx++)
			{
				//fill += "console.log('ROUTE' + '" + s[idx] + "');\n";
				fill += "setCheck('ROUTE', '" + s[idx] + "');\n";
			}

			//fill += fillValue("RentalName", item._rentalIndex);
			if (item._rentalBegin != null)
				fill += fillValue("RENTAL_START", df.format(item._rentalBegin));
			if (item._rentalEnd != null)
				fill += fillValue("RENTAL_END", df.format(item._rentalEnd));
			if (item._rentalDeliveryPayed != null)
				fill += fillValue("RENTAL_DELIVERY_PAYED", df.format(item._rentalDeliveryPayed));
			fill += fillValue("DELIVERY_COST", item._rentalDeliveryCost);
			if (item._rentalPayed != null)
				fill += fillValue("RENTAL_PAYED", df.format(item._rentalPayed));
			fill += fillValue("RENTAL_COST", item._rentalCost);

			//fill += fillValue("GiftName", item._giftIndex);
			if (item._giftSent1 != null)
				fill += fillValue("GIFT_SENT_DATE1", df.format(item._giftSent1));
			if (item._giftSent2 != null)
				fill += fillValue("GIFT_SENT_DATE2", df.format(item._giftSent2));

			//fill += fillValue("TerminalName", item._terminalIndex);
			if (item._terminalBegin != null)
				fill += fillValue("TERMINAL_START", df.format(item._terminalBegin));
			if (item._terminalEnd != null)
				fill += fillValue("TERMINAL_END", df.format(item._terminalEnd));

			if (item._recommendIndex != -1)
			{
				Customer recommend = _userdb.getCustomerItem(item._recommendIndex);
				if (recommend != null)
					fill += fillValue("RECOMMEND", recommend._name);
				out.write("recommenderIndex = " + item._recommendIndex + ";\n");
			}
			if (item._rentalIndex != -1)
			{
				Rental rental = _userdb.getRental(item._rentalIndex);
				if (rental != null)
					fill += fillValue("RentalName", rental._name);
				out.write("rentalIndex = " + item._rentalIndex + ";\n");
			}
			if (item._giftIndex1 != -1)
			{
				Gift gift = _userdb.getGift(item._giftIndex1);
				if (gift != null)
					fill += fillValue("GiftName1", gift._name);
				out.write("giftIndex1 = " + item._giftIndex1 + ";\n");
			}
			if (item._giftIndex2 != -1)
			{
				Gift gift = _userdb.getGift(item._giftIndex2);
				if (gift != null)
					fill += fillValue("GiftName2", gift._name);
				out.write("giftIndex2 = " + item._giftIndex2 + ";\n");
			}
			if (item._terminalIndex != -1)
			{
				Terminal terminal = _userdb.getTerminal(item._terminalIndex);
				if (terminal != null)
					fill += fillValue("TerminalName", terminal._no);
				out.write("terminalIndex = " + item._terminalIndex + ";\n");
			}

			out.write(fill);
			//out.write("alert('" + item._routes.length() + "');");
			//out.write("alert('" + item._memo + "');");
%>
			setChildrenString('<%=item._experiences%>');
			setBabiesString('<%=item._babyTypes%>');

			_indexCustomer = <%=item._index%>;

			setCheck('BABY_TYPE_EXPECTED', '<%=item._babyTypeExpected%>');
			setCheck('DISABLED', '<%=item._disabledType%>');
			setCheck('CARECENTER', '<%=item._careCenter%>');
			setCheck('CARE_PLACE_EXPECTED', '<%=item._servicePlaceWish%>');

			setCheck('CHILDBIRTH_TYPE', '<%=item._childBirthType%>');
			setCheck('CARE_PLACE_REAL', '<%=item._servicePlaceReal%>');

			document.getElementById("COUNSEL_CONTENT").innerHTML = base64.decode('<%=item._memo%>'.replace(/\s/g, "+"));
			$("#VOUCHER").val('<%=(item._voucherType != null) ? item._voucherType : "none" %>');
			setCheck('VOUCHER_PERIOD', '<%=item._voucherDays%>');
			setPets('<%=item._pets%>');
			setCheck('CASHBILL', '<%=item._cashReceipt%>');


			loadCustomerServices();

<%
		}
		else
		{
			//UserDB.makeNewCustomer
			out.write("addCustomerService_forDummy();\n");
		}
%>
			onCancelCheckPayment(); // set to default
			calculateCost();
		});
		/*
		$(document).ready(function() {
			$("#save").click(function() {
				alert("ready");
				submitMe();
			});
		});
		*/

		$(document).ready(function() {
		});

		function cancel() {
			window.history.go(-1);
		}
	</script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
<%@ include file="order_left_menu.jspf" %>
<%@ include file="order_top_nav.jspf" %>

			<!-- page content -->
			<div class="right_col order_consult_new" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>상담/문의
								<small>
									<label for="">상담지점</label>
									<!--<span class="label label-info consult-branch">관악</span>-->
									<select name='CONSULT_BRANCH' id='CONSULT_BRANCH' class="form-control input-sm">
										<%
											Iterator iter = getBelongedBranchList(_user._index).iterator();
											boolean hasBranch = false;

											if (_user.isHQ())
											{
												out.write("<option value=-1 selected>본사</option>");
											}
											else
											{
												while (iter.hasNext())
												{
													Branch b = (Branch)iter.next();
													// b._index: 지점의 index
													// b._region: 지역의 index
													out.write("<option value=" + b._index + ">" + getRegionName(b._region) + "</option>");
													hasBranch = true;
												}
												if (hasBranch == false)
												{
													out.write("<option value=-1 selected>지사없음</option>");
												}
											}
										%>
									</select>
								</small>
								<small>
									<label for="">상담직원</label>
									<span class="label label-info"><%= _user._business %></span>
								</small>
							</h3>
							
						</div>

						<div class="title_right">
							<a class="btn btn-primary btn-sm pull-right consult-save" onclick="saveAll()">저장 후 서비스 &middot; 계약정보 이동</a>
							<!--
							<a href="#!" class="btn btn-warning btn-sm pull-right temp-save" data-toggle="modal" data-target=".temp-save-list">임시저장(10)</a>
							-->
							<a class="btn btn-default btn-sm pull-right consult-cancel" onclick="cancel()">작성취소</a>

							<!-- 임시저장 팝업 -->
							<!--
							<div class="modal fade bs-example-modal-lg temp-save-list" tabindex="-1" role="dialog" aria-hidden="true">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
							
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">
												<span aria-hidden="true">×</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">임시저장 리스트</h4>
										</div>
										<div class="modal-body">
											<table class="table table-hover">
												<thead>
													<tr>
														<th>이름</th>
														<th>휴대전화</th>
														<th>저장일</th>
														<th>저장/삭제</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<th scope="row">강아름</th>
														<td>010-1111-1111</td>
														<td>2018.05.28</td>
														<td>
															<a href="#!" class="btn btn-xs btn-default">
																<i class="fa fa-plus "></i>
															</a>
															<a href="#!" class="btn btn-xs btn-default">
																<i class="fa fa-minus "></i>
															</a>
														</td>
													</tr>
													<tr>
														<th scope="row">강아름</th>
														<td>010-1111-1111</td>
														<td>2018.05.28</td>
														<td>
															<a href="#!" class="btn btn-xs btn-default">
																<i class="fa fa-plus "></i>
															</a>
															<a href="#!" class="btn btn-xs btn-default">
																<i class="fa fa-minus "></i>
															</a>
														</td>
													</tr>
													
												</tbody>
											</table>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
										</div>
							
									</div>
								</div>
							</div>
							-->
							<!-- 임시저장 팝업 -->

						</div>
					</div>

					
					<div class="row">
						<!-- 기본정보 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>기본정보</h2>
									
									<div class="clearfix"></div>
								</div>
								<div class="x_content fixed_height_320">
									<form id="formData_1" data-parsley-validate class="form-horizontal form-label-left">
									
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">성함
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" required="required" class="form-control col-md-7 col-xs-12" name="NAME" id="NAME" />
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">휴대전화
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" name="MOBILE" id="MOBILE" required="required" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">일반전화</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input class="form-control col-md-7 col-xs-12" type="text" name="PHONE" id="PHONE">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">주소
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<div class="input-group">
													<input type="text" class="form-control" placeholder="우편번호" id="POST" name="POST">
													<span class="input-group-btn">
														<button type="button" class="btn btn-primary btn-addr-search">검색</button>
													</span>
												</div>
												<input type="text" class="form-control addr1" placeholder="주소" id="ADDRESS1" name="ADDRESS1">
												<input type="text" class="form-control addr2" placeholder="상세주소" id="ADDRESS2" name="ADDRESS2">
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!-- 접근 &middot; 추천 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>접근 &middot; 추천</h2>
					
									<div class="clearfix"></div>
								</div>
								<div class="x_content reference-type fixed_height_320">
									<form id="formData_2" data-parsley-validate class="form-horizontal form-label-left">
									<h4>
										<i class="fa fa-check"></i>
										접근분류 선택</h4>
									<ul class="list-unstyled">
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="phone">
											<label for="">전화옴</label>
										</li>
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="web">
											<label for="">홈페이지</label>
										</li>
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="exhibition">
											<label for="">전시회</label>
										</li>
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="voucher">
											<label for="">바우처</label>
										</li>
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="center">
											<label for="">조리원소개</label>
										</li>
									</ul>
									<ul class="list-unstyled">
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="etc">
											<label for="">기타</label>
											<input type="text" class="form-control" placeholder="기타 접근, 추천내용" name="ROUTE_VALUE" id="ROUTE_VALUE" >
										</li>
									</ul>
									<div class="clearfix"></div>
									<small>* 홈페이지 가입은 자동으로 접근 분류가 지정됩니다.</small>
									<hr>
									<h4>
										<i class="fa fa-check"></i>
										추천경로선택</h4>
									<ul class="list-unstyled">
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="recommend">
											<label for="">지인추천</label>
										</li>
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="search">
											<label for="">검색을 통해</label>
										</li>
										<li>
											<input type="checkbox" id="ROUTE" name="ROUTE" value="blog">
											<label for="">블로그</label>
										</li>
									</ul>
									
									<div class="input-group reference">
										<div class="input-group">
											<input type="text" class="form-control" placeholder="추천인의 이름, id, 휴대번호" name="RECOMMEND" id="RECOMMEND">
											<span class="input-group-btn">
												<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".user-search" onclick="openRecommendSelectionWindow()">검색</button>
											</span>
										</div>
										<!-- <input type="text" class="form-control" placeholder="지인추천 선택 시 추천인의 이름이나 id, 휴대번호로 검색">
										<span class="input-group-btn">
											<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".user-search">검색</button>
										</span> -->
										<!-- 추천지인검색 팝업 -->
										<div class="modal fade bs-example-modal-lg user-search" tabindex="-1" role="dialog" aria-hidden="true" >
											<div class="modal-dialog modal-lg">
												<div class="modal-content">
										
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">
															<span aria-hidden="true">×</span>
														</button>
														<h4 class="modal-title" id="myModalLabel">추천지인검색</h4>
													</div>
													<div class="modal-body">
														<table class="table table-hover">
															<thead>
																<tr>
																	<th>아이디</th>
																	<th>성함</th>
																	<th>휴대폰번호</th>
																	<th></th>
																</tr>
															</thead>
															<tbody id="recommenders">
																<!--
																<tr>
																	<th scope="row">ruice33</th>
																	<td>조아라</td>
																	<td>조아라</td>
																	<td>010-4461-8845</td>
																	<td><a href="#!" class="btn btn-xs btn-primary" data-dismiss="modal">확인</a></td>
																</tr>
																<tr>
																	<th scope="row">ruice33</th>
																	<td>조아라</td>
																	<td>조아라</td>
																	<td>010-4461-8845</td>
																	<td>
																		<a href="#!" class="btn btn-xs btn-primary" data-dismiss="modal">확인</a>
																	</td>
																</tr>
																-->
															</tbody>
														</table>
													</div>
										
												</div>
											</div>
										</div>
										<!-- 추천지인검색 팝업 -->
									</div>
									</form>
									<small>* 지인추천현황은 통계메뉴에서 확인</small>
								</div>
							</div>
						</div>
						
						<!-- 출산정보 사전정보 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>출산정보 &middot; 사전정보</h2>
						
									<div class="clearfix"></div>
								</div>
								<div class="x_content natal-info">
									<form id="formData_3" data-parsley-validate class="form-horizontal form-label-left">
						
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">지정병원
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" name="HOSPITAL" id="HOSPITAL" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">출산예정일
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="date" name="DUEDATE_BIRTH" id="DUEDATE_BIRTH" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">수술예정일</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input class="form-control col-md-7 col-xs-12" type="date"name="DUEDATE_OPERATION" id="DUEDATE_OPERATION">
											</div>
										</div>
										<div class="form-group ">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">출산경험</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<!--
												<div class="radio-group">
													<input type="radio" name="natal-exp" class="flat" id="">
													<label for="">초산</label>
													<input type="radio" name="natal-exp" class="flat" id="">
													<label for="">경산</label>
												</div>
												<hr>
												<small>* 자녀의 정보</small>
												-->
												<div class="radio-group">
													<input type="radio" name="CHILD_GENDER" value="boy" checked>
													<label for="">남</label>
													<input type="radio" name="CHILD_GENDER" value="girl">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="나이" name="CHILD_AGE" id="child_age"> 세
													<button onclick="addChild()" type="button">+</button><br/>
													<p id="children" align=center>없음(초산)
													</p>
												</div>
												<!--
												<div class="radio-group">
													<input type="radio" name="child-gender2" class="flat" id="">
													<label for="">남</label>
													<input type="radio" name="child-gender2" class="flat" id="">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="나이">세
												</div>
												<div class="radio-group">
													<input type="radio" name="child-gender3" class="flat" id="">
													<label for="">남</label>
													<input type="radio" name="child-gender3" class="flat" id="">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="나이">세
												</div>
												<div class="radio-group">
													<input type="radio" name="child-gender4" class="flat" id="">
													<label for="">남</label>
													<input type="radio" name="child-gender4" class="flat" id="">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="나이">세
												</div>
												-->
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">태아유형</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
													<input type="radio" name="BABY_TYPE_EXPECTED" value="single" id="BABY_TYPE_EXPECTED" checked>
													<label for="">단태아</label>
													<input type="radio" name="BABY_TYPE_EXPECTED" value="twin" id="BABY_TYPE_EXPECTED">
													<label for="">쌍둥이</label>
													<input type="radio" name="BABY_TYPE_EXPECTED" value="more" id="BABY_TYPE_EXPECTED">
													<label for="">삼태아</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">중증장애산모</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
													<input type="radio" name="DISABLED" value="true">
													<label for="">예</label>
													<input type="radio" name="DISABLED" value="false" checked>
													<label for="">아니오</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">산후조리원이용</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
												<input type="radio" name="CARECENTER" value="true" checked >
												<label for="">예</label>
												<select name="CARECENTER_PERIOD" id="CARECENTER_PERIOD" class="form-control input-sm">
													<option value="w1">1주</option>
													<option value="d10">10일</option>
													<option value="w2">2주</option>
													<option value="w3">3주</option>
													<option value="w4">4주</option>
												</select>
												<input type="radio" name="CARECENTER" value="false">
												<label for="">아니오</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">관리사서비스 희망장소</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
												<input type="radio" name="CARE_PLACE_EXPECTED" value="home" checked>
												<label for="">자택</label>
												<input type="radio" name="CARE_PLACE_EXPECTED" value="home_mother">
												<label for="">친정</label>
												<input type="radio" name="CARE_PLACE_EXPECTED" value="home_father">
												<label for="">시댁</label>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!-- 가입정보 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>가입정보</h2>
						
									<div class="clearfix"></div>
								</div>
								<div class="x_content regist-info">
									<div class="row">
										<label for="">아이디</label>
										<%
											if ((index != -1) && (item._id.length() > 0))
												out.write("<span class='label label-warning id-state' id='USER_ID'>" + item._id + "</span>");
											else
												out.write("<span class='label label-warning id-state' id='USER_ID'>입력대기중</span>");
										%>
									</div>
									<div class="row">
										<a class="btn btn-primary btn-sm" data-toggle="modal" data-target=".register_sms" onclick="showSMSDialog()">가입문자발송</a>
										<!-- 가입문자발송 팝업 -->
										<div class="modal fade bs-example-modal-lg register_sms" tabindex="-1" role="dialog" aria-hidden="true">
											<div class="modal-dialog modal-xs">
												<div class="modal-content">
										
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">
															<span aria-hidden="true">×</span>
														</button>
														<h4 class="modal-title" id="myModalLabel">가입문자발송</h4>
													</div>
													<div class="modal-body">
														<form action="">
															<input type="text" id="SMS_MOBILE_NUMBER" class="form-control" placeholder="전화번호가 입력되지 않았습니다." readonly>
															<!-- <div class="btn-group">
																<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false">전체(본사/지사전체)
																	<span class="caret"></span>
																</button>
																<ul role="menu" class="dropdown-menu">
																	<li>
																		<a href="#">본사</a>
																	</li>
																	<li>
																		<a href="#">지사</a>
																	</li>
																</ul>
															</div>
															<div class="btn-group">
																<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false">모든사람에게
																	<span class="caret"></span>
																</button>
																<ul role="menu" class="dropdown-menu">
																	<li>
																		<a href="#">서동필</a>
																	</li>
																	<li>
																		<a href="#">손선애</a>
																	</li>
																	<li>
																		<a href="#">정혜윤</a>
																	</li>
																	<li>
																		<a href="#">서원우</a>
																	</li>
																</ul>
															</div> -->
															<div class="message-box">
																<textarea name="SMS" id="SMS" placeholder="내용을 입력해주세요." readonly></textarea>
															</div>
														</form>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
														<button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="sendSMS()">보내기</button>
													</div>
										
												</div>
											</div>
										</div>
										<!-- <a href="#!" class="btn btn-primary btn-sm">문자내용보기</a> -->
									</div>
									<small>* 회원가입은 고객이 직접 진행해야합니다.</small>
									<br/>
									<small>* 가입문자 발송 후 고객에게 문자도달 여부를 확인하세요.</small>
								</div>
							</div>
						</div>
						<!-- 출산정보 완료정보 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile fixed_height_460">
								<div class="x_title">
									<h2>출산정보 &middot; 완료정보</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form id="formData_4" data-parsley-validate class="form-horizontal form-label-left">
						
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">출산일
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="date" id="BABY_BIRTH" name="BABY_BIRTH" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">태아유형(출산)</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
													<input type="radio" name="BABY_GENDER" value="boy" checked>
													<label for="">남</label>
													<input type="radio" name="BABY_GENDER" value="girl">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="몸무게" name="CHILD_WEIGHT" id="baby_weight"> kg
													<button onclick="addBaby()" type="button">+</button><br/>
													<p id="babies" align=center>미입력
													</p>
												</div>
												<!--
												<div class="radio-group">
													<input type="radio" name="child-gender" class="flat" id="">
													<label for="">남</label>
													<input type="radio" name="child-gender" class="flat" id="">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="몸무게">kg
												</div>
												<div class="radio-group">
													<input type="radio" name="child-gender" class="flat" id="">
													<label for="">남</label>
													<input type="radio" name="child-gender" class="flat" id="">
													<label for="">여</label>
													<input type="number" class="form-control input-sm" placeholder="몸무게">kg
												</div>
												-->
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">분만정보</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
													<input type="radio" name="CHILDBIRTH_TYPE" id="CHILDBIRTH_TYPE" value="natural" checked >
													<label for="">자연분만</label>
													<input type="radio" name="CHILDBIRTH_TYPE" id="CHILDBIRTH_TYPE" value="caesarean" >
													<label for="">제왕절개</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">관리사서비스 희망장소</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<div class="radio-group">
												<input type="radio" name="CARE_PLACE_REAL" value="home" checked>
												<label for="">자택</label>
												<input type="radio" name="CARE_PLACE_REAL" value="home_mother" >
												<label for="">친정</label>
												<input type="radio" name="CARE_PLACE_REAL" value="home_father" >
												<label for="">시댁</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">출산정보 확정</label>
											<div class="col-md-6 col-sm-6 col-xs-12 chk-box">
												<a href="#!" class="btn btn-primary btn-sm">출산완료정보 확정</a>
												<br/>
												<small>* 출산 정보가 확정된 경우에만 클릭하세요.</small>
												<br/>
												<small>* 확정된 값은 바우처 태아유형에도 반영됩니다.</small>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>


					<div class="row">
						<!-- 서비스 계약 정보 - 상담 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile fixed_height_350">
								<div class="x_title">
									<h2>서비스 &middot; 계약 정보 - 상담</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content consult-comment">
									<textarea placeholder="상담 내용을 입력하세요." class="form-control" id="COUNSEL_CONTENT"></textarea>
									<a class="btn btn-primary btn-sm pull-right" onclick="saveCounsel()" >상담내용저장</a>
								</div>
							</div>

						<!-- 서비스금액 -->
							<div class="x_panel tile bg-dark">
								<div class="x_title">
									<h2>서비스금액</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content service-price">
									<div id="ServiceCosts">
									</div>
									<!--
									<div class="row">
										<div class="col-md-6 col-sm-6">
											기본 : <span class="label label-success">-</span>
											<span class="label label-success">2주</span>
											<span class="label label-success">입주</span>
											<span class="label label-success">5일</span>
										</div>
										<div class="col-md-6 col-sm-6">
											351,000원
										</div>
										<div class="col-md-6 col-sm-6">
											옵션 : 
										</div>
										<div class="col-md-6 col-sm-6">
											351,000원
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 col-sm-6">
											연장 :
											<span class="label label-default">프라이빗</span>
											<span class="label label-default">2주</span>
											<span class="label label-default">입주</span>
											<span class="label label-default">5일</span>
										</div>
										<div class="col-md-6 col-sm-6">
											351,000원
										</div>
										<div class="col-md-6 col-sm-6">
											옵션 :
										</div>
										<div class="col-md-6 col-sm-6">
											351,000원
										</div>
									</div>
									-->
									<hr>
									<div class="row">
										<div class="col-md-6 col-sm-6">
											<span class="total-price-label">총액</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="total-price" id="CostTotal">0원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="voucher-label">바우처</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="voucher-price red" id="CostVoucher">0원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="voucher-label">에누리</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="voucher-price red" id="CostDiscount">0원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="income-label">입금받음</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="income-price red" id="CostPayed">0원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="balance-label">잔액</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="balance-price green" id="CostBalance">0원</span>
										</div>
									</div>
									
									<!--<a href="#!" class="btn btn-default btn-sm pull-right">입금확인</a> -->


                                    <a href="#!" class="btn btn-default btn-sm pull-right" data-toggle="modal" data-target=".chk-payment">입금확인</a>
                                    <div class="modal fade bs-example-modal-lg chk-payment" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-md">
                                            <div class="modal-content">
                            
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">
                                                        <span aria-hidden="true">×</span>
                                                    </button>
                                                    <h4 class="modal-title" id="myModalLabel">입금확인</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <p>입금확인을 위해 아래 정보를 선택하세요.</p>
                                                    <form action="">
                                                        <h5>
                                                            <strong>STEP 1</strong>
                                                        </h5>
                                                        <div class="radio-group">
                                                            <input type="radio" name="PAYMENT_SERVICE_TYPE" class="flat" id="PAYMENT_SERVICE_TYPE" value="basic" checked>
                                                            <label for="">기본</label>
                                                            <input type="radio" name="PAYMENT_SERVICE_TYPE" class="flat" id="PAYMENT_SERVICE_TYPE" value="ext1">
                                                            <label for="">연장1</label>
                                                            <input type="radio" name="PAYMENT_SERVICE_TYPE" class="flat" id="PAYMENT_SERVICE_TYPE" value="ext2">
                                                            <label for="">연장2</label>
                                                            <input type="radio" name="PAYMENT_SERVICE_TYPE" class="flat" id="PAYMENT_SERVICE_TYPE" value="ext3">
                                                            <label for="">연장3</label>
                                                        </div>
                                                        <h5>
                                                            <strong>STEP 2</strong>
                                                        </h5>
                                                        <div class="radio-group">
                                                            <input type="radio" name="PAYMENT_PAY_TYPE" class="flat" id="PAYMENT_PAY_TYPE" value="deposit" checked>
                                                            <label for="">예약금</label>
                                                            <input type="radio" name="PAYMENT_PAY_TYPE" class="flat" id="PAYMENT_PAY_TYPE" value="intermediate">
                                                            <label for="">중도금</label>
                                                            <input type="radio" name="PAYMENT_PAY_TYPE" class="flat" id="PAYMENT_PAY_TYPE" value="balance">
                                                            <label for="">잔금</label>
                                                            <p>* 중도금 또는 예약금이 없는 경우 잔금으로 체크하세요.</p>
                                                        </div>
                                                        <h5>
                                                            <strong>STEP 3</strong>
                                                        </h5>
                                                        <div class="input-group">
                                                            <input type="number" class="form-control" placeholder="금액입력, 단위 원" name="PAYMENT_COST" id="PAYMENT_COST">
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal" onclick="onCancelCheckPayment()">취소</button>
                                                    <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="onCheckPayment()">완료</button>
                                                </div>
                            
                                            </div>
                                        </div>
                                    </div>

                                    <a href="#!" class="btn btn-default btn-sm pull-right" data-toggle="modal" data-target=".enuri">에누리</a>
                                    <div class="modal fade bs-example-modal-lg enuri" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-md">
                                            <div class="modal-content">
                                    
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">
                                                        <span aria-hidden="true">×</span>
                                                    </button>
                                                    <h4 class="modal-title enuri-title" id="myModalLabel">에누리 금액입력</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="">
                                                        <div class="input-group">
                                                            <input type="number" class="form-control" placeholder="에누리 금액입력, 단위 원" name="DISCOUNT_COST" id="DISCOUNT_COST">
                                                        </div>
                                                        <div>
                                                            <textarea class="form-control" placeholder="에누리 내용 입력"  name="DISCOUNT_REASON" id="DISCOUNT_REASON"></textarea>
                                                        </div>

                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal" onclick="onCancelDiscount()">취소</button>
                                                    <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="onDiscount()">완료</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>






								</div>
								<div class="payment-history" id="PAYMENT_HISTORY_LIST">
									<!--
                                    <p>2018.06.11 서원우 입급확인 [기본/잔금/900,000원]</p>
                                    <p>2018.05.15 조아라 입금확인 [기본/선금/100,000원]</p>
                                	-->
                                </div>

							</div>


						</div>
						<!-- 서비스 계약 정보 - 바우처 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile fixed_height_350">
								<div class="x_title">
									<h2>서비스 &middot; 계약 정보 - 바우처</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content voucher">
									<form id="formData_5" data-parsley-validate class="form-horizontal form-label-left">
									
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">바우처 소득유형
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<select class="select2_single form-control input-sm input-inline" name="VOUCHER" id="VOUCHER" onchange="calculateCost()">
												<%
													for (idx = 0; idx < arrVoucher.length; idx++)
													{
														if (idx == 0)
														{
															out.write("<option value='" + arrVoucher[idx][1] + "' selected>" + arrVoucher[idx][0] + "</option>\n");
														}
														else
														{
															out.write("<option value='" + arrVoucher[idx][1] + "'>" + arrVoucher[idx][0] + "</option>\n");
														}
													}
												%>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">바우처 서비스 기간</label>
											<div class="col-md-9 col-sm-9 col-xs-12 chk-box">
												<div class="radio-group">
													<input type="radio" name="VOUCHER_PERIOD" value="5" checked onclick="calculateCost()">
													<label for="">5일</label>
													<input type="radio" name="VOUCHER_PERIOD" value="10" onclick="calculateCost()">
													<label for="">10일</label>
													<input type="radio" name="VOUCHER_PERIOD" value="15" onclick="calculateCost()">
													<label for="">15일</label>
													<input type="radio" name="VOUCHER_PERIOD" value="20" onclick="calculateCost()">
													<label for="">20일</label>
													<input type="radio" name="VOUCHER_PERIOD" value="25" onclick="calculateCost()">
													<label for="">25일</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">태아유형</label>
											<div class="col-md-9 col-sm-9 col-xs-12 label-box">
												<span class="label label-primary" id="BabyType">첫째아 [자동산정]</span>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">정부지원금</label>
											<div class="col-md-9 col-sm-9 col-xs-12 label-box">
												<span class="label label-warning" id="VoucherSupport">918,000원 [자동산정]</span>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">본인부담금</label>
											<div class="col-md-9 col-sm-9 col-xs-12 label-box">
												<span class="label label-success" id="VoucherCost">118,000원 [자동산정]</span>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>


					<div class="row">
						<a class="btn btn-primary" onclick="addCustomerService_forDummy();">연장 정보 추가</a>
					</div>



					<div class="row" >
						
						<!-- 서비스 계약 정보 - 서비스/연장 정보 입력 -->
						<div class="col-md-6 col-sm-6 col-xs-6" id=org>
							<div class="x_panel tile fixed_height_860">
								<div class="x_title">
									<h2 id="title_<CS_INDEX>">서비스 &middot; 계약 정보 - 서비스/연장 정보 입력</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content service-extend">
									<!--<form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">-->
									
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">서비스 &middot; 기간
											</label>
											<div class="col-md-8 col-sm-8 col-xs-12">
												<select class="select2_single form-control service-name input-sm input-inline"  name="SERVICE_NAME_<CS_INDEX>" id="SERVICE_NAME_<CS_INDEX>" onchange="onChangeService(<CS_INDEX>);calculateCost()">
													<option value="none" selected>서비스선택</option>
										<%
											for (int i = 0; i < arrServices.length; i++) {
												out.print("<option value='" + arrServices[i][0] + "'>" + arrServices[i][1] + "</option>");
											}
										%>
												</select>
												<select class="select2_single form-control service-period input-sm input-inline" name="SERVICE_PERIOD_<CS_INDEX>" id="SERVICE_PERIOD_<CS_INDEX>" onchange="calculateCost()">
													<option value='0' selected>서비스기간</option>
										<%
											//for (int i = 1; i <= 30; i++) {
											//	out.print("<option value='" + i + "'>" + i + "일</option>");
											//}
										%>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">서비스 시작일
											</label>
											<div class="col-md-8 col-sm-8 col-xs-12">
												<input type="date" class="form-control input-sm input-inline" name="SERVICE_START_DATE_<CS_INDEX>" id="SERVICE_START_DATE_<CS_INDEX>" >
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">서비스 종료일
											</label>
											<div class="col-md-8 col-sm-8 col-xs-12">
												<input type="date" class="form-control input-sm input-inline" name="SERVICE_END_DATE_<CS_INDEX>" id="SERVICE_END_DATE_<CS_INDEX>">
											</div>
										</div>
										<div class="form-group chk-box">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">서비스 형태</label>
											<div class="col-md-9 col-sm-9 col-xs-12 chk-box">
												<div class="radio-group">
													<!--<input type="radio" class="flat" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="inhouse" onclick="hideMixed(<CS_INDEX>)" > -->
													<div id="I<CS_INDEX>">
													<input type="radio" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="inhouse" onclick="onServiceType(<CS_INDEX>,'I');calculateCost()" checked>
													<label for="">입주</label>
													</div>
													<div id="C<CS_INDEX>">
													<input type="radio" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="commute" onclick="onServiceType(<CS_INDEX>,'C');calculateCost()" >
													<label for="">출퇴근</label>
													</div>
													<div id="M<CS_INDEX>">
													<input type="radio" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="mixed" onclick="onServiceType(<CS_INDEX>,'M');calculateCost()">
													<label for="">입주+출퇴근</label>
													</div>
													<div>
														<div class="radio-group">
															<input type="radio" name="SERVICE_DAYS_<CS_INDEX>" id="SERVICE_DAYS_<CS_INDEX>" value="5" onclick="calculateCost()" checked >
															<label for="">5일</label>
															<input type="radio" name="SERVICE_DAYS_<CS_INDEX>" id="SERVICE_DAYS_<CS_INDEX>" value="6" onclick="calculateCost()">
															<label for="">6일</label>
														</div>
														<div id="mymixed_<CS_INDEX>">
															<div>
																<label for="">입주시작</label>
																	<!--
																<div class="radio-group">
																	<input type="radio"name="SERVICE_MIXED_INHOUSE_<CS_INDEX>" id="SERVICE_MIXED_INHOUSE_<CS_INDEX>" value="5" onclick="calculateCost()" checked>
																	<label for="">입주5일</label>
																	<input type="radio" name="SERVICE_MIXED_INHOUSE_<CS_INDEX>" id="SERVICE_MIXED_INHOUSE_<CS_INDEX>" value="6" onclick="calculateCost()">
																	<label for="">입주6일</label>
																</div>
																	-->
																	<input type="date" class="form-control input-inline input-sm" name='INHOUSE_DATE_<CS_INDEX>' id='INHOUSE_DATE_<CS_INDEX>'>
															</div>
															<div>
																<label for="">출근시작</label>
																	<!--
																<div class="radio-group">
																	<input type="radio" name="SERVICE_MIXED_COMMUTE_<CS_INDEX>" id="SERVICE_MIXED_COMMUTE_<CS_INDEX>" value="5" checked>
																	<label for="">출근5일</label>
																	<input type="radio" name="SERVICE_MIXED_COMMUTE_<CS_INDEX>" id="SERVICE_MIXED_COMMUTE_<CS_INDEX>" value="6" >
																	<label for="">출근6일</label>
																</div>
																	-->
																	<input type="date" class="form-control input-inline input-sm" name='COMMUTE_DATE_<CS_INDEX>' id='COMMUTE_DATE_<CS_INDEX>'>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">관리사배정</label>
											<div class="col-md-9 col-sm-9 col-xs-12">
												<a class="btn btn-default btn-xs btn-dark go-helper-list" data-toggle="modal" data-target=".helper-list_<CS_INDEX>" onclick="openHelperSelectionWindow(<CS_INDEX>)">관리사목록</a>
												<input type="text" class="form-control input-inline input-sm" placeholder="관리사분 성함" name='HELPER_NAME_<CS_INDEX>' id='HelperName_<CS_INDEX>' readonly >
												<div class="modal fade bs-example-modal-lg helper-list_<CS_INDEX>" tabindex="-1" role="dialog" aria-hidden="true">
													<div class="modal-dialog modal-lg">
														<div class="modal-content">
												
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">
																	<span aria-hidden="true">×</span>
																</button>
																<h4 class="modal-title" id="myModalLabel">관리사 목록</h4>
															</div>
															<div class="modal-body">
																<table class="table table-hover">
																	<thead>
																		<tr>
																			<th>이름</th>
																			<th>상태</th>
																			<th>소속지점</th>
																			<th>업무성향</th>
																			<th>선택</th>
																		</tr>
																	</thead>
																	<tbody id="helpers_<CS_INDEX>">
																		<!--
																		<tr>
																			<td>김옥분</td>
																			<td>파견중</td>
																			<td>성동</td>
																			<td>입주선호</td>
																			<td>
																				<a href="#!" class="btn btn-xs btn-default">상세정보</a>
																			</td>
																			<td>
																				<a href="#!" class="btn btn-xs btn-info">선택</a>
																			</td>
																		</tr>
																		<tr>
																			<td>김옥분</td>
																			<td>파견중</td>
																			<td>성동</td>
																			<td>입주선호</td>
																			<td>
																				<a href="policy_manage_helper_detail.html" class="btn btn-xs btn-default" target="_blank">상세정보</a>
																			</td>
																			<td>
																				<a href="#!" class="btn btn-xs btn-info">선택</a>
																			</td>
																		</tr>
																		<tr>
																			<td>김옥분</td>
																			<td>근무불가</td>
																			<td>성동</td>
																			<td>입주선호</td>
																			<td>
																				<a href="policy_manage_helper_detail.html" class="btn btn-xs btn-default" target="_blank">상세정보</a>
																			</td>
																			<td>
																				<a href="#!" class="btn btn-xs btn-info">선택</a>
																			</td>
																		</tr>
																		<tr>
																			<td>김옥분</td>
																			<td>근무중[계약자확인]</td>
																			<td>성동</td>
																			<td>입주선호</td>
																			<td>
																				<a href="policy_manage_helper_detail.html" class="btn btn-xs btn-default" target="_blank">상세정보</a>
																			</td>
																			<td>
																				<a href="#!" class="btn btn-xs btn-info">선택</a>
																			</td>
																		</tr>
																		<tr>
																			<td>김옥분</td>
																			<td>근무가능</td>
																			<td>성동</td>
																			<td>입주선호</td>
																			<td>
																				<a href="policy_manage_helper_detail.html" class="btn btn-xs btn-default" target="_blank">상세정보</a>
																			</td>
																			<td>
																				<a href="#!" class="btn btn-xs btn-info">선택</a>
																			</td>
																		</tr>
																		-->
																	</tbody>
																</table>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
																<!-- <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">보내기</button> -->
															</div>
												
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group manage-start-dt">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">관리시작 &middot; 변경일</label>
											<div class="col-md-9 col-sm-9 col-xs-12">
												<div class="input-group">
												<input type="date" class="form-control input-sm" name='CARE_CHANGE_<CS_INDEX>' id='CARE_CHANGE_<CS_INDEX>'><br/>
												<small>* 관리사 시작일(첫 출근일)은 꼭 선택하세요.</small><br/>
												<small>* 관리사 변경 시에도 변경된 관리사의 시작일(첫 출근일)을 선택하세요.</small>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">추가금 케어형태</label>
											<div class="col-md-9 col-sm-9 col-xs-12 chk-box">
												<div class="radio-group">
													<input type="checkbox" id='CARE_FAMILY_<CS_INDEX>' value="family" onclick="calculateCost()">
													<label for="">미취학아동</label>
													<input type="date" class="form-control input-sm input-inline" name='CARE_FAMILY_START_<CS_INDEX>' id='CARE_FAMILY_START_<CS_INDEX>' onchange="calculateCost()"> ~
													<input type="date" class="form-control input-sm input-inline" name='CARE_FAMILY_END_<CS_INDEX>' id='CARE_FAMILY_END_<CS_INDEX>' onchange="calculateCost()">
												</div>
												<div class="radio-group">
													<input type="checkbox" id='CARE_SCHOOL_<CS_INDEX>'  value="school" onclick="calculateCost()">
													<label for="">취학아동</label>
													<input type="date" class="form-control input-sm input-inline" name='CARE_SCHOOL_START_<CS_INDEX>' id='CARE_SCHOOL_START_<CS_INDEX>' onchange="calculateCost()"> ~
													<input type="date" class="form-control input-sm input-inline" name='CARE_SCHOOL_END_<CS_INDEX>' id='CARE_SCHOOL_END_<CS_INDEX>' onchange="calculateCost()">
												</div>
												<div class="radio-group">
													<input type="checkbox" id='CARE_ADDITIONAL_<CS_INDEX>' value="additional" onclick="calculateCost()">
													<label for="">추가가족</label>
													<input type="date" class="form-control input-sm input-inline" name='CARE_ADDITIONAL_START_<CS_INDEX>' id='CARE_ADDITIONAL_START_<CS_INDEX>' onchange="calculateCost()" > ~
													<input type="date" class="form-control input-sm input-inline" name='CARE_ADDITIONAL_END_<CS_INDEX>' id='CARE_ADDITIONAL_END_<CS_INDEX>' onchange="calculateCost()">
												</div>
												<div class="radio-group">
													<input type="checkbox" id='CARE_TWIN_<CS_INDEX>' value="twin" onclick="calculateCost()">
													<label for="">쌍둥이케어</label>
													<input type="date" class="form-control input-sm input-inline" name='CARE_TWIN_START_<CS_INDEX>' id='CARE_TWIN_START_<CS_INDEX>' onchange="calculateCost()" > ~
													<input type="date" class="form-control input-sm input-inline" name='CARE_TWIN_END_<CS_INDEX>' id='CARE_TWIN_END_<CS_INDEX>' onchange="calculateCost()" >
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">추가금 시간초과/휴일근무</label>
											<div class="col-md-9 col-sm-9 col-xs-12">
												<div class="input-group">
												<input type="date" class="form-control input-sm input-inline" id='OVERTIME_DATE_<CS_INDEX>' >
												<select class="form-control input-sm input-inline" id='OVERTIME_HOURS_<CS_INDEX>' >
													<%
														for (int time = 1; time <= 10; time++)
														{
															out.write("<option value='" + time + "'>초과시간(" + time + ")</option>\n");
														}
														for (int time = 1; time <= 10; time++)
														{
															out.write("<option value='H" + time + "'>휴일근무/초과시간(" + time + ")</option>\n");
														}
													%>
												</select>
												<a class="btn btn-xs btn-primary add-overwork" onclick="addOverTime(<CS_INDEX>)">
													추가
												</a>
												</div>
												<hr>

												<!--<p id="OVERTIMES_CS_INDEX" align=center>초과근무 없음</p>-->

												<ul class="list-unstyled timeline" id="OVERTIMES_<CS_INDEX>">
													<!--
													<li>
														<div class="block">
															<div class="tags">
																<a href="" class="tag">
																	<span>2018.06.21</span>
																</a>
															</div>
															<div class="block_content">
																<h2 class="title">
																	3시간 <a href="#!" class="btn btn-xs btn-danger">삭제</a>
																</h2>
															</div>
														</div>
													</li>
													<li>
														<div class="block">
															<div class="tags">
																<a href="" class="tag">
																	<span>2018.06.21</span>
																</a>
															</div>
															<div class="block_content">
																<h2 class="title">
																	휴일근무/초과 3시간
																	<a href="#!" class="btn btn-xs btn-danger">삭제</a>
																</h2>
															</div>
														</div>
													</li>
													-->
												</ul>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">기본서비스</label>
											<div class="col-md-9 col-sm-9 col-xs-12 default-service">
												<h5>&middot; 전신마사지</h5>
												<div class="input-group">
													<label for="">횟수선택</label>
													<select class="form-control input-sm" id='MASSAGE_COUNT_<CS_INDEX>'>
														<%= getBasicServiceOptions() %>
													</select>회
												</div>
												<div class="input-group">
													<label for="">신청일</label>
													<input type="date" class="form-control input-sm" id='MASSAGE_DATE_<CS_INDEX>'>
												</div>
												<small>* 신청일은 고객의 서비스 시작일이 아닙니다.</small><br/>
												<small>* 관리자가 해당 업체에 알린 날짜입니다.</small>
												<hr>
												<h5>&middot; 방문간호사</h5>
												<div class="input-group">
													<label for="">횟수선택</label>
													<select class="form-control input-sm" id='NURSE_COUNT_<CS_INDEX>' value='0'>
														<%= getBasicServiceOptions() %>
													</select>회
												</div>
												<div class="input-group">
													<label for="">신청일</label>
													<input type="date" class="form-control input-sm" id='NURSE_DATE_<CS_INDEX>'>
												</div>
												<small>* 신청일은 고객의 서비스 시작일이 아닙니다.</small>
												<br/>
												<small>* 관리자가 해당 업체에 알린 날짜입니다.</small>
												<hr>
												<h5>&middot; 소독서비스</h5>
												<div class="input-group">
													<label for="">횟수선택</label>
													<select class="form-control input-sm" id='DISINFECT_COUNT_<CS_INDEX>' value='0'>
														<%= getBasicServiceOptions() %>
													</select>회
												</div>
												<div class="input-group">
													<label for="">신청일</label>
													<input type="date" class="form-control input-sm" id='DISINFECT_DATE_<CS_INDEX>'>
												</div>
												<small>* 신청일은 고객의 서비스 시작일이 아닙니다.</small>
												<br/>
												<small>* 관리자가 해당 업체에 알린 날짜입니다.</small>
											</div>
										</div>
									<!--</form>-->
								</div>
							</div>
						</div>
						<!-- 기타정보 -->
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile fixed_height_460">
								<div class="x_title">
									<h2>기타정보</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content etc-info">
									<form id="formData_6" data-parsley-validate class="form-horizontal form-label-left">
									
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">반려동물
											</label>
											<div class="col-md-9 col-sm-9 col-xs-12 animal">
												<div class="row">
													<div class="col-md-6 col-sm-6 ">
														<div class="input-group">
															<!--<input type="checkbox" class="flat">-->
															<label for="">고양이</label>
															<input type="text" class="form-control input-sm" id='PET_CAT_COUNT' value='0' >
															<!--
															<select name="" id="" class="form-control input-sm">
																<option value="">선택</option>
																<option value=""></option>
																<option value=""></option>
															</select>
															-->
														</div>
														<div class="input-group">
															<!--<input type="checkbox" class="flat">-->
															<label for="">새</label>
															<input type="text" class="form-control input-sm" id='PET_BIRD_COUNT' value='0' >
															<!--
															<select name="" id="" class="form-control input-sm">
																<option value="">선택</option>
																<option value=""></option>
																<option value=""></option>
															</select>
															-->
														</div>
													</div>
													<div class="col-md-6 col-sm-6 ">
														<div class="input-group">
															<!--<input type="checkbox" class="flat">-->
															<label for="">개</label>
															<input type="text" class="form-control input-sm" id='PET_DOG_COUNT' value='0' >
															<!--
															<select name="" id="" class="form-control input-sm">
																<option value="">선택</option>
																<option value=""></option>
																<option value=""></option>
															</select>
															-->
														</div>
														<div class="input-group">
															<!--<input type="checkbox" class="flat">-->
															<label for="">기타</label>
															<input type="text" class="form-control input-sm" id='PET_ETC_COUNT' value='0' >
															<!--
															<select name="" id="" class="form-control input-sm">
																<option value="">선택</option>
																<option value=""></option>
																<option value=""></option>
															</select>
															-->
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="" class="control-label col-md-3 col-sm-3 col-xs-12">대여품목</label>
											<div class="col-md-9 col-sm-9 col-xs-12  rent">

												<a class="btn btn-default btn-xs btn-dark go-rental-list" data-toggle="modal" data-target=".rental-list" >대여품목선택</a>

												<div class="modal fade bs-example-modal-lg rental-list" tabindex="-1" role="dialog" aria-hidden="true">
													<div class="modal-dialog modal-lg">
														<div class="modal-content">
												
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">
																	<span aria-hidden="true">×</span>
																</button>
																<h4 class="modal-title" id="myModalLabel">대여품 목록</h4>
															</div>
															<div class="modal-body">
																<table class="table table-hover">
																	<thead>
																		<tr>
																			<th>대여번호</th>
																			<th>상품명</th>
																			<th>수량</th>
																			<th>제품설명</th>
																			<th>선택</th>
																		</tr>
																	</thead>
																	<tbody id="rentalList">
																	</tbody>
																</table>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
															</div>
												
														</div>
													</div>
												</div>

												<!--
												<a class="btn btn-dark btn-xs btn-mb-0" onclick="openRentalSelectionWindow();">대여품목선택</a>
												-->

												<input type="text" class="form-control input-sm" name='RENTAL_NAME' id='RentalName' placeholder='대여물품이 선택되지 않았습니다.' readonly>

												<div class="row rent-start-dt">
													<label for="" class="control-label col-md-2 col-sm-2 col-xs-12">시작일</label>
													<div class="col-md-10">
														<input type="date" class="form-control input-sm" name='RENTAL_START' id='RENTAL_START'>
													</div>
												</div>
												<div class="row">
													<label for="" class="control-label col-md-2 col-sm-2 col-xs-12">회수일</label>
													<div class="col-md-10">
														<input type="date" class="form-control input-sm" name='RENTAL_END' id='RENTAL_END'>
													</div>
												</div>
												<hr>
												<div class="row">
													<label for="" class="control-label col-md-2 col-sm-2 col-xs-12">택배비</label>
													<div class="col-md-10 chk-box">
														<!--
														<div class="radio-group">
															<input type="radio" class="flat" name="delivery-fare">
															<label for="">무료</label>
															<input type="radio" class="flat" name="delivery-fare">
															<label for="">유료</label>
														</div>
														<hr>
														-->
														<label for="">입금일</label>
														<input type="date" class="form-control input-sm" name='RENTAL_DELIVERY_PAYED' id='RENTAL_DELIVERY_PAYED'><br/><br/>
														<label for="">비용</label>
														<input type="number" class="form-control input-sm" name='DELIVERY_COST' id='DELIVERY_COST' value="0">
													</div>
												</div>
												<hr>
												<div class="row">
													<label for="" class="control-label col-md-2 col-sm-2 col-xs-12">대여비</label>
													<div class="col-md-10 chk-box">
														<!--
														<div class="radio-group">
															<input type="radio" class="flat" name="rent-fare">
															<label for="">무료</label>
															<input type="radio" class="flat" name="rent-fare">
															<label for="">유료</label>
														</div>
														<hr>
														-->
														<label for="">입금일</label>
														<input type="date" class="form-control input-sm" name='RENTAL_PAYED' id='RENTAL_PAYED' >
														<br/><br/>
														<label for="">비용</label>
														<input type="number" class="form-control input-sm" name='RENTAL_COST' id='RENTAL_COST' >
													</div>
												</div>
												

													
											</div>
											
										</div>

										<div class="form-group gift">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">선물 1
											</label>
											<div class="col-md-9 col-sm-9 col-xs-12">


												<a class="btn btn-default btn-xs btn-dark go-gift1-list" data-toggle="modal" data-target=".gift1-list" onclick="openGiftSelectionWindow(1)">선물선택</a>

												<div class="modal fade bs-example-modal-lg gift1-list" tabindex="-1" role="dialog" aria-hidden="true">
													<div class="modal-dialog modal-lg">
														<div class="modal-content">
												
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">
																	<span aria-hidden="true">×</span>
																</button>
																<h4 class="modal-title" id="myModalLabel">선물 목록</h4>
															</div>
															<div class="modal-body">
																<table class="table table-hover">
																	<thead>
																		<tr>
																			<th>번호</th>
																			<th>상품명</th>
																			<th>수량</th>
																			<th>지급대상</th>
																			<th>선택</th>
																		</tr>
																	</thead>
																	<tbody id="gifts_1">
																	</tbody>
																</table>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
															</div>
												
														</div>
													</div>
												</div>

												<!--
												<a class="btn btn-xs btn-dark btn-mb-0" onclick="openGiftSelectionWindow();">선물선택</a>
												-->

												<input type="text" class="form-control input-sm" name='GIFT_NAME1' id='GiftName1' placeholder='선물이 선택되지 않았습니다.' readonly >
												<div class="input-group chk-box">
													<label for="">발송일</label>
													<input type="date" class="form-control input-sm" name='GIFT_SENT_DATE1' id='GIFT_SENT_DATE1' >
												</div>
											</div>
										</div>

										<div class="form-group gift">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">선물 2
											</label>
											<div class="col-md-9 col-sm-9 col-xs-12">


												<a class="btn btn-default btn-xs btn-dark go-gift2-list" data-toggle="modal" data-target=".gift2-list" onclick="openGiftSelectionWindow(2)">선물선택</a>

												<div class="modal fade bs-example-modal-lg gift2-list" tabindex="-1" role="dialog" aria-hidden="true">
													<div class="modal-dialog modal-lg">
														<div class="modal-content">
												
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">
																	<span aria-hidden="true">×</span>
																</button>
																<h4 class="modal-title" id="myModalLabel">선물 목록</h4>
															</div>
															<div class="modal-body">
																<table class="table table-hover">
																	<thead>
																		<tr>
																			<th>번호</th>
																			<th>상품명</th>
																			<th>수량</th>
																			<th>지급대상</th>
																			<th>선택</th>
																		</tr>
																	</thead>
																	<tbody id="gifts_2">
																	</tbody>
																</table>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
															</div>
												
														</div>
													</div>
												</div>

												<!--
												<a class="btn btn-xs btn-dark btn-mb-0" onclick="openGiftSelectionWindow();">선물선택</a>
												-->

												<input type="text" class="form-control input-sm" name='GIFT_NAME2' id='GiftName2' placeholder='선물이 선택되지 않았습니다.' readonly >
												<div class="input-group chk-box">
													<label for="">발송일</label>
													<input type="date" class="form-control input-sm" name='GIFT_SENT_DATE2' id='GIFT_SENT_DATE2' >
												</div>
											</div>
										</div>

										<div class="form-group terminal">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">단말기
											</label>
											<div class="col-md-9 col-sm-9 col-xs-12">


												<a class="btn btn-default btn-xs btn-dark go-terminal-list" data-toggle="modal" data-target=".terminal-list" onclick="openTerminalSelectionWindow()">단말기선택</a>

												<div class="modal fade bs-example-modal-lg terminal-list" tabindex="-1" role="dialog" aria-hidden="true">
													<div class="modal-dialog modal-lg">
														<div class="modal-content">
												
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">
																	<span aria-hidden="true">×</span>
																</button>
																<h4 class="modal-title" id="myModalLabel">단말기 목록</h4>
															</div>
															<div class="modal-body">
																<table class="table table-hover">
																	<thead>
																		<tr>
																			<th>단말기번호</th>
																			<th>상태</th>
																			<th>선택</th>
																		</tr>
																	</thead>
																	<tbody id="terminals">
																	</tbody>
																</table>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
															</div>
												
														</div>
													</div>
												</div>
												<!--
												<a class="btn btn-xs btn-dark btn-mb-0" onclick="openTerminalSelectionWindow();">단말기 검색</a>
												-->

												<input type="text" class="form-control input-sm" name='TERMINAL_NAME' id='TerminalName' placeholder='단말기를 검색해 주세요.' readonly>
												<div class="input-group chk-box">
													<label for="">시작일</label>
													<input type="date" class="form-control input-sm" name='TERMINAL_START' id='TERMINAL_START' >
												</div>
												<div class="input-group">
													<label for="">회수일</label>
													<input type="date" class="form-control input-sm" name='TERMINAL_END' id='TERMINAL_END' >
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="">현금영수증
											</label>
											<div class="col-md-9 col-sm-9 col-xs-12 chk-box">
												<!-- <a href="#!" class="btn btn-sm btn-primary">예</a>
												<a href="#!" class="btn btn-sm btn-primary">아니오</a> -->
												<div class="radio-group">
													<input type="radio" name="CASHBILL" id="CASHBILL" value="yes" >
													<label for="">네</label>
													<input type="radio" name="CASHBILL" id="CASHBILL" value="no" >
													<label for="">아니오</label>
												</div>
												<input type="text" class="form-control input-md">
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>





					</div>
					<div class="text-center btn-group-bottom">
						<a onclick="cancel()" class="btn btn-default">작성취소</a>
						<a onclick="saveAll()" class="btn btn-primary">저장 후 서비스 계약정보 이동</a>
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
	<!-- TweenMax -->
	<script src="./vendors/tweenmax/TweenMax.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="./build/js/custom.js"></script>
</body>

</html>