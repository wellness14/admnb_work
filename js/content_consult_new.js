
/*
function showSMSDialog() {
	var url = getSmsUrl();
}
*/

var _customerCost = 0;
var _customerPayed = 0;
var _customerDiscount = 0;
var _customerVoucher = 0;

function writeLog(type, log) {
    var val = '';
    val += 'ADDLOG' + '&';
    val += 'INDEX=' + _indexCustomer + '&';
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

function sendSMS() {
	//alert("HR");
	//return;
	if (_indexCustomer == -1) {
		alert('저장 후 전송 가능합니다.');
		return;
	}
	if ($("#SMS_MOBILE_NUMBER").val().length == 0) {
		alert("전화번호가 입력되지 않았습니다.");
		return;
	}

	var val;
	val = '';
	val += 'INDEX=' + _indexCustomer + '&';
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
			writeLog("SMS", "가입문자 발송");
			alert("전송되었습니다.");
		} else {
			alert("전송실패했습니다.");
		}
	});
}

function showSMSDialog() {
	if (_indexCustomer == -1) {
		$("#SMS").val("정보 저장 후 전송 가능합니다.");
		return;
	}

	var val;
	val = '';
	val += 'INDEX=' + _indexCustomer + '&';
	val += 'GET=' + '&';
	$.post("_consult_update.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		console.log('DONE:' + data.COMMAND);
		console.log('URL:' + data.RESULT.URL);
		console.log(data);
		//_indexCustomer = data.RESULT;
		//location.reload();
		//window.location.href = 'content_branch_list.jsp';
		var smsText = "";
		if (data.RESULT.KEY.length == 0) {
			smsText += "이미 가입처리 되었습니다.";
		} else {
			smsText += "마더앤베이비(산후도우미) 회원가입을 부탁드립니다.\n";
			smsText += "회원가입을 완료하셔야 산후도우미 서비스를 이용할 수 있습니다.\n";
			smsText += "회원가입 이동 : " + data.RESULT.URL;
		}
		$("#SMS").val(smsText);
		$("#SMS_MOBILE_NUMBER").val($("#MOBILE").val());
	});
}

function saveAll() {
	var val;

	//console.log("LLLLLLLL:" + $("#CONSULT_BRANCH").val());
	//return;
	//alert($("#formData_1").serialize());
	getPets();
	//console.log('>>>>>>>>>>>>>>>>' + _indexCustomer);
	val = '';
	val += 'INDEX=' + _indexCustomer + '&';
	val += 'MEMBER=' + _memberIndex + '&';
	val += 'BRANCH=' + $("#CONSULT_BRANCH").val() + '&';
	val += 'ROUTE=' + getCheckedValues('ROUTE') + '&';
	val += 'EXPERIENCES=' + getChildrenString() + '&';
	val += 'BABIES=' + getBabiesString() + '&';
	val += 'PETS=' + getPets() + '&';
	val += 'MEMO=' + base64.encode($("#COUNSEL_CONTENT").val()) + '&';
	val += 'TOTAL_COST=' + _customerCost + '&';
	val += 'TOTAL_PAYED=' + _customerPayed + '&';
	val += 'TOTAL_DISCOUNT=' + _customerDiscount + '&';
	val += 'TOTAL_VOUCHER=' + _customerVoucher + '&';
	//val += 'BABIES=' + b64EncodeUnicode() + '&';
	if (recommenderIndex != -1) val += 'RECOMMEND_INDEX=' + recommenderIndex + '&';
	if (rentalIndex != -1) val += 'RENTAL_INDEX=' + rentalIndex + '&';
	if (giftIndex1 != -1) val += 'GIFT_INDEX1=' + giftIndex1 + '&';
	if (giftIndex2 != -1) val += 'GIFT_INDEX2=' + giftIndex2 + '&';
	if (terminalIndex != -1) val += 'TERMINAL_INDEX=' + terminalIndex + '&';
	val = val.concat($("#formData_1").serialize(), '&');
	val = val.concat($("#formData_2").serialize(), '&');
	val = val.concat($("#formData_3").serialize(), '&');
	val = val.concat($("#formData_4").serialize(), '&');
	val = val.concat($("#formData_5").serialize(), '&');
	val = val.concat($("#formData_6").serialize(), '&');
	//val += $("#formData_1").serialize() + '&';
	//val += $("#formData_2").serialize() + '&';
	//val += $("#formData_3").serialize() + '&';
	//val += $("#formData_4").serialize() + '&';
	//val += $("#formData_5").serialize() + '&';
	/*
	val += $("#formData_1").serialize() + '&\n';
	val += $("#formData_2").serialize() + '&\n';
	val += $("#formData_3").serialize() + '&\n';
	val += $("#formData_4").serialize() + '&\n';
	val += $("#formData_5").serialize() + '&\n';
	*/
	//console.log(val);
	//alert(val);
	$.post("_consult_update.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		console.log('DONE:' + data.COMMAND);
		console.log('done:' + data.RESULT);
		_indexCustomer = data.RESULT;
		//location.reload();
		//window.location.href = 'content_branch_list.jsp';
		for (i in _services) {
			_services[i].saveServer();
		}
		window.location.href = "order_consult_detail.jsp?INDEX=" + _indexCustomer;
	});
}

function submitMe() {
	/*
	var val;
	alert($("#PERIOD_1").val());
	getPets();
	val = '';
	val += 'INDEX=' + _indexCustomer + '&';
	val += 'ROUTE=' + getCheckedValues('ROUTE') + '&';
	val += 'EXPERIENCES=' + getChildrenString() + '&';
	val += 'BABIES=' + getBabiesString() + '&';
	val += 'PETS=' + getPets() + '&';
	val += 'MEMO=' + base64.encode($("#COUNSEL_CONTENT").val()) + '&';
	//val += 'BABIES=' + b64EncodeUnicode() + '&';
	if (recommenderIndex != -1) val += 'RECOMMEND_INDEX=' + recommenderIndex + '&';
	if (rentalIndex != -1) val += 'RENTAL_INDEX=' + rentalIndex + '&';
	if (giftIndex != -1) val += 'GIFT_INDEX=' + giftIndex + '&';
	if (terminalIndex != -1) val += 'TERMINAL_INDEX=' + terminalIndex + '&';
	val += $("#formData").serialize();
	//alert(val);

	//$.post("_consult_update.jsp", val)
	$.post("_test.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		document.getElementById("error").innerHTML = response.responseText;
	})
	.done(function(data) {
		//alert('done');
		//location.reload();
		//window.location.href = 'content_branch_list.jsp';
	});
	*/

	for (i in _services) {
		_services[i].saveServer();
	}
}

