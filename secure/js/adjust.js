// JavaScript Document
 function fadeAlert() {
    $("#myAlert").addClass("out");
}

window.setTimeout(function () {
    fadeAlert();
}, 3000);
function hideAlert() {
    $("#myAlert").addClass("hide");
}

window.setTimeout(function () {
    hideAlert();
}, 4000);