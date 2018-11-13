<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%
    List<Member> listMembers = UserDB.getMemberList();
    Iterator iter;
    Member member;

/*
    iter = listMembers.iterator();
    while (iter.hasNext())
    {
        Member member = (Member)iter.next();
    }
*/
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>마더앤베이비 관리자</title>

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
	<!-- PNotify -->
	<link href="./vendors/pnotify/dist/pnotify.css" rel="stylesheet">
	<link href="./vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
	<link href="./vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
	<!-- Custom Theme Style -->
	<link href="./build/css/custom.css" rel="stylesheet">
	<link href="./build/css/mystyle.css" rel="stylesheet">

	<script
	src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
    <script src="./js/base64.js"></script>
    <script src="./js/myutils.js"></script>
	<script src="./js/order_dash.js"></script>
	<script>
        var _members = [
        <%
            iter = listMembers.iterator();
            while (iter.hasNext())
            {
                member = (Member)iter.next();
        %>
                [<%= member._index %>, '<%= member._business %>'],
        <%
            }
        %>
        ];
		function onState(days) {
            loadStats(days);
		}

		function a() {
			loadOrderStats(1);
		}

		function b() {
			loadConsultStats(1);
		}

		function c() {
			loadNoticeList();
		}

        function d() {
            loadStats(1);
        }

        function e() {
            loadGiftList(1);
        }

        function f() {
            loadRentalList(1);
        }

        function g() {
            loadSchedule(<%= _user._index %>);
        }

        function renderGiftList(list) {
            var html = '';
            var index = 1;

            //console.log(list);
            for (var i in list) {
                var item = list[i];
                html += "<article class='media event'>";
                html += "<a class='pull-left date'><p class='day'>" + item.NUMBER + "</p></a>";
                html += "<div class='media-body'>";
                html += "   <a class='title'>" + item.NAME + "</a>";
                html += "   <p>" + item.PRESENTED + "개 증정</p>";
                html += "</div>";
                html += "</article>";

                index += 1;
            }
            $("#GIFT_LIST").html(html);
        }

        function renderRentalList(list) {
            var html = '';
            var index = 1;

            //console.log(list);
            for (var i in list) {
                var item = list[i];
                html += "<li class='media event'>";
                html += "<div class='media-body row'><h5><i class='fa fa-cube'></i>" + item.NAME + "</h5>";
                html += "<dl>";
                html += "   <dt>전체</dt><dd><span class='badge bg-purple'>" + item.TOTAL + "</span></dd>";
                html += "   <dt>반납예정</dt><dd><span class='badge bg-purple'>" + item.RETURN_SOON + "</span></dd>";
                html += "   <dt>대여중</dt><dd><span class='badge bg-purple'>" + item.RENTED + "</span></dd>";
                html += "   <dt>대여예정</dt><dd><span class='badge bg-purple'>" + item.RESERVED + "</span></dd>";
                html += "</dl>";
                html += "</div>";
                html += "</li>";

                index += 1;
            }
            $("#RENTAL_LIST").html(html);
        }

        function getMemberName(index) {
            for (var i in _members) {
                if (_members[i][0] == index) {
                    return _members[i][1];
                }
            }

            return "없음";
        }

        function renderScheduleList(list) {
            var html = '';
            var index = 1;

            console.log(list);
            for (var i in list) {
                var item = list[i];
                //console.log(item);
                html += "<li><p>";
                if (item.IS_PRIVATE) {
                    html += "<span class='label label-success'>개인일정</span>";
                } else {
                    html += "<span class='label label-warning'>공유받음 &middot; " + getMemberName(item.MEMBER) + "</span>";
                }
                html += item.CONTENTS;
                html += "</p>";
                html += "</li>";

                index += 1;
            }
            //alert(html);
            $("#SCHEDULE_LIST").html(html);

            var today = new Date();
            $("#SCHEDULE_COUNT").html((today.getMonth()+1) + "/" + today.getDate() + " " + list.length + "개의 일정이 있습니다.");
        }

		$(function() {
			_addScheduler(a);
			_addScheduler(b);
            _addScheduler(c);
            _addScheduler(d);
            _addScheduler(e);
            _addScheduler(f);
			_addScheduler(g);

            onPrivateSchedule();
			_runScheduler();
		});

        const SCHEDULE_RECEIVER_INIT = -2;
        const SCHEDULE_RECEIVER_ALL = -1;
        var _scheduleReceiver = SCHEDULE_RECEIVER_INIT;

        function onPrivateSchedule() {
            _scheduleReceiver = SCHEDULE_RECEIVER_INIT;
            $("#SCHEDULE_TYPE").html("개인일정 <span class='caret'></span>");
            document.getElementById("SCHEDULE_RECEIVERS_BOX").style.display = "none";
            //document.getElementById("SCHEDULE_TYPE").innerHTML = "개인일정";
        }

        function onSharedSchedule() {
            _scheduleReceiver = SCHEDULE_RECEIVER_ALL;
            $("#SCHEDULE_TYPE").html("공유일정 <span class='caret'></span>");
            document.getElementById("SCHEDULE_RECEIVERS_BOX").style.display = "block";
        }

        function initSchedule() {
            onPrivateSchedule();
            $("#SCHEDULE_CONTENTS").val('');
            $("#SCHEDULE_DATE").val('');
        }

        function setScheduleReceiver(val, disp) {
            _scheduleReceiver = val;
            $("#SCHEDULE_RECEIVERS_BOX").html(disp + " <span class='caret'></span>");
        }

        function onAddSchedule() {
            var date = $("#SCHEDULE_DATE").val();
            var contents = $("#SCHEDULE_CONTENTS").val();
            _addScheduler(g);
            addSchedule(<%= _user._index %>, _scheduleReceiver, date, contents);
        }

        function initNotice() {
            $("#NOTICE_CONTENTS").val('');
        }

        function onAddNotice() {
            var title = $("#NOTICE_TITLE").val();
            _addScheduler(c);
            addNotice(<%= _user._index %>, title, getEncodedString("NOTICE_CONTENTS"));
            initNotice();
        }

        function onCalcenNotice() {
            initNotice();
        }

	</script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
