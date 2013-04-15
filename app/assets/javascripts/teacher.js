// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {
  $('#add-star').click(function(e) {
    e.preventDefault();
    console.log("add star working");       

    // get request
    $.get(("/stars/new/"), function(html){
    $("body").append(html);
    $('#star-modal').modal('toggle');
    
    });
  });
  
  $.each($('.teacher-dashboard .student'), function(){
    var self = this;
    $(self).find('.remove').click(function(e) {
      console.log("remove click works");
      e.preventDefault();
      $(self).remove();
      // get request
      var groupId = $(self).first().data("group-id");
      var userId = $(self).first().data("user-id");

      $.get("/users/remove_from_group/?user=" + userId + "&group=" + groupId, function (html) {
        console.log(html);
        alert("Student successfully removed from class.");
      });

    });

    $(self).find('#make-teacher').click(function(e) {
      console.log("make-teacher click works");
      e.preventDefault();
      $(self).remove();

      var userId = $(self).first().data("user-id");

      $.get("/users/make_teacher/?user=" + userId, function(html){
      console.log(html);
      alert("Teacher created.");
      });

    });

  });

});




