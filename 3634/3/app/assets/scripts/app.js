/* jshint ignore: start */
var blocks = document.querySelectorAll(".block"),
    modalRestaurants = document.querySelector("#modal_restaurants"),
    restaurantClose = document.querySelector(".restaurant__close"),
    comment = document.querySelector("#comment");

    for (var i = 0; i < blocks.length; i++) {
      blocks[i].onmouseover = function() {
        var reedmore = this.querySelector(".reedmore");
        reedmore.classList.remove("modal--disable");
        reedmore.classList.add("modal--enable");
        reedmore.style.width = this.offsetWidth - 4 + "px";
        reedmore.style.height = this.offsetHeight - 4 + "px";
      };
      blocks[i].onmouseout = function() {
        var reedmore = this.querySelector(".reedmore");
        reedmore.classList.remove("modal--enable");
        reedmore.classList.add("modal--disable");
      };
      blocks[i].addEventListener('click', function() {
        var restaurantName = document.querySelector(".restaurant__name h1"),
            restaurantDescription = document.querySelector(".restaurant__description p"),
            restaurantCoordinates = document.querySelector(".restaurant__coordinates p");

        modalRestaurants.classList.add("modal--enable");
        restaurantName.innerText = this.querySelector(".block__name h3").innerText;
        restaurantDescription.innerText = this.querySelector(".block__hidden p").innerText;
        var restaurantId = this.querySelector(".block__hidden span").innerText;
        restaurantCoordinates.innerText = this.querySelector(".block__coorinates p").innerText;
        var xhr = new XMLHttpRequest();
        xhr.open('GET', "/" + restaurantId, true);
        xhr.onload = function() {
          var commentsData = JSON.parse(xhr.responseText);
          renderHtml(commentsData);
        };
        xhr.send();
    });}

    function renderHtml(data) {
      var htmlUser = "",
          htmlComment = "",
          htmlMark = "";

      for (i = 0; i < data.length; i++) {
        var div = document.createElement("div"),
            paragraphOne = document.createElement("p"),
            paragraphTwo = document.createElement("p"),
            paragraphThree = document.createElement("p");
            div.classList.add("comment");
        comment.appendChild(div);

        htmlUser = "User: " + data[i].user_name;
        htmlComment = "Comment: " + data[i].annotation;
        htmlMark = "Mark: " + data[i].mark;

        paragraphOne.appendChild(document.createTextNode(htmlUser));
        paragraphTwo.appendChild(document.createTextNode(htmlComment));
        paragraphThree.appendChild(document.createTextNode(htmlMark));

        div.insertAdjacentHTML('beforeend', paragraphOne.outerHTML);
        div.insertAdjacentHTML('beforeend', paragraphTwo.outerHTML);
        div.insertAdjacentHTML('beforeend', paragraphThree.outerHTML);
      }
    }

    restaurantClose.addEventListener('click', function() {
      modalRestaurants.classList.remove("modal--enable");
      var comments = document.querySelectorAll(".comment");
      for (i = 0; i < comments.length; i++) {
        comments[i].parentNode.removeChild(comments[i]);
      }
    });
