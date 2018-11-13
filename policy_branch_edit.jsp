<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%
    List<Region> lstRegionsGroup; //= _userdb.getGiftList();
    List<Region> lstRegionsAll; //= _userdb.getGiftList();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Branch item = null;
    Member member = null;
    Region curRegion = null;
    Region upRegion = null;
    int _index = -1;
    int upper = -1;

    String branch = request.getParameter("BRANCH");
    _index = Integer.parseInt(branch);
    item = UserDB.getBranch(_index);

    lstRegionsGroup = UserDB.getRegionList(-1);
    lstRegionsAll = UserDB.getRegionList(0);

    String[] business = item._business.split("-");
    String[] registration = item._registration.split("-");

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
    //region = _userdb.getMember(item._region);
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 지사정보수정</title>

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

        var memberIndex = <%= item._member %>;
        var branchIndex = <%= item._index %>;
        var selectedRegion = <%= item._region %>;

        function setEditFields() {
            //alert('<%= upRegion._name %>');
            $("#region").val(<%= upRegion._index %>);
            $("#BANK_NAME").val('<%= item._bankName %>');
            $("#VOUCHER_NAME").val('<%= item._voucherName %>');
            changedRegion();
            setRegion(<%= curRegion._index %>);
        }

        $(document).ready(function() {
            /*
            $("#search").click(function() {
                var myWindow = window.open("sub_select_member.jsp?SEARCH=" + $("#PATTERN").val(), "selectHelper", "width=500,height=500");
            });
            */
            $("#save").click(function() {
                if (checkRegionSel() == false) {
                    alert("지역이 선택되지 않았습니다.");
                    return;
                }
                /*
                if (memberIndex == -1) {
                    alert("지사 계정이 선택되지 않았습니다.");
                    return;
                }
                */
                //alert('Member:' + memberIndex);
                //var val = 'INDEX=' + branchIndex + '&MEMBER=' + memberIndex + '&' + $("#formData").serialize();
                var val = 'INDEX=' + branchIndex + '&' + $("#formData").serialize();
                //var val = $("#formData").serialize();
                //alert('저장합니다[' + val + "]");
                //$("#PROFILE").val(val);
                //return;////////

                $.post("_branch_update.jsp", val)
                .fail(function(response) {
                    $("#PROFILE").val(response.responseText);
                })
                .done(function(data) {
                    //alert(data);
                    window.location.href = 'content_branch_list.jsp';
                    //location.reload();
                });
            });
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

        function saveMe() {
            if (checkRegionSel() == false) {
                alert("지역이 선택되지 않았습니다.");
                return;
            }
            var val = '';
            val += 'INDEX=' + branchIndex + '&';
            val += 'MEMBER=' + memberIndex + '&';
            val += 'REGION=' + selectedRegion + '&';
            val += $("#formData").serialize();
            //alert(val);
            //return;////////

            $.post("_branch_update.jsp", val)
            .fail(function(response) {
                $("#PROFILE").val(response.responseText);
            })
            .done(function(data) {
                //alert(data);
                window.location.href = 'policy_branch.jsp';
                //location.reload();
            });
        }

        function addExtension() {
            alert('아직 미지원 입니다.');
        }
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col policy_manage_jisa_modify" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>지사정보수정</h3>
                        </div>
                        <div class="title_right">
                            <a class="btn btn-primary btn-sm pull-right jisa-save" data-toggle="modal" data-target=".jisa-save-modal" >저장</a>
                            <a class="btn btn-default btn-sm pull-right jisa-cancel" onclick="window.history.go(-1)" >취소</a>
                            <a class="btn btn-danger btn-sm pull-right jisa-delete" data-toggle="modal" data-target=".jisa-delete-modal" >삭제</a>
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
                            <!-- 지사수정완료 팝업 -->
                            <div class="modal fade bs-example-modal-sm jisa-save-modal" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog modal-sm">
                                    <div class="modal-content">
                            
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">
                                                <span aria-hidden="true">×</span>
                                            </button>
                                            <h4 class="modal-title" id="myModalLabel">지사정보수정</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>수정 완료하였습니다.</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="saveMe()">확인</button>
                                        </div>
                            
                                    </div>
                                </div>
                            </div>
                            <!-- 지사수정완료 팝업 -->
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
                                            <select class="select2_single form-control" onchange="changedRegion()" id=region>
                                            <%
                                            for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
                                            {
                                                Region r = (Region)it.next();
                                                out.write("<option value=" + r._index + ">" + r._name + "</option>");
                                            }
                                            %>
                                            </select>
                                            <!--
                                            <select class="select2_single form-control">
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
                                            </select>
                                            -->
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
                                                    <label for="">성동
                                                        <span class="badge bg-default">0</span>
                                                    </label>
                                                </li>
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
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile">
                                <div class="x_title">
<!--                                    <h2>계약자 &middot; 사업자명 &middot; 아이디 확인 / 비밀번호 변경</h2>-->
                                    <h2>계약자 &middot; 사업자명 &middot; 아이디 확인 </h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content pw-change">
                                    <div class="row">
                                        <dl>
                                            <dt>계약자</dt>
                                            <dd><%= member._contractor %></dd>
                                            <dt>사업자명</dt>
                                            <dd><%= member._business %></dd>
                                            <dt>아이디</dt>
                                            <dd><%= member._id %></dd>
                                            <!--
                                            <dt>비밀번호변경</dt>
                                            <dd><input type="password" class="form-control"></dd>
                                            -->
                                        </dl>
                                        
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
                                                    <input type="text" id="OPERATOR" name="OPERATOR" required="required" class="form-control col-md-7 col-xs-12" value='<%= item._operator %>'>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사업자 번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="BUSINESS1" name="BUSINESS1" required="required" class="form-control input-inline" value='<%= business[0] %>' > -
                                                    <input type="text" id="BUSINESS2" name="BUSINESS2" required="required"
                                                        class="form-control input-inline" value='<%= business[1] %>' > -
                                                    <input type="text" id="BUSINESS3" name="BUSINESS3" required="required"
                                                        class="form-control input-inline" value='<%= business[2] %>' >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">직업소개등록번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    제
                                                    <input type="text" id="REGISTRATION1" name="REGISTRATION1" required="required"
                                                        class="form-control input-inline" value='<%= registration[0] %>'>
                                                    <input type="text" id="REGISTRATION2" name="REGISTRATION2" required="required"
                                                        class="form-control input-inline" value='<%= registration[1] %>'>
                                                    <input type="text" id="REGISTRATION3" name="REGISTRATION3" required="required" class="form-control input-inline" value='<%= registration[2] %>'>
                                                    <input type="text" id="REGISTRATION4" name="REGISTRATION4" required="required" class="form-control input-inline" value='<%= registration[3] %>'>
                                                    <input type="text" id="REGISTRATION5" name="REGISTRATION5" required="required" class="form-control input-inline" value='<%= registration[4] %>'> 호
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">사무실 주소
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <div class="input-group">
                                                        <input type="text" id="POST" name="POST" class="form-control" placeholder="우편번호" value='<%= item._post %>' >
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-primary btn-addr-search">검색</button>
                                                        </span>
                                                    </div>
                                                    <input type="text" id="ADDRESS1" name="ADDRESS1" class="form-control addr1" placeholder="주소" value='<%= item._address1 %>'>
                                                    <input type="text" id="ADDRESS2" name="ADDRESS2" class="form-control addr2" placeholder="상세주소" value='<%= item._address2 %>'>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">일반서비스 계좌번호
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <select name="BANK_NAME" id="BANK_NAME" class="form-control input-inline" >
                                                        <option value="기업은행">기업은행</option>
                                                        <option value="카카오뱅크">카카오뱅크</option>
                                                        <option value="국민은행">국민은행</option>
                                                    </select>
                                                    <input type="number" id="BANK_ACCOUNT" name="BANK_ACCOUNT" class="form-control input-inline bank-account-num" value='<%= item._bankAccount %>' >
                                                    <input type="text" id="BANK_OWNER" name="BANK_OWNER" class="form-control input-inline account-holder" placeholder="예금주" value='<%= item._bankOwner %>' >
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
                                                    <input type="number" id="VOUCHER_NAME" name="VOUCHER_NAME" class="form-control input-inline bank-account-num" value='<%= item._voucherAccount %>' >
                                                    <input type="text" id="VOUCHER_OWNER" name="VOUCHER_OWNER" class="form-control input-inline account-holder" placeholder="예금주" value='<%= item._voucherOwner %>'>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">이메일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="email" id="EMAIL" name="EMAIL" class="form-control" placeholder="address@naver.com" value='<%= item._email %>' >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">휴대전화
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="MOBILE" name="MOBILE" class="form-control" placeholder="010-6515-6545" value='<%= item._mobile %>' >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">사무실(일반)전화
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="OFFICE" name="OFFICE" class="form-control" placeholder="02-5541-5512" value='<%= item._office %>' >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">팩스
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" id="FAX" name="FAX" class="form-control" placeholder="02-5541-5512" value='<%= item._fax %>' >
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약체결일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" id="CONTRACT_MADE" name="CONTRACT_MADE" class="form-control" value='<%= df.format(item._contractMade ) %>' >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약시작
                                                </label> 
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="da te" id="CONTRACT_BEGIN" name="CONTRACT_BEGIN" class="form-control" value='<%= df.format(item._contractBegin) %>' >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">계약만료일
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="date" id="CONTRACT_END" name="CONTRACT_END" class="form-control" value='<%= df.format(item._contractEnd) %>'>
                                                </div>
                                            </div>
                                            <div class="form-group contract-extend">
                                                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                                    <blockquote>
                                                        <p>* 기본 계약정보는 변경할 수 없습니다.</p>
                                                        <p>* 계약자가 변경되는 경우에는 신규 등록하세요.</p>
                                                    </blockquote>
                                                    <dl>
                                                        <dt>연장체결일</dt>
                                                        <dd>
                                                            <div class="input-group">
                                                                <input type="date" class="form-control ">
                                                            </div>
                                                        </dd>
                                                        <dt>연장시작일</dt>
                                                        <dd>
                                                            <div class="input-group">
                                                                <input type="date" class="form-control ">
                                                            </div>
                                                        </dd>
                                                        <dt>연장만료일</dt>
                                                        <dd>
                                                            <div class="input-group">
                                                                <input type="date" class="form-control ">
                                                            </div>
                                                        </dd>
                                                    </dl>
                                                    <a href="#!" class="btn btn-primary btn-sm" onclick='addExtension()'>연장정보 반영</a>
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>번호</th>
                                                                <th>연장체결일</th>
                                                                <th>연장시작일</th>
                                                                <th>연장만료일</th>
                                                                <th>삭제</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id=extension>
                                                            <!--
                                                            <tr>
                                                                <th scope="row">3</th>
                                                                <td>2018.05.20</td>
                                                                <td>2018.06.20</td>
                                                                <td>2019.05.20</td>
                                                                <td><a href="#!" class="btn btn-xs btn-danger btn-mb-0">삭제</a></td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">2</th>
                                                                <td>2018.05.20</td>
                                                                <td>2018.06.20</td>
                                                                <td>2019.05.20</td>
                                                                <td>
                                                                    <a href="#!" class="btn btn-xs btn-danger btn-mb-0">삭제</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">1</th>
                                                                <td>2018.05.20</td>
                                                                <td>2018.06.20</td>
                                                                <td>2019.05.20</td>
                                                                <td>
                                                                    <a href="#!" class="btn btn-xs btn-danger btn-mb-0">삭제</a>
                                                                </td>
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
                                            <hr>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">약력(경력사항)
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <textarea name="PROFILE" id="PROFILE" class="form-control"><%= item._profile %></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">특약사항
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <textarea name="SPECIAL" id="SPECIAL" class="form-control"><%= item._special %></textarea>
                                                </div>
                                            </div>
                                            <div class="btn-group-bottom text-center">
                                                <a class="btn btn-danger btn-sm jisa-delete" data-toggle="modal" data-target=".jisa-delete-modal" >삭제</a>
                                                <a class="btn btn-default btn-sm jisa-cancel" onclick="window.history.go(-1)" >취소</a>
                                                <a class="btn btn-primary btn-sm jisa-save" data-toggle="modal" data-target=".jisa-save-modal" >저장</a>
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