function getCheckedValues(name) {
	var ret = '';
	var boxs = document.getElementsByName(name);

	for (var i = 0; i < boxs.length; i++) {
		if (boxs[i].checked) {
			ret += boxs[i].value + ' ';
		}
	}

	return ret;
}

function saveCounsel() {
	//alert(document.getElementById("counsel").innerHTML);
	/*
	post('_counsel_event.jsp', {
			type : 'saveCounsel',
			data : document.getElementById("counsel").innerHTML
		});
	*/
	var val;

	if (_indexCustomer == -1) {
		saveAll();
		return;
	}

	val = '';
	val += 'INDEX=' + _indexCustomer + '&';
	//val += 'COUNSEL_CONTENT=' + b64EncodeUnicode($("#COUNSEL_CONTENT").val());
	val += 'MEMO=' + base64.encode($("#COUNSEL_CONTENT").val());
	//alert(val);
	$.post("_consult_update.jsp", val)
	//$.post("_test.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		document.getElementById("error").innerHTML = response.responseText;
	})
	.done(function(data) {
		//alert('done');
		//location.reload();
		//window.location.href = 'content_branch_list.jsp';
	});
}

var _memberIndex = -1;
var recommenderIndex = -1;
//var helperIndex = -1;
var rentalIndex = -1;
var giftIndex1 = -1;
var giftIndex2 = -1;
var terminalIndex = -1;

var _indexCustomer = -1;
//var indexPreCustomer = -1;
var smsURL = "";

/*
function savePreCustomer() {
	var val = $("#formData").serialize();
	//alert(val);

	$.post("_savePreCustomer.jsp", val)
	.fail(function(response) {
		alert('Error: ' + response.responseText);
	})
	.done(function(data) {
		indexPreCustomer = data.INDEX;
		smsURL = "localhost:8080/work/signin.jsp?INDEX=" + indexPreCustomer;
		//smsURL = "work.eidware.com:8888/work/signin.jsp?INDEX=" + indexPreCustomer;
		//alert('[' + data.INDEX + ']');
		alert('[' + smsURL + ']');
	});
}
*/

/*
function sendSMS() {
	// 가입문자 발송
	var mobile = document.getElementById("MOBILE").value;
	if (mobile.length < 1) {
		alert('휴대전화 정보가 입력되지 않았습니다.');
		return;
	} else {
		if (indexPreCustomer == -1) {
			//alert('가입을 위한 사전정보가 입력되었습니다.');
			savePreCustomer();
		}
		// TODO: send SMS
		alert(mobile + ' 번호로 문자가 발송되었습니다.');
	}
}
*/

function checkSignIn() {
	//if (smsURL.length > 0) {
	if (indexPreCustomer != -1) {
		$("#USERID").val('가입요청함');
		var val = "PRECUSTOMER_INDEX=" + indexPreCustomer;
		$.post("_check_customer_signin.jsp", val)
		.fail(function(response) {
			alert('Error: ' + response.responseText);
		})
		.done(function(data) {
			_indexCustomer = data.CUSTOMER;
			if (_indexCustomer != -1) {
				window.location.href = 'content_consult_new.jsp?CUSTOMER=' + _indexCustomer;
				//$("#USERID").val('가입아이디:' + _indexCustomer);
			}
			//smsURL = "localhost:8080/work/signin.jsp?INDEX=" + indexPreCustomer;
			//alert('[' + data.INDEX + ']');
			//alert('[' + smsURL + ']');
		});
	}
}

function viewSMS() {
	// 문자내용 보기
	if (smsURL.length == 0) {
		alert('문자 전송 후 확인이 가능합니다.');
		return;
	}
	alert(smsURL);
}

var _children = [];

function getDelChildButton(index) {
	var ret = "<button onclick='delChild(" + index + ")' type='button'>-</button>";
	return ret;
}

function addChild() {
	var temp;
	var genders = document.getElementsByName("CHILD_GENDER");
	var age = document.getElementById("child_age").value;

	if (age.length == 0) {
		alert('아이의 나이를 입력해 주세요.');
		return;
	}
	if (genders[0].checked) {
		temp = "M";
	} else {
		temp = "F";
	}
	temp += age;
	_children.push(temp);
	drawChildren();
	//alert("[" + getChildrenString() + "]");
}

function delChild(index) {
	_children.splice(index, 1);
	drawChildren();
}

function drawChildren() {
	var index;
	var gender;
	var html = "";

	if (_children.length == 0) {
		document.getElementById("children").innerHTML = "없음";
		return;
	}
	for (index = 0; index < _children.length; index++) {
		//alert(_children[index]);
		if (_children[index].substring(0, 1).localeCompare("M") == 0) {
			gender = "남 ";
			//html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
		} else if (_children[index].substring(0, 1).localeCompare("F") == 0) {
			gender = "여 ";
			//html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
		} else {
			continue;
		}
		html += gender + _children[index].substring(1) + " 세 " + getDelChildButton(index) + "<br>";
	}
	document.getElementById("children").innerHTML = html;
}

function setChildrenString(str) {
	var index;
	var vals = str.split(" ");

	_children = [];
	for (index = 0; index < vals.length; index++) {
		if (vals[index].length == 0) continue;
		//alert("[" + vals[index] + "]");
		_children.push(vals[index]);
	}
	drawChildren();
}

function getChildrenString() {
	var index;
	var ret = "";

	for (index = 0; index < _children.length; index++) {
		ret += _children[index] + " ";
	}

	return ret;
}

var _babies = [];

function getDelBabyButton(index) {
	var ret = "<button onclick='delBaby(" + index + ")' type='button'>-</button>";
	return ret;
}

