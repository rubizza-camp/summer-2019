$(document).ready(function () {
  showPlace();
  $('#createReviewButton').click(createReview);
});

function showHtml(html){
  const blockComment = $('#commentBlock');
  blockComment.empty();
  blockComment.append(html);
} 

function showPlace(){
  $.ajax({
    type: 'GET',
    url: document.URL + '/review',
    success: function(html) {
       showHtml(html)
    }});
}

function createReview(e){
  e.preventDefault();
  $.ajax({
    type: 'POST',
    url: document.URL + '/review',
    data: $('#form').serialize(),
    success: function(html){ 
      showHtml(html)
  }});
}
