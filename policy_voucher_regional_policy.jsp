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

    <title>마더앤베이비 관리자 - 지역별 정책 관리</title>

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
            <div class="right_col policy_voucher_location" role="main">
                <div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">바우처</a> &gt;
                        <a href="#!">지역별 정책 관리</a>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>
                                        지역별 정책 관리
                                        <small>* 산후도우미 지역별 정책사항을 입력하세요.</small>
                                    </h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">

                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <!-- start accordion -->
                                            <div class="accordion" id="accordion1" role="tablist" aria-multiselectable="true">
                                                <div class="panel">
                                                    <a class="panel-heading" role="tab" id="headingOne1" data-toggle="collapse" data-parent="#accordion1" href="#collapseOne1"
                                                        aria-expanded="true" aria-controls="collapseOne">
                                                        <h4 class="panel-title">서울특별시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseOne1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">서울특별시</th>
                                                                        <td>강남구</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">서울특별시</th>
                                                                        <td>강동구</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">서울특별시</th>
                                                                        <td>강서구</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingTwo1" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo1"
                                                        aria-expanded="false" aria-controls="collapseTwo">
                                                        <h4 class="panel-title">경기도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseTwo1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingThree1" data-toggle="collapse" data-parent="#accordion1" href="#collapseThree1"
                                                        aria-expanded="false" aria-controls="collapseThree">
                                                        <h4 class="panel-title">
                                                            인천광역시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseThree1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingFour1" data-toggle="collapse" data-parent="#accordion1" href="#collapseFour1"
                                                        aria-expanded="false" aria-controls="collapseFour">
                                                        <h4 class="panel-title">
                                                            부산광역시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseFour1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingFive1" data-toggle="collapse" data-parent="#accordion1" href="#collapseFive1"
                                                        aria-expanded="false" aria-controls="collapseFive">
                                                        <h4 class="panel-title">
                                                            강원도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseFive1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingSix1" data-toggle="collapse" data-parent="#accordion1" href="#collapseSix1"
                                                        aria-expanded="false" aria-controls="collapseSix">
                                                        <h4 class="panel-title">
                                                            대전광역시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseSix1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingSeven1" data-toggle="collapse" data-parent="#accordion1" href="#collapseSeven1"
                                                        aria-expanded="false" aria-controls="collapseSeven">
                                                        <h4 class="panel-title">
                                                            세종특별자치시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseSeven1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSeven">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingEight1" data-toggle="collapse" data-parent="#accordion1" href="#collapseEight1"
                                                        aria-expanded="false" aria-controls="collapseEight">
                                                        <h4 class="panel-title">
                                                            울산광역시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseEight1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEight">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingNine1" data-toggle="collapse" data-parent="#accordion1" href="#collapseNine1"
                                                        aria-expanded="false" aria-controls="collapseNine">
                                                        <h4 class="panel-title">
                                                            대구광역시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseNine1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingNine">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingTen1" data-toggle="collapse" data-parent="#accordion1" href="#collapseTen1"
                                                        aria-expanded="false" aria-controls="collapseTen">
                                                        <h4 class="panel-title">
                                                            광주광역시
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseTen1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTen">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 경상남도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingEleven1" data-toggle="collapse" data-parent="#accordion1" href="#collapseEleven1"
                                                        aria-expanded="false" aria-controls="collapseEleven">
                                                        <h4 class="panel-title">
                                                            경상남도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseEleven1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEleven">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 경상북도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingTwelve1" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwelve1"
                                                        aria-expanded="false" aria-controls="collapseTwelve">
                                                        <h4 class="panel-title">
                                                            경상북도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseTwelve1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwelve">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 전라남도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingThirteen1" data-toggle="collapse" data-parent="#accordion1" href="#collapseThirteen1"
                                                        aria-expanded="false" aria-controls="collapseThirteen">
                                                        <h4 class="panel-title">
                                                            전라남도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseThirteen1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThirteen">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 전라북도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingFourteen1" data-toggle="collapse" data-parent="#accordion1" href="#collapseFourteen1"
                                                        aria-expanded="false" aria-controls="collapseFourteen">
                                                        <h4 class="panel-title">
                                                            전라북도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseFourteen1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFourteen">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 충청남도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingFifteen1" data-toggle="collapse" data-parent="#accordion1" href="#collapseFifteen1"
                                                        aria-expanded="false" aria-controls="collapseFifteen">
                                                        <h4 class="panel-title">
                                                            충청남도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseFifteen1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFifteen">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 충청북도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingSixteen1" data-toggle="collapse" data-parent="#accordion1" href="#collapseSixteen1"
                                                        aria-expanded="false" aria-controls="collapseSixteen">
                                                        <h4 class="panel-title">
                                                            충청북도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseSixteen1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSixteen">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- 제주특별자치도 -->
                                                <div class="panel">
                                                    <a class="panel-heading collapsed" role="tab" id="headingSeventeen1" data-toggle="collapse" data-parent="#accordion1" href="#collapseSeventeen1"
                                                        aria-expanded="false" aria-controls="collapseSeventeen">
                                                        <h4 class="panel-title">
                                                            제주특별자치도
                                                            <i class="fa fa-caret-down"></i>
                                                        </h4>
                                                    </a>
                                                    <div id="collapseSeventeen1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSeventeen">
                                                        <div class="panel-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>시/도</th>
                                                                        <th>시/군/구</th>
                                                                        <th>정책</th>
                                                                        <th>등록</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th scope="row">경기도</th>
                                                                        <td>성남시</td>
                                                                        <td>
                                                                            <textarea name="" id="" rows="5" class="form-control">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quas libero ut architecto neque impedit placeat laudantium maxime, voluptate, repudiandae culpa laborum corporis recusandae id? Corporis commodi provident ex at optio?</textarea>
                                                                        </td>
                                                                        <td>
                                                                            <a href="#!" class="btn btn-default btn-sm">수정</a>
                                                                            <a href="#!" class="btn btn-danger btn-sm">삭제</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>    
                                            <!-- end of accordion -->
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