function addBaby() {
	var temp;
	var genders = document.getElementsByName("BABY_GENDER");
	var weight = document.getElementById("baby_weight").value;

	if (weight.length == 0) {
		alert('태아의 무게를 입력해 주세요.');
		return;
	}
	if (genders[0].checked) {
		temp = "M";
	} else {
		temp = "F";
	}
	temp += weight;
	_babies.push(temp);
	drawBabies();
}

function delBaby(index) {
	_babies.splice(index, 1);
	drawBabies();
}

function drawBabies() {
	var index;
	var gender;
	var html = "";

	if (_babies.length == 0) {
		document.getElementById("babies").innerHTML = "미입력";
		return;
	}
	for (index = 0; index < _babies.length; index++) {
		//alert(_children[index]);
		if (_babies[index].substring(0, 1).localeCompare("M") == 0) {
			gender = "남 ";
		} else {
			gender = "여 ";
		}
		html += gender + _babies[index].substring(1) + " Kg " + getDelBabyButton(index) + "<br>";
	}
	document.getElementById("babies").innerHTML = html;
}

function setBabiesString(str) {
	var index;
	var vals = str.split(" ");

	_babies = [];
	for (index = 0; index < vals.length; index++) {
		if (vals[index].length == 0) continue;
		//alert("[" + vals[index] + "]");
		_babies.push(vals[index]);
	}
	drawBabies();
}

function getBabiesString() {
	var index;
	var ret = "";

	for (index = 0; index < _babies.length; index++) {
		ret += _babies[index] + " ";
	}

	return ret;
}

function setFields_ByName(name, value) {
	var elements = document.getElementsByName(name);
	var index;
	for (index = 0; index < elements.length; index++) {
		elements[index].value = value;
	}
}

var _mixed;
//var _mixedHTML = "<tr><td>입주시작</td><td><input type=text name='MOVE_DATE' placeholder='YYYYMMDD' /></td></tr><tr><td>출근시작</td><td><input type=text name='COMMUTE_DATE' placeholder='YYYYMMDD' /></td></tr>";
var _mixedHTML = "입주시작: <input type=text name='MOVE_DATE' placeholder='YYYYMMDD' /><br/>출근시작: <input type=text name='COMMUTE_DATE' placeholder='YYYYMMDD' />";

function init() {
	//document.getElementById("cost_base").innerHTML = "기본: 블라블라 0원<br/>옵션 0원";
	//document.getElementById("cost_extended").innerHTML = "연장: 블라블라 0원<br/>옵션 0원";
	//document.getElementById("cost_total").innerHTML = "총액 0원 - 바우처 0원";

	//_mixed = document.getElementById("mymixed_0").outerHTML;
}

window.onload = init;

function showMixed(index) {
	//var temp = _mixed.replace(/<CS_INDEX>/g,  index);
	//document.getElementById("mymixed_" + index).innerHTML = temp;
}

function hideMixed(index) {
	//document.getElementById("mymixed_" + index).innerHTML = "";
}

// 추천인 선택
function openRecommendSelectionWindow() {
    //var myWindow = window.open("sub_select_recommend.jsp?PATTERN=" + document.getElementById("RECOMMEND").value, "selectRecommend", "width=500,height=500");
	//myWindow.document.write("<p>This is 'myWindow'</p><button onclick=\"window.opener.setHelper('Someone'); window.close();\">Set Helper</button>");
	var val = "";
	val += "PATTERN=" + document.getElementById("RECOMMEND").value;
	$.post("sub_select_recommend.jsp", val)
	.fail(function(response) {
		$("#org").html(response.responseText);
	})
	.done(function(data) {
		$("#recommenders").html(data);
		//smsURL = "localhost:8080/work/signin.jsp?INDEX=" + indexPreCustomer;
		//alert('[' + data.INDEX + ']');
		//alert('[' + smsURL + ']');
	});
}

function setRecommend(index, name) {
	recommenderIndex = index;
	document.getElementById("RECOMMEND").value = name;
	//alert(name);
}

var _tempServiceIndex = -1;
// 관리사 선택
function openHelperSelectionWindow(serviceIndex) {
    //var myWindow = window.open("sub_select_helper.jsp?SERVICE_INDEX=" + serviceIndex, "selectHelper", "width=500,height=500");
	//myWindow.document.write("<p>This is 'myWindow'</p><button onclick=\"window.opener.setHelper('Someone'); window.close();\">Set Helper</button>");
	_tempServiceIndex = serviceIndex;
	var val = "";
	val += "SERVICE_INDEX=" + serviceIndex + "&";
	$.post("sub_select_helper.jsp", val)
	.fail(function(response) {
		$("#org").html(response.responseText);
	})
	.done(function(data) {
		if (_tempServiceIndex != -1) {
			$("#helpers_" + _tempServiceIndex).html(data);
		}
		//smsURL = "localhost:8080/work/signin.jsp?INDEX=" + indexPreCustomer;
		//alert('[' + data.INDEX + ']');
		//alert('[' + smsURL + ']');
	});
}

function setHelper(serviceIndex, index, name) {
	getService(serviceIndex)._helper = index;
	getService(serviceIndex)._helperName = name;
	//helperIndex = index;
	console.log(setHelper.caller + " - HELPER:" + serviceIndex)
	document.getElementById("HelperName_" + serviceIndex).value = name;
	//alert(name);
}

var _displays = [
    ['BASIC', '베이직'],
    ['PREMIUM', '프리미엄'],
    ['PRIVATE', '프라이빗'],
    ['INTEN', '집중관리'],
    ['35', '35세이상산모'],
    ['HEAVY', '과체중'],
    ['TWIN', '쌍둥이'],
    ['MULTI', '다둥이'],
    ['WORKING', '워킹맘'],
    ['HOME', '산후조리원 내집에'],
    ['INHOUSE', '입주'],
    ['COMMUTE', '출퇴근'],
    ['MIXED_W2W2', '입주 2주 + 출퇴근 2주'],
    ['W1', '1주'],
    ['W2', '2주'],
    ['W3', '3주'],
    ['W4', '4주'],
];

function getDisp(val) {
    //var ret = '';

    for (i in _displays) {
        val = val.replace(_displays[i][0], _displays[i][1]);
    }
    val = val.replace(/_/g, ' ');

    return val;
}

