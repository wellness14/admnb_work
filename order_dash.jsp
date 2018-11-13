<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 주문 대시보드</title>

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
    <script src="./js/order_dash.js"></script>
    <script>
        function renderGiftList(list) {
            var html = '';
            var index = 0;
            var isOpen = false;

            //console.log(list);
            for (var i in list) {
                var item = list[i];
                if ((index % 2) == 0) {
                    html += "<div class='row gift-rank'>";
                    isOpen = true;
                }
                html += "<div class='col-md-6 col-sm-6 col-xs-12'><article class='media event'>";
                html += "<a class='pull-left date'><p class='day'>" + item.NUMBER + "</p></a>";
                html += "<div class='media-body'>";
                html += "   <a class='title'>" + item.NAME + "</a>";
                html += "   <p>" + item.PRESENTED + "개 증정</p>";
                html += "</div>";
                html += "</article></div>";
                if ((index % 2) == 1) {
                    html += "</div>";
                    isOpen = false;
                }

                index += 1;
            }
            if (isOpen) {
                html += "</div>";
                isOpen = false;
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

        var dates = [];
        function renderMilestone(data) {
            var html = '';
            var index = 1;

            //console.log(list);
            html += "<tr><th>지사</th><th class='second'>산모</th>";
            for (var i in data.DATES) {
                var item = data.DATES[i];
                html += "<td>";
                if (item.IS_TODAY) {
                    html += "<span class='label label-success today'>" + item.DATE + "</span>";
                } else {
                    html += item.DATE;
                }
                dates.push(item.DATE);
                html += "</td>";

                index += 1;
            }
            html += "</tr>";

            for (var iCust in data.CUSTOMERS) {
                var customer = data.CUSTOMERS[iCust];
                var events = customer.EVENTS;
                html += "<tr><th>" + customer.BRANCH + "</th><th>" + customer.NAME + "</th>";
                for (var iDate in dates) {
                    var date = dates[iDate];
                    html += "<td>";
                    for (var iEvent in events) {
                        var event = events[iEvent];
                        if (event.DATE == date) {
                            html += "<span class='label label-default'>" + event.EVENT + "</span>";
                        }
                    }
                    html += "</td>";
                }
                html += "</tr>";
            }
            $("#MILESTONE").html(html);
        }

        function a() {
            loadOrderStats(1);
        }

        function b() {
            loadConsultStats(1);
        }

        function e() {
            loadGiftList(1);
        }

        function f() {
            loadRentalList(1);
        }

        function g() {
            loadMilestone(-2);
        }

        $(function() {
            _addScheduler(a);
            _addScheduler(b);
            _addScheduler(e);
            _addScheduler(f);
            _addScheduler(g);

            _runScheduler();
        });
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="order_left_menu.jspf" %>
<%@ include file="order_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col order_dash" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">주문</a> &gt;
                        <a href="#!">대시보드</a>
                    </div>
                    <div class="page-title">
                        <div class="title_left">
                            <h3>주문 대시보드</h3>
                        </div>
                    </div>
                    
                    <div class="row">
                        <!-- 계약 / 결제 -->
                        <div class="col-md-7 col-sm-7 col-xs-12 main_dash">
                            <div class="x_panel tile fixed_height_300">
                                <div class="x_title">
                                    <h2>계약 / 결제</h2>
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
                                                <div class="count" id='DEPOSIT_STANDBY'>-</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>입금완료</h3>
                                                <div class="count" id='DEPOSIT_DONE'>-</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>계약취소신청</h3>
                                                <div class="count" id='CONTRACT_CANCEL'>-</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>환불완료</h3>
                                                <div class="count" id='REFUND_DONE'>-</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스대기</h3>
                                                <div class="count" id='SERVICE_STANDBY'>-</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스중</h3>
                                                <div class="count" id='IN_SERVICE'>-</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스연장</h3>
                                                <div class="count" id='SERVICE_EXTENDED'>-</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스완료</h3>
                                                <div class="count" id='SERVICE_DONE'>-</div>
                                            </div>
                                        </div>
                                    </div>
                        
                                </div>
                            </div>
                        </div>
                        <!-- 상담/문의 -->
                        <div class="col-md-5 col-sm-5 col-xs-12 main_dash">
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
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        조리원을 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='CARECENTER'>
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        홈페이지 직접
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='WEB'>
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        블로그를 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='BLOG'>
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        전시회를 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='EXHIBITION'>
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        검색을 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='SEARCH'>
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        바우처를 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='VOUCHER'>
                                            -
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        추천을 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default" id='RECOMMEND'>
                                            -
                                        </a>
                                    </div>
                                </div>
                                <a href="order_consult_new.jsp" class="btn btn-primary btn-new-consult">신규상담등록</a>
                            </div>
                        </div>
                    </div>

                    <!-- 서비스 MILESTONE -->
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile milestone">
                                <div class="x_title">
                                    <h2>서비스 MILESTONE</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <div class="btn-group pull-right btn-app branch-view">
                                            <a data-toggle="dropdown" class="btn btn-default btn-sm dropdown-toggle" type="button" aria-expanded="false">지사별 보기
                                                <span class="caret"></span>
                                            </a>
                                            <ul role="menu" class="dropdown-menu">
                                                <li>
                                                    <a href="#" onclick="loadMilestone(-2);">전체</a>
                                                </li>
                                                <li>
                                                    <a href="#" onclick="loadMilestone(-1);">본사</a>
                                                </li>
                                                <%
                                                    //List<Region> regions;
                                                    List<Branch> branches;
                                                    //regions = UserDB.getRegionList();
                                                    branches = _userdb.getBranchList();
                                                    Iterator iter = branches.iterator();
                                                    while (iter.hasNext())
                                                    {
                                                        Branch b = (Branch)iter.next();
                                                        Region r = UserDB.getRegion(b._region);
                                                        String name = "본사";
                                                        if (r != null)
                                                        {
                                                            name = r._name;
                                                        }
                                                        out.write("<li><a href='#' onclick='loadMilestone(" + b._index + ");'>" + name + "</a></li>");
                                                    }
                                                %>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12">
                                            <div class="scrolling outer">
                                                <div class="inner">
                                                    <table class="table table-striped table-hover table-condensed" id="MILESTONE">
                                                        <!--
                                                        <tr>
                                                            <th>지사</th>
                                                            <th class="second">산모</th>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td><span class="label label-success today">오늘</span></td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                            <td>날짜</td>
                                                        </tr>
                                                        <tr>
                                                            <th>구리</th>
                                                            <th>산모이름</th>
                                                            <td></td>
                                                            <td></td>
                                                            <td><span class="label label-default">대여시작</span></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td><span class="label label-default">대여회수</span></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <th>구리</th>
                                                            <th>산모이름</th>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td><span class="label label-default">택배비입금</span></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <th>구리</th>
                                                            <th>산모이름</th>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td><span class="label label-default">단말기회수</span></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <th>구리</th>
                                                            <th>산모이름</th>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td><span class="label label-default">선물발송</span></td>
                                                            <td><span class="label label-default">서비스종료</span></td>
                                                        </tr>
                                                        -->
                                                    </table>
                                                </div>
                                            </div>
                                            
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 출산선물현황 / 서비스용품 대여현황 -->
                    <div class="row">
                        <div class="col-md-7 col-sm-7 col-xs-12">
                            <div class="x_panel tile fixed_height_460">
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
                                    <div class="row gift-rank">
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">1</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">2</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                    </div>
                                    <div class="row gift-rank">
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">1</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">2</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                    </div>
                                    <div class="row gift-rank">
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">1</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">2</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                    </div>
                                    <div class="row gift-rank">
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">1</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">2</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                    </div>
                                    <div class="row gift-rank">
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">1</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <article class="media event">
                                                <a class="pull-left date">
                                                    <p class="day">2</p>
                                                </a>
                                                <div class="media-body">
                                                    <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                                    <p>50000개 증정</p>
                                                </div>
                                            </article>
                                        </div>
                                    </div>
                                    -->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 col-sm-5 col-xs-12 rent">
                            <div class="x_panel tile fixed_height_460">
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
                                <div class="x_content ">
                                    <ul class="list-unstyled top_profiles scroll-view" id="RENTAL_LIST">
                                        <!--
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
    <script src="./build/js/custom.min.js"></script>
</body>

</html>