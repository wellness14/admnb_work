<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%!
	String _type;

	String getTitle()
	{
		String title = "미지정";

		if (_type.equals("terms"))
		{
			title = "서비스 이용약관";
		}
		else if (_type.equals("privacy"))
		{
			title = "개인정보 취급방침";
		}
		else if (_type.equals("email"))
		{
			title = "이메일 무단수집거부";
		}

		return title;
	}
%>

<%
	List<Terms> list;
	DateFormat dfApply = new SimpleDateFormat("yyyy-MM-dd");
	//String _type;
	int index = -1;
	Terms item = null;

	_type = request.getParameter("type");
	list = UserDB.getTermsList(_type);

	if (request.getParameter("index") != null)
	{
		index = Integer.parseInt((String)request.getParameter("index"));
		item = _userdb.getTerms(index);
		if (item == null)
		{
			index = -1;
		}
	}

%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>마더앤베이비 관리자 - <%= getTitle() %></title>

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
	<script src="js/base64.js" ></script>
	<script src="js/myutils.js" ></script>

	<script>


		var type = '<%= _type %>';
		var _index = <%= index %>;

		function setEditFields() {
				//alert("init:" + <%=index%>);
				if (_index != -1)
				{
					$("#CONTENTS").val(getDecodedString('<%= (item != null) ? item._contents : "" %>'));
					$("#APPLY_DATE").val('<%= (item != null) ? dfApply.format(item._applyDate) : "" %>');
				}
		}

		//var count = 0;
		function viewTerms(index) {
			//$('adv' + index).prop("checked", true);
			//count++;
			//document.getElementById('adv' + index).innerHTML = '노출중' + index;
			//alert(document.getElementById("APPLY_DATE").value);
			//document.getElementById('adv' + index).innerHTML = $("#APPLY_DATE").val();
			window.location.href = 'policy_terms.jsp?type=' + type + '&index=' + index;
		}

		function howtoChange(state) {
			alert('노출상태 변경을 원하시면 약관보기 후 약관적용일을 수정해 주세요.');
		}

		$(document).ready(function() {
			$("#save").click(function() {
				if ($("#CONTENTS").val().length == 0) {
					alert('내용이 입력되지 않았습니다.');
					return;
				}
				if ($("#APPLY_DATE").val().length == 0) {
					alert('적용일이 입력되지 않았습니다.');
					return;
				}

				//alert($("#term").serialize() + "&INDEX=" + <%= index %>);
				var val = '';
				val += 'type=' + type + '&';
				val += 'index=' + _index + '&';
				val += 'APPLY_DATE=' + $("#APPLY_DATE").val() + '&';
				val += 'CONTENTS=' + getEncodedString("CONTENTS") + '&';
				//val += $("#formData").serialize();

				//alert('저장합니다[' + val + "]");
				//alert(val);

				$.post("_terms_update.jsp", val)
				.fail(function(response) {
					//alert('Error: ' + response.responseText);
					$("#CONTENTS").val(response.responseText);
				})
				.done(function(data) {
					//alert(data);
                    alert('저장되었습니다.');
					location.reload();
				});
			});

			//$("#moveGift").click(function() {
			//	window.location.href = "content_gift_list.jsp";
			//});
		});
		window.onload = setEditFields;
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
                        <a href="#!">약관관리</a> &gt;
                        <a href="#!"><%= getTitle() %></a>
                    </div>
                    <div class="page-title">
                        <div class="title_left">
                            <h3><%= getTitle() %></h3>
                        </div>

                        <!-- <div class="title_right">
                            <a href="order_consult_new.html" class="btn btn-success pull-right">신규상담등록</a>
                        </div> -->
                    </div>

                    <!-- 약관내용 입력 -->
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel tile fixed_height_460">
                                <div class="x_title">
                                    <h2>약관내용 입력</h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <textarea name="CONTENTS" id="CONTENTS" placeholder="약관내용을 입력해주세요." class="form-control"></textarea>
                                    <hr>
                                    <h4>약관적용일</h4>
                                    <input type="date" class="form-control input-inline" id="APPLY_DATE" />
                                    <a href="#!" class="btn btn-primary btn-sm btn-mb-0" id="save">저장</a>
                                    <hr>
                                    <small>* 기본 한개의 약관은 게시중 상태여야 합니다.</small>
                                    <div class="table-responsive">
                                        <table class="table table-striped jambo_table bulk_action">
                                            <thead>
                                                <tr class="headings">
                                                    <th class="column-title">No </th>
                                                    <th class="column-title">약관적용일 </th>
                                                    <th class="column-title">상태 </th>
                                                </tr>
                                            </thead>
                                    
                                            <tbody>
  <%
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");

	//access via Iterator
	Iterator iterator;
	int count;
	Timestamp curTime = new Timestamp(System.currentTimeMillis());
	int exposed = -1;

	count = list.size();

	iterator = list.iterator();
	index = 0;
	Timestamp last = new Timestamp(0);
	while (iterator.hasNext())
	{
		item = (Terms) iterator.next();
		if (curTime.after(item._applyDate))
		{
			//out.write("exposed:" + item._applyDate);
			if (last.before(item._applyDate))
			{
				last = item._applyDate;
				exposed = index;
			}
		}
		index++;
	}
	//out.write("exposed:" + exposed);


	iterator = list.iterator();
	index = 0;
	while (iterator.hasNext())
	{
		item = (Terms) iterator.next();
		String s;
		if (count % 2 == 0)
			s = "<tr class='even pointer'>";
		else
			s = "<tr class='odd pointer'>";
		s += "<td>" + count + "</td>";
		s += "<td>" + df.format(item._applyDate) + "</td>";
		s += "<td>";
		s += "<a class='btn btn-xs btn-mb-0  btn-primary' onclick='viewTerms(" + item._index + ")'>약관보기</a>";
		if (index == exposed)
			s += "<div class='btn btn-xs btn-mb-0  btn-sucess' onclick='howtoChange(1)'>노출중</div>";
		else
			s += "<div class='btn btn-xs btn-mb-0  btn-dark' onclick='howtoChange(0)'>미노출</div>";
		s += "</td>";
		//s += "<td>" + df.format(header.getComposed().getTime()) + "</td>";
		//s += "<td>/" + ((curTime.before(item._applyDate)) ? "아직임" : "지남") + "</td>";
		//s += "/" + ((index == exposed) ? "노출중" : "게시") + "</td>";
		s += "</tr>\n";
		out.write(s);
		count--;
		index++;
	}
%>
<!--
                                              <tr class="even pointer">
                                                    <td>2</td>
                                                    <td>2017.02.20</td>
                                                    <td>
                                                        <a href="#!" class="btn btn-xs btn-mb-0  btn-primary">약관보기</a>
                                                        <a href="#!" class="btn btn-xs btn-mb-0  btn-dark">적용하기</a>
                                                    </td>
                                                </tr>
                                                <tr class="odd pointer">
                                                    <td>1</td>
                                                    <td>2017.12.20</td>
                                                    <td>
                                                        <a href="#!" class="btn btn-xs btn-mb-0  btn-primary">약관보기</a>
                                                        <a href="#!" class="btn btn-xs btn-mb-0  btn-success">노출중</a>
                                                    </td>
                                                </tr>
                                            -->
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
