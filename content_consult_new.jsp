<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!
	String arrVoucher[] =
	{
		"A-가-1",
		"A-가-2",
		"A-가-3",
		"A-나-1",
		"A-나-2",
		"A-나-3",
		"A-다-1",
		"A-다-2",
		"A-다-3",
		"A-라-1",
		"A-라-2",
		"A-라-3",
		"B-가-1",
		"B-가-2",
		"B-나-1",
		"B-나-2",
		"B-다-1",
		"B-다-2",
		"B-라-1",
		"B-라-2",
		"C-가",
		"C-나",
		"C-다",
		"C-라"
	};
	String arrServices[][] =
	{
		{ "BASIC", "베이직 서비스" },
		{ "PREMIUM", "프리미엄 서비스" },
		{ "VIP", "vip 서비스" },
		{ "PRIVATE", "프라이빗 서비스" },
		{ "TWINS", "다둥이 프로그램(쌍둥이 프로그램)" },
		{ "MULTIPLES", "다둥이 프로그램(다둥이 프로그램)" },
		{ "INTENSIVE(WORKINGMOM)", "집중관리 프로그램(워킹맘 케어 프로그램)" },
		{ "INTENSIVE(CAREHOME)", "집중관리 프로그램(산후조리원 내집에 프로그램)" },
		{ "INTENSIVE(35)", "집중관리 프로그램(35세 이상 산모 집중케어)" },
		{ "INTENSIVE(HEAVY)", "집중관리 프로그램(과체중 산모케어)" }
	};

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	public String fillValue(String name, String val)
	{
		return "$('#"+name+"').val('"+val+"');\n";
	}

	public String fillValue(String name, int val)
	{
		return "$('#"+name+"').val('"+val+"');\n";
	}
%>


