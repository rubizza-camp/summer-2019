// jshint esversion: 6

var map;
function initMap() {
var cairo = {
    lat: parseFloat(document.getElementById('map').getAttribute('lat')),
    lng: parseFloat(document.getElementById('map').getAttribute('lng'))
};

var map = new google.maps.Map(document.getElementById('map'), {
    scaleControl: true,
    center: cairo,
    zoom: 16
});

var infowindow = new google.maps.InfoWindow();
infowindow.setContent('<b>'+document.getElementById('map').getAttribute('snack_name')+'</b>');

var marker = new google.maps.Marker({map: map, position: cairo});
marker.addListener('click', function() {
    infowindow.open(map, marker);
});
}