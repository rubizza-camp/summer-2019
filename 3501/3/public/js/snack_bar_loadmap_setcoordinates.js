var marker;
var infoWindow;
var latitudeEl, longitudeEl;
latitudeEl = document.getElementById('validationServerLatitude');
longitudeEl = document.getElementById('validationServerLongitude');
function initMap() {
var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: {lat: 59.325, lng: 18.070}
});
latitudeEl.oninput = ()=> { onLatitudeElChanged(map); };
longitudeEl.oninput = ()=> { onLongitudeElChanged(map); };


marker = new google.maps.Marker({
    map: map,
    draggable: true,
    animation: google.maps.Animation.DROP,
    position: {lat: 59.327, lng: 18.067}
});
marker.addListener('click', toggleBounce);
marker.addListener('drag', onMargerMoved);

infoWindow = new google.maps.InfoWindow();
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
    var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
    };

    infoWindow.open(map);
    map.setCenter(pos);
    marker.setPosition(pos);
    latitudeEl.value = marker.getPosition().lat();
    longitudeEl.value = marker.getPosition().lng();
    }, function() {
    handleLocationError(true, infoWindow, map.getCenter());
    });
} else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
}
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
infoWindow.setPosition(pos);
infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
infoWindow.open(map);
}

function toggleBounce() {
if (marker.getAnimation() !== null) {
    marker.setAnimation(null);
} else {
    marker.setAnimation(google.maps.Animation.BOUNCE);
}
}

function onMargerMoved()  {
    latitudeEl.value = marker.getPosition().lat();
    longitudeEl.value = marker.getPosition().lng();
}

function onLatitudeElChanged(map) {
    marker.setPosition(new google.maps.LatLng(latitudeEl.value,marker.getPosition().lng()));
    map.setCenter(marker.getPosition());
}
function onLongitudeElChanged(map) {
    marker.setPosition(new google.maps.LatLng(marker.getPosition().lat(),longitudeEl.value));
    map.setCenter(marker.getPosition());
}