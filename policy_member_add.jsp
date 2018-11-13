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

    <title>마더앤베이비 관리자 - 지사계정생성</title>

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
    <script>
        var isOK = false;

        function checkIdDup() {
            id = $("#ID").val();
            if (id.length == 0) {
                return;
            }

            var val = '';
            val += 'CHECK' + '&';
            val += 'ID=' + id + '&';
            $.post("_api_member.jsp", val)
            .fail(function(response) {
                alert('Error: ' + response.responseText);
                //document.getElementById("org").innerHTML = response.responseText;
            })
            .done(function(data) {
                console.log(data);
                if (data.RESULT == 1) {
                    isOK = true;
                } else {
                    isOK = false;
                }
            });
        }

        function saveAndList() {
            if (!isOK) {
                alert("중복 체크를 해주세요.");
                return;
            }
            id = $("#ID").val();
            contract = $("#CONTRACT").val();
            business = $("#BUSINESS").val();
            pwd1 = $("#PASS1").val();
            pwd2 = $("#PASS2").val();
            if (pwd1.length == 0) {
                alert('비밀번호가 입력되지 않았습니다.');
                return;
            }
            if (pwd1 != pwd2) {
                alert('입력된 비밀번호가 서로 다릅니다.');
                return;
            }

            var val = '';
            val += 'SET' + '&';
            val += 'ID=' + id + '&';
            val += 'CONTRACT=' + contract + '&';
            val += 'BUSINESS=' + business + '&';
            val += 'PASSWORD=' + pwd1 + '&';
            $.post("_api_member.jsp", val)
            .fail(function(response) {
                alert('Error: ' + response.responseText);
                //document.getElementById("org").innerHTML = response.responseText;
            })
            .done(function(data) {
                window.location.href = 'policy_member.jsp';
                console.log(data);
            });
        }
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col policy_jisa_account_regist" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">관리자</a> &gt;
                        <a href="#!">지사계정생성</a>
                    </div>
                    <!-- 이용안내 -->
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>지사계정생성</h2>
                                    <div class="title_right">
                                        <a href="policy_member.jsp" class="btn btn-primary btn-sm pull-right">지사계정목록</a>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                        
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">계약자명
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="CONTRACT" name="CONTRACT" required="required" class="form-control col-md-7 col-xs-12">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사업자명
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="BUSINESS" name="BUSINESS" required="required" class="form-control col-md-7 col-xs-12">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">아이디</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <div class="input-group btn-mb-0">
                                                        <input type="text" class="form-control" id="ID" name="ID">
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-primary btn-addr-search" onclick="checkIdDup()">중복확인</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">비밀번호</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input id="PASS1" name="PASS1" class="form-control col-md-7 col-xs-12" type="password">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">비밀번호 확인</label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input id="PASS2" name="PASS2" class="form-control col-md-7 col-xs-12" type="password">
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="btn-group-bottom text-center">
                                    <a class="btn btn-primary btn-sm" onclick="saveAndList()">저장 후 목록 확인</a>
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