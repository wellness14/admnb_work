

var _curRentalIndex = -1;

function clearRental() {
    $("#rental_input_type").html("대여품 등록");
	_curRentalIndex = -1;
    $("#RENTAL_NAME").val('');
    $("#RENTAL_NUM").val(0);
    $("#RENTAL_PRICE").val(0);
    $("#RENTAL_QUANTITY").val(0);
    $("#RENTAL_DESCRIPTION").val('');
    $("input[name='"+"RENTAL_EXPOSED"+"'][value="+1+"]").prop('checked', true);
}

function fillRental(item) {
    $("#RENTAL_NUM").val(item.NUMBER);
    $("#RENTAL_NAME").val(item.NAME);
    $("#RENTAL_PRICE").val(item.PRICE);
    $("#RENTAL_QUANTITY").val(item.QUANTITY);
    $("#RENTAL_DESCRIPTION").val(item.DESCRIPTION);
    if (item.EXPOSED) {
        $("input[name='"+"RENTAL_EXPOSED"+"'][value='"+"1"+"']").prop('checked', true);
    } else {
        $("input[name='"+"RENTAL_EXPOSED"+"'][value='"+"0"+"']").prop('checked', true);                
    }
}

function saveRental() {
    var name = $("#RENTAL_NAME").val();
    var price = $("#RENTAL_PRICE").val();
    var num = $("#RENTAL_NUM").val();
    var quantity = $("#RENTAL_QUANTITY").val();
    var desc = $("#RENTAL_DESCRIPTION").val();
    var exposed = $('input[name=RENTAL_EXPOSED]:checked').val();
    if (exposed == '1') {
        //alert('사용중');
        exposed = 1;
    } else if (exposed == '0') {
        //alert('사용안함');
        exposed = 0;
    }
    var val = '';
    val += 'SET' + '&';
    val += 'INDEX=' + _curRentalIndex + '&';
    val += 'NUMBER=' + num + '&';
    val += 'PRICE=' + price + '&';
    val += 'QUANTITY=' + quantity + '&';
    val += "NAME=" + name + '&';
    val += "DESCRIPTION=" + desc + '&';
    val += 'EXPOSED=' + exposed + '&';
    //alert(val);
    //return;
    $.post("_api_rental.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
    	clearRental();
    	loadRentalList();
    });
}

function editRental(index) {
    // TODO: set label with "xxx 수정";
    //alert('EDIT:' + index);
    _curRentalIndex = index;
    $("#rental_input_type").html("대여품 정보 수정");
    var val = '';
    val += 'GET' + '&';
    val += 'INDEX=' + _curRentalIndex + '&';
    //alert(val);
    //return;
    $.post("_api_rental.jsp", val)
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
        fillRental(data.RESULT);
    });
}

function deleteRental(index) {
    //alert('DELETE:' + index);
    //$("#rental_input_type").html("단말기 정보 수정");
    var val = '';
    val += 'DELETE' + '&';
    val += 'INDEX=' + index + '&';
    $.post("_api_rental.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        loadRentalList();
    });
}

function loadRentalList() {
    var val = '';
    val += 'LIST' + '&';
    $.post("_api_rental.jsp", val)
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
            html += "<li>";
            html += "<span class='image'><img src='images/picture.jpg' alt='img' /></span>";
            html += "<dl class='message'>";

        	html += "<dt>등록일 : </dt>";
        	html += "<dd>" + item.REGISTERED + "</dd>";
	        html += "<dt>노출상태 : </dt>";
            if (item.EXPOSED) {
                html += "<dd><span class='label title label-success'>" + "노출중" + "</span></dd>";
            } else {
                html += "<dd><span class='label title label-warning'>" + "노출되지 않음" + "</span></dd>";
            }
	        html += "<dt>상품명 : </dt>";
	        html += "<dd>" + item.NAME + "</dd>";
	        html += "<dt>매입가 : </dt>";
	        html += "<dd>" + item.PRICE + "원</dd>";
	        html += "<dt>수량 : </dt>";
	        html += "<dd>" + item.QUANTITY + "개</dd>";
	        html += "<dt>제품설명 : </dt>";
	        html += "<dd>" + item.DESCRIPTION + "</dd>";
	        html += "<dt></dt>";
	        html += "<dd>";
	        html += "    <hr>";
	        html += "    <a class='btn btn-default btn-sm' onclick='editRental(" + item.INDEX + ")'>수정</a>";
	        html += "    <a class='btn btn-default btn-sm' onclick='deleteRental(" + item.INDEX + ")'>삭제</a>";
	        html += "</dd>";
            html += "</dl>";
            html += "</li>";

            index += 1;
        }
        $("#rentalList").html(html);
    });
}
