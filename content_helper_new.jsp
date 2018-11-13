<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsAll;
	List<Region> lstRegionsGroup;
	DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
	int _region = -1;

	int calcAge(String social)
	{
		int curYear = Calendar.getInstance().get(Calendar.YEAR);
		int year = Integer.parseInt(social.substring(0, 2));
		String[] socials = social.split("-");
		char temp = socials[1].charAt(0);
		boolean is2000s = ((temp == '3') || (temp == '4'));
		if (is2000s)
		{
			year += 2000;
		}
		else
		{
			year += 1900;
		}

		return curYear - year + 1;
	}
%>

<%
	int index = -1;
/*
	Terms item = null;

	_type = request.getParameter("type");
	list = _userdb.getTermsList(_type);

	if (request.getParameter("index") != null)
	{
		index = Integer.parseInt((String)request.getParameter("index"));
		item = _userdb.getTerms(index);
		if (item == null)
		{
			index = -1;
		}
	}
	//_userdb.PrintLog("service.jsp");
*/
	lstRegionsGroup = _userdb.getRegionList(-1);
	lstRegionsAll = _userdb.getRegionList(0);
%>

<html>
	<head>
		<title>산후도우미 신규등록</title>
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

			//var memberIndex = -1;

			function setEditFields() {
					changedRegion_Belong();
					changedRegion_Wish();
			}

			$(document).ready(function() {
				$("#search").click(function() {
    				var myWindow = window.open("sub_select_member.jsp?SEARCH=" + $("#PATTERN").val(), "selectHelper", "width=500,height=500");
				});
				$("#save").click(function() {
					if (checkRegionSel(0) == false) {
						alert("소속지점이 선택되지 않았습니다.");
						return;
					}
					if (checkRegionSel(1) == false) {
						alert("희망근무지역이 선택되지 않았습니다.");
						return;
					}
					//var val = 'MEMBER=' + memberIndex + '&' + $("#formData").serialize();
					var val = $("#formData").serialize();
					alert(val);
					$.post("_helper_update.jsp", val)
					.fail(function(response) {
						alert('Error: ' + response.responseText);
						$("#MEMO").val(response.responseText);
					})
					.done(function(data) {
						alert(data);
						//location.reload();
						window.location.href = 'content_helper_list.jsp';
					});
				});
			});
			window.onload = setEditFields;

			function checkRegionSel(type) {
				var checked = false;
				var names = ['REGION_BELONG', 'REGION_WISH'];
				var boxs = document.getElementsByName(names[type]);
				//var boxs = document.getElementsByName("REGION");
				for (var i = 0; i < boxs.length; i++) {
					if (boxs[i].checked == true) {
						checked = true;
						break;
					}
				}
				return checked;
			}

			function setRegion(type, index) {
				//alert(index);
				//var boxs = document.getElementsByName("REGION");
				var names = ['REGION_BELONG', 'REGION_WISH'];
				var boxs = document.getElementsByName(names[type]);
				for (var i = 0; i < boxs.length; i++) {
					if (boxs[i].value != index)
						boxs[i].checked = false;
					else
						boxs[i].checked = true;
				}
				//alert()
			}

			function changedRegion_Belong() {
				//alert($("#region").val());
				var html = "";
				for (var i = 0; i < regions.length; i++) {
					if (regions[i]._upper == $("#regionBelong").val()) {
                    	html += "<li><input type='checkbox' class='flat' onclick='setRegion(0, " + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " /><label for=''>" + regions[i]._name + "<span class='badge bg-purple'>0</span></label></li>";
						//html += "<input type='checkbox' onclick='setRegion(0, " + regions[i]._index + ")' name='REGION_BELONG' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
					}
				}
				//alert(html);
				document.getElementById('subBelong').innerHTML = html;
			}

			function changedRegion_Wish() {
				//alert($("#region").val());
				var html = "";
				for (var i = 0; i < regions.length; i++) {
					if (regions[i]._upper == $("#regionWish").val()) {
                    	html += "<li><input type='checkbox' class='flat' onclick='setRegion(1, " + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " /><label for=''>" + regions[i]._name + "<span class='badge bg-purple'>0</span></label></li>";
						//html += "<input type='checkbox' onclick='setRegion(1, " + regions[i]._index + ")' name='REGION_WISH' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
					}
				}
				//alert(html);
				document.getElementById('subWish').innerHTML = html;
			}
		</script>
	</head>

	<body>
		<form id="formData">


			<p>
				개인정보 등록<br/>
				<table border=1>
					<!--
					<tr>
						<td align=right>사진</td>
						<td>
							<input type=text name="IMAGE" />
						</td>
					</tr>
					-->
					<tr>
						<td align=right>이름</td>
						<td>
							<input type=text name="NAME" />
						</td>
					</tr>
					<tr>
						<td align=right>주민번호</td>
						<td>
							<input type=text name="SOCIAL_NUM" />
						</td>
					</tr>
					<tr>
						<td align=right>주소</td>
						<td>
							<input type=text name="POST" placeholder="우편번호" /><br/>
							<input type=text name="ADDRESS1" placeholder="주소" /><br/>
							<input type=text name="ADDRESS2" placeholder="상세주소" /><br/>
						</td>
					</tr>
					<tr>
						<td align=right>휴대전화</td>
						<td>
							<input type=text name="MOBILE" placeholder="예시) 010-0000-0000" />
						</td>
					</tr>
					<tr>
						<td align=right>일반전화</td>
						<td>
							<input type=text name="PHONE" placeholder="예시) 02-0000-0000" />
						</td>
					</tr>
				</table>
			</p>
			<p>
				자격정보 등록<br/>
				<table border=1>
					<tr>
						<td align=right>교육수료기관</td>
						<td>
							<input type=text name="EDUCATION" placeholder="" /><br/>
						</td>
					</tr>
					<tr>
						<td align=right>배상보험가입</td>
						<td>
							<input type=text name="INSURANCE" placeholder="" /><br/>
						</td>
					</tr>
					<tr>
						<td align=right>건강검진</td>
						<td>
							<input type=date name="HEALTH_CARE" />
						</td>
					</tr>
					<tr>
						<td align=right>수혜기간</td>
						<td>
							<input type=date name="BENEFIT_BEGIN" /><br/>
							<input type=date name="BENEFIT_END" />
						</td>
					</tr>
				</table>
			</p>

			<p>
				기타정보 등록<br/>
				<table border=1>
					<tr>
						<td align=right>종교</td>
						<td>
							<input type=text name="RELIGION" placeholder="" /><br/>
						</td>
					</tr>
					<tr>
						<td align=right>업무성향</td>
						<td>
							<input type='checkbox' name='WORK_TYPE' value='IN_HOUSE' />입주 선호
							<input type='checkbox' name='WORK_TYPE' value='COMMUTE' />출퇴근 선호
						</td>
					</tr>
					<tr>
						<td align=right>특이사항</td>
						<td>
							<textarea name="MEMO"></textarea>
						</td>
					</tr>
				</table>
			</p>

			<p>
				배속정보 등록<br/>
			</p>
			<hr/>
			<p>
				소속지점<br/>
				<table>
					<tr>
						<td>시/도</td>
						<td>시/군/구</td>
					</tr>
					<tr>
						<td>
							<select onchange="changedRegion_Belong()" id=regionBelong>
							<%
							for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
							{
								Region r = (Region)it.next();
								out.write("<option value=" + r._index + ">" + r._name + "</option>");
							}
							%>
							</select>
						</td>
						<td>
							<div id=subBelong></div>
						</td>
					</tr>
				</table>
			</p>
			<p>
				희망근무지역<br/>
				<table>
					<tr>
						<td>시/도</td>
						<td>시/군/구</td>
					</tr>
					<tr>
						<td>
							<select onchange="changedRegion_Wish()" id=regionWish>
							<%
							for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
							{
								Region r = (Region)it.next();
								out.write("<option value=" + r._index + ">" + r._name + "</option>");
							}
							%>
							</select>
						</td>
						<td>
							<div id=subWish></div>
						</td>
					</tr>
				</table>
			</p>

		</form>
		<button type="button" id="save">저장</button>
	</body>
</html>
