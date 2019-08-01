document.addEventListener("DOMContentLoaded", function() {

    document.getElementById("openSidebar").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = "block";
    });

    document.getElementById("closeSidebar").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = "none";
    });

    document.getElementById("openRegistration").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = "none";
        document.getElementById("registration").style.display = "block";
    });


    document.getElementById("exitRegistration").addEventListener("click", function() {
        document.getElementById("registration").style.display = "none";
    });

    document.getElementById("exitLogin").addEventListener("click", function() {
        document.getElementById("login").style.display = "none";
    });

    document.getElementById("openLogin").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = "none";
        document.getElementById("login").style.display = "block";
    });


    document.getElementById("openRegistrationFromLogin").addEventListener("click", function() {
        document.getElementById("login").style.display = "none";
        document.getElementById("registration").style.display = "block";
    });
});