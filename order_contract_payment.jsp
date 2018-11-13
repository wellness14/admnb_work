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

    <title>마더앤베이비 관리자 - 계약결제</title>

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
<%@ include file="order_left_menu.jspf" %>
<%@ include file="order_top_nav.jspf" %>

            <!-- page content -->
            <div class="right_col order_consult" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>계약/결제</h3>
                        </div>

                        <div class="title_right">
                            <a href="order_consult_new.jsp" class="btn btn-primary btn-sm pull-right">신규상담등록</a>
                        </div>
                    </div>

                    <!-- 검색조건 입력 -->
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile fixed_height_460">
                                <div class="x_title">
                                    <h2>계약 및 결제검색</h2>
                                    <div class="nav navbar-right panel_toolbox">
                                        <label>
                                            <input type="radio" class="flat" name="consult_search"> 오늘
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" name="consult_search"> 7일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" name="consult_search"> 15일
                                        </label>
                                        <label>
                                            <input type="radio" class="flat" name="consult_search"> 1개월
                                        </label>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <!-- 지역선택 -->
                                    <div class="row sido">
                                        <div class="col-md-2 col-sm-2 col-xs-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                시/도</h4>
                                            <select class="select2_single form-control">
                                                <option value="">서울</option>
                                                <option value="">경기도</option>
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
                                        </div>
                                        <div class="col-md-10 col-sm-10 col-xs-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                시/군/구</h4>
                                            <ul class="list-unstyled">
                                                <li>
                                                    <input type="checkbox" class="flat" id="loc_all">
                                                    <label for="loc_all">전체
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">성동
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">광진
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">중랑
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">도봉
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">노원
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강북
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">성북
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">종로
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">서대문
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">은평
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">마포
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강서
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">양천
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">구로
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">영등포
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">금천
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">관악
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">동작
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">서초
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강남
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">송파
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">강동
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">동대문
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">중구
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">용산
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <!-- 접근분류 -->
                                    <div class="row reference-type">
                                        <div class="col-md-12 col-sm-12">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                접근분류</h4>
                                            <ul class="list-unstyled">
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">전체</label>

                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">전화옴
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">홈페이지
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">전시회
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">바우처
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">조리원소개
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">기타
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <!-- 상담상태 / 진행상태 -->
                                    <div class="row consult-state">
                                        <div class="col-md-6 col-sm-6">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                상담상태</h4>
                                            <ul class="list-unstyled">
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">전체</label>

                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">대기
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">진행
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">완료
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-6 col-sm-6">
                                            <h4>
                                                <i class="fa fa-check"></i>
                                                진행상태</h4>
                                            <ul class="list-unstyled">
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">전체
                                                        <span class="badge bg-default">22</span>
                                                    </label>

                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">예정 2일전 문자대기
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <input type="checkbox" class="flat" id="">
                                                    <label for="">예정일 2일전 문자완료
                                                        <span class="badge bg-default">22</span>
                                                    </label>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <!-- 이름 / 휴대번호 검색 -->
                                    <div class="row name-phone">
                                        <div class="col-md-12 col-sm-12">
                                            <div class="input-group">
                                                <label for="">이름 &nbsp;&middot;&nbsp; 휴대번호로 검색</label>
                                                <input type="text" class="form-control" placeholder="이름, 휴대번호 입력">
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <button id="send" type="submit" class="btn btn-primary btn-sm">위 조건으로 검색</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 검색결과 테이블 -->
                <div class="row consult-search-result">
                    <div class="col-md-12 col-sm-12">
                        <div class="x_panel tile fixed_height_460">
                            <div class="x_title">
                                <h2>계약 / 결제검색 결과</h2>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="table-responsive">
                                    <table class="table table-striped jambo_table bulk_action">
                                        <thead>
                                            <tr class="headings">
                                                <th class="column-title">보기</th>
                                                <th class="column-title">상담</th>
                                                <th class="column-title">이름</th>
                                                <th class="column-title">분류</th>
                                                <th class="column-title">상담</th>
                                                <th class="column-title">출산예정일</th>
                                                <th class="column-title">진행상태</th>
                                                <th class="column-title">지점</th>
                                                <th class="column-title">희망서비스</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <tr class="even pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="odd pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-info">진행</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="even pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-success">완료</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="odd pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="even pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="odd pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="even pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="odd pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="even pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
                                            </tr>
                                            <tr class="odd pointer">
                                                <td>
                                                    <a href="order_consult_detail.html" class="btn btn-primary btn-sm">보기</a>
                                                </td>
                                                <td>
                                                    <span class="label label-warning">대기</span>
                                                </td>
                                                <td>최정은</td>
                                                <td>전화옴</td>
                                                <td>조미경</td>
                                                <td>2018.03.26</td>
                                                <td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>
                                                <td>관악</td>
                                                <td>조리원이용 (4주이상) 출퇴근 6일</td>
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
    <!-- TweenMax -->
    <script src="./vendors/tweenmax/TweenMax.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="./build/js/custom.min.js"></script>
</body>

</html>