document.addEventListener('DOMContentLoaded', function() {

    document.getElementById("openSideBar").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = 'block';
    });

    document.getElementById("closeSideBar").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = 'none';
    });

    document.getElementById("openRegistration").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = "none";
        document.getElementById('registration').style.display = 'block';
    });

    document.getElementById("closeRegistration").addEventListener("click", function() {
        document.getElementById("registration").style.display = 'none';
    });

    document.getElementById("openLogin").addEventListener("click", function() {
        document.getElementById("mySidebar").style.display = "none";
        document.getElementById('login').style.display = 'block';
    });

    document.getElementById("closeLogin").addEventListener("click", function() {
        document.getElementById("login").style.display = 'none';
    });

    document.getElementById("closeError").addEventListener("click", function() {
        document.getElementById("error").style.display = 'none';
    });
});