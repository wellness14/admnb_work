

var _curGiftIndex = -1;

function clearGift() {
    var boxes;
    $("#gift_input_type").html("선물 등록");
    _curGiftIndex = -1;
    $("#GIFT_NAME").val('');
    $("#GIFT_NUM").val(0);
    $("#GIFT_PRICE").val(0);
    $("#GIFT_QUANTITY").val(0);
    $("#GIFT_DESCRIPTION").val('');
    $("input[name='"+"GIFT_EXPOSED"+"'][value="+1+"]").prop('checked', true);

    boxes = document.getElementsByName("TARGETS");
    for (i in boxes) {
        boxes[i].checked = false;
    }
}

function fillGift(item) {
    $("#GIFT_NUM").val(item.NUMBER);
    $("#GIFT_NAME").val(item.NAME);
    $("#GIFT_PRICE").val(item.PRICE);
    $("#GIFT_QUANTITY").val(item.QUANTITY);
    $("#GIFT_DESCRIPTION").val(item.DESCRIPTION);
    fillCheckBoxes(item.TARGETS);
    if (item.EXPOSED) {
        $("input[name='"+"GIFT_EXPOSED"+"'][value='"+"1"+"']").prop('checked', true);
    } else {
        $("input[name='"+"GIFT_EXPOSED"+"'][value='"+"0"+"']").prop('checked', true);                
    }
}

function saveGift() {
    var name = $("#GIFT_NAME").val();
    var price = $("#GIFT_PRICE").val();
    var num = $("#GIFT_NUM").val();
    var quantity = $("#GIFT_QUANTITY").val();
    var desc = $("#GIFT_DESCRIPTION").val();
    var exposed = $('input[name=GIFT_EXPOSED]:checked').val();
    var targets = getTargetString();
    if (exposed == '1') {
        //alert('사용중');
        exposed = 1;
    } else if (exposed == '0') {
        //alert('사용안함');
        exposed = 0;
    }
    //alert('[' + targets + ']');
    var val = '';
    val += 'SET' + '&';
    val += 'INDEX=' + _curGiftIndex + '&';
    val += 'NUMBER=' + num + '&';
    val += 'PRICE=' + price + '&';
    val += 'QUANTITY=' + quantity + '&';
    val += "NAME=" + name + '&';
    val += "DESCRIPTION=" + desc + '&';
    val += 'EXPOSED=' + exposed + '&';
    val += 'TARGETS=' + targets + '&';
    //alert(val);
    //return;
    $.post("_api_gift.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        clearGift();
        loadGiftList();
    });
}

function editGift(index) {
    // TODO: set label with "xxx 수정";
    //alert('EDIT:' + index);
    _curGiftIndex = index;
    $("#gift_input_type").html("선물 정보 수정");
    var val = '';
    val += 'GET' + '&';
    val += 'INDEX=' + _curGiftIndex + '&';
    //alert(val);
    //return;
    $.post("_api_gift.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        document.getElementById("error").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        var html = '';
        var index = 1;
        if (data.DONE != 1) {
            alert('정보를 가져오지 못했습니다.');
            return;
        }
        fillGift(data.RESULT);
    });
}

function deleteGift(index) {
    //alert('DELETE:' + index);
    //$("#gift_input_type").html("단말기 정보 수정");
    var val = '';
    val += 'DELETE' + '&';
    val += 'INDEX=' + index + '&';
    $.post("_api_gift.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        loadGiftList();
    });
}

function loadGiftList() {
    var val = '';
    val += 'LIST' + '&';
    $.post("_api_gift.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        var html = '';
        var index = 1;
        if (data.DONE != 1) {
            alert('목록을 가져오지 못했습니다.');
            return;
        }
        for (i in data.RESULT) {
            var item = data.RESULT[i];
            html += "<tr class='even pointer'>";
            html += "<td>" + index + "</td>";
            html += "<td>" + item.NUMBER + "</td>";
            html += "<td><img src='images/picture.jpg' alt='선물이미지' class='gift-img'></td>";
            html += "<td>" + item.NAME + "</td>";
            html += "<td>" + item.PRICE + "</td>";
            html += "<td>" + item.QUANTITY + "</td>";
            html += "<td>" + item.REGISTERED + "</td>";
            if (item.EXPOSED) {
                html += "<td><span class='label title label-success'>" + "노출중" + "</span></td>";
            } else {
                html += "<td><span class='label title label-warning'>" + "사용되지 않음" + "</span></td>";
            }
            html += "<td><a class='btn btn-primary btn-xs' onclick='editGift(" + item.INDEX + ")'>수정</a></td>";
            html += "<td><a class='btn btn-danger btn-xs' onclick='deleteGift(" + item.INDEX + ")'>삭제</a></td>";
            html += "<td class='last'>" + getTargetDisplay(item.TARGETS) + "</td>";
            html += "</tr>";

            index += 1;
        }
        $("#giftList").html(html);
    });
}

