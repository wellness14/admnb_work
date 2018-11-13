<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%
    int selTab = 1;
    String temp = request.getParameter("TAB");
    if (temp != null)
    {
        selTab = Integer.parseInt(temp);
    }
    else
    {
        selTab = 1;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - 선물관리</title>

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
    <script src="./js/policy_gifts_gift.js"></script>
    <script src="./js/policy_gifts_terminal.js"></script>
    <script src="./js/policy_gifts_rental.js"></script>
    <script>
        $(function() {
            // TODO: set labels with "xxx 등록";
            clearGift();
            loadGiftList();

            clearRental();
            loadRentalList();

            clearTerminal();
            loadTerminalList();
        });
    </script>
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col policy_manage_gift" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">선물/대여품/단말기</a> &gt;
                        <a href="#!">선물/대여품/단말기 관리</a>
                    </div>
                    <!-- <div class="page-title">
                        <div class="title_left">
                            <h3>선물관리</h3>
                        </div>
                    </div> -->

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>
                                        선물 , 대여품 , 단말기 관리
                                    </h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                            
                                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                                        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                            <li role="presentation" class='<%= (selTab == 1) ? "active" : "" %>'>
                                                <a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">선물</a>
                                            </li>
                                            <li role="presentation" class='<%= (selTab == 2) ? "active" : "" %>'>
                                                <a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">대여품</a>
                                            </li>
                                            <li role="presentation" class='<%= (selTab == 3) ? "active" : "" %>'>
                                                <a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">단말기</a>
                                            </li>
                                        </ul>
                                        <div id="myTabContent" class="tab-content">
                                            <div role="tabpanel" class='tab-pane fade <%= (selTab == 1) ? "active in" : "" %>' id="tab_content1" aria-labelledby="home-tab">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="x_panel tile">
                                                            <div class="x_title">
                                                                <h2 id="gift_input_type">선물 등록</h2>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                                                                <div class="form-group">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">노출상태
                                                                    </label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                        <div class="radio-group">
                                                                            <label>
                                                                                <input type="radio" name="GIFT_EXPOSED" value="1"> 노출
                                                                            </label>
                                                                            <label>
                                                                                <input type="radio" name="GIFT_EXPOSED" value="0"> 노출안함
                                                                            </label>
                                                                        </div>        
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">gift번호
                                                                    </label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                                        <input type="text" required="required" class="form-control col-md-7 col-xs-12" placeholder="내용을 입력해주세요." name="GIFT_NUM", id="GIFT_NUM">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">상품명</label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                                        <input class="form-control col-md-7 col-xs-12" type="text" placeholder="내용을 입력해주세요." name="GIFT_NAME" id="GIFT_NAME">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">상품이미지</label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                        <div class="radio-group">
                                                                            <label>
                                                                                <input type="radio" name="GIFT_IMAGE_TYPE" value="1"> 직접등록
                                                                            </label>
                                                                            <label>
                                                                                <input type="radio" name="GIFT_IMAGE_TYPE" value="0"> url입력
                                                                            </label>
                                                                        </div>
                                                                        <!-- 직접등록이 기본값. url입력시에는 직접파일등록부분은 숨김처리 -->
                                                                        <div class="input-group">
                                                                            <input type="file" class="form-control gift-img-search">
                                                                            <span class="input-group-btn">
                                                                                <button type="button" class="btn btn-primary btn-sm">찾아보기</button>
                                                                            </span>
                                                                        </div>
                                                                        <input type="text" class="form-control" placeholder="http://">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">매입가</label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                                        <input type="text" class="form-control" name="GIFT_PRICE" id="GIFT_PRICE">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">수량</label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                                        <input type="text" class="form-control" name="GIFT_QUANTITY" id="GIFT_QUANTITY">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">지급대상서비스</label>
                                                                    <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            베이직
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="BASIC_COMMUTE_W1">
                                                                                <label for="">출퇴근 1주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="BASIC_COMMUTE_W2">
                                                                                <label for="">출퇴근 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="BASIC_COMMUTE_W3">
                                                                                <label for="">출퇴근 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="BASIC_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            프리미엄
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_COMMUTE_W1">
                                                                                <label for="">출퇴근 1주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_COMMUTE_W2">
                                                                                <label for="">출퇴근 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_COMMUTE_W3">
                                                                                <label for="">출퇴근 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_INHOUSE_W1">
                                                                                <label for="">입주 1주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_INHOUSE_W2">
                                                                                <label for="">입주 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_INHOUSE_W3">
                                                                                <label for="">입주 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PREMIUM_INHOUSE_W4">
                                                                                <label for="">입주 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            VIP
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_COMMUTE_W1">
                                                                                <label for="">출퇴근 1주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_COMMUTE_W2">
                                                                                <label for="">출퇴근 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_COMMUTE_W3">
                                                                                <label for="">출퇴근 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_INHOUSE_W1">
                                                                                <label for="">입주 1주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_INHOUSE_W2">
                                                                                <label for="">입주 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_INHOUSE_W3">
                                                                                <label for="">입주 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="VIP_INHOUSE_W4">
                                                                                <label for="">입주 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            프라이빗
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PRIVATE_COMMUTE_W2">
                                                                                <label for="">출퇴근 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PRIVATE_COMMUTE_W3">
                                                                                <label for="">출퇴근 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PRIVATE_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PRIVATE_INHOUSE_W2">
                                                                                <label for="">입주 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PRIVATE_INHOUSE_W3">
                                                                                <label for="">입주 3주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="PRIVATE_INHOUSE_W4">
                                                                                <label for="">입주 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            다둥이(쌍둥이)
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="TWIN_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                            <li class="col-md-4">
                                                                                <input type="checkbox" name="TARGETS" value="TWIN_MIXED_W2W2">
                                                                                <label for="">입주 2주 + 출퇴근 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="TWIN_INHOUSE_W4">
                                                                                <label for="">입주 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            다둥이(다둥이)
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="MULTI_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                            <li class="col-md-4">
                                                                                <input type="checkbox" name="TARGETS" value="MULTI_MIXED_W2W2">
                                                                                <label for="">입주 2주 + 출퇴근 2주</label>
                                                                            </li>
                                                                            <li class="col-md-3">
                                                                                <input type="checkbox" name="TARGETS" value="MULTI_INHOUSE_W4">
                                                                                <label for="">입주 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            집중관리(워킹맘)
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-6">
                                                                                <input type="checkbox" name="TARGETS" value="INTEN_WORKING_COMMUTE_W2W2">
                                                                                <label for="">입주 2주 + 출퇴근 2주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            집중관리(산후조리원 내집에)
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-6">
                                                                                <input type="checkbox" name="TARGETS" value="INTEN_HOME_MIXED_W2W2">
                                                                                <label for="">입주 2주 + 출퇴근 2주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            집중관리(35세 이상 산모 집중케어)
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-6">
                                                                                <input type="checkbox" name="TARGETS" value="INTEN_35_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                        <h5>
                                                                            <i class="fa fa-slack"></i>
                                                                            과체중 산모케어
                                                                        </h5>
                                                                        <div class="row">
                                                                        <ul class="list-unstyled">
                                                                            <li class="col-md-6">
                                                                                <input type="checkbox" name="TARGETS" value="INTEN_HEAVY_COMMUTE_W4">
                                                                                <label for="">출퇴근 4주</label>
                                                                            </li>
                                                                        </ul>
                                                                        </div>
                                                                        <hr>
                                                                    </div>
                                                                    <div class="col-md-3 col-md-offset-3">
                                                                        <!--<a class="btn btn-default btn-sm">취소</a>-->
                                                                        <a class="btn btn-primary btn-sm" onclick="saveGift()">저장</a>
                                                                    </div>
                                                                </div>
                                                                </div> <!-- end of form-group -->
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="table-responsive">
                                                            <!--<table class="table table-striped jambo_table bulk_action">-->
                                                            <table class="table table-striped jambo_table">
                                                                <thead>
                                                                    <tr class="headings">
                                                                        <!--<th>
                                                                            <input type="checkbox" id="check-all" class="flat">
                                                                        </th>-->
                                                                        <th>순번</th>
                                                                        <th class="column-title">gift번호</th>
                                                                        <th class="column-title">이미지</th>
                                                                        <th class="column-title">상품명</th>
                                                                        <th class="column-title">매입가</th>
                                                                        <th class="column-title">재고</th>
                                                                        <th class="column-title">노출상태</th>
                                                                        <th class="column-title">등록일</th>
                                                                        <th class="column-title">수정</th>
                                                                        <th class="column-title">삭제</th>
                                                                        <th class="column-title">지급대상 서비스</th>
                                                                        <th class="bulk-actions" colspan="9">
                                                                            <span class="action-cnt"> </span> 
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                        
                                                                <tbody id="giftList">
                                                                    <!--
                                                                    <tr class="even pointer">
                                                                        <td>
                                                                            <input type="checkbox" class="flat" name="table_records">
                                                                        </td>
                                                                        <td>10</td>
                                                                        <td>10</td>
                                                                        <td>
                                                                            <img src="images/picture.jpg" alt="선물이미지" class="gift-img">
                                                                        </td>
                                                                        <td>천장모빌</td>
                                                                        <td>120,000</td>
                                                                        <td>50</td>
                                                                        <td>노출</td>
                                                                        <td>2018.05.05</td>
                                                                        <td><a href="#!" class="btn btn-xs btn-primary btn-mb-0">수정</a></td>
                                                                        <td class="last">
                                                                            베이직 | 1주 2주 3주 4주
                                                                            <br/> 집중관리 (35세이상산모 집중케어) | 출퇴근 4주
                                                                            <br/> 집중관리 (워킹맘) | 입주2주+출퇴근2주
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="odd pointer">
                                                                        <td>
                                                                            <input type="checkbox" class="flat" name="table_records">
                                                                        </td>
                                                                        <td>10</td>
                                                                        <td>10</td>
                                                                        <td><img src="images/picture.jpg" alt="선물이미지" class="gift-img"></td>
                                                                        <td>천장모빌</td>
                                                                        <td>120,000</td>
                                                                        <td>50</td>
                                                                        <td>노출</td>
                                                                        <td>2018.05.05</td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-xs btn-primary btn-mb-0">수정</a>
                                                                        </td>
                                                                        <td class="last">
                                                                            베이직 | 1주 2주 3주 4주
                                                                            <br/> 집중관리 (35세이상산모 집중케어) | 출퇴근 4주
                                                                            <br/> 집중관리 (워킹맘) | 입주2주+출퇴근2주
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
                                                </div>
                                            </div>
                                            <div role="tabpanel" class='tab-pane fade <%= (selTab == 2) ? "active in" : "" %>' id="tab_content2" aria-labelledby="profile-tab">
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                                        <div class="x_panel tile">
                                                            <div class="x_title">
                                                                <h2 id="rental_input_type">대여품 등록</h2>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <div class="x_content">
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                                                                
                                                                            <div class="form-group">
                                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">노출상태
                                                                                </label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                                    <div class="radio-group">
                                                                                        <label>
                                                                                            <input type="radio" name="RENTAL_EXPOSED" value="1"> 노출
                                                                                        </label>
                                                                                        <label>
                                                                                            <input type="radio" name="RENTAL_EXPOSED" value="0"> 노출안함
                                                                                        </label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">대여번호
                                                                                </label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                                    <input type="text" required="required" class="form-control col-md-7 col-xs-12" placeholder="내용을 입력해주세요." name="RENTAL_NUM" id="RENTAL_NUM">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">상품명</label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                                    <input class="form-control col-md-7 col-xs-12" type="text" placeholder="내용을 입력해주세요." name="RENTAL_NAME" id="RENTAL_NAME">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">상품이미지</label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                                    <div class="radio-group">
                                                                                        <label>
                                                                                            <input type="radio" name="RENTAL_IMAGE_TYPE" value="1"> 직접등록
                                                                                        </label>
                                                                                        <label>
                                                                                            <input type="radio" name="RENTAL_IMAGE_TYPE" value="0"> url입력
                                                                                        </label>
                                                                                    </div>
                                                                                    <!-- 직접등록이 기본값. url입력시에는 직접파일등록부분은 숨김처리 -->
                                                                                    <div class="input-group">
                                                                                        <input type="file" class="form-control gift-img-search">
                                                                                        <span class="input-group-btn">
                                                                                            <button type="button" class="btn btn-primary btn-sm">찾아보기</button>
                                                                                        </span>
                                                                                    </div>
                                                                                    <input type="text" class="form-control" placeholder="http://">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">매입가</label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                                    <input type="text" class="form-control" name="RENTAL_PRICE" id="RENTAL_PRICE">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">수량</label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                                    <input type="text" class="form-control" name="RENTAL_QUANTITY" id="RENTAL_QUANTITY">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">제품설명</label>
                                                                                <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                                    <textarea name="RENTAL_DESCRIPTION" id="RENTAL_DESCRIPTION" rows="5" class="form-control"></textarea>
                                                                                </div>
                                                                                <div class="col-md-3 col-md-offset-3">
                                                                                    <a class="btn btn-primary btn-sm rent-save" onclick="saveRental()">저장</a>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                                        <div class="x_panel tile">
                                                            <div class="x_title">
                                                                <h2>대여품 리스트</h2>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <div class="x_content">
                                                                <ul class="list-unstyled msg_list" id="rentalList">
                                                                    <!--
                                                                    <li>
                                                                        <span class="image">
                                                                            <img src="images/picture.jpg" alt="img" />
                                                                        </span>
                                                                        <dl class="message">
                                                                            <dt>등록일 : </dt>
                                                                            <dd>2018.03.26</dd>
                                                                            <dt>노출상태 : </dt>
                                                                            <dd><span class="label label-success">노출중</span></dd>
                                                                            <dt>상품명 : </dt>
                                                                            <dd>메델라 락티나 전동식 모유 착유기</dd>
                                                                            <dt>매입가 : </dt>
                                                                            <dd>100,000원</dd>
                                                                            <dt>수량 : </dt>
                                                                            <dd>50개</dd>
                                                                            <dt>제품설명 : </dt>
                                                                            <dd>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Asperiores labore autem repudiandae, optio quas nisi vel sapiente quasi dolo</dd>
                                                                            <dt></dt>
                                                                            <dd>
                                                                                <hr>
                                                                                <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                                <a href="#!" class="btn btn-default btn-sm">삭제</a>
                                                                            </dd>
                                                                        </dl>
                                                                    </li>
                                                                    <li>
                                                                        <span class="image">
                                                                            <img src="images/picture.jpg" alt="img" />
                                                                        </span>
                                                                        <dl class="message">
                                                                            <dt>등록일 : </dt>
                                                                            <dd>2018.03.26</dd>
                                                                            <dt>노출상태 : </dt>
                                                                            <dd>
                                                                                <span class="label label-success">노출중</span>
                                                                            </dd>
                                                                            <dt>상품명 : </dt>
                                                                            <dd>메델라 락티나 전동식 모유 착유기</dd>
                                                                            <dt>매입가 : </dt>
                                                                            <dd>100,000원</dd>
                                                                            <dt>수량 : </dt>
                                                                            <dd>50개</dd>
                                                                            <dt>제품설명 : </dt>
                                                                            <dd>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Asperiores labore autem repudiandae, optio quas nisi vel
                                                                                sapiente quasi dolo</dd>
                                                                            <dt></dt>
                                                                            <dd>
                                                                                <hr>
                                                                                <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                                <a href="#!" class="btn btn-default btn-sm">삭제</a>
                                                                            </dd>
                                                                        </dl>
                                                                    </li>
                                                                    <li>
                                                                        <span class="image">
                                                                            <img src="images/picture.jpg" alt="img" />
                                                                        </span>
                                                                        <dl class="message">
                                                                            <dt>등록일 : </dt>
                                                                            <dd>2018.03.26</dd>
                                                                            <dt>노출상태 : </dt>
                                                                            <dd>
                                                                                <span class="label label-success">노출중</span>
                                                                            </dd>
                                                                            <dt>상품명 : </dt>
                                                                            <dd>메델라 락티나 전동식 모유 착유기</dd>
                                                                            <dt>매입가 : </dt>
                                                                            <dd>100,000원</dd>
                                                                            <dt>수량 : </dt>
                                                                            <dd>50개</dd>
                                                                            <dt>제품설명 : </dt>
                                                                            <dd>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Asperiores labore autem repudiandae, optio quas nisi vel
                                                                                sapiente quasi dolo</dd>
                                                                            <dt></dt>
                                                                            <dd>
                                                                                <hr>
                                                                                <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                                <a href="#!" class="btn btn-default btn-sm">삭제</a>
                                                                            </dd>
                                                                        </dl>
                                                                    </li>
                                                                    -->
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class='tab-pane fade <%= (selTab == 3) ? "active in" : "" %>' id="tab_content3" aria-labelledby="profile-tab">
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                                        <div class="x_panel tile">
                                                            <div class="x_title">
                                                                <h2 id="terminal_input_type">단말기 등록</h2>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <div class="x_content">
                                                                <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                                                                
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">사용
                                                                        </label>
                                                                        <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                            <div class="radio-group">
                                                                                <label>
                                                                                    <input type="radio"  name="TERMINAL_AVAILABLE" value="INUSE"> 사용
                                                                                </label>
                                                                                <label>
                                                                                    <input type="radio"  name="TERMINAL_AVAILABLE" value="AVAILABLE" checked> 사용안함
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">단말기번호
                                                                        </label>
                                                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                                                            <input type="text" class="form-control" id="TERMINAL_NUM" name="TERMINAL_NUM">
                                                                        </div>
                                                                    </div>
                                                                    <hr>
                                                                    <div class="col-md-3 col-md-offset-3">
                                                                        <a class="btn btn-primary btn-sm" onclick="saveTerminal()">저장</a>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                                        <div class="x_panel tile">
                                                            <div class="x_title">
                                                                <h2>단말기 리스트</h2>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <div class="x_content terminal-list">
                                                                <div class="row">
                                                                    <div class="col-md-7 col-md-offset-2">
                                                                        <table class="table table-hover">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>#</th>
                                                                                    <th>단말기번호</th>
                                                                                    <th>상태</th>
                                                                                    <th></th>
                                                                                    <th></th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody id="terminalList">
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
    <div id="error"></div>
</body>

</html>