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

    <title>마더앤베이비 관리자 - 지역설정</title>

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
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col policy_use_agree" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">지사/지역/산후도우미관리</a> &gt;
                        <a href="#!">지역설정</a>
                    </div>
                    <div class="page-title">
                        <div class="title_left">
                            <h3>지역설정</h3>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>서비스 지역 활성화 설정</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <!-- 지역선택 -->
                                    <div class="row sido">
                                        <div class="col-md-2 col-sm-2 col-xs-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                시/도</h4>
                                            <select class="select2_single form-control">
                                                <option value="">서울</option>
                                                <option value="">경기도</option>
                                                <option value="">인천</option>
                                                <option value="">충청북도</option>
                                                <option value="">충청남도</option>
                                                <option value="">대전</option>
                                                <option value="">광주</option>
                                                <option value="">전라북도</option>
                                                <option value="">전라남도</option>
                                                <option value="">강원도</option>
                                                <option value="">경상북도</option>
                                                <option value="">경상남도</option>
                                                <option value="">대구</option>
                                                <option value="">울산</option>
                                                <option value="">부산</option>
                                                <option value="">제주도</option>
                                            </select>
                                        </div>
                                        <div class="col-md-10 col-sm-10 col-xs-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                시/군/구</h4>
                                            <ul class="list-unstyled">
                                                <li>
                                                    <input type="checkbox" class="flat" id="loc_all">
                                                    <label for="loc_all">전체
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">성동
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">광진
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">중랑
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">도봉
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">노원
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강북
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">성북
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">종로
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">서대문
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">은평
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">마포
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강서
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">양천
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">구로
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">영등포
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">금천
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">관악
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">동작
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">서초
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강남
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">송파
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강동
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">동대문
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">중구
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">용산
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <a href="#!" class="btn btn-primary btn-sm">저장</a>
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