<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%
    List<Region> lstRegionsAll;
    List<Region> lstRegionsGroup;
    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
    int _region = -1;
    int index = -1;

    lstRegionsGroup = _userdb.getRegionList(-1);
    lstRegionsAll = _userdb.getRegionList(0);
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 산후도우미 등록</title>

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

        //var memberIndex = -1;
        var selRegions = [-1, -1];

        function setEditFields() {
            changedRegion_Belong();
            changedRegion_Wish();
        }

        $(document).ready(function() {
            $("#search").click(function() {
                var myWindow = window.open("sub_select_member.jsp?SEARCH=" + $("#PATTERN").val(), "selectHelper", "width=500,height=500");
            });
        });

        function saveMe() {
            if (checkRegionSel(0) == false) {
                alert("소속지점이 선택되지 않았습니다.");
                return;
            }
            if (checkRegionSel(1) == false) {
                alert("희망근무지역이 선택되지 않았습니다.");
                return;
            }
            var val = '';
            val += $("#formData").serialize();
            alert(val);
            //return;
            $.post("_helper_update.jsp", val)
            .fail(function(response) {
                alert('Error: ' + response.responseText);
                $("#MEMO").val(response.responseText);
            })
            .done(function(data) {
                //alert(data);
                //location.reload();
                window.location.href = 'policy_helper.jsp';
            });
        }

        function cancel() {
            window.history.go(-1);
        }

        window.onload = setEditFields;

        function checkRegionSel(type) {
            var checked = false;
            var names = ['REGION_BELONG', 'REGION_WISH'];
            var boxs = document.getElementsByName(names[type]);
            //var boxs = document.getElementsByName("REGION");
            for (var i = 0; i < boxs.length; i++) {
                if (boxs[i].checked == true) {
                    checked = true;
                    break;
                }
            }
            return checked;
        }

        function setRegion(type, index) {
            //alert(index);
            //var boxs = document.getElementsByName("REGION");
            var names = ['REGION_BELONG', 'REGION_WISH'];
            var boxs = document.getElementsByName(names[type]);
            selRegions[type] = index;
            for (var i = 0; i < boxs.length; i++) {
                if (boxs[i].value != index)
                {
                    boxs[i].checked = false;
                }
                else
                {
                    boxs[i].checked = true;
                }
            }
            //alert()
        }

        function changedRegion_Belong() {
            //alert($("#region").val());
            var html = "";
            for (var i = 0; i < regions.length; i++) {
                if (regions[i]._upper == $("#regionBelong").val()) {
                    html += "<input type='checkbox' onclick='setRegion(0, " + regions[i]._index + ")' name='REGION_BELONG' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
                }
            }
            //alert(html);
            document.getElementById('subBelong').innerHTML = html;
        }

        function changedRegion_Wish() {
            //alert($("#region").val());
            var html = "";
            for (var i = 0; i < regions.length; i++) {
                if (regions[i]._upper == $("#regionWish").val()) {
                    html += "<input type='checkbox' onclick='setRegion(1, " + regions[i]._index + ")' name='REGION_WISH' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
                }
            }
            //alert(html);
            document.getElementById('subWish').innerHTML = html;
        }
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

             <!-- page content -->
            <div class="right_col policy_manage_helper_new" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>산후도우미 신규등록</h3>
                        </div>
                        <div class="title_right">
                            <a onclick="saveMe()" class="btn btn-primary btn-sm pull-right helper-save">저장</a>
                            <a onclick="cancel()" class="btn btn-default btn-sm pull-right">취소</a>
                        </div>
                    </div>

                    <!--<form id="formData">-->
                    <form id="formData" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="x_panel tile">
                                    <div class="x_title">
                                        <h2>개인정보 등록</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                            <div class="form-group">
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <div class="profile_img">
                                                        <div id="crop-avatar">
                                                            <!-- Current avatar -->
                                                            <img class="img-responsive avatar-view" src="images/picture.jpg" alt="Avatar" title="Change the avatar">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">사진
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <div class="input-group btn-mb-0">
                                                        <input type="file" class="form-control">
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-primary btn-addr-search">등록</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-sm-2 col-xs-12">이름
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="text" required="required" class="form-control" name="NAME">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-sm-2 col-xs-12">주민번호
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="text" required="required" class="form-control" name="SOCIAL_NUM">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-sm-2 col-xs-12">주소
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" name="POST" placeholder="우편번호">
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-primary btn-addr-search">검색</button>
                                                        </span>
                                                    </div>
                                                    <input type="text" class="form-control addr1" name="ADDRESS1" placeholder="주소">
                                                    <input type="text" class="form-control addr2" name="ADDRESS2" placeholder="상세주소">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="last-name">휴대전화
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="text" class="form-control" name="MOBILE" placeholder="예시) 010-0000-0000">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="last-name">일반전화
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="text" class="form-control" name="PHONE" placeholder="예시) 02-0000-0000">
                                                </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="x_panel tile">
                                    <div class="x_title">
                                        <h2>자격정보 등록</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">교육수료기관
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="text" class="form-control " name="EDUCATION" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">배상보험가입
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="text" class="form-control " name="INSURANCE" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">건강검진
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <input type="date" class="form-control " name="HEALTH_CARE" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">수혜기간
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    시작
                                                    <input type="date" class="form-control input-inline start-date" name="BENEFIT_BEGIN" />
                                                    <br/> 종료
                                                    <input type="date" class="form-control input-inline end-date" name="BENEFIT_END" />
                                                </div>
                                            </div>
                                    </div>
                                </div>
                                <div class="x_panel tile etc-info">
                                    <div class="x_title">
                                        <h2>기타정보 등록</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">종교
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <select name="RELIGION" id="RELIGION" class="form-control">
                                                        <option value="무교">무교</option>
                                                        <option value="불교">불교</option>
                                                        <option value="기독교">기독교(천주교/개신교)</option>
                                                        <option value="기타">기타</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">업무성향
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <ul class="list-unstyled">
                                                        <li>
                                                            <input type="checkbox" class="flat" id="WORK_TYPE_INHOUSE" name="WORK_TYPE_INHOUSE">
                                                            <label for="">입주 선호
                                                            </label>
                                                        </li>
                                                        <li>
                                                            <input type="checkbox" class="flat" id="WORK_TYPE_COMMUTE" name="WORK_TYPE_COMMUTE">
                                                            <label for="">출퇴근 선호
                                                            </label>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">특이사항
                                                </label>
                                                <div class="col-md-8 col-sm-8 col-xs-12">
                                                    <textarea name="MEMO" id="MEMO" rows="4" class="form-control"></textarea>
                                
                                                </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="x_panel tile">
                                    <div class="x_title">
                                        <h2>배속정보 등록</h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <!-- 소속지점선택 -->
                                        <h4>
                                            <i class="fa fa-map-marker"></i>
                                            소속지점
                                        </h4>
                                        <div class="row sido">
                                            <div class="col-md-2 col-sm-2 col-xs-12">
                                                <h4>
                                                    <i class="fa fa-check"></i>
                                                    시/도</h4>
                                                <select class="select2_single form-control" onchange="changedRegion_Belong()" id="regionBelong">
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
                                                <ul class="list-unstyled" id="subBelong">
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- 희망근무지역선택 -->
                                        <hr>
                                        <h4>
                                            <i class="fa fa-map-marker"></i>
                                            희망근무지역
                                        </h4>
                                        <div class="row sido">
                                            <div class="col-md-2 col-sm-2 col-xs-12">
                                                <h4>
                                                    <i class="fa fa-check"></i>
                                                    시/도</h4>
                                                <select class="select2_single form-control" onchange="changedRegion_Wish()" id="regionWish">
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
                                                <ul class="list-unstyled" id="subWish">
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="btn-group-bottom text-center">
                        <a class="btn btn-default btn-sm helper-save-cancel" onclick="cancel()">취소</a>
                        <a class="btn btn-primary btn-sm helper-save" onclick="saveMe()">저장</a>
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
    <!-- DateJS -->
    <script src="./vendors/DateJS/build/date.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="./vendors/moment/min/moment.min.js"></script>
    <script src="./vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="./vendors/jquery-ui-1.12.1.custom/datepicker-ko-KR.js"></script>
    <script src="./vendors/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>

    <!-- iCheck -->
    <script src="./vendors/iCheck/icheck.min.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="./build/js/custom.min.js"></script>
</body>

</html>