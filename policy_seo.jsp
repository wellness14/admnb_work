<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<% Tags tags = _userdb.getTags(); %>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - SEO공통관리</title>

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
    <script src="js/myutils.js" ></script>
    <script>
        $(document).ready(function() {
            $("#save").click(function() {
                var val = '';
                val += 'TITLE=' + $("#TITLE").val() + '&';
                val += 'AUTHOR=' + $("#AUTHOR").val() + '&';
                val += 'DESCRIPTION=' + $("#DESCRIPTION").val() + '&';
                val += 'KEYWORD=' + $("#KEYWORD").val() + '&';

                $.post("_tags_update.jsp", val)
                .fail(function(response) {
                    //alert('Error: ' + response.responseText);
                    $("#CONTENTS").val(response.responseText);
                })
                .done(function(data) {
                    alert('저장되었습니다.');
                    location.reload();
                });
            });
        });
    </script>
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
                        <a href="#!">SEO태그</a> &gt;
                        <a href="#!">공통관리</a>
                    </div>
                    <div class="page-title">
                        <div class="title_left">
                            <h3>SEO 공통관리(PC/모바일) 태그 설정</h3>
                        </div>
                        <div class="title_right">
                            <a href="#!" class="btn btn-primary btn-sm pull-right" id="save">저장</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>타이틀</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <input type="text" class="form-control" name="TITLE" id="TITLE" value="<%= tags.getTitle() %>" >
                                    <hr>
                                    <small>타이틀 (Title) : 인터넷 브라우저 화면 가장 위에 보여지는 텍스트(페이지 제목)를 입력합니다. <br/>※입력 시 글자수 및 입력문자 제한은 없으나 노출되는 영역이 브라우저별로 제한되어 있으므로 한글기준 10자 이내로
                                    작성하는 것이 적합합니다.</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>메타태그 작성자</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <input type="text" class="form-control" name="AUTHOR" id="AUTHOR" value="<%= tags.getAuthor() %>">
                                    <hr>
                                    <small>메타태그 작성자 (Author) : 페이지의 제작자를 입력합니다.<br/> ※메타태그 작성자는 검색 시에 노출되지 않지만 검색엔진에서 사이트를 색인하는 용도로 활용됩니다.</small>
                                     
                                </div>
                            </div></div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>메타태그 설명</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <input type="text" class="form-control" name="DESCRIPTION" id="DESCRIPTION" value="<%= tags.getDescription() %>">
                                    <hr>
                                    <small>메타태그 설명 (Description) : 홈페이지에 대한 간략한 설명을 입력합니다. <br/>※검색사이트의 검색결과에는 설명의 앞부분을 기준으로 한글기준 최대 80자(공백포함)만 노출되므로 이에 맞게 입력해야 합니다.<br/> ※또한
                                    검색사이트에서 사용자에게 보여질 수 있으므로 단순한 단어의 나열보다는 사이트를 설명하는 주요 단어로 문장을 만드는 것이 좋습니다.</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>메타태그 키워드</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <input type="text" class="form-control" name="KEYWORD" id="KEYWORD" value="<%= tags.getKeyword() %>">
                                    <hr>
                                    <small>메타태그 키워드 (Keywords) : 사이트를 설명하는 단어를 쉼표(,)로 분리하여10개 이내로 입력합니다.<br/> ※입력 시 글자수 및 입력문자 제한은 없습니다. <br/>※메타태그 키워드는 검색 시에 노출되지 않지만 검색엔진에서
                                    사이트를 검색할 수 있는 키워드로 활용됩니다.</small>
                                     
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