function getTargetDisplay(str) {
    var disp = '';
    var targets;

    targets = str.split(' ');
    for (i in targets) {
        if ((targets[i] == null) || (targets[i].length == 0)) {
            continue;
        }
        disp += getDisp(targets[i]) + "<br>";
        //alert(targets[i]);
        //console.log(targets[i]);
    }

    return disp;
}

var _tempGiftIndex = -1;
// 선물 선택
function openGiftSelectionWindow(index) {
	_tempGiftIndex = index;
    //var myWindow = window.open("sub_select_gift.jsp", "selectGift", "width=500,height=500");
	//myWindow.document.write("<p>This is 'myWindow'</p><button onclick=\"window.opener.setHelper('Someone'); window.close();\">Set Helper</button>");
	var val = "";
	val += "LIST=" + "&";
	$.post("_api_gift.jsp", val)
	.fail(function(response) {
		$("#org").html(response.responseText);
	})
	.done(function(data) {
        console.log(data);
        var html = '';
        var index = 1;
        if (data.DONE != 1) {
            alert('목록을 가져오지 못했습니다.');
            return;
        }
        for (i in data.RESULT) {
            var item = data.RESULT[i];
            if (!item.EXPOSED) {
                continue;
            }
            html += "<tr class='even pointer'>";
			html += "<td>" + item.NUMBER + "</td>\n";
			html += "<td>" + item.NAME + "</td>\n";
			html += "<td>" + (item.QUANTITY - item.GONE) + "</td>\n";
			html += "<td>" + getTargetDisplay(item.TARGETS) + "</td>\n";
			html += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setGift(" + _tempGiftIndex + ", " + item.INDEX + ", '" + item.NAME + "')\">선택</a></td>\n";
			html += "</tr>\n";

            index += 1;
        }
		if (_tempGiftIndex != -1) {
			$("#gifts_" + _tempGiftIndex).html(html);
		}
		//smsURL = "localhost:8080/work/signin.jsp?INDEX=" + indexPreCustomer;
		//alert('[' + data.INDEX + ']');
		//alert('[' + smsURL + ']');
	});
}

function setGift(giftIndex/* 선물이 여러개 인 경우*/, index, name) {
	if (giftIndex == 1)
	{
		giftIndex1 = index;
		document.getElementById("GiftName1").value = name;
	}
	else if (giftIndex == 2)
	{
		giftIndex2 = index;
		document.getElementById("GiftName2").value = name;
	}
	//alert(name);
}

// 대여품 선택

function loadRentalList() {
    var val = '';
    val += 'LIST' + '&';
    $.post("_api_rental.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        var html = '';
        var index = 1;
        if (data.DONE != 1) {
            alert('목록을 가져오지 못했습니다.');
            return;
        }
        for (i in data.RESULT) {
        	var item = data.RESULT[i];
        	if (!item.EXPOSED) {
        		continue;
        	}
            html += "<tr>";
			html += "<td>" + item.NUMBER + "</td>\n";
			html += "<td>" + item.NAME + "</td>\n";
			html += "<td>" + (item.QUANTITY - item.RENTED) + "</td>\n";
			html += "<td>" + item.DESCRIPTION + "</td>\n";
			html += "<td><a class='btn btn-xs btn-primary' data-dismiss='modal' onclick=\"setRental(" + item.INDEX + ", '" + item.NAME + "')\">선택</a></td>\n";
            html += "</tr>";

            index += 1;
        }
        $("#rentalList").html(html);
    });
}

function setRental(index, name) {
	rentalIndex = index;
	document.getElementById("RentalName").value = name;
	//alert(name);
}

// 단말기 선택
function openTerminalSelectionWindow() {
    //var myWindow = window.open("sub_select_terminal.jsp", "selectTerminal", "width=500,height=500");
	//myWindow.document.write("<p>This is 'myWindow'</p><button onclick=\"window.opener.setHelper('Someone'); window.close();\">Set Helper</button>");
	var val = "";
	$.post("sub_select_terminal.jsp", val)
	.fail(function(response) {
		$("#org").html(response.responseText);
	})
	.done(function(data) {
		$("#terminals").html(data);
		//smsURL = "localhost:8080/work/signin.jsp?INDEX=" + indexPreCustomer;
		//alert('[' + data.INDEX + ']');
		//alert('[' + smsURL + ']');
	});
}

function setTerminal(index, name) {
	terminalIndex = index;
	document.getElementById("TerminalName").value = name;
	//alert(name);
}

function checkCare(type) {
	if (type === "family") {
		//document.getElementById("HelperName").checked;
		alert("FAMILY - " + document.getElementById("check_family").checked);
		if (document.getElementById("check_family").checked) {
			document.getElementById("care_family").innerHTML = "";
		} else {
			document.getElementById("care_family").innerHTML = "";
		}
	}
}

function jsonToDateString(json) {
	return json.YEAR + "-" + ((json.MONTH < 10) ? ('0' + json.MONTH) : json.MONTH) + "-" + ((json.DAY < 10) ? ('0' + json.DAY) : json.DAY);
}

class OverTime {
	constructor(date, hours) {
		this._date = date;
		this._hours = hours;
	}
}

function jsonDateToDateControl(obj) {
	var mon = ((obj.MONTH < 10) ? ('0' + obj.MONTH) : obj.MONTH);
	var day = ((obj.DAY < 10) ? ('0' + obj.DAY) : obj.DAY);
	return '' + obj.YEAR + "-" + mon + "-" + day;
}

function getDays(start, end) {
	console.log("START:" + start + ", END:" + end);
	var ret = 0;
	start = new Date(start);
	end = new Date(end);
	if (start > end)
		return 0;
	ret = parseInt((end - start) / (24 * 3600 * 1000));
	console.log("DAYS:" + ret);
	return ret;
}

//var _createdService = 0;

class CustomerService {
	constructor(index) {
//		this._index = _createdService;
//		_createdService++;

		this._index = index;
		this._indexService = -1;
		this._overtimes = [];

		this._serviceName = 'none';
		this._servicePeriod = 0;

		this._serviceStart = '';
		this._serviceEnd = '';

		this._serviceType = '';
		this._helper = -1;
		this._helperName = '';

		this._careChange = '';
		this._additionalCare = '';
		this._extended = '';

		this._type = ''; // for basic
		this._cost = 0;
	}

