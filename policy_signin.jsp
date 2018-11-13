<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<!DOCTYPE html>
<html lang="en">

<%
    ResultSet rs = null;
    String sql = "select * from INFORMATIONS";
    String signin = "";
    String signout = "";

    rs = DBPool.getResultSet(sql);
    while (UserDB.getNext(rs))
    {
        try
        {
            if (rs.getString("NAME").equals("SIGNIN"))
            {
                signin = rs.getString("INFORMATION");
            }
            else if (rs.getString("NAME").equals("SIGNOUT"))
            {
                signout = rs.getString("INFORMATION");
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }
    DBPool.removeDBObject(rs);
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>마더앤베이비 관리자 - 이용/탈퇴안내</title>

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
        var signin = '<%= signin %>';
        var signout = '<%= signout %>';

        window.onload = function init() {
            document.getElementById('SIGNIN').innerHTML = getDecodedString(signin);
            document.getElementById('SIGNOUT').innerHTML = getDecodedString(signout);
        }
		function onSave() {
			var val = '';
			val += 'SIGNIN=' + getEncodedString("SIGNIN") + '&';
			val += 'SIGNOUT=' + getEncodedString("SIGNOUT") + '&';
			$.post("_save_signinout.jsp", val)
        	.fail(function(response) {
        		alert('Error: ' + response.responseText);
        		//document.getElementById("error").innerHTML = response.responseText;
        	})
        	.done(function(data) {
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
			<div class="right_col policy_use_agree" role="main">
				<div class="">
                    <div class="location">
                        <a href="#!">기본정책</a> &gt;
                        <a href="#!">이용/탈퇴안내</a>
                    </div>
					<div class="page-title">
						<div class="title_left">
							<h3>이용/탈퇴안내</h3>
						</div>
						<div class="title_right">
							<a href="#!" class="btn btn-primary btn-sm pull-right" onclick="onSave()">저장</a>
						</div>
					</div>

					<!-- 이용안내 -->
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel tile fixed_height_460">
								<div class="x_title">
									<h2>이용안내</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<textarea name="SIGNIN" id="SIGNIN" class="form-control"></textarea>
								</div>
							</div>
						</div>
					</div>

					<!-- 탈퇴안내 -->
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel tile fixed_height_460">
								<div class="x_title">
									<h2>탈퇴안내</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<textarea name="SIGNOUT" id="SIGNOUT" class="form-control"></textarea>
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
