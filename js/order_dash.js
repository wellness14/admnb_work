
//var _nDays = 1;
var _cheduledJobs = [];

function _runScheduler() {
	var next = _cheduledJobs.pop();
	if (next) {
		next();
	}
}

function _addScheduler(func) {
	_cheduledJobs.push(func);
}

function loadOrderStats(days) {
	var val = '';
	val += 'DASH' + '&';
	val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		var item = data.RESULT.DASH.ORDER_COUNTS;
		$("#DEPOSIT_STANDBY").html(item.DEPOSIT_STANDBY);
		$("#DEPOSIT_DONE").html(item.DEPOSIT_DONE);
		$("#CONTRACT_CANCEL").html(item.CONTRACT_CANCEL);
		$("#REFUND_DONE").html(item.REFUND_DONE);
		$("#SERVICE_STANDBY").html(item.SERVICE_STANDBY);
		$("#IN_SERVICE").html(item.IN_SERVICE);
		$("#SERVICE_EXTENDED").html(item.SERVICE_EXTENDED);
		$("#SERVICE_DONE").html(item.SERVICE_DONE);
		/*
		for (i in data.RESULT) {
			var item = data.RESULT[i];
			html += "<tr class='even pointer'>";
			html += "<td>" + index + "</td>";
			html += "<td>" + item.NUMBER + "</td>";
			html += "<td><img src='images/picture.jpg' alt='선물이미지' class='gift-img'></td>";
			html += "<td>" + item.NAME + "</td>";
			html += "<td>" + item.PRICE + "</td>";
			html += "<td>" + item.QUANTITY + "</td>";
			html += "<td>" + item.REGISTERED + "</td>";
			if (item.EXPOSED) {
				html += "<td><span class='label title label-success'>" + "노출중" + "</span></td>";
			} else {
				html += "<td><span class='label title label-warning'>" + "사용되지 않음" + "</span></td>";
			}
			html += "<td><a class='btn btn-primary btn-xs' onclick='editGift(" + item.INDEX + ")'>수정</a></td>";
			html += "<td><a class='btn btn-danger btn-xs' onclick='deleteGift(" + item.INDEX + ")'>삭제</a></td>";
			html += "<td class='last'>" + getTargetDisplay(item.TARGETS) + "</td>";
			html += "</tr>";

			index += 1;
		}
		*/
		//$("#giftList").html(html);
		_runScheduler();
	});
}

function loadConsultStats(days) {
	var val = '';
	val += 'DASH' + '&';
	val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		console.log(data);
		var res = data.RESULT;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		var item = res.DASH.CONSULT_STATS;
		$("#PHONE").html(item.PHONE);
		$("#CARECENTER").html(item.CARECENTER);
		$("#WEB").html(item.WEB);
		$("#BLOG").html(item.BLOG);
		$("#EXHIBITION").html(item.EXHIBITION);
		$("#SEARCH").html(item.SEARCH);
		$("#VOUCHER").html(item.VOUCHER);
		$("#RECOMMEND").html(item.RECOMMEND);
		_runScheduler();
	});
}

function loadStats(days) {
	var val = '';
	val += 'DASH' + '&';
	val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		////alert('Error: ' + response.responseText);
		console.log('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		var item = res.DASH.STATUS;
		$("#STATS_TOTAL_SALES").html(item.TOTAL_SALES);
		$("#STATS_BRANCH_SALES").html(item.BRANCH_SALES);
		$("#STATS_CONTRACT_COUNT").html(item.CONTRACT_COUNT);
		$("#STATS_NEW_CUSTOMER").html(item.NEW_CUSTOMER);
		//$("#STATS_DORMANT_CUSTOMER").html(item.DORMANT_CUSTOMER);
		res = item.DAILY_STATS;
		for (var i in res) {
			item = res[i];
			if ((index % 2) == 1) {
				html += "<tr class='even pointer'>";
			} else {
				html += "<tr class='odd pointer'>";
			}
			//html += "	<a data-toggle='modal' data-target='.view-notice' onclick='getNotice(" + item.INDEX + ")'>";
			//html += "	<span class='label label-warning'>new</span>";
			html += "<td class=' '>" + item.DATE + "</td>";
			html += "<td class=' '>" + item.DAILY_SALES + "</td>";
			html += "<td class=' '>" + item.DAILY_BRANCH_SALES + "</td>";
			html += "<td class=' '>" + item.REFUND + "</td>";
			html += "</tr>";

			index += 1;
		}
		$("#STATS_DAILY_STATS").html(html);
		_runScheduler();
	});
}

/*
 *  Notice
 */