	fillCost() {
		var ret = "<div class='row'>";

		this._cost = 0;
		ret += "<div class='col-md-6 col-sm-6'>";
		if (this._index == 0) {
			ret += "기본";
		} else {
			ret += "연장";
		}
		var service = $("#SERVICE_NAME_" + this._index).val();
		var serviceKey = service;
		var type = $("input[name='SERVICE_TYPE_" + this._index + "']:checked").val();
		var days = $("input[name='SERVICE_DAYS_" + this._index + "']:checked").val();
		var serviceCost = 0;
		var servicePeriod = $("#SERVICE_PERIOD_" + this._index).val();
		ret += " : <span class='label label-success'>" + getServiceName(service) + "</span> ";

		ret += "<span class='label label-success'>" + getServicePeriodDisp(servicePeriod) + "</span> ";

		for (var idx in serviceNames) {
			if (serviceNames[idx][0] == service) {
				if (serviceNames[idx][2].search("I") >= 0) {
					ret += "<span class='label label-success'>";
					if (type == "inhouse") {
						ret += "입주";
						serviceKey += "(I)";
					}
					if (type == "commute") {
						ret += "출퇴근";
						serviceKey += "(C)";
					}
					if (type == "mixed") {
						ret += "입주+출퇴근";
					}
					ret += "</span> ";
				}
				break;
			}
		}
		ret += "<span class='label label-success'>주" + days + "일</span>";
		ret += "</div>";
		ret += "<div class='col-md-6 col-sm-6'>";
		serviceCost += getServiceCost(serviceKey, servicePeriod, 'RESERVED');
		serviceCost += getServiceCost(serviceKey, servicePeriod, 'BALANCE(' + days + ')');
		ret += serviceCost + "원";
		this._cost += serviceCost;
		ret += "</div>";

		ret += "<div class='col-md-6 col-sm-6'>";
		ret += "옵션 : ";
		var extra = 0;
		var days = 0;
		if ($('#CARE_FAMILY_' + this._index).is(':checked')) {
			ret += "<span class='label label-success'>미취학아동</span>";
			days = getDays($("#CARE_FAMILY_START_" + this._index).val(), $("#CARE_FAMILY_END_" + this._index).val());
			extra += days * getExtendedCost(type, 'noschool');
		}
		if ($('#CARE_SCHOOL_' + this._index).is(':checked')) {
			ret += "<span class='label label-success'>취학아동</span>";
			days = getDays($("#CARE_SCHOOL_START_" + this._index).val(), $("#CARE_SCHOOL_END_" + this._index).val());
			extra += days * getExtendedCost(type, 'school');
		}
		if ($('#CARE_ADDITIONAL_' + this._index).is(':checked')) {
			ret += "<span class='label label-success'>추가가족</span>";
			days = getDays($("#CARE_ADDITIONAL_START_" + this._index).val(), $("#CARE_ADDITIONAL_END_" + this._index).val());
			extra += days * getExtendedCost(type, 'family');
		}
		if ($('#CARE_TWIN_' + this._index).is(':checked')) {
			ret += "<span class='label label-success'>쌍둥이케어</span>";
			days = getDays($("#CARE_TWIN_START_" + this._index).val(), $("#CARE_TWIN_END_" + this._index).val());
			extra += days * getExtendedCost(type, 'twin');
		}
		ret += "<br/>";
		ret += "</div>";

		ret += "<div class='col-md-6 col-sm-6'>";
		ret += extra + "원";
		this._cost += extra;
		ret += "</div>";

		ret += "<div class='col-md-6 col-sm-6'>";
		ret += "추가근무 : ";
		ret += "</div>";
		ret += "<div class='col-md-6 col-sm-6'>";
		extra = 0;
		for (var index in this._overtimes) {
			extra += getOvertimeCost(service, type, this._overtimes[index]._hours);
		}
		ret += extra + "원";
		this._cost += extra;
		ret += "</div>";
		ret += "</div>";

		ret += "</div>";

		return ret;
	}

	readFromControl() {
		var str;
		//var days;

		console.log("readFromControl - " + this._index);
		this._serviceName = $("#SERVICE_NAME_" + this._index).val();
		//this._serviceName = $('#SERVICE_NAME_' + this._index + ' option');//$("#SERVICE_NAME_" + this._index).val();
		this._servicePeriod = $("#SERVICE_PERIOD_" + this._index).val();
		this._helperName = $("#HelperName_" + this._index).val();
		console.log("check - 1 - readFromControl - " + this._index);

		this._serviceStart = $("#SERVICE_START_DATE_" + this._index).val();
		this._serviceEnd = $("#SERVICE_END_DATE_" + this._index).val();
		console.log("check - 2 - readFromControl - " + this._index);
		//this._serviceType = $("input[name='SERVICE_TYPE_" + this._index + "']:checked").val();
		str = $("input[name='SERVICE_TYPE_" + this._index + "']:checked").val() + "_";
		//alert(this._serviceType);
		//if ((type != undefined) && (type != null)) {
		str += $("input[name='SERVICE_DAYS_" + this._index + "']:checked").val() + "_";

		str += $("#INHOUSE_DATE_" + this._index).val() + "_";
		//str += $("input[name='SERVICE_MIXED_INHOUSE_" + this._index + "']:checked").val() + "_";
		str += $("#COMMUTE_DATE_" + this._index).val();// + "_";
		//str += $("input[name='SERVICE_MIXED_COMMUTE_" + this._index + "']:checked").val();
		this._serviceType = str;
		//}

		this._careChange = $("#CARE_CHANGE_" + this._index).val();
		console.log("check - 3 - readFromControl - " + this._index);

		str = "";
		if ($('#CARE_FAMILY_' + this._index).is(':checked')) {
			str += 'T';
			str += "_" + $("#CARE_FAMILY_START_" + this._index).val() + "_" + $("#CARE_FAMILY_END_" + this._index).val() + "_";
		} else {
			str += 'F';
			str += "___";
		}
		//if (document.getElementById("CARE_SCHOOL_" + this._index).checked) {
		if ($('#CARE_SCHOOL_' + this._index).is(':checked')) {
			str += 'T';
			str += "_" + $("#CARE_SCHOOL_START_" + this._index).val() + "_" + $("#CARE_SCHOOL_END_" + this._index).val() + "_";
		} else {
			str += 'F';
			str += "___";
		}
		//if (document.getElementById("CARE_ADDITIONAL_" + this._index).checked) {
		if ($('#CARE_ADDITIONAL_' + this._index).is(':checked')) {
			str += 'T';
			str += "_" + $("#CARE_ADDITIONAL_START_" + this._index).val() + "_" + $("#CARE_ADDITIONAL_END_" + this._index).val() + "_";
		} else {
			str += 'F';
			str += "___";
		}
		//if (document.getElementById("CARE_TWIN_" + this._index).checked) {
		if ($('#CARE_TWIN_' + this._index).is(':checked')) {
			str += 'T';
			str += "_" + $("#CARE_TWIN_START_" + this._index).val() + "_" + $("#CARE_TWIN_END_" + this._index).val();
		} else {
			str += 'F';
			str += "__";
		}
		this._additionalCare = str;

		str = $("#MASSAGE_COUNT_" + this._index).val() + "_";
		str += $("#MASSAGE_DATE_" + this._index).val() + "_";
		str += $("#NURSE_COUNT_" + this._index).val() + "_";
		str += $("#NURSE_DATE_" + this._index).val() + "_";
		str += $("#DISINFECT_COUNT_" + this._index).val() + "_";
		str += $("#DISINFECT_DATE_" + this._index).val();
		this._extended = str;
	}

