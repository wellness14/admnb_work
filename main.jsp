<%@ page contentType = "text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자</title>

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
    <!-- PNotify -->
    <link href="./vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="./vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="./vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="./build/css/custom.css" rel="stylesheet">
    <link href="./build/css/mystyle.css" rel="stylesheet">
</head>

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
            <div class="col-md-3 left_col menu_fixed hide">
                <div class="left_col scroll-view">
                    <div class="navbar nav_title" style="border: 0;">
                        <a href="index.html" class="site_title">
                            <img src="./build/images/partner6.png" alt="마더앤베이비로고">
                        </a>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                        <div class="menu_section">
                            <ul class="nav side-menu">
                                <li>
                                    <a href="index.html">
                                        <i class="fa fa-tachometer"></i> 대시보드
                                    </a>
                                </li>
                                <li>
                                    <a>
                                        <i class="fa fa-edit"></i> 주문
                                        <span class="fa fa-chevron-down"></span>
                                    </a>
                                    <ul class="nav child_menu">
                                        <li>
                                            <a href="order_dash.html">주문 대시보드</a>
                                        </li>
                                        <li>
                                            <a href="order_consult.html">상담/문의</a>
                                        </li>
                                        <li>
                                            <a href="order_contract_payment.html">계약/결제</a>
                                        </li>
                                        <li>
                                            <a href="order_service_now.html">서비스</a>
                                        </li>
                                        <li>
                                            <a>출산선물
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="#!">현황정보</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a>서비스용품
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="#!">현황정보</a>
                                                </li>
                                            </ul>
                                        </li>
                                
                                    </ul>
                                </li>
                                <li>
                                    <a>
                                        <i class="fa fa-cog"></i> 기본정책
                                        <span class="fa fa-chevron-down"></span>
                                    </a>
                                    <ul class="nav child_menu">
                                        <!-- <li>
                                            <a href="#!">기본정책 대시보드</a>
                                        </li> -->
                                        <li>
                                            <a href="policy_in_out.html">이용/탈퇴안내</a>
                                        </li>
                                        <li>
                                            <a>약관관리
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="policy_use_agree.html">서비스 이용약관</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="policy_private_agree.html">개인정보취급방침</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="policy_email_agree.html">이메일 무단수집거부</a>
                                                </li>
                                            </ul>
                                        </li>
                                        
                                        <li>
                                            <a>SEO태그
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="policy_seo_common.html">공통관리</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a>지사/지역/산후도우미
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="policy_manage_jisa.html">지사관리</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="policy_manage_helper.html">산후도우미 관리</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="policy_manage_location_setting.html">지역설정</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a>선물/대여품/단말기
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="policy_manage_gift.html">선물/대여품/단말기 관리</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a>서비스 프로그램
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="policy_service.html">서비스 상품/옵션</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a>바우처
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="policy_voucher_income.html">기준중위소득관리</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="policy_voucher_support.html">정부지원금 정책</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="policy_voucher_location.html">지역별 정책 관리</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a>관리자
                                                <span class="fa fa-chevron-down"></span>
                                            </a>
                                            <ul class="nav child_menu">
                                                <li class="sub_menu">
                                                    <a href="#!">본사관리자</a>
                                                </li>
                                                <li class="sub_menu">
                                                    <a href="#!">지사계정생성</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- /sidebar menu -->
                </div>
            </div>

            <!-- top navigation -->
            <div class="top_nav main_top">
                <div class="nav_menu first">
                    <nav>
                        <div class="nav toggle">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="이름, ID, 휴대번호">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary btn-sm">검색</button>
                                </span>
                            </div>
                        </div>
                        
                        

                        <ul class="nav navbar-nav navbar-right">
                            <!-- 로그인 유저 확인 및 로그아웃 -->
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    관리자 접속중
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu pull-right">
                                    <li>
                                        <a href="login.html">
                                            <i class="fa fa-sign-out pull-right"></i> 로그아웃</a>
                                    </li>
                                </ul>
                            </li>
                            <!-- 자주 쓰는 메뉴 -->
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false" >
                                    자주쓰는메뉴
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu pull-right  favorite-menu-list">
                                    <li>
                                        <a href="#!" data-toggle="modal" data-target=".favorite-menu">
                                            <i class="fa fa-cog pull-right"></i> 메뉴설정</a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            자주쓰는 메뉴를 설정해주세요.
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!"><i class="fa fa-star"></i> 주문 / 상담문의 </a>
                                    </li>
                                    <li>
                                        <a href="#!"><i class="fa fa-star"></i> 기본정책 / 지사,지역,산후도우미 / 산후도우미 관리</a>
                                    </li>
                                </ul>
                                <!-- 자주쓰는 메뉴 설정 팝업 -->
                                <div class="modal fade bs-example-modal-lg favorite-menu" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">×</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel">자주쓰는 메뉴 설정</h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <label class="control-label col-md-2 col-sm-2 col-xs-12">메뉴선택</label>
                                                        <div class="col-md-3 col-sm-3 col-xs-12">
                                                            <select class="select2_multiple form-control" multiple="multiple">
                                                                <option>대메뉴</option>
                                                                <option>Option one</option>
                                                                <option>Option two</option>
                                                                <option>Option three</option>
                                                                <option>Option four</option>
                                                                <option>Option five</option>
                                                                <option>Option six</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3 col-sm-3 col-xs-12">
                                                            <select class="select2_multiple form-control" multiple="multiple">
                                                                <option>중메뉴</option>
                                                                <option>Option one</option>
                                                                <option>Option two</option>
                                                                <option>Option three</option>
                                                                <option>Option four</option>
                                                                <option>Option five</option>
                                                                <option>Option six</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3 col-sm-3 col-xs-12">
                                                            <select class="select2_multiple form-control" multiple="multiple">
                                                                <option>페이지 선택</option>
                                                                <option>Option one</option>
                                                                <option>Option two</option>
                                                                <option>Option three</option>
                                                                <option>Option four</option>
                                                                <option>Option five</option>
                                                                <option>Option six</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-1 col-sm-1 col-xs-12">
                                                            <a href="#!" class="btn btn-primary btn-sm">선택</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <label class="control-label col-md-2 col-sm-2 col-xs-12">자주쓰는 메뉴<br/> <small> ( 0 / 10  선택)</small></label>
                                                    <div class="col-md-10 col-sm-10">
                                                        <p>자주쓰는 메뉴를 선택해 주세요. (최대10개)</p>
                                                        <p>주문 / 출산선물 / 현황정보 <a href="#!" class="btn btn-danger btn-xs btn-mb-0">삭제</a></p>
                                                        <p>주문 / 출산선물 / 현황정보 <a href="#!" class="btn btn-danger btn-xs btn-mb-0">삭제</a></p>
                                                        <p>주문 / 출산선물 / 현황정보 <a href="#!" class="btn btn-danger btn-xs btn-mb-0">삭제</a></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
                                                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">저장</button>
                                            </div>
                                
                                        </div>
                                    </div>
                                </div>
                                <!-- 자주쓰는 메뉴 설정 팝업 -->
                            </li>
                            <!-- 주문현황 -->
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    주문현황
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu pull-right">
                                    <li>
                                        <a href="#!">
                                            입금대기
                                            <span class="badge bg-orange">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            입금완료
                                            <span class="badge bg-green">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            계약취소신청
                                            <span class="badge bg-red">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            환불완료
                                            <span class="badge bg-blue">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            서비스대기
                                            <span class="badge bg-orange">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            서비스 중
                                            <span class="badge bg-blue-sky">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            서비스 연장
                                            <span class="badge bg-purple">6</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#!">
                                            서비스 완료
                                            <span class="badge bg-green">6</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="nav_menu second">
                    <a href="index.html" class="btn btn-primary btn-sm">Home</a>
                    <a href="order_dash.html" class="btn btn-primary btn-sm">주문</a>
                    <a href="policy_signin.jsp" class="btn btn-primary btn-sm">기본정책</a>
                </div>
            </div>
            <!-- /top navigation -->
            <!-- page content -->
            <div class="right_col main_dash" role="main">
                <div class="">
                    <div class="row">
                        <!-- 주문관리 -->
                        <div class="col-md-5 col-sm-5 col-xs-12">
                            <div class="x_panel tile fixed_height_300">
                                <div class="x_title">
                                    <h2>주문관리</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <label>
                                            <input type="radio" class="flat" name="order_manage"> 오늘
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" name="order_manage"> 7일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" name="order_manage"> 15일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" name="order_manage"> 1개월
                                        </label>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>입금대기</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>입금완료</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>계약취소신청</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>환불완료</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스대기</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스중</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스연장</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>서비스완료</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <!-- 상담/문의 -->
                        <div class="col-md-4 col-sm-4 col-xs-12 main_dash">
                            <div class="x_panel tile fixed_height_300">
                                <div class="x_title">
                                    <h2>상담/문의</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <label>
                                            <input type="radio" class="flat" checked name="consult_inquiry"> 오늘
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="consult_inquiry"> 7일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="consult_inquiry"> 15일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="consult_inquiry"> 1개월
                                        </label>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content row consult-summary">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        다이렉트 전화상담
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        조리원을 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        홈페이지 직접
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        기타
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        전시회를 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        진행
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                         바우처를 통해
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-sm-6">
                                        완료
                                        <a href="#!" class="pull-right btn btn-sm btn-default">
                                            6
                                        </a>
                                    </div>
                                </div>
                                <a href="order_consult_new.html" class="btn btn-primary btn-new-consult">신규상담등록</a>
                            </div>
                        </div>

                        <!-- 업무메모 -->
                        <div class="col-md-3 col-sm-3 col-xs-12 main_memo">
                            <div class="x_panel tile fixed_height_300">
                                <div class="x_title">
                                    <h2>업무메모</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <a href="#!" class="btn btn-danger btn-xs">전체삭제</a>
                                        <a href="#!" class="btn btn-primary btn-xs">저장</a>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <textarea name="" id="" placeholder="메모를 입력하세요."></textarea>
                                    <small>최종수정일 : 2018.03.26</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 공지사항 / 업무쪽지 -->
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                            <div class="x_panel main_notice">
                                <div class="x_title">
                                    <h2>공지사항</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <a href="#!" class="btn btn-primary btn-xs">공지사항</a>
                                        <a href="#!" class="btn btn-default btn-xs more">
                                            <i class="fa fa-plus more"></i>
                                        </a>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <table class="table table-hover">
                                        <colgroup>
                                            <col width="70%">
                                            <col width="15%">
                                            <col width="15%">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <td><a href="#!"><span class="label label-warning">new</span>2018년 새해 전시회 참가일정입니다.</a></td>
                                                <td>정혜윤</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                            <tr>
                                                <td><a href="#!">2018년 1월 3주차 산후건강관리사 교육 진행 계획</a></td>
                                                <td>정혜윤</td>
                                                <td>2018-12-31</td>
                                            </tr>
                                            <tr>
                                                <td><a href="#!">2018년 새해 전시회 참가일정입니다.</a></td>
                                                <td>정혜윤</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#!">2018년 1월 3주차 산후건강관리사 교육 진행 계획</a>
                                                </td>
                                                <td>정혜윤</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                            <div class="x_panel main_notice">
                                <div class="x_title">
                                    <h2>업무쪽지</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <a href="#!" class="btn btn-primary btn-xs"  data-toggle="modal" data-target=".send-message">쪽지보내기</a>
                                        <a href="#!" class="btn btn-default btn-xs more">
                                            <i class="fa fa-plus more"></i>
                                        </a>
                                    </div>
                                    <div class="clearfix"></div>


                                    <!-- 쪽지보내기 팝업 -->
                                    <div class="modal fade bs-example-modal-lg send-message" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                    
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">
                                                        <span aria-hidden="true">×</span>
                                                    </button>
                                                    <h4 class="modal-title" id="myModalLabel">쪽지보내기</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="">
                                                    <div class="btn-group">
                                                        <button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false">전체(본사/지사전체)
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul role="menu" class="dropdown-menu">
                                                            <li>
                                                                <a href="#">본사</a>
                                                            </li>
                                                            <li>
                                                                <a href="#">지사</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                    <div class="btn-group">
                                                        <button data-toggle="dropdown" class="btn btn-default dropdown-toggle btn-sm" type="button" aria-expanded="false">모든사람에게
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul role="menu" class="dropdown-menu">
                                                            <li>
                                                                <a href="#">서동필</a>
                                                            </li>
                                                            <li>
                                                                <a href="#">손선애</a>
                                                            </li>
                                                            <li>
                                                                <a href="#">정혜윤</a>
                                                            </li>
                                                            <li>
                                                                <a href="#">서원우</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                    <div class="message-box">
                                                        <textarea name="" id="" placeholder="내용을 입력해주세요."></textarea>
                                                    </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
                                                    <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">보내기</button>
                                                </div>
                                    
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 쪽지보내기 팝업 -->
                                </div>
                                <div class="x_content">
                                    <table class="table table-hover">
                                        <colgroup>
                                            <col width="70%">
                                            <col width="15%">
                                            <col width="15%">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <a href="#!"><span class="label label-warning">new</span>지원부탁드립니다.</a>
                                                </td>
                                                <td>강서지사</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#!">관리사님들 좀 더 </a>
                                                </td>
                                                <td>정혜윤</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#!">정산할떄 말이죠</a>
                                                </td>
                                                <td>정혜윤</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#!">지사관리 계획안</a>
                                                </td>
                                                <td>정혜윤</td>
                                                <td>2018-01-01</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 주요현황 -->
                    <div class="row">
                        <div class="col-md-8 col-sm-8 col-xs-12">
                            <div class="x_panel tile fixed_height_645 major_status">
                                <div class="x_title">
                                    <h2>주요현황</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <label>
                                            <input type="radio" class="flat" checked name="major_status"> 오늘
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="major_status"> 7일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="major_status"> 15일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="major_status"> 1개월
                                        </label>
                                        <div class="btn-group pull-right btn-app branch-view">
                                            <a data-toggle="dropdown" class="btn btn-default btn-sm dropdown-toggle" type="button" aria-expanded="false">지사별 보기
                                                <span class="caret"></span>
                                            </a>
                                            <ul role="menu" class="dropdown-menu">
                                                <li>
                                                    <a href="#">전체</a>
                                                </li>
                                                <li>
                                                    <a href="#">강북/노원</a>
                                                </li>
                                                <li>
                                                    <a href="#">구리/남양주</a>
                                                </li>
                                                <li>
                                                    <a href="#">성동/광진</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>입금대기</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>입금완료</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>계약취소신청</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>환불완료</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="tile-stats">
                                                <h3>환불완료</h3>
                                                <div class="count">17</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped jambo_table bulk_action">
                                            <thead>
                                                <tr class="headings">
                                                    <th class="column-title">날짜</th>
                                                    <th class="column-title">매출금액</th>
                                                    <th class="column-title">지사매출</th>
                                                    <th class="column-title">환불금액</th>
                                                </tr>
                                            </thead>
                                    
                                            <tbody>
                                                <tr class="even pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="odd pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="even pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="odd pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="even pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="odd pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="even pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="odd pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                    
                                                <tr class="even pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                                <tr class="odd pointer">
                                                    <td class=" ">2018.05.28</td>
                                                    <td class=" ">1,510,000원</td>
                                                    <td class=" ">750,000원</td>
                                                    <td class=" ">0원</td>
                                                </tr>
                                            </tbody>
                                        </table>
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
                                    </div>
                        
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                            <div class="x_panel tile fixed_height_645">
                                <div class="x_title">
                                    <h2>출산선물 현황</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <label>
                                            <input type="radio" class="flat" checked name="iCheck"> 오늘
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="iCheck"> 7일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="iCheck"> 15일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="iCheck"> 1개월
                                        </label>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">1</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">2</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">3</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">4</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">5</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">6</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">7</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">8</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">9</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                    <article class="media event">
                                        <a class="pull-left date">
                                            <p class="day">10</p>
                                        </a>
                                        <div class="media-body">
                                            <a class="title" href="#">뱀부 머슬린 사계절 속싸개</a>
                                            <p>50000개 증정</p>
                                        </div>
                                    </article>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 용품대여현황 -->
                    <div class="row">
                        <div class="col-md-8 col-sm-8 col-xs-12">
                            <div class="x_panel tile fixed_height_500 major_schedule">
                                <div class="x_title">
                                    <h2>주요일정</h2>
                                    <div class="nav navbar-right panel_toolbox">
                    
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <div id="calendar"></div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6">
                                            <div class="x_panel todo-list">
                                                <div class="x_title">
                                                    <small>03/21 일정이 없습니다.</small>
                                                    <a href="#!" class="pull-right add-todo btn-primary btn-xs btn">일정추가</a>
                                                </div>
                                                <div class="x_content">
                                            
                                                    <div class="">
                                                        <ul class="to_do">
                                                            <li>
                                                                <p>
                                                                    <span class="label label-success">개인일정</span>
                                                                    산후도우미 교육
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    오늘 전시회 관련 미팅예정
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                            <li>
                                                                <p>
                                                                    <span class="label label-warning">공유받음 &middot; 서원우</span>
                                                                    트리니티 조리원 미팅있습니다. 시간은 오후 1시 30분입니다. 점심먹고 출발해요.
                                                                </p>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4 col-xs-12 rent">
                            <div class="x_panel tile fixed_height_500">
                                <div class="x_title">
                                    <h2>용품 대여 현황</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <label>
                                            <input type="radio" class="flat" checked name="service_rent"> 오늘
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="service_rent"> 7일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="service_rent"> 15일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" checked name="service_rent"> 1개월
                                        </label>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <ul class="list-unstyled top_profiles scroll-view">
                                        <li class="media event">
                                            <div class="media-body row">
                                                <h5>
                                                    <i class="fa fa-cube"></i>
                                                    적외선방사 피부관리기</h5>
                                                <dl>
                                                    <dt>전체</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>반납예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여중</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </li>
                                        <li class="media event">
                                            <div class="media-body row">
                                                <h5>
                                                    <i class="fa fa-cube"></i>
                                                    적외선방사 피부관리기</h5>
                                                <dl>
                                                    <dt>전체</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>반납예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여중</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </li>
                                        <li class="media event">
                                            <div class="media-body row">
                                                <h5>
                                                    <i class="fa fa-cube"></i>
                                                    적외선방사 피부관리기</h5>
                                                <dl>
                                                <dl>
                                                    <dt>전체</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>반납예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여중</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </li>
                                        <li class="media event">
                                            <div class="media-body row">
                                                <h5>
                                                    <i class="fa fa-cube"></i>
                                                    적외선방사 피부관리기</h5>
                                                <dl>
                                                <dl>
                                                    <dt>전체</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>반납예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여중</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </li>
                                        <li class="media event">
                                            <div class="media-body row">
                                                <h5>
                                                    <i class="fa fa-cube"></i>
                                                    적외선방사 피부관리기</h5>
                                                <dl>
                                                <dl>
                                                    <dt>전체</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>반납예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여중</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                    <dt>대여예정</dt>
                                                    <dd>
                                                        <span class="badge bg-purple">80</span>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </li>
                                    </ul>
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
                    Wellness Intelligence ADMIN PAGE Create by 
                    - Spacemonkey
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
    <!-- bootstrap-daterangepicker -->
    <script src="./vendors/moment/min/moment.min.js"></script>
    <script src="./vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="./vendors/jquery-ui-1.12.1.custom/datepicker-ko-KR.js"></script>
    <script src="./vendors/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    
    <!-- iCheck -->
    <script src="./vendors/iCheck/icheck.min.js"></script>
    <!-- TweenMax -->
    <script src="./vendors/tweenmax/TweenMax.js"></script>
    <!-- PNotify -->
    <script src="./vendors/pnotify/dist/pnotify.js"></script>
    <script src="./vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="./vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="./build/js/custom.min.js"></script>
</body>

</html>