function getTargetString() {
    var boxes;
    var targets = '';

    boxes = document.getElementsByName("TARGETS");
    for (i in boxes) {
        if (boxes[i].checked) {
            targets += boxes[i].value + ' ';
        }
    }

    return targets;
}

function checkBox(val) {
    var boxes;

    if ((val == null) || (val.length == 0)) {
        return;
    }

    boxes = document.getElementsByName("TARGETS");
    for (i in boxes) {
        if (boxes[i].value == val) {
            boxes[i].checked = true;
            break;
        }
    }
}

function fillCheckBoxes(str) {
    var targets;

    targets = str.split(' ');
    for (i in targets) {
        checkBox(targets[i]);
        //alert(targets[i]);
        //console.log(targets[i]);
    }
}

var _displays = [
    ['BASIC', '베이직'],
    ['PREMIUM', '프리미엄'],
    ['PRIVATE', '프라이빗'],
    ['INTEN', '집중관리'],
    ['35', '35세이상산모'],
    ['HEAVY', '과체중'],
    ['TWIN', '쌍둥이'],
    ['MULTI', '다둥이'],
    ['WORKING', '워킹맘'],
    ['HOME', '산후조리원 내집에'],
    ['INHOUSE', '입주'],
    ['COMMUTE', '출퇴근'],
    ['MIXED_W2W2', '입주 2주 + 출퇴근 2주'],
    ['W1', '1주'],
    ['W2', '2주'],
    ['W3', '3주'],
    ['W4', '4주'],
];

/*
[['BASIC_COMMUTE_W1', '_____'],
['BASIC_COMMUTE_W2', '_____'],
['BASIC_COMMUTE_W3', '_____'],
['BASIC_COMMUTE_W4', '_____'],
['PREMIUM_COMMUTE_W1', '_____'],
['PREMIUM_COMMUTE_W2', '_____'],
['PREMIUM_COMMUTE_W3', '_____'],
['PREMIUM_COMMUTE_W4', '_____'],
['PREMIUM_INHOUSE_W1', '_____'],
['PREMIUM_INHOUSE_W2', '_____'],
['PREMIUM_INHOUSE_W3', '_____'],
['PREMIUM_INHOUSE_W4', '_____'],
['VIP_COMMUTE_W1', '_____'],
['VIP_COMMUTE_W2', '_____'],
['VIP_COMMUTE_W3', '_____'],
['VIP_COMMUTE_W4', '_____'],
['VIP_INHOUSE_W1', '_____'],
['VIP_INHOUSE_W2', '_____'],
['VIP_INHOUSE_W3', '_____'],
['VIP_INHOUSE_W4', '_____'],
['PRIVATE_COMMUTE_W2', '_____'],
['PRIVATE_COMMUTE_W3', '_____'],
['PRIVATE_COMMUTE_W4', '_____'],
['PRIVATE_INHOUSE_W2', '_____'],
['PRIVATE_INHOUSE_W3', '_____'],
['PRIVATE_INHOUSE_W4', '_____'],
['TWIN_COMMUTE_W4', '_____'],
['TWIN_MIXED_W2W2', '_____'],
['TWIN_INHOUSE_W4', '_____'],
['MULTI_COMMUTE_W4', '_____'],
['MULTI_MIXED_W2W2', '_____'],
['MULTI_INHOUSE_W4', '_____'],
['INTEN_WORKING_COMMUTE_W2W2', '_____'],
['INTEN_HOME_MIXED_W2W2', '_____'],
['INTEN_35_COMMUTE_W4', '_____'],
['INTEN_HEAVY_COMMUTE_W4', '_____'],
];
*/

function getDisp(val) {
    //var ret = '';

    for (i in _displays) {
        val = val.replace(_displays[i][0], _displays[i][1]);
    }
    val = val.replace(/_/g, ' ');

    return val;
}

function getTargetDisplay(str) {
    var disp = '';
    var targets;

    targets = str.split(' ');
    for (i in targets) {
        if ((targets[i] == null) || (targets[i].length == 0)) {
            continue;
        }
        disp += getDisp(targets[i]) + "<br>";
        //alert(targets[i]);
        //console.log(targets[i]);
    }

    return disp;
}
