<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>

<%!
	List<Region> lstRegionsGroup; //= _userdb.getGiftList();
	List<Region> lstRegionsAll; //= _userdb.getGiftList();
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	int _index = -1;
%>

<%
	Branch item = null;
	Member member = null;
	Region curRegion = null;
	Region upRegion = null;
	int upper = -1;

	String branch = request.getParameter("BRANCH");
	_index = Integer.parseInt(branch);
	item = _userdb.getBranch(_index);

	lstRegionsGroup = _userdb.getRegionList(-1);
	lstRegionsAll = _userdb.getRegionList(0);

	String[] business = item._business.split("-");
	String[] registration = item._registration.split("-");

	//lstRegionsGroup = _userdb.getRegionList(-1);
	//lstRegionsAll = _userdb.getRegionList(0);

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

			var memberIndex = <%= item._member %>;
			var branchIndex = <%= item._index %>;

			function setEditFields() {
				//alert('<%= upRegion._name %>');
				$("#region").val(<%= upRegion._index %>);
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
					else
						boxs[i].checked = true;
				}
			}

			function changedRegion() {
				var html = "";
				for (var i = 0; i < regions.length; i++) {
					if (regions[i]._upper == $("#region").val()) {
						html += "<input type='checkbox' onclick='setRegion(" + regions[i]._index + ")' name='REGION' value=" + regions[i]._index + " />" + regions[i]._name + " \n";
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
				<table border=1>
					<tr>
						<td>계약자:<%= member._contractor %></div></td>
						<td>사업자:<%= member._business %></div></td>
						<td>아이디:<%= member._id %></div></td>
					</tr>
				</table>
			</p>

		<p>
			지사정보<br/>
			<table border=0>
				<tr>
					<td align=right>운영자 이름</td>
					<td>
						<input type=text name="OPERATOR" value='<%= item._operator %>' />
					</td>
				</tr>
				<tr>
					<td align=right>사업자 번호</td>
					<td>
						<input type=text name="BUSINESS1" value='<%= business[0] %>' />-
						<input type=text name="BUSINESS2" value='<%= business[1] %>' />-
						<input type=text name="BUSINESS3" value='<%= business[2] %>' />
					</td>
				</tr>
				<tr>
					<td align=right>직업소개등록번호</td>
					<td>
						제<input type=text name="REGISTRATION1" value='<%= registration[0] %>' />
						<input type=text name="REGISTRATION2" value='<%= registration[1] %>' />
						<input type=text name="REGISTRATION3" value='<%= registration[2] %>' />
						<input type=text name="REGISTRATION4" value='<%= registration[3] %>' />
						<input type=text name="REGISTRATION5" value='<%= registration[4] %>' />호
					</td>
				</tr>
				<tr>
					<td align=right>사무실 주소</td>
					<td>
						<input type=text name="POST" placeholder="우편번호" value='<%= item._post %>' /><br/>
						<input type=text name="ADDRESS1" placeholder="주소" value='<%= item._address1 %>' />
						<input type=text name="ADDRESS2" placeholder="상세주소" value='<%= item._address2 %>' />
					</td>
				</tr>
				<tr>
					<td align=right>일반서비스 계좌번호</td>
					<td>
						<input type=text name="BANK_NAME" placeholder="" value='<%= item._bankName %>' /><br/>
						<input type=text name="BANK_ACCOUNT" placeholder="계좌번호" value='<%= item._bankAccount %>' /><br/>
						<input type=text name="BANK_OWNER" placeholder="예금주" value='<%= item._bankOwner %>' />
					</td>
				</tr>
				<tr>
					<td align=right>바우처서비스 계좌번호</td>
					<td>
						<input type=text name="VOUCHER_NAME" placeholder="" value='<%= item._voucherName %>' /><br/>
						<input type=text name="VOUCHER_ACCOUNT" placeholder="계좌번호" value='<%= item._voucherAccount %>' /><br/>
						<input type=text name="VOUCHER_OWNER" placeholder="예금주" value='<%= item._voucherOwner %>' />
					</td>
				</tr>
				<tr>
					<td align=right>이메일</td>
					<td>
						<input type=text name="EMAIL" placeholder="id@gmail.com" value='<%= item._email %>' />
					</td>
				</tr>
				<tr>
					<td align=right>휴대전화</td>
					<td>
						<input type=text name="MOBILE" placeholder="010-1111-2222" value='<%= item._mobile %>' />
					</td>
				</tr>
				<tr>
					<td align=right>사무실(일반)전화</td>
					<td>
						<input type=text name="OFFICE" placeholder="02-1111-2222" value='<%= item._office %>' />
					</td>
				</tr>
				<tr>
					<td align=right>팩스</td>
					<td>
						<input type=text name="FAX" placeholder="02-1111-2222" value='<%= item._fax %>' />
					</td>
				</tr>
				<tr>
					<td align=right>계약체결일</td>
					<td>
						<input type=date name="CONTRACT_MADE" value='<%= df.format(item._contractMade) %>' />
					</td>
				</tr>
				<tr>
					<td align=right>계약시작</td>
					<td>
						<input type=date name="CONTRACT_BEGIN" value='<%= df.format(item._contractBegin) %>' />
					</td>
				</tr>
				<tr>
					<td align=right>계약만료일</td>
					<td>
						<input type=date name="CONTRACT_END" value='<%= df.format(item._contractEnd) %>' />
					</td>
				</tr>
				<tr>
					<td align=right>약력(경력사항)</td>
					<td>
						<textarea name="PROFILE" id="PROFILE"><%= item._profile %></textarea>
					</td>
				</tr>
				<tr>
					<td align=right>특양사항</td>
					<td>
						<textarea name="SPECIAL"><%= item._special %></textarea>
					</td>
				</tr>
			</table>
		</p>
		</form>
		<button type="button" id="save">저장</button>
	</body>
</html>