<html>
	<head>
		<title>신규 상담</title>
		<script
		src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
		<script src="js/content_consult_new.js" ></script>
		<script src="js/base64.js" ></script>
		<script>
			function setCheck(name, val) {
				//document.getElementsById(name).checked = true;
				temp = document.getElementsByName(name);
				for (i = 0; i < temp.length; i++) {
					if (temp[i].value == val) {
						temp[i].checked = true;
					}
				}
			}

			function writePeriodList(name) {
				document.write("<select name='" + name + "' id='" + name + "' >\n");
				document.write("<option value='0' selected>기간선택</option>\n");
				for (var i = 1; i <= 31; i++) {
						document.write("<option value='" + i + "'>" + i + "일</option>\n");
					}
				document.write("</select>");
			}


			$(function() {
<%
			Customer item;
			String customerIndex;
			String fill = "";
			int index;
			int idx;

			customerIndex = request.getParameter("CUSTOMER");
			if (customerIndex != null)
			{
				index = Integer.parseInt(customerIndex);
				item = _userdb.getCustomerItem(index);

				fill += fillValue("NAME", item._name);
				fill += fillValue("MOBILE", item._mobile);
				fill += fillValue("PHONE", item._phone);
				fill += fillValue("POST", item._phone);
				fill += fillValue("ADDRESS1", item._address1);
				fill += fillValue("ADDRESS2", item._address2);
				fill += fillValue("ROUTE_VALUE", item._routeVal);

				fill += fillValue("HOSPITAL", item._hospital);
				fill += fillValue("CARECENTER_PERIOD", item._careCenterPeriod);

				if (item._expectedDate != null)
					fill += fillValue("DUEDATE_BIRTH", df.format(item._expectedDate));
				if (item._operationDate != null)
					fill += fillValue("DUEDATE_OPERATION", df.format(item._operationDate));
				if (item._babyBirth != null)
					fill += fillValue("BABY_BIRTH", df.format(item._babyBirth));

				String s[] = item._routes.split(" ");
				for (idx = 0; idx < s.length; idx++)
				{
					fill += "setCheck('ROUTE', '" + s[idx] + "');\n";
				}

				//fill += fillValue("RentalName", item._rentalIndex);
				if (item._rentalBegin != null)
					fill += fillValue("RENTAL_START", df.format(item._rentalBegin));
				if (item._rentalEnd != null)
					fill += fillValue("RENTAL_END", df.format(item._rentalEnd));
				if (item._rentalDeliveryPayed != null)
					fill += fillValue("RENTAL_DELIVERY_PAYED", df.format(item._rentalDeliveryPayed));
				fill += fillValue("DELIVERY_COST", item._rentalDeliveryCost);
				if (item._rentalPayed != null)
					fill += fillValue("RENTAL_PAYED", df.format(item._rentalPayed));
				fill += fillValue("RENTAL_COST", item._rentalCost);

				//fill += fillValue("GiftName", item._giftIndex);
				if (item._giftSent != null)
					fill += fillValue("GIFT_SENT_DATE", df.format(item._giftSent));

				//fill += fillValue("TerminalName", item._terminalIndex);
				if (item._terminalBegin != null)
					fill += fillValue("TERMINAL_START", df.format(item._terminalBegin));
				if (item._terminalEnd != null)
					fill += fillValue("TERMINAL_END", df.format(item._terminalEnd));

				if (item._recommendIndex != -1)
				{
					Customer recommend = _userdb.getCustomerItem(item._recommendIndex);
					if (recommend != null)
						fill += fillValue("RECOMMEND", recommend._name);
					out.write("recommenderIndex = " + item._recommendIndex + ";\n");
				}
				if (item._rentalIndex != -1)
				{
					Rental rental = _userdb.getRental(item._rentalIndex);
					if (rental != null)
						fill += fillValue("RentalName", rental._name);
					out.write("rentalIndex = " + item._rentalIndex + ";\n");
				}
				if (item._giftIndex != -1)
				{
					Gift gift = _userdb.getGift(item._giftIndex);
					if (gift != null)
						fill += fillValue("GiftName", gift._name);
					out.write("giftIndex = " + item._giftIndex + ";\n");
				}
				if (item._terminalIndex != -1)
				{
					Terminal terminal = _userdb.getTerminal(item._terminalIndex);
					if (terminal != null)
						fill += fillValue("TerminalName", terminal._no);
					out.write("terminalIndex = " + item._terminalIndex + ";\n");
				}

				out.write(fill);
				//out.write("alert('" + item._routes.length() + "');");
				//out.write("alert('" + item._memo + "');");
%>
				setChildrenString('<%=item._experiences%>');
				setBabiesString('<%=item._babyTypes%>');

				indexCustomer = <%=item._index%>;

				setCheck('BABY_TYPE_EXPECTED', '<%=item._babyTypeExpected%>');
				setCheck('DISABLED', '<%=item._disabledType%>');
				setCheck('CARECENTER', '<%=item._careCenter%>');
				setCheck('CARE_PLACE_EXPECTED', '<%=item._servicePlaceWish%>');

				setCheck('CHILDBIRTH_TYPE', '<%=item._childBirthType%>');
				setCheck('CARE_PLACE_REAL', '<%=item._servicePlaceReal%>');

				document.getElementById("COUNSEL_CONTENT").innerHTML = base64.decode('<%=item._memo%>'.replace(/\s/g, "+"));
				$("#VOUCHER").val('<%=(item._voucherType != null) ? item._voucherType : "none" %>');
				setCheck('VOUCHER_PERIOD', '<%=item._voucherDays%>');
				setPets('<%=item._pets%>');
				setCheck('CASHBILL', '<%=item._cashReceipt%>');

				loadCustomerServices();
<%
			}
			else
			{
				UserDB.makeNewCustomer
			}
%>
			});
			/*
			$(document).ready(function() {
				$("#save").click(function() {
					alert("ready");
					submitMe();
				});
			});
			*/
		</script>
	</head>

	<body>
		<!--<form action="_counsel_add.jsp" method=post>-->
		<form id=formData>
			<table border=1>
				<tr><td colspan="2">■기본정보</td></tr>
				<tr>
					<td align=center>성함</td>
					<td>
						<input type=text name="NAME" id="NAME" size="30" />
					</td>
				</tr>
				<tr>
					<td align=center>휴대전화</td>
					<td>
						<input type=text name="MOBILE" id="MOBILE" />
					</td>
				</tr>
				<tr>
					<td align=center>일반전화</td>
					<td>
						<input type=text name="PHONE" id="PHONE" />
					</td>
				</tr>
				<tr>
					<td align=center>주소</td>
					<td>
						<input type=text name="POST" placeholder="우편번호" id="POST" /><br/>
						<input type=text name="ADDRESS1" placeholder="주소" id="ADDRESS1" /><br/>
						<input type=text name="ADDRESS2" placeholder="상세주소" id="ADDRESS2" /><br/>
					</td>
				</tr>
				<tr><td colspan="2">■접근/추천</td></tr>
				<tr>
					<td align=center>접근분류선택</td>
					<td>
						<input type="checkbox" name="ROUTE" value="phone" />전화옴
						<input type="checkbox" name="ROUTE" value="web" />홈페이지
						<input type="checkbox" name="ROUTE" value="exhibition" />전시회
						<input type="checkbox" name="ROUTE" value="voucher" />바우처
						<input type="checkbox" name="ROUTE" value="center" />조리원소개
						<input type="checkbox" name="ROUTE" value="etc" />기타<br/>
						<input type=text name="ROUTE_VALUE" id="ROUTE_VALUE" placeholder="기타 접근, 추천 내용" /><br/>
					</td>
				</tr>
				<tr>
					<td align=center>추천경로선택</td>
					<td>
						<input type="checkbox" name="ROUTE" value="recommend" />지인추천
						<input type="checkbox" name="ROUTE" value="search" />검색
						<input type="checkbox" name="ROUTE" value="blog" />블로그<br/>
						<input type=text name="RECOMMEND" id="RECOMMEND" placeholder="추천인의 이름, id, 휴대번호" />
						<button onclick="openRecommendSelectionWindow()" type="button">검색</button>
					</td>
				</tr>
				<tr><td colspan="2">■가입정보</td></tr>
				<tr>
					<td align=center>아이디</td>
					<td>
						<input type=text name="ID" id="USERID" readonly value="정보입력중" />
						<button onclick="checkSignIn()" type="button">상태확인</button><br/>
						<button onclick="sendSMS()" type="button">가입문자발송</button>
						<button onclick="viewSMS()" type="button">문자내용보기</button>
					</td>
				</tr>
				<tr><td colspan="2">■출산정보/사전정보</td></tr>
				<tr>
					<td align=center>지정병원</td>
					<td>
						<input type=text name="HOSPITAL" id="HOSPITAL" />
					</td>
				</tr>
				<tr>
					<td align=center>출산예정일</td>
					<td>
						<input type=date name="DUEDATE_BIRTH" id="DUEDATE_BIRTH" />
					</td>
				</tr>
				<tr>
					<td align=center>수술예정일</td>
					<td>
						<input type=date name="DUEDATE_OPERATION" id="DUEDATE_OPERATION" />
					</td>
				</tr>
				<tr>
					<td align=center>출산경험</td>
					<td>
						<input type="radio" name="CHILD_GENDER" value="boy" checked /> 남 
						<input type="radio" name="CHILD_GENDER" value="girl" /> 여 
						<input type=text name="CHILD_AGE" id="child_age" /> 세 
						<button onclick="addChild()" type="button">+</button><br/>
						<p id="children" align=center>없음
						</p>
					</td>
				</tr>
				<tr>
					<td align=center>태아유형(예정)</td>
					<td>
						<input type="radio" name="BABY_TYPE_EXPECTED" value="single" id="BABY_TYPE_EXPECTED" /> 단태아 <br/>
						<input type="radio" name="BABY_TYPE_EXPECTED" value="twin" id="BABY_TYPE_EXPECTED" /> 쌍둥이 <br/>
						<input type="radio" name="BABY_TYPE_EXPECTED" value="more" id="BABY_TYPE_EXPECTED" /> 세쌍둥이이상 
					</td>
				</tr>
				<tr>
					<td align=center>중증장애산모</td>
					<td>
						<input type="radio" name="DISABLED" value="true" /> 예 <br/>
						<input type="radio" name="DISABLED" value="false" checked /> 아니오 
					</td>
				</tr>
				<tr>
					<td align=center>산후조리원이용</td>
					<td>
						<input type="radio" name="CARECENTER" value="true" /> 예 
						<input type=text name="CARECENTER_PERIOD" id="CARECENTER_PERIOD"/> 주<br/>
						<input type="radio" name="CARECENTER" value="false" /> 아니오 
					</td>
				</tr>
				<tr>
					<td align=center>관리사서비스희망장소</td>
					<td>
						<input type="radio" name="CARE_PLACE_EXPECTED" value="home" checked /> 자택 <br/>
						<input type="radio" name="CARE_PLACE_EXPECTED" value="home_mother" /> 친정 <br/>
						<input type="radio" name="CARE_PLACE_EXPECTED" value="home_father" /> 시댁 <br/>
					</td>
				</tr>
				<tr><td colspan="2">■출산정보/완료정보</td></tr>
				<tr>
					<td align=center>출산일</td>
					<td>
						<input type=date name="BABY_BIRTH" id="BABY_BIRTH" />
					</td>
				</tr>
				<tr>
					<td align=center>태아유형(출산)</td>
					<td>
						<input type="radio" name="BABY_GENDER" value="boy" checked /> 남 
						<input type="radio" name="BABY_GENDER" value="girl" /> 여 
						<input type=text name="CHILD_WEIGHT" id="baby_weight" /> Kg 
						<button onclick="addBaby()" type="button">+</button><br/>
						<p id="babies" align=center>미입력
						</p>
					</td>
				</tr>
				<tr>
					<td align=center>분만형태</td>
					<td>
						<input type="radio" name="CHILDBIRTH_TYPE" id="CHILDBIRTH_TYPE" value="natural" checked /> 자연분만 <br/>
						<input type="radio" name="CHILDBIRTH_TYPE" id="CHILDBIRTH_TYPE" value="operation" /> 제왕절개 <br/>
					</td>
				</tr>
				<tr>
					<td align=center>관리사서비스장소</td>
					<td>
						<input type="radio" name="CARE_PLACE_REAL" value="home" checked /> 자택 <br/>
						<input type="radio" name="CARE_PLACE_REAL" value="home_mother" /> 친정 <br/>
						<input type="radio" name="CARE_PLACE_REAL" value="home_father" /> 시댁 <br/>
					</td>
				</tr>
				<tr><td colspan="2">■서비스/계약정보</td></tr>
				<tr>
					<td align=center>상담</td>
					<td align=center>
						상담내용<br/>
						<textarea rows="4" cols="50" id="COUNSEL_CONTENT"></textarea><br/>
						<button onclick="saveCounsel()" type="button">저장</button>
					</td>
				</tr>
				<tr>
					<td align=center>서비스 금액</td>
					<td align=left>
						<p id="cost_base">
						</p>
						<p id="cost_extended">
						</p>
						<p id="cost_total">
						</p>
						<p align=center>
							<button onclick="alert('입금확인 했습니다.')" type="button">입금확인</button>
						</p>
					</td>
				</tr>
				<tr>
					<td align=center>바우처</td>
					<td align=left>
						바우처 소득 유형<br/>
						<select name="VOUCHER" id="VOUCHER">
							<option value="none" selected>소득유형선택</option>
							<%
								for (idx = 0; idx < arrVoucher.length; idx++)
								{
									out.write("<option value='" + arrVoucher[idx] + "'>" + arrVoucher[idx] + "</option>\n");
								}
							%>
						</select><br/>
						바우처 서비스 기간<br/>
						<input type="radio" name="VOUCHER_PERIOD" value="5" /> 5일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="10" /> 10일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="15" /> 15일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="20" /> 20일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="25" /> 25일 <br/>
					</td>
				</tr>


				<!-------------------------- 가변 영역 시작 ------------------------------>


				<tr>
					<td align=center>
						서비스/연장 정보 입력<br/>
						<button onclick="addCustomerService();" type="button">서비스/연장정보 추가</button>
					</td>
					<td id=org>
						<table border=1>
							<tr>
								<td>서비스기간</td>
								<td>
									<select name="SERVICE_NAME_<CS_INDEX>" id="SERVICE_NAME_<CS_INDEX>">
										<option value="none" selected>서비스선택</option>
										<%
											for (int i = 0; i < arrServices.length; i++) {
												out.print("<option value='" + arrServices[i][0] + "'>" + arrServices[i][1] + "</option>");
											}
										%>
									</select>
									<select name="SERVICE_PERIOD_<CS_INDEX>" id="SERVICE_PERIOD_<CS_INDEX>">
										<option value="0" selected>기간선택</option>
										<%
											for (int i = 1; i <= 30; i++) {
												out.print("<option value='" + i + "'>" + i + "일</option>");
											}
										%>
									</select>
								</td>
							</tr>
							<tr>
								<td>서비스시작일</td>
								<td><input type=date name="SERVICE_START_DATE_<CS_INDEX>" id="SERVICE_START_DATE_<CS_INDEX>" /></td>
							</tr>
							<tr>
								<td>서비스종료일</td>
								<td><input type=date name="SERVICE_END_DATE_<CS_INDEX>" id="SERVICE_END_DATE_<CS_INDEX>" /></td>
							</tr>
							<tr>
								<td>서비스형태</td>
								<td>
									<input type="radio" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="inhouse" onclick="hideMixed(<CS_INDEX>)" checked /> 입주
									<input type="radio" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="commute" onclick="hideMixed(<CS_INDEX>)" /> 출퇴근
									<input type="radio" name="SERVICE_TYPE_<CS_INDEX>" id="SERVICE_TYPE_<CS_INDEX>" value="mixed" onclick="showMixed(<CS_INDEX>)" /> 입주+출퇴근 <br/>

									<input type="radio" name="SERVICE_DAYS_<CS_INDEX>" id="SERVICE_DAYS_<CS_INDEX>" value="5" checked /> 5일
									<input type="radio" name="SERVICE_DAYS_<CS_INDEX>" id="SERVICE_DAYS_<CS_INDEX>" value="6" /> 6일 <br/>

									<div id="mymixed_<CS_INDEX>">
										입주시작: <input type=date name='INHOUSE_DATE_<CS_INDEX>' id='INHOUSE_DATE_<CS_INDEX>' /><br/>
										<input type="radio" name="SERVICE_MIXED_INHOUSE_<CS_INDEX>" id="SERVICE_MIXED_INHOUSE_<CS_INDEX>" value="5" checked onclick="alert('123')"/> 입주 5일 <br/>
										<input type="radio" name="SERVICE_MIXED_INHOUSE_<CS_INDEX>" id="SERVICE_MIXED_INHOUSE_<CS_INDEX>" value="6" /> 입주 6일 <br/>

										출근시작: <input type=date name='COMMUTE_DATE_<CS_INDEX>' id='COMMUTE_DATE_<CS_INDEX>' /> <br/>
										<input type="radio" name="SERVICE_MIXED_COMMUTE_<CS_INDEX>" id="SERVICE_MIXED_COMMUTE_<CS_INDEX>" value="5" checked /> 출퇴근 5일 <br/>
										<input type="radio" name="SERVICE_MIXED_COMMUTE_<CS_INDEX>" id="SERVICE_MIXED_COMMUTE_<CS_INDEX>" value="6" /> 출퇴근 6일 <br/>
									</div>
								</td>
							</tr>
							<tr>
								<td>관리사 배정</td>
								<td>
									<button onclick="openHelperSelectionWindow(<CS_INDEX>);" type="button">관리사목록</button>
									<input type=text name='HELPER_NAME_<CS_INDEX>' id='HelperName_<CS_INDEX>' placeholder='관리사를 지정해 주세요.' readonly />
								</td>
							</tr>
							<tr>
								<td>관리시작 변경일</td>
								<td>
									<input type=date name='CARE_CHANGE_<CS_INDEX>' id='CARE_CHANGE_<CS_INDEX>' />
								</td>
							</tr>
							<tr>
								<td>추가금 케어형태</td>
								<td>
									<!--
									<input type=checkbox onclick="checkCare('family')" id='check_family' name="care[]" value="family" /> 가족케어 <br/>
									<input type=checkbox onclick="checkCare('school')" id='check_school' name="care[]" value="school" /> 취학아동 <br/>
									<input type=checkbox onclick="checkCare('additional')" id='check_additional' name="care[]" value="additional" /> 추가가족 <br/>
									<input type=checkbox onclick="checkCare('twin')" id='check_twin' name="care[]" value="twin" /> 쌍둥이케어 <br/>
									-->
									<input type=checkbox id='CARE_FAMILY_<CS_INDEX>' value="family" /> 가족케어
									<input type=date name='CARE_FAMILY_START_<CS_INDEX>' id='CARE_FAMILY_START_<CS_INDEX>' />
									<input type=date name='CARE_FAMILY_END_<CS_INDEX>' id='CARE_FAMILY_END_<CS_INDEX>' />
									<br/>

									<input type=checkbox id='CARE_SCHOOL_<CS_INDEX>'  value="school" /> 취학아동
									<input type=date name='CARE_SCHOOL_START_<CS_INDEX>' id='CARE_SCHOOL_START_<CS_INDEX>' />
									<input type=date name='CARE_SCHOOL_END_<CS_INDEX>' id='CARE_SCHOOL_END_<CS_INDEX>' />
									<br/>

									<input type=checkbox id='CARE_ADDITIONAL_<CS_INDEX>' value="additional" /> 추가가족
									<input type=date name='CARE_ADDITIONAL_START_<CS_INDEX>' id='CARE_ADDITIONAL_START_<CS_INDEX>' />
									<input type=date name='CARE_ADDITIONAL_END_<CS_INDEX>' id='CARE_ADDITIONAL_END_<CS_INDEX>' />
									<br/>

									<input type=checkbox id='CARE_TWIN_<CS_INDEX>' value="twin" /> 쌍둥이케어
									<input type=date name='CARE_TWIN_START_<CS_INDEX>' id='CARE_TWIN_START_<CS_INDEX>' />
									<input type=date name='CARE_TWIN_END_<CS_INDEX>' id='CARE_TWIN_END_<CS_INDEX>' />
									<br/>
								</td>
							</tr>
							<tr>
								<td>초과 시간</td>
								<td>
									<input type="date" id='OVERTIME_DATE_<CS_INDEX>' />
									<input type=text id='OVERTIME_HOURS_<CS_INDEX>' placeholder='초과시간(1시간단위)' /> 시간
									<button onclick="addOverTime(<CS_INDEX>)" type="button">+</button><br/>
									<p id="OVERTIMES_<CS_INDEX>" align=center>초과근무 없음
									</p>
									<br/>
								</td>
							</tr>
							<tr>
								<td>기본 서비스</td>
								<td>
									전신마사지<br/>
									횟수선택 : <input type=text id='MASSAGE_COUNT_<CS_INDEX>' value='0' /> 회 <br/>
									신 청 일 : <input type="date" id='MASSAGE_DATE_<CS_INDEX>' /> <br/>
									<br/>
									방문간호사<br/>
									횟수선택 : <input type=text id='NURSE_COUNT_<CS_INDEX>' value='0' /> 회 <br/>
									신 청 일 : <input type="date" id='NURSE_DATE_<CS_INDEX>' /> <br/>
									<br/>
									소독서비스<br/>
									횟수선택 : <input type=text id='DISINFECT_COUNT_<CS_INDEX>' value='0' /> 회 <br/>
									신 청 일 : <input type="date" id='DISINFECT_DATE_<CS_INDEX>' /> <br/>
									<br/>
								</td>
							</tr>
						</table>
					</td>
				</tr>


				<!-------------------------- 가변 영역 종료 ------------------------------>


				<tr>
					<td align=center>기타 정보</td>
					<td>
						<table>
							<tr>
								<td>반려동물</td>
								<td align=center>
									고양이 <input type=text id='PET_CAT_COUNT' value='0' /><br/>
									새 <input type=text id='PET_BIRD_COUNT' value='0' /><br/>
									개 <input type=text id='PET_DOG_COUNT' value='0' /><br/>
									기타 <input type=text id='PET_ETC_COUNT' value='0' /><br/>
								</td>
							</tr>
							<tr>
								<td>대여품목</td>
								<td>
									<button onclick="openRentalSelectionWindow();" type="button">대여품목선택</button>
									<input type=text name='RENTAL_NAME' id='RentalName' placeholder='대여할 물품을 입력해 주세요.' readonly /> <br/>
									시작일 : <input type="date" name='RENTAL_START' id='RENTAL_START' /> <br/>
									회수일 : <input type="date" name='RENTAL_END' id='RENTAL_END' /> <br/>
									택배비<br/>
									입금 : <input type="date" name='RENTAL_DELIVERY_PAYED' id='RENTAL_DELIVERY_PAYED' /> <br/>
									비용 : <input type=text name='DELIVERY_COST' id='DELIVERY_COST' /> 원 <br/>
									대여비<br/>
									입금 : <input type="date" name='RENTAL_PAYED' id='RENTAL_PAYED' /> <br/>
									비용 : <input type=text name='RENTAL_COST' id='RENTAL_COST' /> 원 <br/>
								</td>
							</tr>
							<tr>
								<td>선물</td>
								<td>
									<button onclick="openGiftSelectionWindow();" type="button">선물선택</button>
									<input type=text name='GIFT_NAME' id='GiftName' placeholder='대여할 물품을 입력해 주세요.' readonly /> <br/>
									발송일 : <input type="date" name='GIFT_SENT_DATE' id='GIFT_SENT_DATE' /> <br/>
								</td>
							</tr>
							<tr>
								<td>단말기</td>
								<td>
									<button onclick="openTerminalSelectionWindow();" type="button">단말기검색</button>
									<input type=text name='TERMINAL_NAME' id='TerminalName' placeholder='단말기를 검색해 주세요.' readonly /> <br/>
									시작일 : <input type="date" name='TERMINAL_START' id='TERMINAL_START' /> <br/>
									회수일 : <input type="date" name='TERMINAL_END' id='TERMINAL_END' /> <br/>
								</td>
							</tr>
							<tr>
								<td>현금영수증</td>
								<td>
									<input type="radio" name="CASHBILL" id="CASHBILL" value="yes" /> 예 <br/>
									<input type="radio" name="CASHBILL" id="CASHBILL" value="no" /> 아니오 <br/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<!--<button id=save type="button" >저장</button><br/>-->
		<button id=save type="button" >저장</button><br/>
		<p>
			<div id=error></div>
		</p>
	</body>
</html>
