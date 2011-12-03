// Notes.js

$(document).ready(function() {
 // When the title span is clicked
 // replace it with a textbox
 //
 // when the textbox loses focus
 // change it back to text
 //
 // when the textarea gains focus
 // remove the default text and
 // allow text to be entered
 //
 // When the form gets submitted
 // send the new record via ajax
  var $note_content = $("#note_content");
  var place_holder_text = "I Just Do ...";
  $note_content.val(place_holder_text);
  $note_content.bind('click', function(){
    if(this.value == place_holder_text) {
      this.value = "";
      this.style.color = "#000000";
      this.style.fontStyle = "normal";
    }
  });
  
});
