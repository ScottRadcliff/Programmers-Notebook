// Notes.js
// TODO: find a way to extract calling document.getElementById on note_title
// multiple times

//  Tired of typing document.getElementbyId
var elem = function(id) {return document.getElementById(id)};

var note_content = elem("note_content");

//var note_title = elem("note_title"); 
var note_title = elem("task"); 

var note_form_submit = elem("note_form_submit");
var search = elem("note_search");
// var place_holder_text = "I Just Do ...";
var note = {};

$(document).ready(function() {

  // if(note_title) {
  //   setEllipsis();
  //   createHandlerForNoteTitle();
  // }

  if(note_content) {
    note_content.value = place_holder_text;
   
    note_content.addEventListener("focus", function() {
      if(this.value == place_holder_text) {
        this.value = "";
        this.style.color = "#000000";
        this.style.fontStyle = "normal";
      }
    });  

    note_content.addEventListener("blur", function() { note.content = this.value });
  } 

  if(note_form_submit) note_form_submit.addEventListener("click", sendForm);
  if(search) search.addEventListener("keyup", getResults);
});

// Send the data to the server from the note object
// Builds and displays a notice if successful, and resets
// the fields to prepare for another entry
var sendForm = function(){
  note.title = note_title.value;
  $(".alert-message").remove();
  $.ajax({
    url: "/notes/create",
    data: {title: note.title, content: note.content},
    type: "POST",
    success: function(data) {
      if(data === "true") {
        var messageBox = $("<div class='alert-message success'>Code added!</div>");
        $("h1").before(messageBox);
        note_content.value = place_holder_text;
        // setEllipsis();
        //createHandlerForNoteTitle();
      }
    }
  })
};

// Creates a span element that holds the title
// that was created, and inserts it into the DOM
// where the original element was
// var createTitle = function(e) {
//   var element = document.createElement("span");
//   element.setAttribute('id', 'note_title');
//   element.innerHTML = this.value;
//   note.title = this.value;
//   this.parentNode.replaceChild(element, this);
// };


// var createHandlerForNoteTitle function() {
//   note_title.addEventListener("click", function() {
//       var title_text_box = "<input type='text' id='note_title_text_box' />";
//       if (this.value !== '...') {
//         $(this).replaceWith(title_text_box);
//         var $note_title_text_box = $("#note_title_text_box");
//         $note_title_text_box.focus();
//         document.getElementById("note_title_text_box").addEventListener("blur", createTitle);
//       };
//     });
// };

var setEllipsis = function() {
  note_title.innerHTML = "...";
}

// Grabs matching titles from the server
var getResults = function() {
  var value = this.value;
  if(value !== "") {
      $.getJSON("/notes/search/" + value, function(data) {
    var result = $("#result");
    result.html("");
    $.each(data, function() {
      result.append("<h1>" + this.title + "</h1>" + this.content );
    });
    if (data.length > 0) result.append("<a href='/notes/all'>View All</a>");
  });
  }

};


