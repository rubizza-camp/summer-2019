/*jshint esversion: 6 */

$(document).ready(function () {
    let button = $("#closeLogin");
    button.on("click", function (ev) {
        ev.preventDefault();
        let email = $("#email_login").val();
        let password = $("#password_login").val();
        $.ajax({
            url: '/login',
            type: "POST",
            data: {email: email, password: password},
            success: function (message) {
                if (message !== 'Done') {
                    alert(message);
                } else {
                    location.reload();
                }
            }
        });
    });
});