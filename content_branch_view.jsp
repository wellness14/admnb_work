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

	String branch = request.getParameter("BRANCH");
	_index = Integer.parseInt(branch);
	item = _userdb.getBranch(_index);

	lstRegionsGroup = _userdb.getRegionList(-1);
	lstRegionsAll = _userdb.getRegionList(0);

	String[] business = item._business.split("-");
	String[] registration = item._registration.split("-");
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

			var branchIndex = <%= _index %>;

			$(document).ready(function() {
				$("#delete").click(function() {
					$.post("_branch_update.jsp?DELETE&INDEX=" + branchIndex, '')
					.fail(function(response) {
						$("#PROFILE").val(response.responseText);
					})
					.done(function(data) {
						window.location.href = 'content_branch_list.jsp';
					});
				});
				$("#edit").click(function() {
					window.location.href = 'content_branch_edit.jsp?BRANCH=' + branchIndex;
				});
				$("#list").click(function() {
					window.location.href = 'content_branch_list.jsp';
				});
			});

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
		<p>
			지사정보<br/>
			<table border=0>
				<tr>
					<td align=right>운영자 이름</td>
					<td>
						<input type=text name="OPERATOR" value='<%= item._operator %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>사업자 번호</td>
					<td>
						<input type=text name="BUSINESS1" value='<%= business[0] %>' readonly />-
						<input type=text name="BUSINESS2" value='<%= business[1] %>' readonly />-
						<input type=text name="BUSINESS3" value='<%= business[2] %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>직업소개등록번호</td>
					<td>
						제<input type=text name="REGISTRATION1" value='<%= registration[0] %>' readonly />
						<input type=text name="REGISTRATION2" value='<%= registration[1] %>' readonly />
						<input type=text name="REGISTRATION3" value='<%= registration[2] %>' readonly />
						<input type=text name="REGISTRATION4" value='<%= registration[3] %>' readonly />
						<input type=text name="REGISTRATION5" value='<%= registration[4] %>' readonly />호
					</td>
				</tr>
				<tr>
					<td align=right>사무실 주소</td>
					<td>
						<input type=text name="POST" placeholder="우편번호" value='<%= item._post %>' readonly /><br/>
						<input type=text name="ADDRESS1" placeholder="주소" value='<%= item._address1 %>' readonly />
						<input type=text name="ADDRESS2" placeholder="상세주소" value='<%= item._address2 %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>일반서비스 계좌번호</td>
					<td>
						<input type=text name="BANK_NAME" placeholder="" value='<%= item._bankName %>' readonly /><br/>
						<input type=text name="BANK_ACCOUNT" placeholder="계좌번호" value='<%= item._bankAccount %>' readonly /><br/>
						<input type=text name="BANK_OWNER" placeholder="예금주" value='<%= item._bankOwner %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>바우처서비스 계좌번호</td>
					<td>
						<input type=text name="VOUCHER_NAME" placeholder="" value='<%= item._voucherName %>' readonly /><br/>
						<input type=text name="VOUCHER_ACCOUNT" placeholder="계좌번호" value='<%= item._voucherAccount %>' readonly /><br/>
						<input type=text name="VOUCHER_OWNER" placeholder="예금주" value='<%= item._voucherOwner %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>이메일</td>
					<td>
						<input type=text name="EMAIL" placeholder="id@gmail.com" value='<%= item._email %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>휴대전화</td>
					<td>
						<input type=text name="MOBILE" placeholder="010-1111-2222" value='<%= item._mobile %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>사무실(일반)전화</td>
					<td>
						<input type=text name="OFFICE" placeholder="02-1111-2222" value='<%= item._office %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>팩스</td>
					<td>
						<input type=text name="FAX" placeholder="02-1111-2222" value='<%= item._fax %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>계약체결일</td>
					<td>
						<input type=date name="CONTRACT_MADE" value='<%= df.format(item._contractMade) %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>계약시작</td>
					<td>
						<input type=date name="CONTRACT_BEGIN" value='<%= df.format(item._contractBegin) %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>계약만료일</td>
					<td>
						<input type=date name="CONTRACT_END" value='<%= df.format(item._contractEnd) %>' readonly />
					</td>
				</tr>
				<tr>
					<td align=right>약력(경력사항)</td>
					<td>
						<textarea name="PROFILE" id="PROFILE" readonly><%= item._profile %></textarea>
					</td>
				</tr>
				<tr>
					<td align=right>특양사항</td>
					<td>
						<textarea name="SPECIAL" readonly><%= item._special %></textarea>
					</td>
				</tr>
			</table>
		</p>
		<button type="button" id="delete">삭제</button>
		<button type="button" id="edit">수정</button>
		<button type="button" id="list">목록</button>
	</body>
</html>
