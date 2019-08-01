/*jshint esversion: 6 */

$(document).ready(function () {
    let button = $("#closeRegistration");
    button.on("click", function (ev) {
        ev.preventDefault();
        let usrname = $("#usrname").val();
        let email = $("#email_registration").val();
        let password = $("#password_registration").val();
        let password_again = $("#password_again").val();
        $.ajax({
            url: '/users',
            type: "POST",
            data: {usrname: usrname, email: email, password: password, password_again: password_again},
            success: function (message) {
                if (message === 'Done') {
                    location.reload();
                } else {
                    alert(message);
                }
            }
        });
    });
});