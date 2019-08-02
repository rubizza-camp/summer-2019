/*jshint esversion: 6 */

$(document).ready(function () {
    let button = $("#singOn");
    button.on("click", function (ev) {
        ev.preventDefault();
        let usrname = $("#usrname").val();
        let email = $("#email_registration").val();
        let password = $("#password_registration").val();
        let password_again = $("#confirm_password").val();
        $.ajax({
            dataType: 'json',
            url: '/users',
            type: "POST",
            data: {usrname: usrname, email: email, password: password, password_again: password_again},
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
