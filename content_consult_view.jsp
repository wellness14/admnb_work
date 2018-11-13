<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="header.jspf" %>
<!DOCTYPE html>

<%!
	public String fillValue(String name, String val)
	{
		return "$('#"+name+"').val('"+val+"');";
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
		<script>
			//function test() {
				$(function() {
<%
	Customer item;
	String temp = request.getParameter("CUSTOMER");
	int index;

	if (temp != null)
	{
		index = Integer.parseInt(temp);
		item = _userdb.getCustomerItem(index);
		out.write(fillValue("NAME", item._name));
		out.write(fillValue("MOBILE", item._mobile));
		out.write(fillValue("PHONE", item._phone));
		out.write(fillValue("POST", item._post));
		out.write(fillValue("ADDRESS1", item._address1));
		out.write(fillValue("ADDRESS2", item._address2));
	}
%>

				});
			//}
			//test();
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
						<input type="checkbox" name="ROUTE[]" value="phone" />전화옴
						<input type="checkbox" name="ROUTE[]" value="web" />홈페이지
						<input type="checkbox" name="ROUTE[]" value="exhibition" />전시회
						<input type="checkbox" name="ROUTE[]" value="voucher" />바우처
						<input type="checkbox" name="ROUTE[]" value="center" />조리원소개
						<input type="checkbox" name="ROUTE[]" value="etc" />기타<br/>
						<input type=text name="ROUTE_VALUE" placeholder="기타 접근, 추천 내용" /><br/>
					</td>
				</tr>
				<tr>
					<td align=center>추천경로선택</td>
					<td>
						<input type="checkbox" name="ROUTE[]" value="recommend" />지인추천
						<input type="checkbox" name="ROUTE[]" value="search" />검색
						<input type="checkbox" name="ROUTE[]" value="blog" />블로그<br/>
						<input type=text name="RECOMMEND" placeholder="추천인의 이름, id, 휴대번호" />
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
						<input type=text name="HOSPITAL"/>
					</td>
				</tr>
				<tr>
					<td align=center>출산예정일</td>
					<td>
						<input type=text name="DUEDATE_BIRTH" placeholder="YYYYMMDD" />
					</td>
				</tr>
				<tr>
					<td align=center>수술예정일</td>
					<td>
						<input type=text name="DUEDATE_OPERATION" placeholder="YYYYMMDD" />
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
						<input type="radio" name="BABY_TYPE_EXPECTED" value="single" checked /> 단태아 <br/>
						<input type="radio" name="BABY_TYPE_EXPECTED" value="twin" /> 쌍둥이 <br/>
						<input type="radio" name="BABY_TYPE_EXPECTED" value="more" /> 세쌍둥이이상 
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
						<input type=text name="CARECENTER_WEEK"/> 주<br/>
						<input type="radio" name="CARECENTER" value="false" checked onclick="setFields_ByName('CARECENTER_WEEK', '')" /> 아니오 
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
						<input type=text name="BORN_DATE" placeholder="YYYYMMDD" />
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
						<input type="radio" name="BORN_TYPE" value="natural" checked /> 자연분만 <br/>
						<input type="radio" name="BORN_TYPE" value="operation" /> 제왕절개 <br/>
					</td>
				</tr>
				<tr>
					<td align=center>관리사서비스장소</td>
					<td>
						<input type="radio" name="CARE_PLACE" value="home" checked /> 자택 <br/>
						<input type="radio" name="CARE_PLACE" value="home_mother" /> 친정 <br/>
						<input type="radio" name="CARE_PLACE" value="home_father" /> 시댁 <br/>
					</td>
				</tr>
				<tr><td colspan="2">■서비스/계약정보</td></tr>
				<tr>
					<td align=center>상담</td>
					<td align=center>
						상담내용<br/>
						<textarea name="COUNSEL_CONTENT" rows="4" cols="50" id="counsel"></textarea><br/>
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
						<select name="VOUCHER">
							<option value="none" selected>소득유형선택</option>
							<option value="svc1">바우처1</option>
							<option value="svc2">바우처2</option>
						</select><br/>
						바우처 서비스 기간<br/>
						<input type="radio" name="VOUCHER_PERIOD" value="5" checked /> 5일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="10" /> 10일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="15" /> 15일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="20" /> 20일 <br/>
						<input type="radio" name="VOUCHER_PERIOD" value="25" /> 25일 <br/>
					</td>
				</tr>
				<tr>
					<td align=center>서비스/연장 정보 입력</td>
					<td>
						<table>
							<tr>
								<td>서비스기간</td>
								<td>
									<select name="SERVICE_NAME">
										<option value="none" selected>서비스선택</option>
										<option value="svc1">서비스1</option>
										<option value="svc2">서비스2</option>
									</select>
									<select name="SERVICE_PERIOD">
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
								<td><input type=text name="START_DATE" placeholder="YYYYMMDD" /></td>
							</tr>
							<tr>
								<td>서비스형태</td>
								<td>
									<input type="radio" name="SERVICE_TYPE" value="move5" onclick="hideMixed()" /> 입주 5일 <br/>
									<input type="radio" name="SERVICE_TYPE" value="move6" onclick="hideMixed()" /> 입주 6일 <br/>
									<input type="radio" name="SERVICE_TYPE" value="commute5" onclick="hideMixed()" /> 출퇴근 5일 <br/>
									<input type="radio" name="SERVICE_TYPE" value="commute6" onclick="hideMixed()" /> 출퇴근 6일 <br/>
									<input type="radio" name="SERVICE_TYPE" value="mixed" checked onclick="showMixed()" /> 입주+출퇴근 <br/>
									<div id="mymixed">
										입주시작: <input type=text name='MOVE_DATE' placeholder='YYYYMMDD' /><br/>
										<input type="radio" name="SERVICE_MIXED_MOVE" value="mixed_move5" checked /> 입주 5일 <br/>
										<input type="radio" name="SERVICE_MIXED_MOVE" value="mixed_move6" /> 입주 6일 <br/>

										출근시작: <input type=text name='COMMUTE_DATE' placeholder='YYYYMMDD' /> <br/>
										<input type="radio" name="SERVICE_MIXED_COMMUTE" value="commute5" checked /> 출퇴근 5일 <br/>
										<input type="radio" name="SERVICE_MIXED_COMMUTE" value="commute6" /> 출퇴근 6일 <br/>
									</div>
								</td>
							</tr>
							<tr>
								<td>관리사 배정</td>
								<td>
									<button onclick="openHelperSelectionWindow();" type="button">관리사목록</button>
									<input type=text name='HELPER_NAME' id='HelperName' placeholder='관리사를 지정해 주세요.' readonly />
								</td>
							</tr>
							<tr>
								<td>추가금 케어형태</td>
								<td>
									<input type=checkbox onclick="checkCare('family')" id='check_family' name="care[]" value="family" /> 가족케어 <br/>
									<input type=checkbox onclick="checkCare('school')" id='check_school' name="care[]" value="school" /> 취학아동 <br/>
									<input type=checkbox onclick="checkCare('additional')" id='check_additional' name="care[]" value="additional" /> 추가가족 <br/>
									<input type=checkbox onclick="checkCare('twin')" id='check_twin' name="care[]" value="twin" /> 쌍둥이케어 <br/>
								</td>
							</tr>
							<tr>
								<td>초과 시간</td>
								<td>
									<input type="date" id='OVERTIME_DATE' />
									<input type=text id='OVERTIME_HOURS' placeholder='초과시간(1시간단위)' /> 시간
									<button onclick="addOverTime()" type="button">+</button><br/>
									<p id="overtimes" align=center>초과근무 없음
									</p>
									<br/>
								</td>
							</tr>
							<tr>
								<td>기본 서비스</td>
								<td>
									전신마사지<br/>
									횟수선택 : <input type=text id='MASSAGE_COUNT' /> 회 <br/>
									신 청 일 : <input type="date" id='MASSAGE_DATE' /> <br/>
									<br/>
									방문간호사<br/>
									횟수선택 : <input type=text id='NURSE_COUNT' /> 회 <br/>
									신 청 일 : <input type="date" id='NURSE_DATE' /> <br/>
									<br/>
									소독서비스<br/>
									횟수선택 : <input type=text id='DISINFECT_COUNT' /> 회 <br/>
									신 청 일 : <input type="date" id='DISINFECT_DATE' /> <br/>
									<br/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align=center>기타 정보</td>
					<td>
						<table>
							<tr>
								<td>반려동물</td>
								<td align=center>
									고양이 <input type=text id='PET_CAT_COUNT' /><br/>
									새 <input type=text id='PET_BIRD_COUNT' /><br/>
									개 <input type=text id='PET_DOG_COUNT' /><br/>
									기타 <input type=text id='PET_ETC_COUNT' /><br/>
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
									입금 : <input type="date" id='DELIVERY_COST_PAY_DATE' /> <br/>
									비용 : <input type=text id='DELIVERY_COST' /> 원 <br/>
									대여비<br/>
									입금 : <input type="date" id='RENTAL_COST_PAY_DATE' /> <br/>
									비용 : <input type=text id='RENTAL_COST' /> 원 <br/>
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
									<input type="radio" name="CASHBILL" value="yes" checked /> 예 <br/>
									<input type="radio" name="CASHBILL" value="no" /> 아니오 <br/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<button id=save type="button" >저장</button><br/>
	</body>
</html>
