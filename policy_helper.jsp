<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%!
    List<Region> lstRegionsAll;
    List<Region> lstRegionsGroup;
    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
    int _region = -1;

    int calcAge(String social)
    {
        if (social.length() < 14)
        {
            return -1;
        }

        int curYear = Calendar.getInstance().get(Calendar.YEAR);
        int year = Integer.parseInt(social.substring(0, 2));
        String[] socials = social.split("-");

        char temp = socials[1].charAt(0);
        boolean is2000s = ((temp == '3') || (temp == '4'));
        if (is2000s)
        {
            year += 2000;
        }
        else
        {
            year += 1900;
        }

        return curYear - year + 1;
    }
%>

<%
    int index = -1;
    Terms item = null;
    String temp = request.getParameter("REGION");

    lstRegionsGroup = _userdb.getRegionList(-1);
    lstRegionsAll = _userdb.getRegionList(0);
    if (temp != null)
    {
        _region = Integer.parseInt(temp);
    }
    else
    {
        _region = -1;
    }
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 산후도우미 관리</title>

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
        var type = '';

        class Region {
            constructor(index, name, upper) {
                this._index = index;
                this._name = name;
                this._upper = upper;
            }
        }
        var regions = [
        <%
            for (Iterator it = lstRegionsAll.iterator(); it.hasNext(); )
            {
                Region r = (Region)it.next();
                out.write("new Region(" + r._index + ", '" + r._name + "', " + r._upper + "),");
            }
        %>
        ];

        function changedRegion() {
            var html = "";
            for (var i = 0; i < regions.length; i++) {
                if (regions[i]._upper == $("#region").val()) {
                    html += "<li><input type='checkbox' class='flat' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " /><label for=''>" + regions[i]._name + "<span class='badge bg-purple'>0</span></label></li>";
                }
            }
            document.getElementById('sub').innerHTML = html;
        }

        function setEditFields() {
            //alert("init:" + <%=index%>);
            changedRegion();

            $.get("_helper_list.jsp")
            .fail(function(response) {
                //alert('Error: ' + response.responseText);
                document.getElementById('result').innerHTML = response.responseText;
                //$("#CONTENTS").val(response.responseText);
            })
            .done(function(data) {
                //alert(data);
                document.getElementById('result').innerHTML = data;
                //location.reload();
            });
        }

        function setRegion(index) {
            //alert(index);
            //var boxs = document.getElementsByName("REGION");
            var boxs = document.getElementsByName("REGION");
            for (var i = 0; i < boxs.length; i++) {
                if (boxs[i].value != index)
                    boxs[i].checked = false;
                else
                    boxs[i].checked = true;
            }
            //alert()
        }

        function viewHelper(index) {
            window.location.href = 'policy_helper_view.jsp?HELPER=' + index;
        }

        function changeRegion(index) {
            window.location.href = 'content_branch_list.jsp?REGION=' + index;
        }

        $(document).ready(function() {
            $("#search").click(function() {
                //alert($("#term").serialize() + "&INDEX=" + <%= index %>);
                var val = $("#searchPattern").serialize();
                //alert('저장합니다[' + val + "]");
                //alert(val);
                //$.post("_terminal_update.jsp", $("#term").serialize() + "&INDEX=" + '<%= index %>')
                $.post("_helper_list.jsp", val)
                .fail(function(response) {
                    document.getElementById('result').innerHTML = response.responseText;
                    //alert('Error: ' + response.responseText);
                    //$("#CONTENTS").val(response.responseText);
                })
                .done(function(data) {
                    //alert(data);
                    document.getElementById('result').innerHTML = data;
                    //location.reload();
                });
            });

            //$("#moveGift").click(function() {
            //  window.location.href = "content_gift_list.jsp";
            //});
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
            <div class="right_col policy_use_agree" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">지사/지역/산후도우미관리</a> &gt;
                        <a href="#!">산후도우미관리</a>
                    </div>
                    <div class="page-title">
                        <div class="title_left">
                            <h3>산후도우미 관리</h3>
                        </div>
                        <div class="title_right">
                            <a href="policy_helper_new.jsp" class="btn btn-primary btn-sm pull-right">신규등록</a>
                        </div>
                    </div>

                    <div class="row">
                        <form id="searchPattern">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="x_panel tile">
                                    <div class="x_title">
                                        <h2>가맹지역 선택(시/도)</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <!-- 지역선택 -->
                                        <div class="row sido">
                                            <div class="col-md-2 col-sm-2 col-xs-12">
                                                <h4>
                                                    <i class="fa fa-check"></i>
                                                    시/도</h4>
                                                <select class="select2_single form-control" onchange="changedRegion()" id=region>
                                                    <%
                                                        for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
                                                        {
                                                            Region r = (Region)it.next();
                                                            out.write("<option value=" + r._index + ">" + r._name + "</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="col-md-10 col-sm-10 col-xs-12">
                                                <h4>
                                                    <i class="fa fa-check"></i>
                                                    시/군/구
                                                </h4>
                                                <ul class="list-unstyled" id="sub">
                                                </ul>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="form-group radio-group">
                                                <label>
                                                    <input type="radio" class="flat" name="SEARCH_REGION" value="belong" /> 소속지점으로 검색
                                                </label>
                                                <label>
                                                    <input type="radio" class="flat" name="SEARCH_REGION" value="wish" /> 희망근무지역으로 검색
                                                </label>
                                            </div>
                                            <div class="form-group radio-group">
                                                <label>
                                                    <input type="radio" class="flat" name="SEARCH_STATE" value="all" /> 전체
                                                </label>
                                                <label>
                                                    <input type="radio" class="flat" name="SEARCH_STATE" value="avail" /> 근무가능
                                                </label>
                                                <label>
                                                    <input type="radio" class="flat" name="SEARCH_STATE" value="unavail" /> 근무불가
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <label for="">이름, 휴대번호로 검색</label>
                                                <input type="text" class="form-control input-inline" name="PATTERN" />
                                            </div>
                                            <hr>
                                            <a class="btn btn-primary btn-sm" id="search">검색</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <div class="col-md-12 col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-striped jambo_table bulk_action">
                                    <thead>
                                        <tr class="headings">
                                            <th class="column-title">보기</th>
                                            <th class="column-title">성함</th>
                                            <th class="column-title">소속지점</th>
                                            <th class="column-title">희망근무지역</th>
                                            <th class="column-title">상태</th>
                                            <th class="column-title">나이</th>
                                            <th class="column-title">휴대폰</th>
                                        </tr>
                                    </thead>

                                    <tbody id=result>
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