<%@ include file="home_menu_nav.jspf" %>

			<!-- page content -->
			<div class="right_col main_dash" role="main">
				<div class="">
					<div class="row">
						<!-- 주문관리 -->
						<div class="col-md-5 col-sm-5 col-xs-12">
							<div class="x_panel tile fixed_height_300">
								<div class="x_title">
									<h2>주문관리</h2>
									<div class="nav navbar-right panel_toolbox">
										<label>
											<input type="radio" name="contact_payment" onclick='loadOrderStats(1)' checked=true> 오늘
										</label>
										<label>
											<input type="radio" name="contact_payment" onclick='loadOrderStats(7)'> 7일
										</label>
										<label>
											<input type="radio" name="contact_payment" onclick='loadOrderStats(15)'> 15일
										</label>
										<label>
											<input type="radio" name="contact_payment" onclick='loadOrderStats(30)'> 1개월
										</label>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>입금대기</h3>
												<div class="count" id='DEPOSIT_STANDBY'>0</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>입금완료</h3>
												<div class="count" id='DEPOSIT_DONE'>0</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>계약취소신청</h3>
												<div class="count" id='CONTRACT_CANCEL'>0</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>환불완료</h3>
												<div class="count" id='REFUND_DONE'>0</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>서비스대기</h3>
												<div class="count" id='SERVICE_STANDBY'>0</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>서비스중</h3>
												<div class="count" id='IN_SERVICE'>0</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>서비스연장</h3>
												<div class="count" id='SERVICE_EXTENDED'>0</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>서비스완료</h3>
												<div class="count" id='SERVICE_DONE'>0</div>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>

						<!-- 상담/문의 -->
						<div class="col-md-4 col-sm-4 col-xs-12 main_dash">
							<div class="x_panel tile fixed_height_300">
								<div class="x_title">
									<h2>상담/문의</h2>
									<div class="nav navbar-right panel_toolbox">
										<label>
											<input type="radio" name="consult_inquiry" onclick='loadConsultStats(1)' checked=true> 오늘
										</label>
										<label>
											<input type="radio" name="consult_inquiry" onclick='loadConsultStats(7)'> 7일
										</label>
										<label>
											<input type="radio" name="consult_inquiry" onclick='loadConsultStats(15)'> 15일
										</label>
										<label>
											<input type="radio" name="consult_inquiry" onclick='loadConsultStats(30)'> 1개월
										</label>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content row consult-summary">
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
										다이렉트 전화상담
										<a href="#!" class="pull-right btn btn-sm btn-default" id='PHONE'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
										조리원을 통해
										<a href="#!" class="pull-right btn btn-sm btn-default" id='CARECENTER'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
										홈페이지 직접
										<a href="#!" class="pull-right btn btn-sm btn-default" id='WEB'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
										블로그를 통해
										<a href="#!" class="pull-right btn btn-sm btn-default" id='BLOG'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
										전시회를 통해
										<a href="#!" class="pull-right btn btn-sm btn-default" id='EXHIBITION'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
										검색을 통해
										<a href="#!" class="pull-right btn btn-sm btn-default" id='SEARCH'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
										바우처를 통해
										<a href="#!" class="pull-right btn btn-sm btn-default" id='VOUCHER'>
											0
										</a>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
										추천을 통해
										<a href="#!" class="pull-right btn btn-sm btn-default" id='RECOMMEND'>
											0
										</a>
									</div>
								</div>
								<a href="order_consult_new.jsp" class="btn btn-primary btn-new-consult">신규상담등록</a>
							</div>
						</div>

						<!-- 업무메모 -->
						<div class="col-md-3 col-sm-3 col-xs-12 main_memo">
							<div class="x_panel tile fixed_height_300">
								<div class="x_title">
									<h2>업무메모</h2>
									<div class="nav navbar-right panel_toolbox">
										<a href="#!" class="btn btn-danger btn-xs">전체삭제</a>
										<a href="#!" class="btn btn-primary btn-xs">저장</a>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<textarea name="" id="" placeholder="메모를 입력하세요."></textarea>
									<small>최종수정일 : 2018.03.26</small>
								</div>
							</div>
						</div>
					</div>

					<!-- 공지사항 / 업무쪽지 -->
					<div class="row">
						<div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<div class="x_panel main_notice">
								<div class="x_title">
									<h2>공지사항</h2>
									<div class="nav navbar-right panel_toolbox">
										<a class="btn btn-primary btn-xs" data-toggle="modal" data-target=".write-notice" onclick="initNotice()">공지사항 등록</a>
										<!-- 공지사항 등록 팝업 -->
										<div class="modal fade bs-example-modal-lg write-notice" tabindex="-1" role="dialog" aria-hidden="true">
											<div class="modal-dialog modal-lg">
												<div class="modal-content">
										
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">
															<span aria-hidden="true">×</span>
														</button>
														<h4 class="modal-title" id="myModalLabel">공지사항 등록하기</h4>
													</div>
													<div class="modal-body">
														<form action="">
															<div class="message-box">
                                                                
                                                                <input type="text" size="100" id="NOTICE_TITLE" placeholder="제목을 입력해 주세요">
                                                                <hr/>
																<textarea name="NOTICE_CONTENTS" id="NOTICE_CONTENTS" placeholder="내용을 입력해주세요."></textarea>
															</div>
														</form>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default btn-sm" data-dismiss="modal" onclick="onCancelNotice()">취소</button>
														<button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="onAddNotice()">등록</button>
													</div>
										
												</div>
											</div>
										</div>
										<!-- 공지사항 등록 팝업 -->
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<!-- 공지사항 내용보기 팝업 // -->
									<div class="modal fade bs-example-modal-lg view-notice" tabindex="-1" role="dialog" aria-hidden="true">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">
									
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">
														<span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">공지사항 내용보기</h4>
												</div>
												<div class="modal-body">
													<h4 id="NOTICE_HEADER"><!--<small class="label label-danger" id="NOTICE_AUTHER"></small>-->
													</h4>
													<hr>
													<p id="NOTICE_CONTENTS_WRITTEN"></p>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
												</div>
									
											</div>
										</div>
									</div>
									<!-- // 공지사항 내용보기 팝업 -->
									<table class="table table-hover">
										<colgroup>
											<col width="70%">
											<col width="15%">
											<col width="15%">
										</colgroup>
										<tbody id='NOTICE_LIST'>
                                            <!--
											<tr>
												<td><a data-toggle="modal" data-target=".view-notice"><span class="label label-warning">new</span>2018년 새해 전시회 참가일정입니다.</a></td>
												<td>정혜윤</td>
												<td>2018-01-01</td>
											</tr>
											<tr>
												<td><a href="#!">2018년 1월 3주차 산후건강관리사 교육 진행 계획</a></td>
												<td>정혜윤</td>
												<td>2018-12-31</td>
											</tr>
											<tr>
												<td><a href="#!">2018년 새해 전시회 참가일정입니다.</a></td>
												<td>정혜윤</td>
												<td>2018-01-01</td>
											</tr>
											<tr>
												<td>
													<a href="#!">2018년 1월 3주차 산후건강관리사 교육 진행 계획</a>
												</td>
												<td>정혜윤</td>
												<td>2018-01-01</td>
											</tr>
                                            -->
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
							<div class="x_panel main_notice">
								<div class="x_title">
									<h2>업무쪽지</h2>
									<div class="nav navbar-right panel_toolbox">
										<a href="#!" class="btn btn-primary btn-xs"  data-toggle="modal" data-target=".send-message">쪽지보내기</a>
										<!-- <a href="#!" class="btn btn-default btn-xs more">
											<i class="fa fa-plus more"></i>
										</a> -->
									</div>
									<div class="clearfix"></div>


									<!-- 쪽지보내기 팝업 -->
									<div class="modal fade bs-example-modal-lg send-message" tabindex="-1" role="dialog" aria-hidden="true">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">
									
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">
														<span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">쪽지보내기</h4>
												</div>
												<div class="modal-body">
													<form action="">
													<div class="btn-group">
														<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false" id="MESSAGE_BUTTON">전체(본사/지사전체)
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
													</div>
													<div class="message-box">
														<textarea name="" id="" placeholder="내용을 입력해주세요."></textarea>
													</div>
													</form>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
													<button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">보내기</button>
												</div>
									
											</div>
										</div>
									</div>
									<!-- 쪽지보내기 팝업 -->
								</div>
								<div class="x_content">
									<!-- 쪽지내용보기 팝업 // -->
									<div class="modal fade bs-example-modal-lg view-message" tabindex="-1" role="dialog" aria-hidden="true">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">
									
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">
														<span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">쪽지내용보기</h4>
												</div>
												<div class="modal-body">
													<h4>지원부탁드립니다. 
														<small class="label label-danger">강서지사님이 보냄</small>
													</h4>
													<hr>
													<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Sed nostrum minima quae reprehenderit molestiae ratione magni vero libero modi? Quas, perferendis atque expedita aspernatur provident sit voluptatem soluta consequuntur labore.</p>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
												</div>
									
											</div>
										</div>
									</div>
									<!-- // 쪽지내용보기 팝업 -->
									<table class="table table-hover">
										<colgroup>
											<col width="70%">
											<col width="15%">
											<col width="15%">
										</colgroup>
										<tbody>
											<tr>
												<td>
													<a href="#!" data-toggle="modal" data-target=".view-message"><span class="label label-warning">new</span>지원부탁드립니다.</a>
												</td>
												<td>강서지사</td>
												<td>2018-01-01</td>
											</tr>
											<tr>
												<td>
													<a href="#!">관리사님들 좀 더 </a>
												</td>
												<td>정혜윤</td>
												<td>2018-01-01</td>
											</tr>
											<tr>
												<td>
													<a href="#!">정산할떄 말이죠</a>
												</td>
												<td>정혜윤</td>
												<td>2018-01-01</td>
											</tr>
											<tr>
												<td>
													<a href="#!">지사관리 계획안</a>
												</td>
												<td>정혜윤</td>
												<td>2018-01-01</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<!-- 주요현황 -->
					<div class="row">
						<div class="col-md-8 col-sm-8 col-xs-12">
							<div class="x_panel tile fixed_height_645 major_status">
								<div class="x_title">
									<h2>주요현황</h2>
									<div class="nav navbar-right panel_toolbox">
										<label>
											<input type="radio" name="major_status" onclick='onState(1)' checked> 오늘
										</label>
										<label>
											<input type="radio" name="major_status" onclick='onState(7)' > 7일
										</label>
										<label>
											<input type="radio" name="major_status" onclick='onState(15)' > 15일
										</label>
										<label>
											<input type="radio" name="major_status" onclick='onState(30)' > 1개월
										</label>
										<div class="btn-group pull-right btn-app branch-view">
											<a data-toggle="dropdown" class="btn btn-default btn-sm dropdown-toggle" type="button" aria-expanded="false">지사별 보기
												<span class="caret"></span>
											</a>
											<ul role="menu" class="dropdown-menu">
												<li>
													<a href="#">전체</a>
												</li>
												<!--
												<li>
													<a href="#">강북/노원</a>
												</li>
												<li>
													<a href="#">구리/남양주</a>
												</li>
												<li>
													<a href="#">성동/광진</a>
												</li>
												-->
											</ul>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>전체매출현황(원)</h3>
												<div class="count" id="STATS_TOTAL_SALES">17</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>지사매출현황(원)</h3>
												<div class="count" id="STATS_BRANCH_SALES">17</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>계약(건)</h3>
												<div class="count" id="STATS_CONTRACT_COUNT">17</div>
											</div>
										</div>
										<div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>신규회원(명)</h3>
												<div class="count" id="STATS_NEW_CUSTOMER">17</div>
											</div>
										</div>
                                        <!--
										<div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
											<div class="tile-stats">
												<h3>휴면회원(명)</h3>
												<div class="count" id="STATS_DORMANT_CUSTOMER">17</div>
											</div>
										</div>
                                        -->
									</div>
									<div class="table-responsive">
										<table class="table table-striped jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th class="column-title">날짜</th>
													<th class="column-title">매출금액</th>
													<th class="column-title">지사매출</th>
													<th class="column-title">환불금액</th>
												</tr>
											</thead>
									
											<tbody id="STATS_DAILY_STATS">
                                                <!--
												<tr class="even pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="odd pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="even pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="odd pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="even pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="odd pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="even pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="odd pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
									
												<tr class="even pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
												<tr class="odd pointer">
													<td class=" ">2018.05.28</td>
													<td class=" ">1,510,000원</td>
													<td class=" ">750,000원</td>
													<td class=" ">0원</td>
												</tr>
                                                -->
											</tbody>
										</table>
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
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="x_panel tile fixed_height_645">
								<div class="x_title">
									<h2>출산선물 현황</h2>
									<div class="nav navbar-right panel_toolbox">
										<label>
											<input type="radio" name="iCheck" onclick="loadGiftList(1)" checked> 오늘
										</label>
										<label>
											<input type="radio" name="iCheck" onclick="loadGiftList(7)"> 7일
										</label>
										<label>
											<input type="radio" name="iCheck" onclick="loadGiftList(15)"> 15일
										</label>
										<label>
											<input type="radio" name="iCheck" onclick="loadGiftList(30)"> 1개월
										</label>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content" id="GIFT_LIST">
                                    <!--
									<article class="media event">
										<a class="pull-left date">
											<p class="day">1</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">2</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">3</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">4</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">5</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">6</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">7</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">8</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">9</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
									<article class="media event">
										<a class="pull-left date">
											<p class="day">10</p>
										</a>
										<div class="media-body">
											<a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
											<p>50000개 증정</p>
										</div>
									</article>
                                    -->
								</div>
							</div>
						</div>
					</div>

					<!-- 용품대여현황 -->
					<div class="row">
						<div class="col-md-8 col-sm-8 col-xs-12">
							<div class="x_panel tile fixed_height_500 major_schedule">
								<div class="x_title">
									<h2>주요일정</h2>
									<div class="nav navbar-right panel_toolbox">
					
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="col-lg-6 col-md-6 col-sm-6">
											<div id="calendar"></div>
										</div>
										<div class="col-lg-6 col-md-6 col-sm-6">
											<div class="x_panel todo-list">
												<div class="x_title">
													<small id="SCHEDULE_COUNT">03/21 일정이 없습니다.</small>
													<a class="pull-right add-todo btn-primary btn-xs btn"  data-toggle="modal" data-target=".add-schedule" onclick="initSchedule();">일정추가</a>
												</div>
												<!-- 쪽지보내기 팝업 -->
												<div class="modal fade bs-example-modal-lg add-schedule" tabindex="-1" role="dialog" aria-hidden="true">
													<div class="modal-dialog modal-lg">
														<div class="modal-content">
												
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">
																	<span aria-hidden="true">×</span>
																</button>
																<h4 class="modal-title" id="myModalLabel">일정추가</h4>
															</div>
															<div class="modal-body">
																<form action="">
																	<div class="btn-group">
																		<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false" id="SCHEDULE_TYPE">개인일정
																			<span class="caret"></span>
																		</button>
																		<ul role="menu" class="dropdown-menu">
																			<li>
																				<a onclick="onPrivateSchedule();">개인일정</a>
																			</li>
																			<li>
																				<a onclick="onSharedSchedule();">공유일정</a>
																			</li>
																		</ul>
																	</div>
																	<div class="btn-group" >
																		<button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false" id="SCHEDULE_RECEIVERS_BOX">모든사람에게
																			<span class="caret"></span>
																		</button>
																		<ul role="menu" class="dropdown-menu" id="SCHEDULE_RECEIVERS">
                                                                            <li>
                                                                                <a onclick="setScheduleReceiver(SCHEDULE_RECEIVER_ALL, '모든사람에게')">모든사람에게</a>
                                                                            </li>
                                                                            <%

                                                                            iter = listMembers.iterator();
                                                                            while (iter.hasNext())
                                                                            {
                                                                                member = (Member)iter.next();
                                                                            %>
                                                                            <li>
                                                                                <a onclick="setScheduleReceiver(<%= member._index %>, '<%= member._business %>')"><%= member._business %></a>
                                                                            </li>
                                                                            <%
                                                                            }
                                                                            %>
																		</ul>
																	</div>
																	<div class="btn-group">
																		<input type='date' id='SCHEDULE_DATE'/>
																	</div>
																	<div class="message-box">
																		<textarea name="SCHEDULE_CONTENTS" id="SCHEDULE_CONTENTS" placeholder="내용을 입력해주세요."></textarea>
																	</div>
																</form>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-default btn-sm" data-dismiss="modal" onclick="initSchedule()">취소</button>
																<button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="onAddSchedule()">일정추가</button>
															</div>
												
														</div>
													</div>
												</div>
												<!-- 쪽지보내기 팝업 -->

												<div class="x_content">
											
													<div class="">
														<ul class="to_do" id="SCHEDULE_LIST">
                                                            <!--
															<li>
																<p>
																	<span class="label label-success">개인일정</span>
																	산후도우미 교육
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	오늘 전시회 관련 미팅예정
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
															<li>
																<p>
																	<span class="label label-warning">공유받음 &middot; 서원우</span>
																	트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
																</p>
															</li>
                                                            -->
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-12 rent">
							<div class="x_panel tile fixed_height_500">
								<div class="x_title">
									<h2>서비스용품 대여현황</h2>
									<div class="nav navbar-right panel_toolbox">
										<label>
											<input type="radio" name="service_rent" onclick="loadRentalList(1)" checked> 오늘
										</label>
										<label>
											<input type="radio" name="service_rent" onclick="loadRentalList(7)"> 7일
										</label>
										<label>
											<input type="radio" name="service_rent" onclick="loadRentalList(15)"> 15일
										</label>
										<label>
											<input type="radio" name="service_rent" onclick="loadRentalList(30)"> 1개월
										</label>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<ul class="list-unstyled top_profiles scroll-view" id="RENTAL_LIST">
                                        <!--
										<li class="media event">
											<div class="media-body row">
												<h5>
													<i class="fa fa-cube"></i>
													적외선방사 피부관리기
                                                </h5>
												<dl>
													<dt>전체</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>반납예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여중</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
												</dl>
											</div>
										</li>
										<li class="media event">
											<div class="media-body row">
												<h5>
													<i class="fa fa-cube"></i>
													적외선방사 피부관리기</h5>
												<dl>
													<dt>전체</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>반납예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여중</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
												</dl>
											</div>
										</li>
										<li class="media event">
											<div class="media-body row">
												<h5>
													<i class="fa fa-cube"></i>
													적외선방사 피부관리기</h5>
												<dl>
												<dl>
													<dt>전체</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>반납예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여중</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
												</dl>
											</div>
										</li>
										<li class="media event">
											<div class="media-body row">
												<h5>
													<i class="fa fa-cube"></i>
													적외선방사 피부관리기</h5>
												<dl>
												<dl>
													<dt>전체</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>반납예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여중</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
												</dl>
											</div>
										</li>
										<li class="media event">
											<div class="media-body row">
												<h5>
													<i class="fa fa-cube"></i>
													적외선방사 피부관리기</h5>
												<dl>
												<dl>
													<dt>전체</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>반납예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여중</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
													<dt>대여예정</dt>
													<dd>
														<span class="badge bg-purple">80</span>
													</dd>
												</dl>
											</div>
										</li>
                                        -->
									</ul>
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
					Wellness Intelligence ADMIN PAGE Create by 
					- Spacemonkey
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
	<!-- bootstrap-daterangepicker -->
	<script src="./vendors/moment/min/moment.min.js"></script>
	<script src="./vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<script src="./vendors/jquery-ui-1.12.1.custom/datepicker-ko-KR.js"></script>
	<script src="./vendors/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
	
	<!-- iCheck -->
	<script src="./vendors/iCheck/icheck.min.js"></script>
	<!-- TweenMax -->
	<script src="./vendors/tweenmax/TweenMax.js"></script>
	<!-- PNotify -->
	<script src="./vendors/pnotify/dist/pnotify.js"></script>
	<script src="./vendors/pnotify/dist/pnotify.buttons.js"></script>
	<script src="./vendors/pnotify/dist/pnotify.nonblock.js"></script>
	<!-- Custom Theme Scripts -->
	<script src="./build/js/custom.min.js"></script>
</body>

</html>