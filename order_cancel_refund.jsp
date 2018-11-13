<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
/*
	HttpServletRequest _request;
	String[] _titles = {"상담/문의", "계약/결제", "서비스"};
	int _step = -1;

	int getStep()
	{
		String step = (String)_request.getParameter("STEP");
		if (step == null)
		{
			step = "0";
		}

		//UserDB.PrintLog("PPPPPP: " + step);
		return (_step = Integer.parseInt(step));
	}

	public String getTitle()
	{
		if (_step == -1)
		{
			getStep();
		}

		return _titles[_step - 1];
	}
*/

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
	List<Region> lstRegionsGroup; //= _userdb.getGiftList();
	List<Region> lstRegionsAll; //= _userdb.getGiftList();

	lstRegionsGroup = UserDB.getRegionList(-1);
	lstRegionsAll = UserDB.getRegionList(0);

	//_request = request;
	//getStep();
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="./build/css/waitingWheel.css" rel="stylesheet">
	<title>마더앤베이비 관리자 - 주문 취소/환불</title>

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
	<script src="js/base64.js" ></script>
	<!--<script src="js/order_consult.js" ></script>-->
	<script>
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
			if (window.confirm("환불 금액 및 내용이 수정됩니다.")) {
			    var val = '';
			    if (refundComplete == "yes") {
			    	refundComplete = "completed"
			    }
			    val += 'CANCEL_CONTRACT' + '&';
			    val += 'REFUND_DATE=' + refundDate + '&';
			    val += 'REFUND_COMPLETE=' + refundComplete + '&';
			    val += 'REFUND_VALUE=' + refundVal + '&';
			    val += 'MEMBER=' + <%= _user._index %> + '&';
			    val += 'CUSTOMER=' + _customer + '&';
			    $.post("_api_sales.jsp", val)
			    .fail(function(response) {
			        alert('Error: ' + response.responseText);
			        //document.getElementById("org").innerHTML = response.responseText;
			    })
			    .done(function(data) {
			        console.log(data);
					$('#REFUND').modal('toggle');
					location.reload();
			    });
			} else {
				//alert("I knew it");
			}
		}

		var _customer = -1;
		function showModBox(customer, name, payed, checked, completed, services) {
			var html = "";

			_customer = customer;
			console.log(services);
			for (var i in services) {
				html += "<h5>";
				html += "<strong>서비스: </strong>" + services[i].name + "<br/>";
				html += "<strong>서비스기간: </strong>" + services[i].period + "<br/>";
				html += "<strong>서비스형태: </strong>" + services[i].type + "<br/>";
				html += "<strong>추가금 케어형태: </strong>" + services[i].cares + "<br/>";
				html += "<strong>추가금 시간초과: </strong>" + services[i].overtimes + "<br/>";
				html += "</h5>";
			}
			html += "<h5>";
			html += "<strong>환불금액입력(필수)</strong>";
			html += "</h5>";
			html += "<div class='input-group'>";
			html += "	<input type='number' class='form-control' placeholder='금액입력, 단위 원' name='REFUND_VALUE' id='REFUND_VALUE' value='" + payed + "'>";
			html += "</div>";
			html += "<h5>";
			html += "	<strong>환불을 완료하셨습니까?</strong>";
			html += "	<input type='radio' name='REFUND_COMPLETE' class='flat' id='REFUND_COMPLETE' value='yes' " + ((completed == "completed") ? "checked" : "") + ">";
			html += "	<label for=''>예</label>";
			html += "	<input type='radio' name='REFUND_COMPLETE' class='flat' id='REFUND_COMPLETE' value='no' " + ((completed != "completed") ? "checked" : "") + ">";
			html += "	<label for=''>아니오</label>";
			html += "</h5>";
			html += "<h5>";
			html += "	<strong>환불한 날짜를 입력하세요.</strong>";
			html += "	<input type='date' class='form-control input-sm input-inline' name='REFUND_DATE' id='REFUND_DATE' value='" + checked + "'>";
			html += "</h5>";
			html += "<h5>";
			html += "	<input type='checkbox' id='REFUND_CHECKED' name='REFUND_CHECKED' class='flat' value='confirmed'>";
			html += "	<strong>위 사항을 확인하였습니다.</strong>";
			html += "</h5>";
			$("#MOD_TITLE").html(name + ' 고객님의 계약을 취소합니다.<br/>아래 사항을 확인하세요.');
			$("#MOD_CONTENT").html(html);
			console.log(completed);
		}

		$(function() {
			//changedRegion();
		});
	</script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
