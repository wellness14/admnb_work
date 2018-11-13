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

    <title>마더앤베이비 관리자 - 선물등록</title>

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
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
<%@ include file="policy_left_menu.jspf" %>
<%@ include file="policy_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col policy_manage_gift_new" role="main">
                <div class="">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>
                                        선물등록
                                    </h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">

                                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                                        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                            <li role="presentation" class="active">
                                                <a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">선물</a>
                                            </li>
                                            <li role="presentation" class="">
                                                <a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">대여품</a>
                                            </li>
                                            <li role="presentation" class="">
                                                <a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">단말기</a>
                                            </li>
                                        </ul>
                                        <div id="myTabContent" class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                                                        
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">노출상태
                                                                </label>
                                                                <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                    <div class="radio-group">
                                                                        <label>
                                                                            <input type="radio" class="flat" name="iCheck"> 노출
                                                                        </label>
                                                                        <label>
                                                                            <input type="radio" class="flat" name="iCheck"> 노출안함
                                                                        </label>
                                                                    </div>        
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">gift번호
                                                                </label>
                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                    <input type="text" required="required" class="form-control col-md-7 col-xs-12" placeholder="내용을 입력해주세요.">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">상품명</label>
                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                    <input class="form-control col-md-7 col-xs-12" type="text" placeholder="내용을 입력해주세요.">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">상품이미지</label>
                                                                <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                    <div class="radio-group">
                                                                        <label>
                                                                            <input type="radio" class="flat" name="iCheck"> 직접등록
                                                                        </label>
                                                                        <label>
                                                                            <input type="radio" class="flat" name="iCheck"> url입력
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
                                                                    <input type="text" class="form-control">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">수량</label>
                                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                                    <input type="text" class="form-control">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">지급대상서비스</label>
                                                                <div class="col-md-6 col-sm-6 col-xs-12 chk-box">
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        베이직
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 1주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        프리미엄
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 1주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 1주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        VIP
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 1주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 1주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        프라이빗
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 3주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        다둥이(쌍둥이)
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주 + 출퇴근 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        다둥이(다둥이)
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주 + 출퇴근 2주</label>
                                                                        </li>
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        집중관리(워킹맘)
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주 + 출퇴근 2주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        집중관리(산후조리원 내집에)
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">입주 2주 + 출퇴근 2주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        집중관리(35세 이상 산모 집중케어)
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <h5>
                                                                        <i class="fa fa-slack"></i>
                                                                        과체중 산모케어
                                                                    </h5>
                                                                    <ul class="list-unstyled">
                                                                        <li>
                                                                            <input type="checkbox" class="flat">
                                                                            <label for="">출퇴근 4주</label>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                </div>
                                                                <div class="col-md-3 col-md-offset-3">
                                                                    <a href="#!" class="btn btn-default btn-sm">취소</a>
                                                                    <a href="#!" class="btn btn-primary btn-sm">저장</a>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
                                                기존 대여품 페이지
                                            </div>
                                            <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
                                                기존 단말기 페이지
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
</body>

</html>