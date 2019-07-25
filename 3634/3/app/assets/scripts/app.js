function makeGetResponse(name) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', 'phones.json', false);
  xhr.send();
}
