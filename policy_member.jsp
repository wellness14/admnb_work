<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
    List<Region> lstRegionsGroup; //= _userdb.getGiftList();
    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
    int _region = -1;
%>

<%
    int index = -1;
    Member item = null;

    ResultSet rs = null;
    String sql;

    sql = "select * from MEMBER where HQ_BRANCH='B'";
    //UserDB.PrintLog(sql);
    rs = DBPool.getResultSet(sql);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 지사계정목록</title>

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
    <script>
        function viewBranch(index) {
            window.location.href = 'policy_branch_view.jsp?BRANCH=' + index;
        }
        function changeRegion(index) {
            window.location.href = 'policy_branch.jsp?REGION=' + index;
        }
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
                        <a href="#!">관리자</a> &gt;
                        <a href="#!">지사계정목록</a>
                    </div>
                    <div class="page-title">
                        <div class="title_left">
                            <h3>지사계정목록</h3>
                        </div>
                        <div class="title_right">
                            <a href="policy_member_add.jsp" class="btn btn-primary btn-sm pull-right">신규등록</a>
                        </div>
                    </div>

                    <div class="row manage_jisa">
                        <div class="col-md-12 col-sm-12">
                            <div class="table-responsive">
                                
                                <table class="table table-striped jambo_table bulk_action">
                                    <thead>
                                        <tr class="headings">
                                            <th class="column-title">계약자</th>
                                            <th class="column-title">사업자</th>
                                            <th class="column-title">ID</th>
                                        </tr>
                                    </thead>
                            
                                    <tbody>
<%
        boolean isOdd = true;

        while (UserDB.getNext(rs))
        {
            if (isOdd)
                out.write("<tr class='odd pointer'>\n");
            else
                out.write("<tr class='even pointer'>\n");
            isOdd = !isOdd;

            //out.write("<td><a class='btn btn-xs btn-primary btn-mb-0' onclick='viewBranch(" + rs.getInt("BRANCH_INDEX") + ")'>보기</a></td>\n");
            out.write("<td>" + rs.getString("CONTRACTOR") + "</td>\n");
            out.write("<td>" + rs.getString("BUSINESS") + "</td>\n");
            out.write("<td>" + rs.getString("ID") + "</td>\n");

            out.write("</tr>\n");
        }
        DBPool.removeDBObject(rs);
%>
<!--
                                        <tr class="even pointer">
                                            <td>
                                                <a href="policy_manage_jisa_detail.html" class="btn btn-xs btn-primary btn-mb-0">보기</a>
                                            </td>
                                            <td>조아라(id)</td>
                                            <td>동작/관악/금천</td>
                                            <td>조아라</td>
                                            <td>조아라</td>
                                            <td>서울 관악구 남현동 111-11 미래오피스 2층 220호</td>
                                            <td>02-1121-5511</td>
                                            <td>개시 yyyy.mm.dd ~ 개시 yyyy.mm.dd</td>
                                        </tr>
                                        <tr class="odd pointer">
                                            <td>
                                                <a href="policy_manage_jisa_detail.html" class="btn btn-xs btn-primary btn-mb-0">보기</a>
                                            </td>
                                            <td>조아라(id)</td>
                                            <td>동작/관악/금천</td>
                                            <td>조아라</td>
                                            <td>조아라</td>
                                            <td>서울 관악구 남현동 111-11 미래오피스 2층 220호</td>
                                            <td>02-1121-5511</td>
                                            <td>개시 yyyy.mm.dd ~ 개시 yyyy.mm.dd</td>
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