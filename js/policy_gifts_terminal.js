
var _curTerminalIndex = -1;

function clearTerminal() {
    $("#terminal_input_type").html("단말기 등록");
	_curTerminalIndex = -1;
    $("#TERMINAL_NUM").val(0);
    $("input[name='"+"TERMINAL_AVAILABLE"+"'][value='"+"AVAILABLE"+"']").prop('checked', true);
}

function fillTerminal(item) {
    $("#TERMINAL_NUM").val(item.NUMBER);
    if (item.AVAILABLE) {
        $("input[name='"+"TERMINAL_AVAILABLE"+"'][value='"+"AVAILABLE"+"']").prop('checked', true);
    } else {
        $("input[name='"+"TERMINAL_AVAILABLE"+"'][value='"+"INUSE"+"']").prop('checked', true);                
    }
}

function saveTerminal() {
    var num = $("#TERMINAL_NUM").val();
    var avail = $('input[name=TERMINAL_AVAILABLE]:checked').val();
    if (avail == 'INUSE') {
        //alert('사용중');
        avail = 0;
    } else if (avail == 'AVAILABLE') {
        //alert('사용안함');
        avail = 1;
    }
    var val = '';
    val += 'SET' + '&';
    val += 'INDEX=' + _curTerminalIndex + '&';
    val += 'NUMBER=' + num + '&';
    val += 'AVAILABLE=' + avail + '&';
    //alert(val);
    //return;
    $.post("_api_terminal.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
    	clearTerminal();
    	loadTerminalList();
    });
}

function editTerminal(index) {
    // TODO: set label with "xxx 수정";
    //alert('EDIT:' + index);
    _curTerminalIndex = index;
    $("#terminal_input_type").html("단말기 정보 수정");
    var val = '';
    val += 'GET' + '&';
    val += 'INDEX=' + _curTerminalIndex + '&';
    $.post("_api_terminal.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        var html = '';
        var index = 1;
        if (data.DONE != 1) {
            alert('정보를 가져오지 못했습니다.');
            return;
        }
        fillTerminal(data.RESULT);
    });
}

function deleteTerminal(index) {
    //alert('DELETE:' + index);
    //$("#terminal_input_type").html("단말기 정보 수정");
    var val = '';
    val += 'DELETE' + '&';
    val += 'INDEX=' + index + '&';
    $.post("_api_terminal.jsp", val)
    .fail(function(response) {
        alert('Error: ' + response.responseText);
        //document.getElementById("org").innerHTML = response.responseText;
    })
    .done(function(data) {
        console.log(data);
        loadTerminalList();
    });
}

function loadTerminalList() {
    var val = '';
    val += 'LIST' + '&';
    $.post("_api_terminal.jsp", val)
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
            html += "<tr class='even pointer'>";
            html += "<td>" + index + "</td>";
            html += "<td>" + data.RESULT[i].NUMBER + "</td>";
            if (data.RESULT[i].AVAILABLE) {
                html += "<td><span class='label title label-success'>" + "사용가능" + "</span></td>";
            } else {
                html += "<td><span class='label title label-warning'>" + "사용중" + "</span></td>";
            }
            html += "<td><a class='btn btn-default btn-xs' onclick='editTerminal(" + data.RESULT[i].INDEX + ")'>수정</a></td>";
            html += "<td><a class='btn btn-danger btn-xs' onclick='deleteTerminal(" + data.RESULT[i].INDEX + ")'>삭제</a></td>";
            html += "</tr>";

            index += 1;
        }
        $("#terminalList").html(html);
    });
}
