function w3_open_registration() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById('registration').style.display = 'block';
}

function w3_open_sing_in() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById('login').style.display = 'block';
}

function w3_open(id) {
    document.getElementById(id).style.display = 'block';
}

function w3_close(id) {
    document.getElementById(id).style.display = 'none';
}
