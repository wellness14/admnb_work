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

    <title>마더앤베이비 관리자</title>

    <!-- Bootstrap -->
    <link href="./vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="./vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="./vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="./vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="./vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
       function onSearch() {
            var period = $("#PERIOD").val();
            var branch = $("#BRANCH").val();
            //console.log("SEARCH:[" + period + "] - " + branch);
            //console.log("SEARCH:[" + period.split(' ')[0] + "] - " + branch);
            //console.log("SEARCH:[" + period.split(' ')[2] + "] - " + branch);
            //return;
            var val = '';
            val += 'STATISTICS' + '&';
            val += 'PERIOD_BEGIN=' + period.split(' ')[0] + '&';
            val += 'PERIOD_END=' + period.split(' ')[2] + '&';
            val += 'BRANCH=' + branch + '&';
            $.post("_api_sales.jsp", val)
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
                var sales = data.RESULT.SALES;
                var contract = data.RESULT.CONTRACT;
                var extended = data.RESULT.EXTENDED;
                var ranking = data.RESULT.RANKING;
                var daily = data.RESULT.DAILY;
                $("#SALES_HQ").html(sales.HQ);
                $("#SALES_BRANCH").html(sales.BRANCH);
                $("#SALES_TOTAL").html(sales.TOTAL);

                $("#CONTRACT_HQ").html(contract.HQ);
                $("#CONTRACT_BRANCH").html(contract.BRANCH);
                $("#CONTRACT_TOTAL").html(contract.TOTAL);

                $("#EXTENDED_HQ").html(extended.HQ);
                $("#EXTENDED_BRANCH").html(extended.BRANCH);
                $("#EXTENDED_TOTAL").html(extended.TOTAL);
                //return;
                html = '';
                for (var i in ranking) {
                    html += "<article class='media event'>\n";
                    html += "<a class='pull-left date'>\n";
                    html += "   <p class='day'>" + index + "</p>\n";
                    html += "</a>\n";
                    html += "<div class='media-body'>\n";
                    html += "   <a class='title' href='#!'>" + ranking[i].NAME + "</a>\n";
                    html += "<p>" + ranking[i].SALES + "원</p>\n";
                    html += "</div>\n";
                    html += "</article>";
                    index += 1;
                }
                $("#RANKING").html(html);
                html = '';
                for (var i in daily) {
                    html += "<tr>\n";
                    html += "<td>" + daily[i].DATE + "</td>\n";
                    html += "<td>" + daily[i].BRANCH + "</td>\n";
                    html += "<td>" + daily[i].MEMBER + "</td>\n";
                    html += "<td>" + daily[i].CONTRACT + "</td>\n";
                    html += "<td>" + daily[i].CANCELED + "</td>\n";
                    html += "<td>" + daily[i].EXTENDED + "</td>\n";
                    html += "<td>" + daily[i].CONSULT + "</td>\n";
                    html += "<td>" + daily[i].IN_SERVICE + "</td>\n";
                    html += "<td>" + daily[i].COMPLETED + "</td>\n";
                    html += "<td>" + daily[i].SALES + "</td>\n";
                    html += "<td>" + daily[i].VOUCHER + "</td>\n";
                    html += "<td>" + daily[i].DISCOUNT + "</td>\n";
                    html += "<td>" + (daily[i].SALES + daily[i].VOUCHER + daily[i].DISCOUNT) + "</td>\n";
                    html += "<td>" + daily[i].REFUND + "</td>\n";
                    html += "</tr>";
                    index += 1;
                }
                $("#STATS").html(html);
                /*
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
                */
            });
        }

        $(function() {
            var val = $("#PERIOD").val();
            console.log("INIT:[" + val + "]");
            onSearch();
        });
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="sales_left_menu.jspf" %>

            <!-- top navigation -->
            <div class="top_nav main_top">