	setToControl() {
		var vals;
		var idx;
		//var type;

		console.log("setToControl - " + this._index);
		$("#SERVICE_NAME_" + this._index).val(this._serviceName);
		onChangeService(this._index);
		$("#SERVICE_PERIOD_" + this._index).val(this._servicePeriod);

		//$("#SERVICE_START_DATE_" + this._index).val("2018-07-04");
		//alert(jsonToDateString(this._serviceStart));
		$("#SERVICE_START_DATE_" + this._index).val(jsonDateToDateControl(this._serviceStart));
		$("#SERVICE_END_DATE_" + this._index).val(jsonDateToDateControl(this._serviceEnd));

		//setHelper(this._index, this._helper, this._helperName);
		getService(this._index)._helper = this._helper;
		getService(this._index)._helperName = this._helperName;
		//helperIndex = index;
		$("#HelperName_" + this._index).val(this._helperName);
		//document.getElementById("HelperName_" + serviceIndex).value = this._helperName;

		$("#CARE_CHANGE_" + this._index).val(this._careChange);

		vals = this._serviceType.split("_");
		$("input[name='SERVICE_TYPE_" + this._index + "'][value='" + vals[0] + "']").prop('checked', true);
		$("input[name='SERVICE_DAYS_" + this._index + "'][value='" + vals[1] + "']").prop('checked', true);
		$("#INHOUSE_DATE_" + this._index).val(vals[2]);
		//$("input[name='SERVICE_MIXED_INHOUSE_" + this._index + "'][value='" + vals[3] + "']").prop('checked', true);
		$("#COMMUTE_DATE_" + this._index).val(vals[3]);
		//$("input[name='SERVICE_MIXED_COMMUTE_" + this._index + "'][value='" + vals[5] + "']").prop('checked', true);
		//$("#SERVICE_TYPE_" + this._index).val(this._serviceType);

		vals = this._additionalCare.split("_");
		idx = 0;
		$("#CARE_FAMILY_" + this._index).prop('checked', (vals[idx++] == 'T') ? true : false);
		$("#CARE_FAMILY_START_" + this._index).val(vals[idx++]);
		$("#CARE_FAMILY_END_" + this._index).val(vals[idx++]);

		$("#CARE_SCHOOL_" + this._index).prop('checked', (vals[idx++] == 'T') ? true : false);
		$("#CARE_SCHOOL_START_" + this._index).val(vals[idx++]);
		$("#CARE_SCHOOL_END_" + this._index).val(vals[idx++]);
		$("#CARE_ADDITIONAL_" + this._index).prop('checked', (vals[idx++] == 'T') ? true : false);
		$("#CARE_ADDITIONAL_START_" + this._index).val(vals[idx++]);
		$("#CARE_ADDITIONAL_END_" + this._index).val(vals[idx++]);
		$("#CARE_TWIN_" + this._index).prop('checked', (vals[idx++] == 'T') ? true : false);
		$("#CARE_TWIN_START_" + this._index).val(vals[idx++]);
		$("#CARE_TWIN_END_" + this._index).val(vals[idx++]);

		vals = this._extended.split("_");
		if (vals.length > 1) {
			console.log("============================" + vals.length);
			$("#MASSAGE_COUNT_" + this._index).val(vals[0]);
			$("#MASSAGE_DATE_" + this._index).val(vals[1]);
			$("#NURSE_COUNT_" + this._index).val(vals[2]);
			$("#NURSE_DATE_" + this._index).val(vals[3]);
			$("#DISINFECT_COUNT_" + this._index).val(vals[4]);
			$("#DISINFECT_DATE_" + this._index).val(vals[5]);
		}
	}

	fromJSON(json) {
		this._indexService = json.SERVICE_INDEX;
		var items = json.ADDITIONAL_OVERTIME.split("_");
		this._overtimes = [];
		for (var i in items) {
			if (items[i].length < 5) {
				continue;
			}
			var item = items[i].split(" ");
			this._overtimes.push(new OverTime(item[0], item[1]));
		}

		this._serviceName = json.SERVICE_NAME;
		this._servicePeriod = json.SERVICE_PERIOD;

		if (json.hasOwnProperty('SERVICE_START')) {
			this._serviceStart = json.SERVICE_START;
		}
		if (json.hasOwnProperty('SERVICE_END')) {
			this._serviceEnd = json.SERVICE_END;
		}

		this._serviceType = json.SERVICE_TYPE;
		this._helper = json.HELPER;
		this._helperName = json.HELPER_NAME;
		if (json.hasOwnProperty('CARE_CHANGE')) {
			this._careChange = json.CARE_CHANGE;
		}

		this._additionalCare = json.ADDITIONAL_CARE;
		this._extended = json.EXTENDED;
	}

