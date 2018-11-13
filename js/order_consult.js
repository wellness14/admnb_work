
function getStatus(item) {
    return "<span class='label label-warning'>" + item.STATUS + "</span>";
}

function getTR(item) {
    var html = '';
/*
    ret += "<tr class='even pointer'>";
    ret += "<td>";
    ret += "<a href='order_consult_detail.html' class='btn btn-primary btn-xs btn-mb-0'>보기</a>";
    ret += "</td>";
    ret += "<td></td>";
    ret += "<td>최정은</td>";
    ret += "<td>전화옴</td>";
    ret += "<td>조미경</td>";
    ret += "<td>2018.03.26</td>";
    ret += "<td>[2018.06.26] 문자발송 완료 고객확인 대기중</td>";
    ret += "<td>관악</td>";
    ret += "<td>조리원이용 (4주이상) 출퇴근 6일</td>";
    ret += "</tr>";
*/
    html += "<tr class='even pointer'>";
    html += "<td><a href='order_consult_detail.jsp?INDEX=" + item.INDEX + "' class='btn btn-primary btn-xs btn-mb-0'>보기</a></td>";
    html += "<td>" + getStatus(item) + "</td>";
    html += "<td>" + item.NAME + "</td>";
    html += "<td>" + item.ROUTES + "</td>";
    html += "<td>" + item.MEMBER + "</td>";
    //html += "<td>" + index + "</td>";
    //html += "<td><img src='images/picture.jpg' alt='선물이미지' class='gift-img'></td>";
    html += "<td>" + item.EXPECTED_DATE + "</td>";
    html += "<td>" + item.PROGRESS + "</td>";
    html += "<td>" + item.BRANCH + "</td>";
    html += "<td>" + item.SERVICES + "</td>";
    /*
    if (item.EXPOSED) {
        html += "<td><span class='label title label-success'>" + "노출중" + "</span></td>";
    } else {
        html += "<td><span class='label title label-warning'>" + "사용되지 않음" + "</span></td>";
    }
    html += "<td><a class='btn btn-primary btn-xs' onclick='editGift(" + item.INDEX + ")'>수정</a></td>";
    html += "<td><a class='btn btn-danger btn-xs' onclick='deleteGift(" + item.INDEX + ")'>삭제</a></td>";
    html += "<td class='last'>" + getTargetDisplay(item.TARGETS) + "</td>";
    */
    html += "</tr>";

    return html;
}

function search() {
    document.getElementById("waitingWheel").style.display = "block";
    document.getElementById("finalView").style.display = "none";
    loadConsultList();
}

function loadConsultList(step) {

    var val = '';
    val += 'LIST' + '&';
    val += 'STEP=' + step + '&';
    $.post("_api_customer.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        //console.log(data);
        var html = '';
        var index = 1;
        if (data.DONE != 1) {
            alert('목록을 가져오지 못했습니다.');
            return;
        }
        for (i in data.RESULT) {
            var item = data.RESULT[i];
            html += getTR(item);

            index += 1;
        }
        $("#consultList").html(html);
        //console.log(html);
        document.getElementById("waitingWheel").style.display = "none";
        document.getElementById("finalView").style.display = "block";
    });
}