<%@ include file="sales_top_nav.jspf" %>
                <!-- page content -->
                <div class="right_col main_dash sales" role="main">
                    <div class="">
                        <div class="row">
                            <!-- 매출검색 -->
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="x_panel tile">
                                    <div class="x_title">
                                        <h2>매출 검색</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div class="row">
                                            <div class="col-md-1"><strong>지사</strong></div>
                                            <div class="col-md-2">
                                                <select name="BRANCH" id="BRANCH" class="form-control input-md">
                                                    <option value='-2' selected>전체</option>
                                                    <option value='-1'>본사</option>
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
                                                            out.write("<option value='" + b._index + "'>" + name + "</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="col-md-1"><strong>기간검색</strong></div>
                                            <div class="col-md-8">
                                                <form class="form-horizontal">
                                                    <fieldset>
                                                        <div class="control-group">
                                                            <div class="controls">
                                                                <div class="input-prepend input-group">
                                                                    <span class="input-group-btn add-on">
                                                                        <a href="#!" class="btn btn-success" onclick="onSearch()">검색</a>
                                                                    </span>
                                                                    <input type="text" style="width:200px" name="PERIOD" id="PERIOD" class="form-control" value="2016-09-01 - 2016-09-22"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                        <hr>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>기간내 매출액
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content top-box-noscroll">
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">본사
                                                    <br/>매출</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='SALES_HQ'>- 원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">지사
                                                    <br/>매출</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='SALES_BRANCH'>- 원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">총매
                                                    <br/>출액</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='SALES_TOTAL'>- 원</p>
                                            </div>
                                        </article>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>기간내 계약건수
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content top-box-noscroll title-control">
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">본사</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='CONTRACT_HQ'>- 건</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">지사</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='CONTRACT_BRANCH'>- 건</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">총건수</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='CONTRACT_TOTAL'>- 건</p>
                                            </div>
                                        </article>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>기간내 연장건수
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content top-box-noscroll title-control">
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">본사</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='EXTENDED_HQ'>- 건</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">지사</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='EXTENDED_BRANCH'>- 건</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="month">총건수</p>
                                            </a>
                                            <div class="media-body sales-price">
                                                <p id='EXTENDED_TOTAL'>- 건</p>
                                            </div>
                                        </article>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="x_panel tile">
                                    <div class="x_title">
                                        <h2>매출액 TOP</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content top-box" id='RANKING'>
                                        <!--
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">1</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">2</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">3</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">4</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">5</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">6</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">7</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">8</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">9</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        <article class="media event">
                                            <a class="pull-left date">
                                                <p class="day">10</p>
                                            </a>
                                            <div class="media-body">
                                                <a class="title" href="#!">00지사</a>
                                                <p>10,000,000원</p>
                                            </div>
                                        </article>
                                        -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="x_panel">
                                    <!-- <div class="x_title">
                                        <h2>기간내 계약건수
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div> -->
                                    <div class="x_content">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>날짜</th>
                                                    <th>지사</th>
                                                    <th>지사장</th>
                                                    <th>계약건수</th>
                                                    <th>계약취소</th>
                                                    <th>연장건수</th>
                                                    <th>상담문의</th>
                                                    <th>서비스진행중</th>
                                                    <th>완료</th>
                                                    <th>입금</th>
                                                    <th>바우처</th>
                                                    <th>에누리</th>
                                                    <th>매출</th>
                                                    <th>환불</th>
                                                </tr>
                                            </thead>
                                            <tbody id="STATS">
                                                <!--
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                <tr>
                                                    <td>2018-05-28</td>
                                                    <td>본사</td>
                                                    <td>정혜윤</td>
                                                    <td>59</td>
                                                    <td>0</td>
                                                    <td>25</td>
                                                    <td>87</td>
                                                    <td>65</td>
                                                    <td>154</td>
                                                    <td>10,000,000원</td>
                                                    <td>???</td>
                                                </tr>
                                                -->
                                            </tbody>
                                        </table>
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
        <!-- bootstrap-daterangepicker -->
        <script src="./vendors/moment/min/moment.min.js"></script>
        <script src="./vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script src="./vendors/jquery-ui-1.12.1.custom/datepicker-ko-KR.js"></script>
        <script src="./vendors/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
        <script src="./vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
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
        <script>
            var year = moment().year();
            var temp_month = moment().month();
            var month = moment().month(temp_month).format("MM");
            var day = moment()._d.getDate();
            
            $('input[name="PERIOD"]').daterangepicker({
                locale: {
                    format: 'YYYY-MM-DD',
                    applyLabel: "적용",
                    cancelLabel: "취소",
                    weekLabel: "주",
                    daysOfWeek: [
                        "일",
                        "월",
                        "화",
                        "수",
                        "목",
                        "금",
                        "토"
                    ],
                    monthNames: [
                        "1월",
                        "2월",
                        "3월",
                        "4월",
                        "5월",
                        "6월",
                        "7월",
                        "8월",
                        "9월",
                        "10월",
                        "11월",
                        "12월",
                    ],
                    customRangeLabel: "기간설정"
                },
                startDate: year + '-' + month + '-01' ,
                endDate: year + '-' + month + '-' + day,
                ranges: {
                    '오늘': [moment(), moment()],
                    '이번달': [moment().startOf('month'), moment().endOf('month')],
                    '7일': [moment().subtract(6, 'days'), moment()],
                    '15일': [moment().subtract(14, 'days'), moment()],
                    '30일': [moment().subtract(29, 'days'), moment()],
                    '1개월': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
                    '3개월': [moment().subtract(3, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                }
            });
        </script>
</body>

</html>