	toPostQuery() {
		var str = '';
		var index;

		//str += 'SERVICE_INDEX=' + this._index + '&';
		str += 'SERVICE_INDEX=' + this._indexService + '&';
		str += 'CUSTOMER_INDEX=' + _indexCustomer + '&';
		str += 'OVERTIME=';
		for (index in this._overtimes) {
			str += this._overtimes[index]._date + " " + this._overtimes[index]._hours + "_";
		}
		str += '&';
		str += 'SERVICE_NAME=' + this._serviceName + '&';
		str += 'SERVICE_PERIOD=' + this._servicePeriod + '&';
		str += 'START_DATE=' + this._serviceStart + '&';
		str += 'END_DATE=' + this._serviceEnd + '&';
		str += 'SERVICE_TYPE=' + this._serviceType + '&';
		str += 'HELPER=' + this._helper + '&';
		str += 'CARE_CHANGE=' + this._careChange + '&';
		str += 'ADDITIONAL_CARE=' + this._additionalCare + '&';
		str += 'EXTENDED=' + this._extended + '&';

		//alert(str);
		return str;
	}

	saveServer() {
		var val = '';

		this.readFromControl();

		val += 'SET=&';
		val += 'REFERENCE_INDEX=' + this._index + '&';
		val += this.toPostQuery();
		/*
		val += 'PETS=' + getPets() + '&';
		val += 'MEMO=' + base64.encode($("#COUNSEL_CONTENT").val()) + '&';
		//val += 'BABIES=' + b64EncodeUnicode() + '&';
		if (recommenderIndex != -1) val += 'RECOMMEND_INDEX=' + recommenderIndex + '&';
		if (rentalIndex != -1) val += 'RENTAL_INDEX=' + rentalIndex + '&';
		if (giftIndex != -1) val += 'GIFT_INDEX=' + giftIndex + '&';
		if (terminalIndex != -1) val += 'TERMINAL_INDEX=' + terminalIndex + '&';
		val += $("#formData").serialize();
		//alert(val);

		//$.post("_consult_update.jsp", val)
		*/
		//$.post("_test.jsp", val)
		$.post("_api_customer_service.jsp", val)
		.fail(function(response) {
			//alert('Error: ' + response.responseText);
			document.getElementById("org").innerHTML = response.responseText;
		})
		.done(function(data) {
			if (data.REFERENCE != -1) {
				console.log('BEFORE:' + _services[data.REFERENCE]._indexService);
				if (data.RESULT != -1) {
					_services[data.REFERENCE]._indexService = data.RESULT;
				}
				console.log('AFTER:' + _services[data.REFERENCE]._indexService);
				//alert('done');
				//location.reload();
				//window.location.href = 'content_branch_list.jsp';
			}
		});
	}
}

var _services = [];

/*
function OverTime(date, hours) {
	this._date = date;
	this._hours = hours;
}
*/

//var _overtimes = [];

function getService(serviceIndex) {
	var ret;

	//console.log(getService.caller + " - INDEX:" + serviceIndex);
	console.log(_services);
/*
	for (i in _services) {
		if (_services[i]._index == serviceIndex) {
			ret = _services[i];
		}
	}
	return ret;
*/
	return _services[serviceIndex];
}

function getDelOverTimeButton(serviceIndex, index) {
	//var ret = "<button onclick='delOverTime(" + serviceIndex + "," + index + ")' type='button'>-</button>";
	var ret = "<a class='btn btn-xs btn-danger' onclick='delOverTime(" + serviceIndex + "," + index + ")'>삭제</a>";
	return ret;
}

function addOverTime(serviceIndex) {
	var date = document.getElementById("OVERTIME_DATE_" + serviceIndex).value;
	var hours = document.getElementById("OVERTIME_HOURS_" + serviceIndex).value;

	if (date.length == 0) {
		alert('날짜를 지정해 주세요.');
		return;
	}
	if (hours.length == 0) {
		alert('초과근무한 시간을 입력해 주세요.');
		return;
	}
	var item = new OverTime(date, hours);
	getService(serviceIndex)._overtimes.push(item);
	//_overtimes.push(item);
	drawOverTimes(serviceIndex);
}

function delOverTime(serviceIndex, index) {
	getService(serviceIndex)._overtimes.splice(index, 1);
	drawOverTimes(serviceIndex);
}

function drawOverTimes(serviceIndex) {
	var index;
	var gender;
	var html = "";
	var temp;

	//console.log(drawOverTimes.caller + " - SERVICE_INDEX:" + serviceIndex);
	if (serviceIndex == -1)
		return;
	var service = getService(serviceIndex);
	if (service._overtimes.length == 0) {
		$("#OVERTIMES_" + serviceIndex).html("초과근무 없음");
		return;
	}
	for (index = 0; index < service._overtimes.length; index++) {
		temp = "";
		temp += "<li><div class='block'><div class='tags'><a class='tag'><span>";
		temp += service._overtimes[index]._date;
		temp += "</span></a></div><div class='block_content'><h2 class='title'>";
		if (service._overtimes[index]._hours[0] == 'H') {
			temp += '휴일근무/초과 ';
			temp += service._overtimes[index]._hours.substring(1) + "시간 ";
		} else {
			temp += '초과 ';
			temp += service._overtimes[index]._hours + "시간 ";
		}
		temp += getDelOverTimeButton(serviceIndex, index) + "";
		temp += "</h2></div></div></li>";

		html += temp;
		//html += service._overtimes[index]._date + " " + service._overtimes[index]._hours + " 시간 초과근무 " + getDelOverTimeButton(serviceIndex, index) + "<br>";
	}
	$("#OVERTIMES_" + serviceIndex).html(html);
	calculateCost();
}

function getPets() {
	var cat = $("#PET_CAT_COUNT").val();
	var bird = $("#PET_BIRD_COUNT").val();
	var dog = $("#PET_DOG_COUNT").val();
	var etc = $("#PET_ETC_COUNT").val();

	if (cat.length == 0)
		cat = 0;
	if (bird.length == 0)
		bird = 0;
	if (dog.length == 0)
		dog = 0;
	if (etc.length == 0)
		etc = 0;

	return cat + ' ' + bird + ' ' + dog + ' ' + etc;
}

