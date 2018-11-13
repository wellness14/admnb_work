<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsGroup; //= _userdb.getGiftList();
	List<Region> lstRegionsAll; //= _userdb.getGiftList();
//	DateFormat dfApply = new SimpleDateFormat("yyyy-MM-dd");
//	String _type;
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
		<title>Wellness Login</title>
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

			function setEditFields() {
					//alert("init:" + <%=index%>);
					//setRegion(regions[0]._index);
					changedRegion();
			}

			$(document).ready(function() {
				$("#search").click(function() {
    				var myWindow = window.open("sub_select_member.jsp?SEARCH=" + $("#PATTERN").val(), "selectHelper", "width=500,height=500");
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
					//alert('Member:' + memberIndex);
					//alert($("#term").serialize() + "&INDEX=" + <%= index %>);
					var val = 'MEMBER=' + memberIndex + '&' + $("#formData").serialize();
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
				//	window.location.href = "content_gift_list.jsp";
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
				//alert(index);
				var boxs = document.getElementsByName("REGION");
				for (var i = 0; i < boxs.length; i++) {
					if (boxs[i].value != index)
						boxs[i].checked = false;
					else {
						boxs[i].checked = true;
					}
				}
				//alert()
			}
			function changedRegion() {
				//alert($("#region").val());
				var html = "";
				for (var i = 0; i < regions.length; i++) {
					if (regions[i]._upper == $("#region").val()) {
						html += "<input type='checkbox' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
					}
				}
				//alert(html);
				document.getElementById('sub').innerHTML = html;
			}

			function setMember(index, contractor, business, id) {
				document.getElementById('CONTRACTOR').innerHTML = contractor;
				document.getElementById('BUSINESS').innerHTML = business;
				document.getElementById('ID').innerHTML = id;
				memberIndex = index;
			}
		</script>
	</head>

	<body>
		<form id="formData">
			<p>
				가맹지역 선택/변경<br/>
				<table>
					<tr><td>
					<select onchange="changedRegion()" id=region>
					<%
					for (Iterator it = lstRegionsGroup.iterator(); it.hasNext(); )
					{
						Region r = (Region)it.next();
						out.write("<option value=" + r._index + ">" + r._name + "</option>");
					}
					%>
					</select>
					</td><td>
					<div id=sub></div>
					</td></tr>
				</table>
			</p>
			<p>
				지사계정 불러오기<br/>
				<input type=text id="PATTERN" />
				<button type="button" id="search">검색</button><br/>
				<table border=1>
					<tr>
						<td>계약자:<div id="CONTRACTOR"></div></td>
						<td>사업자:<div id="BUSINESS"></div></td>
						<td>아이디:<div id="ID"></div></td>
					</tr>
				</table>
			</p>

			<p>
				지사정보<br/>
				<table border=0>
					<tr>
						<td align=right>운영자 이름</td>
						<td>
							<input type=text name="OPERATOR" />
						</td>
					</tr>
					<tr>
						<td align=right>사업자 번호</td>
						<td>
							<input type=text name="BUSINESS1" />-
							<input type=text name="BUSINESS2" />-
							<input type=text name="BUSINESS3" />
						</td>
					</tr>
					<tr>
						<td align=right>직업소개등록번호</td>
						<td>
							제<input type=text name="REGISTRATION1" />
							<input type=text name="REGISTRATION2" />
							<input type=text name="REGISTRATION3" />
							<input type=text name="REGISTRATION4" />
							<input type=text name="REGISTRATION5" />호
						</td>
					</tr>
					<tr>
						<td align=right>사무실 주소</td>
						<td>
							<input type=text name="POST" placeholder="우편번호" /><br/>
							<input type=text name="ADDRESS1" placeholder="주소" />
							<input type=text name="ADDRESS2" placeholder="상세주소" />
						</td>
					</tr>
					<tr>
						<td align=right>일반서비스 계좌번호</td>
						<td>
							<select name="BANK_NAME">
								<option value="기업은행">기업은행</option>
							</select>
							<input type=text name="BANK_ACCOUNT" placeholder="계좌번호" /><br/>
							<input type=text name="BANK_OWNER" placeholder="예금주" />
						</td>
					</tr>
					<tr>
						<td align=right>바우처서비스 계좌번호</td>
						<td>
							<select name="VOUCHER_NAME">
								<option value="기업은행">기업은행</option>
							</select>
							<input type=text name="VOUCHER_ACCOUNT" placeholder="계좌번호" /><br/>
							<input type=text name="VOUCHER_OWNER" placeholder="예금주" />
						</td>
					</tr>
					<tr>
						<td align=right>이메일</td>
						<td>
							<input type=text name="EMAIL" placeholder="id@gmail.com" />
						</td>
					</tr>
					<tr>
						<td align=right>휴대전화</td>
						<td>
							<input type=text name="MOBILE" placeholder="010-1111-2222" />
						</td>
					</tr>
					<tr>
						<td align=right>사무실(일반)전화</td>
						<td>
							<input type=text name="OFFICE" placeholder="02-1111-2222" />
						</td>
					</tr>
					<tr>
						<td align=right>팩스</td>
						<td>
							<input type=text name="FAX" placeholder="02-1111-2222" />
						</td>
					</tr>
					<tr>
						<td align=right>계약체결일</td>
						<td>
							<input type=date name="CONTRACT_MADE" />
						</td>
					</tr>
					<tr>
						<td align=right>계약시작</td>
						<td>
							<input type=date name="CONTRACT_BEGIN" />
						</td>
					</tr>
					<tr>
						<td align=right>계약만료일</td>
						<td>
							<input type=date name="CONTRACT_END" />
						</td>
					</tr>
					<tr>
						<td align=right>약력(경력사항)</td>
						<td>
							<textarea name="PROFILE" id="PROFILE"></textarea>
						</td>
					</tr>
					<tr>
						<td align=right>특양사항</td>
						<td>
							<textarea name="SPECIAL"></textarea>
						</td>
					</tr>
				</table>
			</p>
		</form>
		<button type="button" id="save">저장</button>
	</body>
</html>
