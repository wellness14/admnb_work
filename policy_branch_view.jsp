<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%
    List<Region> lstRegionsGroup; //= _userdb.getGiftList();
    List<Region> lstRegionsAll; //= _userdb.getGiftList();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Branch item = null;
    int _index = -1;
    //int _index = -1;

    lstRegionsGroup = UserDB.getRegionList(-1);
    lstRegionsAll = UserDB.getRegionList(0);


    String branch = request.getParameter("BRANCH");
    _index = Integer.parseInt(branch);
    item = UserDB.getBranch(_index);
/*
    Branch item = null;
    Member member = null;
    Region curRegion = null;
    Region upRegion = null;
    int upper = -1;

    String branch = request.getParameter("BRANCH");
    _index = Integer.parseInt(branch);
    item = _userdb.getBranch(_index);


    member = _userdb.getMember(item._member);

    for (Iterator i = lstRegionsAll.iterator(); i.hasNext(); )
    {
        Region r = (Region)i.next();
        if (r._index == item._region)
        {
            curRegion = r;
        }
    }
    for (Iterator i = lstRegionsGroup.iterator(); i.hasNext(); )
    {
        Region r = (Region)i.next();
        if (r._index == curRegion._upper)
        {
            upRegion = r;
        }
    }
*/
    String[] business = item._business.split("-");
    String[] registration = item._registration.split("-");

