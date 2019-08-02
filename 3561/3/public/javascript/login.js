/*jshint esversion: 6 */

$(document).ready(function () {
    let button = $("#singIn");
    button.on("click", function (ev) {
        ev.preventDefault();
        let email = $("#email_login").val();
        let password = $("#password_login").val();
        $.ajax({
            dataType: 'json',
            url: '/login',
            type: "POST",
            data: {email: email, password: password},
            success: function (response) {
                if (response.status) {
                    location.reload();
                } else {
                    alert(response.message);
                }
            }
        });
    });
});