function setPets(str) {
	var pets = str.split(" ");
	$("#PET_CAT_COUNT").val(pets[0]);
	$("#PET_BIRD_COUNT").val(pets[1]);
	$("#PET_DOG_COUNT").val(pets[2]);
	$("#PET_ETC_COUNT").val(pets[3]);
}

var _service = '';
//var _serviceCount = 0;

//var _serviceList = [];

function makeIndex(index) {
	var temp = _service.replace(/<CS_INDEX>/g,  index);
	//_services.push();
	//alert(temp);
	return temp;
}

//var _postFunc = null;

function loadCustomerServices() {
	var service;
	var index = -1;
	var val = '';

	//val += 'ADD=' + _indexCustomer + '&';
	val += 'GET=' + _indexCustomer + '&';
	val += 'CUSTOMER_INDEX=' + _indexCustomer;

	$.post("_api_customer_service.jsp", val)
	.fail(function(response) {
		alert('Error: ' + response.responseText);
		document.getElementById("error").innerHTML = response.responseText;
		//data = response.responseText;
	})
	.done(function(data) {
		/*
		index = data.INDEX;
		alert('len:' + data.TEST.length);
		for (i in data.TEST) {
			alert('val:' + i + ':' + data.TEST[i]);
		}
		//alert('done');
		//location.reload();
		//window.location.href = 'content_branch_list.jsp';
		if (index != -1) {
			document.getElementById("org").innerHTML += makeIndex(index);
		}
		*/
		if (data.LIST.length == 0) {
			addCustomerService_forDummy();
		}
		for (var i in data.LIST) {
			index = data.LIST[i].SERVICE_INDEX;
			document.getElementById("org").innerHTML += makeIndex(i);

			service = new CustomerService(i);
			service.fromJSON(data.LIST[i]);
			//service.setToControl();
			_services.push(service);

			//drawOverTimes(index);
		}
		for (i in _services) {
			_services[i].setToControl();
			//document.getElementById("org").innerHTML += makeIndex(index);

			//service = new CustomerService(index);
			//service.fromJSON(data.LIST[i]);
			//service.setToControl();
			//_services.push(service);

			drawOverTimes(i);
		}
		calculateCost();
	});
}

function addCustomerService_forDummy() {
	var service;

	console.log("addCustomerService_forDummy");
	for (i in _services) {
		_services[i].readFromControl();
	}
	document.getElementById("org").innerHTML += makeIndex(_services.length);
	for (i in _services) {
		_services[i].setToControl();
	}
	//$("#org").html($("#org").html() + makeIndex(_services.length));
	service = new CustomerService(_services.length);
	_services.push(service);
	/*
	var index = -1;
	var val = '';

	val += 'ADD=' + _indexCustomer + '&';
	val += 'CUSTOMER_INDEX=' + _indexCustomer;

	$.post("_api_customer_service.jsp", val)
	.fail(function(response) {
		alert('Error: ' + response.responseText);
		document.getElementById("error").innerHTML = response.responseText;
		//data = response.responseText;
	})
	.done(function(data) {
		index = data.INDEX;
		//alert('done');
		//location.reload();
		//window.location.href = 'content_branch_list.jsp';
		if (index != -1) {
			//document.getElementById("org").innerHTML += makeIndex(_services.length);
			$("#org").html($("#org").html() + makeIndex(_services.length));
			//document.getElementById("org").innerHTML += makeIndex(index);

			service = new CustomerService(index);
			_services.push(service);
		}
	});
	*/
	calculateCost();
}

var _servicePeriods = [
	[ '1W', '1주' ],
	[ '2W', '2주' ],
	[ '3W', '3주' ],
	[ '4W', '4주' ],
	[ 'C4', '출퇴근 4주' ],
	[ 'I4', '입주 4주' ],
	[ 'I2C2', '입주 2주 + 출퇴근 2주' ]
];

function getServicePeriodDisp(val) {
	var ret = '';

	for (var idx in _servicePeriods) {
		if (_servicePeriods[idx][0] == val) {
			ret = _servicePeriods[idx][1];
			break;
		}
	}

	return ret;
}

function addCheckedPayment(serviceType, paymentType, payedCost) {
	var service;
	var index = -1;
	var val = '';

	val += 'ADD&';
	val += 'CUSTOMER_INDEX=' + _indexCustomer + '&';
	val += 'SERVICE_TYPE=' + serviceType + '&';
	val += 'PAYMENT_TYPE=' + paymentType + '&';
	val += 'PAYED_COST=' + payedCost + '&';
	val += 'MEMBER_INDEX=' + _memberIndex + '&';

	$.post("_api_payment.jsp", val)
	.fail(function(response) {
		alert('Error: ' + response.responseText);
		document.getElementById("error").innerHTML = response.responseText;
		//data = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		calculateCost();
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
		alert('Error: ' + response.responseText);
		document.getElementById("error").innerHTML = response.responseText;
		//data = response.responseText;
	})
	.done(function(data) {
		console.log(data);
		var payed = 0;
		var discount = 0;
		for (var i in data.RESULT) {
			if (data.RESULT[i].SERVICE_TYPE == "discount")
				discount += data.RESULT[i].PAYED_COST;
			else
				payed += data.RESULT[i].PAYED_COST;
		}
		$("#CostPayed").html(payed + "원");
		$("#CostDiscount").html(discount + "원");
		var balance = _totalCost - discount - _voucherSupport - payed;
		$("#CostBalance").html(balance + "원");
		//calculateCost();
		_customerPayed = payed;
		_customerCost = _totalCost;
		_customerDiscount = discount;
		_customerVoucher = _voucherSupport;
	});
}

function b64EncodeUnicode(str) {
	return btoa(str);
    // first we use encodeURIComponent to get percent-encoded UTF-8,
    // then we convert the percent encodings into raw bytes which
    // can be fed into btoa.
    return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g,
        function toSolidBytes(match, p1) {
            return String.fromCharCode('0x' + p1);
    }));
}

function b64DecodeUnicode(str) {
	return atob(str);
    // Going backwards: from bytestream, to percent-encoding, to original string.
    return decodeURIComponent(atob(str).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
}