%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 지사상세정보</title>

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

        var branchIndex = <%= _index %>;

        $(document).ready(function() {
            $("#delete").click(function() {
                $.post("_branch_update.jsp?DELETE&INDEX=" + branchIndex, '')
                .fail(function(response) {
                    $("#PROFILE").val(response.responseText);
                })
                .done(function(data) {
                    window.location.href = 'content_branch_list.jsp';
                });
            });
            $("#edit").click(function() {
                window.location.href = 'content_branch_edit.jsp?BRANCH=' + branchIndex;
            });
            $("#list").click(function() {
                window.location.href = 'content_branch_list.jsp';
            });
        });

        function checkRegionSel() {
            var checked = false;
            var boxs = document.getElementsByName("REGION");
            for (var i = 0; i < boxs.length; i++) {
                if (boxs[i].checked == true) {
                    checked = true;
                    break;
                }
            }
            return checked;
        }

        function setRegion(index) {
            //alert(index);
            var boxs = document.getElementsByName("REGION");
            for (var i = 0; i < boxs.length; i++) {
                if (boxs[i].value != index)
                    boxs[i].checked = false;
            }
        }
        function changedRegion() {
            var html = "";
            for (var i = 0; i < regions.length; i++) {
                if (regions[i]._upper == $("#region").val()) {
                    html += "<input type='checkbox' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
                }
            }
            document.getElementById('sub').innerHTML = html;
        }

        function setMember(index, contractor, business, id) {
            document.getElementById('CONTRACTOR').innerHTML = contractor;
            document.getElementById('BUSINESS').innerHTML = business;
            document.getElementById('ID').innerHTML = id;
            memberIndex = index;
        }

        function deleteMe() {
            $.post("_branch_update.jsp?DELETE&INDEX=" + branchIndex, '')
            .fail(function(response) {
                $("#PROFILE").val(response.responseText);
            })
            .done(function(data) {
                window.location.href = 'policy_branch.jsp';
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
            <div class="right_col policy_manage_jisa_detail" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>지사 관리</h3>
                        </div>
                        <div class="title_right">
                            <a href="policy_branch.jsp" class="btn btn-primary btn-sm pull-right go-list">목록</a>
                            <a href="policy_branch_edit.jsp?BRANCH=<%=_index%>" class="btn btn-default btn-sm pull-right jisa-modify">수정</a>
                            <a href="#!" class="btn btn-danger btn-sm pull-right jisa-delete" data-toggle="modal" data-target=".jisa-delete-modal">삭제</a>
                            <!-- 지사삭제 팝업 -->
                            <div class="modal fade bs-example-modal-sm jisa-delete-modal" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog modal-sm">
                                    <div class="modal-content">
                            
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">
                                                <span aria-hidden="true">×</span>
                                            </button>
                                            <h4 class="modal-title" id="myModalLabel">지사정보삭제</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>지사정보를 삭제할까요?</p>
                                            <p>삭제된 정보는 복구되지 않습니다.</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
                                            <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" onclick="deleteMe()">삭제</button>
                                        </div>
                            
                                    </div>
                                </div>
                            </div>
                            <!-- 지사삭제 팝업 -->
                        </div>
                    </div>

                    <div class="row">
                        <!-- 지사정보수정 -->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>지사정보</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content jisa-info">
                                    <div class="row">
                                        <form id="formData" data-parsley-validate class="form-horizontal form-label-left">

                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">운영자 이름
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="first-name" required="required" class="form-control col-md-7 col-xs-12" value='<%= item._operator %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사업자 번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="last-name" name="last-name" required="required" class="form-control input-inline" value='<%= business[0] %>' readonly> -
                                                    <input type="text" id="last-name" name="last-name" required="required"
                                                        class="form-control input-inline" value='<%= business[1] %>' readonly> -
                                                    <input type="text" id="last-name" name="last-name" required="required"
                                                        class="form-control input-inline" value='<%= business[2] %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">직업소개등록번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    제
                                                    <input type="text" id="last-name" name="last-name" required="required"
                                                        class="form-control input-inline" value='<%= registration[0] %>' readonly>
                                                    <input type="text" id="last-name" name="last-name" required="required"
                                                        class="form-control input-inline" value='<%= registration[1] %>' readonly>
                                                    <input type="text" id="last-name" name="last-name" required="required" class="form-control input-inline" value='<%= registration[2] %>' readonly>
                                                    <input type="text" id="last-name" name="last-name" required="required" class="form-control input-inline" value='<%= registration[3] %>' readonly>
                                                    <input type="text" id="last-name" name="last-name" required="required" class="form-control input-inline" value='<%= registration[4] %>' readonly> 호
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">사무실 주소
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" placeholder="우편번호" value='<%= item._post %>' readonly>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-primary btn-addr-search">검색</button>
                                                        </span>
                                                    </div>
                                                    <input type="text" class="form-control addr1" placeholder="주소" value='<%= item._address1 %>' readonly>
                                                    <input type="text" class="form-control addr2" placeholder="상세주소" value='<%= item._address2 %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">일반서비스 계좌번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control input-inline account-holder" placeholder="예금주" value='<%= item._bankName %>' readonly>
                                                    <!--
                                                    <select name="" id="" class="form-control input-inline" readonly>
                                                        <option value="">기업은행</option>
                                                        <option value="">카카오뱅크</option>
                                                        <option value="">국민은행</option>
                                                    </select>
                                                    -->
                                                    <input type="number" class="form-control input-inline bank-account-num" value='<%= item._bankAccount %>' readonly>
                                                    <input type="text" class="form-control input-inline account-holder" placeholder="예금주" value='<%= item._bankOwner %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">바우처서비스 계좌번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control input-inline account-holder" placeholder="예금주" value='<%= item._voucherName %>' readonly>
                                                    <!--
                                                    <select name="" id="" class="form-control input-inline" readonly>
                                                        <option value="">기업은행</option>
                                                        <option value="">카카오뱅크</option>
                                                        <option value="">국민은행</option>
                                                    </select>
                                                    -->
                                                    <input type="number" class="form-control input-inline bank-account-num" value='<%= item._voucherAccount %>' readonly>
                                                    <input type="text" class="form-control input-inline account-holder" placeholder="예금주" value='<%= item._voucherOwner %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">이메일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="email" class="form-control" placeholder="address@naver.com" value='<%= item._email %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">휴대전화
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" placeholder="010-6515-6545" value='<%= item._mobile %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사무실(일반)전화
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" placeholder="02-5541-5512" value='<%= item._office %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">팩스
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" placeholder="02-5541-5512" value='<%= item._fax %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약체결일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" class="form-control" value='<%= df.format(item._contractMade) %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약시작
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" class="form-control" value='<%= df.format(item._contractBegin) %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약만료일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" class="form-control" value='<%= df.format(item._contractEnd) %>' readonly>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">약력(경력사항)
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <textarea name="" id="" class="form-control" readonly><%= item._profile %></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">특약사항
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <textarea name="" id="" class="form-control" readonly><%= item._special %></textarea>
                                                </div>
                                            </div>
                                        </form>
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