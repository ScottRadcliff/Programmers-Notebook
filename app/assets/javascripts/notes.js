// Notes.js

$(document).ready(function() {
  var note_content = document.getElementById("note_content");
  var note_title = document.getElementById("note_title"); 
  var place_holder_text = "I Just Do ...";

  if(note_title) {
    note_title.innerHTML = "...";
    
    note_title.addEventListener("click", function() {
      var title_text_box = "<input type='text' id='note_title_text_box' />";
      if (this.value !== '...') {
        $(this).replaceWith(title_text_box);
        var $note_title_text_box = $("#note_title_text_box");
        $note_title_text_box.focus();
        document.getElementById("note_title_text_box").addEventListener("blur", createTitle);
      };
    });
  
  }

  if(note_content) {
    note_content.value = place_holder_text;
   
    note_content.addEventListener("focus", function() {
      if(this.value == place_holder_text) {
        this.value = "";
        this.style.color = "#000000";
        this.style.fontStyle = "normal";
      }
    });  
  } 

  document.getElementById("note_form_submit").addEventListener("click", sendForm);

});

var sendForm = function(){console.log(note_title.value)};

 var createTitle = function() {
  var element = document.createElement("span");
  var id = document.createAttribute('id');
  id.nodeValue = "note_title";
  element.setAttributeNode(id);
  element.innerHTML = this.value;
  this.parentNode.replaceChild(element, this);
 };
