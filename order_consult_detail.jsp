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

	String servicePeriods[][] =
	{
		{ "1W", "1주" },
		{ "2W", "2주" },
		{ "3W", "3주" },
		{ "4W", "4주" },
		{ "C4", "출퇴근 4주" },
		{ "I4", "입주 4주" },
		{ "I2C2", "입주 2주 + 출퇴근 2주" }
	};

	public String getServicePeriodDisp(String val)
	{
		String ret = "";

		for (int idx = 0; idx < servicePeriods.length; idx++)
		{
			if (servicePeriods[idx][0].equals(val))
			{
				ret = servicePeriods[idx][1];
				break;
			}
		}

		return ret;
	}

	public long getServiceCost_FromTable(String key)
	{
		long ret = 0;

		List<ServiceOption> lstOptions =  _userdb.getServiceOptionList();
		Iterator iter = lstOptions.iterator();
		while (iter.hasNext())
		{
		//for (idx = 0; idx < lstOptions.length; idx++) {
			ServiceOption opt = (ServiceOption)iter.next();
			if (opt._type.equals(key))
			{
				ret = opt._cost;
				break;
			}
		}
		//UserDB.PrintLog("LLLLLLLLLLLLLLLLLLLLLL:" + key + "===>" + ret);

		return ret;
	}

	//public long getServiceCost(String service, String period, String[] types)
	public long getServiceCost(CustomerService service)
	{
		String svc = service._serviceName;
		String key;
		String[] types = service._serviceType.split("_");
		int idx;
		long ret = 0;

		for (idx = 0; idx < arrServices.length; idx++)
		{
			if (arrServices[idx][0].equals(service._serviceName))
			{
				if (arrServices[idx][2].indexOf("I") >= 0)
				{
					if (types[0].equals("inhouse"))
						svc += "(I)";
					if (types[0].equals("commute"))
						svc += "(C)";
				}
				break;
			}
		}
		key = svc + "_" + service._servicePeriod + "_RESERVED";
		ret += getServiceCost_FromTable(key);
		key = svc + "_" + service._servicePeriod + "_BALANCE(" + types[1] + ")";
		ret += getServiceCost_FromTable(key);

		return ret;
	}

	DateFormat _df = new SimpleDateFormat("yyyy.MM.dd");

	public String fillValue(String name, String val)
	{
		return "$('#"+name+"').val('"+val+"');";
	}

	public String getVoucherName()
	{
		String ret = "";

		for (int i = 0; i < arrVoucher.length; i++)
		{
			if (arrVoucher[i][1].equals(_item._voucherType))
			{
				ret = arrVoucher[i][0];
				break;
			}
		}

		return ret;
	}

	public long getVoucherSupport(String tag)
	{
		long ret = 0;
		String[] vals;
		String post = "";
		String key = "";

		List<ServiceOption> list = _userdb.getServiceOptionList();
		for (int i = 0; i < arrVoucher.length; i++)
		{
			if (arrVoucher[i][1].equals(_item._voucherType))
			{
				vals = arrVoucher[i][2].split(" ");
				if (Integer.parseInt(vals[0]) == _item._voucherDays)
				{
					post = "_SHT";
				}
				if (Integer.parseInt(vals[1]) == _item._voucherDays)
				{
					post = "_STD";
				}
				if (Integer.parseInt(vals[2]) == _item._voucherDays)
				{
					post = "_EXT";
				}
				key = _item._voucherType + post + "_" + tag;
				break;
			}
		}

		Iterator iterator = list.iterator();
		while (iterator.hasNext())
		{
			ServiceOption service = (ServiceOption) iterator.next();
			if (service._type.equals(key))
			{
				ret = service._cost;
				break;
			}
		}

		UserDB.PrintLog("::: KEY ===> " + key);
		return ret;
	}

	public long getPayedCost()
	{
		List<PaymentHistory> lstPayments = UserDB. getPaymentHistoryList_Customer(_item._index);
		Iterator iterator = lstPayments.iterator();
		long ret = 0;

		while (iterator.hasNext())
		{
			PaymentHistory pay = (PaymentHistory) iterator.next();
			ret += pay._payedCost;
		}

		return ret;
	}

	public String getPayedLog()
	{
		List<PaymentHistory> lstPayments = UserDB. getPaymentHistoryList_Customer(_item._index);
		Iterator iterator = lstPayments.iterator();
		String ret = "";
		DateFormat df = new SimpleDateFormat("yyyy.MM.dd");

		while (iterator.hasNext())
		{
			PaymentHistory pay = (PaymentHistory) iterator.next();
			ret += df.format(pay._checkedTime) + " ";
			ret += pay._memberName + " ";
			if (pay._serviceType.equals("basic"))
			{
				ret += "기본";
			}
			else if (pay._serviceType.equals("ext1"))
			{
				ret += "연장1";
			}
			else if (pay._serviceType.equals("ext2"))
			{
				ret += "연장2";
			}
			else if (pay._serviceType.equals("ext3"))
			{
				ret += "연장3";
			}
			ret += " 서비스의 ";
			if (pay._paymentType.equals("advanced"))
			{
				ret += "선금";
			}
			else if (pay._paymentType.equals("intermediate"))
			{
				ret += "중도금";
			}
			else if (pay._paymentType.equals("balance"))
			{
				ret += "잔금";
			}
			ret += " " + pay._payedCost + "원 입금 확인.\n";
		}

		return ret;
		//return "*2018.2.23 잔액 입금확인 [조미경 확인] *2018.2.22 추가서비스 신청 [조미경 확인] *2018.2.18 잔금입금 [조미경 확인]";
	}

	public String getServiceName(String val)
	{
		String ret = "";

		for (int i = 0; i < arrServices.length; i++)
		{
			if (arrServices[i][0].equals(val))
			{
				ret = arrServices[i][1];
				break;
			}
		}

		return ret;
	}

	public int getDays(String start, String end)
	{
		int ret = 0;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		UserDB.PrintLog("START:[" + start + "], END:[" + end + "]");

		if ((start.length() != 10) || (end.length() != 10))
		{
			return 0;
		}

		try
		{
			Date date1 = df.parse(start);
			Date date2 = df.parse(end);
			long diff = date2.getTime() - date1.getTime();
			if (diff > 0)
				ret = (int)TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return ret;
	}


	public int getExtendedCost(String type, String option)
	{
		String key = "EXTENDED_" + type.toUpperCase() + "_" + option.toUpperCase();
		int ret = 0;
		int idx = 0;

		List<ServiceOption> lstOptions =  _userdb.getServiceOptionList();
		Iterator iter = lstOptions.iterator();
		while (iter.hasNext())
		{
		//for (idx = 0; idx < lstOptions.length; idx++) {
			ServiceOption opt = (ServiceOption)iter.next();
			if (opt._type.equals(key))
			{
				ret = opt._cost;
				break;
			}
		}

		UserDB.PrintLog("EXTENDED KEY:" + key);
		//console.log("KEY:" + key + ", val:" + ret);
		return ret;
	}

	public long getOvertimeCost(String service, String type, String hours)
	{
		List<ServiceOption> lstOptions =  _userdb.getServiceOptionList();

		if (service.contains("INTENS"))
			service = "INTENSIVE";
		String temp = "OVERTIME";
		int numHours;
		if (hours.charAt(0) == 'H')
		{
			temp = "HOLIDAY";
			hours = hours.substring(1);
		}
		numHours = Integer.parseInt(hours);
		String key = temp + '_' + type.toUpperCase() + '_' + service.toUpperCase();
		long ret = 0;

		Iterator iter = lstOptions.iterator();
		while (iter.hasNext())
		{
		//for (idx = 0; idx < lstOptions.length; idx++) {
			ServiceOption opt = (ServiceOption)iter.next();
			if (opt._type.equals(key))
			{
				ret = opt._cost;
				break;
			}
		}

		UserDB.PrintLog("OVERTIME KEY:" + key + ", val:" + ret + ", HOURS:" + numHours);
		return ret * numHours;
	}

	public Customer _item;

	public String getRecommendedRoutes()
	{
		String html = "";
		String[] routes = _item._routes.split(" ");

		for (int idx = 0; idx < routes.length; idx++)
		{
			if (routes[idx].equals("blog"))
			{
				html += "<span class='label label-default'>" + "블로그" + "</span> ";
			}
			else if (routes[idx].equals("search"))
			{
				html += "<span class='label label-default'>" + "검색" + "</span> ";
			}
			else if (routes[idx].equals("blog"))
			{
				html += "<span class='label label-default'>" + "블로그" + "</span> ";
			}
		}

		return html;
	}

	public String getRoutes()
	{
		String html = "";
		String[] routes = _item._routes.split(" ");

		for (int idx = 0; idx < routes.length; idx++)
		{
			if (routes[idx].equals("web"))
			{
				html += "<span class='label label-default'>" + "홈페이지" + "</span> ";
			}
			else if (routes[idx].equals("exhibition"))
			{
				html += "<span class='label label-default'>" + "전시회" + "</span> ";
			}
			else if (routes[idx].equals("phone"))
			{
				html += "<span class='label label-default'>" + "전화옴" + "</span> ";
			}
			else if (routes[idx].equals("voucher"))
			{
				html += "<span class='label label-default'>" + "바우처" + "</span> ";
			}
			else if (routes[idx].equals("center"))
			{
				html += "<span class='label label-default'>" + "조리원소개" + "</span> ";
			}
			else if (routes[idx].equals("etc"))
			{
				html += "<span class='label label-default'>" + "기타" + "</span> ";
			}
		}

		return html;
	}

	String getMember()
	{
		String ret = "지정되지 않음";

		if (_item._memberIndex != -1)
		{
			Member member = UserDB.getMember(_item._memberIndex);
			ret = member._business;
		}

		return ret;
	}

	String getBranch()
	{
		String ret = "지정되지 않음";

		if (_item._memberIndex != -1)
		{
			Member member = UserDB.getMember(_item._memberIndex);
			if (member.isHQ())
			{
				ret = "본사";
			}
		}
		if (_item._branchIndex != -1)
		{
			Branch branch = UserDB.getBranch(_item._branchIndex);
			if (branch != null)
			{
				Region region = UserDB.getRegion(branch._region);
				if (region != null)
				{
					ret = region._name;
				}
			}
		}

		return ret;
	}

	String getID()
	{
		return _item._id.length() > 0 ? _item._id : "입력대기중";
	}

	String getLogs(String type)
	{
		List<ConsultLog> logs;
		String ret = "";

		logs = UserDB.getLogs(_item._index);
		Iterator iter = logs.iterator();
		while (iter.hasNext())
		{
			ConsultLog log = (ConsultLog)iter.next();
			if (log._type.equals(type))
			{
				ret += _df.format(log._time) + " " + log._log + "\n";
			}
		}

		return ret;
	}

	String printDate(Timestamp time)
	{
		if (time == null)
			return "미입력";
		return _df.format(time);
	}

	String printBabyType()
	{
		String ret = "미입력";

		if (_item._voucherType.indexOf("A-") >= 0)
		{
			ret = "단태아";
		}
		else if (_item._voucherType.indexOf("B-") >= 0)
		{
			ret = "쌍태아";
		}
		else if (_item._voucherType.indexOf("C-") >= 0)
		{
			ret = "삼태아 이상 중증장애산모";
		}

		return ret;
	}

	String printDisabled()
	{
		String ret = "미입력";

		if (_item._disabledType.equals("true"))
		{
			ret = "예";
		}
		else if (_item._disabledType.equals("false"))
		{
			ret = "아니오";
		}

		return ret;
	}

	String printCareCenter()
	{
		String ret = "미입력";

		if (_item._careCenter.equals("true"))
		{
			if (_item._careCenterPeriod.equals("w1"))
			{
				ret = "1주";
			}
			else if (_item._careCenterPeriod.equals("d10"))
			{
				ret = "10일";
			}
			else if (_item._careCenterPeriod.equals("w2"))
			{
				ret = "2주";
			}
			else if (_item._careCenterPeriod.equals("w3"))
			{
				ret = "3주";
			}
			else if (_item._careCenterPeriod.equals("w4"))
			{
				ret = "4주";
			}
			ret += " 이용";
		}
		else if (_item._careCenter.equals("false"))
		{
			ret = "이용안함";
		}

		return ret;
	}

	String printServicePlace(String val)
	{
		String ret = "미입력";

		if (val.equals("home"))
		{
			ret = "자택";
		}
		else if (val.equals("home_mother"))
		{
			ret = "친정";
		}
		else if (val.equals("home_father"))
		{
			ret = "시댁";
		}

		return ret;
	}

	String printChildBirthType()
	{
		String ret = "미입력";

		if (_item._childBirthType.equals("natural"))
		{
			ret = "자연분만";
		}
		else if (_item._childBirthType.equals("caesarean"))
		{
			ret = "제왕절개";
		}

		return ret;
	}

	String getPets()
	{
		String ret = "";

		String[] temp = _item._pets.split(" ");
		ret += "고양이 " + temp[0] + "마리<br/>";
		ret += "새 " + temp[1] + "마리<br/>";
		ret += "개 " + temp[2] + "마리<br/>";
		ret += "기타 " + temp[3] + "마리";
		return ret;
	}

	String getRental()
	{
		String ret = "";

		if (_item._rentalIndex != -1)
		{
			Rental rental = _userdb.getRental(_item._rentalIndex);
			if (rental != null)
				ret += rental._name + "<br/>";
		}
		if (_item._rentalBegin != null)
			ret += "시작일 " + _df.format(_item._rentalBegin) + " | ";
		if (_item._rentalEnd != null)
			ret += "회수일 " + _df.format(_item._rentalEnd) + "<br/>";

		if (_item._rentalDeliveryCost > 0)
		{
			ret += "택배비 유료 | ";
			if (_item._rentalDeliveryPayed != null)
				ret += "입금 " +  _df.format(_item._rentalDeliveryPayed) + " | ";
			ret += "비용 " + _item._rentalDeliveryCost;
			ret += "<br/>";
		}
		else
		{
			ret += "택배비 무료<br/>";
		}

		if (_item._rentalCost > 0)
		{
			ret += "대여비 유료 | ";
			if (_item._rentalPayed != null)
				ret += "입금 " + _df.format(_item._rentalPayed) + " | ";
			ret += "비용 " + _item._rentalCost;
			ret += "<br/>";
		}
		else
		{
			ret += "대여비 무료<br/>";
		}
		return ret; //"적외선방사 피부관리기<br/> 시작일 2018.02.22 | 회수일 2018.02.0<br/> 택배비 유료 | 입금 2018.02.02 | 비용 10,000<br/> 대여비 유료 | 입금 2018.02.02 | 비용 10,000";
	}

	String getGifts()
	{
		String ret = "";
		if (_item._giftIndex1 != -1)
		{
			Gift gift = _userdb.getGift(_item._giftIndex1);
			if (gift != null)
				ret += gift._name + " | ";
			if (_item._giftSent1 != null)
				ret += "발송일 " + _df.format(_item._giftSent1) + "<br/>";
		}
		if (_item._giftIndex2 != -1)
		{
			Gift gift = _userdb.getGift(_item._giftIndex2);
			if (gift != null)
				ret += gift._name + " | ";
			if (_item._giftSent2 != null)
				ret += "발송일 " + _df.format(_item._giftSent2) + "<br/>";
		}

		return ret; //"아기 체중계 1EA<br/> 발송일 2018.02.22";
	}

	String getTerminal()
	{
		String ret = "";

		if (_item._terminalIndex != -1)
		{
			Terminal terminal = _userdb.getTerminal(_item._terminalIndex);
			if (terminal != null)
				ret += "단말기 번호 " + terminal._no + " | ";
			if (_item._terminalBegin != null)
				ret += "대여일 " + _df.format(_item._terminalBegin) + " | ";
			if (_item._terminalEnd != null)
				ret += "회수일 " + _df.format(_item._terminalEnd) + "<br/>";
		}

		return ret;
	}

	String getReceipt()
	{
		if (_item._cashReceipt.equals("yes"))
			return "예";
		return "아니오";
	}
%>

<%
	Customer item;
	String temp = request.getParameter("INDEX");
	int index;

	if (temp != null)
	{
		index = Integer.parseInt(temp);
		item = _userdb.getCustomerItem(index);
		/*
		out.write(fillValue("NAME", item._name));
		out.write(fillValue("MOBILE", item._mobile));
		out.write(fillValue("PHONE", item._phone));
		out.write(fillValue("POST", item._post));
		out.write(fillValue("ADDRESS1", item._address1));
		out.write(fillValue("ADDRESS2", item._address2));
		*/
	}
	else
	{
		item = new Customer();
		response.sendRedirect("order_consult.jsp");
	}
	_item = item;
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>마더앤베이비 관리자 - 상담상세정보</title>

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
	<link href="./build/css/mystyle2.css" rel="stylesheet">
	<script
	src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	<script src="js/content_consult_new.js" ></script>
	<script src="js/base64.js" ></script>
	<script src="js/myutils.js" ></script>
	<script>
		function addCheckedPayment_forDetail(serviceType, paymentType, payedCost) {
			var service;
			var index = -1;
			var val = '';

			val += 'ADD&';
			val += 'CUSTOMER_INDEX=' + _indexCustomer + '&';
			val += 'SERVICE_TYPE=' + serviceType + '&';
			val += 'PAYMENT_TYPE=' + paymentType + '&';
			val += 'PAYED_COST=' + payedCost + '&';
			val += 'MEMBER_INDEX=' + _memberIndex + '&';
			//alert(val);

			$.post("_api_payment.jsp", val)
			.fail(function(response) {
				//alert('Error1: ' + response.responseText);
				console.log(response.responseText);
				document.getElementById("error").innerHTML = response.responseText;
				//data = response.responseText;
			})
			.done(function(data) {
				//console.log(data);
				//calculateCost();
			});
		}

		function getCheckedPaymentList() {
			var service;
			var index = -1;
			var val = '';

			val += 'LIST&';
			val += 'CUSTOMER_INDEX=' + _indexCustomer + '&';

			$.post("_api_payment.jsp", val)
			.fail(function(response) {
				//alert('Error2: ' + response.responseText);
				document.getElementById("error").innerHTML = response.responseText;
				//data = response.responseText;
			})
			.done(function(data) {
				console.log(data);
				var payed = 0;
				for (var i in data.RESULT) {
					payed += data.RESULT[i].PAYED_COST;
				}
				$("#CostPayed").html(payed + "원");
				var balance = _totalCost - _voucherSupport - payed;
				$("#CostBalance").html(balance + "원");
				//calculateCost();
			});
		}

		function onCheckPayment() {
			var serviceType = $("input[name='PAYMENT_SERVICE_TYPE']:checked").val();
			var paymentType = $("input[name='PAYMENT_PAY_TYPE']:checked").val();
			var cost = $("#PAYMENT_COST").val();
			addCheckedPayment_forDetail(serviceType, paymentType, cost);
			$("input[name='PAYMENT_SERVICE_TYPE'][value='basic']").prop('checked', true);
			$("input[name='PAYMENT_PAY_TYPE'][value='advanced']").prop('checked', true);
			$("#PAYMENT_COST").val('0');
			location.reload();
		}

		function onCancelCheckPayment() {
			// set to default
			$("input[name='PAYMENT_SERVICE_TYPE'][value='basic']").prop('checked', true);
			$("input[name='PAYMENT_PAY_TYPE'][value='advanced']").prop('checked', true);
			$("#PAYMENT_COST").val('0');
		}

		function goConsultList() {
			document.location.href = 'order_consult.jsp?STEP=' + 1;
//			window.history.go(-1);
		}

		//function deleteCustomer(index) {
		//}

		function getBabyOrder(type) {
			var babyType = "삼태아 이상 중증장애산모";

			if (type.search("A-") >= 0) {
				//babyType = "단태아";
				if (type.search("1ST") >= 0) {
					babyType = "첫째아";
				}
				if (type.search("2ND") >= 0) {
					babyType = "둘째아";
				}
				if (type.search("3RD") >= 0) {
					babyType = "셋째아 이상";
				}
			} else if (type.search("B-") >= 0) {
				//babyType = "쌍태아";
				if (type.search("1ST") >= 0) {
					babyType = "둘째아";
				}
				if (type.search("2ND") >= 0) {
					babyType = "셋째아 이상";
				}
			}

			return babyType;
		}

		function sendSMS() {
			var val;
			val = '';
			val += 'INDEX=' + _index + '&';
			val += 'SEND_SMS=' + '&';
			$.post("_consult_update.jsp", val)
			.fail(function(response) {
				//alert('Error: ' + response.responseText);
				document.getElementById("org").innerHTML = response.responseText;
			})
			.done(function(data) {
				console.log('DONE:' + data.COMMAND);
				console.log('URL:' + data.RESULT);
				if (data.RESULT == 'success') {
					alert("전송되었습니다.");
					writeLog("SMS", "가입문자 발송");
				} else {
					alert("전송실패했습니다.");
				}
			});
		}

		function edit() {
			//alert('편집 화면으로 이동[작업중]');
			document.location.href = 'order_consult_new.jsp?CUSTOMER=' + _index;
		}

		function confirmInfo() {
			writeLog("CONFIRM", "고객에게 정보를 확인하였습니다.");
		}

		function writeLog(type, log) {
		    var val = '';
		    val += 'ADDLOG' + '&';
		    val += 'INDEX=' + _index + '&';
		    val += 'TYPE=' + type + '&';
		    val += 'LOG=' + log + '&';
		    $.post("_api_customer.jsp", val)
		    .fail(function(response) {
		        alert('Error: ' + response.responseText);
		        //document.getElementById("org").innerHTML = response.responseText;
		    })
		    .done(function(data) {
		    	console.log(data);
		    	//location.reload();
		    });
		}

		/*
		function getCost() {
		    var val = '';
		    val += 'GETCOST' + '&';
		    val += 'INDEX=' + _index + '&';
		    $.post("_api_customer.jsp", val)
		    .fail(function(response) {
		        alert('Error: ' + response.responseText);
		        //document.getElementById("org").innerHTML = response.responseText;
		    })
		    .done(function(data) {
		    	console.log(data);
				$("#VOUCHER_GOV").html(data.RESULT.GOV + "원 [자동산정]");
				$("#VOUCHER_SELF").html(data.RESULT.SELF + "원 [자동산정]");
		    });
		}
		*/

		function deleteCustomer(index) {
		    var val = '';
		    val += 'DELETE' + '&';
		    val += 'INDEX=' + index + '&';
		    $.post("_api_customer.jsp", val)
		    .fail(function(response) {
		        alert('Error: ' + response.responseText);
		        //document.getElementById("org").innerHTML = response.responseText;
		    })
		    .done(function(data) {
		    	console.log(data);
				goConsultList();//window.history.go(-1);
		    });
		}

		function getExperiencesString(val) {
			var M = 0;
			var F = 0;
			console.log(val);
			val = val.split(' ');
			for (index = 0; index < val.length; index++) {
				//alert(_children[index]);
				if (val[index].substring(0, 1).localeCompare("M") == 0) {
					M++;// = "남 ";
					//html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
				} else if (val[index].substring(0, 1).localeCompare("F") == 0) {
					F++;// = "여 ";
					//html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
				} else {
					continue;
				}
			}

			console.log('M:' + M);
			console.log('F:' + F);
			if ((M == 0) && (F == 0)) {
				return "초산";
			}

			return "경산 [남(" + M + "), 여(" + F + ")]";
		}

		function countBabyOrder(val) {
			var count = 0;
			for (index = 0; index < val.length; index++) {
				//alert(_children[index]);
				if (val[index].substring(0, 1).localeCompare("M") == 0) {
					count++;// = "남 ";
					//html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
				} else if (val[index].substring(0, 1).localeCompare("F") == 0) {
					count++;// = "여 ";
					//html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
				} else {
					continue;
				}
			}
			return count + 1;
		}

		function getBabiesString(val) {
			var html = '';
			val = val.split(' ');
			for (index = 0; index < val.length; index++) {
				console.log('[' + val[index] + ']');
				if (val[index].substring(0, 1).localeCompare("M") == 0) {
					html += "성별[남] 몸무게[" + val[index].substring(1) + "kg]<br>";
				} else if (val[index].substring(0, 1).localeCompare("F") == 0) {
					html += "성별[여] 몸무게[" + val[index].substring(1) + "kg]<br>";
				} else {
					continue;
				}
			}

			return html;
		}

		function saveCounsel() {
			var val = '';
		    val += 'INDEX=' + _index + '&';
			//val += 'COUNSEL_CONTENT=' + b64EncodeUnicode($("#COUNSEL_CONTENT").val());
			//val += 'MEMO=' + base64.encode($("#COUNSEL_CONTENT").val());
			val += 'MEMO=' + getEncodedString("COUNSEL_CONTENT") + '&';
			//alert(val);
			$.post("_consult_update.jsp", val)
			//$.post("_test.jsp", val)
			.fail(function(response) {
				//alert('Error: ' + response.responseText);
				document.getElementById("error").innerHTML = response.responseText;
			})
			.done(function(data) {
		    	console.log(data);
		    	location.reload();
			});
		}

		function onCancelContract() {
			//alert('popup');
		}

		function onCancelContractCancel() {
			//alert('cancel');
		}

		function onCancelProceed() {
			//alert('proceed');
			var refundVal = $("#REFUND_VALUE").val();
			if (refundVal.length == 0) {
				alert("환불 금액을 입력하세요.");
				return;
			}
			var refundComplete = $("input[name='REFUND_COMPLETE']:checked").val();
			if (refundComplete == undefined) {
				alert("환불 완료 여부를 체크해 주세요.");
				return;
			}
			var refundChecked = $("input[name='REFUND_CHECKED']:checked").val();
			if (refundChecked != "confirmed") {
				alert("[위 사항을 확인하였습니다.]를 체크해 주세요.");
				return;
			}
			var refundDate = $("#REFUND_DATE").val();
			console.log("Date:[" + refundDate + "]");
			if (refundDate.length == 0) {
				alert("환불한 날짜가 입력되지 않았거나 형식이 올바르지 않습니다.");
				return;
			}
			if (window.confirm("계약취소 를 진행할까요? 취소된 계약사항은 “계약취소/환불”에서 확인할 수 있습니다.")) {
			    var val = '';
			    if (refundComplete == "yes") {
			    	refundComplete = "completed"
			    }
			    val += 'CANCEL_CONTRACT' + '&';
			    val += 'REFUND_DATE=' + refundDate + '&';
			    val += 'REFUND_COMPLETE=' + refundComplete + '&';
			    val += 'REFUND_VALUE=' + refundVal + '&';
			    val += 'MEMBER=' + _memberIndex + '&';
			    val += 'CUSTOMER=' + _indexCustomer + '&';
			    $.post("_api_sales.jsp", val)
			    .fail(function(response) {
			        alert('Error: ' + response.responseText);
			        //document.getElementById("org").innerHTML = response.responseText;
			    })
			    .done(function(data) {
			        console.log(data);
					$('#REFUND').modal('toggle');
					document.location.href = "order_cancel_refund.jsp";
			    });
			} else {
				//alert("I knew it");
			}
		}

		$(function() {
			$("#EXPERIENCES").html(getExperiencesString('<%= _item._experiences %>'));
			$("#BABIES_TYPE").html(getBabiesString('<%= _item._babyTypes %>'));
			//$("#BABY_ORDER").html(countBabyOrder('<%= _item._experiences %>'));
			$("#BABY_ORDER").html(getBabyOrder('<%= _item._voucherType %>'));
			$("#COUNSEL_CONTENT").val(getDecodedString('<%= _item._memo %>'));

			_indexCustomer = <%=item._index%>;
			_memberIndex = <%= _user._index %>;

			//getCost();
		});
		var _index = <%= item._index %>;
	</script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
<%@ include file="order_left_menu.jspf" %>
<%@ include file="order_top_nav.jspf" %>

			<!-- page content -->
			<div class="right_col order_consult_detail" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>상담/문의
							</h3>

						</div>

						<div class="title_right">
							<!-- <div class="btn-group pull-right"> -->
								<a onclick='deleteCustomer(<%=item._index%>)' class="btn btn-primary btn-sm pull-right detail-delete">삭제</a>
								<a href='order_consult_new.jsp?CUSTOMER=<%=item._index%>' class="btn btn-primary btn-sm pull-right detail-modify">수정</a>
								<a class="btn btn-primary btn-sm pull-right go-list" onclick="goConsultList()">목록</a>
								<a href="#!" class="btn btn-primary btn-sm pull-right detail-modify" data-toggle="modal" data-target=".cancel-contract" onclick="onCancelContract()">계약취소</a>
                                    <div class="modal fade bs-example-modal-lg cancel-contract" tabindex="-1" role="dialog" aria-hidden="true" id="REFUND">
                                        <div class="modal-dialog modal-md">
                                            <div class="modal-content">
                            
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">
                                                        <span aria-hidden="true">×</span>
                                                    </button>
                                                    <h4 class="modal-title" id="myModalLabel">계약취소</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <p>
                                                    	<%= item._name %> 고객님의 계약을 취소합니다.<br/>
                                                    	아래 사항을 확인하세요.
                                                	</p>
                                                    <form action="">
														<%
															List<CustomerService> list;
															Iterator iterator;
															list = UserDB.getCustomerServiceList(_item._index);
															iterator = list.iterator();
															while (iterator.hasNext())
															{
																CustomerService service = (CustomerService) iterator.next();
																String[] cares = service._additionalCare.split("_");
																int days = 0;
																String[] types = service._serviceType.split("_");
																//UserDB.PrintLog("LEN = " + cares.length);
																String[] overtimes = service._additionalOvertime.split("_");
																//UserDB.PrintLog("[" + service._additionalOvertime + "] LEN = " + overtimes.length);

														%>
                                                        <h5>
                                                            <strong>서비스: </strong><%= getServiceName(service._serviceName) %><br/>
                                                            <strong>서비스기간: </strong>
                    	                                        <%= getServicePeriodDisp(service._servicePeriod) %> /
																<%
																	if (service._serviceStart != null)
																		out.write(_df.format(service._serviceStart));
																	else
																		out.write("미입력");
																	out.write(" ~ ");
																	if (service._serviceEnd != null)
																		out.write(_df.format(service._serviceEnd));
																	else
																		out.write("미입력");
																%>
																<br/>
                                                            <strong>서비스형태: </strong>
                                                            <%
																if (types[0].equals("inhouse"))
																{
																	out.write("입주");
																}
																else if (types[0].equals("commute"))
																{
																	out.write("출퇴근");
																}
																else // if (types[0].equals("mixed"))
																{
																	out.write("입주 + 출퇴근");
																}
															%>
														 / <%= types[1] %>일
															<br/>
                                                            <strong>추가금 케어형태: </strong>
															<%
																if (cares[0].equals("T"))
																{
																	days = getDays(cares[1], cares[2]);
																	//out.write("가족케어 " + days + "일 : " + (days * getExtendedCost(types[0], "noschool")) + "원<br/>\n");
																	out.write("가족케어 " + days + "일 | ");
																}
																if (cares[3].equals("T"))
																{
																	days = getDays(cares[4], cares[5]);
																	//out.write("취학아동 " + days + "일 : " + (days * getExtendedCost(types[0], "school")) + "원<br/>\n");
																	out.write("취학아동 " + days + "일 | ");
																}
																if (cares[6].equals("T"))
																{
																	days = getDays(cares[7], cares[8]);
																	//out.write("추가가족 " + days + "일 : " + (days * getExtendedCost(types[0], "family")) + "원<br/>\n");
																	out.write("추가가족 " + days + "일 | ");
																}
																if (cares[9].equals("T"))
																{
																	days = getDays(cares[10], cares[11]);
																	//out.write("쌍둥이케어 " + days + "일 : " + (days * getExtendedCost(types[0], "twin")) + "원<br/>\n");
																	out.write("쌍둥이케어 " + days + "일 | ");
																}
															%>
                                                            <br/>
                                                            <strong>추가금 시간초과: </strong>
															<%
																for (int idx = 0; idx < overtimes.length; idx++)
																{
																	String[] t = overtimes[idx].split(" ");
																	String h;
																	if (t.length != 2) continue;
																	boolean isHoliday;
																	if (t[1].charAt(0) == 'H')
																	{
																		h = t[1].substring(1);
																		isHoliday = true;
																	}
																	else
																	{
																		h = t[1];
																		isHoliday = false;
																	}
																	out.write(t[0].replace("-", ".") + " : " + (isHoliday ? "휴일 " : "") + h + "시간 | ");
																	//out.write("" + getOvertimeCost(service._serviceName, types[0], t[1]) + "원<br/>\n");
																}
															%>
                                                            <br/>
                                                        </h5>
								                        <%
								                            }
								                        %>
                                                        <h5>
                                                            <strong>환불금액입력(필수)</strong>
                                                        </h5>
                                                        <div class="input-group">
                                                            <input type="number" class="form-control" placeholder="금액입력, 단위 원" name="REFUND_VALUE" id="REFUND_VALUE" value="0">
                                                        </div>
                                                        <h5>
                                                            <strong>환불을 완료하셨습니까?</strong>
                                                            <input type="radio" name="REFUND_COMPLETE" class="flat" id="REFUND_COMPLETE" value="yes">
                                                            <label for="">예</label>
                                                            <input type="radio" name="REFUND_COMPLETE" class="flat" id="REFUND_COMPLETE" value="no">
                                                            <label for="">아니오</label>
                                                        </h5>
                                                        <h5>
                                                            <strong>환불한 날짜를 입력하세요.</strong>
                                                            <input type="date" class="form-control input-sm input-inline" name='REFUND_DATE' id='REFUND_DATE'>
                                                        </h5>
                                                        <h5>
                                                            <input type="checkbox" id='REFUND_CHECKED' name='REFUND_CHECKED' class="flat" value="confirmed">
                                                            <strong>위 사항을 확인하였습니다.</strong>
                                                        </h5>
                                                        <!--
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
                                                            <p>* 중도금 또는 선금이 없는 경우 잔금으로 체크하세요.</p>
                                                        </div>
                                                        <h5>
                                                            <strong>STEP 3</strong>
                                                        </h5>
                                                        <div class="input-group">
                                                            <input type="number" class="form-control" placeholder="금액입력, 단위 원" name="PAYMENT_COST" id="PAYMENT_COST">
                                                        </div>
                                                    	-->
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal" onclick="onCancelContractCancel()">작성취소</button>
                                                    <button type="button" class="btn btn-primary btn-sm" onclick="onCancelProceed()">진행</button>
                                                </div>
                            
                                            </div>
                                        </div>
                                    </div>
							<!-- </div> -->
						</div>
					</div>

					<!-- 개인정보 -->
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>기본정보</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content basic-info">
									<dl>
										<dt>성함</dt>
										<dd><%= item._name %></dd>
										<!--
										<dt>생년월일</dt>
										<dd>1990.10.10(만 27세)</dd>
										-->
										<dt>연락처</dt>
										<dd><%= item._mobile %> | <%= item._phone %></dd>
										<dt>주소</dt>
										<dd><%= item._post %> <%= item._address1 %> <%= item._address2 %></dd>
									</dl>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>추천 &middot; 상담정보</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content recommend-consult">
									<dl>
										<dt>접근분류</dt>
										<dd><%= getRoutes() %></dd>
										<dt>추천경로</dt>
										<dd><%= getRecommendedRoutes() %></dd>
										<dt>상담직원</dt>
										<dd><span class="label label-default"><%= getMember() %></span></dd>
										<dt>상담지점</dt>
										<dd><span class="label label-default"><%= getBranch() %></span></dd>
									</dl>
								</div>
							</div>
						</div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>가입정보</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content regist-info">
									<div class="row">
										<div class="col-md-3 col-sm-3">
											<dl>
												<dt>아이디</dt>
												<dd><span class="label label-default"><%= getID() %></span></dd>
											</dl>
											<% if (_item._id.length() == 0) { %>
											<a class="btn btn-primary btn-sm" onclick="sendSMS()">가입문자 재발송</a>
											<!--<a href="#!" class="btn btn-primary btn-sm">PW변경</a>-->
											<% } %>
										</div>
										<div class="col-md-9 col-sm-9">
											<textarea name="SMS_LOG" id="SMS_LOG" class="form-control" readonly><%= getLogs("SMS") %></textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 출산정보 -->
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>사전정보</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content before-info">
									<dl>
										<dt>지정병원</dt>
										<dd><%= _item._hospital %></dd>
										<dt>출산예정일</dt>
										<dd><%= printDate(_item._expectedDate) %> [예정일 2일전 문자발송 예약][문자내용 확인/재발송]</dd>
										<dt>수술예정일</dt>
										<dd><%= printDate(_item._operationDate) %></dd>
										<dt>출산경험</dt>
										<dd id="EXPERIENCES"></dd>
										<dt>태아유형(예정)</dt>
										<dd><%= printBabyType() %></dd>
										<dt>중증장애산모</dt>
										<dd><%= printDisabled() %></dd>
										<dt>산후조리원 예정</dt>
										<dd><%= printCareCenter() %></dd>
										<dt>관리사서비스 희망장소</dt>
										<dd><%= printServicePlace(_item._servicePlaceWish) %></dd>
									</dl>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>완료정보
									</h2>
									<a class="btn btn-primary btn-xs pull-right" onclick="edit()">정보등록/수정</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content completion-info">
									<dl>
										<dt>출산일</dt>
										<dd><%= printDate(_item._babyBirth) %></dd>
										<dt>태아유형(출산)</dt>
										<dd id="BABIES_TYPE">성별[-] 몸무게[-kg]</dd>
										<!--<dt>산후조리원</dt>
										<dd></dd>-->
										<dt>분만형태</dt>
										<dd><%= printChildBirthType() %></dd>
										<dt>관리사서비스 장소</dt>
										<dd><%= printServicePlace(_item._servicePlaceReal) %></dd>
									</dl>
									<textarea name="CONFIRM_LOG" id="CONFIRM_LOG" class="form-control" readonly=""><%= getLogs("CONFIRM") %></textarea>
									<a class="btn btn-primary btn-sm pull-right" onclick="confirmInfo()">출산 완료 정보 확정</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 서비스 , 계약정보 -->
					<!--
					<div class="row ">
						<div class="col-md-12 col-sm-12">
							<a href="#!" class="btn btn-app">
								<span class="badge bg-red">1회</span>
								<i class="fa fa-edit"></i>
								바우처정보 입력</a>
							<a href="#!" class="btn btn-app">
								<span class="badge bg-red">1회</span>
								<i class="fa fa-info"></i>
								기타정보</a>
							<a href="#!" class="btn btn-app">
								<span class="badge bg-red">1회</span>
								<i class="fa fa-list"></i>
								서비스(계약)정보 | 연장(추가)정보</a>
						</div>
					</div>
					-->

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>상담</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content consult">
									<textarea name="COUNSEL_CONTENT" id="COUNSEL_CONTENT" class="form-control"></textarea>
									<a class="btn btn-primary btn-sm pull-right" onclick="saveCounsel()">저장</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<%
							list = UserDB.getCustomerServiceList(_item._index);
							iterator = list.iterator();
							while (iterator.hasNext())
							{
								CustomerService service = (CustomerService) iterator.next();
								String[] cares = service._additionalCare.split("_");
								int days = 0;
								String[] types = service._serviceType.split("_");
								//UserDB.PrintLog("LEN = " + cares.length);
								String[] overtimes = service._additionalOvertime.split("_");
								//UserDB.PrintLog("[" + service._additionalOvertime + "] LEN = " + overtimes.length);

						%>
						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>서비스 제공</h2>
									<a class="btn btn-primary btn-xs pull-right" onclick="edit('SERVICE')">기록/수정/삭제</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content service-offer fixed_height_520">
									<dl>
										<dt>서비스</dt>
										<dd><%= getServiceName(service._serviceName) %></dd>
										<dt>서비스 기간</dt>
										<dd>
											<%= getServicePeriodDisp(service._servicePeriod) %> /
											<%
												if (service._serviceStart != null)
													out.write(_df.format(service._serviceStart));
												else
													out.write("미입력");
												out.write(" ~ ");
												if (service._serviceEnd != null)
													out.write(_df.format(service._serviceEnd));
												else
													out.write("미입력");
											%>
										</dd>
											<%
											%>
										<dt>서비스 형태</dt>
										<dd>
											<%
												if (types[0].equals("inhouse"))
												{
													out.write("입주");
												}
												else if (types[0].equals("commute"))
												{
													out.write("출퇴근");
												}
												else // if (types[0].equals("mixed"))
												{
													out.write("입주 + 출퇴근");
												}
											%>
										 / <%= types[1] %>일</dd>
										<dt>관리사</dt>
										<dd><%= service.getHelperName() %></dd>

										<dt>추가금 케어형태</dt>
										<dd>
											<%
												if (cares[0].equals("T"))
												{
													days = getDays(cares[1], cares[2]);
													out.write("가족케어 " + days + "일 : " + (days * getExtendedCost(types[0], "noschool")) + "원<br/>\n");
												}
												if (cares[3].equals("T"))
												{
													days = getDays(cares[4], cares[5]);
													out.write("취학아동 " + days + "일 : " + (days * getExtendedCost(types[0], "school")) + "원<br/>\n");
												}
												if (cares[6].equals("T"))
												{
													days = getDays(cares[7], cares[8]);
													out.write("추가가족 " + days + "일 : " + (days * getExtendedCost(types[0], "family")) + "원<br/>\n");
												}
												if (cares[9].equals("T"))
												{
													days = getDays(cares[10], cares[11]);
													out.write("쌍둥이케어 " + days + "일 : " + (days * getExtendedCost(types[0], "twin")) + "원<br/>\n");
												}
											%>
											<!--
											취학아동 5일 : 35,000원<br/>
											추가가족 5일 * 3인 : 75,000원<br/>
											쌍둥이케어 5일 : 150,000원
											-->
										</dd>
										<dt>추가금 시간초과</dt>
										<dd>
											<%
												for (int idx = 0; idx < overtimes.length; idx++)
												{
													String[] t = overtimes[idx].split(" ");
													String h;
													if (t.length != 2) continue;
													boolean isHoliday;
													if (t[1].charAt(0) == 'H')
													{
														h = t[1].substring(1);
														isHoliday = true;
													}
													else
													{
														h = t[1];
														isHoliday = false;
													}
													out.write(t[0].replace("-", ".") + " : " + (isHoliday ? "휴일 " : "") + h + "시간 | ");
													out.write("" + getOvertimeCost(service._serviceName, types[0], t[1]) + "원<br/>\n");
												}
											%>
											<!--
											21일 : 3시간 | 39,000원<br/>
											22일 : 1시간 | 13,000원<br/>
											24일(주말) : 2시간 | 26,000원<br/>
											25일(주말) : 1시간 | 13,000원
											-->
										</dd>
										<!--
										<dt>추가금 휴일근무</dt>
										<dd>
											24일 : 26,000원 <br/>
											25일 : 13,000원
										</dd>
										-->
									</dl>
									<textarea name="SERVICE_LOG" id="SERVICE_LOG" class="form-control" readonly></textarea>
								</div>
							</div>
						</div>
						<%
							}
						%>
						
						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile bg-dark">
								<div class="x_title">
									<h2>서비스 금액</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content service-price fixed_height_520">
									<dl>
						<%
							long costTotal = 0;
							iterator = list.iterator();
							boolean isFirst = true;
							while (iterator.hasNext())
							{
								CustomerService service = (CustomerService) iterator.next();
								String[] types = service._serviceType.split("_");
								String[] cares = service._additionalCare.split("_");
								String[] overtimes = service._additionalOvertime.split("_");
								int days = 0;
								long costOption = 0;

								if (cares[0].equals("T"))
								{
									days = getDays(cares[1], cares[2]);
									costOption += (days * getExtendedCost(types[0], "noschool"));
								}
								if (cares[3].equals("T"))
								{
									days = getDays(cares[4], cares[5]);
									costOption += (days * getExtendedCost(types[0], "school"));
								}
								if (cares[6].equals("T"))
								{
									days = getDays(cares[7], cares[8]);
									costOption += (days * getExtendedCost(types[0], "family"));
								}
								if (cares[9].equals("T"))
								{
									days = getDays(cares[10], cares[11]);
									costOption += (days * getExtendedCost(types[0], "twin"));
								}

								for (int idx = 0; idx < overtimes.length; idx++)
								{
									String[] t = overtimes[idx].split(" ");
									String h;
									boolean isHoliday;
									if (t.length != 2) continue;
									if (t[1].charAt(0) == 'H')
									{
										h = t[1].substring(1);
										isHoliday = true;
									}
									else
									{
										h = t[1];
										isHoliday = false;
									}
									costOption += getOvertimeCost(service._serviceName, types[0], t[1]);
								}
						%>
										<dt><%= (isFirst ? "기본" : "연장") %> :
											<span class="label label-default"><%= getServiceName(service._serviceName) %></span>
											<span class="label label-default"><%= getServicePeriodDisp(service._servicePeriod) %></span>
											<span class="label label-default">
											<%
												if (types[0].equals("inhouse"))
												{
													out.write("입주");
												}
												else if (types[0].equals("commute"))
												{
													out.write("출퇴근");
												}
												else // if (types[0].equals("mixed"))
												{
													out.write("입주 + 출퇴근");
												}
											%>
											</span>
											<span class="label label-default"><%= types[1] %>일</span>
										</dt>
						<%
								long costSvc = getServiceCost(service);
								costTotal += costSvc;
						%>
										<dd><%= costSvc %>원</dd>
										<dt>옵션</dt>
										<dd><%= costOption %>원</dd>
						<%
								costTotal += costOption;
								isFirst = false;
							}
						%>
<!--
										<dt>연장 :
											<span class="label label-default">프라이빗</span>
											<span class="label label-default">2주</span>
											<span class="label label-default">입주</span>
											<span class="label label-default">5일</span>
										</dt>
										<dd>2,167,000원</dd>
										<dt>옵션</dt>
										<dd>687,000원</dd>
-->
									</dl>
									<div class="row">
										<div class="col-md-6 col-sm-6">
											<span class="total-price-label">총액</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="total-price"><%= costTotal %>원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="voucher-label">바우처</span>
										</div>
										<% long voucherSupport = getVoucherSupport("GOV"); %>
										<div class="col-md-6 col-sm-6">
											<span class="voucher-price red"><%= voucherSupport %>원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="income-label">입금받음</span>
										</div>
										<% long payed = getPayedCost(); %>
										<div class="col-md-6 col-sm-6">
											<span class="income-price red"><%= payed %>원</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="balance-label">잔액</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="balance-price green"><%= costTotal - voucherSupport - payed %>원</span>
										</div>
									</div>
									<hr>
									<textarea name="COST_LOG" id="COST_LOG" class="form-control" readonly><%= getPayedLog() %></textarea>
									<!--<a href="#!" class="btn btn-primary btn-sm pull-right">입금확인(확인전)</a>-->
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
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>바우처</h2>
									<a class="btn btn-primary btn-xs pull-right" onclick="edit('voucher')">기록/수정/삭제</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content voucher">
									<dl>
										<dt>바우처 소득유형</dt>
										<dd><%= getVoucherName() %></dd>
										<dt>바우처 서비스 기간</dt>
										<dd><%= _item._voucherDays %>일</dd>
										<dt>태아유형</dt>
										<dd><%= printBabyType() %></dd>
										<dt>출산순위</dt>
										<dd id="BABY_ORDER"></dd>
										<dt>정부지원금</dt>
										<dd id="VOUCHER_GOV"><%= getVoucherSupport("GOV") %>원 [자동산정]</dd>
										<dt>본인부담금</dt>
										<dd id="VOUCHER_SELF"><%= getVoucherSupport("SLF") %>원 [자동산정]</dd>
										<dt>거주지역</dt>
										<dd><%= _item._address1 %> <%= _item._address2 %> [주소 자동 참조]</dd>
										<dt>지역정책</dt>
										<dd id=REGION_POLICY">미입력</dd>
									</dl>
									<!--<textarea name="" id="" class="form-control"></textarea>-->
								</div>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>기타정보</h2>
									<a class="btn btn-primary btn-xs pull-right" onclick="edit('etc')">수정</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content etc-info">
									<dl>
										<dt>반려동물</dt>
										<dd><%= getPets() %></dd>
										<dt>대여품목</dt>
										<dd><%= getRental() %></dd>
										<dt>선물</dt>
										<dd><%= getGifts() %></dd>
										<dt>단말기</dt>
										<dd><%= getTerminal() %></dd>
										<dt>현금영수증</dt>
										<dd><%= getReceipt() %>
											<a onclick="writeLog('ETC', '현금영수증 발행 확인')" class="btn btn-primary btn-xs btn-mb-0">현금영수증 발행확인</a>
										</dd>
									</dl>
						
									<textarea name="ETC_LOG" id="ETC_LOG" class="form-control" readonly><%= getLogs("ETC") %></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<!--
						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>연장정보1</h2>
									<a href="#!" class="btn btn-primary btn-xs pull-right">기록/수정/삭제</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content extension fixed_height_450">
									<dl>
										<dt>서비스</dt>
										<dd>프라이빗</dd>
										<dt>서비스 기간</dt>
										<dd>2주 / 2018.02.20 ~ 2018.03.05</dd>
										<dt>서비스 형태</dt>
										<dd>입주 / 주5일</dd>
										<dt>관리사</dt>
										<dd>조아라</dd>
										<dt>추가금 케어형태</dt>
										<dd>
											 가족케어 5일 : 50,000원
											<br/> 취학아동 5일 : 35,000원
											<br/> 추가가족 5일 * 3인 : 75,000원
											<br/> 쌍둥이케어 5일 : 150,000원
										</dd>
									</dl>
								</div>
							</div>
						</div>
						-->
						<!--
						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>삭제된 연장정보(yyyy.mm.dd 조미경 삭제)
									</h2>
									<a href="#!" class="btn btn-primary btn-xs pull-right">복구요청</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content deleted-extension-info fixed_height_450">
									<dl>
										<dt>서비스</dt>
										<dd>프라이빗</dd>
										<dt>서비스 기간</dt>
										<dd>2주 / 2018.02.22 ~ 2018.03.22</dd>
										<dt>서비스 형태</dt>
										<dd>입주 / 주5일</dd>
										<dt>관리사</dt>
										<dd>조아라</dd>
										<dt>추가금 케어형태</dt>
										<dd>
											가족케어 5일 : 50,000원
											<br/> 취학아동 5일 : 35,000원
											<br/> 추가가족 5일 * 3인 : 75,000원
											<br/> 쌍둥이케어 5일 : 150,000원
										</dd>
									</dl>
									<textarea name="" id="" class="form-control">yyyy.mm.dd 조미경 삭제</textarea>
									<hr>
									<small>* 삭제된 기록은 과금에 반영되지 않습니다.</small>
									<br/>
									<small>* 삭제된 기록은 복구되지 않습니다. (관리자에게 문의하세요)</small>
								</div>
							</div>
						</div>

						<div class="col-md-6 col-sm-6">
							<div class="x_panel tile">
								<div class="x_title">
									<h2>복구된 연장정보 2</h2>
									<a href="#!" class="btn btn-primary btn-xs pull-right">기록/수정/삭제</a>
									<div class="clearfix"></div>
								</div>
								<div class="x_content restoration-extension-info fixed_height_450">
									<dl>
										<dt>서비스</dt>
										<dd>프라이빗</dd>
										<dt>서비스 기간</dt>
										<dd>2주 / 2018.02.22 ~ 2018.03.22</dd>
										<dt>서비스 형태</dt>
										<dd>입주 / 주5일</dd>
										<dt>관리사</dt>
										<dd>조아라</dd>
										<dt>추가금 케어형태</dt>
										<dd>
											가족케어 5일 : 50,000원
											<br/> 취학아동 5일 : 35,000원
											<br/> 추가가족 5일 * 3인 : 75,000원
											<br/> 쌍둥이케어 5일 : 150,000원
										</dd>
									</dl>
									<textarea name="" id="" class="form-control">yyyy.mm.dd 조미경 삭제 -> yyyy.mm.dd 조미경 복구요청 -> yyyy.mm.dd 서동필 복구완료</textarea>
								</div>
							</div>
						</div>
						-->
					</div>
					

					<div class="text-center btn-group-bottom">
						<a onclick='deleteCustomer(<%=item._index%>)' class="btn btn-primary btn-sm">삭제</a>
						<a href='order_consult_new.jsp?CUSTOMER=<%=item._index%>' class="btn btn-primary btn-sm">수정</a>
						<a class="btn btn-primary btn-sm" onclick="goConsultList()">목록</a>
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