function loadNoticeList() {
	var val = '';
	val += 'NOTICE_LIST' + '&';
	//val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		for (var i in res) {
			var item = res[i];
			html += "<tr>";
			html += "<td>";
			html += "	<a data-toggle='modal' data-target='.view-notice' onclick='getNotice(" + item.INDEX + ")'>";
			//html += "	<span class='label label-warning'>new</span>";
			html += item.TITLE;
			html += "	</a>";
			html += "</td>";
			html += "<td>" + item.MEMBER_NAME + "</td>";
			html += "<td>" + item.COMPOSED + "</td>";
			html += "</tr>";

			index += 1;
		}
		$("#NOTICE_LIST").html(html);
		_runScheduler();
	});
}

function getNotice(index) {
	var val = '';
	val += 'GET_NOTICE' + '&';
	val += 'NOTICE_INDEX=' + index + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		console.log(data);
		var res = data.RESULT.NOTICE;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		$("#NOTICE_HEADER").html(res.TITLE + " <small class='label label-danger' id='NOTICE_AUTHER'>" +
			res.MEMBER_NAME + "님이 " + res.COMPOSED + "에 작성" + "</small>");
		//$("#NOTICE_AUTHER").html(res.MEMBER_NAME + "님이 " + res.COMPOSED + "에 작성");
		$("#NOTICE_CONTENTS_WRITTEN").html(getDecodedString(res.CONTENTS));
		_runScheduler();
	});
}

function addNotice(member, title, contents) {
	var val = '';
	val += 'ADD_NOTICE' + '&';
	val += 'MEMBER=' + member + '&';
	val += 'TITLE=' + title + '&';
	val += 'CONTENTS=' + contents + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		//$("#NOTICE_LIST").html(res.NOTICE_TITLE);
		//$("#NOTICE_AUTHER").html(res.NOTICE_AUTHER + "님이 작성");
		//$("#NOTICE_CONTENTS").html(res.NOTICE_CONTENTS);
		_runScheduler();
	});
}


/*
 *  Message
 */
function loadMessageList(member) {
	var val = '';
	val += 'MESSAGE_LIST' + '&';
	val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		var item = res.DASH.CONSULT_STATS;
		$("#PHONE").html(item.PHONE);
		$("#CARECENTER").html(item.CARECENTER);
		$("#WEB").html(item.WEB);
		$("#ETC").html(item.ETC);
		$("#EXHIBITION").html(item.EXHIBITION);
		$("#PROCEED").html(item.PROCEED);
		$("#VOUCHER").html(item.VOUCHER);
		$("#DONE").html(item.DONE);
		_runScheduler();
	});
}



/*
 *  Gift
 */
function loadGiftList(days) {
	var val = '';
	val += 'DASH' + '&';
	val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT.DASH.GIFT_LIST;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		renderGiftList(res);
		_runScheduler();
	});
}


/*
 *  Rental
 */
function loadRentalList(days) {
	var val = '';
	val += 'DASH' + '&';
	val += 'DAYS=' + days + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT.DASH.RENTAL_LIST;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		renderRentalList(res);
		_runScheduler();
	});
}



/*
 *  Milestone
 */
function loadMilestone(branchIndex) {
	var val = '';
	val += 'MILESTONE' + '&';
	val += 'BRANCH_INDEX=' + branchIndex + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		renderMilestone(res);
		_runScheduler();
	});
}


/*
 *  Schedule
 */
function addSchedule(member, receiver, scheduledTime, contents) {
	var val = '';
	val += 'ADD_SCHEDULE' + '&';
	val += 'MEMBER=' + member + '&';
	val += 'SCHEDULE_RECEIVER=' + receiver + '&';
	val += 'SCHEDULED_TIME=' + scheduledTime + '&';
	val += 'SCHEDULE_CONTENTS=' + contents + '&';
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		_runScheduler();
	});
}

function loadSchedule(member) {
	var val = '';
	val += 'GET_SCHEDULE' + '&';
	val += 'MEMBER=' + member + '&';
	val += 'SCHEDULED_TIME=' + getCurrentDateString() + '&';
	////alert(val);
	$.post("_api_dash_stats.jsp", val)
	.fail(function(response) {
		//alert('Error: ' + response.responseText);
		//document.getElementById("org").innerHTML = response.responseText;
	})
	.done(function(data) {
		//console.log(data);
		var res = data.RESULT.SCHEDULE_LIST;
		var html = '';
		var index = 1;
		if (data.DONE != 1) {
			//alert('목록을 가져오지 못했습니다.');
			return;
		}
		renderScheduleList(res);
		_runScheduler();
	});
}
