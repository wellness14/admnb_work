
function getEncodedString(id) {
	return base64.encode($("#" + id).val());
}

function getDecodedString(encoded) {
	return base64.decode(encoded.replace(/\s/g, "+"));
}
/*
$(document).ready(function() {
	if (_service == '') {
		init();
		_service = document.getElementById("org").innerHTML;
		document.getElementById("org").innerHTML = '';
	}
	$("#save").click(function() {
		//alert("ready");
		submitMe();
	});
});


function b64EncodeUnicode(str) {
	return btoa(str);
    // first we use encodeURIComponent to get percent-encoded UTF-8,
    // then we convert the percent encodings into raw bytes which
    // can be fed into btoa.
    return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g,
        function toSolidBytes(match, p1) {
            return String.fromCharCode('0x' + p1);
    }));
}

function b64DecodeUnicode(str) {
	return atob(str);
    // Going backwards: from bytestream, to percent-encoding, to original string.
    return decodeURIComponent(atob(str).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
}
*/

function getCurrentDateString() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd = '0'+dd
	} 

	if(mm<10) {
	    mm = '0'+mm
	} 

	today = yyyy + '-' + mm + '-' + dd;
	return today;
}