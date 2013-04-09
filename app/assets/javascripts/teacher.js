// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/




$(document).ready(function() {
  
  $.each($('.teacher-dashboard .student'), function(){
    console.log("jquery has awoken");
    var self = this;
    console.log(this);
    $(self).find('.remove').click(function(e) {
      console.log("remove click works");
      e.preventDefault();
      $(self).remove();
      // get request
      var groupId = $(self).first().data("group-id");
      var userId = $(self).first().data("user-id");
      $.get(("/users/remove_from_group/?user=" + userId + "&group=" + groupId), function(html){
      console.log(html);
      });
    });
  });

});