<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%
    List<Region> lstRegionsGroup; //= _userdb.getGiftList();
    List<Region> lstRegionsAll; //= _userdb.getGiftList();
    int index = -1;
    //int _index = -1;

    lstRegionsGroup = UserDB.getRegionList(-1);
    lstRegionsAll = UserDB.getRegionList(0);
/*
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

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
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 지사관리</title>

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

        var memberIndex = -1;
        var selectedRegion = -1;

        function setEditFields() {
                changedRegion();
        }

        $(document).ready(function() {
            $("#search").click(function() {
                //var myWindow = window.open("sub_select_member.jsp?SEARCH=" + $("#PATTERN").val(), "selectHelper", "width=500,height=500");
                //alert("search");
                var val = '';
                val += "SEARCH=" +  $("#PATTERN").val() + "&";
                $.post("sub/sub_member_list.jsp", val)
                .fail(function(response) {
                    //alert('Error: ' + response.responseText);
                    //$("#PROFILE").val(response.responseText);
                })
                .done(function(data) {
                    //alert(data);
                    //location.reload();
                    document.getElementById('listMember').innerHTML = data;
                    //window.location.href = 'content_branch_list.jsp';
                });
            });
            $("#cancel").click(function() {
                window.location.href = 'policy_branch.jsp';
            });
            $("#save").click(function() {
                if (checkRegionSel() == false) {
                    alert("지역이 선택되지 않았습니다.");
                    return;
                }
                if (memberIndex == -1) {
                    alert("지사 계정이 선택되지 않았습니다.");
                    return;
                }
                var val = '';
                val += 'MEMBER=' + memberIndex + '&';
                val += 'REGION=' + selectedRegion + '&';
                val += $("#formData").serialize();
                //var val = $("#formData").serialize();
                //alert('저장합니다[' + val + "]");
                //$("#PROFILE").val(val);
                //return;////////

/*
                if ($("#CONTENTS").val().length == 0) {
                    alert('내용이 입력되지 않았습니다.');
                    return;
                }
                if ($("#APPLY_DATE").val().length == 0) {
                    alert('적용일이 입력되지 않았습니다.');
                    return;
                }
*/
                //alert(val);
                //$.post("_terminal_update.jsp", $("#term").serialize() + "&INDEX=" + '<%= index %>')
                $.post("_branch_update.jsp", val)
                .fail(function(response) {
                    //alert('Error: ' + response.responseText);
                    $("#PROFILE").val(response.responseText);
                })
                .done(function(data) {
                    //alert(data);
                    //location.reload();
                    window.location.href = 'policy_branch.jsp';
                });
            });

            //$("#moveGift").click(function() {
            //  window.location.href = "content_gift_list.jsp";
            //});
        });
        window.onload = setEditFields;

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
            var boxs = document.getElementsByName("REGION");
            for (var i = 0; i < boxs.length; i++) {
                if (boxs[i].value != index)
                    boxs[i].checked = false;
                else {
                    selectedRegion = index;
                    boxs[i].checked = true;
                }
            }
        }

        function changedRegion() {
            //alert($("#region").val());
            var html = "";
            for (var i = 0; i < regions.length; i++) {
                if (regions[i]._upper == $("#region").val()) {
                    //html += "<input type='checkbox' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
                    html += "<li><input type='checkbox' class='flat' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " /><label for=''>" + regions[i]._name + "<span class='badge bg-purple'>0</span></label></li>";
                }
            }
            document.getElementById('sub').innerHTML = html;
        }

        function setMember(index, contractor, business, id) {
            document.getElementById('CONTRACTOR').innerHTML = contractor;
            document.getElementById('BUSINESS').innerHTML = business;
            document.getElementById('ID').innerHTML = id;
            memberIndex = index;
            $('#jisa-search-modal').modal('hide');
        }
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col policy_manage_jisa_new" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>지사 관리</h3>
                        </div>
                        <div class="title_right">
                            <a id="save" class="btn btn-primary btn-sm pull-right jisa-save">저장</a>
                            <a id="cancel" class="btn btn-default btn-sm pull-right">취소</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>가맹지역 선택/변경</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <!-- 지역선택 -->
                                    <div class="row sido">
                                        <div class="col-md-2 col-sm-2 col-xs-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                시/도</h4>
                                            <select class="select2_single form-control" onchange="changedRegion()" id=region >
                                                <%
                                                for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
                                                {
                                                    Region r = (Region)it.next();
                                                    out.write("<option value=" + r._index + ">" + r._name + "</option>");
                                                }
                                                %>
                                                <!--
                                                <option value="">서울(15)</option>
                                                <option value="">경기도(5)</option>
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
                                                -->
                                            </select>
                                        </div>
                                        <div class="col-md-10 col-sm-10 col-xs-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                시/군/구</h4>
                                            <ul class="list-unstyled">
                                                <div id=sub></div>
                                                <!--
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">광진
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">중랑
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">도봉
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">노원
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강북
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">성북
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">종로
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">서대문
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">은평
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">마포
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강서
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">양천
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">구로
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">영등포
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">금천
                                                        <span class="badge bg-purple">홍길동</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">관악
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">동작
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">서초
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강남
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">송파
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강동
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">동대문
                                                        <span class="badge bg-blue">본사</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">중구
                                                        <span class="badge bg-default">0</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">용산
                                                        <span class="badge bg-default">0</span>
                                                    </label>
                                                </li>
                                                -->
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <blockquote>
                                        <p>* 동일 지역에 중복 선택 안됨(1지역 1지사장 원칙입니다.)</p>
                                        <p>* 이미 배정된 지역에 배치하고 싶은 경우
                                            <ul>
                                                <li>기존에 배정된 지사의 배정 정보 해제</li>
                                                <li>배정 정보 해제는 해당 지사 정보의 수정페이지에서 가능합니다.</li>
                                            </ul>
                                        </p>
                                    </blockquote>
                                </div>
                            </div>
                        </div>
                        <!-- 지사계정 불러오기 -->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
                                    <h2>지사계정 불러오기</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content load-jisa">
                                    <div class="row">
                                        <div class="col-md-3 col-sm-3">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="PATTERN" placeholder="이름, ID, 핸드폰번호" />
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".jisa-search-modal" id="search">검색</button>
                                                </span>
                                            </div>
                                            <!-- 지사계정 불러오기 팝업 -->
                                            <div class="modal fade bs-example-modal-lg jisa-search-modal" tabindex="-1" role="dialog" aria-hidden="true" id='jisa-search-modal'>
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                            
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal">
                                                                <span aria-hidden="true">×</span>
                                                            </button>
                                                            <h4 class="modal-title" id="myModalLabel">지사계정선택</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>아이디</th>
                                                                        <th>계약자명</th>
                                                                        <th>사업자명</th>
                                                                        <th>#</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id=listMember>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <!-- <div class="modal-footer">
                                                            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
                                                            <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">보내기</button>
                                                        </div> -->
                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 지사계정 불러오기 팝업 -->
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="animated flipInY col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <div class="icon">
                                                    <i class="fa fa-user"></i>
                                                </div>
                                                <div class="count" >계약자</div>
                                                <h3 id="CONTRACTOR">미입력</h3>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <div class="icon">
                                                    <i class="fa fa-building-o"></i>
                                                </div>
                                                <div class="count" >사업자명</div>
                                                <h3 id="BUSINESS">미입력</h3>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <div class="icon">
                                                    <i class="fa fa-key"></i>
                                                </div>
                                                <div class="count" >아이디</div>
                                                <h3 id="ID">Unknown</h3>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-sm-12">
                                            <blockquote>
                                                * 지사장님이 검색되지 않으세요? '기본정책 > 관리자 > 지사계정생성' 을 통해 지사의 계정을 먼저 생성해야 합니다.
                                                <a href="policy_member_add.jsp" class="btn btn-sm btn-primary">지사계정생성 이동</a>
                                            </blockquote>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <!-- 지사정보등록 -->
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
                                                    <input type="text" name="OPERATOR" id="first-name" required="required" class="form-control col-md-7 col-xs-12">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사업자 번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="BUSINESS1" name="BUSINESS1" required="required" class="form-control input-inline"> - <input type="text" id="BUSINESS2" name="BUSINESS2" required="required" class="form-control input-inline"> - <input type="text" id="BUSINESS3" name="BUSINESS3" required="required" class="form-control input-inline">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">직업소개등록번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    제 <input type="text" id="REGISTRATION1" name="REGISTRATION1" required="required" class="form-control input-inline">                 <input type="text" id="REGISTRATION2" name="REGISTRATION2" required="required" class="form-control input-inline">
                                                    <input type="text" id="REGISTRATION3" name="REGISTRATION3" required="required" class="form-control input-inline">
                                                    <input type="text" id="REGISTRATION4" name="REGISTRATION4" required="required" class="form-control input-inline">
                                                    <input type="text" id="REGISTRATION5" name="REGISTRATION5" required="required" class="form-control input-inline"> 호
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">사무실 주소
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" id="POST" name="POST" placeholder="우편번호">
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-primary btn-addr-search">검색</button>
                                                        </span>
                                                    </div>
                                                    <input type="text" id="ADDRESS1" name="ADDRESS1" class="form-control addr1" placeholder="주소">
                                                    <input type="text" id="ADDRESS2" name="ADDRESS2" class="form-control addr2" placeholder="상세주소">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">일반서비스 계좌번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <select name="BANK_NAME" id="BANK_NAME" class="form-control input-inline">
                                                        <option value="기업은행">기업은행</option>
                                                        <option value="카카오뱅크">카카오뱅크</option>
                                                        <option value="국민은행">국민은행</option>
                                                    </select>
                                                    <input type="number" name="BANK_ACCOUNT" class="form-control input-inline bank-account-num">
                                                    <input type="text" name="BANK_OWNER" class="form-control input-inline account-holder" placeholder="예금주">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">바우처서비스 계좌번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <select name="VOUCHER_NAME" id="VOUCHER_NAME" class="form-control input-inline">
                                                        <option value="기업은행">기업은행</option>
                                                        <option value="카카오뱅크">카카오뱅크</option>
                                                        <option value="국민은행">국민은행</option>
                                                    </select>
                                                    <input type="number" name="VOUCHER_ACCOUNT" id="VOUCHER_ACCOUNT" class="form-control input-inline bank-account-num">
                                                    <input type="text" name="VOUCHER_OWNER" id="VOUCHER_OWNER" class="form-control input-inline account-holder" placeholder="예금주">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name" >이메일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="email" class="form-control" placeholder="address@naver.com" name="EMAIL" id="EMAIL" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">휴대전화
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" placeholder="010-6515-6545" name="MOBILE" id="MOBILE" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사무실(일반)전화
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" placeholder="02-5541-5512" name="OFFICE" id="OFFICE">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">팩스
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control" placeholder="02-5541-5512" name="FAX" id="FAX">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약체결일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" class="form-control" name="CONTRACT_MADE" id="CONTRACT_MADE">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약시작
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" class="form-control" name="CONTRACT_BEGIN" id="CONTRACT_BEGIN">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약만료일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" class="form-control" name="CONTRACT_END" id="CONTRACT_END">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">약력(경력사항)
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <textarea name="PROFILE" id="PROFILE" class="form-control" ></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">특약사항
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <textarea name="SPECIAL" id="SPECIAL" class="form-control" name="SPECIAL" id="SPECIAL"></textarea>
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