<%@ include file="order_left_menu.jspf" %>
<%@ include file="order_top_nav.jspf" %>

			<!-- page content -->
			<div class="right_col order_consult" role="main">
				<div class="">
					<div class="location">
						<a href="#!">주문</a> &gt;
						<a href="#!">
							주문 취소 / 환불
						</a>
					</div>
					<div class="page-title">
						<div class="title_left">
							<h3>주문 취소 / 환불</h3>
						</div>
					</div>

					<!-- 검색결과 테이블 -->
					<div class="row consult-search-result">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel tile fixed_height_460">
								<div class="x_title">
									<h2>주문 취소 / 환불 목록</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="table-responsive">
										<div class="animate-bottom">
										<table class="table table-striped jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th class="column-title">번호</th>
													<th class="column-title">계약자</th>
													<th class="column-title">계약취소일</th>
													<th class="column-title">환불금액</th>
													<th class="column-title">환불날짜</th>
													<th class="column-title">담당자</th>
													<th class="column-title">보기/수정</th>
												</tr>
											</thead>

											<tbody id="consultList">
											<%
												String sql;
												String html = "";
												ResultSet rs = null;
												ResultSet rsSvc = null;
												int index = 1;
												int customer = -1;

												sql = "select cus.*, DATE_FORMAT(pay.CHECKED_TIME, '%Y-%m-%d') as CHECKED_TIME, DATE_FORMAT(cus.CANCELED, '%Y-%m-%d') as CANCELED_TIME, pay.*, mem.* from CUSTOMER cus" +
													" inner join PAYMENT_HISTORY pay on pay.CUSTOMER_INDEX = cus.CUSTOMER_INDEX" +
													" inner join MEMBER mem on pay.MEMBER_INDEX = mem.MEMBER_INDEX" +
													" where cus.VALID = 0 and pay.SERVICE_TYPE = 'refund'";
												rs = DBPool.getResultSet(sql);
												UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx - 1");
												while (UserDB.getNext(rs))
												{
													UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx - 2");
													if ((index % 2) == 0)
														out.write("\n<tr class='even pointer'>");
													else
														out.write("\n<tr class='odd pointer'>");

													//
													out.write("<td>" + index + "</td>");
													try {
														out.write("<td>" + rs.getString("cus.NAME") + "</td>");
														out.write("<td>" + rs.getString("CANCELED_TIME") + "</td>");
														out.write("<td>" + rs.getString("pay.PAYED_COST") + "</td>");
														out.write("<td>" + rs.getString("CHECKED_TIME") + "</td>");
														out.write("<td>" + rs.getString("mem.BUSINESS") + "</td>");

													html = "<td><a href='#!' class='btn btn-primary btn-xs btn-mb-0' data-toggle='modal' data-target='.cancel-contract'" +
														" onclick=\"showModBox(" +
														" " + rs.getInt("cus.CUSTOMER_INDEX") + "" +
														",'" + rs.getString("cus.NAME") + "'" +
														", " + rs.getString("pay.PAYED_COST") + "" +
														",'" + rs.getString("CHECKED_TIME") + "'" +
														",'" + rs.getString("pay.PAYMENT_TYPE") + "'" +
														",[";
													customer = rs.getInt("cus.CUSTOMER_INDEX");
													} catch (SQLException e) {
														UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
													}
													index++;

													sql = "select * from CUSTOMER_SERVICE where CUSTOMER_INDEX = " + customer;
													rsSvc = DBPool.getResultSet(sql);
													UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx - 1");
													String tmp = "";
													Timestamp date;
													while (UserDB.getNext(rsSvc))
													{
														String[] cares = null;
														int days = 0;
														String[] types = null;
														//UserDB.PrintLog("LEN = " + cares.length);
														String[] overtimes = null;
														try {
															cares = rsSvc.getString("ADDITIONAL_CARE").split("_");
															types = rsSvc.getString("SERVICE_TYPE").split("_");
															overtimes = rsSvc.getString("ADDITIONAL_OVERTIME").split("_");

															tmp += "{";
															tmp += "name:'" + getServiceName(rsSvc.getString("SERVICE_NAME")) + "'";
															tmp += ",period:'" + getServicePeriodDisp(rsSvc.getString("SERVICE_PERIOD")) + " / ";
															date = rsSvc.getTimestamp("SERVICE_START");
															if (date != null)
																tmp += _df.format(date);
															else
																tmp += "미입력";
															tmp += " ~ ";
															date = rsSvc.getTimestamp("SERVICE_END");
															if (date != null)
																tmp += _df.format(date);
															else
																tmp += "미입력";
															tmp += "'";

															tmp += ",type:'";
															if (types[0].equals("inhouse"))
															{
																tmp += "입주";
															}
															else if (types[0].equals("commute"))
															{
																tmp += "출퇴근";
															}
															else // if (types[0].equals("mixed"))
															{
																tmp += "입주 + 출퇴근";
															}
															tmp += " / " + types[1] + "일'";

															tmp += ",cares:'";
															if (cares[0].equals("T"))
															{
																days = getDays(cares[1], cares[2]);
																//out.write("가족케어 " + days + "일 : " + (days * getExtendedCost(types[0], "noschool")) + "원<br/>\n");
																tmp += "가족케어 " + days + "일 | ";
															}
															if (cares[3].equals("T"))
															{
																days = getDays(cares[4], cares[5]);
																//out.write("취학아동 " + days + "일 : " + (days * getExtendedCost(types[0], "school")) + "원<br/>\n");
																tmp += "취학아동 " + days + "일 | ";
															}
															if (cares[6].equals("T"))
															{
																days = getDays(cares[7], cares[8]);
																//out.write("추가가족 " + days + "일 : " + (days * getExtendedCost(types[0], "family")) + "원<br/>\n");
																tmp += "추가가족 " + days + "일 | ";
															}
															if (cares[9].equals("T"))
															{
																days = getDays(cares[10], cares[11]);
																//out.write("쌍둥이케어 " + days + "일 : " + (days * getExtendedCost(types[0], "twin")) + "원<br/>\n");
																tmp += "쌍둥이케어 " + days + "일 | ";
															}
															tmp += "',overtimes:'";
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
																tmp += t[0].replace("-", ".") + " : " + (isHoliday ? "휴일 " : "") + h + "시간 | ";
															}
															tmp += "'";

															tmp += "},";
														} catch (SQLException e) {
															UserDB.PrintLog("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
														}
													}
													DBPool.removeDBObject(rsSvc);
													if (tmp.length() > 0)
													{
														tmp = tmp.substring(0, tmp.length() - 1); // To remove last comma
														html += tmp;
													}
													html += "])\">보기/수정</a></td>";
													out.write(html);
													out.write("</tr>\n");
												}
												DBPool.removeDBObject(rs);
											%>
												<!--
												<tr class="even pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="odd pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-info">진행</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="even pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-success">완료</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="odd pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="even pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="odd pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="even pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="odd pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="even pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												<tr class="odd pointer">
													<td>
														<a href="order_consult_detail.html" class="btn btn-primary btn-xs btn-mb-0">보기</a>
													</td>
													<td><span class="label label-warning">대기</span></td>
													<td>최정은</td>
													<td>전화옴</td>
													<td>조미경</td>
													<td>2018.03.26</td>
													<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
													<td>관악</td>
													<td>조리원이용 (4주이상) 출퇴근 6일</td>
												</tr>
												-->
											</tbody>
										</table>
										</div>
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
													<p id="MOD_TITLE">
													</p>
													<form action="" id="MOD_CONTENT">
													</form>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default btn-sm" data-dismiss="modal" onclick="onCancelContractCancel()">작성취소</button>
													<button type="button" class="btn btn-primary btn-sm" onclick="onCancelProceed()">진행</button>
												</div>
							
											</div>
										</div>
									</div>
										<!--
										<nav aria-label="Page navigation example">
											<ul class="pagination pull-right">
												<li class="page-item disabled">
													<a class="page-link" href="#" tabindex="-1">이전</a>
												</li>
												<li class="page-item">
													<a class="page-link" href="#">1</a>
												</li>
												<li class="page-item">
													<a class="page-link" href="#">2</a>
												</li>
												<li class="page-item">
													<a class="page-link" href="#">3</a>
												</li>
												<li class="page-item">
													<a class="page-link" href="#">다음</a>
												</li>
											</ul>
										</nav>
										-->
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
	<!-- jQuery Sparklines -->
	<script src="./vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
	<!-- DateJS -->
	<script src="./vendors/DateJS/build/date.js"></script>
	<!-- bootstrap-daterangepicker -->
	<script src="./vendors/moment/min/moment.min.js"></script>
	<script src="./vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<script src="./vendors/jquery-ui-1.12.1.custom/datepicker-ko-KR.js"></script>
	<script src="./vendors/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>

	<!-- iCheck -->
	<script src="./vendors/iCheck/icheck.min.js"></script>
	<!-- TweenMax -->
	<script src="./vendors/tweenmax/TweenMax.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="./build/js/custom.min.js"></script>
</body>

</html>