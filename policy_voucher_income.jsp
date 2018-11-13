<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
    public void setUserDB(UserDB userdb)
    {
        _userdb = userdb;
        _options = _userdb.getServiceOptionList();
    }
    public List<ServiceOption> _options;

    public ServiceOption getOption(String type)
    {
        //access via Iterator
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

//  return "<input type=text id='" + id + "' name='" + id + "'>";
    public String tagInput(String id)
    {
        return "<input type='text' class='form-control' id='" + id + "' name='" + id + "'>";
    }
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

    <title>마더앤베이비 관리자 - 기준중위소득관리</title>

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
    <!--<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>-->
    <script>
        function setEditFields() {
            <%= scriptSetCost("50_1") %>
            <%= scriptSetCost("50_1_COM") %>
            <%= scriptSetCost("50_1_REG") %>
            <%= scriptSetCost("50_1_COM_REG") %>

            <%= scriptSetCost("50_2") %>
            <%= scriptSetCost("50_2_COM") %>
            <%= scriptSetCost("50_2_REG") %>
            <%= scriptSetCost("50_2_COM_REG") %>

            <%= scriptSetCost("50_3") %>
            <%= scriptSetCost("50_3_COM") %>
            <%= scriptSetCost("50_3_REG") %>
            <%= scriptSetCost("50_3_COM_REG") %>

            <%= scriptSetCost("50_4") %>
            <%= scriptSetCost("50_4_COM") %>
            <%= scriptSetCost("50_4_REG") %>
            <%= scriptSetCost("50_4_COM_REG") %>

            <%= scriptSetCost("50_5") %>
            <%= scriptSetCost("50_5_COM") %>
            <%= scriptSetCost("50_5_REG") %>
            <%= scriptSetCost("50_5_COM_REG") %>

            <%= scriptSetCost("50_6") %>
            <%= scriptSetCost("50_6_COM") %>
            <%= scriptSetCost("50_6_REG") %>
            <%= scriptSetCost("50_6_COM_REG") %>


            <%= scriptSetCost("60_1") %>
            <%= scriptSetCost("60_1_COM") %>
            <%= scriptSetCost("60_1_REG") %>
            <%= scriptSetCost("60_1_COM_REG") %>

            <%= scriptSetCost("60_2") %>
            <%= scriptSetCost("60_2_COM") %>
            <%= scriptSetCost("60_2_REG") %>
            <%= scriptSetCost("60_2_COM_REG") %>

            <%= scriptSetCost("60_3") %>
            <%= scriptSetCost("60_3_COM") %>
            <%= scriptSetCost("60_3_REG") %>
            <%= scriptSetCost("60_3_COM_REG") %>

            <%= scriptSetCost("60_4") %>
            <%= scriptSetCost("60_4_COM") %>
            <%= scriptSetCost("60_4_REG") %>
            <%= scriptSetCost("60_4_COM_REG") %>

            <%= scriptSetCost("60_5") %>
            <%= scriptSetCost("60_5_COM") %>
            <%= scriptSetCost("60_5_REG") %>
            <%= scriptSetCost("60_5_COM_REG") %>

            <%= scriptSetCost("60_6") %>
            <%= scriptSetCost("60_6_COM") %>
            <%= scriptSetCost("60_6_REG") %>
            <%= scriptSetCost("60_6_COM_REG") %>




            <%= scriptSetCost("80_1") %>
            <%= scriptSetCost("80_1_COM") %>
            <%= scriptSetCost("80_1_REG") %>
            <%= scriptSetCost("80_1_COM_REG") %>

            <%= scriptSetCost("80_2") %>
            <%= scriptSetCost("80_2_COM") %>
            <%= scriptSetCost("80_2_REG") %>
            <%= scriptSetCost("80_2_COM_REG") %>

            <%= scriptSetCost("80_3") %>
            <%= scriptSetCost("80_3_COM") %>
            <%= scriptSetCost("80_3_REG") %>
            <%= scriptSetCost("80_3_COM_REG") %>

            <%= scriptSetCost("80_4") %>
            <%= scriptSetCost("80_4_COM") %>
            <%= scriptSetCost("80_4_REG") %>
            <%= scriptSetCost("80_4_COM_REG") %>

            <%= scriptSetCost("80_5") %>
            <%= scriptSetCost("80_5_COM") %>
            <%= scriptSetCost("80_5_REG") %>
            <%= scriptSetCost("80_5_COM_REG") %>

            <%= scriptSetCost("80_6") %>
            <%= scriptSetCost("80_6_COM") %>
            <%= scriptSetCost("80_6_REG") %>
            <%= scriptSetCost("80_6_COM_REG") %>
        }

        function saveOK() {
            alert("저장되었습니다.");
        }

        $(document).ready(function() {
            $("#save50").click(function() {
                $.post("_service_option_update.jsp", $("#50").serialize())
                .done(function(data) {
                    saveOK();
                });
            });
            $("#save60").click(function() {
                $.post("_service_option_update.jsp", $("#60").serialize())
                .done(function(data) {
                    saveOK();
                });
            });
            $("#save80").click(function() {
                $.post("_service_option_update.jsp", $("#80").serialize())
                .done(function(data) {
                    saveOK();
                });
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
            <div class="right_col policy_voucher_income" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">바우처</a> &gt;
                        <a href="#!">기준중위소득관리</a>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>
                                        기준중위소득관리
                                    </h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">

                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <h4>
                                                <i class="fa fa-slack"></i>
                                                <strong>50% 판정기준</strong>
                                                <small class="pull-right">최종수정일 2018.03.09</small>
                                                <div class="clearfix"></div>
                                            </h4>
                                            <blockquote>
                                                <p>* 건강보험료 본인 부담금에 의한 기준 중위소득 50% 판정 기준을 입력하세요.</p>
                                                <p>* 입력 금액 이하일 경우 기준 중위소득(소득구간) 50% 이하로 판단</p>
                                            </blockquote>
                                            <form id="50">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>가구원수</th>
                                                        <th>건강보험료 본인부담금 직장가입자(원)</th>
                                                        <th>건강보험료 본인부담금 지역가입자(원)</th>
                                                        <th>건강보험료 본인부담금 직장+지역(원)</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("50_1") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_1_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_1_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_1_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("50_2") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_2_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_2_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_2_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("50_3") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_3_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_3_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_3_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("50_4") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_4_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_4_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_4_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("50_5") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_5_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_5_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_5_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("50_6") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_6_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_6_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("50_6_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            </form>
                                            <a class="btn btn-primary btn-sm" id="save50">저장</a>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <h4>
                                                <i class="fa fa-slack"></i>
                                                <strong>60% 판정기준</strong>
                                                <small class="pull-right">최종수정일 2018.03.09</small>
                                                <div class="clearfix"></div>
                                            </h4>
                                            <blockquote>
                                                <p>* 건강보험료 본인 부담금에 의한 기준 중위소득 60% 판정 기준을 입력하세요.</p>
                                                <p>* 입력 금액 이하일 경우 기준 중위소득(소득구간) 50% 초과 - 60% 이하로 판단</p>
                                            </blockquote>
                                            <form id="60">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>가구원수</th>
                                                        <th>건강보험료 본인부담금 직장가입자(원)</th>
                                                        <th>건강보험료 본인부담금 지역가입자(원)</th>
                                                        <th>건강보험료 본인부담금 직장+지역(원)</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("60_1") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_1_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_1_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_1_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("60_2") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_2_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_2_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_2_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("60_3") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_3_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_3_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_3_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("60_4") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_4_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_4_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_4_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("60_5") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_5_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_5_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_5_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("60_6") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_6_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_6_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("60_6_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            </form>
                                            <a class="btn btn-primary btn-sm" id="save60">저장</a>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <h4>
                                                <i class="fa fa-slack"></i>
                                                <strong>80% 판정기준</strong>
                                                <small class="pull-right">최종수정일 2018.03.09</small>
                                                <div class="clearfix"></div>
                                            </h4>
                                            <blockquote>
                                                <p>* 건강보험료 본인 부담금에 의한 기준 중위소득 80% 판정 기준을 입력하세요.</p>
                                                <p>* 입력 금액 이하일 경우 기준 중위소득(소득구간) 60% 초과 - 80% 이하로 판단</p>
                                                <p>* 입력 금액 이상인 경우 80%초과 예외지원으로 판단</p>
                                            </blockquote>
                                            <form id="80">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>가구원수</th>
                                                        <th>건강보험료 본인부담금 직장가입자(원)</th>
                                                        <th>건강보험료 본인부담금 지역가입자(원)</th>
                                                        <th>건강보험료 본인부담금 직장+지역(원)</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("80_1") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_1_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_1_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_1_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("80_2") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_2_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_2_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_2_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("80_3") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_3_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_3_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_3_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("80_4") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_4_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_4_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_4_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("80_5") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_5_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_5_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_5_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%= tagInput("80_6") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_6_COM") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_6_REG") %>
                                                        </td>
                                                        <td>
                                                            <%= tagInput("80_6_COM_REG") %>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            </form>
                                            <a class="btn btn-primary btn-sm" id="save80">저장</a>
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